Return-Path: <linux-kernel+bounces-268735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721B942873
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D871F241B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F4D1A7F65;
	Wed, 31 Jul 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="q5MmTzUL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46A1A7F68
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412630; cv=none; b=McYaavaIkiQXopnz3Lyhx2VgS4PZvFbUbymcLFKrgQwYF3zxypIW+sTsDwQlrt1F1gTqpxiCqt+ozDJDmAvOiE5933s7JdpPsZKuANLqpV5+1Jrc6jNcAWJH0IlVmc7af7Kt4KJ7k07OOhDx3/QMqeS3jqnG5LZPW9Ped7rezIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412630; c=relaxed/simple;
	bh=5xMUQQnHfiLd7ujJcusm+8XOcwFYI/PU72Bs1QhUKnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRdlqAAOjA6u/VT+7PLJOh5IIrAEBBnOKqKLRGmJr3IuMVA98IOTlAH1EnJPXqBm6gI14TH3mOEgXR1EKOyPVzI/GAa43TaUsz3TOuhfiWqW0sNLFhkUp7Xrl/d3UbOG28jZLwDgah1xo7GfjM9N6cnGUiRl6lrxGEpWWKEAwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=q5MmTzUL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928cso13161625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722412627; x=1723017427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mERmM/WSYpb8xDnumITCRtHrfI1svR9aufTX1a5k9Go=;
        b=q5MmTzULb08VR1wEzzpxx9/pxcVvZh0vbR/JTsZnqbLkxiMvT0kfPpZ+mBV5gWtXnl
         5KJFhhTwwABjGC+PLvgOi0X3kCtEZsEyq1NeuIL8pS2yZryAcvJTQ9Cp6FMNkGMfXSfg
         nyAJuAyTejo3+16X24MBL+hZBaXL5qOjDtwZ5g2Wej2qMxXQQlOQteJ4pkwxPRZFZmQR
         RLn2Qk4X9JTURvtHxjvxBzBvFLeQ2c2fv7eCeSoZoupu+9T/06i6mikMR8q03iX7VVkZ
         uA/h44S8DuwUSMYCfgBXwIWl8dr56dA8Z99D9bH4bATp6D8dgcqvDO4T9zf9FnlzRgCJ
         QsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722412627; x=1723017427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mERmM/WSYpb8xDnumITCRtHrfI1svR9aufTX1a5k9Go=;
        b=jVG+Pd/+C7QdY4dJ5S7nSZRteRzrT3KHjYsOh1nuiU21O9i8zOc3BGOT+KXy0MXAEG
         FVtXLRoglzk4L2dDjwNPRAccgV2umA+IO80nYqoeG06Xnz+FH36shI6UTV8LpVDf3SZG
         R1IQqBLew7mLXAspKbixh9G5eUXY9d/+O4wpQXSzBZTDsSa+CushdGa9/AT2/SG4I/UW
         tkAYly+0ubcOY4OVA84FyM8/LhOD+ji5xsKVg2MGPA1yeGabqAR9vpsL16iyoZuz30IL
         XhfpxPQdu3YH43ObsQUnWhpiRw8pLw9cvccKbRZac4vASoPr7UqDrsvQhOdvTiYkPaGo
         Eqzw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Nbkg273sdJp/l7oaR7UxB02XOkF6eP8Cx7kRbZnd/oZ3YXmeQjdLIkFzMeq1i1S2x9YkB4CljmSrbD+NZ8Y363lTkxkjR4R0qQLw
X-Gm-Message-State: AOJu0YxPdrKu31wZqndYifGvYf7Xogch1WMkLoZx5qAitaQK3b3slkZC
	SUGfgtu8wk0H7Q+wduFUSdYqnYeDOMKJVrLWszPg4cUSDDpy7+nMGrJN5VDGbr8=
X-Google-Smtp-Source: AGHT+IH/zfkXj5ULQZEFU6EvFUMJIx7j4wtOjvfjIg2atf3Em/LAAqfxwNTWM/qdKFYhsjISa/CeKA==
X-Received: by 2002:a05:600c:1550:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42811dd7a57mr93317365e9.24.1722412627182;
        Wed, 31 Jul 2024 00:57:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb223f6sm11524355e9.45.2024.07.31.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:57:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	warthog618@gmail.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/gpio:Fix the wrong format specifier
Date: Wed, 31 Jul 2024 09:57:05 +0200
Message-ID: <172241262296.10170.8900238511707870912.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724024636.3634-1-zhujun2@cmss.chinamobile.com>
References: <20240724024636.3634-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 23 Jul 2024 19:46:36 -0700, Zhu Jun wrote:
> The unsigned int should use "%u" instead of "%d".
> 
> 

Applied, thanks!

[1/1] tools/gpio:Fix the wrong format specifier
      commit: ac93ca125b5409df56c5139648bbe10fd1ea989b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

