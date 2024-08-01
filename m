Return-Path: <linux-kernel+bounces-270814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CE9445AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A433284219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A022116DC07;
	Thu,  1 Aug 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r1slnntt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A712158A23
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497994; cv=none; b=gzkFvRrzRk/8Ohlxkrfv7bjU01+rntZo89fe1GH+huYSPhPL6MyXhsagYJVhlZx2nKAGMYSHR1KXdfQiQVvJXu1bjB+g+loumvjTQg8jufDiWmHiL7/nRmZRwhZcVmBTZ5FRZeEIHIS0mISekT5yKACCoR//B+TYFWdvBzMRJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497994; c=relaxed/simple;
	bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulhe+In+lx2t3rbaaZtLxueAgYR4zVgKRtRIALeVNxCrQ7Ea/TZ0+CqAt0hYjPxRjhosJodMmojAHidF4BMa7wfKXTz4hnv45ff8VHksWSbMtOSRt/36Tc7Cph0EkU2Ws8hajcHno9KmtUKNA1WGK6xo2UH2EbqLDoQEkAbcE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r1slnntt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso7856003e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722497990; x=1723102790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
        b=r1slnnttOhiEgMvH3qPcPxvnBJd8THdcNDevn8YoTvuJfBFYDvNcip6NW7JPsks8+s
         UcHk/jtaSgNd3CEcvB9HUrd0qmUxHIoxDP7mjb8pk1AH9+nnGHpwjC5ewYMrdC8MP0en
         X2AwsHObu9pYAf7o1Poo+4Pjggs+RxVnm6MiYekdR9QemPl5/eFwR/K8OmO75L9FNRvV
         tRAaK/B913sjFZCSgLUiZc8SwIB0BaPX4xZ/06IsN1WLLYViyFUtDzI8HwQAIvQ4qAVV
         cbf8iw8OoBI4hoqZ1zDaFa35sIUZ2mMqFyBMQPjb6XxCuqunQxsFFZKpz7OgQSWNhPiQ
         CWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497990; x=1723102790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
        b=NM0FE/kQ8ft8ftZq/Pug0Olh0MHwEVRZi+ik7tC1uUQWYvdlTBg2NqA1tCh6B8yIET
         CXr93ZtNmi7HBPHXFT3ab6x1X8f3GoJNPcOHGo6saSGLrAs2xWIv2ZlV+VRNqJJWbvy+
         U8p/jClUzJ5+wK76VUVb2IQKyW5DAn7G0o/NAe1NAFAI4dbgyFKBO0OxxB1oVv3d5tNt
         mVmnNyPQib9Yf121+xgL/Wd+32gikR7pjrFP8TAPy/V/QdHOsYhCXAzFPxu6oZU1rAxS
         9UA7pJxelmzOx7K5x1kGi3pERrjHNJvgzPqoQ1LLVrp6QVeOE5B4nGpQoN8Bh1GxFvnW
         uBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUEwKf3XKMuP3KD56E2S+9+QTz2mH1mYLp9vYMoO4UDJzikC77R13qyhL75to3SUGDWHcyI6hndsw6bM1o37U1bTs8/m48seESUd9Q/
X-Gm-Message-State: AOJu0YyHW8TTNMrIX2N13BYrRDdVCh/ybj+Co9OGoW6ZxmbGUtUfhbTS
	5668042ZGOW3BQ7EgT8lysj6aC4EIMWEc8yNJ8PkUy3wrAO/MT4FmOxpUrj8j7R1oXYzO3YZ3iR
	u5WvW3lkJ2YNVrX6U0zyUhs3w0BWTlosM/dVu3w==
X-Google-Smtp-Source: AGHT+IHo/b0qGpAtmfn+vlvLftSjw0v2BkRvO2zL+jmTStPZf1kPbAEkaUkfp3TLtsxLE8UjVR/ASTzdNGhVwxjsZDA=
X-Received: by 2002:a05:6512:239d:b0:52c:cc2e:1c45 with SMTP id
 2adb3069b0e04-530b61af38dmr1012927e87.15.1722497989787; Thu, 01 Aug 2024
 00:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org> <07a6df7e-b1f6-4de6-bb54-a18966efc26c@molgen.mpg.de>
In-Reply-To: <07a6df7e-b1f6-4de6-bb54-a18966efc26c@molgen.mpg.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 1 Aug 2024 09:39:38 +0200
Message-ID: <CAMRc=McCjv_2Ap+yb7gDOO5b1pqjRrNNegXH_mDH5Ao2VbVqJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Wren Turkal <wt@penguintechs.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:29=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Bartosz,
>
>
> Thank you for the patch.
>
> Am 31.07.24 um 17:20 schrieb Bartosz Golaszewski:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > QCA6390 can albo be used on non-DT systems so we must not make the powe=
r
>
> al*s*o
>

Luiz: Can you fix this when applying?

Bart

