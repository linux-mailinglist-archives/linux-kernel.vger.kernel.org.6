Return-Path: <linux-kernel+bounces-566098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C4A6732A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C01749D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E420A5DC;
	Tue, 18 Mar 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkEZngh0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8E20B1EA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298718; cv=none; b=ilPxjpwxopZGb6smRfbT+8m7XhRBcnPDczDzrML446F94Mt8pn7y+nRyvm3g/DX11dC7i1FyRyz0WKoTZieZuogGEH74tuXatWO24MVGT46571ejUHpywQCyAcgcu4ld29oACfhmTwKCFpQy0OCMp1Wo2KfR3/pKxy18I/9eINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298718; c=relaxed/simple;
	bh=278+u3fizP7W8E5ySpxmiPu88Rz4xQpc2j0W/vcy+uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQPovUa6wfRPkgbaoXmTzCfx8L6EKkVxaK3pWOjNzAs28/fysUPCcerH8YwRZ3/l1fqTqxNhSCpt4h+J8b9LZx22kVeReDDhKjk3jP9JbCgmiPKxFSkOpiqvUc/xgdWzl+6vUd4toj3t/xv0ZD+8knfKAPSZ/Yn1rhvDCmi7Vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkEZngh0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so94381895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742298716; x=1742903516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVMWAIsRCWkE85QC6mHErAJfnb/S0g2tA5F2CDUjozQ=;
        b=mkEZngh0qaEUdh87z4y9/T8XWz2qWhhJuVsF2rImhRit3XuqBFArI/wcDUcztv5vSl
         Gjla9gr86kfXZXFBRyPL29RIqVxdFgw4lsK+9iva9N4h1FS9giz/MwogmzMM4PEIpy93
         Ln/j2NG07qqhjmmA0ZlGMZIAqC+ZUfMKB6cMtVTQ2ued5IMtKizVbMAJbN5k5YsxtLNv
         uGdLHhgculLo1FeI0JjOILJUP3+cdKbNQds78JTazCGnNBYzrKjGTFlds7oniINLxqUd
         FVF/cPfUjIzWri6unjnWKwt3cD9007HrCGBNMYhZMEvU+PdAO2w+E9xo1qjj338vkAwW
         gs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298716; x=1742903516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVMWAIsRCWkE85QC6mHErAJfnb/S0g2tA5F2CDUjozQ=;
        b=tFDpRZwGCOU1nnP+x7g16gW3iotfBjZqP2UK1FK7KY3z4FZ3ip8+0UZ8Zru+er6eH1
         K4ccE1CgOUDkCPICz1tySWRediH5ekNvxIYtL1aE19DToaNhnBQaDcAY+4pdFAg4sDBD
         K4E2ETBWRWCXDKioZ3kRqrsrDrydYapTDCMvWmn2F4kLG3CiW3CPk9DvxxsEjMgma0Sd
         DaRdRge5X1t5g6SPICcIeFGphoNOLLnRMTg+kohU1Va3poUwK0UqUDfrXFiP0DPb2/+t
         EPvLQeJTqcH0U4yYJ0q/foCZ4pSzAtFoPINRKTHKGxwmBiYvOP86m7pMzRMcvDsvtFKZ
         iRZw==
X-Gm-Message-State: AOJu0Yyp0YX21RJIqfhDznBO/9gVI10X/nSSI5JrQQoo86q0Ab2rHkWY
	KJ+xm7KGt6MudUyzxFtMOflCfRHzXvobGuvtrSwE0BdLKHA1IQNTX+wgRInnWxs=
X-Gm-Gg: ASbGncufPfsBdokYIcF1Bx+SXMv2mvvPbHqV+vx324Q1m5oqDCsOOYJsNy4n7myJr1n
	pqGIz9dGfxprFOnC1nJ0QsHyrjCwP3GsJfNc+G/y8a9R/f/A7LhnjWmV/6ppx286Nbw06IxX3Gk
	Wms+HmC1C175K2rjDoIF9anOdok6BpBndBlLGz1T9awBipY88JP3kDH3gIPmMqhMhXW6uYOt2DY
	gaKwKWd8tWkVBy+v96ZSFt6imnA61rYqz6LYCqi1pI6ZMPfuJH8yfKszlvINi3WQEZvSPY11Qfw
	LeJZSDKIrd5CTif/qsmKsbmDNzvPKGEasrLury2xjXEiVQ==
X-Google-Smtp-Source: AGHT+IEzMpHgErA9n1ehW0f2v6qOCLqe4x3qcL5Y3qH01rUKVjK2gAXQcOufynlZ3NKmeynRUexjng==
X-Received: by 2002:a17:902:d50b:b0:224:11fc:40c0 with SMTP id d9443c01a7336-225e0a52d78mr205251585ad.11.1742298715753;
        Tue, 18 Mar 2025 04:51:55 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7280sm92079725ad.147.2025.03.18.04.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:51:55 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Burak Emir <bqe@google.com>
Subject: [PATCH V3 0/2] Rust: Add cpumask abstractions
Date: Tue, 18 Mar 2025 17:21:48 +0530
Message-Id: <cover.1742296835.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds initial cpumask Rust abstractions and adds a new maintenance
entry for the same.

This was earlier sent as part of a larger series [1] and it was suggested to
send these separately.

Depends on: [2].

V2->V3:
- Improved comments, SAFETY, Invariants, and INVARIANT blocks.
- Add examples.
- Inline few methods.

V1->V2:
- Add Yury's Reviewed-by tag in 2/2.

- Implemented two different structures, Cpumask (corresponds to struct
  cpumask) and CpumaskBox (corresponds to cpumask_var_t). Thanks Alice for
  helping out.

--
Viresh

[1] https://lore.kernel.org/all/cover.1738832118.git.viresh.kumar@linaro.org/
[2] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/

Viresh Kumar (2):
  rust: Add initial cpumask abstractions
  MAINTAINERS: Add entry for Rust bitmap API

 MAINTAINERS            |   6 +
 rust/kernel/cpumask.rs | 301 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 308 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

-- 
2.31.1.272.g89b43f80a514


