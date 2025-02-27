Return-Path: <linux-kernel+bounces-536888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BDA4855B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B8B3A6B96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FD1B3955;
	Thu, 27 Feb 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akOV67KC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EC1B394E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674385; cv=none; b=Z8pjtea3gDR4oe/aqOhxFk0kFbrcV4c8cdncgW4xeAXtQ0rIUzJH9hpUJdEJng06PRhFMjdn9kUeFB4XyFHNIMPMaXrnweVC8ex8ilZSL6jvb6GnBuj1O3V9cqLyuB8mwPNuuWL8hv4DTkmyk1vG1sMHeyjJl0V5IjCAnc1X9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674385; c=relaxed/simple;
	bh=tSvgh1gnqbBUp+pOKDxBFcFMzDCL9KkB2ZMAPDvL6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiQwbMQxOLfVRNDDgJY9hUyKpkw0VU72tFSU6Oo8tUOk8e6atI5sDiPD4rZWI+V1Ix/64BHWMOS7HYnMJ9eZtlow5n/vK04uS1BLw5ZEOsE7cxVpCJ/2G8JhTVBqV7HISJtsWwHKBvpWCDbi/sd2SR2NQFBmsPfgwM9UhwVTjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akOV67KC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22128b7d587so24088125ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740674384; x=1741279184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lU6TulGrlmG4KlNsYp6ILx7vjJst+VSlmCV1XTMvdnI=;
        b=akOV67KC498bmbxXh+TmewYAFKeIfyYliAugaB81lXztzx6/8tY98G0vQVpOIUaImu
         g+gEkuw94+nwFPYrlze6GVClPda1VH9iVP749luV5mrOYLdeQZfyB2jSU6K2b1Pb1YKC
         G1uE7wvL56YE1tpSHIEPp5bdfK3zOPrubvdXBM57APGbFySkzb00CRZ8xkweJ7+etFE1
         zwzNU69ewuH2JWuh9rL3iQEzJJ+qKPvze/ONhUplzwTTKP53E362JMdO5y8q2PHW51v/
         gBCxhphDWZdz1KJYRLYQygP57LBR95sIUEgssFQC50YqwvVscJWE5wvaWUYEhLde0X2p
         qE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674384; x=1741279184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU6TulGrlmG4KlNsYp6ILx7vjJst+VSlmCV1XTMvdnI=;
        b=G0kegnoAFj/XxXlaNoZOnjl9/zVPS9ohWqKcqZoALxDP5NrrRtayKOJ2h9/kYqKQHQ
         ZHr9YsgL99k9oDllY0Fye6oF4+VxdoQlt7DfCry/2R5qAP8EdVbeM0IHAl+egLotS7UK
         qmwGMwq4j5b7QtDTSpLcX4LolGzST3Sc8fBNZ9Hib8RdlItWOQR2+vYg8+MFsjiyIzPS
         9X6NgavhH/cxGey5/e0lZpkqGUPoxelpw9onOgYKtVW35fOEvPb/h9fQLf0xYlj/Y6to
         kh08OgevCGsRREFQOCtL08yKsoPxZYRbiG7K7oelmwWQXgiYe2jt9f2tRnPBmktbzzd5
         CYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWNYVZ093xkor3UCy4x1oJnRvziDO8X+EV5xydxkmd5Rf+Ve9Z23QdQSREuvnwxyiz97iJjt1IY0ClvGWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuEeoSkviswULc9oTpUltOc8upB/bdmsPkVexp5FuwnLQpiDp
	9xMGKOep+D/oio/kGMjNxVbuIkOtusiCFyr9C4OYQWlPQW3nBejsUMtYU/LfLw==
X-Gm-Gg: ASbGnctgp0vuxDrbJR4nYdVDKQIBut5wmgQtrpXuGHYIP6CUZGhoYegGe95UE65xeO0
	Q5lYUekc0JrdQ7FpwYsW0bkMSVUvp3NHq2qodVFdXdVAJDmeBN1/aI368ZgLbU02HpK0eAiylhD
	pRYratg7itKqjnQY5hM0GNVZz6PnFbOK9RvK/33pybbHBk8Vm/m7D+BOwE5SDcl/5S/bCeO1BnF
	qPMWl69x6HvvYvLSqMHePVHLl4PEGevMpGbDY2qWgI/aYOQwBfc1PeE6Y7vKzrgNqEhAT0sKJvG
	Fq+RByAiu1u3gXtpJZIMfc10VjRyaZ2s5Lp3
X-Google-Smtp-Source: AGHT+IGjVr6y7dk/NnaehBxWXZ5Z15rh1gbNg00OEsuqQ8qkTGeQI6wsgYKPU0Nh3/UelzRQKc/AYg==
X-Received: by 2002:a17:902:ea0b:b0:220:f91a:4650 with SMTP id d9443c01a7336-22320081109mr134100515ad.19.1740674383644;
        Thu, 27 Feb 2025 08:39:43 -0800 (PST)
Received: from thinkpad ([120.60.51.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm16787555ad.229.2025.02.27.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:39:43 -0800 (PST)
Date: Thu, 27 Feb 2025 22:09:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: tglx@linutronix.de, kw@linux.com, kwilczynski@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
Message-ID: <20250227163937.wv4hsucatyandde3@thinkpad>
References: <20250227162821.253020-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227162821.253020-1-18255117159@163.com>

On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
> Add to view the addresses and data stored in the MSI capability or the
> addresses and data stored in the MSIX vector table.
> 
> e.g.
> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# ls
> 86  87  88  89
> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# cat *
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000000
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000001
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000002
> msix
>  address_hi: 0x00000000
>  address_lo: 0x0e060040
>  msg_data: 0x00000003
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  kernel/irq/msi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 396a067a8a56..a37a3e535fb8 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -503,8 +503,18 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  {
>  	/* MSI vs. MSIX is per device not per interrupt */
>  	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
> +	struct msi_desc *desc;
> +	u32 irq;
> +
> +	if (kstrtoint(attr->attr.name, 10, &irq) < 0)
> +		return 0;
>  
> -	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
> +	desc = irq_get_msi_desc(irq);
> +	return sysfs_emit(
> +		buf,
> +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
> +		is_msix ? "msix" : "msi", desc->msg.address_hi,
> +		desc->msg.address_lo, desc->msg.data);

Sysfs is an ABI. You cannot change the semantics of an attribute.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

