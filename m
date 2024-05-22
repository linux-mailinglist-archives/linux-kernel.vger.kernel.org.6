Return-Path: <linux-kernel+bounces-186468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1868CC48F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D781F213CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CD13D8AA;
	Wed, 22 May 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLD0jpc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0900210EC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393402; cv=none; b=hClv6DH1463HrQ7ZQJucAWwqnougBrx3rHC8K6Pa/SPV2Ua+TGLyT80RDrjPQJWKzFnXPHojHmsGzCo5VwRcamK/GKxWmgSUPqPVlgO5g+n1BH9frdvGi5xb+xExfsDDKPQiQ7egvA9wcMnf75x2bKe93896NgELHcF51pFq+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393402; c=relaxed/simple;
	bh=v8cAZZ8J7bzfnYp5o6idecynXR7i2En6YomK8I+ZL6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcLeRf5Oy4q3RkKLzmKJNEu9nFj3uWxjgfj7noQbuPLye5kNvbrlDi9QmCVnH8TYi9Zvra7Z3tPsIwt3I//Q2tpG7xnvxWQr+5EqN2AA/tkq4mw4EvPIQYIn9MN3/+7wSalQAkzCa8hTW1PAoPpx0xeT/Ju129ssWOfnUIElN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLD0jpc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D94C2BD11;
	Wed, 22 May 2024 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716393401;
	bh=v8cAZZ8J7bzfnYp5o6idecynXR7i2En6YomK8I+ZL6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLD0jpc6QQLiSCCbEJeS+c7bGv0AsYyKFZKKbtw7cQcYIknJL1fcWPR1nAQOaha9z
	 oj90/comP+41/pQqz2/wj5CvnrFTF5uQC0UNTxkUZAqgW0q1cR8Z3MY+IsA9aLbbmZ
	 cvUOEP/gBVlbuVuPlIQR4qqx0iTloDgBs79fnz/MdQ/bHuc85GvC8LeRWH+uzqIQzo
	 dhJStFVW+HggCYESP7xGiH2i+5p1grYKCuMq8W7YuzuWiyzt8FfJV6s2KRNJJW6btu
	 ddOK2mZSKdYQi2qF79qYmKlBuSMycmJo7poUF62W6nXV9XOVNp/jO5K7RkEgUEehL6
	 6CPfgG9iDIigg==
Date: Wed, 22 May 2024 09:56:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522154212.643572-2-jmeneghi@redhat.com>

On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	/* iopolicy changes reset the counters and clear the mpath by design */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);

Can you me understand why this is a desirable feature? Unless you
quiesce everything at some point, you'll always have more unaccounted
requests on whichever path has higher latency. That sounds like it
defeats the goals of this io policy.

> @@ -1061,6 +1066,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>  {
>  	return false;
>  }
> +static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */

You can remove this stub function since the only caller resides in a
CONFIG_NVME_MULTIPATH file.

