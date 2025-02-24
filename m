Return-Path: <linux-kernel+bounces-529024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16AA41EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E01889E62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DD19B5A3;
	Mon, 24 Feb 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIJwfcMk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586791A317A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399890; cv=none; b=EPNU2W4JSmse4qr9+GfDKNfM06ePLyzLY+hwJA1PksGfcT+WrBBI5V2gwj2l8EZmKuCvY2IOdh0HlBB9GDx7uBD44rp/9BBv+OslpgQQVSXCvb8KInmpojvuMmW361MUstTk17eozRxrrKExeLn7y/tgubBlsDC6IYD2mQugSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399890; c=relaxed/simple;
	bh=Lis5HjVK3WM+Degswlw1UlkMf1Me/rIKqyrwVJtfqU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIJifv1zDqkm11R4zPK7QRBQrXnt7tdFTLZuf0sGTdUhbEy4mxfHvLOMd6HNxQfGct9Coa1j2Wk4W4J3FhX4lEBVNJSKBjRreoRUL26igzPfFocTgkYs8z7obaigj85m5Qs3Wf2OjC2dGrcdbgJEVABDYxVdVW20x5b1wnxn5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIJwfcMk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so6621583a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740399887; x=1741004687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzOuuE5AQmIPlvYyxq7yqi7h09eNAtPB9O3gjrpeReo=;
        b=oIJwfcMkfnEX1XrhSul8seuSPE+46c/4HFTZiw5clumOvxxskLZaPSXB4YpyxCLrEl
         tywQJyA2XdDP0EBQe3lrG4qZgsNf0XiPwi8eHbEC9/ORIA2vFfC5qHn4SM8YIC7aHr2z
         IPuuoml/OcxfEOUJJ3BSPLgH29l9xGy+X9aav8FsBMswtrAh1CRjhAc3yJ1ZSZxwJesL
         4VhfkGLWn3NgvMNoyOu2CtmB5gjy5AdOPHGzyQf/qXSwxZR6lLhdltN4p5xxfbVAKPeJ
         o9F6x0ZAwEn2gJBahYvb/Ht1P4XBIsEqoATZZXO9bxRcdS7VBhBVtTA1DbVeMvRFyBno
         ZUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399887; x=1741004687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzOuuE5AQmIPlvYyxq7yqi7h09eNAtPB9O3gjrpeReo=;
        b=Z6EhOx0r/semB4cGfKLqosVZQyNrmRxStiSrwXGIYcTGuRpm0aWaHxDNZHhMyYqjVe
         /uVBPfNSHmJbdXUrX7l+vj+Du9+8lzh2wh5Q0tOM/ZtiaMusp98MYpKywFx7HO3nGFK+
         wRvac0ARBQC1Hu2uiMZJGIWKQNfSCbL+lyyIunczL3ayoFE2yqrjHGQ3uVPb0hYmhO5B
         nE/1EhYoN8sWAWndpu+X+svxXgYhEyJgIO4GtJArTjwIo2ungjYUE7EaRBQS4cf5v/Hb
         qD8f9t61XDiZ8iEpEnXfwC0jbRg2oi32Ld/OJzwEu3FJR7ircTOmEWp8UCm1hnmRLmmr
         6egw==
X-Forwarded-Encrypted: i=1; AJvYcCVvnr5XYijY7E0RogKtpL3I7rkfOAQDgNtWNAaQ8EjKHuHMdcnjSpwsR1dnqgohTBEu1jxzfAk2X5E/HUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbKeDeaDS+xCB+McJ+cPXJDFmN7/Z+iG49vbwpi/YEAzqFcNZ
	HDfMnu4YjumvpwrzJo4z7K2xwIwfkzs/637aBHVYgCIEjbuL13fcKV0XGYELscRQBvFV6SS+lCk
	=
X-Gm-Gg: ASbGncteszg2UE/Ud8DTXpRx2tvt7oX0+WXvnka0zRumnGgpW0IMh+fNIbsryXho4ut
	634PFHORAjEKuz7x9QVKh0glImlgQb4uapbkp0PEd65cA3kMjtQ9J0iME+kF+sr2eV0xFYQC9g7
	Hbxz0c+XBlDF/eQzNAk6BKYfCMxCkMJx8V16oxR9uH3Jw8N40pgCRRhUZL/V1tSvC3YjT1zf/g2
	8PzId7UISGqSZ6sN9PsLLBULC1iwQa2hXe0FfV+sh0gI1vJHi0ypMJPRGgH+WWu9g5vWcYnPCbJ
	YTP9PTga+UH0jjPaB6YOHVnJSiGPT0SzsiZS
X-Google-Smtp-Source: AGHT+IH/w00sFYxAQuhzHVocmdDGxR/sR2j2LN3gKicNu564R2XT9+1VYMvG9GP5RbWPILjxrB+JCQ==
X-Received: by 2002:a17:90b:53ce:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-2fce789de66mr23281750a91.2.1740399887600;
        Mon, 24 Feb 2025 04:24:47 -0800 (PST)
Received: from thinkpad ([36.255.17.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5ea71sm18865435a12.8.2025.02.24.04.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:24:47 -0800 (PST)
Date: Mon, 24 Feb 2025 17:54:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, neil.armstrong@linaro.org,
	quic_devipriy@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <20250224122439.njrcoyrfsisddoer@thinkpad>
References: <20250220102253.755116-1-quic_wenbyao@quicinc.com>
 <20250220102253.755116-3-quic_wenbyao@quicinc.com>
 <20250224073301.aqbw3gxjnupbejfy@thinkpad>
 <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
 <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>

On Mon, Feb 24, 2025 at 12:46:44PM +0100, Konrad Dybcio wrote:
> On 24.02.2025 9:46 AM, Wenbin Yao (Consultant) wrote:
> > On 2/24/2025 3:33 PM, Manivannan Sadhasivam wrote:
> >> On Thu, Feb 20, 2025 at 06:22:53PM +0800, Wenbin Yao wrote:
> >>> From: Qiang Yu <quic_qianyu@quicinc.com>
> >>>
> >>> Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> >>> whole PHY (hardware and register), no_csr reset only resets PHY hardware
> >>> but retains register values, which means PHY setting can be skipped during
> >>> PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> >>> after that.
> >>>
> >>> Hence, determine whether the PHY has been enabled in bootloader by
> >>> verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> >>> available, skip BCR reset and PHY register setting to establish the PCIe
> >>> link with bootloader - programmed PHY settings.
> >>>
> >>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> >> Some nitpicks below.
> >>
> >>> ---
> 
> [...]
> 
> >>
> >>> +     * In this way, no matter whether the PHY settings were initially
> >>> +     * programmed by bootloader or PHY driver itself, we can reuse them
> >> It is really possible to have bootloader not programming the init sequence for
> >> no_csr reset platforms? The comment sounds like it is possible. But I heard the
> >> opposite.
> > 
> > PCIe3 on X1E80100 QCP is disabled by default in UEFI. We need to enable it
> > manually in UEFI shell if we want.
> 
> IIUC this will not be a concern going forward, and this is a special case
> 

I'm wondering how many *special* cases we may have to deal with going forward.
Anyhow, I would propose to atleast throw an error and fail probe() if:

* the platform has no_csr reset AND
* bootloader has not initialized the PHY AND
* there are no init sequences in the kernel

- Mani

-- 
மணிவண்ணன் சதாசிவம்

