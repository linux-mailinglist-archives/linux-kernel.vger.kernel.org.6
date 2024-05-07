Return-Path: <linux-kernel+bounces-170613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB08BD9B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891A51F22FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B14F61D;
	Tue,  7 May 2024 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNOz6v75"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1D4C94;
	Tue,  7 May 2024 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052504; cv=none; b=hJxrRAikffZxWmOTnAMvrXwiGxN324PsN0JylBNr9c2QJ4halmjJ2ngHPr4jGY8QgcdA+ORD+brvHOjHKX8wFcVEK9od4v/mSJym6vwMPzmW2buM142+st2aYx8ipwyI0CTI5U7sQi+TzTYQm9MBwm/bX9oBDYVpE70YsYlczwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052504; c=relaxed/simple;
	bh=VM7uBtgDykOSCEFvxGZTHdHh834Ycngh2ZDz0aAHDjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xs8I2tefgqqjYbt7OySHOhMdFzfv5dZ01AjO/fceOGjSeH3GTGcl2C6p5uM6WBf1MdGXGUbCUylMA+Gmy6itPC2fUIATGjaQqrfOU7UGsiMiJ4G3N7Vyg4TyUrFRdv4YxrQ1slXWL9qTm6SdOeR1qTDP00I2u2itQhScrD+jJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNOz6v75; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so2543874b3a.2;
        Mon, 06 May 2024 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715052502; x=1715657302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=jNOz6v75AKuM7kuVcRxNWPWErhAZJHv1v5kXS/yynL5+HbEVQkVyHQZC1Qoa2TIdTb
         6nyOjCNv3hUB49ev4RgqF+6qRqHMz/8/ofnhhIiYynitVwfQdUq+U3GbLpZMprkXf1Li
         F/euTWUlcG5eM1W3o0umYO0Igc/orm/EayHWdRh3EpDG45wBvj2jsSpuXit1KmjC6Y5l
         FNCfenRHSknwKkusT25H7Yabz4VJVkwuP2LTzzecX3IHKHOwBA8NRyMGv++3gN8k6+EX
         MOoxPpE+ceC60RXyQm5TM0mTFFGCa4BI31veqBevmDZsOuRkKYNwd1s5vmOvPcKfoLM+
         4+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715052502; x=1715657302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=F431ORCoslLT7+2nLpkSK7cblpZUR45TVbXrzcpdvjt6YAXSkLFLp6ov+WGKbw9xpI
         7KeIBKRqFOlJ3v1KLGwZE0j/BTVgN2iAWkkVdGWXAhVqCNJ6sGqy+IDxTY1B/GJm8/mx
         2O4S0oqqb+RHK9Y5y9Zns60QrCoSL2QbYwfhj3al1ppiuJsMdUrEVw2sx8fxm8jFMicS
         qjG3dQ4bTHFPHIUdcAy5cIAWrjVu88cd2Q7DwollFa4DomAFINy35hQsFuSfE1dNzR+n
         MxMu57/VjFO2cNYNS4uJaqDcAvklT4vT28mkQCoO2IzXjm4+B71hNoySN96Wt9845lEy
         ADeA==
X-Forwarded-Encrypted: i=1; AJvYcCVFdHfeos1gHK6+ebGUYiyRZWSaOi47PGXmOCdwDE55tmOLcqomP8T/X0IlWfWx9+LPLBYt90q/0kH8nhPKj/VUwZ94QxGe9RKsRtUXD5lkMuuPV3PuWrXbxYaNYRjzG7XZXxZpzsEH5o7yVcg1AM+Bevovsd83fEBvC+QKCsC9nTtL
X-Gm-Message-State: AOJu0Yz2S4OqjPhY7oGEKhB3Fnq9zkP4vAnhjQZ134m0DBC1HynYmd5n
	cT8Tb3qXGe9CNjjQFwqNufVAXAFvV/qjxoKoWIft7YN6yN64OKB2eiNjGA==
X-Google-Smtp-Source: AGHT+IHKL3g+3kTUa1oQMquQVXpn+yfHlbbziGb6kfxG2mhrQGITfNK2pPt0dtfvj3MsH1zU89N41g==
X-Received: by 2002:a05:6a21:8cc6:b0:1a9:a820:c604 with SMTP id ta6-20020a056a218cc600b001a9a820c604mr16337860pzb.48.1715052502344;
        Mon, 06 May 2024 20:28:22 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001ebd7bdaaffsm8988409plg.288.2024.05.06.20.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 20:28:22 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v7 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Tue,  7 May 2024 15:27:56 +1200
Message-Id: <20240507032757.146386-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507032757.146386-1-21cnbao@gmail.com>
References: <20240507032757.146386-1-21cnbao@gmail.com>
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


