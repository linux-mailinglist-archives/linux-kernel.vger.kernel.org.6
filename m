Return-Path: <linux-kernel+bounces-445058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCDE9F107E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9941686FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF91E231A;
	Fri, 13 Dec 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJFtKA1K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E961E102E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102637; cv=none; b=jZ1ZlMRjswBGxkzGa4jnYmwoI09NLVXTpM7hS5qDvYr9UAQnvFc5rmAL+0iF3wio1wBDb5qbpAPlHkdezIc1EFwhvVNfLqq7KvkTLlvOzuRPJVAqmDQENPuPPqs1/qrTJg3ZrRZXBFqVvNKeQ4B4O2Rg5A64xgyTsG7soqmxnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102637; c=relaxed/simple;
	bh=xSgxkdchTJyFCqqvoi9ov9RsXW8Hs0dq0bbwd76PbfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f48HEJliEhqvOVbh/h56OXLh2znO/BNlwWSDIwGvfVZtkXZXTOzC9earvIAIyo3iRkaYYGvZPFJPzTXoxtRlmr39ndpkwOYlwqVuj57/yCLRiVb4UmWNawDc2xJpm96qxTXZwEcuqDlvJL7yfsyRa2oDrvt6p1AFZ53MqyqY72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJFtKA1K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BEyRorFLWfoHHa/oesuugW/TqvR2Li1O4P72mmMm/o=;
	b=WJFtKA1KOrQC3EjWl+Azfdb5uTP8/5x0EnVoFMGOy4UKYHpClszH2qm32hCDaJfQaQMLZd
	E2bgT0uOHOK3Tg8a++/ajIwFUysQ3MvTGCGdhE3JfwTJUixyOstWWOhIiVrFwCPooZdTcS
	StIy1cRpAXJbT0H5oSAyj8t/iJa51T0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-o48Jw5ZMMs-r4AfHn1RlIA-1; Fri, 13 Dec 2024 10:10:32 -0500
X-MC-Unique: o48Jw5ZMMs-r4AfHn1RlIA-1
X-Mimecast-MFC-AGG-ID: o48Jw5ZMMs-r4AfHn1RlIA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4678b42cbfeso38238761cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102632; x=1734707432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BEyRorFLWfoHHa/oesuugW/TqvR2Li1O4P72mmMm/o=;
        b=WskfKHw2NjoJ/ZCMKAoVmkO0qU5mWLgmwXpgZ+cy/RF8lAJkSDFeabZspMqAzoTqI6
         FUOXHfOd2kNb5r+Tv/28S7S534GIoCPno/6Ig8fE9IYQ+5xavOReq0bcYK6aPcsBUy2y
         kOA2vS/wVUcMCOnKvri9vgQbab/XQwbazCLjHMQ92s8rRAcRlzFscRRv+2MgxiwSYj/g
         jRAC6MfjnJTjWafM8qW3lcXNW3rodGTohYEVJelI2Ueh8Xib7Ot6drf/35mpnyhQ99Pc
         0xrnTfJZr2R6ULGBmn7YIIsAqT0/EhS5SMloEhnDLSqKDHyQsMjByRmboD3f7Egt9Xd1
         ZFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXXwaRWjY0BaTd5iuouOtnIPNoYk0YSoidvwbS8AG6vG8eMgr1+m07T9DaGCRnCUhE2kpPnlB6DVx0qa68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qa06s0AwrjbWCsvnrrwC7PnFjwlobjPU/cQGWT8nTMj6Q4Ut
	Tsjw6VSkbaIsZjcdPyfGiyav3/npO1Vw26TdmFNWo/FA1XTO5mb22cljctaZfjrxzOAv6HlvpOV
	kAOeXpsOblTAzF3FoYtus2F6/wh6IhoOl9bbMvrj2ylK1xzU9Zn2lv3zQ5QcdbA==
X-Gm-Gg: ASbGncth7kwY612vJ9VHglu2VUAdlWKJlpo1YLQb3TM32AfttSbWiu6Mk4lEM9RCvpw
	GA+MmuA+xjvIuuKkMsRSVjz20IEKs1o55PyIFTLCPOPufy5VviPmR78q90xq+qTyUez1d5Cj0fS
	GYsGqi/cph1w7f7NNx8EJe6jtmFNkWBh8x2v9xEzWwHLO2j2SWfuymU+NCyHmNvyFdafpkzmlK6
	Xhkqj/HMZY5XagY7LKVN0Y54H/UBNURpmAYnDn72o3OA16eXn+97lY9MK4YVDJ8mJ3Xdy0m7OqQ
	kVLFj+wiKRYa6tZkezzMD+mrIVcTGYIC
X-Received: by 2002:ac8:580d:0:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-467a57187fdmr52846201cf.1.1734102632390;
        Fri, 13 Dec 2024 07:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAC+FS+51MMmMCXEiGRCIxWdIv4Ie7rXV1jDHWY/BSX2ZUme69goy8f4oh8q1WbfMuFRI6jw==
X-Received: by 2002:ac8:580d:0:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-467a57187fdmr52845841cf.1.1734102631983;
        Fri, 13 Dec 2024 07:10:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46776526082sm42161231cf.14.2024.12.13.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:10:31 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
References: <20241211104704.208354-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241211104704.208354-2-pstanner@redhat.com>

On Wed, Dec 11, 2024 at 11:47:05AM +0100, Philipp Stanner wrote:
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
>Changes in v3:
>  - Move __iomem *io declaration into the loop. (Stefano)
>
>Changes in v2:
>  - Fix build warning because of dead variable.
>  - Make "bars_found" a boolean, since only true or false are relevant.
>---
> drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++-----------------
> 1 file changed, 26 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index c8b74980dbd1..643e335f00f1 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -556,59 +556,58 @@ static const struct vdpa_config_ops snet_config_ops = {
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
> 	char *name;
>-	int ret, i, mask = 0;
>+	unsigned short i;
>+	bool bars_found = false;
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
>+		void __iomem *io;
>+
>+		if (pci_resource_len(pdev, i) == 0)
>+			continue;
>+
>+		io = pcim_iomap_region(pdev, i, name);
>+		if (IS_ERR(io)) {
>+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>+			return PTR_ERR(io);
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

Could we also use a temporary variable here as we did in 
psnet_open_pf_bar()?

It seems to me that no one uses `!snet->bar` for now to check whether 
they are configured or not, but maybe better to prevent, WDYT?

Thanks,
Stefano

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
>@@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
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


