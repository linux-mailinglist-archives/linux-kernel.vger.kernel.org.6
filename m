Return-Path: <linux-kernel+bounces-199106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E368D822B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E30DB25BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E112BF34;
	Mon,  3 Jun 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ThatlpO7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DED77118
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417442; cv=none; b=igtCcNdSboJDfheo8FuQk/R63R8hOc4J/euAHYC9tG9a9aJ65ZdvTg0HKcB1DwOjPlFyYu6QJNILQiWtN9O10+fEKcsjysUUGjg6CUzCuQWXl7peSSJtQ+1ewqDpSGMpDe4rbqMUwePv4dn0uIn1zcbUz8wq4y2KRyBUwJsPVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417442; c=relaxed/simple;
	bh=sdzFus9iWb7MdyLcKMzB2O+os0H1yvpL3U23jpmxnik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imm6SLw9duLBjsTQlorXLvvXMWJf9PL+WQ1Wljq8VC5A8NGE+bno2TkLeNuyvmBOGdvcdGX4/f6zyLpkGk+ku1XnWcgTAZr0KFc4ZDdOkURtgwca+Bj5UQ7/omWjIig+44G8xRpwwr+K40QHQyn/Sp1m5ay2WvPm9ZPUfFyxBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ThatlpO7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dc36b107fso3234292f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717417439; x=1718022239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR46fXcoXv6ChkybX1LtRgF9jjoOYKn8LfgvVCf8DkE=;
        b=ThatlpO71mXGVfaR864SxLJtMTFtkn+s93FIUPbRCIsqBDoSrOUWBNomjsQQxpnbBv
         PuSRVO4RrPktNLGOY2e6Zycfx012WnQX+0zcKn9+jvo14RXqgIAKpP1UIWPEUzOLHCt9
         bjqvv5UMqkLhsYhdVaKC+aSw+2n+wvtLmCzksDxf0wTeOaa6Kwfuood6yK3H06A5FI4b
         rHnOazVm4lkQlNPwcIyUL0yxf4hPiWqZv8M+N3Q8hUPhNfrCsrav3ejQY8dX5Z0GH5uA
         E85v84043aDhJflDgP9JPKl33TSqFWNFPH8U+b8f8xKgjutd1Yc8Vtkj9MYufe6nhOy+
         /efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717417439; x=1718022239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR46fXcoXv6ChkybX1LtRgF9jjoOYKn8LfgvVCf8DkE=;
        b=VxAtNr/vuYuC6piPYP2g8U34xaGP4y4cPZ0VciUJSbujaPXvbaqhQA5rr+IPhxgdZ4
         k67NUbHrQg9jA0c4PNJBkF5vCTn8voSYg1rYMhz+leC7yIfYTI2NMr+HErS7zrh2wNa9
         WW9jzhtDvQPCSegt1Plc1m0lQRLQJ6gsAcMvqY9BgRCXj75nRoNWXCLsMl+7yd2pHZHL
         fNL1v4MEzDjsmxRbWVsvlgYjRi0JvZnKhIOvCYAVNyiO7Vum9tx4Upv5oQK6FH1PUPUv
         mYP02WVrAmwmmrFx1yAd4ROJcYErLur07O3gSnFOezxCWdNnmBXUFlIQtsovh6t0YTh7
         9gXw==
X-Forwarded-Encrypted: i=1; AJvYcCWjG56fNvO5qV+lBG9NlPCIboIDmj7tQv0W4Hp6eH7JwjNNGaa7lvTHTtKMoxdAgYmrfK2uZ30zDJIe3MAZyPkBQSXWrGjeWLAXZrLG
X-Gm-Message-State: AOJu0YzO83Vf4K5hn0JZxb2SZvKg+LLWjcPTM6+DPDlRO8Ediu2le6Kw
	Rr8SmASB6lx+/Ncj+vWiymQO2iblzzIh2H15oqssvPjAd1tpSOSvrIFCx/g2kSA=
X-Google-Smtp-Source: AGHT+IHB3TUN3a1VvRb01F02ldgZaivCRHBmm9DVppPgU9/moWf5g70KbShoONHjFApsB7/wMVBgRw==
X-Received: by 2002:a5d:5f8b:0:b0:355:796:15ef with SMTP id ffacd0b85a97d-35e0f25e488mr7585207f8f.10.1717417438990;
        Mon, 03 Jun 2024 05:23:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:5b1:48e9:27a3:7085])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e8fsm8687533f8f.2.2024.06.03.05.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:23:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/4] gpio: tqmx86: fix typo in Kconfig label
Date: Mon,  3 Jun 2024 14:23:57 +0200
Message-ID: <171741742898.63658.2302976335873675404.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e0e38c9944ad6d281d9a662a45d289b88edc808e.1717063994.git.matthias.schiffer@ew.tq-group.com>
References: <e0e38c9944ad6d281d9a662a45d289b88edc808e.1717063994.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 30 May 2024 12:19:59 +0200, Matthias Schiffer wrote:
> Fix description for GPIO_TQMX86 from QTMX86 to TQMx86.
> 
> 

Applied, thanks!

[1/4] gpio: tqmx86: fix typo in Kconfig label
      commit: 8c219e52ca4d9a67cd6a7074e91bf29b55edc075
[2/4] gpio: tqmx86: introduce shadow register for GPIO output value
      commit: 9d6a811b522ba558bcb4ec01d12e72a0af8e9f6e
[3/4] gpio: tqmx86: store IRQ trigger type and unmask status separately
      commit: 08af509efdf8dad08e972b48de0e2c2a7919ea8b
[4/4] gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH interrupt type
      commit: 90dd7de4ef7ba584823dfbeba834c2919a4bb55b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

