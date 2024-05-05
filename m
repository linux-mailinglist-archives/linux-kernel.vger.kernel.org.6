Return-Path: <linux-kernel+bounces-168950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDE8BC01D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7110C1C20CB9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D8125AC;
	Sun,  5 May 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ49tr+D"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0B11182
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714905856; cv=none; b=FA9sY0X0r429+cdgLFtHmOPl7zUh9oSqzvZsij5jKilRBs73LvqpWzmGv0TOINHZQRKoEq3K6hlICRjYOKczBxqyA7U8xnrS5AwDrbSOX1YcjxXidLQUCBcNg8M9DrdjMtsMWYJQG4c6ZhFkGSZC1pr9a96BDBIHft9Kp97RS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714905856; c=relaxed/simple;
	bh=KHEhv3zmaRfP0djX9DxadejSI7CWrAi5q8BogsN6Uzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXhhc3Td+3lXGbFjkJQ9sWY2V+8ukioL7IHTHRzQ1nUM3WbPoJShlq7cqqxfljCe9giwtFy7pzk2ODl7epJRXGMFd9V9YR65MKdqJAARrFjggGc109oPyzT7e7eqfO/ENQOSaD7suDcP/UihjH+6aMPgNPx/5bYS3UcwV6Ck1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ49tr+D; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso798621a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714905854; x=1715510654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHEhv3zmaRfP0djX9DxadejSI7CWrAi5q8BogsN6Uzg=;
        b=AQ49tr+Dckuz6Bg78RABuLyIWesNOLm2IKEFFy/Lfsa6eVKNnP9NQThh5Y2xvPSBEg
         WCpX3r4zzvR9vaNjSRRhpxgm1SE0hY6XtI8JOcsmfwV//KlQi0jK6qs6QQPHZ2fiUgNK
         +VWyz1i3Ae/1mCrxa62oAZfgWx0lqLInNTo5DOSmqLvc4lhtaVbiHEqRut2+u/3NsnkI
         qXnKYyQD9XLkEyUXeKm+vjSjhHvzC2axohkcdiw8MN9Dq6twVmyo44r36wYWmirN/D3X
         nOU15MeGeRjan15vqIoDItTXZi4dlOUMgGLKgJKT5rYzIHEJouxkr+tWA9rulzJxr69V
         wn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714905854; x=1715510654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHEhv3zmaRfP0djX9DxadejSI7CWrAi5q8BogsN6Uzg=;
        b=SmcZ/CAGuXVZTEBVwnRMb7Y/4goHFhMC/2IoKjd9957bhTyPOmIALjdWdCXOKg3Uv2
         +snvmi5ZU07HWwzOtvIOJ5Ivflk0RyrLdzE3qGYcIpICOXB0UTy7CZ3StOzwGBA1rjBM
         ccQg+wUy1WtmmmsREIpJRD4rYUuRrf/0QHJ/2SFOrNmYBSJSdpChmhD6DUqAsElk/pWn
         onni7ZHl07BxxzF27FipgB1Sr4YoOtnYADTzHthkHDoinvG73cZdhztYQh5JXluwPriA
         br3VVwkaRkKKh8P12NPUdrd+HoIajAHa6tkKr4h+ma+IpuwT+iojDjH1ew3G4QE2fHWI
         g3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPIGS31olCqur0TV2lUKp+x3BYC5B7YLsMNZIiSwicmCAqy8RYyFlanzQlmui1TMOY+YWHyvtbAUPONm97KTHEGs5PNTtGHv9pYlN
X-Gm-Message-State: AOJu0Yzh7diQu4LLeQeYFu5NSof0e/HcgNnPK1/Rd622Td8kTyM+qqYC
	JZYC5uUqdgrsD84JXGbqmABqO2R2vzoM0AE9iLoOJqZ4OhStsSfFvVGXCqZm5tY+mlUHtE7+45L
	1PcaAV26jACKeOVWHKEw/7TExf3M=
X-Google-Smtp-Source: AGHT+IE/KQfFTavx9IjjwIVQyxMZ7eZmWGjgcGO/oqK1nSJ7M3enWhKtOEViDKSlx+ck20q3uRIjXvGpMgTk6YXz/fg=
X-Received: by 2002:a17:90a:51a5:b0:2b2:d375:3b7c with SMTP id
 u34-20020a17090a51a500b002b2d3753b7cmr6369408pjh.31.1714905854426; Sun, 05
 May 2024 03:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502092443.6845-2-visitorckw@gmail.com> <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name> <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name> <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X> <ZjVdbavKgDo8a0CZ@yury-ThinkPad> <20240503222338.GA1908482@thelio-3990X>
In-Reply-To: <20240503222338.GA1908482@thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 May 2024 12:42:50 +0200
Message-ID: <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 12:23=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Adding Miguel as compiler attributes maintainer to make him aware of the
> change. I think it would be reasonable to have you take it through the
> bitops tree with your ack so that the test patch can make use of this as
> the fix for the robot's issue.

Thanks Nathan!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

The new macro sounds OK to me. Perhaps we should add some docs to the
other two attributes about their relationship and/or the existence of
this new `__always_used` one (so that it is easier to find). And if
so, then perhaps the docs for `__always_used` can be simplified.

> One gotcha that might be worth mentioning is that this combination only
> works on functions and non-local variables (i.e., static or global).

Yeah, since the `unused` one only applies to that, right?

Cheers,
Miguel

