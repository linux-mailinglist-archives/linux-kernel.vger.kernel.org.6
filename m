Return-Path: <linux-kernel+bounces-440078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EE9EB86B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEC28338A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727186359;
	Tue, 10 Dec 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kevnHUcS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873823ED70
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852183; cv=none; b=ROJv6IVqFjDH+nWKutruzl3bYqttEJF5TRrQI/Ipn5hEyQ4eTacTOXeY+eBTBvwwr0ziY39JB+GiJP1YdO7urBmtCt1PtqKp7g5xKZT4E1aloxEGllD8axgOs+LcG0mrzO4X8mFKIHpqHe8iLQLgdD2zPTX+Sx8LTNM6D9Jh51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852183; c=relaxed/simple;
	bh=uc/KoFq3rxskakYmwWPYaPJkb7ZU7MaZCt99tu8wRd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOYJ30aGqr79EjMMP4ytg8rYkogD23UsyUQtmg475li6BFKfosGzPDzQiq0AJDByWE1ClJqOaB5gv+ZXImR8sJqsVilL0MxdLESFblAX1E/dvYmb2UEnoDEwrar3ZYzrKfngKYAb6WnJ3G4KaMnXqSg8dH6UYchk+KekfPMRXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kevnHUcS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3022598e213so21020751fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733852179; x=1734456979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45GbkkO+PNQbehuwGVxBjmjUnYt/mkk4Fr5XHE7t0MY=;
        b=kevnHUcS0KRnd2UeIjzdrgtWlfYa7Jb+hVMRE476fsSqdePkGYmQr2N3MVBTLBIIo3
         UwD5tWHgbzJwAX1Uoyp7vVOGxco47obvgLDkR6LhU+ouo++2iaqU+rNwb7Dv3xbDUc3N
         5xMt6jhUg+uQM58+EZVlwwVlC1Ody8KqTh/Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852179; x=1734456979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45GbkkO+PNQbehuwGVxBjmjUnYt/mkk4Fr5XHE7t0MY=;
        b=G3SQJL6SmEz0NxmezsmLcJ8XOP1OzBagV3puiLPovNIegLDbKGDY9kXRHFq7jZB8cl
         +uymMRG8DQdFhGmHqOrGwAt8Tupcg4l9ZHpjYpV2uyAbdXa2zC0jdr3tZJcumMqqcBMn
         ZEdL36qbar1Sj6aUIIg/00piISEakMZjcfFevYn/pxB0CIk5QJ1F4yBatfo4Aahm+4Sc
         no0RFkgxko/M9ieoyAYAs3j1rhYX3ztczez/FZBFYxM0PJ8Q7sGtKiMKunFJ+QVbsWls
         roN9mWImFK110CvcWf3SNuqPMuuZ0HR8J+MhlRRA4/ojjv305Wox7sg84XD5J5Pz3rdz
         89hA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ55p7vsRYs2IHGZYEK0mlUi3wJroVrywVDAISY0XBcSZ3dJ0ceffyUk2K8IO6kHcRsC5vdfcD+tFkhzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NVak86xgF3GhXm9nqDXJ6or4SnuhlvRjtrYekxuOOBuVUQkU
	G0MJzQzlZL2dmhBrPber0XajP6B8F43kL285Ekh5wRCedeRs8W+7Db3n6kA7IcvhaWhfqxn8wDM
	87euF
X-Gm-Gg: ASbGncvv7XP/Py8RZz/W5+b5BXy64LT2k0zoJ9FiSgTKcJGU8gZ73/nKgEY3S18Irab
	QGqCDcpF2GXESffTkJlibgOOwnrgrrQJczTK+n1Oz6+hOzrOhbbDALNYDnVaa5U4ks9ooSyWEeR
	OrVV7g6RqjkUUhIE3HYJo1dwolSWM82IK34LdM460ZdCP3PQgUpSMwbCDlymoGUF0jwGTXwCBj5
	XsrQ/UXXTcXvb48H1khVETiGwnbhlSGza1qQ9E3A9MvLhzFGaha77s4FGuAED3+qNK/n3Aw4Kxt
	r00YrjJiSFapTq9icA==
X-Google-Smtp-Source: AGHT+IGVoVlG+DHo0cSxeai0f6Nwz+ViszBTsIB0GyJfy39yJ4OVYMfwbH0OQ85sKHToZnRdB6bz5w==
X-Received: by 2002:a2e:93cc:0:b0:300:324e:3504 with SMTP id 38308e7fff4ca-30240d5aabemr263741fa.27.1733852178820;
        Tue, 10 Dec 2024 09:36:18 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30038ce97b4sm12318481fa.118.2024.12.10.09.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:36:17 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so2595724e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjy6JtKd7zKJG7QkQtnpfqgBjTQALvaRmHndR/b6c/NoWo+eFwT0M3LIXKcIs/VtNcW+DzXlr39lYQkBk=@vger.kernel.org
X-Received: by 2002:a05:6512:3b8c:b0:53e:df2b:df12 with SMTP id
 2adb3069b0e04-540240d2fa3mr2349794e87.28.1733852177330; Tue, 10 Dec 2024
 09:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210095238.63444-1-cuiyunhui@bytedance.com>
In-Reply-To: <20241210095238.63444-1-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 09:36:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XtSiQayR6EVAU+eH2OWgoQ725pmC=XPtfhwNZJ=-XjMA@mail.gmail.com>
X-Gm-Features: AZHOrDlQ0t34rQtQ86IdACbaZNCbi2mb6QxoC5JN-z5bU1XuO2vC0qu6aI7oYGM
Message-ID: <CAD=FV=XtSiQayR6EVAU+eH2OWgoQ725pmC=XPtfhwNZJ=-XjMA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: output this_cpu when printing hard LOCKUP
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, song@kernel.org, john.ogness@linutronix.de, 
	liusong@linux.alibaba.com, joel.granados@kernel.org, yaoma@linux.alibaba.com, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2024 at 1:52=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> When printing "Watchdog detected hard LOCKUP on cpu", also output
> the detecting CPU. It's more intuitive.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  kernel/watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

