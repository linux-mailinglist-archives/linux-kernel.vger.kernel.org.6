Return-Path: <linux-kernel+bounces-369833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F39A233E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB52285E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033A41DE3D7;
	Thu, 17 Oct 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw8SpAMq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B71DE3D4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170742; cv=none; b=J6T4bQXcGeHVnSLferiikNBVpVdB5NIxrO7awXj7oYxl20cZYsVJ/CadzlPOuXSEobwzCzYONJWU9sMMZwp8+F5D6lQBH4SXe+hAt6p82lPcjm8DH7iw5r4Dhd3FtuR+Ba0HYCBep93bfAcB4FjUZFFtL0sfEodAIqacOmhHLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170742; c=relaxed/simple;
	bh=ZeiQpCcngaL1betvyW/NNSOcBr2oq3trOx+Qs0Oth5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxL755ncwLDhat/lZsww52ukMlTAhCSKwJen+wEDhCLC/t5dW5hbwanzAmFCXL1zObFZTlsym5kzKcymWt2rJ1aTMAKBFhsgMBTLM+UvwiGK0dSo3RsiwiFqZXv++Rn9KtMFNI976a1SdxoH3f/yidMhbiunHPJ6zI+A7/dfvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yw8SpAMq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb587d0436so10362071fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729170736; x=1729775536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeiQpCcngaL1betvyW/NNSOcBr2oq3trOx+Qs0Oth5M=;
        b=yw8SpAMqVDDaZb2Jwp9aA3mHQfSy6mppJH/wAYDpETXDQqQmCjzvH+R87cyE+otZ2m
         ey4ndiLQsIE5Iwvr9NzcONfvc8jSb+IBFMcXtbAvOtq0QZUeMxn53c2vyRRl98qK9goA
         WV+ed5fuZ6oMdg0j3pG/ux6LpwoMTqGvcnzUmSdkwHFVN0CK4MyzPQ822KwKEayDhQaP
         eBfXRaBLFVh+pZPdD/mVq1TXB5f236ZBqQx0FrqMlICaeVdRv4cA9htKPCnaU06CfWq4
         4jFS9Irbcb5RtR0G76aWK5fG5nLuhSZOKExEZZKkQhOzCQN5HJyXkHJP3LOnMW4BKY7o
         qw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170736; x=1729775536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeiQpCcngaL1betvyW/NNSOcBr2oq3trOx+Qs0Oth5M=;
        b=YwPZI9QKcicb8TBwI20/HDZ5skY9Ieyt4pPmk3BJpFqH6AoSCfOJhr2BR8XPn44aLq
         VSJcoL3Q1uUZksd3KakVEGKpRe9O6E4MmRvLycZsJmdqDxZaGKkuQCY53XGx55egGV38
         EXtRYIBq6wWDswziFVm+hgY/jXsIUtk9qb8VsSMSnEi3HLX/KN5yVNS3InLvmzVgWQ1p
         mNoee2xtqK+0Z456IVE3JOG3zFqci+sMcqMo7Vo6h30pae2FqtzRzVJWVewhlJuYpvJH
         LOLRMm2DiufiHmKu4w/CJdw1fzDUI3JKMpazFLM4KXXiDPB1veowbC0oZJueQlPWHgzU
         nQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWVaUQHjL79zQmWa2kcy5wrrXNTSdbvlFeCXXUl4oyRVbzwhXszJLSVBIWgPOXXW9oMe4x6cxhXYwY9eTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrr5hr9cyeE+wnAcVlJA6xNPYg1OuclvpR8DhHVOn70D0EkCbq
	DAXGTbkgYCz4ICMU2KCFGDqg/j8PNkmki/cE9itHczcXoCgasB/c4b6ON6etHUgKRDSa2ZM/lrA
	ZihSvd0xhnUXRx05Lz8sv/I2LxCtM1BSFYI7/TgQB6M5fWEhYuYw=
X-Google-Smtp-Source: AGHT+IEmoK3+zsEQP5cnCvB1cvwReFT17GUZuuzVpudQYX/VHEXnY/qyojlJX6LS47hk7TDkZq906phdXNPWUGXmUW0=
X-Received: by 2002:a2e:6101:0:b0:2fa:e4ae:3364 with SMTP id
 38308e7fff4ca-2fb3f1af9c0mr83282611fa.16.1729170735998; Thu, 17 Oct 2024
 06:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017123044.75531-1-brgl@bgdev.pl>
In-Reply-To: <20241017123044.75531-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 15:12:05 +0200
Message-ID: <CACRpkdYJVtCwVJ8H2AxY1keVFZMvGnPjBCOvqnfhSCUx3Qb+tA@mail.gmail.com>
Subject: Re: [PATCH] gpio: ftgpio010: shrink code
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:30=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use devm_clk_get_enabled() to drop the goto label from probe() and the
> entire remove() callback. Drop platform_set_drvdata() as it's no longer
> needed. Drop log noise on success.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

