Return-Path: <linux-kernel+bounces-571256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FBA6BAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F6483AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF10225797;
	Fri, 21 Mar 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fMnk5s2c"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECB226CF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560984; cv=none; b=MCjeDjgtO0+80/OHPRxsUINzE20I6RNxRDgYSZ8eo9aitY4CacJGt1ATSSV/BgzklUviNxW5XSGIc7HWb4hpTCgmtjz2eQGpgQBlKTsEuBre1QEohiGe6RhyQ4AKJQKcNk17FDheCPnEJV19uPU13Ynki9hF9nM6KYihxW9YkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560984; c=relaxed/simple;
	bh=eBQn892UZG+jcWZElqAh1wPIVMeJ5i+Xu+1Q2pde8hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxFb8y4BxtuyhGqgZtEAUcSA+Zb22mShRgiqCdbi9ePMpvWPdti5h5yauZQXzPb68f8mdv4sTogfmJDyqwht3tBTwlalzvxMMlc7J7lv6GKxq29XVlZrnUFY8sVf4tbTn2xF4xNtrbihxcafJxydIMuAD4/0B2S/DCo14u6EKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fMnk5s2c; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bef9b04adso20727191fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742560980; x=1743165780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twviCGxAniHlC3WUcKtYW6Ox7Z/6C3imNQV4imugJhg=;
        b=fMnk5s2cYeSWsJq9AI7BdBlKtXh72hzsnhoBT6TaXHxtLYh4ulpF4vr5Mob06uWFPJ
         sbB1/Fch+EoJOkWdjntHrbibbKieBf7h3VU0mQMgNX76PrRsGRa93J0O6GGz2Tcd21tQ
         4pzkbeu+SEUDLobsYhGxXMD9PYtKsQaE9TSpmhpYUtmUDroHdsVj7zyDjbKkWq1CSDPj
         ISPnxfwb5nlpVAGHV1NttL6AGa9qMx745GrfSjXo0N7yi+HJG4sd5gEwICbIQlBi5CIX
         d7ChuUAXDrQrQXVF1GfoFWZxWIqFCyFY9Es9G765DCqQxW7BD4EFOCUPEgaGBxD1H7/B
         67xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560980; x=1743165780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twviCGxAniHlC3WUcKtYW6Ox7Z/6C3imNQV4imugJhg=;
        b=LVzqGe1ottzrafQLVc3oJpZIQOaIsMrfcNiucxzfrfzKheSd1m6yV8G+cG8T7GhaJ/
         PD+xV8GV/2OWHoTVONcpUzFPawBEu/muNu41WdWJU5gqZsZyvrG9o4DQjJ5QHVQH7/Ip
         C0jni0x+euba7+qXT/T2jS4coEu5el8m3TQrmGDu/mmTxCQI1IjuOn3N+ca/Dih6Aovc
         ZhO0F0WCCgGZysrUGuDFniBmLuSQ5gQxlzZ4JvhkgFUX1Yp65NOq53/c1GrZv8FnXLVa
         W3mqO8eR6xKjFk3Z/vDsPWcdJfo2jpKdZ0HobS8uCTLcUL3prFGptBMPz8UnPw8aCKJo
         KRHg==
X-Forwarded-Encrypted: i=1; AJvYcCXUzL4iu4EWGgNjbcDz/SV7sB8qNEaYKrCqKKgcKp20gLB0WPWKyVAs9vLgvUBJN4mA3fBZdpOVtKmluBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqkSFQ0bIfWNKGZl6PPNnaezUb1RJOLsRhS66hClc/EaFGJUn
	pTkiiM8G+7lvaJE+j+pQu2E1LQucii5idGcvt9tpBMVKk4z4yE/ojKnEA8O7qLgVfH5FruBkc+K
	MXl1hs1OrN6s0eXijcJWPfcC0LloiocqQv7ZOQQ==
X-Gm-Gg: ASbGnctyZvn8AYY29IO2t6odirrLXVOJ82hGFkWSgSV+Akqh0EySFgHjPZ/e8Wpe8ti
	My1Ug1K9nedT0qygoSdTMyp9GQvuz4Ba4Crg8PBVvGUC0xQDjWJtxiz0VnY23xT9tLAbF/6csxx
	soQ2Zr7vXdM5sGpxWc1UY3vWww6jQ8blRXCn+I3/vUAsLn6gTYavv35SvDuA==
X-Google-Smtp-Source: AGHT+IF6bDeViMRm+F3GDiSCI8KFfXh2g6OPn8L/1naZxiDI5aTUCMM4Tf4b22Rl4qKBrOf4W2YTckl4OUZpJhc4CRs=
X-Received: by 2002:a2e:a78a:0:b0:30c:4610:9e9e with SMTP id
 38308e7fff4ca-30d7e2d9f69mr12592721fa.35.1742560980286; Fri, 21 Mar 2025
 05:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-5-koichiro.den@canonical.com> <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
 <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
 <CAMRc=McpqUsEsMSfwo+WrzWdaW6YnMbptpj3fAoS-JfVhSm9mQ@mail.gmail.com> <oneoncbyv3iwb54kvjvmerv4xxhixgeqp44ubeikvy4yst3az3@g5c7uxgkonbx>
In-Reply-To: <oneoncbyv3iwb54kvjvmerv4xxhixgeqp44ubeikvy4yst3az3@g5c7uxgkonbx>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 13:42:49 +0100
X-Gm-Features: AQ5f1Joi-n_6xI1YtplWveFaMKn6awkhJ4yLQwNvEy4Q5RoMmSRTfRJNj-KZBzk
Message-ID: <CAMRc=Mfg1aNUQ+HeJurEH15+6e8dhmDS480SLOcmwOGP1u+iyg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs interface
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:33=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
>
> Actually I wasn't aware of [1]. So let me summarize: does this match what
> you have in mind?
>
>   Before this patch series:
>   * forwarder:        gpiochip_fwd_* + gpio_fwd_*
>   * sysfs interface:  new_device/delete_device + aggr_*
>   * platform device:  gpio_aggregator_*
>   * module init/exit: gpio_aggregator_*
>
>   After this patch series:
>   * common utils:     gpio_aggregator_*
>   * forwarder:        gpio_forwarder_*

Best don't change it in this series unless you touch the code. If you
do, then yes, gpio_forwarder_ works.

>   * configfs:         gpio_aggregator_*
>   * sysfs interface:  new_device/delete_device     <-- _Unchanged_

Do change this one to also use the gpio_aggregator_ prefix.

>   * platform device:  gpio_aggregator_*            <-- _Unchanged_
>   * module init/exit: gpio_aggregator_*            <-- _Unchanged_
>
> Thanks,
>
> Koichiro
>
> >
> > Bartosz
> >
> > [1] https://lore.kernel.org/all/20250317-aaeon-up-board-pinctrl-support=
-v2-0-36126e30aa62@bootlin.com/

Bartosz

