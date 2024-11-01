Return-Path: <linux-kernel+bounces-392243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6959B9165
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09521C20DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881019E96A;
	Fri,  1 Nov 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1De2YMJz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14D1DA53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465808; cv=none; b=G3AEzMlLeEBPCI6OugB0aFuh/17qT8lRikqe8qyedBf2T3lUSZH5sziVyVjjoS/O6ToEpFYMkN7Qe29lmiTyhIR3H8mwZD1HSLS2f0AiU0o2fQSTKJcpinfif8jbS9QQGrQ5sTeX88f24NsEVoImvBpohyvPpxE942p/Qc46xjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465808; c=relaxed/simple;
	bh=gTqZJ827CF4psA8k3dkMwZbTk/mKzRLSWPTcMyg0Avo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8Lrq+M+XwSc6nKMHeGMO5NSG57bkba+73V02tOUdBuOesWpQUoyrMm4xfX6lxEtZ4J2cbqhD/WplUKfLGimjniA8hlWvL/v2gTLs781NGMp1yY65jLixmZHbioshX+fLhb5C3tGuT0CyzvXCyArrsiZAq2qpPnfM4Dz3zNaAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1De2YMJz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f53973fdso1797025e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730465804; x=1731070604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcbC5Kzt7xtHst+nDuMhIvjMwvrGD5IjyhOSr65wC/I=;
        b=1De2YMJzdYKid+RNL7Cq86PVqh5o3v5DIIiOsHT1aD1rW/jWs+hzSzsVxhGeGjrYUq
         rFUlgjqd6RUYrehxVRF/sw3MHMtuKGgsdj6C+IGqJVjdMunoc9CiuRTI7wdUdUOWWmS7
         R/o7BLCbcEIhTmPpWGowCICnn27JCeSczQPMIPeGl3cs5EeVvZQUd2hhM05oYrh9ruw5
         GwqYUYqWJHXqzzNl19BycPy7QtpY8/o3+g5P5KRC9UShevsDfrYo3PBfhB7uB67NahkC
         O1w02n3b7F46yJG0V7c15BZhugqKk4/CV+ahXoss57k6xcVyy2a7rwlJbDJ+j1+HkMp5
         WasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730465804; x=1731070604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcbC5Kzt7xtHst+nDuMhIvjMwvrGD5IjyhOSr65wC/I=;
        b=gXRN9fLbxGALdbOLKHQOsWDe37MsQGtMpXH2lFJBaEJs8lo9nJ1Q0iUiVRNygKBECE
         c9ufy5cSPDCsP8SO7GRepGv9AVmDGCvsLuI/89NWwINvIoHYFByAWAhF/1HBRYT7piHo
         Mit49B8jYMiPwAAkJDPOzB67xzwaS8WXBuKMluvcVDc/PIZbNt2Bz0ZZ+fHDE3VIMkaU
         gmBIDDo5BSMuCdKyqyDw1ArLHUr62lOxSMnPYvo7V4ZkRumXEsa3nhr6JINszym8N74Z
         aQJTVdu/23u6DRpBKWwzlbaxoU8X0uugPzgMCKBB6/b/i6LPiRzdFJUALkEETB7Oyedg
         fItw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1LCWLO7saHbiQ+R9tsAojwL9PFQiZLx005EeKyOK6Ilj3N+gvrBS67Ut4Wyt7eJNMBVrzxO+67vp4WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0Zm+RGf74EcwPUlAmCpJkDQ7KVFQNbXLyiZma83VZlTZycvo
	1z5Q8AqJGeQ1ttG3MzgtX8X+QzmwAvH45Fj7YJKMplUV54VKwICh0OoSHcalMLFH9xUaA3e44VN
	qYKpFJdh0lkhkBPxseMSkSgRW7e6iRlfOoX8OVkZRWiUr3XXC
X-Google-Smtp-Source: AGHT+IE7kl8dpN1cMEpI37NhROwIbEOKA+43ZYl20abHXLitFsMuMRydI+EPDonSAB1LVUcCnCdu1zofVeKTMG1zQtY=
X-Received: by 2002:ac2:483c:0:b0:539:e94d:2d50 with SMTP id
 2adb3069b0e04-53c7bbecbc0mr1946518e87.15.1730465804459; Fri, 01 Nov 2024
 05:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092154.2244728-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MeiZ_U0UoU1atWxyWxEhcKwUcCK_cbYu_p-DQar27Fw+A@mail.gmail.com> <ZySOMUs4URLBevtx@smile.fi.intel.com>
In-Reply-To: <ZySOMUs4URLBevtx@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Nov 2024 13:56:33 +0100
Message-ID: <CAMRc=Me7FFawu1wozyN5b9eLYNpaL9iOGLzdc4BAh9Ckw4tycQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate gpiod_direction_input_nonotify()
 call
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 31, 2024 at 08:14:56PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Oct 31, 2024 at 10:22=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > >  set_output_flag:
> >
> > Ok, I'll take it but please change this label to "emulate_output" or
> > something similar that's more indicative on what the goal here is.
>
> It's out of scope of this patch.
>

It is not though. You are already touching this code, make it even better.

Just say in the commit message: "while at it, rename the label to ..."

Bartosz

