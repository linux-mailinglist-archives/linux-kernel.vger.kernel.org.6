Return-Path: <linux-kernel+bounces-170830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDD8BDC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB78F281B53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0413C66D;
	Tue,  7 May 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uigBo9Rd"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72313C3E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067892; cv=none; b=q3sGpNEZNxu1Dkc25HMYqJsBx2O/uC/a73grbS1LCesHXEi0iN+2gkEXn9l0k/jVmbxu3SwNb5KHV64r13KMDJfsekh/dslnC3vhoEHEdVhomjDTmYHrWBRvWQJFKgJBKRAu3UWYKfhhZquIutQy++WM0VxwtfTOdJ0iffC0kak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067892; c=relaxed/simple;
	bh=QZBqqw5CjPg1UIXq1sw3E1GLAGkrvPPvKo7F0LSWiIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHTc1wnRyPP16bA14qnPpKU7BwUtiAShazkgRma4HpOUM4jJdU79ja1mHNqpupgp3EnEj4fyV53Qn08xJcJBiTc5OCgbjZpD+x092jI6QXbIfhE3caecfJuKXl1JlE8NQiHp18jpNAd4t95/YyVgZtyyW2U5bIKNiGlMWC3ZG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uigBo9Rd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so6716001fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715067889; x=1715672689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1bi4jNn6UYAzYQiUUn5O+wqHqVm96iTmQL0Ia3V0gI=;
        b=uigBo9RdN4BClZvRS5ko2kQLIFRMi0KMf7wiRDy5xMhZCqsx8oa870zU4AA5HBARZj
         XXWzJuscX7AJ8F6R7usl/hCvCHq7AEoQ4idRzHWxYydxROyAvIm7syIX8L9+UEdYbVXU
         l9AIkQabM+LeC0XbO0B+QtL5TFB1BlG8jknMh97M/6zC8/06Y/NdK3mjSM6TI/cTe1TY
         u7VQsbtfPzOGYRGueivJDVWLVl7JFKD/91pBtsWm4FIClGHlZsKdsGJVWSEBzPc+pksl
         ODkN2xEK7hffy9UdYZwDuqF8IRr4ANsGUT59/1605Mg8LQN9dAiSFK83W8AKQEzfQrxL
         5f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715067889; x=1715672689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1bi4jNn6UYAzYQiUUn5O+wqHqVm96iTmQL0Ia3V0gI=;
        b=pbHl8GfLUw+eqKoYhExg6XGcWjR4gHjfhm6KFcx+XeE47VjmJ4HIRweuuYuz9qe6jV
         BPbiZsDNl3QbB6b3VvmaXuLUpo5xj9XykLzY9C2X6CPvVIiPDymAy046tGjX4i1/v92O
         x/jiqZ+UkH3+M/8sYpeQCWD9WmggOT8u9bstqqJG2hz3qg9IWt4/CtQ2C3KyL45TqmqY
         Aj1gMh15V6RZuegbB5AVY8tJ3HTo98Wh41Ri1GI75qCo5xk56M5LbwCpR/kAdC93YS/6
         a3wWB7WLr9o0MSBNnhrCVWGFw9mduOdt1rY3odGtk07umEfRKFIXo2ud5h0HG9uImQK0
         ez+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDVaibf4ckWHgot648s9LvKWq2wA3rV3fKcU5XpjlheSk6xjfWyZme3Qv1NLStnUWpoXvhmLnMaotAmAmx2LLLX7w/k5cFM1/ECwfb
X-Gm-Message-State: AOJu0YyIIJfJRukYGnnpbkBUbvLU+zCPidncAcx755m+SKdwFhNok1Io
	lQBG5AopIIV96w/j5rsDNzEG7q6ZklbWCnKPcDpAHvM/kYMfFj/aZ3KDL8kBcNY=
X-Google-Smtp-Source: AGHT+IEqBq6InnqV5B1ebMw5bjIhWdea7zdgrrhAfTHQbMFBGkMMYvDCj4F0RXyjXFCvoK6BKa7DbA==
X-Received: by 2002:a2e:b0d5:0:b0:2de:73b5:4280 with SMTP id g21-20020a2eb0d5000000b002de73b54280mr8434578ljl.3.1715067888674;
        Tue, 07 May 2024 00:44:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:581a:1d:3b79:3b03])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c311400b0041bf685921dsm18660565wmo.0.2024.05.07.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 00:44:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	dan.carpenter@linaro.org,
	elfring@users.sourceforge.net,
	Jim Liu <jim.t90615@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4] gpio: nuvoton: Fix sgpio irq handle error
Date: Tue,  7 May 2024 09:44:47 +0200
Message-Id: <171506788090.6452.15729262435287015920.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506064244.1645922-1-JJLIU0@nuvoton.com>
References: <20240506064244.1645922-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 06 May 2024 14:42:44 +0800, Jim Liu wrote:
> The generic_handle_domain_irq() function calls irq_resolve_mapping().
> Thus delete a duplicative irq_find_mapping() call
> so that a stack trace and an RCU stall will be avoided.
> 
> 

Applied, thanks!

[1/1] gpio: nuvoton: Fix sgpio irq handle error
      commit: 7f45fe2ea3b8c85787976293126a4a7133b107de

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

