Return-Path: <linux-kernel+bounces-426372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7199DF245
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FB328139C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE101A42A5;
	Sat, 30 Nov 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhahCId6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393381A08AF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988182; cv=none; b=V3Fa1GizWPAprckFBoenE52ZSSbEwK68vUG1u73nZHTUtjOsgTuxr+aavmyUT+7vLyzd/4Wa2Gqka/tencE1ZozZhickdeL5Zwcwi+e9HhIqfFnY+YdOFA/cWMPTxZpAaz3uyh0y+cN6FAwUuEVCzigwj8Ks0B5UsHvpPfMzWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988182; c=relaxed/simple;
	bh=AQtCMX1P3wuQKwqtdH5vvu6PcvnewkPo/PRrzUbdMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrb+Mav6plJ2Ruiuo7CTEMLB0qpp8eN0is7uHH5FP8kMHif1syVixrukuNXlS0MhGVgcWSkQPtsgmyOMEUDPnSvcvgCqQzS8IcZYpvVNF63Y+BgL/lPEUGtUZNzNp+AOWEDYc3YdujHmVdQfiO4nXztAq60EFtFMMJVSTzWI+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhahCId6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee67ed00deso187606a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732988180; x=1733592980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UF0Pi1PE/BcQ6VB5E3JMrfTk12v/UWV0vf6/DOiLyA=;
        b=nhahCId6BrKvqOrR9KdJpbPE9V3wsU5cUl134oW/cXSaGKNHfni525yvjEhRKiIcr1
         VRtRK+UXqebMKBkuMJAp4NWqggGMRBepYERCZevxRUWEY0/I8k5gBzK0Gqq2oe516Dbc
         onQDZAgyKUmGkzcLCEm7i5DQIEJKIcv+tMKjrzTSWoKZwxVUt54lrEXYzyupSF52R8wW
         iFHi5Ycaa0QSLVTQDfGWNzKiYWWlPgzAwJFsLObvlHgKp7Mnfmi7cqb0aYudylbLNRx/
         tXFr6bd+64xT3snDjG1rnsfV5ecqsqgqEIFR2MheK0mJRDWzNy+dCzREZHxgvOxt2Hci
         ygBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732988180; x=1733592980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UF0Pi1PE/BcQ6VB5E3JMrfTk12v/UWV0vf6/DOiLyA=;
        b=bE4Zgyq3lndEWvmxSTJh1hQVMhnRbaGvnm8vJfZ3k8OopEO4JI+okO6Qi+egF72vPM
         vVpnaYg34lDORteghIWf3D9zpwJfRME6+z8pw8GzXoddRT3TXlgxeZg1VWhoJ7vL8LDR
         X34qEOlo6gfWcPdNMB3bXFuynuZNPzgBMWC6+EPy1XFU2ZZnGUpHQgPPwDzRBhmVErX9
         hUIfYfUg5dggRoJGyDPXM5rsfG1/VsIs0Xm3X+uPJLvMOekWDPvG9BL2Xh5jKvPdAahD
         ZBGjqYtzMK4Cif/u3DTf5biNW9VldO+tu0vaDMimQK/FyRY0QPKFTZyqNLtWFX8hj1RE
         Y6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVAP1OOhKIb+PbStfZTlTu6eSAMk8HGHOT3p+Lv6W2C8ZMdGJP8YmjJ1P7v2TXxW4ZPePEo2yLvjIXo6go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuH2NSqZpw7d9rTSW6opCUsQXEviyS+Jleab8r5sv1tuVSftQu
	5Xgkg2gEsr837VzCeBZ+PRXTP8BbkzPKb70My89ps7wgQdvv8lqgNLbKt8JIxotN9Nsibbnz1zq
	s9uTAKU076afU67cQkTA1Ftv6WaQ=
X-Gm-Gg: ASbGncsJoTB++v/NLBx+PbKL03ckMkJLktm6ZiGScfP6Duj7p6GWnTiz0Nkqt6XYptq
	cLfqSyqQ6v/fqpBCj1fTzteakPpFjsR4=
X-Google-Smtp-Source: AGHT+IHjDjPuXgiT5nYobtFnyRHsG/CI5leBl3OOLOalgUbIGJCJb7BQUZ14dPwukULw/xWFO9WScTJIEBHMzNuUCTk=
X-Received: by 2002:a17:90b:3b48:b0:2ea:5c01:c1b4 with SMTP id
 98e67ed59e1d1-2ee097d02c6mr8459880a91.5.1732988180531; Sat, 30 Nov 2024
 09:36:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 Nov 2024 18:36:07 +0100
Message-ID: <CANiq72kqMmD1P_2wjL3xL2ot9+3MzcrrZH1Jsw6Tz+m9A3z6uw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, 
	Erick Archer <erick.archer@outlook.com>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 3:57=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
>  drivers/auxdisplay/cfag12864bfb.c  | 6 +++---

Acked-by: Miguel Ojeda <ojeda@kernel.org> # cfag12864bfb

Glad to see that journey finishing :)

Thanks!

Cheers,
Miguel

