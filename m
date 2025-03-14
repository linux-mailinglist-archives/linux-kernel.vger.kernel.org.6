Return-Path: <linux-kernel+bounces-561236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06ADA60F13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486133B16EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC81F3FD3;
	Fri, 14 Mar 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UX/9XGJQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AE1581F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948536; cv=none; b=UvDUWjLq838KtdTZBluU8gAuTlD0wU5sM+KMS9I9NUX0JzWtcr5xgfbUW64gmZRpugkJJhFm7u/E264r3kSfg/ZpG1P5Ah+CdPRvmKOLk3sBPfVeebET+3mmSdiXHUngyEMtbgPhxpaQ8eZkivGQWo8ZjBwEWmHqoE3+op30Ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948536; c=relaxed/simple;
	bh=byp0CMONitAS83Z+cofs0zoqBUKuIOo2HHl452cNy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcw/fBNRDD4T2Dw46qiKWGTVCcHX9om2XyCz8xOqp7+QNd1lr0VDgcc8MoCE7X+gNQ77Le4aJFIz9X5NStwQwv1gGzVDmwKCVKAA3S1tPS6D251ry0cBs0xeyDiW0ySGXNdhhEXaIyY02UBhT17ZNBE+RGicjv8aILTuOJepZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UX/9XGJQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfed67e08so21179601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741948532; x=1742553332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byp0CMONitAS83Z+cofs0zoqBUKuIOo2HHl452cNy7w=;
        b=UX/9XGJQUW2crxkYTjxrGqcXoM8pEebdnEb2H1RPSI8o8aN4TXVoEvdH7XvoASCpcC
         3PBoICaexwlMgQ22NBV6R/E8dGv7MtHKastT3I3fXqgFB9oqC7/09rtVZySq2KxVGDYV
         ENe/60NfeLQkeeqs7TPNdAsZi6z4U/smDf2UUxk/jV5QyXJLPjQ7sICH/H3CKMqGLemB
         QolHUWXt5aY7mO72gOCnkDIgqyXY8xHiGIddIuMCNzCFoFIyPi8FXifMBxnt6WNeHSPG
         rczMF/MOzX+RLqyzEeo7t7O883z5qoJNVE3M9hdzMLBe6xFSEY/BKJF6pWxhj91KEVFS
         sc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948532; x=1742553332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byp0CMONitAS83Z+cofs0zoqBUKuIOo2HHl452cNy7w=;
        b=EphZF5Qwq8T24UfrotD2r5lVET0LJSEMww1ry+TB789Mt1/vgt8jh5e5q5A10ZAwWq
         px4DbmPtjz7X0wtVRrLnjs5IzKGsZv6Tp1JRyWUQM6Oxg4VWV1FdXkP0eti4XG3TRW5t
         yTQFfgpTLPy+e36vYRD1blqjRIvr7KtQFAx2vD/aBBpXkW1MJ120XW1NTOuURxVpuEOL
         lBx/7Z8OOwa/4vVPVnuvzj7BU+RNDF9sOLV+iCe6qfIPHSjEyPbajNJt0Q48pdMokG+4
         fnvHKChQynvFgrxI9rVlA4Rf04maMeZtBzTQSpaArJcngrITq9rbU0r6YjiWrnULIbPQ
         /0+g==
X-Forwarded-Encrypted: i=1; AJvYcCXgrDadLFL2L+jySoDKTW5AjQ44zUkwQazjokiMterhYO+xEwW4PE0lOl7tj2ZA4H/5N6smPqxdsXxfoLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuEnlyWeV/B5UgSz7hsSY5/mi+BopzIDiJBeWhNGNKkgM1j8V
	0GZNkGzffQ7dgNuvos4YdfSzwwh6+MWs91fxP34pSWhljSqzNgVN6Tn94D7f5FbAxwE/GxQ2nSr
	dPITW1x+tx/0u2MzoSY/wV+4YqcxHWTRxV2rxAQ==
X-Gm-Gg: ASbGncvs8quWD5Tp1N3p6EAhJE1FtMhCUycYqh/DNqsChXAFd81nvCdbkJIxEBBfpVq
	83WNY/Ni0rW6+sNeZYRIUEUbSae27xkCWWrvKJREYwlUf2AfEqttj5LJJUZlJmxSAdQAirnPJBO
	ZQZ87KPDW2HjImbGTRf8ZlHHUkvYlEL9fZEZ/9oEHeyqpMKpFYWFc3JR1j1Q==
X-Google-Smtp-Source: AGHT+IHNSwbjzbuzRPAiJD00Jt5nD26NtrsgQ3Lc7gQxLhe707fef4I+GVhiAwy5zJX0S/yQtbxvirtc4ueDEeSIyFY=
X-Received: by 2002:a05:6512:ba9:b0:549:5b54:2c77 with SMTP id
 2adb3069b0e04-549c3924ecfmr680660e87.32.1741948532345; Fri, 14 Mar 2025
 03:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-gpio-set-check-output-v1-1-d971bca9e6fa@linaro.org> <CACRpkdYujYhF8VP-_6O4Bt2tWL-NO-GgQPr=DeqE9QwCq12gqg@mail.gmail.com>
In-Reply-To: <CACRpkdYujYhF8VP-_6O4Bt2tWL-NO-GgQPr=DeqE9QwCq12gqg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Mar 2025 11:35:21 +0100
X-Gm-Features: AQ5f1JoZTZzrHSsu-v4vWCd9D7G2LfPqDBPbesIa9dWZsnlLy03UiQNrMNRR14M
Message-ID: <CAMRc=MdwQZMDaHn15n4zgCujtDRg=UUwz3A9ZUYY9Uv7FFgz2Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't allow setting values on input lines
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kent Gibson <warthog618@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:33=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Tue, Mar 11, 2025 at 3:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Some drivers as well as the character device and sysfs code check
> > whether the line actually is in output mode before allowing the user to
> > set a value.
> >
> > However, GPIO value setters now return integer values and can indicate
> > failures. This allows us to move these checks into the core code.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Makes sense, if there are regressions let's smoke them out
> in linux-next.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks. I decided not to queue it for v6.15 for exactly that reason,
I'll pick it up early into the v6.16 cycle and let it sit in next for
several weeks.

Bart

