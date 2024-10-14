Return-Path: <linux-kernel+bounces-363516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2B99C361
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1AF28243D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBD1537C6;
	Mon, 14 Oct 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HKboHoWF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9911537CB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894710; cv=none; b=mHJk5UXbEwC3CRJvkH+rU5R29h6UKNOWwgtTSDgCboZ9X/zp2NWzgQ+iezPGC1r8K4n3yCedR/JmLOW+4/Ey1AL8RXpOuSiF5TfsBHlj0vLOPU+1koaEqDyqHnscf/0gXo8a1CoB3lVZxYQn3WbC0c7h9KQiw5ET2sRf2otsKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894710; c=relaxed/simple;
	bh=HE9Al0va2ODYdhqdHVSw+zk/FQ8zaom4PAMPAZIm4VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMof5W3Y2ujhRcZnaqdzMIkLya50YzTPWlXcvXbzwZ8ffgv7B6pYxxb7jGPTsyv9SbF34WGG+bZEGJOni5Mnh2HL2eZP10AptSPmBqgTJbgsmLgadMeAYNaanLHrdHsIOHzbNX6+P89o7+O1i/pDjt8aVvwlDQofuObIIKo6fGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HKboHoWF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43118c9a955so32400045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894707; x=1729499507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwyhr6igfpTKATOiexahVRFN/HJlXGuClRFssRVX40U=;
        b=HKboHoWFFgWX/sztaZ6yPb8q76DEAXXazDDnsIm8h94VNPMbqeQePsQ6dKAzlyvtc/
         BDOjWfszPT+QO/Kejvoz3VyyZC8mUTo6t/2kztod/u++oH8JeFtCGkbPXmi7pYBeDQZD
         my81fbpJghINu6wIreEjqoQcPjoxfg56Ilp1CKxZb8K/pdVeCzkl0nOdi66iU8QeF1PF
         5l26T+xpx1i1lRf1NtrlAVylSiXdm12oY9qAXVBcjGf+6FDvS6AmSVTpVBKR79wGRa+2
         BzC83OEuKM5LxcbZbijxQDswvA027EqpnEJJLpcE09A9rrjmKWWzm/Xak2vioXvtMQy9
         v51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894707; x=1729499507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwyhr6igfpTKATOiexahVRFN/HJlXGuClRFssRVX40U=;
        b=d9bbpOI8fLA/FaJVnpEZ8ylvhkky7o1Jwcw90rcVM844v1N+6R5P7FyFEfyiNak1HR
         ZKe2EVn2/u88p+WshoZRs0cd8E+1ZRe0+xS2S5hfYCFeOgnkHLE49Nbr4iBgWdqevrAK
         fjXnWdNxwDYfQiycRbGsvqQyqrj53eDNu9Fc3bt82+mXKqm11gQVthjNcshgs5WME2B1
         EAkM9XiyzeRw9GzjOw97QHb1afXdSOpVrkj5mldS/pk3egy3Xy+E4d280+Ix0Ju3Y4uQ
         nAcxRTKvLwLlqplWST7Ubnar86fOoHGhxQYI1WZvE49DgY67QaX5QdLGrEgA9u+gNR7N
         0d8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfEb7IMwkxQloR5Wety94RaElVhM6ml/rC/7Bjjf5FPPS4umlO0TQIpOnRFXpmwKMdercHQ9j5N2J5LgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8b0xpIVEPbSuwqY0B75P1bqB9UA7ySRHnw6k/1QwtmPNjR/u
	wMhNW90SxaDRCKRtsOpK9O1L7Y+PZL+nx7wLqMrLsLgydF4489d2yjgP4Zy5BhI=
X-Google-Smtp-Source: AGHT+IHjmfOV3l0GUYHjsDipojoIx4s0Y3U/KcM7Q0ddNaeMxL+7zZKbix7PDd9O0FlC94490z5G5g==
X-Received: by 2002:a05:600c:510d:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-4311ded1c9dmr84550955e9.8.1728894706885;
        Mon, 14 Oct 2024 01:31:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: eic-sprd: use generic device_get_match_data()
Date: Mon, 14 Oct 2024 10:31:32 +0200
Message-ID: <172889468798.57095.4871472029437960734.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007102859.35602-1-brgl@bgdev.pl>
References: <20241007102859.35602-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Oct 2024 12:28:59 +0200, Bartosz Golaszewski wrote:
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() instead.
> 
> 

Applied, thanks!

[1/1] gpio: eic-sprd: use generic device_get_match_data()
      commit: 1396470c11d4f30b4d4f444adf353848b48c74da

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

