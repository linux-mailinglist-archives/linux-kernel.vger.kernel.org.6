Return-Path: <linux-kernel+bounces-572436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47465A6CA4C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389D048496C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDA230BEE;
	Sat, 22 Mar 2025 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNqR3XUP"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9C22FDF0;
	Sat, 22 Mar 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649840; cv=none; b=ZLBRkrR7lg32ZdYHL3RQ2yT3w4JDPDkKaAr2M0P7v6PtTY9NazoQLrbRDXsJmCOcQa1vZLfueoOfVPU05tCg5Gw4xKptN8YHsvcQuUNI02m/6bW5g2IHDQL37cOgjovaK8RP6N0fRU+dCMP6FgOJsEaVGXGKok7nK5apnECnOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649840; c=relaxed/simple;
	bh=RcpYLZw1RAa8muhe/Euso6KSm+l7tmrzUWkd91ep1g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJmOUSqU+WBfnHU3CX1DsumQsocNCVvVupX3py1dhy7z8ca8bGFy512CtrTUXqJviQYXh1HMg2c+PS0LI3oMfTMojynaLneFbQtST6dEjjtSFcn6Oym9wcjQOszY9rcoqFp9yzHETAafwVRfir559umwyvf3Xaenwppw0C6l4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNqR3XUP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a1acf61eso27228881cf.1;
        Sat, 22 Mar 2025 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649838; x=1743254638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X22ATaB98Oosm8hcOWH2nhPf6uFPIBwDQQfpG0TIAOE=;
        b=dNqR3XUPw5qsAwxGvhslvPz1/239iQ5sUsdEdO8jI8rYtiwqBNSzsITDSfzas4jwIv
         VQLKJthTVnuFdXAjfbBhed2Wy8ys6UBzSM/Ty4oNqh4BNRtVYsEHLk2z1VR0CL2hj0Fy
         tTCgl3fy5JEUUSTBjPbVQqUCa61E6m+IqacTcInhNphwQra0ZEY6jW5ZEwrSc6iLnfvY
         m4Y11jNRzubRBL8HyHNwI0bzZbYhqsuP5xBhfoLXLDNbQaDodOkGDH2sYWaGXF+3lQjP
         gdqekkCaPv7NysIoZI7hd4VZqcfR34CJ77SoZOxuRLcsGWZjGcVigP8xMxaCl/K40DNH
         8TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649838; x=1743254638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X22ATaB98Oosm8hcOWH2nhPf6uFPIBwDQQfpG0TIAOE=;
        b=ur/mJSK0ww+LVgTTBhNvZPpJChOuuUm/yunVaWnlm/SFnBCnvf9EgrYA5jCOZgkIsg
         ZU2DLjDpp18aHFOHOcNonm/8mYrmsUxdrIZqFGatDX0JDMtIyO8XnWKS7KqyNba8i8KM
         3Mw6ZZgulAXPYmiVfi20/TC1pSxlUQyRt39fxxmLcXRoG7wBUrl/ZUCKpWjiz2THjkVb
         SIWtl+hSRYBQq6Nq2R8IUxEAt34EaRL6mihxZOtenhlXY7+xua58zgQoJejGeozSvonD
         Y0odp49z7xKVfxf1dn3SYi26W2189zmGan+ZZqj3GRygH+j0L70zY/ierAm+t50v/ZeD
         yo9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgsSlqKEPow9TeAYjcssDAiJXZ0ESCoqM7r2aYCjahMDOxe7SyfHPyzwfgU0UavRL2rjeWefhLvlHnjFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTnkSQMWDXowy47ptauxATaf/MgLf4v86XbpzJaP463zjdaB2
	lh/pkcIJuQixgxh9S8FJpCo3yofVlg9EZJNEN2/xzzlD/NkfZSht
X-Gm-Gg: ASbGncum3WW1Dw9zHkSEFo5cG9GAC3XQfqruSV1rM8k9F6HOn6UHrE0Y47aLepGUBI6
	6yJgP2vEmV6U6+FvOZekoEvzwRQOvz7zQNHovUm2s3rdMMn6Elr3x9JSQybMMFcvzp9RT17IP6n
	sIlxt8SusaFrfAji8tTcxt6O6kUd+Q8mV+1egRFf26cO9ooCdXun3tgUJaWcLP9ImZoaxda3xh7
	BeAahhCOuDFTQ0DpKcNnQE8sChg4b//Gp4Y8rHTV9BWcThVOpn4O6wZUw2o78/QTDav9G1npfMJ
	5D500WyCdo3WbmcmGb1QTGdPGVAmXyQ9c7gky6QyWgmC03oMpQ98lfHPAw4HX+OYUZB9+hlK/tk
	D/+MGkIfav5qMO9QZe85yAIeAWNJlyAl/r7kwl/5dljkLJnfQQOE7F6LCZkA5BeGMhQwicvc=
X-Google-Smtp-Source: AGHT+IHMFXDYpV/dIiH8VXpCPQjHip0jc322w6bzkrHDQBSbrvi9VkDtPV5iGtIQd6xfOPfO8XUn5w==
X-Received: by 2002:a05:6214:1bce:b0:6e8:97d2:9999 with SMTP id 6a1803df08f44-6eb3f32a5femr105735526d6.28.1742649837834;
        Sat, 22 Mar 2025 06:23:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:41 -0400
Subject: [PATCH v4 06/11] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-6-1f51f9c907eb@gmail.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
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
index 0772ea309f94..1ee079c6d916 100755
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


