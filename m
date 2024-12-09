Return-Path: <linux-kernel+bounces-437690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D99E972B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F190D16427D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200F1A238A;
	Mon,  9 Dec 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feyrXe9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89539233157
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751078; cv=none; b=DwvxD7FoPxFlBsXgPY435jmnyBYyR/RmQnLwr0JKN+l/TWxxn9sbq3l86R+TLSO1nvizCE6Nj/p+WAmK1cy9KUYhXq/hMdBW9DvhY3njeYRCx2H4f3/R7Bpj9nSsizOU+odCy1lE0tsLY/Q3ggiRi4TtzRsCXOafB78u32+GMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751078; c=relaxed/simple;
	bh=1H2yYR4fWimIzimli7rKNJTjfr7H1SoQ5tzNP52S2i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS9ZTSHnYBXrkmc/JAMmRwGQ0qh6XXUbsgECTLNUNDJRddKaUNk76kd9k9xPH4FaV2zpsvkuAV4TtVCXHDNQEaLBwV+vQzYopJIYzgDGwsOegt6ooVAjEf1LOXAK0h9OTNgD/gNsLZh2w+HYGJYsbF7ixCDH9YET7/kCgYZVv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feyrXe9p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733751074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJJrk6X28C8CR+DZtpKKo6pW56zGxdkQs6FbM6/Q0HU=;
	b=feyrXe9pWI79da6VniXLVW1J6N6sx2tCwco3N8Q/DWl+5ezhl3Kez6JtJAtMEIBORhmkg5
	ISyKSI36ECayJzUwpKxCQ/A6tt/QFZM9gOttFruMvKauatJOye7Sns10OF0iTSRUrz1wX9
	s7JjREurSurFn8aYlhgZi8ei4RGZ54Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-bL89ue2FNIGgjDPSWeXCJg-1; Mon, 09 Dec 2024 08:31:13 -0500
X-MC-Unique: bL89ue2FNIGgjDPSWeXCJg-1
X-Mimecast-MFC-AGG-ID: bL89ue2FNIGgjDPSWeXCJg
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6c6ff1f2cso320336885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751073; x=1734355873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJJrk6X28C8CR+DZtpKKo6pW56zGxdkQs6FbM6/Q0HU=;
        b=iwh9f/AKQDJ2jRT7E+8rnXXJBpK+U7p0EdAiqgQmarMFXAav9eipkYkXEroHtwWtQ4
         aRWyqeOY+T5/GRydqeLIXPBrMjP/0BA0y20POh11gqq0mLo/Uyt5eU34gEyzNs9fh80p
         tSrW49egVLjY7gOoHK2rOpL3zXKilyEtn11S9dLWg2rzSLl0jBeMo2bmFMGlwa/HQf/U
         DpBe/8vUdX8HPvgvjHTebx6DdMpncTjsBtUCdH2DKsOfyboASAFa6z7Ag/KG9tOS3IGP
         5aFyoR/XZE5bytv+lX8jIvCR08KCCCYZ+YIN21wGPLjMQv9Y4aolxDl4CmEwDqxyT5C+
         V9lg==
X-Forwarded-Encrypted: i=1; AJvYcCW40qAG8RIgZUIUwME3RvoOu6j+Gqqchwc01706jTsCX4YzVQFmJMIV8SEKmKKLLd+0H5nP8vvKeih1D58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6Cub0eDYHyxjQrKiu7TW9XO5S7VCst0pav1EFib9dxyifrGX
	yrJ8B5hvn9vbmGSg1vodEdN/+ryWUUTUpu7HQc1rXxh/2qWBvWg1BsNZ/EIocln6bAFmISt8AYK
	ipQgoPH0RaPQczbqUVWOqu7L+pBfj9hvAlLboTVw+K6MYIIg7LaSLgYOp4vzw8w==
X-Gm-Gg: ASbGncs/qFBCWPnetW2RxK9MRWeBvYVVE4De96qfsRUyozF0tEaKzdkDWbO0KxdW6Ck
	bIOwi1lGw7EjWTvWTCmzUbViDAKrt1Ytn8SpUHxNsSfILTkzMWKKk5WHPINQvFmL6UnBa65qPg9
	DlgkpKMt7nMe3838bvJ4kOlgCz3Ixextp7ap+oEO916/4xBUri72ugtV5iypaBVWc+vVSzTQFUJ
	DyxOIqGs2Tf2cFK1zaIjtNvJwys9dcF4ndXYYFfQkOhaiv+YnrVoPFuobLJI5C1ziMenvWw4YQp
	GVKEeeJL4CJT6HRVFeoEJWcC7A==
X-Received: by 2002:a05:620a:8907:b0:7b6:cedf:1b48 with SMTP id af79cd13be357-7b6cedf1cf5mr1047519985a.3.1733751072827;
        Mon, 09 Dec 2024 05:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHOffgDQ8/bjuiYZrcLXualPEwUTQlzYmQoIldXxXgZHOWsGH5VE9kSfFc+AkR+6USYKF4jQ==
X-Received: by 2002:a05:620a:8907:b0:7b6:cedf:1b48 with SMTP id af79cd13be357-7b6cedf1cf5mr1047514985a.3.1733751072389;
        Mon, 09 Dec 2024 05:31:12 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d447cba1sm113579385a.116.2024.12.09.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:31:11 -0800 (PST)
Date: Mon, 9 Dec 2024 14:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
References: <20241209115118.125940-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241209115118.125940-2-pstanner@redhat.com>

On Mon, Dec 09, 2024 at 12:51:18PM +0100, Philipp Stanner wrote:
>The PCI functions
>
>	pcim_iomap_regions()
>	pcim_iounmap_regions()
>	pcim_iomap_table()
>
>have been deprecated by the PCI subsystem.
>
>Replace these functions with their successors pcim_iomap_region() and
>pcim_iounmap_region().
>
>Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>---
>Changes in v2:
>  - Fix build warning because of dead variable.
>  - Make "bars_found" a boolean, since only true or false are relevant.
>---
> drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
> 1 file changed, 25 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index c8b74980dbd1..1b9841698a1a 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
> 	char *name;
>-	int ret, i, mask = 0;
>+	unsigned short i;
>+	bool bars_found = false;
>+	void __iomem *io;

I would suggest to move this declaration (*io) inside the for loop where 
it's used.

>+
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	/* We don't know which BAR will be used to communicate..
> 	 * We will map every bar with len > 0.
> 	 *
> 	 * Later, we will discover the BAR and unmap all other BARs.
> 	 */
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>-		if (pci_resource_len(pdev, i))
>-			mask |= (1 << i);
>+		if (pci_resource_len(pdev, i) == 0)
>+			continue;
>+
>+		io = pcim_iomap_region(pdev, i, name);
>+		if (IS_ERR(io)) {
>+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>+			return PTR_ERR(io);

Now instead of calling pcim_iomap_regions() once, we need to call 
pcim_iomap_region() multiple times.
If one of these fails, should we unmap the ones we mapped before?

Thanks,
Stefano

>+		}
>+
>+		psnet->bars[i] = io;
>+		bars_found = true;
> 	}
>
> 	/* No BAR can be used.. */
>-	if (!mask) {
>+	if (!bars_found) {
> 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> 		return -ENODEV;
> 	}
>
>-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>-	if (!name)
>-		return -ENOMEM;
>-
>-	ret = pcim_iomap_regions(pdev, mask, name);
>-	if (ret) {
>-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>-		return ret;
>-	}
>-
>-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>-		if (mask & (1 << i))
>-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
>-	}
>-
> 	return 0;
> }
>
> static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> {
> 	char *name;
>-	int ret;
>
> 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
> 	if (!name)
> 		return -ENOMEM;
>
> 	/* Request and map BAR */
>-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>-	if (ret) {
>+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
>+	if (IS_ERR(snet->bar)) {
> 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
>-		return ret;
>+		return PTR_ERR(snet->bar);
> 	}
>
>-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
>-
> 	return 0;
> }
>
>@@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
>
> static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
> {
>-	int i, mask = 0;
>+	unsigned short i;
>
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> 		if (psnet->bars[i] && i != psnet->barno)
>-			mask |= (1 << i);
>+			pcim_iounmap_region(pdev, i);
> 	}
>-
>-	if (mask)
>-		pcim_iounmap_regions(pdev, mask);
> }
>
> /* Read SNET config from PCI BAR */
>-- 
>2.47.1
>


