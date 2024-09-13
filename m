Return-Path: <linux-kernel+bounces-328124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA8977F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E71C21B27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753371DA2F9;
	Fri, 13 Sep 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSW6/JPd"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B81DA2E5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228960; cv=none; b=ukfvzJZmE/yPUoj7RRYQG9Fvgjdlrd0ZzZgXnq/YeDPzTM7rhedvwVEqGf3GGTdL8qQRWsodobnwdWG9Dc3v59p3yIheqy5bMNzFVgDHr2SxFRfxyQWu+aSbVEaEFslpFPWfEsDGa2ElAAiYCUffx3RTTb9to5W6GmTfoO39JtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228960; c=relaxed/simple;
	bh=WJGCx6i8v72/tO4OLrJlpsz+OdDbw91LWPJWIc7jdh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVTdARUGw3mqu+JOOMfCx8KmEAe0rTAxFjmZgCmuvaiWhazDbrpR2cJaj4o2PUZaWyRpLCbgyBeYZkiAiGIZzxfmjqvKgLkuRs4Zn5cD5bFP41PRPhFE51zbX9Xu80HydvkYeuk/uNJJebm9tHr/U7YQ+gnjTDzBdXbyGJ3CZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSW6/JPd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so868525276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228958; x=1726833758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2EMotPu+SsnYPYZCxsQEhILLifcL+u+4RLDmrhDotzQ=;
        b=dSW6/JPds0DRcfTqyndSyrxbOxsoIhsHrSntNaYDLJWHnxlgZ4qHIxJQZtW/xwOL0K
         zgoGP304MV33xn5SRBUNHwU+F5gSUaykCggy4x5m3cV8TaGhaI/JLuiARCFFXeHVXPdD
         JaJuglsy+MMp27PJh6dwveJSa5RmCBhhx1P8+HHM+fl7sYLfGYbThH52MVe3QDyB9WDF
         mmBeaeV7FEXFk8XWmCEelVJ7nZvjI5ac5vcuYPS94gB7/zsVpqvyI8V5t+5r4ux5rT9z
         BsjuoElpBHsGmk4Ms3V7EpeL7h810Sa3r4EmSLggm4Vp/G9nihPDv7JQuCNSi9uWPfZ0
         xtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228958; x=1726833758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EMotPu+SsnYPYZCxsQEhILLifcL+u+4RLDmrhDotzQ=;
        b=FUIw5oOPZp0elzjyD1vyKBpdQZxvsUbyjvYPByp6jdWRd7CTA5BGiPK9eOiZL3W/Be
         nhFB52mgCKIY9MlFNcunfm6RRgwBZef+7ghvf8ndYWxSTEvqTPKLFnTcJ//r4EoK0GOB
         1GXXRBNQSSMMcWZ3MTuAeehu9w078ajmRUdL0S1lK85obiDC6UR98dJIXLpcc2HPfWY2
         AZi2O029IjjSU940tkf08zJGO1grxRH+6+JdiSbaHX1Kf2L2+O/cY64Aa8rGzCDD89x1
         P6Tf2JOUfRxkx0Cgt9SIm0UQK0lX79CPkIL0hjq+KfP+r4npSwhiifCnAYq1CG/N74Lz
         caFw==
X-Gm-Message-State: AOJu0YxlICCvhVh8iiB+3A/DsIOsa75zcl9OVc50B6VBqe83md6PszuT
	/OIrg6jvkxC7GgpyGaLJiREok6drb9FIUiiaIe9d42TDvCURiC93wO87JJxEOey8oJggIJUjPs9
	zzRnK1h3xixnipsXtFJkgbc89cZTJgDhUCdppFSHvDtF1t0ge
X-Google-Smtp-Source: AGHT+IEmYliY4E2folPA6tK9YT9mUZYVhyxJSAMt263ZcnxuojEhH8f9gYxBDVwC3jIeAmLM93D4nNjDl4YbjAmXemg=
X-Received: by 2002:a05:690c:3343:b0:6db:98ad:86a with SMTP id
 00721157ae682-6dbcc593989mr21037947b3.40.1726228958446; Fri, 13 Sep 2024
 05:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829202732.75961-1-detlev.casanova@collabora.com>
In-Reply-To: <20240829202732.75961-1-detlev.casanova@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:02:02 +0200
Message-ID: <CAPDyKFr8x3B9dmz1fOCOpovhN8CC=187Rtjc+cTEFKN3=U9OmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: rockchip: Add gating support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 22:26, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The rk3576 SoC needs to ungate power domains before it can manipulate
> their status.
>
> This makes to to ungate the PM, changes the status, and gate it again.
>
> Detlev.
>
> Detlev Casanova (2):
>   pmdomain: rockchip: Add gating support
>   pmdomain: rockchip: Add gating masks for rk3576
>
>  drivers/pmdomain/rockchip/pm-domains.c | 87 +++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 21 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

