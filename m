Return-Path: <linux-kernel+bounces-572430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E2A6CA46
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FFA3AEEE6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EA224238;
	Sat, 22 Mar 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmy5aWj3"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CF204689;
	Sat, 22 Mar 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649830; cv=none; b=dRqp0u2go3qGOwigo6Cxu2OoFErZstqqxgN4l3Fr6wSqwU49RMz9mE+nd3k4HUqCPBHpi44J2eCDti7io+H9/PT700uGrdXkvAFL/b20ySIzCJC9jM3NXFl5DwlYsnSPOoXBrVuQhB18u91FNr25Jg0J5JQpkPdp9Z2gCELTRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649830; c=relaxed/simple;
	bh=9N4qOT6DsS/CzRxa1iRMjBzm8Si8WXsqZsxsVuqS+4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WjNpUsn0kvPIKjSF6K0hQMa4X4vl+JjsfkqHPnrSleHW2SKpG2xwCXvvmvWF0l2Pu+zOtS7FAVnPSRAh7fAqr0QS7XxdWCV7jzl9/Derfph792rCno0HsU0Qa/LJh8W2ZRXKGq2cmMMJw67XSrG5/lw+BLUbrrcfzA+RezO66Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmy5aWj3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8ffa00555so24364476d6.0;
        Sat, 22 Mar 2025 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649828; x=1743254628; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8O35Tlt9vslut2I/jWGilISC3ltc8LfI2Vxf6+fF1cs=;
        b=Pmy5aWj3rlwkxBswuD8chKYMVgnBXKPiF/AWDNhAUr4za8chiLzp/gOv3vfAYMFg+y
         Kn5+AV/eTAMUuxsms9/Vb0PoJcjs76ngFwDYry19LXla515UM62e00wkSGJguzc+iDlk
         Qxy/+QSgHpKq6s/QqVR6bne5WuzDklEkupf8uYLeg4M2qlvk/4U/yU86h170Im/G78Kb
         +eXsq0sqY45bkG0zMXjzw3j6U+MExvRGDK8h5FEsfXgxuTXZ0rtjTMlUdSO60pgRN71B
         kuzlMZeMkK8LIRZ/6HNdfF5qHhBPzL00Y0MZ56xNKbe7a9dEhvsD6yFTqwfTcQZwQh5t
         xgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649828; x=1743254628;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8O35Tlt9vslut2I/jWGilISC3ltc8LfI2Vxf6+fF1cs=;
        b=d/51Zy42jGdg23iNH2o2xIDYWBu1fixiEHPRlQAYvgHeO/ZhdX5aZSky+Q5At76RYP
         +8NmSOtgFj3oIMxxSUVyUeLXAo6pd4kxPs9L3x+GyhHPbTPzUh5x2nZPIv5igJeWUMwc
         jt/E2NfDBoY1zZjlHSdlx14qNJvkCt7rPy4yCYSvNA1WufKSTc/foGP3OtFemhakG3YM
         huss2GnqAiwYCPhtrd5jUZunZgORUsQQMXB13gGEYOBaxa+ljLSzbk3N6c+/wYI7BZgZ
         9QSwfYKD2ozFwsAuuG14mK5/FlxsAuEtC6ToQsB+Qx8MewhTkB/mHryG825MSnC7X6J+
         slew==
X-Forwarded-Encrypted: i=1; AJvYcCXxuo0+bHr8BT9osc6hUDbzw2QQxIR6XBvwDS66qCzdNkRgs/wlrl8uoMTMIjUSh0EUCDpZ24KnrhK2QEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOysIWWbD1BYm0LOTq1B9uvhjg1bXXV6DwULEvjepwCZFUKNQ
	02w1yKWK6pYx/psQIp9bsoxfMgvZ67YWYY6mok2UbIkP5iYBAgLe
X-Gm-Gg: ASbGnct/aLDnnx8EWSNB/8ngDr6RR1jMrNecoBoEs5glgljlEIlIn+G2EDWPMtJhid3
	vL+OR8CymnLVX2DFKzEOmke1ztfe+zedrc+TLTtuQAT4JMKRhsbkL7aVqzlCjZ8juLWOuWBoT7d
	9vv91ui7mS0RpjFEZiuj/02NQ0ZOau+KIZOl6xy/k7VODYv4KWeBfyWrZC2wdCFzTDpMN3FABDo
	KmtVXw0troFl08U13Rt1OSqc6S4MCkcqvh2upRHHv9NcY7XXAnHuBonQk0yiG8I/pMVEy3f/Pbg
	w93NTuNeUwNdUgbm4+NIzGWfv8eFLPn386MvfQA518tlB4NI89xe/Uhzpr6smOhW5n6x4pFojUW
	S7g2dqxy046z7xvajGCX0rZbH37dZU1nd6SrA7dikLJnTwaFwQu7SL40MZtnqZbg/Ym3zgSc=
X-Google-Smtp-Source: AGHT+IGojvTBV+1NAi1za+eYps6iqi/vWB/TIE/K/A+ft42/iQjzXxigG1GlqoN/ik7Ho5gwo5rrmQ==
X-Received: by 2002:a05:6214:19e3:b0:6e8:ef80:bcbc with SMTP id 6a1803df08f44-6eb3f279ab0mr104761266d6.5.1742649827773;
        Sat, 22 Mar 2025 06:23:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 00/11] rust: generate_rust_analyzer.py: define host
 crates and scripts
Date: Sat, 22 Mar 2025 09:23:35 -0400
Message-Id: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANe53mcC/33OwQ6CMAyA4VcxOzuzdgzRk+9hPEwosASY2XARC
 e/u4CIxxOPfpF87Mk/OkGfn3cgcBeON7WIk+x3La91VxE0Rm6FAJVCcuHv6nutON8ObHK9trET
 eQWSpUuqYsbj4cFSa14Jeb7Fr43vrhuVGgHn6lwvABdeIWapRY6nlpWq1aQ65bdnMBfwSEmCTw
 EhIgSgIIFUAv4RcE9tfyJmI20lChLLANTFN0wcCRFIyOgEAAA==
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

The last 3 commits can also be considered optional, as they can be
submitted separately. I included them in this series because they depend
on it, but they can be split out if this is preferred.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v4:
- Fix typo (s/generate/generated/).
- Pull Trevor's suggested change into a separate patch with a
  Suggested-by tag.
- Add patch to avoid file descriptor leak.
- Add patch to generate rust-project.json entries for scripts/*.rs.
- Add patch to use `cfg_groups` to reduce size of `rust-project.json` by
  90%.
- Link to v3: https://lore.kernel.org/r/20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com

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
Tamir Duberstein (11):
      scripts: generate_rust_analyzer.py: add missing whitespace
      scripts: generate_rust_analyzer.py: use double quotes
      scripts: generate_rust_analyzer.py: add trailing comma
      scripts: generate_rust_analyzer.py: extract `{build,register}_crate`
      scripts: generate_rust_analyzer.py: add type hints
      scripts: generate_rust_analyzer.py: use str(pathlib.Path)
      scripts: generate_rust_analyzer.py: identify crates explicitly
      scripts: generate_rust_analyzer.py: define host crates
      scripts: generate_rust_analyzer.py: avoid FD leak
      scripts: generate_rust_analyzer.py: define scripts
      scripts: generate_rust_analyzer.py: use `cfg_groups`

 scripts/generate_rust_analyzer.py | 257 ++++++++++++++++++++++++++------------
 1 file changed, 180 insertions(+), 77 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250209-rust-analyzer-host-43b108655578

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


