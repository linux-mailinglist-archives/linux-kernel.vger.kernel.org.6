Return-Path: <linux-kernel+bounces-525236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31BA3ECD5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74353B934C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF771FCF62;
	Fri, 21 Feb 2025 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlcTKdCK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988D1FBC8D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119634; cv=none; b=aRRJV0uMUWS4ltRcYKEfgp0GIzQFhnXiOUQed8+M51X+dro5xHYE8lpijwP3mQff4d0VBfVn/g976QpoiSSOLH5DVLAWG/dQx8JOSc6j/W8WR+hBlb5k3W2JnNfnwqKKyxsHxu3sIxvM7vb+5kFFQlB9Gq3ZVj3VJHTx9Gr5HsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119634; c=relaxed/simple;
	bh=UnV/+GfcAYzsBk/o1/mbrqjdXTKd+qmvgLBpMdIuhrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYqg0pTU/KbEl8rGolDLfeTYgc05BgCBpep4MkJrSWT3nBlY2kwY8X3BeCl0HUSWsyWNrX8ttAQ4ftFYyUURlP/JDMP2a6+0OhVnjRFw+YfhIzKpHVRc8K+E6hPDn9rIMtDrD8VmNqaMF4IZ3ivK2VYXbavhrZYPVf8OnUwUyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PlcTKdCK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220e989edb6so48330615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740119631; x=1740724431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3qkD2W8GHPxS6rjoat2i19yWeUXmPG3MQqxSAFZ/8c=;
        b=PlcTKdCKDpi1QO7NG8AQYezLG/xToMvncu9ycJf9FhoLe2ZTRb9jfTPK998MKrBpKn
         +ZOVThGps+zEJqqz6fLAa7SrK9Fz7ahCfSRTtbfR1NOYrI6EMF1nyHuWV9M3VYU7g2b3
         EG/ldhckbswoCKjp7JNIBeyV1rJFjPipK/xeR4/WQx4W/WdjK0M4uyEFgahdrRObY5hh
         vIS+mgHgHllHQjR4uMArpRYwdyiEQu03hWzFejE6rKIFz97MQCMUPz03MolP2V6kR6mW
         1y0/mKdP2RV4MdomVsLK0ZwQ3xoR9MsdH/h2iumaq1XcuCHS6jQA8Atr2paIfNikn/xL
         Nzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119631; x=1740724431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3qkD2W8GHPxS6rjoat2i19yWeUXmPG3MQqxSAFZ/8c=;
        b=Jc7l5/OovO1p6TTk4naML2hSMDZsaSdp7Hi6CCB3E18y5gXkl0RZHB9o3TS6NKzEnT
         Mq9cOKmV3pQfNTZe2/d1XjcT27PODtxJdlrYYGf1B3JckVePmPsL9+VYhP4BG+XDabBS
         hkwkWiMGB3BFF4gHcoeazY0iDegbct0G4zPJLP5GAgG4y0Uds8H1GRrQgU9Bh+yiSjl4
         99SscdtXBTaWvPTPXayD3KMZod6sjKHM3SHY/C2NgOMF0UYj0gnjdBQmBWM9yCPjDZuq
         E/Hn/svA84G3Y0A9jeZBp37nXMKKyUTDtBnYtsL8aUuffHDN743D20CN1REjGX++IAn4
         WGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWKtbmKaNd1+nCHkFBraKiZ9N2tvrxGYJAf/DzFjFz5FvjzWrCIwHUAQGROukzfGM8yYRp8AtQ4d3E3u/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42AOuOkRaTFexE4tHEq0Lx1Kol8PZ56XADXv4snDW8e2g/gUs
	nAuN9bjT2WD7RCNAqeENHeEzH/Mv4Df13gMh2IuY/cK1oYo1pfYm48oJkS4JPR8=
X-Gm-Gg: ASbGncucxenFIz8TlAGtJZHk43EGJqirzoweq5vVun3wCSmZolodqiAFp+6s3UxQWZN
	kJujK9InDkhpT/7sNXtzovNoCWzAMrFGr0WJacpAnEGVUhBkuirqZuxMbU23/xWGssQUUrDs6/5
	yP2KQjSB03c9cnvxtQoXFLV5rRuUXg5lV/Z1vuUFXasyFZq6BtjU07E35twOxROayqZ4GIfZ3pX
	rRyFlkkosE1oh9gYyUJLQq5UcFkY7Wr8d0BxebFOhPeQgwJnCCSJKA8hi7QZSUrzBVt+y2beaXs
	6+8PIyvLM7wlqZYM6UNCvMaCsIwl
X-Google-Smtp-Source: AGHT+IGBFTKUqNROscBFlXFQPsAysi8TjZrSjaBBpoMwqoUOJ2o4jmxLvYsGM0FXUS1xsZzgGKCJBg==
X-Received: by 2002:a17:902:d2c7:b0:21d:3bee:990c with SMTP id d9443c01a7336-2219ffb5fa6mr30105085ad.42.1740119631572;
        Thu, 20 Feb 2025 22:33:51 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d7dasm523355a91.5.2025.02.20.22.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:33:50 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V2 0/2] rust: Add basic clock bindings
Date: Fri, 21 Feb 2025 12:03:37 +0530
Message-Id: <cover.1740118863.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This adds initial bindings for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

For now I have added them under the maintainership umbrella of the common clk
framework, please let me know if I should do it differently.

This was posted earlier as part of the series implementing cpufreq/OPP Rust
bindings [1] (since its V6 version). In order to make sure this gets properly
reviewed and I don't accidentally miss relevant reviewers, I am posting it
separately now.

If possible, I would like to get these merged via the PM tree along with
cpufreq/OPP bindings, but its okay otherwise too.

--
Viresh

[1] https://lore.kernel.org/all/cover.1738832118.git.viresh.kumar@linaro.org/

V1->V2:
- Post this as an independent series.
- Include more APIs, apart from clk_get() and clk_put().

Viresh Kumar (2):
  rust: Add clk helpers
  rust: Add basic bindings for clk APIs

 MAINTAINERS                     |   2 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/clk.c              |  57 +++++++++++++++++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/clk.rs              | 104 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 166 insertions(+)
 create mode 100644 rust/helpers/clk.c
 create mode 100644 rust/kernel/clk.rs

-- 
2.31.1.272.g89b43f80a514


