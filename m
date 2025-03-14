Return-Path: <linux-kernel+bounces-561170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23100A60E44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6714717166D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817911F3BBB;
	Fri, 14 Mar 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHhs5mqq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14C1F3BAC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946984; cv=none; b=hqtP2OVHczNTfcOWGCx2KE65cSQR5NH9LtdBMm9xzbX8XEujLywFBcWHm6se7l651B97jJx0yOCyuCH8kABcJqKh8ZhqvpmniIBWWGy40+vitG+O2aPsxoYShVsQwYf2ztwHSnHpiuUbpq9n30zkuLpptQmPC+mWmLAku0en+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946984; c=relaxed/simple;
	bh=6NLADSkDarLz7Z7OYmqQfLe1SXOFojqaV4Wg/1X5Lvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV9RiMbggieO4VwH48WIJJI+gqnfkFghtpNLTzjegCyORsGOUtRqxeE3D+r8RO9GX35/hsdKS0GtsjgTVd1c/1NHU3FSGaTP9E4dvxd9JeCPHSy05Pk324R9seTtu8kt9rmq7oMcJ7x9y+3aEgOAAiI1+y+Vc14XisgwpBdr9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHhs5mqq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so2298570e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946981; x=1742551781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NLADSkDarLz7Z7OYmqQfLe1SXOFojqaV4Wg/1X5Lvk=;
        b=oHhs5mqq2fAT7GArjab7dflnsobFJRwf+a4nUMmzBM7ZiS+/mz1U/P0jeHu06sw1eQ
         3IfYCJwvUuIxNmZFDlyvvydnEycNuw2mKgjxUVduy/KZIY/4eOrUJ08dPq+j6BZtv3sV
         fxFZElRkyulJQT6QmzBd2RFot9AXY4wiN9/1QrpFuf3t1WX1wD6OjgRtrlDBX/jlSQDN
         spR1o/lPZa6udtozmEnwB90H+n0R6ZP0hrcaFjIxsSzApAkLBu7TluljiGERrxY6beDr
         BER6x41h+u5PWwt+hvYlJvrzvQeH/9HMrQlJEgUYFDUOtMNSEX4VCA3NWBbh2qj8LuYq
         aegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946981; x=1742551781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NLADSkDarLz7Z7OYmqQfLe1SXOFojqaV4Wg/1X5Lvk=;
        b=o2rTdSCzm6wPgw7JAMJ5TSnF+Bg1R7H6WG/PiPpAjrK2iujRsPkZhAVpQ4/s4A/lAI
         TatW9vvmUudBtRw360gvA7exdP6ztbYryN90Y8IprJzN/QhVD+h7JjOxjOg/TMvxt9Rs
         AzHMO7XGsypXGhpYDChLD7gX8LlPh1OqBIY++qgcZmLxz09fqBzd3xTuxC8vr1u8uPza
         z06y8cb6r1wrNVWUU1W2tygmsyyjKn/MBQc+lwkBSljTS0vgLkhpt97uo0kjr742YHGh
         Gsny0Nw2VY7mjNmO58viNoHpzNw0dhAKtdvp5yFZMhyDpTTWtL60P2X5Hau24//63pdV
         LaKg==
X-Forwarded-Encrypted: i=1; AJvYcCXYdnJ3HmRuLKc9wgKHugF/t+8piol/dtW8Om+JVgIRTC+zdpfBJ+5urbMdQIpY8rC++rKRKFf/BSh3JTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+AQb6u1N/j1E/boWf+eQhooXq6Vb7MPIPxHWQ7oJej7IujLM
	Qyf6F1PVXIxhhG+C2pwdVt+zNxN0EoDy1Tfe3IoigMctYEvSclls6nDlbuvFwy7WugnWNfgL7pK
	R+daMgEbYUkd6zYLGoAWOs7d6s/bNhJkHSUVtgg==
X-Gm-Gg: ASbGncus/vL2PS/fpCvnQYLEqAbFJxnz4gerChTM4+AOsCsTfbm9DPBnCJiTyHProFs
	2CI69EaGg0xSf1wf0aayiSkU4W1e847RZhs3ZYNBT9sxlU3MILtEIGwSVVSVNPpI54KuHeL1r2+
	kxNO/Gg2H0D58CGhgeWap4F7M=
X-Google-Smtp-Source: AGHT+IFjiYsqF6Pyqe1wUFWI7nyyxGuJZBr6f+0A/76JcjtNSWdMzHbLZ4PSj75IOQgpIEaB5uAMo8Q1EAtsb4s/3C0=
X-Received: by 2002:a05:6512:15a7:b0:545:2cb6:af31 with SMTP id
 2adb3069b0e04-549c3901b52mr686120e87.15.1741946981009; Fri, 14 Mar 2025
 03:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306-gpiochip-set-conversion-v2-0-a76e72e21425@linaro.org> <20250306-gpiochip-set-conversion-v2-1-a76e72e21425@linaro.org>
In-Reply-To: <20250306-gpiochip-set-conversion-v2-1-a76e72e21425@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:09:29 +0100
X-Gm-Features: AQ5f1JqxL5-Dmf4MU338rvb42G4-CrTDhu0nskqF0WrCnFLpk_ifBnvVfk6zV9I
Message-ID: <CACRpkdbUJ_XEPVf4dXp3uHEaPPiz=E=hguea5RUhyfwkdn2U-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: adnp: use lock guards for the I2C lock
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:19=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reduce the code complexity by using automatic lock guards with the I2C
> mutex.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

