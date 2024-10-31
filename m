Return-Path: <linux-kernel+bounces-390494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E407E9B7A97
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211CA1C2219D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EB19D087;
	Thu, 31 Oct 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uVRVVCFx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFB19CCFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377976; cv=none; b=gd9ePp2G09I91zAO8Qbku5Sph8GFssU0wQURdDEC5EFOOIA5b1D6FzIkH1hSIB2289figoM+SdSE0xQx6nKwP6qQQG4oouEAZWCF7qmtcM58QS/02BG4z/j4EAfwxoWmviNLCw5aBVbfB42yd2xynpi3nghc/c9Cipq0j92XsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377976; c=relaxed/simple;
	bh=J6D519UsX7pfCfkuuscjiM0yqOK9QlALGZkh1pV2gw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iws/jCxi4t/7SowhDgPFAKnUiUU0iQcDQ/DEUWzOdaKJH+fr0P/ym07+sS4Ect2pYqWRDo+Hxt9fb5MaVirb/ALnA4hV3x5TxFLAeJhWMfLFYnynHsNFu5ylj1/Oyk2sunWiQWw4LMsDPKmZO+wJh0+T3CjbEjSENzpXoPTu/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uVRVVCFx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43152b79d25so7580815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730377973; x=1730982773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVXdp7V34mnOKroXaCWoC0q65JLXS/x+HvwWBIx7JJs=;
        b=uVRVVCFxPm/AwLclf3AySj/KCX986yrdSYxgPPchixMXjSulf7qH8dkfQyyEOCKn/4
         4rHJ6UixjCo+foqrfvPDo88icCcOysQWpipJ1hKzTJAPMxP98RjQ2BQiNUTVRywbpMzW
         yM4fARKyyxPnni9CizPzEXzOk//392w+zKs5NKQvDvBMJ44dks195GEbUrDAIYpcMSnR
         L2QWDbrdgoMHWb8tmk+pji0tuXGEIuYZ1J2rBnZDyVly/+jy93xxlDGC16a15TcaXEEz
         IWWDdKWx9A6ahlxdkqbsJIGtY+bWMAubyN6aVeFZ8ZCliZMuvjYhRGGG5ailR5yK9MfR
         h37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377973; x=1730982773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVXdp7V34mnOKroXaCWoC0q65JLXS/x+HvwWBIx7JJs=;
        b=TvH9rZLCf1YnjVZEv7GxLJSxbVT3Z9RsTx/o+wvwgWPf+P/Q739BC7jt5/AWhfk1eI
         SLWfh7VcU6xv3dAQXS7EjVZzHRG37D2Lb5IWC480hMAnB1eMcRSCEByuHHrsp6jnDpko
         0lYLG9nSXylwJ14wgoBFvcjZZce2LFE895OvKdxssEO1PpHtNdLZCF+NP3DKp0cCzb7w
         Lhrnwhcl1/i6qQUgpG7OhtQ0394j6HQJi6n0J0653UAciZvpx34egu/v+L3d+qB36yhy
         mUxrzPNHIMahhq9brPoinqf+nmA0wcwPMLP5FwEPaG98IzANpRXu+rzeDyVLiTauf4SZ
         5jtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXofgwlvTbfG9y1y0X0ZzNsRVJ3wyo3D43hyMqTeZOM9Uw4WXFZylBxExu63E46tXvmHe7hdj5K68paotk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvxv07Mq7/7t2ChLf3CnHqVehe+tkH/FRIrLe/o64cjzsZtS6
	3DqmwO0qLH7Xwg0Hw8RSU8bobqNvnYYgprf29Gm7tjl/XtueXR2HPoZGdh+FgdU=
X-Google-Smtp-Source: AGHT+IFmRsRvehM0h4BPKtbxntLBEEGRSlQ6Q/RFX8aiCmN75FSuODZPQQRNVOYCGmsZ3cOKZqlgOg==
X-Received: by 2002:a05:600c:1c28:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-4327b6f950fmr28631625e9.13.1730377972949;
        Thu, 31 Oct 2024 05:32:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983ddsm25275415e9.44.2024.10.31.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:32:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: remove leftover spinlock bits
Date: Thu, 31 Oct 2024 13:32:49 +0100
Message-ID: <173037796253.6131.7309929068589307533.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024191532.78304-1-brgl@bgdev.pl>
References: <20241024191532.78304-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 24 Oct 2024 21:15:32 +0200, Bartosz Golaszewski wrote:
> We no longer use any spinlocks in gpiolib.c. Stop including
> linux/spinlock.h and remove an outdated comment.
> 
> 

Applied, thanks!

[1/1] gpiolib: remove leftover spinlock bits
      commit: 01aab9fd0a838a6195863b0b019eed648f41edb2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

