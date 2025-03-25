Return-Path: <linux-kernel+bounces-576101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD51A70B02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0303E173026
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4E265CDD;
	Tue, 25 Mar 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7jTLw59"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CD19D086;
	Tue, 25 Mar 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933202; cv=none; b=buDqva62Gxk8qx9+6mg+v6L0PdOFZouxb2fIsRjuekjsBwRP4b7+O9WISa9LOKCvFfsm1nYFf6NgnANN4QxMTJpBlt4bJs9PjG9BhMaRlrqYc3vMQ1ZBqg7OfUsy6VaF9EJkeP9/ZCleId8IGaLCbIqYWgRr5c6NLYWcNRADmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933202; c=relaxed/simple;
	bh=37juYYRqY6OHu5SY94dbPEG1lj9f7gZuSP/ozLzc7cs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rXMP4G6fjOF6S+naN+pttkAGkcA6vRhXXw+gvVtgGnS177IxkUlk/V5zHWuVtli5GuLt3Taq7Uo7FHCpMtdxYkwUNyu/sziQ8XdODxqrlZTJ78FBwZ/qYKzx/CIwLj3UXLKCDXMvRRwk8pe2U6I41sMj9Zw9yKZO4YcEUytKSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7jTLw59; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47677b77725so53044741cf.3;
        Tue, 25 Mar 2025 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933200; x=1743538000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWwBrYfMvlFJt8r0M0ffvzNJQz4ZELXtcONy+nGTPbs=;
        b=W7jTLw59yfl/04Dw/ZI0rCHKvGSvDjzvOuAvl+vusAOTOPwqL15yRYgzsb1hFJW2Nb
         +JWTD1U+hb1M4pl5viGcrVd425U7arHktj6NE4ZFzwAEMFRNaEW3EZJaLdi/zALNMA9x
         U/UMtEVN5AA+2v9OFwqHu4jr3Wd4AGOzV+u1Vfh84oUj8SFfIxfZrc6HcduyISLjxuxQ
         +GZj3vnJhj1TSMYtbG0qjWHp1TjAV+O4ZBNwOZbOnyRohAhtf9j/6sCt2BEgi5iSxWqb
         iXUPtP1R4ApBhuWggQjbHpHKYOmQlDV0wbwjJHeIUKeerW9wJoRK1VtTqvHdI5MGnVOR
         wEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933200; x=1743538000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWwBrYfMvlFJt8r0M0ffvzNJQz4ZELXtcONy+nGTPbs=;
        b=FVWyxKfq18xJgzGBhb18YvPeWnK8YsEiWFpRpbWRX2GjIJWIx0EWm3IxZH/ThqMD26
         FuP0Pet6iPdibl1MTyRDdltgXgkLV+sRH5Dzn6BbCsecpZFH/Cmu6JAAFJTtA8HSIVkj
         XYvDt7EQ+ASvV3ZVmQR+z+zi9ANY7bXlcRjYW5AYZHvODtMkQz0m2ERFqHiVGB9K2wKw
         dEFoLC7zRfNZzGMJytKZ4rKSQz23nNt0s4aJ4qsPKUS/DErKemXxkv0ZoqQgkUTQ/zWq
         4wmHOlx3d6jVvFd8cPQ6c20OaP22rb71ldPRhpp+btZVpgO74rbDbP2vGmpnQOli9KgH
         uAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXIvzXuL7d0PNrjh9jquNzq5Ue7/u/O6qIknB0C1eZ+J8EPmlfO7srNI9hI7yGaJ0bZ0J+dMpVBZK7cE6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyGvfHqZPIAacdqaEVNqgXDuCUUHhsBlJrzMPsU3KM6ldyCBm
	dPJ1VIbQuuA7SOhGgWyL/mKQyw7/525+g5byrWg5hydk1EgZ//VG
X-Gm-Gg: ASbGnctevEg0GAxGisb5ujk299TsShLJRwji11jBSFJqODHoCsflDTVJkFbBh7vdoi/
	zEOVccCEMRi+CZ5PdMTghLFzBgwuJjELhhqHvVYM+6sWAJ9kyZ8/HmtksU2l1k82AFcMay+G26F
	sxwaRYL3RR/9+dUN/WEJlYWMVDJ8/byQIkZbWz9NCMwWSXbmTPUFUEOLz/1jDLeF6CipSROgztZ
	9mAxziM+7v8qUeL9/4JknaTRgOhs61GwAh/9W2r2qc/akjXJI5N0yZxHBjQRLsNnFyczIdpOAP0
	xnNU5hZlT5dZXmreWyiXg9cBC/XzyneNwXQNufrlAApCdu7knbTSzNOo3THTE53u7dHmPqhYGn3
	JZ7W/r0U0kI0KwzOEADEF/cxub9La4Lw6R+fKcoHVDrKDEcTMv0tMyQ==
X-Google-Smtp-Source: AGHT+IFepJRsVKmCNDmpptRQJvDtbt9c0wB2ebPH7poonDcfu9JIbwI8zP6fJws9cdkkc+/3wR7YDQ==
X-Received: by 2002:a05:620a:4409:b0:7c0:a0ba:2029 with SMTP id af79cd13be357-7c5ba1e9625mr2904836785a.40.1742933199638;
        Tue, 25 Mar 2025 13:06:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 00/13] rust: generate_rust_analyzer.py: define host
 crates and scripts
Date: Tue, 25 Mar 2025 16:06:23 -0400
Message-Id: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8M42cC/33OzQ7CIAzA8VdZOIuhBebmyfcwHnCWjUSHgUn8y
 N5d5sXFLB7/TfprXyxScBTZtnixQMlF5/scelWwpjN9S9ydcjMUqAWKmodbHLjpzfnxpMA7n0v
 JI4iq1FpvKpYXr4Gsu3/Q/SF35+Lgw+NzI8E0/csl4IIbxKo0aNAauWsvxp3Xjb+wiUv4JSTAI
 oGZkAJREECpAX4JOSeWv5ATkbeVIkJ5wl9CzQjERUJlAqwGWze12NBxTozj+AZOzoP9fQEAAA=
 =
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
 Tamir Duberstein <tamird@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
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

The trailing commits can also be considered optional, as they can be
submitted separately. I included them in this series because they depend
on it, but they can be split out if this is preferred.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Split remove `"is_proc_macro": false` into separate patch. (Daniel
  Almeida)
- Move whitespace change from "add type hints" to "add missing
  whitespace".
- Add patch to avoid default arguments and force keyword arguments.
- Add patch to add type hints for CLI parameters.
- Replace some instances of `str.replace` with `str.{l,r}strip`.
- Rebase on next-20250325. This must be rooted on linux-next because
  it's the only place rust-next and rust-fixes have been merged.
- Link to v4: https://lore.kernel.org/r/20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com

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
Tamir Duberstein (13):
      scripts: generate_rust_analyzer.py: add missing whitespace
      scripts: generate_rust_analyzer.py: use double quotes
      scripts: generate_rust_analyzer.py: add trailing comma
      scripts: generate_rust_analyzer.py: extract `{build,register}_crate`
      scripts: generate_rust_analyzer.py: drop `"is_proc_macro": false`
      scripts: generate_rust_analyzer.py: add type hints
      scripts: generate_rust_analyzer.py: avoid optional arguments
      scripts: generate_rust_analyzer.py: use str(pathlib.Path)
      scripts: generate_rust_analyzer.py: identify crates explicitly
      scripts: generate_rust_analyzer.py: define host crates
      scripts: generate_rust_analyzer.py: avoid FD leak
      scripts: generate_rust_analyzer.py: define scripts
      scripts: generate_rust_analyzer.py: use `cfg_groups`

 scripts/generate_rust_analyzer.py | 330 ++++++++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 87 deletions(-)
---
base-commit: eb4bc4b07f66f01618d9cb1aa4eaef59b1188415
change-id: 20250209-rust-analyzer-host-43b108655578

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


