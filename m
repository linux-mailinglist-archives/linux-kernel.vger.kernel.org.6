Return-Path: <linux-kernel+bounces-311334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428BE9687A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6D31F22B76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968CA19C568;
	Mon,  2 Sep 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MhXwNY7m"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF919C541
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280660; cv=none; b=WO7nZhIPZ+YHkuwErKXHg1jZi61mcqysRdbOtAiguvZCIi878no0nYhPHPOmqekl/o/XTmi5u0QH8OS0xm5qgHhSqMS/AId59t4ifsaXs/eGMcabWY4pILle5bAoa5ng4hNuIvpkoDbamyykUmx6N4aHnquy7ykyF7OSsXIHb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280660; c=relaxed/simple;
	bh=NP0rgn+ASsyKRaYE8lsV/RhvHQSwBjs9OEJTn76oiYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwiN9ywswbLzWQ18ZvzFTifmPittOYqJ2tbWxDgn9RPr4uvQGryX5DMVHAXG5Jj42NEZuULqNeGgrVccEdvIYiIMkHIZ9YfjpIm37QgUQ5yD2TefuTDW7jx0hSXB6aJAmRg8SS4iUjJRL20mXs9CkvfVFleVcg1qnEM8eXVbhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MhXwNY7m; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso2805742f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725280657; x=1725885457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQFBtXSWGUhbtWOtZku1sSH/A3WSjyIHigoXatlNOx0=;
        b=MhXwNY7mxOmlzGJTclZljrI3WT4coY2kFoNkkcuU2yZfWRHCE2CncyMtyiMsf9sNBX
         Sl0JyZq9lAP9Zx8cvzLA0TxZUqztWrusZbp9rjw0f7SR626gzs0lGAGZPZ6yYXcxhfCY
         PD+pxdurEtecSPLjl0wLVsvLUXvz0j7Dex5ZYg9PVwylGHGhVOcYPklyTjFhdlc4qbmY
         Am56EhW5JZUPpO2YukR/s8pn7qY8Y/7ByIWatRya/+RQv7TO1GCZVJPVbeqsKvUmw4mk
         ZTNJvpmGzdydxOGIkGYNopMLIsElp/7tZvRj3maYrhrPjJ86mclKSPwoSsGwtFbV9P4n
         nGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280657; x=1725885457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQFBtXSWGUhbtWOtZku1sSH/A3WSjyIHigoXatlNOx0=;
        b=QrloJ+Xy3Se6DEmZUF89AepW9AlgMhy1rFeuRKB0l1soR0fm4QxXfqRCZyG3MxykqZ
         JqjsrdUbdz1VNlI4fT9nV2AA/CFioaMzMX8ZKdyxYK5+fFVoQJDNbJ+UMfEGvhvJ34Oz
         31c4qxRPJh8ElEk8mXAaSPjJkccETBojx/DjKymXXT9ihzigUpMVjv+P5wzxoDVEpHqG
         p1/JUkAKVH1/kCcM3wdPW0sTcnZq1jHH1Bl62E+M7yi9sxcJtl1urKJJyo1vIZMittN/
         Rg9HqrpA5kGGL1WZeuGmrNrl2sGMYmvGQT9w2+R/vqP3DpFH5jqIOoWheWh/JFJg5MjD
         4vWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdlzvYgSTyPDBldLswwstQJ3bRikJ8b1/JiQ71R6wkQ72HYcbceXk9cuf2bvwrQAQLmHhuNX9oZgutdyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjXzZVfxzRrA/UzSkycvuS3XLSivL1NUaLQtOWz4PM/rKzK0K
	iQBiq8VOMBm/Cm9tK/EqRXuVmjApeZKhLOTBvSnUBWsGDFXH0h4J0qJP382nDnY=
X-Google-Smtp-Source: AGHT+IGUPRaU5FnlLYMNITT9UfVG0A1DYVQT5aDC6k21qX7hVdBs/KpsVWU3uutzmx44zSnuC7bQMw==
X-Received: by 2002:a5d:6c64:0:b0:374:cd32:f84e with SMTP id ffacd0b85a97d-374cd32fa0fmr1775128f8f.29.1725280656347;
        Mon, 02 Sep 2024 05:37:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b6a3d27fsm8290020f8f.59.2024.09.02.05.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:37:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiko Stuebner <heiko@sntech.de>,
	Jianqun Xu <jay.xu@rock-chips.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: rockchip: fix OF node leak in probe()
Date: Mon,  2 Sep 2024 14:37:33 +0200
Message-ID: <172528065211.30738.10099217690325199623.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
References: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 26 Aug 2024 17:08:32 +0200, Krzysztof Kozlowski wrote:
> Driver code is leaking OF node reference from of_get_parent() in
> probe().
> 
> 

Applied, thanks!

[1/1] gpio: rockchip: fix OF node leak in probe()
      commit: adad2e460e505a556f5ea6f0dc16fe95e62d5d76

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

