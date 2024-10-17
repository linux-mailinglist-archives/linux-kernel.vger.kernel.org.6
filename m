Return-Path: <linux-kernel+bounces-369426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA29A1D28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF5C28B5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FD1D1E96;
	Thu, 17 Oct 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhO7YR+Z"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF51C2447
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153645; cv=none; b=OYb9DoPEphsxyqtNMt3He0XFXiItmH6WOUbZ3W6S/Ru250hkInabVla/kEC2/b5AspwFYiYq0V5GPqMIOpacyTAJRzIMlG/aLY0YGHj3viY3JR7wvgwOxwuvDK8ri4SDQE10MvusaPZg70iPju8qgpljCf9GKX1ohdMDHDrabcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153645; c=relaxed/simple;
	bh=9RuFKXOCKGYCpRwEf9eZyL6fG6HGSQQ0BYGl8jLj5XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO7FXvEHNAtGqy9Xbu8grpRrxa4jKerJ7O1tdmfAxXwlgBWkf8mBNMYb4E44/BmWDn27QuMD7m43mBKMtP4HZEqxdB1vqmtAkIBgnG4cecsotoN7qGHWBpgBJkqrmxO4eWFSosaYP8APnvYNRLb15AVz1l8HyVSAp2gdQp4PbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YhO7YR+Z; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso5461731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729153639; x=1729758439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RuFKXOCKGYCpRwEf9eZyL6fG6HGSQQ0BYGl8jLj5XM=;
        b=YhO7YR+ZJZMMxUQ0FU9xAsUAIERP47nhn6SP8ucU3ADPGryllAFNbHwtxtmfZ9tTBN
         4UjHlLXT3q52TYPuwiUrdyGV50s7nj5n26rU6zb40Lm65Bo5LHqV5CcW13edJWRfEsuT
         dpN4kKJlXRmJ5XjvktUpF047K1us+/j8dIELs6v91oNXmh4xgBJsrA7fFEiEa7zpE4P5
         ksMWfAUItaj/aVbgD7lqjdU4eDc/T8MSGApJB2n5sqW3WbfrvAbmdmtzQzK50wLy0tlb
         XjXqF9nICQYe+MH//GXFa1URrh5AEnlpna57gOeKaEA2Lh4x3vh+VLsiFYy1tA2hgylw
         cG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153639; x=1729758439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RuFKXOCKGYCpRwEf9eZyL6fG6HGSQQ0BYGl8jLj5XM=;
        b=wpG8Lo1eY6dLRzcWsOCs1Ca/VDEfniaWd+rG9i3yvIOlnR7CdUChcjRxBwS2GPV5rs
         Sf4trvg3xwsLjo33jVKYPVlqWYxJ4bzLPi2TT884RPs89nPix1hm3wmeJxSj/5Agg6qH
         NF9BThgKsbjeWod3SBFDm0ybbtvwfFBJN28AgjgW+ENGdAX35yYYCpa08YuiPIbR7sIn
         cQDqTFb0iT7la1PrKM1TYOAb0QF6HvyiFlm/E4jIR2ziaFwto9W5lfNOHtnUeDKL0K97
         ZqmD+bghS096petdrCPIww59hIQv2twC5PsDIUMCPob7TubC5hGBeG0NOR7NCtdOu5TI
         VZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUjeBy1S45XPNrhuYq6Iu/U+oh3TM1whF5PdUh2jD4ZTxB/j6FlCBjsNsAvuOa/zhpmqMwWrqgdcZKyGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9Ro53LoQUC08+1EwSFbnRj6QtFF6NewXs9QiUwd3kZ6TCPi6
	C3W0tswHqEzs+m6o7v/YX/8K/l5V8xMxNNQBfmdJIvpjYThJV3wewwI8wuFeNQjbI/poXshxm27
	8r+x2nHmmEL3ObJaS5pYEPpL1u59nqi9wbLRnBA==
X-Google-Smtp-Source: AGHT+IFGp1jCZnmvHDvQ/rJ1b9yqTSHX/X7zZXCjm52M5WN86eDGAJcyc4neSjprAjW8t26MkeSMDc9bWn8TglCFYV8=
X-Received: by 2002:a2e:a58c:0:b0:2fb:266b:e3b2 with SMTP id
 38308e7fff4ca-2fb32b38547mr108340751fa.36.1729153639012; Thu, 17 Oct 2024
 01:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017071835.19069-1-brgl@bgdev.pl>
In-Reply-To: <20241017071835.19069-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 10:27:07 +0200
Message-ID: <CACRpkdYeYLzF00Oa8QNo6MjcbyKdk4L=CE-a+8CXMK5soiUCXg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add a keyword entry for the GPIO subsystem
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:18=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Every now and then - despite being clearly documented as deprecated -
> the legacy GPIO API is being used in some new drivers in the kernel. Add
> a keyword pattern matching the unwanted functions so that I get Cc'ed
> anytime they're being used and get the chance to object.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Excellent idea. I had to patch out *new* users of the legacy
API in the last merge window. :/
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

