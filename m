Return-Path: <linux-kernel+bounces-186531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A438CC544
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4628272D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB01420D1;
	Wed, 22 May 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpo1AtU9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3E7483;
	Wed, 22 May 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397353; cv=none; b=kxqlU1s/t9lm2lQjIK4UeLStWAeQg/75mDh9mxIJuq46j2qSOjn8PFGjv5OvyEQdRAMM4m9Csu9/unOrnyq0DmN5aLzPWouNueVRX2IX/dcCUBLi/p0gdPCZ1gKhSd4OngIy9QfQPyIUb4zcUWPXA4s8YGAI6qmbYYY5BfZhs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397353; c=relaxed/simple;
	bh=Puptrl6ccH8U6wynXeeoHT2VTC4tYfIonHb+nEl+Eu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIOq1ssxAUucAlP6MYEjOwQjPpp8XR45DFnINjZ45JpC2+cPvRgq/koOHiXeXWpCP+p5ssfy68kw4Ca5ajVdX4Zcl3WttTGRmF2zpiOiXUHCJEGT4jRKBIBePlpPN31k5fKiBCDKVGZlHs5Ljm3C/S+ytwUbXltMna3ds704Qq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpo1AtU9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f40b5e059so7421889e87.0;
        Wed, 22 May 2024 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716397350; x=1717002150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=biTX1lY3rxhlPuo7g+HDANOFhfS90Bjl+wxh8tPkfvs=;
        b=gpo1AtU9m/fNY+doUpibPBalQc7HDe4C5Sl/01FV7CqHZrOGQz+ty9zaZhHevfxyNZ
         7MByAEyQSqJnBwmVPCdJYNYdEaPMQ7YQSjMqURC3SlsDy2Yl5lCAr4ofx+Mdi7+nEXba
         1EOppYPhvEGjHop8dppFmcGGr4qKHdHkYEE1V1Oz3gq4Rwhk3s09E8Azu8AkPnsXOprX
         AuyTouTW0MBsHJ36e4FgO8krGaK7pHd+cfM5Nd6XpuSLlSgTfqU36DSOidP7RvD5vyWL
         MTeu+5yqUJdOm71saeb8BH7BOTUdarCuRdrtmV+fkVhDoFY3p3AePadLNjwz8QSB+3m3
         P/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716397350; x=1717002150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biTX1lY3rxhlPuo7g+HDANOFhfS90Bjl+wxh8tPkfvs=;
        b=Y3eWZ/5ijgXMyAW72niV9lsrMCkEqp3WFuwFvRK+EsOixPGZiW4AKD30p2FFFEvxLm
         ng+pQNGTOknqlkiTNyWR+4TrJrBxzkG5asxEFAqOB4Ln/gQiP+TJvt61cHiB9BIf0shX
         aoikwYHdY2m47RfPEr4aMHaxvJ76o7k+mS33u3j9egxXPdLU8YjV3//FMTFoVXP7oAGQ
         qLFajbi3bAgMFiILROcvSVpK2k5Ehz9AIliS0tY/tW0X8ewdsTQXhG3WbxkyY1HRPc7H
         jnXHCVYmeC6DY0MiL5SwPmgkG/nTj08M0rWFtJRHOd/GjkQZKKrMosMvlcz0UZDA1syU
         FoPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyFz0HF5hbWbcq8551hLzyVSzRn4gwQx4jav5RXZRCwt1gvZqttRXV30HUoEK9p38umsm/6uxbiQPFc9qg5WTzW1ZPkn2S7Cu5WtPV1S6cnFHx/IlQ5/LNYJ4ur41Phs99NtsrbUsUcKgEKu3jcXEKx7gTV0Ho/Wmcw+2OnVjVyYTyOlI2
X-Gm-Message-State: AOJu0YyE3hZpWgEa6R2ywv+1xPFdHa9sAXTeQX79ORR5pgOwV284bArJ
	ofNDfWmmDVpAPQ7Wy0VQwb2RjKHyWoQAc4OMVp8QGh4vTWB2/t9fQA0olX4DDHT3hj1/P3ZYbKd
	p/8ahZnVDGRHi6rvasE52sYzprjI=
X-Google-Smtp-Source: AGHT+IHF3Yq3TjZtrSQrPgIrirlnVEfMDqqdVjHff1M5C3nO3oZg+FeFBxiAHZzl3MVNMOQnkGuSOVltS2iGOIYEM+c=
X-Received: by 2002:a05:6512:2351:b0:522:2c9b:63bb with SMTP id
 2adb3069b0e04-526bf642daamr1655834e87.52.1716397349438; Wed, 22 May 2024
 10:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522075245.388-1-bavishimithil@gmail.com> <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org> <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org> <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
In-Reply-To: <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 22 May 2024 22:32:16 +0530
Message-ID: <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yep. And testing DTS should clearly show that conversion leads to
> incomplete binding.
>
> >
> >> I assume the DTS was validated with the binding. Isn't the case here?
>
> Mithil Bavishi,
> Are you sure you tested the DTS?

dt_binding_check did not give me any errors. Yeah the example is
different from how it is implemented in the kernel ie board specific
(omap4, omap5 etc). Should the example be changed according to that
dtsi then?


-- 
Best Regards,
Mithil

