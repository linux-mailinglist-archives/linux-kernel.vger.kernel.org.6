Return-Path: <linux-kernel+bounces-557125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E3A5D3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFBA1774B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79F14D29B;
	Wed, 12 Mar 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6/axH7g"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48113A3F7;
	Wed, 12 Mar 2025 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742268; cv=none; b=GxKjVrms8gUbXepiTtaMfipmlVJ30yuW7JvACh2ZAjCz95ou9qA8NqLQae/4ibZoeRdBf0OUd++rtthqe0r76MdqHOCUTAfTqyeT950CBjGg/VF0o15bpWoS61dLPie12ogrTSCoAIQ6kqnxO/mmYQy55md7+3MmxiHHMUTHfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742268; c=relaxed/simple;
	bh=RyaLkXl9kX5iA7WcKe4mmQYs2dDyrXegysm2+y1UChM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNwH2OgVy5MCpxr5quLkmKHRzBSSrhqv63bikJ55F0fPFeFoeO9WpWxqq2xGRZP5ptZf2/V+YLlnO6z4wtiAPQv6T59khN+GhXymQ9Otnc/bkB2A/cGFMAaumm9A5sSTLHknBmgvA21114LXDzUfni8JZd6KctQ8CXAeZ1Pniso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6/axH7g; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8efefec89so49552996d6.3;
        Tue, 11 Mar 2025 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742265; x=1742347065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkdJVLyC+3pFRj2tgwQ7Jhglb327o4ms0rKwM8mHQQI=;
        b=F6/axH7gfTRAliFNIU5dGWoyvW2opW1wsUjuUgyoxyjXsdoGb1eGjZ7z7kFVLQDJqW
         4O2EPZ5k1XMP/v/FesDLCkpw7/HE5GAr3VNuU6CJ6t01ZmeJwRDEOIvhwMpdjprVIZqQ
         as9iz72vlXifJtU0Xmj2J2HaKBLh1YdBwKkOjiPy78PqnC9RnAiOY9rMP8INSlbtheQH
         M3/hV5j3r+BEMIM50RAtAuxKrlSDWeh0wN26Kn/8uG8J7ZqAnXVTwKgO7+KePEJTdFkn
         eMq3s4oeQHkH39b13q8h8dmgZO6PFmXOjWJbff3SUg3odzc1+BxRCd+po9UDhF8BqIFY
         c2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742265; x=1742347065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkdJVLyC+3pFRj2tgwQ7Jhglb327o4ms0rKwM8mHQQI=;
        b=VG2Tw7T9G95eA1cq/MPRKTbPXhkdMiwbljuj6b6KmwfDoTGf8qafQfhsYCH4/YMOY+
         tzJ2eSHxr2myfV07tO78qF3rlT0aScUPXTBE+kJu/6tBv0qJS8JgKZb0yxRjE9gLI6ne
         ke1jwj/VHLrIf4F+tVhVe6wwILTqAvNPwd3QX2L133Ezrzm99XhUH3KkXSiEmS+sPlJw
         tOM0+QJsPkhhm6Dy8KsMP1QCO4nPy01GFbgeDBp1RJ+sNTLEDC/U/EYjRnDeYZECIqLt
         o6v2BPMOW3kT4+jX5+ZLULf2HcQyRrqWTs3STd7ETBNkqhoK3K8MzKAVT8taN4XZ9PoM
         ipHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKvIQAzcGf9ATNft52qSF5zvnKBNsEiubjOayELwuEt2PN3MU/Jhpz32HtsgHJoy2WZAfgX+hOjoGTsbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY41WkLcCcHMeLFjgqxwgMHU0hUXzmIFPmVXdfH9MoYlK039l4
	2D2r3v/xjAFVmrBf6bdyBvyvWLiw0NqZwbEQJtEk85CazIpB6jKA
X-Gm-Gg: ASbGnctG8m6o2/S3duGXn3noxdMs9y0saBDs+Z5+i/OgZ9LSkS2TyHHUJ4PEslGT/jR
	7iRCPVdQxTndFbrY7LKFtlSsH3hl9i3ern2X9rputdlbIIarZ4+9IDoSZ05C+qfDMTJyb2kpYiP
	3ahdEuNbZ9p1ndcPW9CFR5m1+sfk7X/JnmRzXMUbr1pfi9dmaPaIxYthEjwA9USZzCcfW5N4xOK
	RUzXvXbvoFNnuuiPOm7Tpw+PAqqYlHCyWyfrJUN1KGrfJYHdvylznwy3X1pUTE624A9JJw4fLkY
	sTavXfpGS9LtKAsdk9fLdW2NStONUu03o2oRopfgDA0bUBw3iQ62Uu6LvpIB8/IiujSK
X-Google-Smtp-Source: AGHT+IF9FkWR3X8MdeEN/67lwUSToC8vl31IgxHkLMLzSQfJrUYX/49zCPEgsyHxtLO51GjTUroPVg==
X-Received: by 2002:ad4:5e8e:0:b0:6e6:6c7f:1116 with SMTP id 6a1803df08f44-6ea2dd25c19mr74281316d6.24.1741742265336;
        Tue, 11 Mar 2025 18:17:45 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:23 -0400
Subject: [PATCH v2 2/7] scripts: generate_rust_analyzer.py: use double
 quotes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-2-30220e116511@gmail.com>
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
In-Reply-To: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
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

Replace inconsistent use of single quotes with double quotes.

This change was made by a code formatting tool.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 15a690ae2edb..5913934ecb5a 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -154,8 +154,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
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
2.48.1


