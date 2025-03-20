Return-Path: <linux-kernel+bounces-568983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12204A69D10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C50A981F83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43D36AF5;
	Thu, 20 Mar 2025 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCWrtvJT"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEB184F;
	Thu, 20 Mar 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429253; cv=none; b=W75URNz9yYhbwkb5upHDcXDvIuog+3zbgN4Rk3w0LarJgHNK/Uz+e+coOnQEziZ8X63On/y0OSHfbjneZYHQC33SGnTCcsM+x3GQhTHgyfqGZ0pmsQne759d34dCMhTJPvqMzG9vCZ1L7SWW+sbUD/tB+JO+dkn5RpiNIyH6YZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429253; c=relaxed/simple;
	bh=JdCyp8ZXNj+fcgKqSmXD3PggNZEZw2J8jfBJPnlDeZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjCsr3agp0ogybpeliWqNfyUEe9DagAj0NmdwVDICxd2ZdaDAsSFOILLoh+oGjXukVY4LxG7K+WtoSYJlGxHFn8KuZDUCRTIiLdqc9Qv8xO6fNNXe0M6U9eDbCYNBGF/aaa6MT6hGCxvMrmSOa+FlmVEz0s8XQdx6bmpZB8HHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCWrtvJT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c07cd527e4so23321985a.3;
        Wed, 19 Mar 2025 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429251; x=1743034051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fj+kk7Lkzxt8uLQdw0OmZf5Yvssdshhqyv1gEmXKIf0=;
        b=SCWrtvJTKFMO6mJEpMrofEzIQrqBy1NAdS0kkyxzWcxpRHeRJ+BYDlyJ4ADcI+PNJc
         y+tQpp6YnLvH2MS96sRXvPE0mwk6R7+0AqR74hMpsEEzrRk2vtaKl7PPj+ocIm6tXLXs
         lYJ1BzsJSHKndfYY1gEo2K212NVaZNVYlARSQqf2b4RMlhFNnvxxji3yjoe4pePIY+Dw
         XNJBUKCzL8zuQIwQdWAuspHuQMoMhTY+c5it3FwMMIV/FRytsCl7o5+31cBmKIQhLN/C
         CSrFJlhkybWi65JM6obg11oUwequA3n5V8fyQ3aAPrnSSX/V1NjLugiALU4YbHlFruE2
         ko2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429251; x=1743034051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj+kk7Lkzxt8uLQdw0OmZf5Yvssdshhqyv1gEmXKIf0=;
        b=cOR75t5zNytEFTMKK72tw5vW1YPLF5wx6ClX9wbEkM8Pcb/J3QWZdeUOhmkBYFYWp0
         txziNCUMtJluj5jo3JqHzfx1uqmoZ1WXxRvEoTiUwWXRHL4Z4BvMQUs67wwXKNoquOcm
         vwRJ8ZApxiYcXSK9y4KbZurXAtkGj2nTlMxDoODBjtXk5GPKj7J1mvjfyHG3nN9VPE5N
         GnFxIrzS3QHDopvE1mbPqozP3fP8E2u94Ts6aN0nqjuEsjzvyAJwiEkzOVB4zF5QkfvN
         xVwUGWaDyl1sz2Xb+5Lkb2eHL8g5NA+jj47/vkMglUkic8FWIsdtVERTt7pwXiz7WRog
         cKcA==
X-Forwarded-Encrypted: i=1; AJvYcCXCFfMo7jw35/TEEhv+zYt9aFSoNYkffCrVBFHq+o2xR5Gdo+otj9DPa387XzXLiCAWMtidwsho8HGLMpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8w6LGGy4GZgHMGyiY6mKeBQksGMcDbG1zJtIUhR6oJwGOe4lh
	+RUmDuQXGgVUkl9jmD9Z9K7FxkteILVTtE0oBJrbUnqrvEZz5Rf9dH4tvfn0bTE=
X-Gm-Gg: ASbGncskZimgVz8xTm2UtEQzqgf5WXn7OHVWmvk+Ob6L9mla0eg3s6G0ugRcDwrHyXD
	p/iTLW5dKVeGO6G+ka+Y3ZNKuL2PfC75QWz97fRmSLGGnoXv5fm3GjkF3YnODDGh5dwCfDgMa5W
	4/qlq7gjPQOkmBj8g3fUS7KVfqTL1IbDsJqrBzBCZxsagyJirqF/FJMcqckvyRbCndN5rSXa+rH
	/i3IEpfgZIqGXmTfj2haf32NrmHHpwajV7Yb1C8iJflv8ibo2QtI2rdSJ/TAg5YwPFwWC5vFsU2
	GDyn5Ab+TiRL1eytGWycuj+5yeZvbVHszIifMnjin2KLvgUAL7b015fnBkTlC7R9WHzbrZAuWw9
	U8HdBIPwalOc=
X-Google-Smtp-Source: AGHT+IG3VoeVKKlF39aMv6Hh6VI/wQjXSbzaMX78+jaPc+twdrjhcXQ3LVUKAaGDJ2UhS9G4UqHuTA==
X-Received: by 2002:a05:620a:469e:b0:7c5:6ba5:dd40 with SMTP id af79cd13be357-7c5a83967e9mr676597485a.17.1742429250640;
        Wed, 19 Mar 2025 17:07:30 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:21 -0400
Subject: [PATCH v3 5/7] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-5-311644ee23d2@gmail.com>
References: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
In-Reply-To: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
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

Use the `/` operator on `pathlib.Path` rather than directly crafting a
string. This is consistent with all other path manipulation in this
script.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index c6f8ed9a5bdb..21224fc9be8f 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -123,7 +123,7 @@ def generate_crates(
         proc_macro_crate: ProcMacroCrate = {
             **crate,
             "is_proc_macro": True,
-            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
+            "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
         register_crate(proc_macro_crate)
 

-- 
2.48.1


