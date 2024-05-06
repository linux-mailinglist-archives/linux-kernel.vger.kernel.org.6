Return-Path: <linux-kernel+bounces-169239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B028BC58D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894AFB21079
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C240855;
	Mon,  6 May 2024 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S11NdwUp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877740847;
	Mon,  6 May 2024 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959993; cv=none; b=XdccPzwUCpBY3bRmSvPeHMRGaLIgrESvo50HGkuvGXlm1YOQqQB6Mz7Si2FKaCPVSF3KhytBR87L42SeyW42y4nc+kfp1rz11zAOB+ZpJSdprpVxPbZVY42P7J8IM6R3uYphhBu7Go+IFFkMcsRlLFGAPtgWo0+/vPLk0jBqE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959993; c=relaxed/simple;
	bh=VM7uBtgDykOSCEFvxGZTHdHh834Ycngh2ZDz0aAHDjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nk3y1MSr3kSeo//tEgIX3w2eYQm+/oKcgNzotsQmtTYgYY21WK9lg5Y3THyqDGi9d51sJwYqCn3jtIZY62FpR8fBLDii4BcVmr/20DBIRDOILiDHbaLXM5HagEDFyXDpUWqyIVXfc+Ft+ZaI97zSueETdaVD0PtxFnkfTzSmXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S11NdwUp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f447260f9dso832966b3a.0;
        Sun, 05 May 2024 18:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714959991; x=1715564791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=S11NdwUp+cZ+wm63qCy5U4UyRRh61yP1zIznYdaPQqvbOylzs9GcxIBstH1BFLnrTp
         bYkySOecncSatzkWqtXqDQwW/APpQbfm16F2KCsZ36uF1toY3b+YotrxrDV5Kn708f79
         nnlobA4XmCUbApFesQzHUXbVcDzhZTdGL7S+1chWd/kFXA7i9ghWwIbWjjkyrDhqKizI
         ElG3dikFlUd9IG2PCWS6RViewlT/UyqtigqzJQEIj6TtlrtbBWbUOY7vCivfEUAEBwih
         PH0IkE9CT51J4lraopgl8rcpatmb8Hwo9li4Aum7m9Z0vQ1rLeeI0BJ1WHitnOB5QeL8
         YjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714959991; x=1715564791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=l9zTIpUtLtWoR/5M2n/w9x7REc/Q9GbufbHxd/9WA0z48EAtARn6xZYWOT2M1lzDSW
         HlZ3rdS/6gVaFhgHWO+iM2woJIQNgaHnA95wXe70XjdiWzBaDtj9wb1k3WYf4pync1Jb
         6ObsySWHnTOA3PlnWvdX9mNHeWd24eeZlLJE6G8YZ3zV7j9Y4hW217eDaaCM1BnQeuJ3
         iFtOb5r3aA9IUvpRpHQvhkPpoHHllDHbCobWfZDrwmOIgHGTCywAqRkrr3KQnQJrd+fQ
         Z2nNlxrKMLWSqFt7Cz1HNJ5lBlt6riy7x3oFCbc62e91Eb6szIwCaoIb2wTj+V2DtzJV
         S6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNrxkckw1MoJ/GwnEXWOH1V2Q+6egZajTtzYgqimQCMW/Wln4sjrgjE1Qt+JaNkdNrDtb5ZpenmikQVcnCP5g0k3b1mmULiUK7a3tQAzKbXsrhkuc92ATCoec8l7swhaM0vSM82LIAtpIioikpl4+kLfcQLRCiiVpCBomHWUz9aL6e
X-Gm-Message-State: AOJu0Ywk2r7iZsAZXivxZSs9a5SdlyBVzSFPR2Rr3kQJ5OYgbh2K7q96
	vrIQgWlNVVQkxGfxHVaGjnoq0u9UQaLSKmFUGnHPZ3ibcUAX9ZlQ
X-Google-Smtp-Source: AGHT+IG5YP5CA7xuNnsfIi6JS+6mqnt69fHIJ7ok44VU9RBoD7S7xiTZylgoiC4Xk22OkcxGNBSlTw==
X-Received: by 2002:a05:6a00:2185:b0:6ed:4f2e:ef22 with SMTP id h5-20020a056a00218500b006ed4f2eef22mr9949394pfi.31.1714959990994;
        Sun, 05 May 2024 18:46:30 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id fj30-20020a056a003a1e00b006eac4297ed3sm6608511pfb.20.2024.05.05.18.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:46:30 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	joe@perches.com,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH RESEND v6 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Mon,  6 May 2024 13:46:05 +1200
Message-Id: <20240506014606.8638-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506014606.8638-1-21cnbao@gmail.com>
References: <20240506014606.8638-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
and loongarch,
   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

The reason is that flush_dcache_page() is implemented as a noop
macro on these platforms as below,

 #define flush_dcache_page(page) do { } while (0)

The driver code, for itself, seems be quite innocent and placing
maybe_unused seems pointless,

 struct page *dst_page = sg_page(req->dst);

 for (i = 0; i < nr_pages; i++)
 	flush_dcache_page(dst_page + i);

And it should be independent of architectural implementation
differences.

Let's provide guidance on coding style for requesting parameter
evaluation or proposing the migration to a static inline
function.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Joe Perches <joe@perches.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Xining Xu <mac.xxn@outlook.com>
---
 Documentation/process/coding-style.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..7e768c65aa92 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,29 @@ Macros with multiple statements should be enclosed in a do - while block:
 				do_this(b, c);		\
 		} while (0)
 
+Function-like macros with unused parameters should be replaced by static
+inline functions to avoid the issue of unused variables:
+
+.. code-block:: c
+
+	static inline void fun(struct foo *foo)
+	{
+	}
+
+Due to historical practices, many files still employ the "cast to (void)"
+approach to evaluate parameters. However, this method is not advisable.
+Inline functions address the issue of "expression with side effects
+evaluated more than once", circumvent unused-variable problems, and
+are generally better documented than macros for some reason.
+
+.. code-block:: c
+
+	/*
+	 * Avoid doing this whenever possible and instead opt for static
+	 * inline functions
+	 */
+	#define macrofun(foo) do { (void) (foo); } while (0)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


