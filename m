Return-Path: <linux-kernel+bounces-297010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A7495B1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4118D281818
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FE17C211;
	Thu, 22 Aug 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWONRY/9"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B515572C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319517; cv=none; b=HnX247BVyCCOJdYFCwU9aY6fwWAEQCBhorffNQiEbi7Unr8sIFkC+EUudfB9ozbh5bk56WutgHIc3EppGdArbFdji4E733noWj3ll3FALFQKdh+2/D0ezk41LlUTDBs+pjzV5sBEr+vlUu14Sjl6EHvfnQHroYYiRwH9OOeahJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319517; c=relaxed/simple;
	bh=111O/5/1ojVV7OI8NIPGIbmOFNtTVFkol4UsxQyR9uU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVnMqWsFEF/pat2Iu80jpdESo4fDImh3hiN1eh9pTSGv0vVMx02IpW9hRrsAttHDW8/yNW/IUnego5B0NqywTHkwLCZijPDd2GfCYvMoy9qohj8JlHRUnKTxdnKcFDI7odCstBNteNmu1L5xSh4a3lUjzLYubMDKn4iEHHEbuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWONRY/9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37308a2ea55so29014f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724319513; x=1724924313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcAP1+UzidHHBut/wkiIQwc08/qanMcQw9/HOzcokdI=;
        b=fWONRY/9UMTzGG2Qzqvg0H7UBr3TB1U+gX5960uBT4/SWB360FJTy7nM/VXeoqAKQ2
         94cVylOhpoJ+8qh+jovXrAPviM5FaGdMQgarRt//YbuzpR6VMQPrXt5KKizz9K37WkJ9
         NT794Gzmzebjzbznq8rHw3dQnjBF/T/cIm3ddqWArD6wq/y2ol9SdbfmVXBUU72AZoaL
         X9N2fb2WtQDXGiBzkvhvZwyQ/ooOIEbbMBCD2P2epP4CnyGqtKvRBhcNJY78tBfqB4W7
         olua1koQa4puJthRGptKzKCgY02bGzzVOfogOGcVbymO6X78KGMIMoUNhZXBKmMlIiad
         zTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319513; x=1724924313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcAP1+UzidHHBut/wkiIQwc08/qanMcQw9/HOzcokdI=;
        b=Ngz8c+iup7m+qaloLmR608y1Ofl1uP3BPQN1ACB/MrN0YnQus0wiYu87Ds+/94Ct+8
         l/eTAO6xKXmBZHDozPG6qog3i5LLy5IzxfYpr3YFIEl6lmWhnjjUP8EuV3OIZsdqhShD
         mzlAV11vELkCn9omcMI/6fDbEay/c2oR1EETAovHQL8R2gnnJIronkRuAJCOBdK9EEsM
         gxMfnHbJc7mDfFEbM3wSUhKvhem8FACMyNU6a7Z1D17M7dYcSAII93wRsl6AqbAusIKq
         N+ZfyHZzkC1EOJkY6NEO0r0TPmXKAmExeFJRwtGxPxOGPzOZIKIaaBWIHng64wHfGtel
         2AoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNoRHLhm5BuHvS2n2BrBBY/c73rAoY96swvbeYelIy60AuE+EONWqBloYo82BuE3+v6FxxYEqwcc9T2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJQ5e09T01YXazc4Z5/U4U4831SrmRQuSJkhFZgLvex7LgkDq
	WwMvLBoDYfp49u1Y1tseuDA6XKPMRLZh6T7uSxnsj9uTYqA4T8r52OdwzQifOI8=
X-Google-Smtp-Source: AGHT+IFJFErUAThi7f4GEL5kxSEupuPH+kbml2cXMv40hedr33cHGawmpp718dh+i0XjTApnjQJUxQ==
X-Received: by 2002:a5d:5e0f:0:b0:36b:b2a1:ef74 with SMTP id ffacd0b85a97d-372fd82f725mr1321582f8f.8.1724319512802;
        Thu, 22 Aug 2024 02:38:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a5acsm1221805f8f.64.2024.08.22.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:38:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kwanghoon Son <k.son@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240819-add_sysmmu-v1-1-799c0f3f607f@samsung.com>
References: <CGME20240819075546epcas1p355a3c85ffcea2c43e8f1b2c69a0f3b4e@epcas1p3.samsung.com>
 <20240819-add_sysmmu-v1-1-799c0f3f607f@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynosautov9: Add dpum SysMMU
Message-Id: <172431951098.22090.17586720049616945954.b4-ty@linaro.org>
Date: Thu, 22 Aug 2024 11:38:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 19 Aug 2024 16:55:45 +0900, Kwanghoon Son wrote:
> Add System Memory Management Unit(SysMMU) for dpum also called iommu.
> 
> This sysmmu is version 7.4, which has same functionality as exynos850.
> 
> DPUM has 4 dma channel, each channel is mapped to one iommu.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynosautov9: Add dpum SysMMU
      https://git.kernel.org/krzk/linux/c/71e0b08ed2a98e5ab5eb255fc86cda04205b141e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


