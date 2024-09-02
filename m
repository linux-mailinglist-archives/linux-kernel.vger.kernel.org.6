Return-Path: <linux-kernel+bounces-311063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E2968471
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228531F239D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9A13D8B2;
	Mon,  2 Sep 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hE7DqvO3"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAF13CA93
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272324; cv=none; b=lLw0R7wT5lHA6ZN9ywD1MNDN/94vnhkQcyY6itHdONxt7RSokl+nh2YDWvU3iSb31l0tKx/e4eEqBb1e3hQx3SSGns7mUvrwjzsLqjvgf7/I6q35p0f7BjUlOXzWyArnlFMOkpczfRfw9vRIZsJniYnHYX/0ABn8uhiig5SNBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272324; c=relaxed/simple;
	bh=NswE2y90mim75aJCfzrIx/4kaVgnl/JCkngqK8EmH3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGdXE+IrPN5QYzTtuCVwhpjTc5QDwGWKmnW5LLQMak2n3ANv/vS9CgKkpGXPX25Wtk95lkqsmvJviALCn6VW25WDt+dlookHU010ujxOvdVnEr6k0fdYKDydvEuKgEHhxxjFvo04qeOBv7dJf6hxPTsdlpaFyZdcni9Gypfhsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hE7DqvO3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so1136874f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272321; x=1725877121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4QFj6+ALzemNgN4lMLiLnoXr0Dgmd+rfQHvi6JHSU4=;
        b=hE7DqvO3c4gBinpQMDSnZPRoV8pX5vm91UauI4my57VTEUL0zh46nW2bbCzTz3SJtn
         bcjZrJww3e3T7BZb/YllX3vrcJSZ9OUNo2CV/FUVn5KV2Uzd1LbKwj98T3t/KP4He5vx
         AWhkSz7LjhF1KqfQVk/aYfGJJvDhrlicuNKJaDEaqmaNstPjX3Fi4XvNujnJGKY6UR20
         Cpv8UliykJkaPCYjKad96hdcTRLPX44QzsUSKLebS85ZIh9cWG2yV5mwQBjMz1COyVmM
         IfzL2MEp1kzP/4xl5njwyf/IDIqkaiwc9m0AZsqAKcBCaY2xJeC0ZCBLlNvQCpgyonIU
         yfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272321; x=1725877121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4QFj6+ALzemNgN4lMLiLnoXr0Dgmd+rfQHvi6JHSU4=;
        b=SzlV1M1nPeMANDKR2SCSUpor2ZyDcn+GBOXNwaI4VMtJ7GJ8jNBa0zu748jzd27QLi
         yFDa6S70d6nalMUJJZSsRrCG3D6ithqOBA7XvzCOcFr2PFk3GyYIaR5zjPOr7/BRoHDs
         YUZaW+nrcDpOpZv2j83m2dHJEq9LRNHFi06WQOoXS3cHL6onud+qotZoaj0JGRQ2QghQ
         2tgrVCoiTQo+qbmE6TVUmnB9YaXsdENjBoQVkH7FNhmOJf3O7qpiTpWpEvrJPtgJeUGQ
         YNc+gMCpjopuNh7eFObkhR9F+Wai5f11a6Qkb/qKhjFBQl+Nqt8eluETDCPtMpjyP8pH
         ILDg==
X-Forwarded-Encrypted: i=1; AJvYcCWimoxnYoCULDPtHS++UJ8HK9MhPHlLXABEhLNXJjB8JWAeSmdXCmFihJa7jmnrWBSzHQe1WDtyiBxDXCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmapYNzs07w++G9HHZ1kKuABPzEhDKv5DOKcPadb/msvU52OLX
	GQSlH0EW7LMeFt8MVPdohdPctfcX8qtUdulffqKd/VkNTjOguytkXdwrEuGyaQ4=
X-Google-Smtp-Source: AGHT+IFwmJjnZR4B4GeO/RdQeVrzPp2PLK9pFJJJBmJ4/xvVUXdeCjovjyuyfoWfQWIbfsK2FDyHqA==
X-Received: by 2002:adf:e604:0:b0:374:ca43:abff with SMTP id ffacd0b85a97d-374ca43ada7mr1644330f8f.26.1725272320556;
        Mon, 02 Sep 2024 03:18:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cee38722sm1190892f8f.112.2024.09.02.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:18:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Richter <rric@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: thunderx: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:18:31 +0200
Message-ID: <172527230207.24237.18438688734291858387.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822225300.707178-1-andy.shevchenko@gmail.com>
References: <20240822225300.707178-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:53:00 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: thunderx: Replace of_node_to_fwnode() with more suitable API
      commit: fd7f4d67469d701f5f5fbdfdb94875fbe8b5ad15

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

