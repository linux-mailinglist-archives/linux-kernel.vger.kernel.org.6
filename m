Return-Path: <linux-kernel+bounces-448780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539C9F455E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C1169C19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4C1D434F;
	Tue, 17 Dec 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG7S45Ah"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE939537F8;
	Tue, 17 Dec 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421416; cv=none; b=B73Xl5gxQQH1FeZMSBnYRH5cibO22cQTeNFdkjsLwO1YHgRwa2Rs3qpUxIot3sCIKI0QKkvpqDTmhfiCh4UN3J4BqfIFj6F7DRkeB/uq56hNX/xMd8hGrsiYCk/1iBOFEZXhefku5g8VhWjfWfBCJ9+haD4mbv2ofvQU1u/pVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421416; c=relaxed/simple;
	bh=Ux/Oc3nDB+r0+GR4U8mSBxJ27d0ItkKzpSRwQputMrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0CZ2Z1AczO5+YinGsXVRLhXt75NUolELMeFRVTw9ZY3ZrW5A2VlDgsRFyTxiV+TWOaGZbRYkmlzAPZd5up2sRNcKPp2IF2rLE/zvKe4JLL3fP1/UfjmDL5F9w6VXSEfQqvb/+o1Syez4yzw6Tc72fnF6XVIr6XE3jNvEXpHZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG7S45Ah; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso32677695e9.1;
        Mon, 16 Dec 2024 23:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734421413; x=1735026213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0S/6FmSFabcO52cV4xoHDhy7ScsbPCuhDZexoemgSXQ=;
        b=NG7S45AhyT99miBsn7JlHFTJmi7DMB5BQ/L7mdXxJrESaK/DhhQPMzn4bkTIgDOX1g
         LoHir7fcRafxf/3s+x8nrYfn5qVzDPdYoIE4b3mesdLY96CZDRHlx6ImXZ8+kvCd8DQR
         +ALQ1oOM3kL/lk6kkxU39r/JZh/6p7IjGAGKqBRAEXvLYRFVn3soeCTufyoqRC7WoKEm
         pYzgb2FbPMkB+VUJFqNiaikrA7xRN+fepLHDR3Hwcx7dMm6OZG7jUe6Ym31EfFUolFHI
         I+ZZ96Oit0Zjk1hgivgykpTIIbdMJKJePKX9wS5lTy2s6GbqBKP35QA5ImS7WcSUvWur
         8TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734421413; x=1735026213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S/6FmSFabcO52cV4xoHDhy7ScsbPCuhDZexoemgSXQ=;
        b=J5Pceb59C5wcrEKiYpg1+f2zTu3f1oACM9nIleJiabSyMUYJeVB3qSU0ZSHjXVHooD
         EN24M6I8anOGO26q9DZkkItLnUS+nat9LQX0n+IWCozUCtVYhooQEOOd+qv0RG2USWn+
         3AesSCQWmZhee1uxe0ziRZ+0Njfgp/JwhHb5G2emTeiYZZmVjxLeYRJ3EHTrAp/jJ7vr
         qt3L8cbjLxDgscqgMVDVZGMY1DuQLm/b1eOLNqNozohGAEKW9crjbQL+cvdRbHcCFwOa
         1OTbcpLuS/VjVubsxW3bTBcoe6mvFGQhb3+6xYDLT4WuSPiKo3LtWetyRVbdzs6do1EX
         dWzg==
X-Forwarded-Encrypted: i=1; AJvYcCU4vNjEGPWXwsVnoT05Qfk0XRlei0bczecI+Y8wI3Huu73cVnR9o6rhphYfEKRPf60ZOE7hVwgzzKZC@vger.kernel.org, AJvYcCXvjmL0bgafd9tWUOAEV6PRzCYjzuudd0QTheIfm0GaZWKjWr8WYHR1TJVX1a/yr6Wu3UwJEqVP1mHnU/11@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ot4fFKP5r2cK4KZURtuDH7cuvSoofcv5gw7SalKTDcIWFUw0
	rH2vDQDFsdaRVHsQDgSpbP3iA1HaHtJLRAg65uIHnkT8PHsP8CuT
X-Gm-Gg: ASbGncvF7AsM9OXxq2Ia3VNXS8ZGfoko6UuvTMffDB80H+WM3nfVn7w2T9pWe24ZpCJ
	PWugX076JpUEvG8flTo9NmrDAXMSn3d7Tg8wk5TvcMjSuyaj/fEQpSOYPVJxARu6r7Uq8CAyplu
	GZdMH3URm1GSMv+2VMuT/15rhKWsyVcUNvA3k+8e/g1njoO8f7ZLBE+bi1vky8AT5O6c/jvG0AS
	SSwl6959f8pKtJ/wFsCyFYc6b7D4nfjX8eeLz9/UCKFiyLzoaMpJGFhhrYiYFSTTDjM/Jmnms5s
	c0F1oGF8Rlv9iUl4b+bp
X-Google-Smtp-Source: AGHT+IHgQe29RtLKwJS/IyCggWxJjUgUcpG95qhrjN33clhr9vC2LKe1EHdlAC7fauyxkiWt2TjIog==
X-Received: by 2002:a05:6000:4619:b0:385:e0ea:d4ef with SMTP id ffacd0b85a97d-3888e0c0661mr10846469f8f.58.1734421412749;
        Mon, 16 Dec 2024 23:43:32 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806055bsm10196190f8f.92.2024.12.16.23.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 23:43:32 -0800 (PST)
Date: Tue, 17 Dec 2024 08:43:30 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <Z2ErogZuX_bLtM2c@standask-GA-A55M-S2HP>
References: <Z1_9ROiI2ZHKsbAD@standask-GA-A55M-S2HP>
 <20241216-bobbed-lend-abf4b2b5323c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-bobbed-lend-abf4b2b5323c@spud>

On Mon, Dec 16, 2024 at 06:39:09PM +0000, Conor Dooley wrote:
> On Mon, Dec 16, 2024 at 11:13:24AM +0100, Stanislav Jakubek wrote:
> > Directly reference the sc2731-efuse bindings to simplify the schema.
> > Remove the duplicate example from the efuse bindings.
> > While at it, add the "pmic_adc" label that was missed during the
> > initial YAML conversion.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Changes in V4:
> > - rebase on next-20241216
> > - drop patch 1 (already applied)
> > - add the pmic_adc label that was initially missed
> > 
> > Changes in V3:
> > - new patch due to a missing dependency in the MFD tree 
> > 
> > Link to V3: https://lore.kernel.org/lkml/cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com/
> > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> > 
> >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 12 ++------
> >  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
> >  2 files changed, 2 insertions(+), 39 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > index 8beec7e8e4c6..b023e1ef8d3c 100644
> > --- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > @@ -67,15 +67,7 @@ patternProperties:
> >  
> >    "^efuse@[0-9a-f]+$":
> >      type: object
> > -    additionalProperties: true
> > -    properties:
> > -      compatible:
> > -        enum:
> > -          - sprd,sc2720-efuse
> > -          - sprd,sc2721-efuse
> > -          - sprd,sc2723-efuse
> > -          - sprd,sc2730-efuse
> > -          - sprd,sc2731-efuse
> > +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> >  
> >    "^fuel-gauge@[0-9a-f]+$":
> >      type: object
> > @@ -199,7 +191,7 @@ examples:
> >            };
> >          };
> >  
> > -        adc@480 {
> > +        pmic_adc: adc@480 {
> 
> I don't understand the point of this hunk, nothing ever references it.
> Examples aren't supposed to contain unused labels.

Hi Conor,

this label is used by the fuel-gauge io-channels in the example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml?h=v6.13-rc3#n219

Regards,
Stanislav

