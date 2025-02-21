Return-Path: <linux-kernel+bounces-525558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA71A3F14D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92927A7C90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF7201246;
	Fri, 21 Feb 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0UgVN+d"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339D199237
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132204; cv=none; b=PbNeCVD7ch7JMXSvP3j+2WogvI05YdyEgVBrbGRDyszftkiIT33BU76x1H2uXAmj7v8PhZ36NH6/zmeUkaE+aa4JNJpoz+hEiAH4/yH05CgHIWoi/0vUxtLWLLpi3AYPIH/kXTogqXCgRNoj59v/NSN0NQaC239JUBf3FvOAE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132204; c=relaxed/simple;
	bh=zbOp8mcJp98Zt8CyqI4/UZQSSKzSMrTTBy1Oaq5R8Wg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ma642JTDZXBLJxThVNKQ/gqGIzbq52b8lfQBrc1KYR6nCmN+I+5fb/5Fb+NFwrMMITOWkO6+wE+KfTWqLfQPI7IHc08GZVxpwpbhcgegq5eBOhK0dflEYmm9ABC5D6INR9NkhKya4PDvDU4YP6pJD3pqYzU+glJRO6dcoLN9n1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0UgVN+d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so1001680f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740132201; x=1740737001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJU/IyPNR8ispZ2Uu5yd+utAZTTPyngqkCVfD11Jyso=;
        b=G0UgVN+dcrSecgokWw4aKc9uqy4vSgXe2iawCBA+zKwUYQOYDgL6ddJa22clJ7Grz0
         uPTGKrvtkprJ5LxzbIFTsnu4h3ES6lWMd1lyPWFP5c/GkZs/8OW3EjuQ6SewRgGqX+3E
         25Ts4uRRVlPMtdRnDmoy29Lf/PJrMLgRxDgpnjFb2770nA/gOytWPTBkWCwdsIrLcFrV
         0mJuyiV5HybjusPXg+HMYM84ToHh4CNiG0ZYc2WF61XKG4KX6cp0YUGeeu0y1n21ysjh
         ZUZYZY/8bvSEup5YNDWwX4yPiz/b0yJmS0OUy/7+2lWe1TGU4doR5wr9bc6W0Zwj187x
         rzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132201; x=1740737001;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJU/IyPNR8ispZ2Uu5yd+utAZTTPyngqkCVfD11Jyso=;
        b=dGkhOAfsFM3Wl3/HdT6godvE7nVgGPkbtIvOZeK0E0u8I5MmuiasV9LEWLIYToX3rl
         FagBPHT78GDHWMCZDZpKFnc2WlhKQ6Bigles7CASoW7np9NNEZ8ZbNoQyVCTPP6M7ePe
         Kf1KYsOfTsUGIVsYfx4p2SkCXBcqtKEr7YQwxQLk+WJwJYghIgaYAXpSXCO2OJENrWTf
         UooWkQ1iTRu1bcMx3qLC/BOxfKxjwirunIr/aHgPC3kBn7xmY3dkLIn4d06e6wUP0xIJ
         oKIquOlAUPYFEtMCnMgYQSOlFcrB6NQrzmb/hJALnBEEyFHYfPoQQSGibnSGUWdgI1oX
         35OQ==
X-Gm-Message-State: AOJu0YzdmQJbBonw4EJ01s5bCnM78ZyHOP33KfDDqohp13PLgoeoeCFZ
	bNgrpbUoWVdLK2Vgm5wbevwLYuK86TI5whv7YpZcbdFN7YIR6Z6X0DXLxImfOr5hGxCQ2oyxg/s
	v
X-Gm-Gg: ASbGncsHlQDCKjJgDiG7rKNiWSn1jVfBMFIA5Mldg/2WhWQjUfI2h2TunnWXxG2zN4l
	L2s2lCTWYeM6RyqT6P5XW1VOf8w37kWmjIEd6WWw36r4nwIZgxzU+Im2/Jx+hjaZpzVFR1wc3CN
	WqooxrPD1CTvx4/WwNXrNtAuD6sQ25FuwCodtkzoMph2ghWv7CmrrqIm+vXAhz7Q09hNyPUJc7I
	rSXanNG77D59cZs61rhdhe9M/+73WAmMK4eNdA2e7rmTYlehRv7Px9YJyQu6g07O+ZQxWfVmIfY
	lGMSiHJ3lBVMvXipy35NERkXJdPkEO4MZFjCJ+EK4EvO
X-Google-Smtp-Source: AGHT+IGjF6le4uy6lkUkiEwMmVD3Cgw3XIGytL0xVw692V54SHWd4G65SYZ52imDG4nlsMHrKUxBqg==
X-Received: by 2002:adf:e612:0:b0:38d:de92:adab with SMTP id ffacd0b85a97d-38f707a9c30mr1406183f8f.29.1740132201502;
        Fri, 21 Feb 2025 02:03:21 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdb19sm23504974f8f.95.2025.02.21.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:03:21 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20250220-nvmem-word-size-align-v1-1-0f7cc909bc86@linaro.org>
References: <20250220-nvmem-word-size-align-v1-1-0f7cc909bc86@linaro.org>
Subject: Re: [PATCH] nvmem: make the misaligned raw_len non-fatal
Message-Id: <174013220022.174725.12738219990803856609.b4-ty@linaro.org>
Date: Fri, 21 Feb 2025 10:03:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 20 Feb 2025 21:49:30 +0200, Dmitry Baryshkov wrote:
> The commit 11ccaa312111 ("nvmem: core: verify cell's raw_len") enforced
> the raw read len being aligned to the NVMEM's word_size. However this
> change broke some of the platforms, because those used misaligned
> reads. Make this error non-fatal for the drivers that didn't specify
> raw_len directly and just increase the raw_len making it aligned.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmem: make the misaligned raw_len non-fatal
      commit: d0ee061dec068a8c8700b51b08a7b7898cc66a2e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


