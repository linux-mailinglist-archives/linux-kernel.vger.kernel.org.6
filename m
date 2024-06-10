Return-Path: <linux-kernel+bounces-207780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F132901BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E91C21947
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD32C87A;
	Mon, 10 Jun 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DQmSOd6N"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962BE224F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005121; cv=none; b=dFHwLvDE34eDko/KIvVRp8vcZDMG8Jj0mbQjxCfyWMamsGb5d7hM6QgHhBO6ICgOFRlcsBPysYfDedGAmX/ZluP6LyXOnjVwXOUjcIPGD2Mn/WMsNZcs/XDHsG8GO1wnFcOcqT+4RK1Yl5lSXS5vIqlkLDy6VLmMq8P9IKM7eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005121; c=relaxed/simple;
	bh=J3TJUg5+q7YP0MGTuE4DpuCVtIoec/4jlVQ+5HhQKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdkUU/9YHtVJWm2dGQ4KR0AD+ouygYHHoSuCubMek5+gV7DzqXwDK/xuKqajL1y5UEPjcv66SNXvaFUCgURuyVs1ZBeA3hhbTISftSw6Aqfq7ONpK5FTZI+9zH3LC7Eyakb+IO2RP+8wczyGhuuAWtM00zexgfmmuAkqmLcUgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DQmSOd6N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421b9068274so5805345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718005118; x=1718609918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3sXZnTrFx1FLNku3UarqNq102veh5s5DlicL0ytOPY=;
        b=DQmSOd6NrsPxmPI9wUvdC34r+48+kXctKUkQSLIt62iTcVnng2BBOajz00JROXCrIK
         H+UiCAAg3lnkwNCVIOtEbAHd7Fojb1VMTayHugyLaUtJJpUP+tfRVaxTHr5dUJV62B0G
         eLHT3Zz9S61VLepVcyBSsSR71apioNOFgs+jn9ZVEGn6HciNj4vbAT0un7OZ8Aigpb6t
         yYceJYG9ZWvaMIFKXfXoMoN9cgg2ZEhzyFupzvwjGQKMID7SVoDlMb1rFeOIF9MGiWS4
         zj/ZJPCjUDjgjW+ZeOZvqodl8leEvlBEYL9GBkFA02lZZCIcku+JFQ3LNCCMitzLGsw4
         MSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718005118; x=1718609918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3sXZnTrFx1FLNku3UarqNq102veh5s5DlicL0ytOPY=;
        b=iuyP5XDJh2fCIDmwNuDvVsw/qdex1qwVEJRjwFUlhp8QyGe7lAguVdI+di+u5MXpcH
         Uarx23cZxSsMRzyGOcGyfCN3+Mna8+zjjxHAjh39DXE6WoWnrbQyg0jSHBwdWStNTMqX
         g4E0668aTy+Q9+wECuBroqdlbP9HI0qCJePgBGodmPFV4ie/52qD3gsUgpgYSr8Qu9zC
         AjYhTVcnDdAVIjQEJY0EgYD92Y0SkzwoT/MNF2F+sK/JgULk58KREmH4DGeUlRF2AG6A
         /OqbN0zm1cssKwHxaIGsiXy5Z188Pkj1XG8i2Fqd7qn2j6WZSFNaE8xVbeuF7wD/fcEu
         rEHw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDbnewh0YzCiVa52HnYhq6Kl0wzDYctdr9qKJkoX0oB+LsslTV2n4ByGBxb16dL3mnNloXaOYkfvDjPflOGpt4V+K/fSOwy4pgdXT
X-Gm-Message-State: AOJu0Yy19+bUkmxNSXxfmYwskOSZq/akCs8TxjZmkS5u5lRP0R4qqFTT
	BxeltpQf21/ZZ4DsVU63SU8+BgFHnrjeYh2I8tbTh4X/pULHMeYNIlJ2kb7/fe0Z2rMYaD0q6YB
	R
X-Google-Smtp-Source: AGHT+IGv6yWdP8pzscvWRA8dl/BXTGiMUSwmqHfHi0M+GCIMctO8PARtwXxuupJU4okqHnTCWtagZQ==
X-Received: by 2002:a05:600c:3c94:b0:41a:b54a:9ad8 with SMTP id 5b1f17b1804b1-4216499c726mr75618785e9.0.1718005117749;
        Mon, 10 Jun 2024 00:38:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:b790:b49b:9038:8e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe371sm166778035e9.1.2024.06.10.00.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:38:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	Huichun Feng <foxhoundsk.tw@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	corbet@lwn.net,
	linus.walleij@linaro.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	warthog618@gmail.com
Subject: Re: [PATCH v2] docs: gpio: prefer pread(2) for interrupt reading
Date: Mon, 10 Jun 2024 09:38:36 +0200
Message-ID: <171800510952.16671.14245266233040448666.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240609173728.2950808-1-foxhoundsk.tw@gmail.com>
References: <20240609173728.2950808-1-foxhoundsk.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Jun 2024 01:37:28 +0800, Huichun Feng wrote:
> In legacy sysfs GPIO, when using poll(2) on the sysfs GPIO value for
> state change awaiting, a subsequent read(2) is required for consuming
> the event, which the doc recommends the use of lseek(2) or
> close-and-reopen to reset the file offset afterwards.
> 
> The recommendations however, require at least 2 syscalls to consume
> the event. Gladly, use of pread(2) require only 1 syscall for the
> consumption. Let's advertise this usage by prioritizing its placement.
> 
> [...]

Applied, thanks!

[1/1] docs: gpio: prefer pread(2) for interrupt reading
      commit: 7f1e45f4ae7671550e15354ef87194bccd99ecec

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

