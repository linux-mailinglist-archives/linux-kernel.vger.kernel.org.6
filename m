Return-Path: <linux-kernel+bounces-556891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C5A5CFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA02A189E654
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE182641CA;
	Tue, 11 Mar 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KZ7s4Db3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1344217719
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722636; cv=none; b=pKrBptBmcH2Hy2eukjULH5TMR+a3YCqZUmjO2xicLVCDS5Ccto8kufgU4jav442FgS0pQHksf+DxSMcCeeBtV0ZKvzDV+ZgH0w3k47lvcZSrYLPTFeBZR1qfHUnCIT3kD5XKbN35PoQzQjgqe/8mkuz24xN+1BgZlbvbwSlW7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722636; c=relaxed/simple;
	bh=HBKTIcJdBDO7yrFqGw1sqxIWrbOaXehqkaEPlSp2hVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0JGDJWfhqQruLiYLeV94nqCIdjvzl/yI/V6/XkafuJDckFc+dMsxFm3t2zeGMrOJZFUuSySg9ocizGQVdkvOWbcupaUmtZPrn22gotGRr2Zh6ritAdZNxZEGCet0cHdXR4QHDp610pU/J62nRTf9MhbJOtB6gUqdTk55DMvTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KZ7s4Db3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499c5d9691so3445894e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741722633; x=1742327433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq/JcpFJHDUT1Ef+/IWGp9CZQdsUBpGs0X2x21xxyGQ=;
        b=KZ7s4Db3uOrggZZcVh3LgOEchZsQEBdmVx+gw89X7PPW0Q7akXTMGU7QV5oC3wDog5
         g18bC2bQfG/YLuPYQVmNA2S5wuwkneqjjP0xiI/bKb+wASaFfnxXFVxmyd2dgeaza/OZ
         qh/SEiHC+tYjE8KEvZMyE6JB7cXFQcd4jugXNI/mijxXLPJQHHNd73D9j2lKo0+wsnkd
         91EJvteARRa7O2UK60mVQ3RUKwUkgHSFmbDpBmk2IcRxVfYcD8HwLufMuHGbjDHgg4x2
         pXqAy1xSg1PJglvhWB7cWXapbm3Ipjr8P04X0EC30LLSGuZTLZ0/lZjZi7pXQ3o9Bgxo
         ZXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722633; x=1742327433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq/JcpFJHDUT1Ef+/IWGp9CZQdsUBpGs0X2x21xxyGQ=;
        b=XXsWMq1pfnsYs80LkNY9tE06CD75wXQYqfym8LbYmnmtl/Zteg00+lLxibXXGb93Y0
         QZf5QrNufADidqyxT52g06KVwNfnHxZMeFp1v6Y+4GrNt8mX9r2R6myuUBaRqP06L+HR
         ugprUXbdJVjFM7ZhPiFxlpK6vCGxlO1/ixLwS9hF8kzuWSTLzNU3ZlEQZooH3dQFoMTt
         KwuR2AqhQHOZ9V/9o8M42cap1axIgAXYY9uh9ao+n6OqNvRMaAUbpQnMLLebUlNng6au
         yTRdD1fhrxXDB5UVU+E/vHDweoI9ssBsahr3FpalR2UYC+0+zvQWiwKoodWu17hEi/Dz
         vKVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmWTHOFKkrX43Jy3DzpMhN1iPv2+GIpfkdDR5M7+7ILsCP2eEUjzz+0wD1PWgDMqpERi45sdC5W3Oj1n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUYCcMVtV5XfedZCsPbIvxQ88De5Wnz6Lo0t1ophCTk3mwcM2
	YvLbai4wQZA2c4tuwx3rRQWJJEPf64Etg7wMFygoqm8OvYWK6bVBF0Qjdz8aNkHh4RLqrZLVAeL
	ne5p3zIP9yYsEqVucMzTbK3WL2k1YWbexhpRW4NL6bO7VM+PwC0g=
X-Gm-Gg: ASbGncvkJvPX0aQGHPnmoItAEYEhNSnFteTi17ST/l76JDkicvg7PxPmY5cJpseCLVG
	9i86yOvutVZ/Z/puBS0hnDXLvoGK3rSE+y83ZTZGNdiFQJ6wNa/BXqcexaSiFMQCi+63zVgnEJX
	5CW5FnIYS37NfaZxwixAsSI4qTf5cvLn6a73cKHYjTbVM7hAWqNfEFm0fBcfByBZ94BBs=
X-Google-Smtp-Source: AGHT+IHl6j5j5SomjINRchvsfly9h9XFFnxscFB20My2s2QskmtbkaNSy5APBp3ZYvQD2cCDToM/l5u5NAuBTBHOcaM=
X-Received: by 2002:a05:6512:12c3:b0:549:4df0:76 with SMTP id
 2adb3069b0e04-54990e2bfa4mr6513966e87.4.1741722632539; Tue, 11 Mar 2025
 12:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579283e5c832d77aeed531e8680961c815557613.camel@sapience.com>
 <1d8bf01be50646bb7b36abfc1ecb25eb997598dd.camel@sapience.com>
 <CAMRc=Mc6Tn9CZJA6EN_a0i=hiiz6jTr9oYLHdJ8iyrtsw+LmZw@mail.gmail.com> <962ff60ebdb9207354560f938de8f23e4d02f30a.camel@sapience.com>
In-Reply-To: <962ff60ebdb9207354560f938de8f23e4d02f30a.camel@sapience.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 20:50:21 +0100
X-Gm-Features: AQ5f1Jo19ld-vhsqDYYCbpt69VQo96FJpDSZ9T2vPMH-p0ylVgk4jG9zzAiuio8
Message-ID: <CAMRc=McPdfMM85GMgMChUzZSJzrpELNZZFMiOrBkM_Hy0ovHFg@mail.gmail.com>
Subject: Re: rc4 and later log message: gpiochip_add_data_with_key:
 get_direction failed
To: Genes Lists <lists@sapience.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:30=E2=80=AFPM Genes Lists <lists@sapience.com> wr=
ote:
>
> On Tue, 2025-03-11 at 10:40 -0700, Bartosz Golaszewski wrote:
> > On Tue, 11 Mar 2025 15:03:59 +0100, Genes Lists <lists@sapience.com>
> > said:
> > > On Sat, 2025-03-08 at 15:45 -0500, Genes Lists wrote:
> > > >
> > > >  gpio gpiochip0: gpiochip_add_data_with_key: get_direction
> > > > failed: -
> > > > 22
> >
> > Hi Gene!
> >
> > There are two problems here. The issue you're seeing is fixed in next
> > but
> > not in mainline due to my omission. I will send a patch for that.
> >
> > On the other hand, the pinctrl driver in question should be fixed
> > too.
> > Can you try the following change:
> > ...
>
> > Bart
>
>
> Thank you Bart.
>
> I tested your pinctl patch on mainline (on commit
> 0b46b049d6eccd947c361018439fcb596e741d7a) and the same messages are
> logged.  Presumably I also need the other patch from next as well.
>

No, they are independent. The other one should fix your issue. Could
you please test it[1] and leave your Tested-by under it on the list?

Bartosz

[1] https://lore.kernel.org/all/20250311175631.83779-1-brgl@bgdev.pl/

