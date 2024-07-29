Return-Path: <linux-kernel+bounces-266176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83293FC07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EE52832E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18F15EFB8;
	Mon, 29 Jul 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="do2ZnoLZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BD15B97D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272626; cv=none; b=SX6cZE4jvTh20zotZuvxUsZ/RPXTDzue6/4leMlEJKQW8nNcnZpfvkykuPtRbrAS8XlxVkxuaskktQAb80oXRbxIPaGhWmHWn3g4h+5aw4fCcB66PDncZyzpB8JQwwxFg7KJJXO9wo5VJZFI8WCb6lip1bpIcsqLBqwxL00UaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272626; c=relaxed/simple;
	bh=9DITD1sQ0c/mffmy0n+p+R7L3gsOgO/klKURj2MHIRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iRayiwLqWjE9g3vEtdkeROfSv80hhgW+ZRyjBss+J2JbsYWoJCZNSG0vPIXoMoC0ZgQg3ZevTZ9GWYHNlgSmvu6NQlXlqt+IolFbcj4igWGtAUnylybHXkm1n+M0yEje/fwSfN0m9UkroMgzBPX4dvlIUJg/iwLqpj0KeeV5DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=do2ZnoLZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so11706545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722272623; x=1722877423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4QMJ2vu32awVFR08ex54N/5/opw4a1ucxK32751hSU=;
        b=do2ZnoLZwmJWdlwQoKT41ukemzPDQdWpb9Q1sD+QfAKgh/u/nH8UhzTQ0A5MQg4sNy
         yskuQ1VirCeYlS5b/pTjwyp45V8E01ZRQ7zVfrrF/jxp6J/eDc9+gqV8ejGRPr+ow+yw
         WRjAq7tVHdujs6elRPvMD2UDEmZDfOyAlX21Z2ylqNpMed4oLwEN7Fb4nJmnttaT+/uS
         NkDZoQ2HrAA7o56r1NMUFvtO/YPadV+onCoJBHuQioQyvjIIu2SZKLN9tKc/dzqVgMI9
         o5wqErXxPPpgILCGyQ2IBrWN0NToX7G5wt8Hdhlq3PCMK/pWirsJ4zjsKXjY0SbJzbGN
         x+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272623; x=1722877423;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4QMJ2vu32awVFR08ex54N/5/opw4a1ucxK32751hSU=;
        b=dfLSBFeJfTzLwrId8B8ICUoIzVMKDkTqzaw+YCANAiwUZg06cKHXA6IwqiN9tA7JVR
         UU67E5Wsx/X6W6onYh3w/O75hKgDmTWzsi80CfiR2M3bpblcWCZa2NWY5F6RbTV9WvlR
         nwu8TC+avrVlW5g98YgeK8kBWnCTn3SG7Xaf2n9GmCNL2beWIAXWBH8nhrcZqroTVf39
         Koyfnw6rwB0lLT4TQOj+7mEJ4m6YP3bdBfo0qia5mi9Iy2KZxK8SatzMx90uaoLHSW/z
         Auy3yIsKLOJOBcpD6NXmPgXfcAO/eoIQM9fdoOvNxwQL6Bak0hfgBOJao6L/2l/LNSxw
         oQYQ==
X-Gm-Message-State: AOJu0YwErHybfj2rLLNLTR2k+R6Wg1LLsF+SkYnrWDpeaBue6a0SWrbe
	vG9od93MGfRNNfNyfXiSBDjiMtJmbjCAfpoxSv50xJzlxfaups++Fyq16dZRQBA=
X-Google-Smtp-Source: AGHT+IFDDBwmSOgvzrJlt7lNEcKvYu9x6l09Cch+NOr9qiXQtZC+LH7RjBJs+0BzIHEp5aK7b/y8YA==
X-Received: by 2002:a5d:5710:0:b0:36b:33eb:f0d6 with SMTP id ffacd0b85a97d-36b5d7beea6mr6206706f8f.2.1722272623164;
        Mon, 29 Jul 2024 10:03:43 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36b367c0668sm12712416f8f.10.2024.07.29.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:03:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-clk@vger.kernel.org
In-Reply-To: <20240719094228.3985595-1-jbrunet@baylibre.com>
References: <20240719094228.3985595-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: meson: introduce symbol namespace for amlogic
 clocks
Message-Id: <172227262256.349016.9112945226896279160.b4-ty@baylibre.com>
Date: Mon, 29 Jul 2024 19:03:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: meson: introduce symbol namespace for amlogic clocks
      https://github.com/BayLibre/clk-meson/commit/adac147c6a32

Best regards,
--
Jerome


