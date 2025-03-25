Return-Path: <linux-kernel+bounces-576102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E91A70B00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2648C3B7822
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ACB26658D;
	Tue, 25 Mar 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKNDGjGE"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47141265CC3;
	Tue, 25 Mar 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933204; cv=none; b=Na1EMIeuDzYyyYD50Wrrzj/WWFSL3XIrm7lbqZPN/ek/lSXYGowkw5EbrlM7GaHX6jZ01H861fWB1VYD0TqGqVZGdrdzCTXV3zajJ5n/IiVLYOwLg3mjkdeB/olrlj02OE6rzlPCbnLDeD6xtKk1YGj92c/5OL1ZYKV9AtWGqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933204; c=relaxed/simple;
	bh=amAr5E0aBIx/K15nFizO7nPe5b4QCSDp91BRzALGDp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBd7FvEdiKgtblytX/IXep7u0GjFfk7yLb7E1hGFmMssxOOgAG0KIdQsKl/Ruo4f8Py+ylwHxq3x/sBbbOkswH2HH1HVeuWEfhvCPI0wKE8BUaXHj93Ux8feJ7agf5FnMaxtYH9o4z2xou7ixk6Zn75Tz8LowHiIdTU+itvxSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKNDGjGE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47686580529so58119041cf.2;
        Tue, 25 Mar 2025 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933201; x=1743538001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMuuZscz9GIa7rSURlINgWLPX2QsIky02FhmYuiPfS4=;
        b=aKNDGjGE1QhV3gJZQsQvww7Xd50ASbWVugqhC1Q8ve/0Y866m2FqDiPFj1CqNR7ksN
         jLcp9X99Ik4E4TTShR3BL374IhNeCgmK1EA+awM1PZuNAODyexOrsnMA2h7GOFtPN28h
         nhoEoPwO2+jzHBZrRYW5PQhXnBIq5D0JU0gZthfgbhPyztmYGLf6mjlDScwsYnymt90p
         2Cwq9hwiV8ymtemYgXkqVytwWZLn5jG3DJSgcn+EreFy+z3fRCqEyZtYaRUlGxCEiGqo
         O3FL16ohZ4y5w+UWsUks/h31+4UTaSjJtm0dyk1F2gegMYzPH7OvGREEo7V3ARjVz6QE
         ehcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933201; x=1743538001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMuuZscz9GIa7rSURlINgWLPX2QsIky02FhmYuiPfS4=;
        b=dq77rknFQM515hXeOZLJRsdHe1aXzSzNduVn0FGa5JyxFHZg4cZncgbuRM3erQccob
         PIy4gU+/LsablvIX2Uzl5+scdJjMbc/x5BGR9E+S5d0fSa1rTLEvwPUObGeT58eSyA5r
         VT7G3e8RfIgL0FY1lnxKAhSGyNh6USup4Wo0dI93Sr8L+236CAdKBZhzylt4o6Exuo4K
         B0pFzoWZGh1yPh+wYMqeDPqF3kDzKhnAEO3Rp2z7Zsljtpr7GxW+ZIrvyiuPPant4uaE
         /JOt4vXaCz9BqcKy0QvMDtbFaP1iP3DHfS7Qfkob7b7lG5r+t5KvTsTT2Yr4P5pkJwuO
         TMpA==
X-Forwarded-Encrypted: i=1; AJvYcCXt7Cj957n5kleLkl4epFHlEORHwTWK/IvnbUkhVjAnduIJkdGHk1rdS043+8+dSiZANwb6n59T4+lng9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7nKxHHPRXoLbU8ZfbOZSAqJIOdVN0g6aO/mHT+gJAPIS2+lS
	ntiXa5EplVBIm2uJ+wldHfEL3T4Xmya8BlwWSmL0vGJhgYApIpaP
X-Gm-Gg: ASbGncthL0vsBghzJBlP2BIcpLT1ub91uvnZkpQ22JcTdp5QVvlv1DAKtbCVcbJoQ+L
	IJashIEdyfGUbWss96fRz83SBVecAgGSXteQFEHwpG3hkozzT9cjlm5equz+PFpNv8DLOSx6Bn8
	acypP5ZI1V6afTxw3Cp6vRMsz2IKiXJjyDdUQ9lpJDqTJiX23I1VoV3GKkov0zqof1nZe9ai+y7
	uQftGN9Xqaepsxw875pLlanaRXKVHd/P2CsvoVmq4OOseK1StrHo9PeumIpNPQWMEoLilq1Bl6c
	F+mn56RLxWGymiv8V2rdsOaZCPhr8mHXr4lm0iYne4QpYOI8DWqqByKT3jNP4q/kTExEntV7xYr
	zPFqlvnk8kVcgxvQZ4tdms8kbQvKYVeLeAWuolbdmh9PI5kFHDhzj5Wc2R3+HfAIy
X-Google-Smtp-Source: AGHT+IHVfWkpZu6b0+zqDfsamVkn5g5nlhvtmpzMZ3bm1lJ03if2eGIMlqxVL7dZiuyc9W5tOKvcBA==
X-Received: by 2002:a05:620a:d8b:b0:7c5:6a35:81c1 with SMTP id af79cd13be357-7c5ba1fba0fmr3311090585a.48.1742933200963;
        Tue, 25 Mar 2025 13:06:40 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:40 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:24 -0400
Subject: [PATCH v5 01/13] scripts: generate_rust_analyzer.py: add missing
 whitespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-1-385e7f1e1e23@gmail.com>
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

Add a space before the `/` operator for consistency with surrounding
code and code formatting tools. Add a second newline between top-level
items in accordance with PEP 8[1]:

> Surround top-level function and class definitions with two blank
lines.

This change was made by a code formatting tool.

Link: https://peps.python.org/pep-0008/ [1]
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index a0e5a0aef444..7bd7f7ef2529 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -118,7 +118,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     ):
         append_crate(
             display_name,
-            srctree / "rust"/ display_name / "lib.rs",
+            srctree / "rust" / display_name / "lib.rs",
             deps,
             cfg=cfg,
         )
@@ -167,6 +167,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
     return crates
 
+
 def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
@@ -193,5 +194,6 @@ def main():
 
     json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)
 
+
 if __name__ == "__main__":
     main()

-- 
2.49.0


