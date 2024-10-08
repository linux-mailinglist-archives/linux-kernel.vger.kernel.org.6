Return-Path: <linux-kernel+bounces-355709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A9E9955E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ECF28A33D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B020B202;
	Tue,  8 Oct 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+S5iwRb"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FE20B1E5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409359; cv=none; b=F25zrPl0gDyirqDCj99dIQoHVhbIO3eoJSSPBCdsy256Yb2rGorutCDQBG1y3K63T9UIom5DJnI+eAAvbQ4tN1IJrDE6Tqxty5bLksjjMnt9Pxn7EuHnU8QQ0Ft0JVdfFaiX4K8B50TDsgWb9mzf+RJQdapCbmXYdd8cnbcj/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409359; c=relaxed/simple;
	bh=7VrquXITTAVgBVfUM3yz5jotzJFGKuHWlIogBY6j53I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Alx8RZC9/bfJGeDZ2VX4bjZIpMMfNUKmFp6axWAdevNsWc4/ZZ1M66Y8vj77Ws2JBrUFZodjweiDr/wgw/sdGwBfPNb7x9B5sl6o/jDA3CgUeyySGhJDojbcuBM+3xBSjZM/sxBm5Bcn4u6fbBX2auOCWaFBAURJP2iqm1Plsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+S5iwRb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so9120296276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409357; x=1729014157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgK3lBqj7HCmk+9LUSPqdDkHBRN063pnpAU4FPd3St0=;
        b=W+S5iwRb+lcwOaTXDjzT/knn2U/368WxpbvVt4KqrUMpkGiHwe7n+FiJHy8TU85TdG
         KrN6cJ3imuqTbc/A4kZ15s+FH4vFBcib+AHHfrKNWHQOUHAD06WWAouEtODMLEYO4uzN
         mPXU9w/+VqXPYyRIiEDIGEf0sCBhEOjqkSv6cLC+UVG2Ec5vYCAhZo+2xrEPJEpWmi0r
         3n6Hi9mAz+Ptny1qYgo6xFSQFqkRD2B1bUmrHzqdM+MrbaKpcwgGqJ5c9W+pgBGoC/q4
         V5/K1vz/xI/Vvs4EijE+luMKb5JCl3A0hLZuk1bl3NlhtnsQstG70+ASYNOosYH7uOT3
         zYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409357; x=1729014157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgK3lBqj7HCmk+9LUSPqdDkHBRN063pnpAU4FPd3St0=;
        b=Vcvfp1wUyifPkqLuT6tnLmXUJR439pEGk5EilyME2aa2RIgAlvzE703cF92JaNCAXo
         pRsweosdVgpw8+nhdKiunyqdG/f6wXJ+H2ebbcl85iQgZocvRzK07SpofQQ51rYe1MsU
         evcax7TqVDuhtV8flkmSSZo0GCDi5kGITk9qKtYJWddkSGWAkdFwIEkHpr+Q8r7howvF
         F6n+2zaot2dN/j1AXIWk2YAIKQHEJ+zPq2kJqP87yBogYhWLop0WfJYTap6YIYxiHf+E
         6B0GQj0AxSf+zUuZwAKDJ6eILj2zxdHVsKk8SOkvJpEgdwuyarqxeqRVzdfLVNEvBKJA
         QwbQ==
X-Gm-Message-State: AOJu0YwSliIbWutYygmH/wFE9y9PH58/mCrb0HqEvrmtx07FR8pcv3l1
	FlrNXQYE07qCEpAT1HjrYc+/MG7Ipd5mBb7HxwiwANBiExemYBiNizDLvTFASy3Z8ZTyJbUBwDP
	gj0WhIMhSLOf6Cg==
X-Google-Smtp-Source: AGHT+IG3T5XqJh9/9rmjuml4Px/hI8sjWelEP75WqcsLd/zn4j2IvF+sm/vRk1CTkLNfNW7DZbcKuJh8liNb/98=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:d49:b0:e05:6532:166 with SMTP
 id 3f1490d57ef6-e28936c0dabmr37382276.1.1728409356875; Tue, 08 Oct 2024
 10:42:36 -0700 (PDT)
Date: Tue, 08 Oct 2024 17:42:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAhvBWcC/x2MQQqAIBAAvxJ7bkHFovpKdBBdbcEsNCKI/p50H
 JiZBwplpgJT80CmiwvvqYJsG7CrSYGQXWVQQmkpxIDWM3q+McZrw2BOQik70oPrjbUj1O7IVIX /OS/v+wEFN9SSYwAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7VrquXITTAVgBVfUM3yz5jotzJFGKuHWlIogBY6j53I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnBW8KtP3DykEWFYHgJ7kJ6trT/2NJCiNwASv45
 v9q2bZXtdGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwVvCgAKCRAEWL7uWMY5
 Rq++D/9mzGqrQv+GdnnV6NuVZISD+eGJVuf3N0SHiYzI/43XJDNNg1jNMWsiDOI2GXk6n5tef4l
 WpyyrvPlfwd3h6CXxjDNXSYRPkBFN7hT0R+IrVnHDC4wDJVZnJRp0hyzccIIsWr/8r81V+vMshF
 rymAzkr66c+cXqIVOpKy9E9PkujQ4jlAc27dMONIuvZCvPDsiFiZ9xwYwQ9Mrksg6YkjmH/+e/s
 Au6CgtVdn3RFECeBxJ3eB21U5I3LIf1tL8+qjh43bEY9KglwhH8YQ/NViU9jiNN8KUc9FGTcqMu
 9P3ZoWcxqkwhVjLGM/tXIo78XKc0IUgOf3MxJprwmnKR8M9PH8hUt/SvV4zkFmjJWBneqkQHluw
 41/Ft5dO6GsqhxWbgatSjCMHSBniJHWskbrgzSlBQuHc9oz6lQd25MGPZ/qc7NYi775p+TUOBHu
 SCw5SSp9TDhbiJy9tIvGXz68004wkVkLD9cv/OYtuvEry8wOYGNM2HtJsDVeyXnJ3BWdYLH3GEp
 jDTT4E4wRRNupTQ3TX0T2mLlHSJ6+Mjz6sNkBxpPd7h4yjYW5I6mOvW3rlANcQAtMTNV3QNrBl0
 6DZaVhFJuZPhOyA2G4i8K+lCC+7r/1Yc4Te1gaYGKUBTCzYC+rh/hw1ImF0T2RnbSu1w0X1kgx7 AqAqJ6a0KlERJTw==
X-Mailer: b4 0.13.0
Message-ID: <20241008-cfi-fix-llvm-gate-v1-1-32d47459eee4@google.com>
Subject: [PATCH] cfi: fix conditions in HAVE_CFI_ICALL_NORMALIZE_INTEGERS
From: Alice Ryhl <aliceryhl@google.com>
To: Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The CFI_ICALL_NORMALIZE_INTEGERS option is incompatible with KASAN
because LLVM will emit some constructors when using KASAN that are
assigned incorrect CFI tags. These constructors are emitted due to use
of -fsanitize=kernel-address or -fsanitize=kernel-hwaddress that are
respectively passed when KASAN_GENERIC or KASAN_SW_TAGS are enabled.
However, the KASAN_HW_TAGS option relies on hardware support for MTE
instead and does not pass either flag. (Note also that KASAN_HW_TAGS
does not `select CONSTRUCTORS`.)

Additionally, the option is configured to have a prompt and gated behind
EXPERT. The previous method for a user override of the option did not
actually work. This is expected to be temporary, as I intend to add a
precise detection check for 6.13 - I did not included that here to avoid
adding a RUSTC_LLVM_VERSION config in a fix.

Fixes: 4c66f8307ac0 ("cfi: encode cfi normalized integers + kasan/gcov bug in Kconfig")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 arch/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374ea1adc..2632de28c05a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -852,8 +852,9 @@ config CFI_ICALL_NORMALIZE_INTEGERS
 	  This option is necessary for using CFI with Rust. If unsure, say N.
 
 config HAVE_CFI_ICALL_NORMALIZE_INTEGERS
-	def_bool !GCOV_KERNEL && !KASAN
-	depends on CFI_CLANG
+	bool "Are normalized CFI tags for integers available?"
+	default !GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS
+	depends on EXPERT || (!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)
 	depends on $(cc-option,-fsanitize=kcfi -fsanitize-cfi-icall-experimental-normalize-integers)
 	help
 	  Is CFI_ICALL_NORMALIZE_INTEGERS supported with the set of compilers

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241008-cfi-fix-llvm-gate-115e48d6acc9

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


