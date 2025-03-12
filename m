Return-Path: <linux-kernel+bounces-557128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB400A5D3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D559189C9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13351A08AF;
	Wed, 12 Mar 2025 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J27KX1Hg"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979213774D;
	Wed, 12 Mar 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742275; cv=none; b=l+2IbdSzr0kXvsNXbpN9bAK0yKLo8er0Qow0TdUmBBgdiZCJudzfOjkatQ9gAVn6rM6yHUMD1w75hG/as3zweNeKOUDNbVs+PA8Rk03kBN3VexqSEj5FWP3C3NXihRnNU/wzt5y/4MwJWMgNTzW3rcDljmvygWpkFyHvOR3PUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742275; c=relaxed/simple;
	bh=BgThh1Uj39dsD3ERwfQo2QnWW8SQ1eBROVFyBcK6Ifo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2YX1KASoBBi4Dg/Eh9+0n6LK5duR5Sb5CSOhtUg7InSAD8ZFwN4DsY52UgXDvSuDAVL8ScClaOJgWsJMis7uoiPU11+SG1lIEfMnnR+/FbGFUvUelzWfn3hmM8+r1mON2SIXzwGOFE4f6nKn0aQqF7gOSoNNaqpXQ4KXCrDSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J27KX1Hg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f05acc13so62332376d6.2;
        Tue, 11 Mar 2025 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742272; x=1742347072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaKtc/l0mW3laduZvTeKZzaRaJDTU/Yr10LNrXCha1k=;
        b=J27KX1Hg/g+LVUH65QywRmOlsi+IGtXU4UXfZ/YnR2TguaX6gu9eyldembQIgs/w8v
         044CAUhGWocKEpfYM0enHOyz10gvXdBSq6feMUTR5fZhWMWycx9jHY1Zp0AnSK/NFWk9
         AwXUy3AsQPUAG/Dbww0XAp3TtOJmGi+Q/E27guPufNTUpqpG296Ej7U83C3whJfDHDpR
         AzVdFG4c/vTo6f1sZKio4Y5Kh1linxNyoT7PcZOLi04HhB5EIKaG70+TdXq5twLkWNpC
         VRnQy8EMlEW0AKkAwRGyVfY6218/QRO3EjNse40fJuAs+nDA2N+E4BB9rYl2al4/XIV4
         VDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742272; x=1742347072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaKtc/l0mW3laduZvTeKZzaRaJDTU/Yr10LNrXCha1k=;
        b=ScnBMDzCjSCXmxSiKVhXvVSneLUscBoDm3klA+DVDj0BjKB0pE0W+Y6qvJORm6+iFv
         QwTUYboOO4me6CldDkbYvcfbpCYKCoP9n+DaCHKCoDbp0Jxt3lCD6HK7q2/jaYr9Mcl1
         WWqiEXMZVUeTS0DobiXW9GruKmd2L5VHdVz/OWpCHd7O89nzCFQ1OhpW9W6XAtmf679P
         4dEkiGO+86X0a0HWbwRcfm3YqCqw4QvUglaps3OQZJW6+ma1wZKfAgh8dfyqnWz3HIdN
         /8B6m0KO18kya1TG7PAvbn2mkEszzZHPzYHBAqW75gXZL7mgVBxSkscmbsyVO1m2+MNi
         ZUIA==
X-Forwarded-Encrypted: i=1; AJvYcCXaSosID9K58PGXsa/9+Q0JY1z9kUwCxQ5WPr5rxi2Qf5PW4lLJBnJ45Re6AOiVbRHUTwCo1qcRr7mj4kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDkkZ/n4fYFfudE+WK5bQRJWmnb/hHjK1ogh8RvhH7uy/Jnry
	w5Q0uhDSQ2mtgap9G2SFLm9gI0PulhTEsi/qBlHbvpMhzA5notQE
X-Gm-Gg: ASbGnctywhr8vqDudI4wDQrx8g++m/6MvUQSGqPIenKmTd/GP5IwjMtU0KGnCVJtHNI
	Xpn2eHLnZoLd82Xq3yqA81ddVGp7xojMjGRtv//TpgNsTBbs1CQRFWtC1SFkH790VMYY06WCzeL
	9NtpnBiyp906u5EB1jNaKoZHTNAOdZNUwX9oP36tDOVpogluXtXWa1J2EsDZG7ENQctTXyVckCC
	cCvCaBvCC3jBpdWdugM9tuiKdBNaDTOTbsLWuExPks25c71OwgnxjDJ7Q4lsu6c4oH8QaI1VnI3
	2KRIcA1DYkkY9JFFve8EAG4gAJUuBQpLOm8WMoFQazhx8EIHC4fENfqPy4Xwuy7jVg7D
X-Google-Smtp-Source: AGHT+IH+iMxjtwH4nwrrqPI7nXqS7kAk+GpkLS5RDJxcyUIIFA1C9nayRM4oxawHNDs6TD6lFvxefw==
X-Received: by 2002:a05:6214:80b:b0:6ea:d393:9634 with SMTP id 6a1803df08f44-6ead3939835mr178986d6.3.1741742272466;
        Tue, 11 Mar 2025 18:17:52 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:26 -0400
Subject: [PATCH v2 5/7] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-5-30220e116511@gmail.com>
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

Use the `/` operator on `pathlib.Path` rather than directly crafting a
string. This is consistent with all other path manipulation in this
script.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index c73ea8d116a4..1bb185ae2e87 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -109,7 +109,7 @@ def generate_crates(
         crate: ProcMacroCrate = {
             **crates[-1],
             "is_proc_macro": True,
-            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
+            "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
         crates[-1] = crate
 

-- 
2.48.1


