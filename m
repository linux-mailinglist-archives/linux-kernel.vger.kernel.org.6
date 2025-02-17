Return-Path: <linux-kernel+bounces-517426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22028A380B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BA916834D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDD217661;
	Mon, 17 Feb 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z01mC7QZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA96216E1E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789502; cv=none; b=rk+IIqA6pbcdAw1P/v0JaBLifkHi/7gzFMOXZ7QFtug/JyWC4OZLBIHhSt0Tmeg/t5sY9fNONy08iTycesTopganu4+u0iHUR/ES7frP4+oOG55rAJ19mW68bb8Tgr97mmuv4mSF9lwlhx0Cc01+LluSJmrTUpZ73vZIG5R4Qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789502; c=relaxed/simple;
	bh=2a6DWia5aelo3+hT4preBpQwhiMBH04u1wwdvEZZTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIB7fWSKcfCHlVUl7fvoObgMHW8FFOQC6iXDyjKk5aM6eRiug/KTP20XNDH32b32yczNs1hWvP2KjkXk2zOGCtUh26y2E9/uvhPMu6hK+X8be+wf8anfaMNDlReW5nI6oSVue5LHJ/mR8Sc00TT/5owkA554Bl5Ba61ll5ahaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z01mC7QZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43989226283so3106145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739789499; x=1740394299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9rL7BFj/LGtJcja3SBY10iTH0HmL8V8oaNVVBtRsuM=;
        b=Z01mC7QZwOxL1/XXOMz8nWKJZ3L8MAjS0d3cK2A7by6uQfstUzM4Y14rz6xBv/zpPW
         64ynFLrOUDJCWhSemDJkL5Y1xc/m+vkZLc5PegYqS35Z8puUwKjAGUYd6KuudKb09Aoh
         2JQrdPAOnccxglYFxBTqdOi6GVooWchcKg6q9sj8JEW/+5KYRi4XpXT1TrFzWPoFzBQu
         y6gTdKZQE5/upc1psewJIGHEays7sgTxdVvh9q/SKja/ilAM02ZZrDatrSwiJlR3Df1i
         cNqYmIiZ+SykBt4rivydr/pwudfbhl5nsqjxJtzmXRZMUNR/eF3Sjk7V0KtqmaNHnOXP
         ScZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789499; x=1740394299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9rL7BFj/LGtJcja3SBY10iTH0HmL8V8oaNVVBtRsuM=;
        b=tfhSTNm0Aha9K6o14hCN5BsfOsUlIOWF6wd+pvWpuny43iKjCj5OQ/49SM5tokiUCM
         aBhtd7GnRnuTv/GGcSLie/BmL2MqGf25y17enhSiKntSEqqe2TldlBdmUheGoybXerMR
         n2sZVYqNwyhze2pQv1j/nFaKNUnB2tYlYICsMf2ULmS7GkJB4JO7OyTkgSniO9GrZWTY
         CFDxfhVGFXP3VHpKlR8jB6kGqWjEg8BLzU1/tOyNgGQ0zTwtx6s2lA6I6gVEc2GQh3pD
         V2zVLi9Omiled0rioWNv38JEYvgStP37x7WZcJUXWxdn+Qn59OPwXj7fUqlGuMCyM/Yc
         4G9g==
X-Forwarded-Encrypted: i=1; AJvYcCWnQVQLA5M+P3miYd4HVyawwLvq1TtnVO32jk1Vid9qNQVKtkGV0xkrGhUvouiiiFqYCAimgtxfRa/9mx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYfRTEh4OGscYTK4WarYcD++8WeOe6CafsExgqrLnWGeNZF97
	mqq+gxX6irM9oXbsP4CHPZkDa3RbLZcCqGGs5QKZXlCdok2X1Gp5XlvioZaUkro=
X-Gm-Gg: ASbGncs92Q9Zf6M5Ev5Fe2L7sK6mSPqIkE6bFgeagn5NJxtRKlgzMVm3A34RQLvibpU
	qa0qqMM7W+Ua9G2UjrEevNraVDdb1krYMI8iQwTIGYkzovgZg7Zya8mbboR6YO+/Hz+w5DfVGBA
	OiBhI8akgLLuBxity9+3+4mkn+x8Jp3m/3potsyw0qxn5R6O4D5dxtjqbnlIsn+cY+Wci9l/YxS
	Yz5s4i4mKMjTT4qv7PfxLySmVP71F6gEHE9DVmalF+i/AgpAyWrbi6dRbVeXRJnGIMywOitZowF
	R83k4Bhgtufj
X-Google-Smtp-Source: AGHT+IEcFZLNABjtm5sf5QsAlzR9E7GKqtzQrNge8fNqrR3LiZfoVYgQ3/KTJrrfcZCS1hAQIBqFGw==
X-Received: by 2002:a05:6000:145:b0:38d:b325:471f with SMTP id ffacd0b85a97d-38f33f1f725mr7557321f8f.15.1739789499204;
        Mon, 17 Feb 2025 02:51:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm11717692f8f.85.2025.02.17.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:51:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/8] gpiolib: sanitize return values of callbacks
Date: Mon, 17 Feb 2025 11:51:37 +0100
Message-ID: <173978946845.153202.10192575435977387116.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 11:51:54 +0100, Bartosz Golaszewski wrote:
> We've had instances of drivers returning invalid values from gpio_chip
> calbacks. In several cases these return values would be propagated to
> user-space and confuse programs that only expect 0 or negative errnos
> from ioctl()s. Let's sanitize the return values of callbacks and make
> sure we don't allow anyone see invalid ones.
> 
> The first patch checks the return values of get_direction() in kernel
> where needed and is a backportable fix.
> 
> [...]

Queued this one for fixes. The rest will be picked up next week once this
is upstream.

[1/8] gpiolib: check the return value of gpio_chip::get_direction()
      commit: 9d846b1aebbe488f245f1aa463802ff9c34cc078

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

