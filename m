Return-Path: <linux-kernel+bounces-289010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7795413A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2760EB21884
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB880025;
	Fri, 16 Aug 2024 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQpkbqmb"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3674770F1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786535; cv=none; b=HDf7BIrhlDgMLCcrZskxSG6blaoxKp+QW5/hitB0w0wPv8slB0QP9j+MxUKid7Xvj8YXr0xEwIoAoxGuggki5V68LMk67Q+ydWJA33/XViUocZF+LgTYD7FF38HW0m/pAEXBQ8GUEyQpcNqVceRUKw31yOIro6i6g2UdD2ueMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786535; c=relaxed/simple;
	bh=mLnOVTA8ZDKjWj4IQyecDgjYW0tAiFP+ZMEIQGLfMpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjFixIQrNO3Rh+zRvOCo/KEizzHOWgUp7WYzUh5daKUwG6fqG/IrNRzCaz0HwavAC4nbP+lJcXuX41ZlzFKzhDVpRIAZzZV8eNzQku2WdPrX43HCfAig4egjzH5V2vq0HJ/a7+N8zvdBkhrd3zJ/7rjeiBWik/uZbkjUUDuz62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQpkbqmb; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14339fb0so945368b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723786533; x=1724391333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mMaohtWWFbTctu7Q7bNFG3sM1FkY98D3v+9DciGUac=;
        b=SQpkbqmbAVzwozBjamzZenZU4T82Mxr3DjWjHxvYBSAuS28pK9P8CYRiCfQ9HR1WjM
         zLpum7EJeW2bwOHQxdjH+C0Yf9TG5WWSljB421f7oWm8WgRPTuPmujTEgsxUUmYhzB32
         Sjg4cwoVswacXmmuxdo4XRt1ljdnO0T7fYi8jXe8+u0N6uYdtxBLoebwOjV3XQxcFfLo
         v2AUtakLnEuL2bZR4cGHCA7gHMBjiMNmfW81Sz/oH6neZxeefDS7JudgCb8iho40lXIg
         QrNckyNcnZ+/vwV6NJGOCBXVxSTNpZrIrUkcyttm/mQzuYLjd9WXlmiygXpLYyCD8dp0
         9aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786533; x=1724391333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mMaohtWWFbTctu7Q7bNFG3sM1FkY98D3v+9DciGUac=;
        b=pG6o41gca1ZTIzpQEv9OajJpeJE5BJP8QFAlduG0ZttRwMZi+vnzf/Buzvvk1Lcywi
         xQfX0BBmvEjSxQkc3+xdFYxI+Qf00M5bZDmZA+FcRWPaJfYfhO80x6d+O55fGB8ugdH3
         fWNseRu2RW3waEKgq9Flc+xOBp0KqJtfpBKNxUaFTcgKqCOcYFuIWBwaBXJYXSj51FTR
         udstmCwpe4ldbrJ0Ckgs0QuTkVQae/GrMYEMV/F98zHI6B+53rICGTT5ltWb0ZdMuLZ0
         m94gdPksfKvJLS1hb1PHW0XxqZv9/+Blzt4JvOQVe3i4wid7RymeE7VA/KDVSQMd5Y2g
         FMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPfDq7ayWbfdJgg61OUpJ9XCGfpyz7GTxecwXrvuDE/+lNueDvxKlU64gVigtYHinuKUDnt/GrODTn1FPA8BkNqK5809ljDxugogen
X-Gm-Message-State: AOJu0Yw+1jH64xAAZOvdEPLWnF7/9HoSluC/hhmgGoRAXldlL9n/urYW
	Thv1USxIYhQxLty3+YK5WM7RxdIcdKafXHvDgV2GmrlLccf5X7SFSN+31AKdgg==
X-Google-Smtp-Source: AGHT+IH5fYA4C+PqIdtqa5tigd13rlW3iuUhpdJbBFlL/Dw4xrGfG1S74WR2K2ZfCPHUvtemrCLNeA==
X-Received: by 2002:a05:6870:e255:b0:254:7211:424b with SMTP id 586e51a60fabf-2701c354a33mr1863004fac.6.1723786532956;
        Thu, 15 Aug 2024 22:35:32 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae16f52sm1891825b3a.67.2024.08.15.22.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:35:32 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:05:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Kyoungrul Kim <k831.kim@samsung.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 2/3] ufs: core: Add a quirk for handling broken LSDBS
 field in controller capabilities register
Message-ID: <20240816053528.GE2331@thinkpad>
References: <20240815-ufs-bug-fix-v2-0-b373afae888f@linaro.org>
 <20240815-ufs-bug-fix-v2-2-b373afae888f@linaro.org>
 <869108d2-638a-473f-81bd-21304d473fab@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <869108d2-638a-473f-81bd-21304d473fab@acm.org>

On Thu, Aug 15, 2024 at 11:12:57AM -0700, Bart Van Assche wrote:
> On 8/14/24 10:16 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > +	/*
> > +	 * This quirk needs to be enabled if the host controller has the broken
> > +	 * Legacy Queue & Single Doorbell Support (LSDBS) field in Controller
> > +	 * Capabilities register.
> > +	 */
> > +	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
> 
> The above comment is misleading because it suggests that the definition
> of this bit in the UFSHCI specification is broken, which is not the
> case.

Really? I don't see where the comment implies that the bit in the specification
is broken. It clearly says that the 'host controller has the broken bit'.

>How about this comment?
> 
> 	/*
> 	 * This quirk indicates that the controller reports the value 1
> 	 * (not supported) in the Legacy Single DoorBell Support (LSDBS)
> 	 * bit although it supports the legacy single doorbell mode.

But this comment is more elaborative. So I'll use it, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

