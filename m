Return-Path: <linux-kernel+bounces-209905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D298F903CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8837C2828CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6A17C7CB;
	Tue, 11 Jun 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jufcDoo6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AF38DD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111311; cv=none; b=bzA/FQWJ0V2UK/a7fGQm4UFMJfECTTuLDKlB4raW/V+GL0wMs0XNkATYyqCf2fCIefJHPL+IXcDDuUJdtBNTwXsbJBV0RxbChxpGQVnFGwMf+MAFJ2B7K1Wu3k/H4A3ZNLTcilaHHV9SwWbnD1QeBQX2NEJteDNgypu+iIEjJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111311; c=relaxed/simple;
	bh=qLXHl7HneB0ZAz2f7/+nFTx5F6LdpJLFJfWWnfw3aco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOBKSQu6zVmfWUjM19L3B8EWSUm4CySDM+SfBTton+3GKAOBbNxHCkvMhR35bxQsQVyal77ccaQQuk4yXDFuNqW4piAO1c1LWCxwio62XWXNekgvEC1FP5kRkOpWwTamKmAMPpzMp+kd0HxVm08DzmmltDsnO/uVRbxxprwdahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jufcDoo6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78ef397bso6063597e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718111308; x=1718716108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf6/gT+Ewdw8uG06lDxtm/kv6Pnh+Q7yaLg/g7n32Y8=;
        b=jufcDoo6WoFT2VX5NFQliniXHwypKEiuXTIsnRVicbCNqKCVTCoSMy6TEyqfDisRof
         Ch4FviWx7WPSB94YSRLTsFJa/yoGvXWMZ4mJasdeXBtARmXQl4nwgHTUNUUIp926fP9l
         byWmqqzJHSwrAxmhteLsviGXRONCNt5KhcOOJ6+ygsdZpRpOmyKH9l8RKFNVHHgXHmWx
         9uOkRj+3uB9VUj/EkXO6UObtmrstbyQNRcbYZGQmew4r0XsYSgZBDo8Xy7f1y4u1BNMi
         i8ENgl+N9E6S6DRSVVFdjI1MGLgxhabxSP7r1fcBpwFmuyMq0r+agQMH2ajHdBae9vi7
         3oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111308; x=1718716108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf6/gT+Ewdw8uG06lDxtm/kv6Pnh+Q7yaLg/g7n32Y8=;
        b=VIUvU8lFhYuyUUMaHcEcHBVzKkvw5wU2705CfrzO4YocyPZ66X0A6zn9DGq7ZfX0fV
         AyC3cQkL2sTMctB7+WOWpUSxeo/DINZJWHMbUoiBMG6SrAMOieJ79jQlhwRmxDvz10rN
         Kp118G+A/We1bKNy7lKwFF6XzDntPTIyvdRrrpMcrRm0sUWCv1WozgZLIJdsbwrkeQiI
         n4Uv0bMiKLID0I5n6kq5n4sSfBk80LekvcYjqpJHbKQz0L+nEnTJGZ/WuFJz0We1Q7C8
         d3B8PLXrLWHgtaR1280woxOmI9AN1nAMRHoWZTGamwzw44l9KVK1R5s67iUeIZhc6mqW
         NEaw==
X-Forwarded-Encrypted: i=1; AJvYcCW/PgxcfAmzGVzslQG2eBBGJu0+BnXVI9/po0rcNk3VyUA+HLymwWXBF4ybGo9ru3wlTf9+u48kcfg3Y3mpTZxiKFx0o4/n+B9Je7t4
X-Gm-Message-State: AOJu0YyhtgEHQvFEW+RDI9dcTnS/d7rHbBtvnGyi6hbo2XyuLwAr7/1j
	RyM4FbMT2j6RF7JA+QZxuE8VZ0qoGdjInm6WFUlsJgQdFelNiOu8wEkRF6hftpNHN1Vp4Cr6b7z
	HdT8jWXsUYXwI8BAbOh+h1/a+Ftcin39hM/mbGFDw87Vu01km2s8=
X-Google-Smtp-Source: AGHT+IHOqXye9KCZZG448CXko9HSkqfPVrmO82845VTO+F6jU8L2MsQWSJpeN3/1oP3ZGjeUR2ViNiHEQQoCCvJpXrY=
X-Received: by 2002:ac2:5041:0:b0:52c:94ad:9b26 with SMTP id
 2adb3069b0e04-52c94ad9cd1mr564889e87.30.1718111307827; Tue, 11 Jun 2024
 06:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>
In-Reply-To: <5a970f32-25c0-4955-b480-a4738bf86153@kili.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Jun 2024 15:08:15 +0200
Message-ID: <CACRpkdbSiSpRXGa=eHRgt-8sCgk9ByostgynRYoC1tZY9fUh8A@mail.gmail.com>
Subject: Re: [PATCH] bitops: Add a comment explaining the double underscore macros
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:38=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> Linus Walleij pointed out that a new comer might be confused about the
> difference between set_bit() and __set_bit().  Add a comment explaining
> the difference.
>
> Link: https://lore.kernel.org/all/CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNo=
tkk8cPgCODCg@mail.gmail.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: re-word the comment, put it right next to the macros and add a blank
>     line in front of the test_bit() macros so it's not mixed in with the
>     non-atomic macros

Thanks Dan! This makes the kernel a better place.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

