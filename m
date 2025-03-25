Return-Path: <linux-kernel+bounces-576114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCBDA70B17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873597A7F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407B267B85;
	Tue, 25 Mar 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKbJJO5w"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EE267B0D;
	Tue, 25 Mar 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933222; cv=none; b=e7iml5d31iXMI+koLJvRCouIo5/bjpngKfq8jEpA8o+hDuDnvcmTqjV9yw1mWZkNpnb8dy2Kf+SnnxmP+VKCUG2r+oEMFJJYU1DzsZfUwQaCg+NlZtiqhNJQzamkRl3G3XM3DOQogY0/rlBjZFwmhJSk4+UG+7AHI+4U4RKWWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933222; c=relaxed/simple;
	bh=srGNfh5JskTbG+L+vHX6JNmL4vBd4cpetPvPNJaflC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5+0pgLEWy1dKRY+4bJ9ssCfH3CyxQih1gMfrYH1YiUpELiPCCtHZC0xsUuWdjBt2SIEP1uqo8o63PqyZXibbd03bcFXGA+bKc9jqTHwhFhjv9hbywHA9bdhvw+xnw2OBULX664IBjuH3MlffjwEKGNRgf5rzX00aNb/wJjqarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKbJJO5w; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55b53a459so577020685a.3;
        Tue, 25 Mar 2025 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933219; x=1743538019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSRxIJTrtDAGZ/UrpdmNrq7fIRw+Z0BD29MCAXHGwUY=;
        b=DKbJJO5wB/uofVPQyrRyH1H6HbpOOyKFzCPnJpC3AdlcdTuTjJ6za/aLkcTCyjYTNA
         lhEnUUdUd5mHApKzLF9qvjaPjF10vMa6x62q8f4e3IisH5+OmqiBsG/YpBzkq5l6ieUp
         pJojLemkjLsXIhVJNgqKPLza33XR7FYU1VDLf/cUrrQpoNHr+C18y63jgbaP1JwvNlkD
         6kLnG1L+LppK4cxtVE+lJG92t7jlJVVhjOrRZubd/pfI2MNFwvF+rZyePYEpI5Jxh8Tf
         hKccTTX0RDOe3xn8cLwhL93IGu5oyLgbGUiW1rqHubf+F/64fPnCoq5b2JO5pa3Uc/wA
         E60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933219; x=1743538019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSRxIJTrtDAGZ/UrpdmNrq7fIRw+Z0BD29MCAXHGwUY=;
        b=lCUuSAXG4hq74FX32Y+X2nIswfXsMv0aAfudB4JaigJYRIdPhfRLWeMtOL3nO93H8D
         g2JE5ZF76z0U//xmw8ew2NmDWG7RC+f0TrCGZiPAUluclNEjppOo8e3an6w/7sg++8Kx
         VhqsMWKOYvBgxsCH9cok6TLyvrjFgi1U3uYjeH94LZBb1+tdK7lmutPgDxlnpNa3h2Po
         dGG0fp4n/JCWZCLY3+qkTwj00+tov4OR+qS/pMQ0dZg1sO1CK0m/Be3DwQR5TkxTyWiE
         b2iHWvVa2zGddByCjWZrAQ3FAuPh7164ZLMQFqiNnHVL6E+hM6rNvL9hznr75xo7nE9f
         uttw==
X-Forwarded-Encrypted: i=1; AJvYcCUERe4OD9LKBON4CZyQ1aHEnybhROxyHkLiO6ANIOdWiUgDqCmJVKQ4yHVx1w3q4Z2bATYJbqFtsKUHFAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WaNdwNEEXTZnRdrUxQh44fZhDt7n+HE6DYn83BHUg1AezD5u
	LNK0/aGv6Gwfha6eIr1KNTK9atiPjliUMKEKuLq9LL8OeDFnL7XF
X-Gm-Gg: ASbGnctNgzTINt43+A3cEKkWDfRIJkG6SwvRf4Ko7//HaBT+gxIT2YO0cshgBOth7Is
	d4yyJYbWM3ukwlMdUbPewDiTjolZOnaIu+4QJQ8HmK4H7Pbs3fjH6c3wf2xXEqrhaouJI856hUx
	5Yh2u0oNZaWm3mfKYGaCNUOWeIKyAqWnPIp4YUZxLolDIu9FdmyvVqzIZyXYWff1jPvR2uSSukr
	URL1xalveqpADOORaV8WFmm6EmHV964K88QVGQm7Ek2oE0LvuqNA7nXroo+ELOKh/+3PLvzXQ0h
	3yhf6roGD8RHxMzkW+xW+c27hCvX/zd0wWb5xbA61dppNakq9wmgyz9ODhWKPThBSvJqIoDQa+x
	5i8jmnOUljeDMBkBZLsXM44CO7mefUns7PdXEcOtidTYjUGnj32YNPw==
X-Google-Smtp-Source: AGHT+IFsSzdWyb8Lup1WtXHsJBfffopY2Nuc8ptZE/CVsJGtvVVON39tfpOR9VwrPv2J1yxTspuChA==
X-Received: by 2002:a05:620a:2405:b0:7c0:7c8f:c3a9 with SMTP id af79cd13be357-7c5ba131e23mr2368292685a.1.1742933219437;
        Tue, 25 Mar 2025 13:06:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:36 -0400
Subject: [PATCH v5 13/13] scripts: generate_rust_analyzer.py: use
 `cfg_groups`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-13-385e7f1e1e23@gmail.com>
References: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
In-Reply-To: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
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

Declare common `cfg`s just once to reduce the size of rust-analyzer.json
from 30619 to 2624 lines.

Link: https://github.com/rust-lang/rust-analyzer/commit/2607c09fddef36da0d6f0a84625db5e20a5ebde3
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 5c0056c265bb..4faf01e2cbc6 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -29,6 +29,7 @@ class Crate(TypedDict):
     root_module: str
     is_workspace_member: bool
     deps: List[Dependency]
+    cfg_groups: List[str]
     cfg: List[str]
     edition: Literal["2021"]
     env: Dict[str, str]
@@ -51,15 +52,8 @@ def generate_crates(
     sysroot_src: pathlib.Path,
     external_src: pathlib.Path,
     crates_cfgs: DefaultDict[str, List[str]],
+    cfg_groups: List[str],
 ) -> List[Crate]:
-    # Generate the configuration list.
-    cfg = []
-    with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
-        for line in fd:
-            line = line.replace("--cfg=", "")
-            line = line.replace("\n", "")
-            cfg.append(line)
-
     # Now fill the crates list.
     crates: List[Crate] = []
 
@@ -76,6 +70,7 @@ def generate_crates(
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
             "deps": deps,
+            "cfg_groups": cfg_groups if is_workspace_member else [],
             "cfg": cfg,
             "edition": "2021",
             "env": {
@@ -293,7 +288,7 @@ def generate_crates(
                 name,
                 path,
                 deps=[core, kernel],
-                cfg=cfg,
+                cfg=[],
             )
 
     return crates
@@ -328,6 +323,10 @@ def main() -> None:
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.
     assert args.sysroot in args.sysroot_src.parents
 
+    # Generate the configuration list.
+    with open(args.objtree / "include" / "generated" / "rustc_cfg") as fd:
+        cfg_groups = {"rustc_cfg": [line.lstrip("--cfg=").rstrip("\n") for line in fd]}
+
     rust_project = {
         "crates": generate_crates(
             args.srctree,
@@ -341,8 +340,10 @@ def main() -> None:
                     for crate, vals in map(lambda cfg: cfg.split("=", 1), args.cfgs)
                 },
             ),
+            list(cfg_groups.keys()),
         ),
         "sysroot": str(args.sysroot),
+        "cfg_groups": cfg_groups,
     }
 
     json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)

-- 
2.49.0


