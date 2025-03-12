Return-Path: <linux-kernel+bounces-557123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F7A5D3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F4617A5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B713AA20;
	Wed, 12 Mar 2025 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L72ULtt8"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20520EB;
	Wed, 12 Mar 2025 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742265; cv=none; b=GbDQ8LCth7hSKDUVaE+0WTIdccjfUAwgDXJoyGbAZ93l23hivPCNA9JXtYGmwMUPgzPLMsbmrOlJcRtiG5IuhH/3HUWtYhlMW+LcqjKYEpSLUD6/cMqg9T1Wqg1KdKMiLXZmzLsSgWyqGsSpf2Dgtw38MAs1S10jbcm36hs5oEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742265; c=relaxed/simple;
	bh=BIEa1ejn9vUMvnxh83/Pfjv65SGkYNICYTRPB94OxDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GJ+RbQpfCYWIN+FxydmPjp3pYh81hY683fuEdGbJ5KUqwsDsDoNcTpRGd7pcswGGZtjm5iITLnjxEPPi/CjCUFauyI6GACRs6CBb1D+vUGAVGVL1dk0JDvfXDmMQyFMzUxUwJheW9UCxxjIx58pfcBMdY9uajrgcZryAdH10wnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L72ULtt8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e90b8d4686so28381466d6.2;
        Tue, 11 Mar 2025 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742262; x=1742347062; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvQKYHjgxU1wCfiqd43p8PZdXr56fxvuMpg073sHfxI=;
        b=L72ULtt847ttHCZr0EU4iUVw8fx+JEMu5Lkf82DeIKlWi1Y+/2xS5hEn/rtf1Q/tXz
         K+RYKRCr0Ph0V7eHWNlAwhS4VKzTwvyVhCpAy9JGbVTpUlTPr+L1Zw3+jDZiOagu4CSQ
         zjqby4inbUMRI/UESs32mXtfVB/wuJcKg6uXSCOjv83wZeyjKBerPqVBw9Q09/Cdx188
         Z+MmgFjiW4boC0pVBH7mG9kyDVOGOkU1GU8Y2VdZ0k+uqAA6NldpYd/xkc9rNUx03xHL
         SYHgiiZX/3UGX7c5ltCYuzipVv7r023H2wG4MgvTYbnucC24cTd9eUKwK5BtEnocWJbD
         x9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742262; x=1742347062;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvQKYHjgxU1wCfiqd43p8PZdXr56fxvuMpg073sHfxI=;
        b=rQllZyUJQwsaHwM0eMMdUfczeuzL+NbKdinPpKu2TrJ+z/HmqiXIabUbzBTUKGjfLF
         ZYg4PiRqP77AnS6mbqjZl/m6SRQVOaOU/75TQ91boG8WyQIo2cQyi60xInQ0WuJ86f7I
         oSgT9GoGqnvYvgZ4ItmgUgV7OTuGzaLeny/raFfWt2wJYHQbOZy+IdH88u2iAP/lwYXc
         ayxbp9f4Wu2zUiMKE+yUsNLeOoKuou0ADIa+70mv82CgVGuKEy0zhTaRWbmyBwsCQD8I
         v4w7EFDkm7kutqxEtfWhdKo9dTBuiOlYr585DgGehIkmdlgnSD4dqbTdxl/PkCa/V5UW
         dvSw==
X-Forwarded-Encrypted: i=1; AJvYcCVqtp9/+K6C5jXiCLdzH36WE2tWqWuEtiQpEw7tliK5BMeW6gd/segQIIpb/dCONEVbdctURktJkJkNg+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySAd1eE9pw8hjtw7/qwAf4n9KgmvUPQ/9vj4m9E0Pa5/ygOyj
	6Ah35HQxJpDYkHX7UDYZk2H+CloBdUEAeezPJcsyKfajJSGuM7m5
X-Gm-Gg: ASbGncsNEPTcrJZjPtn7nOn3No6sLYCM1cXjjPHNro0hwbJpkV5+2GCLiHMCp5zcGxj
	C1TDlLN7Yjtv3tv6/pFblfvtZqR9V6nCGzbJJ+UCUw+flV957ZfaHCTgBlxSPKdeppRYaj9qWTm
	DEYMQtDYeWimRZaMc1qjqBbregP5KuEM5awg1Scs30Q636aD2ovjvrL0RJd7ULSt4zm7L7vrmcQ
	m0FSrSR5fS6bgrLCkJEOwsKuf9XpaW0jXTpqzG+5Ui5rYCJwmDS6ec6hi3+T1gV8R2thVfxYb+M
	rDl+IEGxXeivZcmJobNTa6w9W852714AS/RHYxEKnA9mEZKvSEgVjamJU8iaJ6K3hgAo
X-Google-Smtp-Source: AGHT+IFQmmH/sZYSi645oSe6oiCp5Sc7cqYWDz6oj+FoiTtTYxCqqpKOYdjsTgHu7RBXFFlNsh8uxA==
X-Received: by 2002:a05:6214:2504:b0:6e4:269f:60fd with SMTP id 6a1803df08f44-6ea2dd26c2bmr95976936d6.23.1741742262004;
        Tue, 11 Mar 2025 18:17:42 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:40 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/7] rust: generate_rust_analyzer.py: define host crates
Date: Tue, 11 Mar 2025 21:17:21 -0400
Message-Id: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHg0GcC/33NQQ6CMBAF0KuQWVvTDhbRlfcwLEYsdBJoSYtEJ
 L27lQO4fD/5/28QTWAT4VpsEMzCkb3LwEMBrSXXG8HPbECJWqK8iPCKsyBHw/oxQVifdSofSta
 V1vpcQy5OwXT83kfvTbblOPuw7h+L+qV/5xYlpCDEuiIk7Ki89SPxcGz9CE1K6QtAZI97tAAAA
 A==
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

 scripts/generate_rust_analyzer.py | 177 ++++++++++++++++++++++++++------------
 1 file changed, 121 insertions(+), 56 deletions(-)
---
base-commit: 510570138476387532129cba425ea7a375308d87
change-id: 20250209-rust-analyzer-host-43b108655578

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


