Return-Path: <linux-kernel+bounces-537924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C5A49288
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988BE1888D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E11CB51F;
	Fri, 28 Feb 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q232I1OA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973771C75E2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729419; cv=none; b=o0L16Rr+AZt95efBRf99RFx7Oxbf7OzRJfGgY6/cn6Pz3nDTMM45qND4T2FcxmhSsDtwJ7ACiYj1ZrpAUgpZH0ky7++ijebI+S7tS9hibaTT4dHaZpeeViYL5W81MAhUSS6/ZBR+TApcXglYWYdlPZ8qqt8h6J8D+JvTdkOJ9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729419; c=relaxed/simple;
	bh=+EDAJ73DStfMSqA6gAhC1SZrXNktmDUfQj5Ip4QS3bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kui8x3CvvUpVij029+Cctk5xDeC2jZch281bBNAfmofp6sIe3OtAvpmUuDE+XnmbcFEpAshg/zm0FwvVxvCxMPOsVmaIWsJhd8ZyHccNuHgUTb4B/Fs7EQnyMIeeLJ/G5k4WLQQRyOSHw3CpoC8ImpEVHNMjte/RjpKWnLxbkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q232I1OA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234daaf269so48235035ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740729417; x=1741334217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTz6ofSciL2eXzNdkAhDR+tvNoRg5kiUiLQxdxgVGYk=;
        b=q232I1OAdXc6xS9vCIzEWo4bqO/3Jo/qW8PLU9vBcqr4WV7QX4welDCFMPov+5VglB
         jAT2WSvHVcFeDAvIfPyRXViHby9dEPWVUtX5CXMrCEcLGd/vlETl5Cbd0W2gwsYJp8hN
         nvTu3ct4E/PQXtXIuWNlMTA/oTOKDDYiPJY9KAcLZP9gYpIiMUQo/SiyakGbj9y9tOwo
         dckSnj3109+0tcuPOOWZzHQJkWPwzhmbhd5p5t2tWp57TFFgYk5tCouGmeefBNVMlZNZ
         LG/96FGWdOE+quKivoJI3zZ6I1V+SOgqKQUbTiV2yUI+R7dX5jrezJBHSwHl/IviL1eB
         x/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729417; x=1741334217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTz6ofSciL2eXzNdkAhDR+tvNoRg5kiUiLQxdxgVGYk=;
        b=pBF11ISjKjkGDuLeDCGSTOYlAeAn6aNNObX/LcufzBbKXy1IXu6X8pchLvJZPJfCUu
         IOdQlWL8grvfqO2CKe6Z5Qzs2XpAaT7Mfd+G6EJMFpL2UPbq+dtb8aNRQuU4wgvWdrGe
         PeOIO05oxP2U+ZpX9qup/UTt0Q+E8ju05kkxko0bCiyKd/SnUqxaz8jGeglon387gVaq
         yD7HfoE1MOZtQys0oGlJq6XCmBdsLqS7feSo4wXv8dRSzj29Mm3otvy39QXeBsO5axkw
         VpPao87S9qP3q50HjCU9tPGcrvfWoretw0cdkRr4v+J451fazevdjHoJb7frajMWDTV8
         pkCA==
X-Gm-Message-State: AOJu0YxmU8kqEkZ5wQMTXo043qLYwnQ/PTgwwuXL7tHhHNW8JfZP0mea
	YLILXmpF0+g2cWldNllFqEAKMe/2JUBjda72PumqjOKfO6yuszbNw4/TsCzpp5E=
X-Gm-Gg: ASbGncsPM+5xwg/yvgRfh3ynKb9T+2ia1tODwRjDHMOpoPeWTQfSvl3Mcu1tvWA85kB
	llhZ0LO3wc+PVZBiVbuMXJ6Ff2pj+JAe5fIHVZuvRCL5Z+ZXEYLVM0ROA7pmCS4o48gA97RApxI
	40UOMpHuTvcgxX/kWRa1AokxrV0Aw8waeXtQ1GtDXfx25TSXdjxKuWdaBL7z3Qa6nf8mgqgY6du
	vcmL8Kp6O5YVwUI2BeUuExyjkVQgVwqu8hfvj8fspaJJu1t72Sdjvd7+gvQOyRzSDonFwcDeoZf
	MMfbDBF1AP36jtn2Ntc1G1yyQKA=
X-Google-Smtp-Source: AGHT+IFGpTJLDvxLtvXLcdS7yjyRf63+ncOkZSbMRmureb3JGoaHRvxlTM1CAaR0IVK73tvTJ4D6CQ==
X-Received: by 2002:a17:902:d512:b0:223:6254:79b8 with SMTP id d9443c01a7336-2236926f058mr34736085ad.47.1740729416895;
        Thu, 27 Feb 2025 23:56:56 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235051ffc0sm27428085ad.226.2025.02.27.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:56:56 -0800 (PST)
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
Subject: [PATCH V2 0/2] Rust: Add cpumask abstractions
Date: Fri, 28 Feb 2025 13:26:45 +0530
Message-Id: <cover.1740726226.git.viresh.kumar@linaro.org>
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

 MAINTAINERS            |   6 ++
 rust/kernel/cpumask.rs | 209 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 216 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

-- 
2.31.1.272.g89b43f80a514


