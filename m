Return-Path: <linux-kernel+bounces-565515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD453A669EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DFC3AC169
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A91A8F63;
	Tue, 18 Mar 2025 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDocyHhF"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C221922D3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277452; cv=none; b=Tmifk0ittRxJDkmHKmALUZLMn6juFnGzR3gmaMJZqiNeLae5wcDKStMTLfkDpcM+SoBxSNFHWhhW43HzWhgieNMcftPbdM4JvaTUJnq2q5cNZiuiI7a7i5Za6DGgiT/RHTE7LsjPWl1Yt/WNe+bclf6xQIrgMYeAxYewMVG/UHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277452; c=relaxed/simple;
	bh=+sCbQh8R9TiUu2oyJra9dESUle0tKB3+uLGKQZ/N9mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtvBvI7DBW2qCgWcwIICr9ynaTPnuKfVCOvq1Sh9QgjSc8PDqoXczwL2/KEaBPLAwus6oNxno55cMjGN+KpLQ22DTMo6J60UOc7EkRYTdkGgKh5w2z4SLhSgdpWQ+QV76M7IOpqNBz0d0dC+HI1E0M6YzR3OpTG2N/s2zenj5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDocyHhF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225d66a4839so63549505ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742277450; x=1742882250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeBl6UcsWDr5MR5JO0HAraFd7qqgoYlegSDWTc4mF74=;
        b=TDocyHhF9xHl6UQit6JetGMGlFOuk8gVHsZstEslB0WnSDxEbgWiM5wngvSBIMppC1
         cGxeS9CCPfbD9JbO2KquRW9QK0QQbtnaZqRsYMG/ixw1ZVfJn3/5GLmoQ9a9hV31VIEe
         n0qQCaT+C95lVmYzos6HDsCBSiH9DmCoLSp91Aig0mD3niiP1DRnCz46J1RZkMzeDlRu
         /Pi0ZyyOHs2OuJVp8DxILB/C4FgvxjOhlgFu45UnyEn2zN1fGAXRgX2KlG9Ot/0cxta2
         YlsacoGBweSQsvFTLQBrV4s9Zd40U+1l5ajd1ugCNwxMLUUxC5MUew4hShmfcXaMgRMd
         Mqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742277450; x=1742882250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeBl6UcsWDr5MR5JO0HAraFd7qqgoYlegSDWTc4mF74=;
        b=S6CqzFggFUzJr6UtnxIevav5uyH3UkASL38FUn8APFRfswMRSEIlDd6BgXSRSwmmzM
         ysq1kjoL/C/p5+U44gCBGiiSCSIFk2JSqL+WMRXQWSGTYVp4Bke0ljYRC9H1VAFsDZ1I
         5NnNC0IyJjL/XBXkzqE1f54aDl12++AUzD8vLxK+WVGgDJBpehX5XlO18FsMEJ43U8Y8
         e4z1oFaEhl+WuFkTqStpFEHuxjaQxXemx5D0ijyOqFBJZ+jE9zvgC7pVy0Qk4kSEMuXZ
         sjyrJDp5Kpvx4RPzb5GDHNs3E02RvRXHFLIAvRVdqurPHZcYW8w82NPol2ptBY9mh7Fx
         r6+w==
X-Forwarded-Encrypted: i=1; AJvYcCWw6DXomtZbjgZ9yPZzVbUlbg6R6l1WYF/A852DbvfjKNSIrQeA5MbtVLmfEyr4yT0IMdPjgMdBuyyvg5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5l46wPHDf0w1ZoI0BzXQSL7Hd8Z5tCrQvmd9pSGS16Kf3NTV
	SN64tzrSQu90NYHCXZMI08wfn+FE/YER3qEru/gmmt9NEO9u5MCNUQb2HPZKtFs=
X-Gm-Gg: ASbGncsEsFFxq3qeU6qJcmBg0aeMWGAHUi+rHJOmOYeYQGHxOQaSE2KjFHOyK7HwlXF
	5rxsVu+g0WSuqrFlHKzwGi98VPiwD3NOCZ5SKcdp2yGTlLpJKBzVehmjdltC7tjn9dTQetikGru
	391Mk8e43xbPPpQ0VxkuOJlwa4E/Z02m+EAqDKFMZpRWpaoW9jOQXjLdu8ndc/cKkJnKzYhWFkS
	Hw7LtRwWKPONijLUpskF7gORe2gGpEtEDNvCMjO/suP3ZbdJCvJu3Vp89VtJA4pT4Ehh4tVcvzi
	DxwTbf6JI4am9x3C/W5J6KqoOC0CjUZgsdcmzW6+5JoDapi3Fv1hMops
X-Google-Smtp-Source: AGHT+IGZoqhHvlj2fz0gcgs7G9e+hylpXfVfEtrS7DVAG1eIEQ0QX829SvXWTu+13YtzB692qBmerw==
X-Received: by 2002:a05:6a21:1fc1:b0:1ee:a410:4aa5 with SMTP id adf61e73a8af0-1fa50bd891emr2828484637.17.1742277450486;
        Mon, 17 Mar 2025 22:57:30 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152951bsm8981519b3a.15.2025.03.17.22.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:57:29 -0700 (PDT)
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
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH V4 0/2] rust: Add basic clock abstractions
Date: Tue, 18 Mar 2025 11:27:13 +0530
Message-Id: <cover.1742276963.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This adds initial abstractions for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward to
introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

For now I have added them under the maintainership umbrella of the common clk
framework, please let me know if I should do it differently.

If possible, I would like to get these merged via the PM tree along with
cpufreq/OPP abstractions, but its okay otherwise too.

Miguel: I have dropped the changes related to a Guard implementation for clk
APIs as the discussion wasn't conclusive enough. Maybe we can tackle that later
if required.

--
Viresh

V3->V4:
- Enable clk abstractions only for cfg(CONFIG_COMMON_CLK) (Stephen Boyd).
- New struct implementation of Hertz.
- Added examples for all the structures.
- Make methods inline.
- Improved comments, Invariants, INVARIANT, SAFETY sections / comments, use
  intra-doc links.
- Other minor improvements.

V2->V3:
- Add type Hertz (Daniel Almeida).
- Improved comments in helpers.rs (Daniel Almeida).
- s/Clk::new/Clk::get/ (Daniel Almeida).
- Implement OptionalClk as well (Rob Herring).
- Fix Safety comments (Danilo Krummrich).
- Add tags from Daniel Almeida.

V1->V2:
- Post this as an independent series.
- Include more APIs, apart from clk_get() and clk_put().

Viresh Kumar (2):
  rust: Add clk helpers
  rust: Add initial clk abstractions

 MAINTAINERS                     |   2 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/clk.c              |  66 +++++++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/clk.rs              | 304 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 376 insertions(+)
 create mode 100644 rust/helpers/clk.c
 create mode 100644 rust/kernel/clk.rs

-- 
2.31.1.272.g89b43f80a514


