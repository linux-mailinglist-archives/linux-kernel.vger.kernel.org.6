Return-Path: <linux-kernel+bounces-545261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85687A4EAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19F01891CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B828D065;
	Tue,  4 Mar 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZfmi2mf"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20E286298
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110637; cv=fail; b=YHD7w+aS9bggcdcTp1h1XmGZcRkSbck6fYyOvycM0kZjnkrhx5XTlslRLHJYAk0eu2GEyPhAEXMyfZlhc4JjgKNkCZ0FdbZW0qYSunntr5CtB5z9cpHvcLfhZWi2FqPyh4DGCVUr+xcl3/yXorRk/rSo+ycKOIwsWDn2cnB+oEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110637; c=relaxed/simple;
	bh=+GESS41zZMwknv3jzLMF+8OwA0DxTwcd/v3C9+s2/8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewNoacVvSc2NOVuMpoF+nn+aWCn61MtX0wrLdpDJhp3JZu94jQbvkMF7QcArTXI/XSiLtRKWHdA9sOYBtYkEZ9b3vx3fqD2OU5ghMsGCz/XEMfYejFZXvhBW6nZtP5JjolpGvf3ZqKoQWnQTAV6hoUfga1kwzdRpQfZ2MeCYyVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZfmi2mf reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.179; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id E536440D1F50
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:50:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LZfmi2mf
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fjz08KDzG0X6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:29:27 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A74E842741; Tue,  4 Mar 2025 18:29:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZfmi2mf
X-Envelope-From: <linux-kernel+bounces-541326-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZfmi2mf
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 76992434B6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:00:38 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 32C453064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:00:38 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896F8166B6A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD11F237D;
	Mon,  3 Mar 2025 10:00:26 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E731EFF8E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996023; cv=none; b=Jq1h8ATE46QL5r6MgVsXrsELo1wN7mlhgM7S0vKXru1ZfFgibIwmBVrA/m1IEKrArAhLICjQ6lPL3YYo5Nd6LLxFdUkl/i6EN/Y8NBZWE7u/ZQG7fYqorNvXVwSLXQQGTxiV6N/ON+xVYGcApXxfqHKZJqdSZ0W4sMUPI9DxHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996023; c=relaxed/simple;
	bh=W/MWmFyRzRaY/L8mQHhIyX4NsQyvm3lJ3qdXyxFuKQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcIxnesOFZdEQ3ltoQcXBFdHtDOMwfVSy06gMcRHbkOwDLQwliQY5juywTeQg2/eB+/Ev5yVnHp6CI/N67Y5HMAueP/kdYJMqaAQTyykUOy9MSGGM0a5ZndMsBbtdqJPSElevdDSnJnKn6IFXuVWl7nh9dapCol7JYEU6ltvjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZfmi2mf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223959039f4so23547485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996021; x=1741600821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ui+QueMnTsbsw0Ov5sY4KY3gRDEpJNDApjz73wwqkjA=;
        b=LZfmi2mfw8rquM1K61TDxyhk3do1+8SmeVxNSBf0CnylS2idN1uHBgltGIqEhe01P6
         t5X8aIcDqIpNk4XmlzjsjHC/mYTkissaMAAXuMot/H+vdZOUlixw2m4/iK17ut/pULHz
         p0Hraz/e+ASkIrR3lPa/WJZ+senZeQGCqu82EyO1CKMSDCTz9Lwz0NLmEyhnB67wUEUe
         43QW0NAaa0Nhz2McwFLhwoQAuheCiPCx0/NcVrE0c1LKZGAAg3jT7nA5hDCQdzvb56Wg
         VZMS7bGL9ufSlFeU/WroF31HQu9WlWWy1wN9jzF3W91Erk8yhJIVoWeCDfqbtFWh4s+h
         lGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996021; x=1741600821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ui+QueMnTsbsw0Ov5sY4KY3gRDEpJNDApjz73wwqkjA=;
        b=eIvKjg59ac5idrj6SfhwXrLrRilCjXdZbgSXt51qStIZ5w7pMxHYdN5ppQJWqQUZI0
         gSTU2exhyMJlcIMoVm3axxoQFzhDmhxQ0mrlbbuT0JdT6YZHhI9sjRtxCMMRvxcP48Qp
         t5xnzXSga/MV9t6vPRE1J14fVtt4dCp8usqlKM0OUdJPNkbqma19TBwfDhKk9MV8/sSN
         ITCoAz/qrCyh2if8La1Tcn+H/TdY8BRMdBSmlmVsaT2JPJNGHcyAYCunkAhsugN7+6hd
         qpuOdbRCOIhVGfY5Tu3XsgSdS4uRV69xN2L1czDDi3+FKc0C9YIth2ijXFEgCQJmNT3M
         97yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZYf7sBj/jpd/sKf9OOzNB5Vr3ewv+bp83KykAowGXBOHRIA6jEDtm5m6EQVnvO45i9L0mBGRf5YpoaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9T6U2V8DlEBe986UYU98L5DDXPu+S9R1hqAgbG1I4XC50BZE
	pIoKHa+lJS5tYwd4b7diOCvTEdcdWOBYUVKgEDWTM1Tys9OOZDBfgWX8BwB4uKQ=
X-Gm-Gg: ASbGncsl93tQe+JhYSLao7nbJYkl4feACs8qph0IxNCA1w2EQ5slemkjDnXQFPkmFAi
	ID1kLDqRW6bNVzPZ56KAroIt/FIg4u/QvJxfBotFBkzJ2mVosRHKkU1SmboF5T/bTFYE8ZFOy/X
	loL1fnDK8bhtM58oUtXPE4+inQ0vFpl6e0cQ84kOET6uTODfMlU1Jn+15mQr1YfuduQxGjAy8QB
	0RYk9W7BrkHoyAV9JoQDEdc8ltzhe1bfL0k4i0EHWdT4QGbmSoY4luTgRK3IYQOh/zVTVipoALC
	HIw99siqEV2Cl39o1Nme4sI0cB0Yf1XpmafHve75SYs0vA==
X-Google-Smtp-Source: AGHT+IFJ/3EtNRcapiKvA/LhInnujARn41J0eZebYdMRMc5AqmzRtaclMoy8+PxW2aUq83BCOeNAyQ==
X-Received: by 2002:a05:6a00:14c9:b0:736:3979:369e with SMTP id d2e1a72fcca58-73639793857mr10236218b3a.9.1740996020598;
        Mon, 03 Mar 2025 02:00:20 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363288529dsm4567764b3a.41.2025.03.03.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:00:19 -0800 (PST)
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
Subject: [PATCH V3 0/2] rust: Add basic clock abstractions
Date: Mon,  3 Mar 2025 15:28:08 +0530
Message-Id: <cover.1740995194.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fjz08KDzG0X6
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715308.01849@2FY/1CVavVdzGtLo5pKD1Q
X-ITU-MailScanner-SpamCheck: not spam

Hello,

This adds initial abstractions for the clk APIs. These provide the minima=
l
functionality needed for common use cases, making them straightforward to
introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

For now I have added them under the maintainership umbrella of the common=
 clk
framework, please let me know if I should do it differently.

If possible, I would like to get these merged via the PM tree along with
cpufreq/OPP abstractions, but its okay otherwise too.

Danilo: I haven't done anything about MaybeNull<T> yet, as we can not acc=
ess
fields of the C clk pointer from Rust code. Not sure if that is still req=
uired
or not.

--
Viresh

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
 rust/helpers/clk.c              |  66 ++++++++++++++++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/clk.rs              | 134 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 205 insertions(+)
 create mode 100644 rust/helpers/clk.c
 create mode 100644 rust/kernel/clk.rs

--=20
2.31.1.272.g89b43f80a514



