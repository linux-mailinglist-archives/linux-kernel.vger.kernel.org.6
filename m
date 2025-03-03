Return-Path: <linux-kernel+bounces-541899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF73A4C326
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C97916B0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900E213E70;
	Mon,  3 Mar 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KtfmI3zq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7378F39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011407; cv=none; b=uTsdSGGOyyoJgeuZEVOm2oL+wqpToh0VKeSw6gnn7tzc+YZJgOFTuZki0jSxnDApEafuSCiYXwktVrkWX+6vp4YOSaLl0Y/XNqFmCySYmK3NDZanp+6YbXBH02FAFAt95kZrd+NV1Jy+3jZruAyE3ICKY64sbmRbNdwTqvPV/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011407; c=relaxed/simple;
	bh=FP1QKBFPUcrMI2AawgU0YCWUvxa2VeGB+6LbEEtYqOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1IZGUs6Ioxd7xNpTDXfTWULoDSAjZ0wXbSikzqty+35SrbFkP1p2xs2rrkFlhHh1nDleNLNe3J/7oNFDLNZTO2KzZ8UHxAmWZCjIzXt2aEycCQi+357aDNTdMww811g3kNePd2Gn3rTb4xhQiGYNPD4MDdNEeA6n6Ne+Ka/kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=KtfmI3zq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234daaf269so54063565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741011405; x=1741616205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHyQ1S6OcoiWu2NIhoviRiSzrc0wSkcr90Nm+vU00/w=;
        b=KtfmI3zqTNLJ3v/qawt1jcLBBHfz2zziJzXUR7IwLKbNQF2TBGZ4WWXGJuGnnV3YOO
         VpO9XWiZjTaYp3pQJPyJaeYTOrKMMWeX7NtmiiP6e01GnZH98EHNPA8USZSfN/RF3EVc
         D63TQv2m+fHtG2IbrvZxzd+RTKf/KVXqlT1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011405; x=1741616205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHyQ1S6OcoiWu2NIhoviRiSzrc0wSkcr90Nm+vU00/w=;
        b=ODkM9O7l4L8oadub+RVUmogSBjJ7mRMld+Gbg1GNKPzGtM/IWe7Wl0P+ndR6vOz0IB
         TWQsBzH6jJ2plguwzzNxsU3e+c0UjfZE7W2ITSxgMGOqI54UPgoHiQtz6THpUMgFvLsA
         AZ7vMGbqcwGCLVV7lAbN2Pt46X5v5HPweY/aIEMp/C9KtuTwrKEvf1ytIypXAs26cizd
         XbM01qg9ss7PUvgEVEdalqLkFCavzfkzVu13m5i45j0igUl0jsMuWnW4swka/cU2o1sf
         bhhFOKrh6ckB5L1KTrMqtACsxZT5cIUnglXD/tbxMEGN0LoP1HtKK79/nLrdk5aa6mgy
         WMfA==
X-Gm-Message-State: AOJu0Yw46gY3rXkdWtQibcCDEG692LBteS8Ya9HvPDYOfQlkk1cDLfIE
	1gZSRYu6Zww0KN4QxfsVKJeoLrZ5yEyL3/KJ2Tz7SErxWHo6um90Z0tt/M1fkxQ=
X-Gm-Gg: ASbGnctAd+7amRhejvCWFcm2/ZcqQzu3YU4BYAAkuSNwUFSY/I5ybaqOa3CxKaKbGXG
	YDe7n53bQrKB1pi+HsNlfVyBxntavU9IImq3wnxH+FbaVD+xkL9nH/7Z7CCWMWqiCr6WZrO54+l
	iBwjrxA59jhJwgATlscXuZgyNT4qzIMhvtjqTHUtXSoVvesZim6LepwvKQBozADpzgWGG4QhZLQ
	Q8cOwdLDR4tlKoCzA8yyo0iWlHlps5i1qYxBEayq8S1kq5n9MdfGxGl0bLCC9Z+lknWn4F2VNJW
	gwVYH8LBUi2XfpsrrgQgBF825qshGT9m1gtIW3wf8D4z//rZNQ==
X-Google-Smtp-Source: AGHT+IGoLI4X4aCiq6Qh2tqDp2VFm/jy5ZG2qcvCISc/6H3iGzMjb0RkAikmZjUbfxoQpMD0LN0TIw==
X-Received: by 2002:a05:6a00:ccc:b0:736:48d1:57f7 with SMTP id d2e1a72fcca58-73648d159c8mr7714064b3a.7.1741011405046;
        Mon, 03 Mar 2025 06:16:45 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7364ef011c1sm2591656b3a.111.2025.03.03.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:16:44 -0800 (PST)
Date: Mon, 3 Mar 2025 15:16:39 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/3] PCI: vmd: Disable MSI remapping bypass under Xen
Message-ID: <Z8W5x73El3aUOs5i@macbook.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <20250219092059.90850-3-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219092059.90850-3-roger.pau@citrix.com>

Hello Nirmal,

Can I please get an Ack or a request for changes on the patch below
for the VMD controller code?

Thanks, Roger.

On Wed, Feb 19, 2025 at 10:20:56AM +0100, Roger Pau Monne wrote:
> MSI remapping bypass (directly configuring MSI entries for devices on the
> VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
> and hence cannot configure the entries using the pIRQ interface in the PV
> case, and in the PVH case traps won't be setup for MSI entries for such
> devices.
> 
> Until Xen is aware of devices in the VMD bus prevent the
> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
> any kind of Xen guest.
> 
> The MSI remapping bypass is an optional feature of VMD bridges, and hence
> when running under Xen it will be masked and devices will be forced to
> redirect its interrupts from the VMD bridge.  That mode of operation must
> always be supported by VMD bridges and works when Xen is not aware of
> devices behind the VMD bridge.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Changes since v2:
>  - Adjust patch subject.
>  - Adjust code comment.
> 
> Changes since v1:
>  - Add xen header.
>  - Expand comment.
> ---
>  drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947350..e619accca49d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,8 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  
> +#include <xen/xen.h>
> +
>  #include <asm/irqdomain.h>
>  
>  #define VMD_CFGBAR	0
> @@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int err;
>  
> +	if (xen_domain()) {
> +		/*
> +		 * Xen doesn't have knowledge about devices in the VMD bus
> +		 * because the config space of devices behind the VMD bridge is
> +		 * not known to Xen, and hence Xen cannot discover or configure
> +		 * them in any way.
> +		 *
> +		 * Bypass of MSI remapping won't work in that case as direct
> +		 * write by Linux to the MSI entries won't result in functional
> +		 * interrupts, as Xen is the entity that manages the host
> +		 * interrupt controller and must configure interrupts.  However
> +		 * multiplexing of interrupts by the VMD bridge will work under
> +		 * Xen, so force the usage of that mode which must always be
> +		 * supported by VMD bridges.
> +		 */
> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +	}
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> -- 
> 2.46.0
> 

