Return-Path: <linux-kernel+bounces-434059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016509E610C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB33D18856BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FC01D4340;
	Thu,  5 Dec 2024 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="035i0Ejl"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1591C3C0A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439961; cv=none; b=b24MDFsXqTBStjjbeXA9t6dh0QWiF01H97t8+m1k9iKnYyyEmheUeJ5F2cj+kXPXyQnRdVYshevyTvzxG9SPtbS41gkaimYvB+XvKsraJTJAATvb74NmcQHE1wNdE0zOUhD47dXMapCZZicaL9OH+uK4qqx67nlQu3p2v4vveFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439961; c=relaxed/simple;
	bh=KtxXe4kgB0BnW3MsFzYn465Cqu75ZgmvR8VczHsk0ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrBc+hCDnIfWxiw9JBmYlaU4NADO3TnVa8Lme8KiT44P7Mqxq6xd5noMsaqjXaojxnElmjmwNEykgs6mQk0vqp+wy0Kw3soE2JCfEWGnx9n6Mo8+DBGqe4D0UOmqKBfRao8TgUu3ZhDizI3UYczuVBM2akwB7PkD3FtM6hvEpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=035i0Ejl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215b13e9ccbso14521765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733439958; x=1734044758; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JF86DSQKrbpE7zkN2nZ2brMlp1Djxw82gJt7o2CQPAc=;
        b=035i0EjlumNK2kL3E73CEI22yu/W3Cz+/ySlvV5hxJbhYCOgWW9u52L25pH4xHOElp
         DMc1vnF3jDAKd08M9sUEU/pLHYHIwfVxi1ICfyhq4mSjojGIZ344IT8x7l6tblc7ASxX
         cT0sz2k/id7+3R2u1I8gPgCPDfDKUa6FBTCdgNuHgto2SBSloQSWCBg80IVofiZwii+y
         gDDnrAwv9/ud4gjlJZ08D0d3CIEtcVe7qeB7fc1ORMCuK7NOGOFNUYyfYRv3kslhAihU
         AQan1aaDS9oDNO8ujM+qrWv/AqL7JCcVREnNjgx6EPMnVFI6OUPYe69MgKe9A/mFuV7R
         gFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439958; x=1734044758;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF86DSQKrbpE7zkN2nZ2brMlp1Djxw82gJt7o2CQPAc=;
        b=bY4YWu4Wza2JFTfVn29tKDwxV4QsCgStzUhsGsHm2dFpVH9p+OkEGL2NO1tLVbXPZs
         WWLqu7Ld7wXVDDBTlODiys37QyFImsEV6hDMpPpTiMn4ntmHAbCEzbDrle189Oa2Xf4S
         MZz1/RtIOe2mlM3jarXg/cmO6dfXz0mEYOZX58wMbH6H7TxvISPHyRdRlqHq+DXZSXnU
         HDqGijfti39vSNX5IBJcRBQaDOyOL38imEQzC09hRpyDdiTe5ayPOQO0gtAAbgOoyKca
         +kxppc3GI65hVHrSCbBg2/qba1FrS5M7S7HeWkanytX4ckFiiWFgG+6FqlAp1Q8zwwVH
         +7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU+nug6BjtVNYKCHn86r27IicOu2sQlrQNO9WJ8v5KTgp7H/r5+vxhO/hlvjRHlo8qKhL1cm71DEMjDZ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gB60YCjgrdQJhUQpR0qNvGYQ6zMWwN4YJd+VYg7/NAhn2V66
	cKfXVpx9xB9zcLlVh5eadixwiyawa+EXCbRDCv7szZj2LobwKXpzZikH9/jnAcc=
X-Gm-Gg: ASbGnct6cwpNE0lHUU2ndXhKFV+n4Q9+KfEd/eE0z1a+mWPi9rbf7WCDHlTQGqKE0SX
	nmYJk/FCs2ceBiANkXG0fzxlLpREF2Dy/zFwTFxxfGrqaK5R/s4EoYWzn78qbDbypgQbsN4DjyV
	hPh7BVsEtq7BflHFiykmNN0XIFzs+Xn42l17UhktPmk/9U6YAV/73IjhpGkH7WZTab8H0iPPByE
	i+Iv3fjATPmRaRzaIvlRzoPAdaqBqr/TeuBD2PjbZq5ZnLt
X-Google-Smtp-Source: AGHT+IH2vKnwRVJfKJzkSGh5FdTz/wRZJhZsXQWgmQ3KNajlOo7D+P5OBQ8tqAAXIc8fvqH0d73N5g==
X-Received: by 2002:a17:903:1103:b0:215:acb3:3786 with SMTP id d9443c01a7336-21614d445d7mr8493235ad.19.1733439958591;
        Thu, 05 Dec 2024 15:05:58 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9df9sm17546475ad.148.2024.12.05.15.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:05:58 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andreas Kemnade <akemnade@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andreas Kemnade
 <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, Conor Dooley
 <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
  devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] ARM: ti/omap: gta04: properly specify GTA04
 touchscreen properties
In-Reply-To: <20241205204413.2466775-1-akemnade@kernel.org>
References: <20241205204413.2466775-1-akemnade@kernel.org>
Date: Thu, 05 Dec 2024 15:05:57 -0800
Message-ID: <7hldwthgru.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry,

akemnade@kernel.org writes:

> From: Andreas Kemnade <akemnade@kernel.org>
>
> Specify touchscreen in a way that no userspace configuration is needed.
>
> Note: if the devicetree patch is in without the input patch, things
> will be broken in a different way.

Due to this dependency, I can queue this driver patch in my tree along
with the DT patch so things go in together.  Let me know your
preference.

Kevin


> Andreas Kemnade (2):
>   Input: tsc2007 - accept standard properties
>   ARM: dts: ti/omap: omap3-gta04: use proper touchscreen properties
>
>  arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 6 ++++--
>  drivers/input/touchscreen/tsc2007.h        | 2 ++
>  drivers/input/touchscreen/tsc2007_core.c   | 5 ++---
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> -- 
> 2.39.2

