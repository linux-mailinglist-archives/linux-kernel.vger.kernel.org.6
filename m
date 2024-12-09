Return-Path: <linux-kernel+bounces-437655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AB9E96A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C001F18856F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F861B0423;
	Mon,  9 Dec 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1O6gcie"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6335978;
	Mon,  9 Dec 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750094; cv=none; b=rwAjA06krkCbhEfmUOiIJvbv9/o0jm0uw49WNBhEI7lOfjUjzRUYXUhbaeZ2oCRFE8UKh/J9SzW2miBsiQHkjfVVElK0sikiHt1XqmvC2EuYMGoQS8Ya8C4/kr2wbBg8tEn1W6XlPqZbPtsATh9yzXXbajw/KZxFvfZWhTOtS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750094; c=relaxed/simple;
	bh=MfxYxf5VEbiyn3dI5DjDEsyqKin/VtH5WxpgoPeQ1pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRP7o9anmkRMvhv0tZQhj4dJYnfnCDLkTMiexMGoIiSGx8jSfsm5czknOJpdN18YJ+V31f7OOa/qjmiYWTEy8vCwsVn4sYxbmNixCfNvnPmYfiUyPrZJ7//Yol1sTVFnmhzoJ89tBqs4gNHKwtTPdsqDt5ti/M/wD92Jl3UQxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1O6gcie; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2155157c31fso33950215ad.1;
        Mon, 09 Dec 2024 05:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733750092; x=1734354892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0AoR9dxGrsHW84PdOuURm3y2KtwmWWGGLrdwIjgKBw=;
        b=Q1O6gcieBUbL8v37ejFLuafMKu879zOiyDTi4uAs5KgK9brVDNsldnZ1197ZzUz244
         5vijNUQc7x1AWphrC0W7srgfrIzjRXVxiG4r+WFxFEgwZxuoyE9wEaAh0fMl/t540Vcd
         5qnQEpnphKG0fi+qpwc2ew6wbu71Hi81efn4joilqZUnCxJNVBqJ4nnFBOZsKq94g/l6
         19c0onO7SvMr9ZpddntIBAiz0PT0tzTSNfUNKrCbA+ERO5ITC47gZIc+X6aOmIZYTwaa
         uJ4ewflZ+MunzDUbPTEiugUozMuGuhPeHvbIWsZxkXUUs+0j4yVCeIvyRVLxv5CzAPnB
         xvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750092; x=1734354892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0AoR9dxGrsHW84PdOuURm3y2KtwmWWGGLrdwIjgKBw=;
        b=pIwAqbSZV/ElzVegM2R05npsxv+F2l7rwX6hwU0K4KlfiXBudqIV6MCcg/VDspn0wr
         AIvW/NtyUgmbM7FMFX8UsaBz/biPHym99DNRFNN9zmYr8lm80Nn+e6qMGusO3WYj9i40
         6nSgwEGSrQP+vBkQrOj19GtGuHUCu5xYvlVdgBafmiNWTUbFBqUC4osCIAzWjFaL9I7p
         mk+PjP8jmV3OeqGvXGPUGNLiUCLQqDDNdSr92maStmZPI60s3jNcYBoNxpqD0Ex6xWp+
         hB94+Z3G3/tmFXgwgwJCPnukbaSklmmwrDefaVWFhBN9eWetupPd5NmzhSpO+T1T0Dso
         uisg==
X-Forwarded-Encrypted: i=1; AJvYcCUd5FlFwjl7sWum0hHfS4rRQQWX7SK9pquEMmzhjsmc91y3NVqP7Ydy15ZQz5LcjsGq5xpPEJYl2sBBopFvW8g=@vger.kernel.org, AJvYcCW7V8XvMloruqWXhSoMAuKEhNvb1AXTWGMulOrXokLZ3EnjF3Yj1KWqn1uGwUUjjDYqDlq1KLYkJJj/u9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r3VoIi9nqzjYp8lIRu+zrYCb/FXqBEujVVQDrYUeInhqO/MQ
	+ThGe3X4lye0ECaP5u29TZ31TTsYsY/WJwOxbwWonvIhI2elPuJb
X-Gm-Gg: ASbGncu3eJZv8nOBGw8vu8HQvlfhkMDDU/2K9LRlGELzwmo2ZmrfRxK8HEytAmtxdNh
	WUIL47SZxVxJdGLQxwYfjtL+0bQcfEkpN9jPe1JO9oQrOPWlJaVIBfNqIqXWVlti8FD56algl74
	pXhxiarDjExwgni98bOWQXRfwp1HQRMVLvcLiR646xY7rxWxuK2RZE7JyEkkEs+2WDZr4OX3gyM
	K3k+KLdiYKwbu+uKFD7wB/UfaZj6DhKfHHTJ5o1AfbnnXmx/WIM956o
X-Google-Smtp-Source: AGHT+IFnbIyA3QAa1+sJSNailitjbXdS3Z9D2DA6Vxm31zJibMVTCp7kT8Fo2gRqGBqkEkHZ6sEu7w==
X-Received: by 2002:a17:902:ea0d:b0:216:5448:22c3 with SMTP id d9443c01a7336-2165448255amr44181475ad.6.1733750092235;
        Mon, 09 Dec 2024 05:14:52 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161e9a6491sm51441835ad.110.2024.12.09.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:14:51 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: daniel@sedlak.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tahbertschinger@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com,
	wcampbell1995@gmail.com
Subject: Re: [PATCH] rust: macros: add authors
Date: Mon,  9 Dec 2024 10:14:43 -0300
Message-Id: <20241209131443.415158-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <23097a11-2bf3-4ae0-a1d8-9df5f772e15d@sedlak.dev>
References: <23097a11-2bf3-4ae0-a1d8-9df5f772e15d@sedlak.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Daniel Sedlak <daniel@sedlak.dev> wrote:
> That is true, it could be part of `checkpatch.pl`, however I would argue 
> that if we can overcame the formatting problems by repeating the field, 
> instead of modifying `checkpatch.pl`, then none code is better than some 
> code (regarding modifying `checkpatch.pl`).
I understand, but if we choose have a multiples author, firmware and alias
fields, we need modify some codes in `module.rs`, and I think that in the end
is the same work, because if we choose have a multiples fields we need change
modify the module.rs and if we choose have a array we need modify the
checkpatch.pl... 

It seems for me is the same work.

Unless you convince me otherswise, I think that is the best thing is to
maintain this as a array, and avoid boring scrolling screen.

On the other hand, I understand that the module that have a author, alias or
firmware a lot is the minority, and the marjority modules we don't need
scrolling screen a lot.

Thanks and regards,
guilherme

