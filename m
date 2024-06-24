Return-Path: <linux-kernel+bounces-226882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36E914537
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1901C20FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662E4D108;
	Mon, 24 Jun 2024 08:46:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA52907
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218794; cv=none; b=qhR/ioC2ggxbj2cW22QE87Su6mIvzNIuotOqBAwd+jlATksmUVSzV/c+mLn3u7qrO1yO3hnKjRzAGc2pE9eQgwF3h1DgRL8ykWQbY199OH4CviRGgc5G120JkAEgawg54Umt69ruDxaQCkb3DEHV1Kmsgy9RLxkxnYa1hhhm0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218794; c=relaxed/simple;
	bh=Dahm1or6x3YT+dfAXikcLeG3FadNltDMjYUUSTDXDco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvhrGRM+3T8xXOLdd2+Ndoc8QOV2OGIucBGhxaXhPx5XIWC355Dy474Bx5a4zUt96j3DSi2Dvzjoza2j5jkM1v2bSpl7wu7g1Ef/I/C/qT7hYSeTHu6Z37fQ26tQb4Eib4YJfkABgtjiVyY73b0rwRHJx/RRxm1JstQhEAOKrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D8A268B05; Mon, 24 Jun 2024 10:46:28 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:46:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240624084627.GA20032@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de> <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 01:54:29PM -0400, John Meneghini wrote:
>>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>>> +		int iopolicy)
>>> +{
>>> +	struct nvme_ctrl *ctrl;
>>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>> +
>>> +	if (old_iopolicy == iopolicy)
>>> +		return;
>>> +
>>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>>
>> What is the atomicy model here?  There doesn't seem to be any
>> global lock protecting it?  Maybe move it into the
>> nvme_subsystems_lock critical section?
>
> Good question.  I didn't write this code. Yes, I agree this looks racy. 
> Updates to the subsys->iopolicy variable are not atomic. They don't need to 
> be. The process of changing the iopolicy doesn't need to be synchronized 
> and each CPU's cache will be updated lazily. This was done to avoid the 
> expense of adding (another) atomic read the io path.

Looks like all sysfs ->store calls for the same attribute are protected
by of->mutex in kernfs_fop_write_iter and we should actually be fine
here.  Sorry for the noise.

>> 	pr_notice("%s: changing iopolicy from %s to %s\n",
>> 		subsys->subnqn,
>> 		nvme_iopolicy_names[old_iopolicy],
>> 		nvme_iopolicy_names[iopolicy]);
>
> How about:
>
> pr_notice("Changed iopolicy from %s to %s for subsysnqn %s\n",
>                 nvme_iopolicy_names[old_iopolicy],
>                 nvme_iopolicy_names[iopolicy],
>                 subsys->subnqn);

Having the identification as the prefixe seems easier to parse
and grep for. 


