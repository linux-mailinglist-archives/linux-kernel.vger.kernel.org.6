Return-Path: <linux-kernel+bounces-228079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAB915AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611ADB23CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4477D1BBBD5;
	Mon, 24 Jun 2024 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1VZz5A0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367981BBBDE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271804; cv=none; b=HpoPhpvUsFrr8ZqGidvYyaHncwHSKCIt4Gx/VItgWV+OYdVo3Chu/8JHO3w3W9ATNn/pCu4B3oV0WxYA05dB6hg0Y4vqxIOSOzb8LSyxfvOW/BTmeBkQq0h6tIGJ0Z03b3bFz97RJObx+GKKF1L9T4ffbs1A5hsjExLOH4FOLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271804; c=relaxed/simple;
	bh=HKl8DYXudRkj2nEiXmQj8vs+8XvlCafs7fYfuFr5khk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQWnfYerDNa7ZevdnoKGKviTUFlw/V042kwSzI803Me9FeHbngFqlZFPlR8NLqhcJ+5u99SBMxCeRIGyCjv+SjhzRDEmLBxnduhG5kyK+Btz2l2/YnaA4o7iA8bQg6KsPWvX7rMpHaOzRC2fLG29Qrlrfbe/BDI1ADXqGj1eLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1VZz5A0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so3896013a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271802; x=1719876602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=L1VZz5A0VEDktw2LPT6BNr4lgic3OPfHYjLXM5bpsEW7dm25Z1NKkUVGeebsGTBXp7
         BdKHriPY1tcFX4quwQXKtE2blCShX1aDAYwT0a4to/iUKq9deDcNQZz4oS7/3nleTyJE
         Yzyej+qxGtjArH2WhuIp+ESU1JaHd99UGpBoz4K/Qhk5/Bk3yelU9MKadaV9D4u3+e7l
         WtrZk0ZZ6q0gagvlA80Zjrxy0n7xS0TpkZg7OqxIIjxvDsR1HeIL+q0K6pM6QqPPBQkE
         hq4mzk7DyJSScAoTzDnLaxUriGJmfcDABgmTr0TRRHW721YpkRAocm7i2CYr/RiS0Z11
         YOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271802; x=1719876602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=RQtN5Sy+Wl6NcEz/KU0caE2nKTU+WliHnsj47OnbaeRH1KQkdFQE9+DY/B0uhBGReP
         aYpm0iW2ZHpHOIuJFeR7N5pyDZ2SUpvCma1cMaFKz68dpC5IUqR0VoviRuCdEaXrM2P5
         WhusqTbsgEdzxmRz/2mQubxCb1fjJYQSvySN8qXoczIddQryHaeOiK2uyGVezc1EN8Cf
         2GGWAbInwUbwZLCCZ8eTHBZ7CweyJe3/2lINl9xu0O0YHy4AwT4vaE65KC7MwurIwgvs
         nSP+/u+208Lh9IwGi3vJLw30AMvUHAs/QqChdBxppUYNCr4zuFGjo9//saNwaiPJIPmz
         tbxA==
X-Gm-Message-State: AOJu0Yy/lf/YFBNhc8z/kUYY5cGq2I7SGIxYA6z0POu3aaXkAruwfOF7
	Z27buqGqNGrXxPS5ulOuWnTi7w1j7uqAV+TWXTpKsfs4+rmaExK324KwTWTRa5m2YnBfOEUrkE0
	WNg==
X-Google-Smtp-Source: AGHT+IEfb9KUh1OpOD8DwIk/54klv7dSo/nLX1YPQZQ44FjQ7tb2FCGqwu/ay8BBa1IDIHl2DafOvSF/pwc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:654f:0:b0:6e9:6c12:3523 with SMTP id
 41be03b00d2f7-71acda64918mr19622a12.10.1719271802360; Mon, 24 Jun 2024
 16:30:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:21 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-13-edliaw@google.com>
Subject: [PATCH v6 12/13] selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.2.741.gdbec12cfda-goog


