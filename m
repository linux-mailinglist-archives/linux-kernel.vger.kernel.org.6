Return-Path: <linux-kernel+bounces-373787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0819A5CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C82834B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2101D1E73;
	Mon, 21 Oct 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2/CgBy+G"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489E1D1721
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495451; cv=none; b=LZHtP1NNVfhNlz2JQJ4uOFWgj/SBmtzmejYCZ6pLa0P1d7ZRKwQUxs5OdBAyzmNqMJGB7TyNIWqcmXMyHRS0S1RmTlIa9VEBzBpfB2F2LMuIvD/pbNODBdgMSq8P9uAdXV1Jxo08bgFKKuxodv2bfKQuZInKM5yIQWywnJVfU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495451; c=relaxed/simple;
	bh=MFlDMZ24pYGgbOnrbfqa5/CqhCJzqIOgQ6PFvuHBYCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh+pbET1y8nqnXIn5vS8qpbHwzgzf7n7+gVax1Xv7nLPSRY6UUKMx+V2t3SQ7j6kdq4KG3lne8Dg/q0uFsFPlsbi8zqheZlvM+LgCAZenRAzlSD7oQl+TH/uDvx6ujcabLOFwfmim2Mx8UuUQX++G/IzezdcsZP+yg/J0Dbnx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2/CgBy+G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431688d5127so17619535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729495448; x=1730100248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjEGhUSbcEnP4r1jXYeMykGZF0XLG/zYLNdVPESYZPM=;
        b=2/CgBy+GRoK004s/mHWBg24dBwnfhdnEB914M9sYkVSM22MpEna9V2sRLZ68xPXc85
         /oQBNDcsITtgbEC2q0zn6iN+X/3vls60QTx/8nwNJ/hkXu5N/ICjlpGqfZymtxTqsC0i
         sqPyPLKHollF0qwD/AHK/qHWFHHw6YvtyDcX8JQwI/nJMEqBR2ypkC7mVwcEFtF1rNiz
         aqlKdgpNUjguzkoIp41vP76KRyqaCH6ZwxZkd7AF/hZFHJaELzogQMXWGKQ78EsDjrUz
         7GPsFKeIPcciXro4IfGJwGqMBNXk56fvm6f3sgclJ2UA9g1e9N+WbirPYRUQanRWocrM
         y79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495448; x=1730100248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjEGhUSbcEnP4r1jXYeMykGZF0XLG/zYLNdVPESYZPM=;
        b=sWe/SDwzLAuKvoJm6sFzvI2jT6buqY3I16SPwdgwLJP/2Mzs4tEO+/t5wwPkGpAIbx
         XSIWVaHQ/Nqd94/W+JIIa0v/RYn8ckxxHk6poU7CXHgSf2nclVhSXiHXG+IByhJ7z1A1
         Lid5Xsej4gUDkFqHOpwLE1HzIojy7Ke//X8v6W1o71JZvkXY1+Lg4+7ugU5pnTcbSuAM
         hpIbmg5orLLFFUaiB8oqdoK6XAK9wKWiM3VRokA5A+qkybz3q5Wfr31i3LkQAn2o9XeY
         LdMLie8824QAzCB1KfZb88MkA8qY5enUSO+nZXrBnwUhc0dtsh+9AKWHUbfLY5JW5l/O
         RoGw==
X-Forwarded-Encrypted: i=1; AJvYcCWQxGhl5OE0TJchQcoXQUWaF6lgA09MB7+MtYYMluS/JsJImy+qek6N1TJdppaNLrpTahjEs9XALQBxJBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkXRl6op1sbDse2pC4I5Ut+K0+DFsvrqMIQi5cdTryE30fuZs
	vz5adxKYaDd0NHMcZ0cUhxVSYvuLtbrqk59xogIkRozGFFg5ja2YdoonzgJ2jIQ=
X-Google-Smtp-Source: AGHT+IG8uYTIh/d32tWl7WVIotx59tAebKHZ8hHRhKCUf7rMvm/qO+TWOU5tSrhboW+83ZkmalAxZw==
X-Received: by 2002:adf:cd0c:0:b0:37d:485b:b68d with SMTP id ffacd0b85a97d-37eab4d13cdmr6788028f8f.2.1729495447745;
        Mon, 21 Oct 2024 00:24:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9baa7sm3517954f8f.96.2024.10.21.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:24:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: ftgpio010: shrink code
Date: Mon, 21 Oct 2024 09:24:04 +0200
Message-ID: <172949543974.8769.880498156858512337.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017123044.75531-1-brgl@bgdev.pl>
References: <20241017123044.75531-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 17 Oct 2024 14:30:44 +0200, Bartosz Golaszewski wrote:
> Use devm_clk_get_enabled() to drop the goto label from probe() and the
> entire remove() callback. Drop platform_set_drvdata() as it's no longer
> needed. Drop log noise on success.
> 
> 

Applied, thanks!

[1/1] gpio: ftgpio010: shrink code
      commit: 68d51a0207de5f155c4d6dcc25983abafdc3f1b0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

