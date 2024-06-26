Return-Path: <linux-kernel+bounces-230277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B81917AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4069F285A67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A31684BA;
	Wed, 26 Jun 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uR1QIQpk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8815FA60
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389925; cv=none; b=qeKcOs8QPbc57YaH3IP37HtFezKWb3cNcvuGaiilJyMoxe1zcX2n6lwmEkJzmpEwWp/oU4qhqBSxeMgJ3oN9UL3GhBDFWABc3Q/Ruq/QWtLSKixJhM80KbCtGcICnO0ic/Y+3LI/QTjw7GFpiG4U0ixXhtUwPBppOto3PWN2Lr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389925; c=relaxed/simple;
	bh=NSqa2kAEd9Iv1e72CviFTjembB5wPUawAMWFyJ4kKJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh/yNZMPDtvI4IU8+LmyGAs8Gczytwa+mfhMr5MuWf+On8FuR8KDgsBkXxnG2wYFgCGcJQ14xDZE3Vsat52EPc0y29HxDtBB67v5M2yT07beJEty5oRTe7TgPvJBLNcNvYFeb/bkMWl6uA06cOcD9wZW8U2fSdGzk1WUFyyCxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uR1QIQpk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso76326931fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719389923; x=1719994723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3850Fx9RZmAEeBVhGsAovnMam9xtT8LNg4P+ZWop5vE=;
        b=uR1QIQpkllPyFxi3B255i4PLw3YCLI87is00ClC8Eu+k5nD4lw1nBjY/SQvqE7hff+
         ifegGJxqggM8px+bcGKQoq4UN4HdlV+iQm64fVIbpgGnfRWC3NyjNdX/ngbLHB+YXZy3
         dqYDqhu3dpaq300bG76g8V5BM6mQDmDzVreIzSyBtzY6TnFCXOYkAuZrwh53v4ogUXGO
         v4O6JxnPbF7xaarb7+2SNa9clZKzenr2B41vN8xHQiZsnyujNVVVl+DAQzaMQ0JwG9yC
         wXigXF6N0XTFUj6NNK3xCIMuQVelLiFzC0uAEYm9txroqhWACs+4xrr1aPSKqLgxwtZe
         r1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389923; x=1719994723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3850Fx9RZmAEeBVhGsAovnMam9xtT8LNg4P+ZWop5vE=;
        b=JXpHz/len5EQ1eysd8ZFTOdUAhx/fTgKn/2urEtBZegzPDFLeIGBol8g16n1fpGn/X
         hRyDFU/A/S4IJeEF8wPQ8OHWiOYeR4i94jjZ0m7MqV0Z+XI5xkSAt/Fk3WQoyrijBTkH
         2H4JfqsaW2g2RF2dEeV1H3ZCOO+1sZuwLl11/KidWVX/i/uoXvhVHyUQjwhVild3+8ZK
         drnB0QQwwDvQW7N3cAWhTOF2zKuUkYOeTD+kGZQGCmRcZRIzC6ki4eKY5LL8HoNusmnU
         w56cbyR4cTj3EdnBzVTsYYS2TnAja/jo23U6H1wG4Y+CzRqIKSu0l10w97ocRxcx5Sgx
         +1yw==
X-Forwarded-Encrypted: i=1; AJvYcCVnuIYtEz9ZBMZfnQ6z69LdkXgAxKfByghlHpkutgWh3iOwDo9HOecqjw2vkmMMJjc4Z0A7qX8OakjkVh9gyHcnGWN4Wdy2yxnO3Rds
X-Gm-Message-State: AOJu0YzD7Wditc+/sDqaCma99pBYig3H6KzRLzZNwuHBDDXpjsk9D16l
	oakHpCUriQcGhOpd+XqLgASgWNosckQ+d7QC6ensO9OwhS3PEenb0U9hGYs3JcE=
X-Google-Smtp-Source: AGHT+IEWVAt1TEvKvv++Hfb7gwDHylSEYmBfiE1+nF4beh9Jfz2aCXQAEjR76W0zgm+iy8kNzjSoEg==
X-Received: by 2002:ac2:5183:0:b0:52c:9635:46d with SMTP id 2adb3069b0e04-52ce064f4eemr6136863e87.41.1719389922791;
        Wed, 26 Jun 2024 01:18:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a149:6586:c473:97d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8246828sm16232965e9.5.2024.06.26.01.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:18:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: graniterapids: Add missing raw_spinlock_init()
Date: Wed, 26 Jun 2024 10:18:41 +0200
Message-ID: <171938991825.8608.11339070228901947974.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625135343.673745-1-aapo.vienamo@linux.intel.com>
References: <20240625135343.673745-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 25 Jun 2024 16:53:43 +0300, Aapo Vienamo wrote:
> Add the missing raw_spin_lock_init() call to gnr_gpio_probe().
> 
> 

Applied, thanks!

[1/1] gpio: graniterapids: Add missing raw_spinlock_init()
      commit: 888119571b7c9518faeeeb2b431ffc4455e0028d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

