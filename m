Return-Path: <linux-kernel+bounces-528485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F34A41828
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F183AF975
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744B198E63;
	Mon, 24 Feb 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vFbagN9F"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA224291A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388013; cv=none; b=h9CAsyhJgZWgPlykeXfJCefKRHN2lB6SKGi4l0hWqiw2X86B6FTHevaOuGqRbLbZW5zaQOAuf/6tt0RCWwp1E6ZlnN7ZBnBVg45ThvJQw91Oxz3b7wkQlRnUzUAtyy3B+DZ7qKf4Mh14FMP9WBoHIys6HXcURJUaqOCyQQaqfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388013; c=relaxed/simple;
	bh=yDGWepIHLbPVLZ5Rl3jNTHF4R70JWVTndC2BD1bDldE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0blsrY06r0mGZ5bSNTJ27jtY/mvt+eUvTlIvZhuUGm6km+/xzPDFYllQgyKSg0KCUznqB8s1pG0o2KyErZY35SAbkKNKTKu1xOxkwwMRll1y+bqlRchfnaAJsbHHH9lubaDorKaS63KwaBkHcq4ghqrqPLozPjHi3lf7GYAFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vFbagN9F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439950a45daso24516625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740388010; x=1740992810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYxTXn3Dc5cnG8TtU5kqenlM0ZtDWqWGDCzwlccpQPg=;
        b=vFbagN9FmbhemAI6Czy6FhzH63lWSBF/QJAsiHbbdazPYSqCX9cZ4bWF64x29rNDhq
         xbV1DANnZIwIl5JeTXcaI9j1oUZFNd1e8piaCyXbNxCyZmPbbPmMJZXG6lJEPRNBVM47
         sd81GT2xPKWSkjCelBABAFOZXfqY39QU8txF7Mv7xXCr6uaSIBlQi7MfUQ0zpoBzWvGw
         sRWaGK9RzzY7rjmii10m3teEHq9ISff8T3gvy5v83YUC2g1y8RP9v7O9exzunWd7LVYc
         gdVuhyJ3HuFylRGGI8qqO8PH/0YR03yZSJqWFDlunqzNOScfFa1M4x/ggLEnKbfwZF8F
         J0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388010; x=1740992810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYxTXn3Dc5cnG8TtU5kqenlM0ZtDWqWGDCzwlccpQPg=;
        b=oic84AFOXQqfbcARB3PwNpky+K0jV1WqQ+y+B4GQuL5MOxqQZb0LZBu1mjNexeNMBT
         yvTLAUI8NJ18HfIicAOtKIWowQchyuiN4HsHk/p3GXBWnb3N4vo/pEi7i0INQWEgfwPs
         zUGIVLDsnl2H1P3RlrKZDTmpRpRymfoWBZafSak2LxfH7OmK8ugczh7zajFOsNuVqliq
         g5bZQ9jfQINqq3t3FZCcdqkCU/ASVw+FxHqLyY+txQaAgrN8ffyvInsqWIHeV/XtHGeY
         Sfp4eIFur7C/IEdkzrMH+23dmaKgi4/x0VGQonFQtiE+qQUqRP3YFU820GDhOiMEvTTW
         4G6w==
X-Forwarded-Encrypted: i=1; AJvYcCUO+b/ZtlPBOKg/ITxhDtjyh9ZUgHcrm09QnaippqGP3INBHfm73qCxiwKCZZwOolCbWDCS8MpxFFPxDEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6Ba2x8fNx3SyF+qqRAb+fvwgBArgV5cdFvIZwHbGbHeIB5Ls
	PehHqF7AABvGIGPlEiY6V7w4PoxcpQ6QGWFOUgJ2pGu3t9nJlUSVPFDUBeaRKe0=
X-Gm-Gg: ASbGncse/IG16347iYQBcplf3SQhJfUfwl0JbPg11eKkQSnsBYTn1fKdfBORse9XyJJ
	adIPuoF7UG3oMl30+3+w63fKJtnFaOLwwPZAo33fZR/ZJZ7nDyg/NLQUqAk+u5/VxTf+4k/WxLA
	JgBcEg1+sZlUlNqVWG04cVE4ydx4HOhleC24KPfoZG8SkTrpWKDRL5EUUTbd2jaq98L9MYG45l7
	PZPF8WoRXoHRXn6r5h9XSeKGrY0Y1Q4jhcJPyNQcPlgLIjxyOF10hrgJSjqZgjfLUEdFsja2QMa
	4YhNFQYLze5usyqDtSQE2PqV
X-Google-Smtp-Source: AGHT+IH6mI67VN6+LJhW4CQixdQKl6hq9aE0FVeh49meEBwPyv6KSQ0mFCOhMgKfSlM+rzBNT1MX8A==
X-Received: by 2002:a05:600c:468e:b0:439:9b3f:2de1 with SMTP id 5b1f17b1804b1-439ae1f199cmr96841805e9.15.1740388010179;
        Mon, 24 Feb 2025 01:06:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:eb70:990:c1af:664a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c4df982sm131355455e9.1.2025.02.24.01.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:06:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: read descriptor flags once in gpiolib_dbg_show()
Date: Mon, 24 Feb 2025 10:06:48 +0100
Message-ID: <174038800639.24858.15060256292022357731.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250215100847.30136-1-brgl@bgdev.pl>
References: <20250215100847.30136-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 15 Feb 2025 11:08:47 +0100, Bartosz Golaszewski wrote:
> For consistency with most other code that can access requested
> descriptors: read the flags once atomically and then test individual
> bits from the helper variable. This avoids any potential discrepancies
> should flags change during the debug print.
> 
> 

Applied, thanks!

[1/1] gpiolib: read descriptor flags once in gpiolib_dbg_show()
      commit: 11067f50458a5bb3b72f83c508e03f321e0c0c34

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

