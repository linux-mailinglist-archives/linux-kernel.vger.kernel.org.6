Return-Path: <linux-kernel+bounces-240690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A3927109
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1BCB21A52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0219DF4A;
	Thu,  4 Jul 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fJiyy4fm"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053D174EC0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079868; cv=none; b=RoTW+shO9rC9vTgjZsfMGuW6QOQtSHgjd89fyOV0X9gFX29LYB0ZFDxiVNEIZJ2M8gUGaLElUHcrmg8p/ni+y1MSuxM/rImfZDfifCrVyoX012h++jt+sWaPtxeCGsMTPPSbvRfa8/xZ5NMqT1iiA130nQGiI+ywosgD1PZ6wFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079868; c=relaxed/simple;
	bh=8kDMT9EBYm9HC1LZq4DHZqjchUB2docd4HQCzcQ6Qlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtPt0sgjGjvVS+pPWSXqVgDhU1gNGEz3X0+HtUO3A2bq32PzLmZ1SMGLPL0Db0P56EqGYtPd/o0GqZB58a+OAMnv08EfUtPOD7L98Qb/n02xoFCWjJwIHeJdPckE5uKeLsxa1gdbfmaaoqo4+Dx1YBXh5Q0tuZHJ9osBvIV/daQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fJiyy4fm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so3465171fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720079864; x=1720684664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDMT9EBYm9HC1LZq4DHZqjchUB2docd4HQCzcQ6Qlg=;
        b=fJiyy4fmf42yluCMlIfU34kaCRi82eIL6UUBnVofh+NXQ/2Xuxpt895xCDP1nbhmit
         35Aegw/kHqY/Nqq1bcmnxSvnPm2nRIqcYPZcLNTnTF7YqRAP1LiDzoIou8b7IX752rvu
         x2XElA1DrKn+v6oyzQim4qlEXQCAemqR55NjD2P4w+P+QIWKoeVwpCq3sabieIpagCtX
         XZitgydW82PW+V2faUkuSA4gW6agGe7SzfgUMAbkNlAxxeubLO8KJVJcffrlWladMvDE
         d+58p7d5j3CW/jb86gpPHeJq9+peM3Jvc3TFjV7IUwUJrGmXHxBWQegZm0sfxEPO/R7q
         hT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079864; x=1720684664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kDMT9EBYm9HC1LZq4DHZqjchUB2docd4HQCzcQ6Qlg=;
        b=ljNpzVijZPBBnVPogZHWtOUXGyummyoogJThE62JU3zoVwuXkDrdymx3BpSxbH7xpG
         Zag2kZ/cAqP4+wKBo3BQZ++wMyqb2U3srde1fOf35tGTM3jccU8qjoO0RO7RtOdJjrTW
         bTFlTsY6TUcLRBLoX8X6BcxDtFGWgT0dqH+F/jWJXi3vVo3DAYRQP4UmpgX8OsrJjqEA
         JWeEvrJY61zk+fchoDKxz00IZFEHHRIra7ZQBDw4U3DC4f4S1cKb4oI6L8hLkhHsVpYr
         uujdiy6kPsG+vktuWHWuo4HZd9xBzxDuqUoSPJzfHynu5oIkrEjngUHqz1niFh10FW5m
         dS9w==
X-Forwarded-Encrypted: i=1; AJvYcCXA9aPrG10RWSS2+0HzDWldnuvAevpmtCG7Yj/xfCole6lMbKSy9pJNQVsKU8oC+v1ayNzORvEfzD5sigqXAN6qUa9bH9fvLlyB7q7Z
X-Gm-Message-State: AOJu0YyczyDwJnP88O7iLHxSq8lDEYFrjvyfFSYOJpACGuFykiZVJYpi
	bzT4jba5pigWswU8uqGQiEbbs6SLg/p0ozGJ3Gvd/Ln1vTkfo781lwskg/jJuZuI3TiidDqIfva
	de6SJnauXUL7Q/8tUdHVmWJiWD8a5kc6lHWHA/Q==
X-Google-Smtp-Source: AGHT+IG1wqcWg35yvJEx2/20Ma4xVBOJwLAVOcYMZ4HlosRwRg09Ym1gzUAGNNPbS1DQb/Q4bIjU2gdwVStnn2k+THg=
X-Received: by 2002:a05:651c:2120:b0:2ec:419b:429e with SMTP id
 38308e7fff4ca-2ee8ed3ceffmr6724021fa.2.1720079864457; Thu, 04 Jul 2024
 00:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627115112.25769-1-brgl@bgdev.pl>
In-Reply-To: <20240627115112.25769-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Jul 2024 09:57:33 +0200
Message-ID: <CAMRc=Md+j4Ah0sOzKXNNbDdF-YBbVyKsiZa+2zSbmM+5Zw0uzQ@mail.gmail.com>
Subject: Re: [PATCH v9] gpio: virtuser: new virtual testing driver for the
 GPIO API
To: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 1:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The GPIO subsystem used to have a serious problem with undefined behavior
> and use-after-free bugs on hot-unplug of GPIO chips. This can be
> considered a corner-case by some as most GPIO controllers are enabled
> early in the boot process and live until the system goes down but most
> GPIO drivers do allow unbind over sysfs, many are loadable modules that
> can be (force) unloaded and there are also GPIO devices that can be
> dynamically detached, for instance CP2112 which is a USB GPIO expender.
>
> Bugs can be triggered both from user-space as well as by in-kernel users.
> We have the means of testing it from user-space via the character device
> but the issues manifest themselves differently in the kernel.
>
> This is a proposition of adding a new virtual driver - a configurable
> GPIO consumer that can be configured over configfs (similarly to
> gpio-sim) or described on the device-tree.
>
> This driver is aimed as a helper in spotting any regressions in
> hot-unplug handling in GPIOLIB.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

With no objections, I'll queue it early next week.

Bart

