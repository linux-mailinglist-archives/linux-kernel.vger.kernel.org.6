Return-Path: <linux-kernel+bounces-186572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91D8CC5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F9BB22CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D9143C5B;
	Wed, 22 May 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J497um/g"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA19142E6A;
	Wed, 22 May 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400052; cv=none; b=NOBbeIS+VoXsG9lTY4jQ9B7ODe2ouyAcjULur4fe9+1312fZ638ODvgunjFt4FFUuXLdstsOmj7p7pc25CsB7olVSBLC8rCpNBn28Gn0M6h/D4/BA9CuT698xecqiZTIue+Pf5/yvzqailB9rgf9d8qVI2Xpr/LWk+42mKmBPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400052; c=relaxed/simple;
	bh=gjQFUkmKSj86HlJZV1l+XdpHTnwTikA3msRKm7inGks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvSd9dBfKqR8w6cMjRlnf499GMHIYfMD8VePkR/rlbiGCNabHHA8vMeKzObNTk6j4DNGrXGYSj7dELlOUAD6xoAkraDqfyG2YaRLiRm7KA4bzT7OO1wpGwTKwW0dQrfPMGOghSzSvEluuoYvdiuvdU2zsuYzUynKxr38WMlT51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J497um/g; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5206a5854adso6040812e87.0;
        Wed, 22 May 2024 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716400048; x=1717004848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+HhzDlrygC3CKmNKNnlvvwQPnU1QbynOZdDkM/5OBAg=;
        b=J497um/g8YwlJmRrAclrqlK8A/YDACqHn8JZjbqQDReVbponk3oTYCh0BmSX9dK65q
         Os93v64aJDOUsizjxGMOxLE3BNZKXUfNo0WVTT/2Vvp1lw1vN29OKSVZCLVBsW8YAUwA
         5GfuCc9i8e8d0rePWhuskYrx2RdsnLxwyH7vS6EqcLtitOp8Ka024pdkO67WuQkf4UJu
         P1KYAAXj3Q/S/HzuaRw8Ch64nt4OltN+sMtIFMyhMU785e6y0/DXj6q4SLiaS53HcNCp
         BNE6Nei+L1s+S6JQF3hxM4w2/AEyuvD1p2ME52z1Uswa4SuX2B5Y/oSUHTWEb27fCbXh
         BY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400048; x=1717004848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HhzDlrygC3CKmNKNnlvvwQPnU1QbynOZdDkM/5OBAg=;
        b=LfNc3cwm/V6bqEf9D5prQln3MKXzGrD0uoR2M6d1sjbHzMVk1u+PS9q5vDwsHlAvBZ
         m3+h5hMcBP/0mSdHJV+A4rh7Wa5hLkRNTOgq8T0b5pLAiXPZaFqQIuYyZD8Hyk/H45Sp
         giNMDpj6TXN4PnASjoX5uRC7It1gwhQSfBJaA0Z8Sz6v0RUbYcBPdCKjG5du9Mx72JCA
         diKZnaCPtIRj+Ei+7to5NdbgeLub2Q3HcsFZCmRjgP5QAfZni3nRzrHmS5mbYBklZ8ub
         eHA9v2X0Ff6QsgRHYUVG09pD9RVyMEdPs0MkeUBtEXO5GpWxT8LPCEmL2DTYcJDjTXFq
         jmig==
X-Forwarded-Encrypted: i=1; AJvYcCUQxqCfaqRxthHlDqUevGJ1lEmmHFpndBWScdpxrj77W6sJ0c82+/g1hfS3MfT+gU4qkTBuMgvOZ9Nci/dcPDlzrXeHcnTnPTfXHrUKykL8l/Mvun5aJGicRUUrL8c3L8FhIA47pGU1Kz1gIbdKUiOCTjeB2heBBgMpE/JOWfJgBfarN090
X-Gm-Message-State: AOJu0Yx1qi87OsM7dj/SgRfcFiQnw1QfsEHtijq7mMhMpHgTQkT7W++Z
	EvmMW8M2E6Rr6eqyThIH0qz1JBW1rvUGHoOQDf8BtT8abC8ft6RTsaOFIZ1L8APGwkdm4dKfeJ2
	v2/Xi9CEWtutCJMifOVHUb6hzhr4=
X-Google-Smtp-Source: AGHT+IFSpgb1R9JRzKeziRekZA8ENhVvYKjubDHK6juv356O4yEXmZixwV6hUWbStw3OL0qY6DzmQMO/fuak+bXr3y0=
X-Received: by 2002:a05:6512:442:b0:523:c515:ecd9 with SMTP id
 2adb3069b0e04-526bd694358mr1646462e87.14.1716400048051; Wed, 22 May 2024
 10:47:28 -0700 (PDT)
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
 <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org> <CAGzNGRnsmRWzimUX5tEC2-Y44aa4i9Lbdp8YJ+oneV4ujs4qBA@mail.gmail.com>
In-Reply-To: <CAGzNGRnsmRWzimUX5tEC2-Y44aa4i9Lbdp8YJ+oneV4ujs4qBA@mail.gmail.com>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 22 May 2024 23:17:15 +0530
Message-ID: <CAGzNGRmTR_nK0SoWG8uqDfRzDShs7sR+Mc+44__SBi0CR5LKEg@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My apologies, misunderstood the error.
Proposed changes for the next version,
Add dma, dma-names, reg-names properties, and do the changes in
example (rename node to mcpdm since it is different from generic pdm).
  reg-names:
    items:
      - const: mpu
      - const: dma

  dmas:
    maxItems: 2

  dma-names:
    items:
      - const: up_link
      - const: dn_link

examples:
    - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    mcpdm@0 {
      compatible = "ti,omap4-mcpdm";
      reg = <0x0 0x7f>, /* MPU private access */
            <0x49032000 0x7f>; /* L3 Interconnect */
      reg-names = "mpu", "dma";
      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
      interrupt-parent = <&gic>;
      dmas = <&sdma 65>,
             <&sdma 66>;
      dma-names = "up_link", "dn_link";
      ti,hwmods = "mcpdm";
      clocks = <&twl6040>;
      clock-names = "pdmclk";
    };

Remove ti.hwmods from required since some dts like
omap4-duovero-parlor, omap4-panda etc do not use it which causes
dtbs_check to not pass.

-- 
Best Regards,
Mithil

