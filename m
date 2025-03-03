Return-Path: <linux-kernel+bounces-540860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0CA4B5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508413A7ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0E13C82E;
	Mon,  3 Mar 2025 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcLG3yEU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440212B9A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966912; cv=none; b=d6cgrNR5aeTnPDJBvHVmFmlE1YB3aJBSfCTJaJgaW8DzX2goBc3MZeODv6XUPNyGHHdNjdAd9IPT4ortcMw7kLBTSeP3k/6GVTGaWjX7L3Xzk173akfx25k7lvu6txzkOYf1XlJh+zUSLvLCJ+8aKWnrp6l3lrSGZxGxcQhn2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966912; c=relaxed/simple;
	bh=IF1XD6iHCWXh0nQwj7pwPszvVvIyjWgq5tPQr9uvN8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etO+NPAUpajHzlnXfgPF91jyb1tzjn1ce7d1kNjok72BYUzmWqQLQqiAYEFnHQwnsuF9Qbbq/4QrEvCcpRykkBcC5hQGaUMG2kL7IkJ3aw4elOdqiSHNAUsKhkarW9LVGJRHoTxR1laOFfOkQBOwFs1bqOaNymecvfjGL+3GO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcLG3yEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740966909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhgK+qmDRl4rHSWqmJa5YbcWbITFtEJIZPZRBB24C/k=;
	b=hcLG3yEUKrot1u5VE1y7WUtLImStS9kMjlH16aUhn5vA4mAXIblbw58QjXJNlhJtx/kyEa
	kwzBvQmf+FAVFutk/BSuQFjUIPbKTI1z4yElerYbBN5ytq8WyUgOGhjR03jBDz7YVU5N4+
	B+J1BGCU66/FeUWwm0NN2xvs5qoAj7g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-HbBO5pdTN9OhB7UIpFZq_Q-1; Sun,
 02 Mar 2025 20:55:06 -0500
X-MC-Unique: HbBO5pdTN9OhB7UIpFZq_Q-1
X-Mimecast-MFC-AGG-ID: HbBO5pdTN9OhB7UIpFZq_Q_1740966905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBA1D1944D01;
	Mon,  3 Mar 2025 01:55:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9390B180087B;
	Mon,  3 Mar 2025 01:55:03 +0000 (UTC)
Date: Mon, 3 Mar 2025 09:54:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z8UL8pW84S46Ca/K@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/20/25 at 05:54pm, Jiri Bohac wrote:
......
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..ea4d53435515 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -987,6 +987,20 @@
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> +	crashkernel=size[KMG],cma
> +			[KNL, X86] Reserve additional crash kernel memory from CMA.
> +			This reservation is usable by the first system's userspace,
> +			so this should not be used if dumping of userspace
> +			memory is intended. A standard crashkernel reservation,
> +			as described above, is still needed to hold the crash
> +			kernel and initrd.
> +			This option increases the risk of a kdump failure: DMA
> +			transfers configured by the first kernel may end up
> +			corrupting the second kernel's memory. This reservation
> +			method is intended for systems that can't afford to
> +			sacrifice enough memory for standard crashkernel
> +			reservation and where less reliable kdump is preferrable 
There's trailing whitespace at the end of above line, checkpatch should
be run to check it.

> +			to no kdump at all.
>  
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 


