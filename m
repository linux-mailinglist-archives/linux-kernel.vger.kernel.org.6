Return-Path: <linux-kernel+bounces-186535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8798CC554
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA6A1C20F34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0D1422AE;
	Wed, 22 May 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRk8tYwg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCD1F17B;
	Wed, 22 May 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397654; cv=none; b=UpaYD/YkWlet3pMh+oOEMPCD7mVBrDJlDb4Sav3RtJTX1tFYDCxbrqkI/pNK6JTIhQ/cU4xhWy+l9XoweEMM6KhIwcCwS1W0zCSJfjvrqNlsQHlHkrBzwmyr/Ogj1/xgL4PkbrZ3kPt1M5ZtDeyHPTfRrTL4GFPbHuk32iXAI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397654; c=relaxed/simple;
	bh=jJg6M8vnkkRviy8VdHkN3OP9YxMIJ2Pi8/sx2dPnwlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crF6PeQVFXxXuEde0KCHERGyNtIz0+u9MgsfyL1bn1BC9PMaflMZVCVRv79I/7pvkKijqNzHbvcuzFxbSq8Vsm7QoOtEZ8Rdg3gd1GXjrkxIEYGGdOonCywBwEA3melhsxkkkKCVO9wfbXIMGPHHwjHM9s+1fdM8zWPZTW/dRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRk8tYwg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so1199019e87.0;
        Wed, 22 May 2024 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716397650; x=1717002450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9aUWuoj4YVy4L3kVpwH36ZaspoRMfIbWdd8Qbs4xFE=;
        b=gRk8tYwgwErSUB3yjT1wPes1LIIBTkJVZkKCWakaVB4an1APPe9QzGdnviX1cYi3KA
         fUJGOPIBORWKi8eM+ZblP3GqLZYpVcFg9GsJQiy/js7Y9jTojWjuUGjrkc3F73K5oKP/
         e5e3R2/YWwarvtthjki9MO4VaK5e0iAQJdUCIdAZ8Irep6xhSnffaYz2qeoGbe0Znm0E
         dK5rpCdeiewkeZKGZQS1VTrdTG75hyCskpAF6aqxtgCOzxgsx2aehGWcA+gVSnoQIh5Q
         jH+NPtGrQesLPKOL26WqzRGHTYDTsZLc3qT41L/qvZzCmcXqPwXLHpRMQB+6rIO5xRX6
         G1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716397650; x=1717002450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9aUWuoj4YVy4L3kVpwH36ZaspoRMfIbWdd8Qbs4xFE=;
        b=GPoOqfqsVKCPR/V3WdYkJnvcC/rAYaf+E6ZmZTUV+c7y5HWUKXLC6iBctKV/rToUCZ
         VBpka6B8NcrUZhS/E+78E5FRdJz0zyGqMoG75mtf3RrT/5GtNEIg4KpbNnVEjx+7mOU9
         mvBjxGNWrPBZ9ygmvT5JPIeBoQw1sc/YBijrw0/2DkUkp0OpCjqS3dw5eviN64+7YGBw
         vpDnGj+WlU4/hKXMcm9ja1wJS1dqLL/J+YcCu31l6HzR6MfnVm+wAj+QDAWFeVCKCJ6m
         sQMBNWXHgLtjxOmCnLbzpr4X8ivUw1qF/xs+3SMIM/h2LzX/HMOenR12luM04e/MfRUP
         hTRw==
X-Forwarded-Encrypted: i=1; AJvYcCVjmCx2qkx8FtsNNyVB+0AzffE3HejkHVSAihHBAhTW5Vacki8cJW9wHeAyTgR0oFtuNntLvfroi3bIkzMwbr0qIJfgyw2gVeBhIhkRvt8LP+87GPaUGOzbn3E6FbkGUjiWaEOFNcauHlqW3xOddl04t6tN1vowNhdxvxG/2UCuhuja0TEc
X-Gm-Message-State: AOJu0Yx0wBzsjTbAZNeCesTvvpqBohH0r1/vLfXIwt7mPboDrECnjWEB
	T4FAQnYjJ5wckqSsMUg19rGgOrdAzbtemRwm9sbmaNsP5FRv1Zhlnwrndd0VcsDZltieBtQmByJ
	0wnorwgcYWk/xM1TMNILdrsyV5IbApu8eis/4wA==
X-Google-Smtp-Source: AGHT+IHJtY2P3oJxRC0ryXLWUKx5drw3pPINF21ew+vjLBwgO/mAJe8fhU6lyJ3KfHeHcoaraTybHLIiAC8QR8aVmSY=
X-Received: by 2002:a05:6512:3991:b0:521:7b99:8d20 with SMTP id
 2adb3069b0e04-5269cdd056dmr935303e87.23.1716397650274; Wed, 22 May 2024
 10:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522075245.388-1-bavishimithil@gmail.com> <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org> <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org> <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org> <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
In-Reply-To: <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 22 May 2024 22:37:18 +0530
Message-ID: <CAGzNGRmiNvNvzkxeyhoC30_QY=MK8pgxdVf_E9Toa7Z66dmwmQ@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Something along the lines of,
mcpdm: mcpdm@0 {
    compatible = "ti,omap4-mcpdm";
    reg = <0x0 0x7f>, /* MPU private access */
            <0x49032000 0x7f>; /* L3 Interconnect */
    reg-names = "mpu", "dma";
    interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
    dmas = <&sdma 65>,
                <&sdma 66>;
     dma-names = "up_link", "dn_link";
};

Might also need to add clocks?
    clocks = <&twl6040>;
    clock-names = "pdmclk";
But those are usually defined in board specific files.

And add reg-names, dmas, dma-names information to the docs?

-- 
Best Regards,
Mithil

