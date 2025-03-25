Return-Path: <linux-kernel+bounces-576103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC7A70B01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55183B8396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C32266599;
	Tue, 25 Mar 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grqAmM2f"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D461266560;
	Tue, 25 Mar 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933205; cv=none; b=Vvu70T405VphJcjnw0eoUaWmK/Y7dcDB2GBYLG1Wt+ebLg/CAUmaLpKpaIufYKvwF3s3mktx5IuVo7fdwQvHHOONZpvfZWwzivFP5oaDLDFdKf2uN10tbsFcr8CH4Mww1ulKOZHN605YA1Qzcvw+PjuXnjOCED4ZPckljL+THok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933205; c=relaxed/simple;
	bh=v2QSX0QkoHeeWs5dJxhmBZTf3fzs6LxHYd7DDowPVL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfgPNxf5lSpsICxmRsDDREUaUawg/mvu5nNvU6LFZ1Dkoi1vQzgJN/CIWnXZ5qPitTGly0D27JxLoW6t+4HCO/LixhFeJhvhuGKB7AYMB2kQ+c12RO4HeVkZZ1fAgzGEsVqeVgF8SSAjRuKDBEFEe+43cxIFe41IK8Ts1PCOeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grqAmM2f; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54c52d8easo24644885a.0;
        Tue, 25 Mar 2025 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933202; x=1743538002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hInmf2ZmSMzZJVmSYezo7QRv5Caf/+GDp4vgvM388ew=;
        b=grqAmM2fku8OXFPWJX7KsjGxNCJPl6eQMo5e/fyjeiqFsDXVjko0U++pPniuSIGCz0
         qk2FlMFVcK94YjSjIAGD/v25gXIr/ZU5G2/tBuUFPdtiSR/RMC1yOTB8hUmO3wur3LJM
         9nOacGlLX5ewB+YAAwnNAGSLge48UrCNQJ+hfK56OKzJkflN2MBmtK4oJ69QJ2FdoAEo
         ouGfbYsRiNdUXEBlxOC8TRvvxZ/1qa8x5oiWSan9mXaRGTE4Goc4ar4Dt2jEDih5loAc
         NtGLsluN6UNCBHeNuZFu7HEJDkprKWsKh2Jc0kWTpA//kURAJuiJpfmgD5ztWpsFO66I
         KqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933202; x=1743538002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hInmf2ZmSMzZJVmSYezo7QRv5Caf/+GDp4vgvM388ew=;
        b=cHF0e6SgeTTl508jufp0LrUWmhvB5Gvl/gALyLX5d7g38GDhl+YOVPmkZ+axu6AGBl
         daq8vB/eciZ2SRqtJCeb0L/oux5YH8s5HUi4MS9owFYGw53cCDpsoexisPDPGKuNpKhl
         Vtnh0jSR0hPtnT9rdLWeFYF1Z7LDnDxwpE3bXZ8dsZtcQMDnQdcza7uSt3noFED37LW5
         hBWiQ7QuhJ0dOjkqUNhvalYXfrvkGj/WhwicYaPpXiFlxivmLxmpqAFrBy+oiOYBV22n
         Hx2vWuUVt2KMPFJiR/I1n/JSzGV1IDmqGVaxcnfAD4LSBEo1u1rZUyrS9uq6tjzkMm28
         57tg==
X-Forwarded-Encrypted: i=1; AJvYcCVpzZzewlqsc6HQDDWSgDKxYuqgNbB6xMiNu8mjnshWamTgxl5IjF5wKdvRE2dwrc/4HXAlYbsc3CDiIFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/gEu+DTPc6ZMpX2FN7GJR1OMqVdk9AoFsGmnfRxX9EIpDk4t
	xljJqoN76k0wJh+xIROrDvi7wQl82FXhES1IrkzHNVa3GkQ36GOE
X-Gm-Gg: ASbGnctXROAdSijTcKt6czXRQlfpfR+oRhjGGIV4oAhLQ0MeQq4/lf8UPNsyxpS66LA
	SaXVVf1TR6qLL9VdyGXaZP9BMEYEXhT53AXW+L3ktWC3vdFXhCIAah8LK6HVLbmZ4uXin5+srBq
	2OFdusDBxKdL8unUlxs1VBXG4yO9kcAheGy25aV60eUfBfd+iA/1Aj1XJ7H7Bu6iH49NHibOW6w
	u9b4JhhMXWHH6SyTxFJ2yczEe9i3h/EDGNvydIKkllKW7ESUGw78pf7nnpPIbM5bFqs1i2NvZh0
	uJqWNt1ZG3i5pi51IMCL7av0ihsjRwuzODOsCLnRS7y3jXET5jye1BThbixVDb2NNuOpu+FVkC8
	xVj0DEwkP4rs6JYeRrP6AI027I4S/2PoiPo3L511CT23kb4N3U0Dqq9OgAD/UxChw
X-Google-Smtp-Source: AGHT+IFK8vphe61iExYx7dRaKwB1RBqGXbgj531la0AzLyVNZWTQaO8FuGGVyzVp+EO7Q0U3D8UipA==
X-Received: by 2002:a05:620a:17a0:b0:7c0:ad47:db3d with SMTP id af79cd13be357-7c5e491453amr184613985a.21.1742933202032;
        Tue, 25 Mar 2025 13:06:42 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:25 -0400
Subject: [PATCH v5 02/13] scripts: generate_rust_analyzer.py: use double
 quotes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-2-385e7f1e1e23@gmail.com>
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

Replace inconsistent use of single quotes with double quotes.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7bd7f7ef2529..7d4274ee90ab 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -170,8 +170,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
 def main():
     parser = argparse.ArgumentParser()
-    parser.add_argument('--verbose', '-v', action='store_true')
-    parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("--verbose", "-v", action="store_true")
+    parser.add_argument("--cfgs", action="append", default=[])
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)

-- 
2.49.0


