Return-Path: <linux-kernel+bounces-195408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5708D4C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5AD1C211AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B91822E2;
	Thu, 30 May 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biHpAYnc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00EB145A01
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075032; cv=none; b=SYuf2sTpGpz27wCTypJ9yvFs1twurwTVJpN4+iXFNr3iIrKx/cQ7iFpOSySaQZZJpECQt0q2qs/CEQK2e4izd0UNyWvRa/kxwArTJN7LTkWT8+SSDy8PKj1W7vlF5W+Ugy81hcDekk2QQF3V4eWEjH0PwemHJ9XElBzXte7tXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075032; c=relaxed/simple;
	bh=1G2diuKVaHRB57mWjeDywkL9BOqOzFEhSmqwQ0CpoLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AS10Gtd3j7oIMKd84x0myUFIMj2aWoQgVyCtHnu2dowbeGTiNIk0HT4f96xdK5bnfjz6yFB2peRPsif43WXVivAf2/iDZYFOA6YkelBa37S1XOFUnpIUxYznFKJElDCb7sEXfrsPXCMfguROzGI0pSg4vNpH7U3xvpFs4QBadhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biHpAYnc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c19bba897bso671482a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717075029; x=1717679829; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lrR0F6NwP1G8Q4TJCXB4TMu40D0ygkOQsh9747J6r0=;
        b=biHpAYnciDETDQkK53Ln9+UQd11lQKAD7W3vHEpRPamhUHAhdL6/4/MwwBvF6Niqiq
         FXfg7u+5waBPPXw9cqLQFIFyimK3aTKWzKye2V0u7wXAnr3GlGyFGq46XP0SNxxFXR36
         RhIYJ82+eC1K5dLbxhfxGJ/xGF2Jrr8GG0nqI57GsyUeZmlpoEtdPzGkf7739oI1JOFE
         rHiskISdnxb1O1xl2SZxx0qx0DCOMyN9JGu9oa/+/AoXFBkxgD3gz7KGrQudPk2umzGs
         vfUdqo08/fS1B3CIt/eX2RffNXi6HyIuZ1cec6o0bRhWeBsL1W6mcLt8uM4tx0/8fLbV
         Akdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075029; x=1717679829;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lrR0F6NwP1G8Q4TJCXB4TMu40D0ygkOQsh9747J6r0=;
        b=cOhSiP2P2s0cEepRaVN8uzxiIm5TyNoVJvFUYcVvWcgdIr3RjBEp/GZgTjlaNur11r
         Uvw+ZcjVgEmFAveQE4iKutsLzbEEoO6zFK7223WkFFaSnmviOtpXCFZO0BahiiNfgflY
         SsqrvkideJrYNmo3ct9S43cqFYIoemMrmUToRiU2P+4nSLy8ByVEnQMfYTtTSgffi0u/
         t22ii+8UzAnIlWkNP8xqFX/osKV09vo4Q+Xuui9Zd9Qt4SUQBPnJ1cDaDfOsD3PwBz5k
         P+zlMrU/RI7Csd1+wEL074rGX5S1ZR5c3myyQwDsNGkuGfHm78JB94eIS4+/NmmNMsjo
         8qPw==
X-Forwarded-Encrypted: i=1; AJvYcCVXOU/DQCtUco9UwTDdDwLZ6R+fgb6kYAarbL5dpreD8/TLIhNvkM55moS91s0Heo9Je6CIXs3I11G2v3GaNwJWh+rcrYECU36h8tCl
X-Gm-Message-State: AOJu0Yy+61pOwsJNViOorhHzzfrGjzlU5Lz4OZPf/xYSQtHR3oGtW3e3
	BPnGth/KOAQPmPcMtAwiLHDU6a83yU2YEpVxN35GMcoFtnQpFvALRl3DtGPXpZCUbeMUMVEOmff
	j1iRKMYh3U2eO2Y3XULOXaq3G+2Q=
X-Google-Smtp-Source: AGHT+IGBhwoDb58h+jyzsL4b5pGy9KtHG9fEiek/I1hJnatDDoenPgk4Yf322cPBUh+jMRW/pnUVxC7RSty9/AslPAc=
X-Received: by 2002:a17:90a:b38a:b0:2b4:fe80:1b1b with SMTP id
 98e67ed59e1d1-2c1abc7b93dmr2036426a91.43.1717075029164; Thu, 30 May 2024
 06:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
 <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
 <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
In-Reply-To: <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 May 2024 09:16:56 -0400
Message-ID: <CADnq5_OTOYLYLE5d_nXiu+b3edBZBc88wha6qs8hDypOUURzag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update email for Evan Quan
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, 
	"Ma, Jun" <Jun.Ma2@amd.com>, Evan Quan <quanliangl@hotmail.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll send out an update.  Thanks!

Alex

On Thu, May 30, 2024 at 9:12=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Evan no longer maintains the SWSMU code, it should be changed to Kennet=
h and Jun (CCed).
>
> Thanks for the heads up! Kenneth, Jun, will you send a patch or shall I?
> If you send one, please add:
>
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>

