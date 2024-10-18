Return-Path: <linux-kernel+bounces-371877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188D9A41B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF051289A98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266B2022C8;
	Fri, 18 Oct 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doDiPHF+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1FB1FF60B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262984; cv=none; b=Xn4bRByyD9Vx9S+AtlMxXGg/E30Z5lIuut1KZnVCYIkcjAAbaSY2eqGQWk5j3mbBRrcb+RbD+yz6xFT2zxzFTkfO3wazdn6HFn75OrxqUmK21ISsP9Ze90vYyoFhVD0dIyg3zaIyY2uiwCXtQbMIH1i1/T3u9uGehscuxN2pKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262984; c=relaxed/simple;
	bh=OFVzv/Bzy5SEVC2fr38Gqy63G+CyJt1NjMHppf2By3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvRYlol6pQCDYvrOYHGCYDTG9fgW7EGlXiVK/65hv+h8bBvAX7v6gzJtQ31+bOlc7CrfJRqYXAa1f3gnbTaw+YivqwQQv7BA4H6jJ7d71apGnE0TJ2dCBkCzRdTAdrPG82lkfdY0ZbwgvVgZubQT/2Y3UHWO/Sw4t/UI1+yE2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doDiPHF+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLK06kjenlDOhOsBFo7iWO+e34B5cBf5XFw1B3ccV2U=;
	b=doDiPHF+yBkR0Zx4tfFykW4hctQB3E0d2x1gwrbpQka022jPJzhPr32Eqw90TN18oJgPWz
	dM/cBPrpf+Z6hGqalGu/EYQbsQ+MrmiT2TZOBTIZVpttpS7zAVNVq8A9yDoUGptErSBUxr
	S29jZfvs8pkv68OmbRLKpxOmUr5IYjM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104--fj_ZNM-OueTwDPM8Np_SA-1; Fri, 18 Oct 2024 10:49:39 -0400
X-MC-Unique: -fj_ZNM-OueTwDPM8Np_SA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b155e23851so163473385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262978; x=1729867778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLK06kjenlDOhOsBFo7iWO+e34B5cBf5XFw1B3ccV2U=;
        b=VCltwmS7UwcqfcbRyvVS4sHMCy0Pxq2Cj6nBz5B7z0s1sAnp4st5AZNyq+k/xLZh1z
         5xN6wjdvCyJEuVCBE4X8HX7WKnc/cpMCMXVpRkeIc/n5rnuEU1njGgIoF+CvENnyfgkL
         rACNUtulOb14sR/E8Rv4kw7Fpp5HJn+7DFr/Clhq74xEMBB1ju50Fb3sE4HY/uVvQtMA
         dDTkJQsqkH1AofX3hfz8/7+Dst5EIVrFPo+/VTgzbdW+5DAgwlJA2jmCXM8AY4M8fwJU
         h72f1ZSyTIrsIqiipQbCixCi15CoNJuUbnwxVxzBuuiiClFLCDOgpa/cU6iT+UrkhE2o
         9FBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3KnBchnPAytDr5qsUTwxOX5bsKJbHbtpE+GB0k5ipe7FeRvnCIrZ0vTg5yKMSRspbz64xdS+k6wtlnRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/Rc+o5b8NL08cz1QYYchPC1zlhx0oz1C5LC0Y7NMrKMsDCnp
	ALogVF8fWKzvNyTjSNeF400LxVcetPRU8KQX7wRLFKyLAWMoUUCxKvQ6S1lnAQirVpyhGWn2+7A
	6LoRCpEsukgoeZ5OVVvy82IkpeGdgkVTRQtTRvut2+bQjgXyUwMMAQ2H0qDmfzA==
X-Received: by 2002:a05:620a:28ca:b0:7ac:b3bf:c30c with SMTP id af79cd13be357-7b157be329dmr296849685a.45.1729262978351;
        Fri, 18 Oct 2024 07:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfckV/4mq/+sa6eyJY9yg4483MucXF6w+/neilLz6xBQ/bACL6PpfbLYrwxMWUXC6aOTZ6A==
X-Received: by 2002:a05:620a:28ca:b0:7ac:b3bf:c30c with SMTP id af79cd13be357-7b157be329dmr296846185a.45.1729262977922;
        Fri, 18 Oct 2024 07:49:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f9509fsm75604885a.30.2024.10.18.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:49:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:49:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Message-ID: <xyv4vzeq7tqq6qqfafaqxfohgmwu5tx4sb4pgg6dilpgqou32m@l4c5il7euzpb>
References: <20241016072553.8891-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241016072553.8891-2-pstanner@redhat.com>

On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
>In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
>pcim_iomap_regions() is placed on the stack. Neither
>pcim_iomap_regions() nor the functions it calls copy that string.
>
>Should the string later ever be used, this, consequently, causes
>undefined behavior since the stack frame will by then have disappeared.
>
>Fix the bug by allocating the strings on the heap through
>devm_kasprintf().
>
>Cc: stable@vger.kernel.org	# v6.3
>Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
>Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
>Suggested-by: Andy Shevchenko <andy@kernel.org>
>Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>---
> drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
>index 99428a04068d..c8b74980dbd1 100644
>--- a/drivers/vdpa/solidrun/snet_main.c
>+++ b/drivers/vdpa/solidrun/snet_main.c
>@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>
> static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> {
>-	char name[50];
>+	char *name;
> 	int ret, i, mask = 0;
> 	/* We don't know which BAR will be used to communicate..
> 	 * We will map every bar with len > 0.
>@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> 		return -ENODEV;
> 	}
>
>-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	ret = pcim_iomap_regions(pdev, mask, name);
> 	if (ret) {
> 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
>@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>
> static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> {
>-	char name[50];
>+	char *name;
> 	int ret;
>
>-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
>+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
>+	if (!name)
>+		return -ENOMEM;
>+
> 	/* Request and map BAR */
> 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> 	if (ret) {
>-- 
>2.46.1
>
>


