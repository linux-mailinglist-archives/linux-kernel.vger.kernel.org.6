Return-Path: <linux-kernel+bounces-237528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1775923A58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D979B21D76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75609155CA5;
	Tue,  2 Jul 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LtUwbk09"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70F153836
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913291; cv=none; b=XDNjj09asZSgfsXdkRvZSn12+kkYi1PZmEKoxKMk4mVy5Xpc0JtVUsg0oc07sLuVe8qxzxX1A5xPPNSyZSVM4wnaNIQhXwnNncXIvPWL7n1w7+wUKxAK+aCfbmpsqIdHMb+ZVO83xdqPjvza2o42abSTb0tlSnRjh5we9+cJrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913291; c=relaxed/simple;
	bh=kxWmBl/62F6kGkS01rbXx3MfKTWBN/DQsH2ryOG58n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vl6YwesE3FMHojZKhs8YUjHO6ERVPsfHfFt/GZd7G2P/TcxGYdgd1hDG8uF4lSaEMVHTxX9NaIxC4nw2W/bT7O5kUYn8ozSrtyh3I1+wmBtjQoG5vf3svvkYNu+ge6WG7TAieLs/pP/8FtynspH9974c8QNzKj1sey3zlQdpnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LtUwbk09; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42563a9fa58so28009185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719913289; x=1720518089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE0waSrgtEeU0HkldbaEfxX0jG9ixu+KFSkm+VwWqgM=;
        b=LtUwbk09LHEpI1H3BgtRpWN7R5TtEXkgkvonFlJmeFtQLfFRoBb4gsrtCO/0fc23qc
         k8ie+qlVWSbFgBOWLRRVg/RSgNMG4ZpvkcSdgAcGgkfk+b84ddj4VxjIKVQCeqtAJcHj
         5E24UtCIzuys204RdgPIyYjkegkq78LEqIab9rw2ZJyOC4cB81x7l1oJABxeR5aPtBLy
         1RsQgpi9eAK6Q94Nlxm+EZCu/8UAec0nZNmWvxr1FgMD2AeboZVQCYGrB8PNDTgsN1jh
         97zB+F35s2NhfoPji7tANlPYaAzXcz/3thTHQKXXPKnCmCfyj++YVHABSRVurf7QjP9y
         EMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913289; x=1720518089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE0waSrgtEeU0HkldbaEfxX0jG9ixu+KFSkm+VwWqgM=;
        b=B/awHrVaBWsYj9Pfmjdr0eH0Wo8eElBiZtdZxhfBuBhHKcNtbgKL5mUIECPHVu9ynX
         Uarz/bQhA3zk+tm9MVo4o0YfDwThOLroPSAetOYFIASsX3wBSmGAk1SWlOpX4C+OdY0u
         wgSQRaRN+j3NkCqWC9sy8I/FSTEwv0c15PtHsy5CLyLJycByHKYMZWZ8brF1jMopyWDZ
         tLPELNVA9nvXrPm1Ra0lGOu5ZMhlZAUBqaj6btRlX0sQAQkpXbYoR624vjMLwNkLjXqe
         zpoJ/rbVTUnEgDNgw20f65V7A7JAgEh2O8wjLNhYwk2INB+2K6QcC2X0dEw7NsxSw03/
         NuSg==
X-Forwarded-Encrypted: i=1; AJvYcCU+inlPLxOj1Qo1s85DHd5F16iOUwINc2R3yxAiUAFPTXVlqXYh6a6F142azT9zcxc0vD9vRmIKVRZg3eFlpoSV+2J2mV/FSd7tvZUZ
X-Gm-Message-State: AOJu0YyScQvAXxnPU3KF07y3wWKBpkfnFytgIeaVw0nIBbYwlz8gJT5W
	Hq+o3h2HOGQQiWGwA3suBaTpxide+EPah4oC1tvHpMICyrhqCkb+cKoKkLOgfBc=
X-Google-Smtp-Source: AGHT+IGkyESW9xePTb5X/hnH8dGkmvMTF0N+RUyGBGuPtMLfLKFbJSjRsa3XTlj/FaSou+MTpduycw==
X-Received: by 2002:a05:600c:4a16:b0:424:a779:b5c1 with SMTP id 5b1f17b1804b1-4257a0114a9mr56336445e9.20.1719913288699;
        Tue, 02 Jul 2024 02:41:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:628b:5bc8:edc:9c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258014f8b7sm95708385e9.41.2024.07.02.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:41:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: unexport gpiochip_get_desc()
Date: Tue,  2 Jul 2024 11:41:26 +0200
Message-ID: <171991328463.12913.15479546795148049516.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625073815.12376-1-brgl@bgdev.pl>
References: <20240625073815.12376-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 25 Jun 2024 09:38:15 +0200, Bartosz Golaszewski wrote:
> This function has been deprecated for some time and is now only used
> within the GPIOLIB core. Remove it from the public header and unexport
> it as all current users are linked against the compilation unit where
> it is defined.
> 
> 

Applied, thanks!

[1/1] gpiolib: unexport gpiochip_get_desc()
      commit: 6f2a875024993449f1b19a144d3e4391411a1b51

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

