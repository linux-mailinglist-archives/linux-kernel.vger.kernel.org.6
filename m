Return-Path: <linux-kernel+bounces-355318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C442F9950A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547FDB24CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A151DF722;
	Tue,  8 Oct 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVWsTOd5"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3A1DEFCE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395377; cv=none; b=B5YkS2qBAIuV6a9IhKdNAF3FM6VKUtnaHl4Tn+pBKms1YSJIfjORECjp+9//637OOFRQGvS3hUayu1e9vcqsPDCD4hnIUhVG5vZFzjPrRfseMDeVEqrhJv68pI0W4aLBR40to3kLMWkqjp7rWbwgMSulDgy095W2Bc8dmlawhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395377; c=relaxed/simple;
	bh=PAy8KbMPRxDvQPnFcsHsbRZaqKCFxxdrKz60LsWVkgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qZl+1H2/pB+9FiFT99r+boxZuGg3DbjaY+ogXiqqKo0mn8kCAfXIOXmsz9cmKbqMqiwP+nJ3NiDTT5S5tVfcPmDrRf5CmJSs3oKLls5Abbg54KLyw/CTZZHwuHET02T7i1gXFr/Ghj7sZ9SJ+BitqLWnN47YHf0T3JL5DpYgaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVWsTOd5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28edea9af6so956382276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728395375; x=1729000175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ty371un3VmcVuir+Swm7PB3rYO23gYtOTEJBH12hV04=;
        b=vVWsTOd5yukSL5Z6gz/jflPm1qBXpiTg9V66xy5WHq1KvLYb3Zp5qHWZQaGr8rbR1w
         mCTgs2f38DmBGUL4uK5fNoCRDFdB55ylk0xsx+pVDyft4dVW4bZgOX4qKUExDroIat5R
         Zd1Vr4ZxaYRfZ4CUVMbY5LufWuA/Fnx38AYNWcimiQtjbAAwg6sinfH5S7dzvIo73U4t
         RMPQPnGajjwqaA1HBviX12B8pTGTGjJl2jTtwvrUbKmiNLEe6Xoqpb3fNXjSmOv7eRab
         0v5MfBG2DahQLcTFPN3Ki7PcE61NHmn2y4JhMNQpJ/hJ6d9DpDB3ZQYDLoAtFz7FBSHe
         sPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395375; x=1729000175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ty371un3VmcVuir+Swm7PB3rYO23gYtOTEJBH12hV04=;
        b=hOMlVesMX/VIytq3C/hBh22kUfGDQqT5Kaq+v4QMicIDQmOD3iD8xQOMWQEEtIUvdz
         KgzmQhQ5DVu1Cpz7SHLhuIfJCCHT7DD7JSVJSw74aJgRNy7StgNfVzQ8AlUyNM7i6eSn
         0l7loCUbSLam1zeIkjwEiVim+nQXjnSkbgHXdtqpCJqKLuOjgt15mVFL1MS7UxK4p4/I
         Ps08uyce9aRsnbdtDHMIoaNAoMe6ZrHTCLVw9XiXfyR2ILAuwXJzyUPWNDu4w2uAYUgq
         EPQft4GrCWTeqrdB2XFSp+MbkklIpdNzj0BXtJwVl2Q5/ELaZbYnNQMh9lWfw3CN6sHp
         E/qA==
X-Forwarded-Encrypted: i=1; AJvYcCVE7gW+KX8kCKUIv0RxoBnYH5TNZl9sXzdGi0s48CSCDZY2KbXjUkePMX+lTy1N0Wqdns/y3IJxs2g85M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBQkskYh2XNcflOezQOP6Un5I06HN6AS4GfJl0gsFAlX1/xaI
	V+Is7fA7qTZWxYEUtLt0yWCEjkwA74CSqRIfs+9m8o6nzzE4Fmo39VY7miSWC0mRGX2uQR+mkmJ
	k14JbN1T9LyTzyw==
X-Google-Smtp-Source: AGHT+IGqXAzL/FwZ9UoYeFmPh5E87cmBlGLD64DsNLrgtpsNzYOYsp8QScgYTxKxgy/aFZ69YQ68J1/XuDzw3Ow=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:4b0:b0:e28:f1e8:6596 with SMTP
 id 3f1490d57ef6-e28f1e86681mr13360276.1.1728395374730; Tue, 08 Oct 2024
 06:49:34 -0700 (PDT)
Date: Tue, 08 Oct 2024 13:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEs4BWcC/x2MSQqAMAwAvyI5G2jd8SviQWvUXGxJqgji3y0eB
 2bmASVhUuizB4QuVvZHAptn4Pbp2Ah5SQyFKSprTIdyanToQ0wizt5HjTIFbExL9byW1lYOUhy EVr7/8TC+7weNr32kaAAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PAy8KbMPRxDvQPnFcsHsbRZaqKCFxxdrKz60LsWVkgg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnBThQrr9xRkja2f8Wly8lFM+F/RR8Jj8q1LrBG
 ERtO4kpp1WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwU4UAAKCRAEWL7uWMY5
 RrGeEACv5oKbb6Rjxi2re9EbT4KAydu+j6EQ27vu1GPirfvHGy8SMe2Mo5TZc7+IKanADZx6Geb
 LnXBhzilhfSCqU4B91HdfJqCNZqfADLSRwMrqAYgvMIAyfPWN0MfC/Ny0wIey4n14tOwhMoQans
 C81j9H0To8zH54MV7OeRwv3r2hEdIKdvQe3ALIUyw+M5ucFIP9D3+AIHAr/x8UJeQvgE6EvvKLX
 aBCZROW+3Lp8mxLDKzWBAzxJ9jPevMFlqGa44hg4/pWws3pHhL8t97VhdwOetqeI/USsaqU3tnA
 VFi4R4372HUcNsg1REioOA0a/NRJwHIav5uXPvfUhP7JukNz+qeLDXAnm5cCvLfIIL+vrxdwljr
 VAEuEomDvOIFPtDdg5Z3+JMcvH+oZbQkABYcC/eB4wa9VF7ll/NbV4j3r8T3aQ1CYZFjeir/kyf
 1h5wBZZ9PCOAVKcbEhLIOdXUuMPT9VvuBc9n/pdtpes+XPIEgHi07nUhBYmHgH1ZedZhn50thjx
 iquC1PGFgul+/V26QMufqORBOwhVVtdc8JLtaBG0d5qwmVtd6GgkyX22nc2QGq0iLFV8bfJpA0Y
 M48L+NLCz0pPq8tWUOf7DZghAYbyL+qDvlrcpVtKJshFxOLNCVDTGqZ7ugeIRNKrvtnWitURX9N oZ5Gl4+RmFoIzYw==
X-Mailer: b4 0.13.0
Message-ID: <20241008-rustc-option-bootstrap-v1-1-9eb06261d4f7@google.com>
Subject: [PATCH] Kbuild: add RUSTC_BOOTSTRAP to rustc-option
From: Alice Ryhl <aliceryhl@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When using unstable features with the Rust compiler, you must either use
a nightly compiler release or set the RUSTC_BOOTSTRAP environment
variable. Otherwise, the compiler will emit a compiler error. This
environment variable is missing when rustc-option is executed, so add
the environment variable.

This change is necessary to avoid two kinds of problems:

1. When using rustc-option to test whether a -Z flag is available, the
   check will always fail, even if the flag is available.
2. If KBUILD_RUSTFLAGS happens to contain any -Z flags from the
   environment, even if unrelated to the flag being tested, then all
   invocations of rustc-option everywhere will fail.

I was not actually able to trigger the second kind of problem with the
makefiles that exist today, but it seems like it could easily start
being a problem due to complicated interactions between changes. It is
better to fix this now so it doesn't surprise us later.

I added the flag under try-run as this seemed like the easiest way to
make sure that the fix applies to all variations of rustc-option,
including new ones added in the future.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 scripts/Makefile.compiler | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 057305eae85c..50eada69aed9 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -21,6 +21,7 @@ TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
 # automatically cleaned up.
 try-run = $(shell set -e;		\
 	TMP=$(TMPOUT)/tmp;		\
+	RUSTC_BOOTSTRAP=1;		\
 	trap "rm -rf $(TMPOUT)" EXIT;	\
 	mkdir -p $(TMPOUT);		\
 	if ($(1)) >/dev/null 2>&1;	\

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241008-rustc-option-bootstrap-607e5bf3114c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


