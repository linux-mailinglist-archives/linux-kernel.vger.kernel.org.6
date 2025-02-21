Return-Path: <linux-kernel+bounces-526431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955CDA3FEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE76703BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37C2512DC;
	Fri, 21 Feb 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kimbYH3f"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81751D5AA7;
	Fri, 21 Feb 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162135; cv=none; b=jaTVEakr9rbIyOn9oPhYxkk03iajmeqlYtcG6DclXiNGSsWgfUUUvtVUAxVlUqR8IPRvwQQHOFeAnhBOehBl/K/YnsOXhd6307HoXjwmVYGa1guYZW3NFRbektT0c5v+mwvfm8P0W31k4Xq8Bn56AmMWr1I5FQa/qt+g3e6uKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162135; c=relaxed/simple;
	bh=L5Girfd3B73kfvjAEBHiRwPqWXrE3xTavT1abxWzlMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1G8EvCBwNTQHfZk5Mh7ZuqcYUTOWqXDUMwXO3UurOd4riI5RafHVjy5RawqhJtlzyABillByIz2img4u0VjJ+UjyrHUpT161jjHYRQgM9dmMYD2Pt5Ul92XxNZBREFwrf8xbUOX4LS3De01ifCUaGfZxOm8L2vKDB+L85IvnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kimbYH3f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so44506035ad.0;
        Fri, 21 Feb 2025 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162133; x=1740766933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkJW9xIrJMOBXhMyWGWR5ruS6dpL++0YVSfzdFkJuS8=;
        b=kimbYH3fkSpvOjL/z+Ad3TStuRVo4vp/ZKLt7N2jwrfgu++xLLZ9q9H0eeS9D2Kbzb
         aPBcQakbGkYaOAzpttZOsLLLdknMCF85j+2U+05QIYz4QgMyNJreHXVml9m+n9Ta8dY9
         aLP0LdlheUVQNXqJ9pwCwR4DLnvi8hfZ+QsootmTIFNhR3yTQx2B2BbhGkEVTXqtwO3z
         SX/CnArdibTHGRl+HmtY5XJqGAhJrUfgqzqmWUtWVRFM7B1P/VV5ZIzzosAxEMMF9THA
         P9HgvJ0UdPJqU7nTNddLbOtdGUnSP82+/P4CPFV/4f2zgdVlJUYrD1RfTPFY30EF2zFw
         foqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162133; x=1740766933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkJW9xIrJMOBXhMyWGWR5ruS6dpL++0YVSfzdFkJuS8=;
        b=EfCjjR4ZLbNYLNyyM4nFntZ7yqnR0A0Na6DDa8Smxm82CxJcUNjYbgBAROybFiHa93
         5bAEwkIuX3vPV2Gzv6J0Qe6+aCrGneGra7sSFJ0CUT98gj49xuDwd/lYeiaAXdyCOGGM
         +wUBht6uIlxCfj2KWtqVfCS7+pYQVUPNwV+UZde6bW6b2gQCXIwyAshkVQFS/V8NGKz7
         cEXhsfD0f4DpduXg613sHaJiLAywJ8kpyT92KotG79t/ls5qne1ECqYEFYoay8IlJ8hu
         KLjb//5chn3jMnr3SmOXtBZAiGnuEqh0AvHWFBn/fCtxSW7VDGssjJWVZHdqNu5UpWww
         N/3A==
X-Forwarded-Encrypted: i=1; AJvYcCV7Hpl92iapVHwthjU8z6bR8qFTSFC3OjPxfIXe9x2fbYIwcJL6aUZhkd9oGuvqf1XjiuMgnI4KKp306yw=@vger.kernel.org, AJvYcCX4nSJVWeKuAh91nB5MtHZ+2Q+UF5zO62/ToYIj4dWP83jQ07czsAjSlvgi4RMVuq+GMnfMOMFTLggJA5NZRf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzPlTujysrTL0Hnznn3IleJuMrBEP6W8kMtuqp1ck7Ytocdp/
	IQYmaszptAnFWmnaDWprXUCo2nxniPI/2UFH+B2FqwI1hnFxG+Yg
X-Gm-Gg: ASbGnctcLqCVvUFhnou1q4oca/icBQWtJdNjUQI/67J86plNVwTd6+02/7Sv6TaE60o
	gdlIGwzoeaH3fs8IZnApMkYPastrW/IFvK6slHLHASQoscrCC60zvzNHuYRk1Ordpya1Mg3uTi8
	m6GkmHQ4nJp8/Yq6pDjLdsDlRrNzUmh37nJ9f3+xvM37ptq0hFiwg5N6wl+ieRASSa2GH0n1RhY
	7ZNLdVobkoJHyeiyV8irsByxHFANF1fWBvL52RLX4M/pVEH3poFH0HKvgEciGqedL0w0vrXeiJv
	8NcBQpuiphG6qhIqC/b8XRALopTeutoBCw==
X-Google-Smtp-Source: AGHT+IEUjY22pHVSXXxBPcdVvc8Va6HuIxppxZw7ZP2raDq0CUy81ZDTd99tOa0SLVskT9pVa1I0gA==
X-Received: by 2002:a05:6a21:394a:b0:1ee:e30c:68d8 with SMTP id adf61e73a8af0-1eef3c88b2bmr7343020637.12.1740162133346;
        Fri, 21 Feb 2025 10:22:13 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52aefbsm14767948a12.62.2025.02.21.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:22:13 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] author field in module! macro should be a array
Date: Fri, 21 Feb 2025 15:21:40 -0300
Message-Id: <20250221182142.42134-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field is currently of type String.
Since modules can have multiple authors, this limitation prevents
specifying more than one.

- Change the author field to Option<Vec<String>> to allow creating
  modules with multiple authors.

- rename the field from author to authors to make it explicit that it
  can refer to multiple authors.

- In modules that use the author field, update its value to an array of
  strings, and also rename it from author to authors.

- Change the checkpatch.pl to find poorly formatted arrays in the macro
  module!

---
V4 changes 

- Improved checkpatch warning messages
- Improved shiftwidth
- Fixed the regex in checkpatch
---

Guilherme Giacomo Simoes (2):
  rust: module: change author to an array
  checkpatch: throw error for malformed arrays

 drivers/block/rnull.rs               |  2 +-
 rust/kernel/net/phy.rs               |  4 +--
 rust/kernel/pci.rs                   |  2 +-
 rust/macros/lib.rs                   |  6 ++--
 rust/macros/module.rs                | 12 ++++----
 samples/rust/rust_driver_faux.rs     |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 scripts/checkpatch.pl                | 43 ++++++++++++++++++++++++++++
 12 files changed, 63 insertions(+), 18 deletions(-)

-- 
2.34.1


