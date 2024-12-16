Return-Path: <linux-kernel+bounces-447107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C79F2D63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF9E164D26
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F691C54AA;
	Mon, 16 Dec 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygvp4KX2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA201264
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342738; cv=none; b=msQupjHjr1mpRG9SeNP7Fkm+0GrD1rxkaWmwmTEqjJGQBWqsWhZmWMRdQPd9hlpojfZixZHzET93wSrqT8OGoGAZ0Sq3wn5l9BHjZ0iKQsZH+C6ZmkgdKSS7epRCReGZynZmDIveV9I50KGCb7/fCtUCf4hTo9+4YzipF2uAzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342738; c=relaxed/simple;
	bh=6M7zgRahWi9BaMVg3H/Es7ufS+weRIaW8/ZvlIZSMJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt3ctyhyY5Wk9MjJkvuJ2xnVMbH0tq6F07JfJcTiMhNQcptXu4S/V7JdVN2dJsU89BV0SollkcMxEinMsF7U33qJz1KcXDV1/jqzhZj7JMml5SJT/lu83DaDs1Fn3FflcKgz/oxmB8rJK5wPM7iQPx4gU70EO4412oill66F8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ygvp4KX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734342734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmSjD0XkZmqY+fXEbPDuflTWR35GHKak2Nr2YDS7T5o=;
	b=Ygvp4KX2ciF93pj8dm8MIq+l0KEYwW1IRI501KcXUAalgQr+ztUtVdvOeKkUF8tuJPc7Gu
	PaKHilg0iy9NP3GBOO8uVFhxiXV+HdormD6fL2H0GsTho5EL0RH6gD2s18l0B6Pnn8+2SP
	HFUEUTY+AnJP8J+Ohylusf17PRKznc4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-SofcZVHxP5qemYnniY8iQw-1; Mon, 16 Dec 2024 04:52:11 -0500
X-MC-Unique: SofcZVHxP5qemYnniY8iQw-1
X-Mimecast-MFC-AGG-ID: SofcZVHxP5qemYnniY8iQw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4678f97242fso126296561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342730; x=1734947530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmSjD0XkZmqY+fXEbPDuflTWR35GHKak2Nr2YDS7T5o=;
        b=npqBq6CDRhDiOYkMlsqtw5TQgHzN6fyRow/kNzhQQpDNhvmwky6msRVHG+7spWc5wX
         AXlkuwKGXFmM2uUZ2eFoSxQqDq2NgLT9+CwNk5tnUquQEb2SeDdlE/wSwUS4MGBHINqH
         9p3If9IUFj3MFMeNxLkE3wjFxszAoaMbu+hwMIWX37074NZa1mVGIiO6ci/og+iBxOto
         SBaj80KmKFIIP6ZSSioTFc9jYj9Lsr29qJMCoAYxhKLt2MdPvF5pbRk7WQr6vqIcgRbp
         8y2dlip+ApvJnRsPuc2C1Cpgo2Ya8TOvBCRAcYpwbBBpkx9bHjVCDyc8pcxYERYKnjB6
         xu7g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6/O1ICurOACYeJCyZixnCF6IbeoiygLk2yNSAsED6Ksd1z0DKYwrkt/fbAF/QIUght9MHr/9+UjRIzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrVLDEN+IvFtPna6hhk8belVECtOUbjmarUGgaGgjvRSaVRDb
	04+TKQ2AlGeGstMSMgLjBhwqgbOyKzVB9oUr2oqBkVA6cBC2Al/drU5ZtkVu+pWiQE/4gnI5qAt
	/9y76VSmT4zklyHgq9BymO/MtM/bYVZRsW6m/vWhqHI/7rLG4TCtDqZ25PSYrgg==
X-Gm-Gg: ASbGncuLlPKbcFski6AYN9eDCk9Rd1xwC8mdrf+nf4dRujN2VJDb8XHeQSEVGxKGdjK
	kzTuzHFBJScqMuU94TDTllqXiwulSFGnf5z787MJ20E3UCAEfPU4BZ2kNuRIjxeAWx4NB/noDG1
	gCJi3LZvId/JyQzK3ZzmPyxns4ICwpIMqtfdfh7wgJWUzlmzDHIRnOZtRmMIjmvYm+QxOMoeRtH
	d55KR32czMES05OVmA2jrOEhJK/jbS7SZC1flJIbih6nteO0EXBq+K1sPEdhYz4Ntofd94MaVU8
	ohJJK7aEKhDb0eYnz+sF1rSCSbWYTtpj
X-Received: by 2002:ac8:5a51:0:b0:467:6a0c:9c76 with SMTP id d75a77b69052e-467a5823693mr191620791cf.47.1734342730605;
        Mon, 16 Dec 2024 01:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdYI6GT63sqttTS043tIllhpF3MOhkRaFOGgKJjJ/HmG+lPxr2aPmilTBr1aod4rP2ULthwQ==
X-Received: by 2002:ac8:5a51:0:b0:467:6a0c:9c76 with SMTP id d75a77b69052e-467a5823693mr191620541cf.47.1734342730240;
        Mon, 16 Dec 2024 01:52:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c6fd59sm26096621cf.11.2024.12.16.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:52:09 -0800 (PST)
Date: Mon, 16 Dec 2024 10:52:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <itatpahlgullmutoxdwybzcpxvg3xklyeqnq7wjztr36xeuon6@4owugtmenlaj>
References: <20241211104704.208354-2-pstanner@redhat.com>
 <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
 <08e922383c726a72574ea24eb2db520d40de4c47.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08e922383c726a72574ea24eb2db520d40de4c47.camel@redhat.com>

On Fri, Dec 13, 2024 at 07:39:46PM +0100, Philipp Stanner wrote:
>On Fri, 2024-12-13 at 16:10 +0100, Stefano Garzarella wrote:
>> On Wed, Dec 11, 2024 at 11:47:05AM +0100, Philipp Stanner wrote:
>> > The PCI functions
>> >
>> > 	pcim_iomap_regions()
>> > 	pcim_iounmap_regions()
>> > 	pcim_iomap_table()
>> >
>> > have been deprecated by the PCI subsystem.
>> >
>> > Replace these functions with their successors pcim_iomap_region()
>> > and
>> > pcim_iounmap_region().
>> >
>> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> > ---
>> > Changes in v3:
>> >  - Move __iomem *io declaration into the loop. (Stefano)
>> >
>> > Changes in v2:
>> >  - Fix build warning because of dead variable.
>> >  - Make "bars_found" a boolean, since only true or false are
>> > relevant.
>> > ---
>> > drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++--------------
>> > ---
>> > 1 file changed, 26 insertions(+), 30 deletions(-)
>> >
>> > diff --git a/drivers/vdpa/solidrun/snet_main.c
>> > b/drivers/vdpa/solidrun/snet_main.c
>> > index c8b74980dbd1..643e335f00f1 100644
>> > --- a/drivers/vdpa/solidrun/snet_main.c
>> > +++ b/drivers/vdpa/solidrun/snet_main.c
>> > @@ -556,59 +556,58 @@ static const struct vdpa_config_ops
>> > snet_config_ops = {
>> > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
>> > *psnet)
>> > {
>> > 	char *name;
>> > -	int ret, i, mask = 0;
>> > +	unsigned short i;
>> > +	bool bars_found = false;
>> > +
>> > +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
>> > bars", pci_name(pdev));
>> > +	if (!name)
>> > +		return -ENOMEM;
>> > +
>> > 	/* We don't know which BAR will be used to communicate..
>> > 	 * We will map every bar with len > 0.
>> > 	 *
>> > 	 * Later, we will discover the BAR and unmap all other
>> > BARs.
>> > 	 */
>> > 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> > -		if (pci_resource_len(pdev, i))
>> > -			mask |= (1 << i);
>> > +		void __iomem *io;
>> > +
>> > +		if (pci_resource_len(pdev, i) == 0)
>> > +			continue;
>> > +
>> > +		io = pcim_iomap_region(pdev, i, name);
>> > +		if (IS_ERR(io)) {
>> > +			SNET_ERR(pdev, "Failed to request and map
>> > PCI BARs\n");
>> > +			return PTR_ERR(io);
>> > +		}
>> > +
>> > +		psnet->bars[i] = io;
>> > +		bars_found = true;
>> > 	}
>> >
>> > 	/* No BAR can be used.. */
>> > -	if (!mask) {
>> > +	if (!bars_found) {
>> > 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
>> > 		return -ENODEV;
>> > 	}
>> >
>> > -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
>> > bars", pci_name(pdev));
>> > -	if (!name)
>> > -		return -ENOMEM;
>> > -
>> > -	ret = pcim_iomap_regions(pdev, mask, name);
>> > -	if (ret) {
>> > -		SNET_ERR(pdev, "Failed to request and map PCI
>> > BARs\n");
>> > -		return ret;
>> > -	}
>> > -
>> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> > -		if (mask & (1 << i))
>> > -			psnet->bars[i] =
>> > pcim_iomap_table(pdev)[i];
>> > -	}
>> > -
>> > 	return 0;
>> > }
>> >
>> > static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
>> > *snet)
>> > {
>> > 	char *name;
>> > -	int ret;
>> >
>> > 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-
>> > bars", pci_name(pdev));
>> > 	if (!name)
>> > 		return -ENOMEM;
>> >
>> > 	/* Request and map BAR */
>> > -	ret = pcim_iomap_regions(pdev, BIT(snet->psnet-
>> > >cfg.vf_bar), name);
>> > -	if (ret) {
>> > +	snet->bar = pcim_iomap_region(pdev, snet->psnet-
>> > >cfg.vf_bar, name);
>>
>> Could we also use a temporary variable here as we did in
>> psnet_open_pf_bar()?
>
>We can. Some maintainers want it so, others so
>
>>
>> It seems to me that no one uses `!snet->bar` for now to check whether
>> they are configured or not, but maybe better to prevent, WDYT?
>
>So it seems that this driver is a bit special as its probe() function
>can take different paths running into one of the respective request
>functions.
>Doesn't look to me as if pcim_iomap_region() could fail and the driver
>would still load?

yeah, it's not super clear to me how physical and virtual functions are
managed.

>
>Anyways, better safe than sorry. If you think it's safer I can modify
>it so those pointers are valid or NULL.

Just because this way we leave the behavior the same as before this 
change, but I don't have a strong opinion, actually it's the error path 
of the probe, so maybe the device is completely deallocated.

Thanks,
Stefano

>
>
>P.
>
>>
>> Thanks,
>> Stefano
>>
>> > +	if (IS_ERR(snet->bar)) {
>> > 		SNET_ERR(pdev, "Failed to request and map PCI BAR
>> > for a VF\n");
>> > -		return ret;
>> > +		return PTR_ERR(snet->bar);
>> > 	}
>> >
>> > -	snet->bar = pcim_iomap_table(pdev)[snet->psnet-
>> > >cfg.vf_bar];
>> > -
>> > 	return 0;
>> > }
>> >
>> > @@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet
>> > *psnet, u32 off)
>> >
>> > static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
>> > psnet *psnet)
>> > {
>> > -	int i, mask = 0;
>> > +	unsigned short i;
>> >
>> > 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> > 		if (psnet->bars[i] && i != psnet->barno)
>> > -			mask |= (1 << i);
>> > +			pcim_iounmap_region(pdev, i);
>> > 	}
>> > -
>> > -	if (mask)
>> > -		pcim_iounmap_regions(pdev, mask);
>> > }
>> >
>> > /* Read SNET config from PCI BAR */
>> > --
>> > 2.47.1
>> >
>>
>


