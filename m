Return-Path: <linux-kernel+bounces-357422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F18997118
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205101C21E15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB5197A77;
	Wed,  9 Oct 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKW6Ou+W"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A331D31B2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490011; cv=none; b=pd3ZwdgndBCIpSZwW93I7FFv9HpgvYTyHezMO3s5w3UGCBOSODsl+wHBe5GppG7CFdvCr2G5y+ZuA+KAkNxEF7+OP39K4DNY4Ncl8Jg38YWW75MVBH1pxy4iOXNH05TUVVeQEAU/0/uo/SKca6d+ZF4kuyrCQco1PSLmzuX9p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490011; c=relaxed/simple;
	bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD9qyE6IC3xGzDsHbbBBgQ2DjDHh52N7m5IEoRTFUNYijgqSQhHkNCL0FQWo0NPt56Xg/6MSRBUxCrASQ9ABgRowUFZv88PUXuGnMOKuCDF6EMeiYCzYci/dtDByivFaw79y0/0abeNuWGNFwHWX3J5LIIJUz7duYt//mAUFiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKW6Ou+W; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e23aa29408so10468967b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728490008; x=1729094808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
        b=VKW6Ou+WFI6CYLkbWHCWM50aVe77PG3KQEyt7XEV88psUHzfK4smhXKMLRfyvx0Vv4
         FO8gUno2MoyDAT0p5NqE+Il/RHEfSSZRDIqFJAxLRjeEEea3sxC2Tot2FoLTsay++34h
         /FNTNWoUu2lNR1TY+d3CgDhreupc3NbWoqQTtUdAiPMjHLGz7manVa2Hlluzc8X+TCWZ
         Kbcd6Jmqp7SLz2s8ePMxjip9aI0UIDyA3AlEU7OxP716YkQbFwPj1Jz2J+LLqrE6Rhnp
         ViCtzrIw2L81FMMuQsu6wHgfp6m55erNcq6G/Cw268SSlBul3uktkr7HO0oWBRFKq7yf
         Sdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490008; x=1729094808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkfcKspWQ8hexMjCW+X8wh5gyfzaCeAToCi4rgQ7REw=;
        b=v3K4qMLUpDoIVbNePfVUuMzHZrVBXZtaoL1jcBaREBDBsD6aurLLNWGNfTBk+hVoVC
         AGn8lFwy07zk0KXKG0AIQUbkyrO3swlz7vj0GBhekgNowZ4zm5ZWKZe7axK2qHIj4Rrx
         QEZGxnRpaoG4q8f4lhCdjK/z0/TDtYGfa/OlEYbIifc1HeSfx65cF6JdVlDRLXECAYmE
         WySPcATA7GX5ndP9p4EH93RDMRS8Jn0xKzJYSxN/tAihfoBrLIaIslSEzSAPV8pXXn0T
         +KWpUBmOH+djColdtc4D8ULm+PDwpBcUfG79+bhgDalyz39RsncFnWZevLT2H0yZIS9p
         Kmew==
X-Forwarded-Encrypted: i=1; AJvYcCVrd1RXylE0D4zpOqI3tAGZhDGXpR3Iu4p4IEsGKgXB//KLU2k/IpWR7E7hMo1ehABvgdrPHvS+otI51Po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3p6R68kodWIIPJqp/zbwRh9U163BQPp3J12aSQgIZ/37t6oQh
	MazuUL677vt1uVsH0ijFcFGG8ZdDWi+mhE6hFz74CojvvrcNwmL2LxQSELGEBwZM1NYbMajRObM
	o4ydRJrT69N7WVAF55qPvtnXRe6PbCdlr0GKngA==
X-Google-Smtp-Source: AGHT+IEB7615ehnAAzSlp9QeY7Exo9QxBnJB+eLgmqzfktq+2EhfQ1a1O+UY0RdpmmKJABEdhGOUsHTE88vgiT+tHak=
X-Received: by 2002:a05:690c:f93:b0:6dd:ddf6:90aa with SMTP id
 00721157ae682-6e32f134e85mr1925237b3.5.1728490008640; Wed, 09 Oct 2024
 09:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:06:34 +0200
Message-ID: <CACRpkdZtUHAaF1cqmyJcthp=6-w4quYAF=PMdknU4iQZ3_E-Tw@mail.gmail.com>
Subject: Re: [PATCH 0/7] power: supply: constify ocv and resistance tables
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:

> These tables are nevery modified. Reflect this in the API and constify
> the table definitions.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

