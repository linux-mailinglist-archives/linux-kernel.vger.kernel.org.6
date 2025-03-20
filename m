Return-Path: <linux-kernel+bounces-568978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91260A69D09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47FF19C0799
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465F23A6;
	Thu, 20 Mar 2025 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvj4F9yf"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB84A02;
	Thu, 20 Mar 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429243; cv=none; b=g1F4mUxJtNOOnEovMfb8i/8FCaVCcycGSjiDwRUWcjeEorM6dZNqAFCmaApD2/mKE/8oMZyfzi8Eh7x+J7MUxUwPRCq0clCWg2iHWW9nXnCn4Q/CphRD8pJyqqWt6XcFU6OxLrU84i6ATpr+IY4oK6KLR8383WWwZwI5YzWGiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429243; c=relaxed/simple;
	bh=eX2rMDxHsP943t9OL43/VGbUFjFVE1AZryFeeTbN0MQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WzLcdsZ787Hu70WEbHy8JMc2l0HfFO3rv/A9ElGkWjltTaBGbVo8bhE4JCTiLAMRohWXGntwR1ZsgKvzG81vjECDAgT931k0bin1ydcSRvrik/HO1aiKhBFGI1bUAJCvifQR+oeubs6xDan2HwMc2bGmAg7j3d0x9SgVNklms2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvj4F9yf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c546334bdeso20492085a.2;
        Wed, 19 Mar 2025 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429241; x=1743034041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXEySPw4oVIaWLtdcnKpaconhTP/6lzcw08cIroD2iY=;
        b=Cvj4F9yfjfiRAD/dZ1da5G6njPmS9Np5qHy2OvqnsSl40L7jncobFxofrzlwUVMq1Z
         oDo+UJ1WOVwyVXSu9qos25mYwvRZbEQXh2fLiuNznb43zFUh+xqo7IkMvHHWzJcf6veq
         CZZlgYY6dDt8AwpnzvlzUz4QW/7OddkbkaBjRFe4vgx06zc6mMbags8Ejee7nQCJKPby
         8R6rG+fv+w8KZPrtlRDSKvV4ClB1ytyY4Nh6AoQeqC4TlszougZZZKaQMsgQFv26H3OJ
         KURZ1Mu0RqQCuuRPOld8PtKeIqJD9tyE9z2OcHB42x4CQ3pZoMvBatv+YN/xJaEkCW4F
         6NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429241; x=1743034041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXEySPw4oVIaWLtdcnKpaconhTP/6lzcw08cIroD2iY=;
        b=srwvV/eTf9KCs15O3lZqsU1Zvmwqol3dl86/eWgJp2EnFi3ExqNCEttZHhabywOD9o
         vDg7ufqY2GK47hymFVJNjXQUxRznWMvDG175ZZHcBzV6jAXPvxwdOw4nM4f2qJVqVFkT
         pIoDG9NUOM+R9DVd/OE884JwncVudvhEOg6XB1AxEZO4OUk4yz6svJJi/VzQ/a1HQh0U
         uWXPzh+rc2pqPWuGPetu0dt4XOkG9vjMMszX35oqgC0EGV8zCWkxQWl6vNi4EZn0B4JN
         OOPtX+a/1OK9K5PiQcGfeU3Lq26hFAMw4D+L1XFFwG4ykuVTB7/CaxUbdC3ITyHuegJ2
         YZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUissWbPnhLxFtoB4VdzxykWjPphx0sq0lKwe97jJh/diK2Nd9ekt+UHyWRrbVwvnymWhh6pg0+3jmpG/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8ne3LfUw5jmR/tuMuHK5+rQCfaUI3nDna5DTAvoT61F4c70g
	MewvKARyLt1iNHzr5LE+/xzDRsvq46Pb6HzVMoSnzhAAhm2cuozq
X-Gm-Gg: ASbGnctHQswbPMD56P5LEoow6HaISIm1MjGAGJd8pQZF5vI0uIw7DUMW5KzJCmzh3Qa
	UCf3SI3U/ltHJMDXuEz97Xka1D3Huddds63lPVXTaw6tQI6tnXZdBXU+/mdlR+vCm4eMAURcs/y
	E0BjJ4uZuK8eoZvx1iN8FL/eRaRs6wnjHVlbjIT9JHq8XBuGFKbruFnipJ2wQbP8HQUu8ubS+64
	A2Lrzhh5V/0Y7/sZfLqAS2rGeSF1hBcV9NEdIs/O7T82pifis+g1+d3LsTkEApmKuxf34Go5AEt
	ZW/+2MXNkHLv1+PsREfqDZMic0kSRPVoyhxlbn4h4kIPn21EgeJjbQsJHMNVUd2VMnx10XrMjMO
	QQwXExX2un0I=
X-Google-Smtp-Source: AGHT+IHHpgGcFo33ef5NwaWJ89cP246u1PYYKNpdcH8knFU0ocxKgqhf6TO75EHmfUq2RAggoylbtw==
X-Received: by 2002:a05:620a:4246:b0:7c5:4949:23f3 with SMTP id af79cd13be357-7c5a83c9ab2mr541664585a.27.1742429240861;
        Wed, 19 Mar 2025 17:07:20 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/7] rust: generate_rust_analyzer.py: define host crates
Date: Wed, 19 Mar 2025 20:07:16 -0400
Message-Id: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRc22cC/33NQQ6CMBCF4auQWVvTmVpEV97DuBixQBOgpsVGJ
 NzdwkYXxuX/kvlmgmC8NQGO2QTeRBus61OoTQZlw31thL2lBpKkJcmD8I8wCO65HV/Gi8al2qk
 ryiLXWu8LSId3byr7XNHzJXVjw+D8uP6IuKx/uYhCCiYqciamitWp7ti229J1sHCRPoRC/ElQI
 pQkkgYx14jfxDzPbyzwjgP3AAAA
X-Change-ID: 20250209-rust-analyzer-host-43b108655578
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
 Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Wirth <lukas.wirth@ferrous-systems.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series updates rust-project.json to differentiate between host and
target crates, where the former are used as dependencies of the `macros`
crate. Please see individual commit messages for details.

The first 3 commits contain mechanical formatting changes and are
optional. The series can be taken without them.

I avoided more significant formatting or changes where possible to
reduce the diff. Unfortunately `scripts/generate_rust_analyzer.py` is
not consistently formatted before nor after this series.

The 5th commit ("scripts: generate_rust_analyzer.py: use
str(pathlib.Path)") can also be considered optional. It removes an
inconsistency I noticed while working on this series and which occurs on
a line which churns in this series anyway.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Rebase on linux-next. This is needed to pick up all the conflicts from
  both rust-next and rust-fixes.
- Drop `uv` from `mypy` command. (Trevor Gross)
- Add `--python-version 3.8` to `mypy` command. (Trevor Gross)
- `from typings import ...` directly. (Trevor Gross)
- Extract `build_crate` and `register_crate` to avoid peeking into
  `crates[-1]`. (Trevor Gross)
- Link to v2: https://lore.kernel.org/r/20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com

Changes in v2:
- Rebased on "rust: fix rust-analyzer configuration for generated files" [1]
  Link: https://lore.kernel.org/all/CANiq72nv7nQ+1BinCHe2qsvwdUb-y9t7x=RGSppi_n9TBXNHpw@mail.gmail.com/ [1]
- Link to v1: https://lore.kernel.org/r/20250209-rust-analyzer-host-v1-0-a2286a2a2fa3@gmail.com

---
Tamir Duberstein (7):
      scripts: generate_rust_analyzer.py: add missing whitespace
      scripts: generate_rust_analyzer.py: use double quotes
      scripts: generate_rust_analyzer.py: add trailing comma
      scripts: generate_rust_analyzer.py: add type hints
      scripts: generate_rust_analyzer.py: use str(pathlib.Path)
      scripts: generate_rust_analyzer.py: identify crates explicitly
      scripts: generate_rust_analyzer.py: define host crates

 scripts/generate_rust_analyzer.py | 210 ++++++++++++++++++++++++++------------
 1 file changed, 144 insertions(+), 66 deletions(-)
---
base-commit: 57e79e4281c114dc06f6aaf3369d863025e706b4
change-id: 20250209-rust-analyzer-host-43b108655578

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


