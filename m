Return-Path: <linux-kernel+bounces-577084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB7BA71823
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF77F1714BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90B1E505;
	Wed, 26 Mar 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LsfbF1jE"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57F1F099F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998315; cv=none; b=oFYxm7bwcg7gWVPrZpQlTJcG2sGnpq782WZBx2M8qV1DLQlYe1WXBdYowt17/COAE4VDoR5P/L/VBETa52b55UJAtTR3/SRNfq044qh2Q34QuoiKUGu975BFSk7Z00mDPQ7lRaqKXJ5spJeaQ+wkMsAVK5+tkeFzO9K2vbiMZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998315; c=relaxed/simple;
	bh=yXtz2926jy2R/WRj7oe5ZqUVxpPtrQBW9y6HOZP7ZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsdDsXmHrAtS/29GQ3/59PTxpuW51OMS/VY4ytq3n8bISoNVK5aS89UrWTixo5jKdzjxCsNbsnGXXkHXmhT57ZcO+X9++8BBq61c8BPXR+StDoD9uxGYD+cvKR7cfaUEfFJmXouVDQmAWp1Z+POspQs6ESiAZdXVNdb0rQZh03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LsfbF1jE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47663aeff1bso66508241cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742998312; x=1743603112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yJeop5/9lZPmW3LTcIpQF3Z1hxE5T9Z8IMFMo+YuI4=;
        b=LsfbF1jEVeiuL+tlTAsWiZ2nb32IyF2R1p43AY2uU9f8NuSl5XUDNxVD1taAjR2QuO
         Wpx88Cn/Tyq9HOUBJoRcNCfKnOR7ANUeMLNFZ0OT9gOU78392NnJpl22uhpvZETToP6V
         qNr5fPk/kLZXHSBfAoLw9a5PHPtTVAClqxxJTumuvncLbbFdpDzOZIH4Btizi/dtbmEd
         6WXnODS4kNm60O3YKUwU49Dhfbez+F5YhCGQt9KA3Kn70bWClMAMz5LL3gJ4HwRkVmVZ
         jrV6wJjpFzmSgI6wHwmpSJpkWzNb/ivW1IhxQf5n6fudf11Lb4shg/cbk4gy4/PBnR/X
         5t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998312; x=1743603112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yJeop5/9lZPmW3LTcIpQF3Z1hxE5T9Z8IMFMo+YuI4=;
        b=qXpaCswhwB1lbXSKCysSu/7hfzuQQLdVQeQQBwYQCDEUxOwrZj7bM7ZLPYDtZgZy32
         t35IWZkJLhM0mEHe+K41Cahxvq9RK1xcyxwXF6XkNxDctK0JwDdBcJ1c1MKhJ3eTts+3
         gkeBZdal1A1GOaXS8nKl7IWqTboAkUt5xNsEK3Xjr6x8axwLQ2iymRfTnmcE3f4Es5yF
         f6eIGjv/SNk19tvsMUEGicwZ0KxsKqz126FAwiE5f3ifgOGm+nSIH1k4DI+6F9lFLcHX
         J2faEjXStbTITHSCSMXRqKO8KnMGZFqLf5t8AriROQ67BWPbwDeACUBkMjTMrmLhenE/
         K/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrSr5uP/Zt2tS868/WejEgtLFRbbJ9DRyCzuUeCmuHiUZO60oMzoLW2r0IueGQKoJ0CMb4ZOtRVY7wpM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnG1fzX80lXJXfsex06/uTaVCcuDUrwzsRBm+ktLh27eT7o7aH
	8CBkDmn+5kRbFIiteA+1fH7VneZF3VUjYR/D/9pCNVdVFeKau+evdLH7v2RiCA==
X-Gm-Gg: ASbGncssLpSGDPsNhObJFHBJ+uQnlaJb72S43damFP9IoFJbTza/7RfEdqCdl24dpZz
	DmJ1adgR8njn3GrsLFR7x8V12g8LSy051EtWCkSbgOP3EQGK8DyUTyzICZxPm3exqchI2t74MYF
	Zf9SV1wGFcFh5d8tCuFZXLzX3rxOmP8GizjeSSO/+oZ+hBP1971eFUelJT/Ue8k7zHFUhkU2OgM
	3RIjJdzfnuoUdMQQaok+oNjF0TGfmR9bsS5oxtoiSSJrW1WRn1K68HKBJs8uyRgOqSNbwkb1bra
	LxMHX5+m9V2wCN+HD1KXnqulU9pM/pBsrKyK5UBSXfbrNJ3sXp0tX4UAAEY4Vbg=
X-Google-Smtp-Source: AGHT+IFZCtFXRFi1B9VodvEj5Mj7HA1YzrBpLpz2+TIPt+Odd8LHmFlysvBHDrxXPsEe1PHedgDd0A==
X-Received: by 2002:a05:622a:248e:b0:476:b56d:eb46 with SMTP id d75a77b69052e-4771dd77d25mr324475231cf.15.1742998311539;
        Wed, 26 Mar 2025 07:11:51 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a193sm72082021cf.14.2025.03.26.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:11:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:11:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mingcong Bai <jeffbai@aosc.io>
Subject: Re: [PATCH] USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)
Message-ID: <ab64291d-2684-4558-8362-9195cce1de07@rowland.harvard.edu>
References: <20250326102355.2320755-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326102355.2320755-1-chenhuacai@loongson.cn>

On Wed, Mar 26, 2025 at 06:23:55PM +0800, Huacai Chen wrote:
> The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> is wrapped around (the second 4KB BAR space is the same as the first 4KB
> internally). So we can add an 4KB offset (0x1000) to the OHCI registers
> (from the PCI BAR resource) as a quirk.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/usb/host/ohci-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
> index 900ea0d368e0..38e535aa09fe 100644
> --- a/drivers/usb/host/ohci-pci.c
> +++ b/drivers/usb/host/ohci-pci.c
> @@ -165,6 +165,15 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static int ohci_quirk_loongson(struct usb_hcd *hcd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
> +
> +	hcd->regs += (pdev->revision == 0x2) ? 0x1000 : 0x0;

Please add a comment explaining why the quirk is needed and how it fixes 
the problem.

Alan Stern

> +
> +	return 0;
> +}
> +
>  static int ohci_quirk_qemu(struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> @@ -224,6 +233,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
>  		PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
>  		.driver_data = (unsigned long)ohci_quirk_amd700,
>  	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
> +		.driver_data = (unsigned long)ohci_quirk_loongson,
> +	},
>  	{
>  		.vendor		= PCI_VENDOR_ID_APPLE,
>  		.device		= 0x003f,
> -- 
> 2.47.1
> 

