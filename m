Return-Path: <linux-kernel+bounces-174867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00088C1649
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF931C23C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64A13791F;
	Thu,  9 May 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiAYhO1t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1862137757
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284911; cv=none; b=d0784yEGRBJFIJSR+9O7l5sNDSxBLkFavT3qyQtg6G6gG/yLPLfg+GgVQEw8Zyrs3e5YUnMz5W52uAFRCXcrlpZuRRjHWmxfDoepWOCkDKKD0UoLKoxcc0zJSEWugBq4Eg+HUQl7O5Vs7plGeg2m2PlySqWfYhLaJovJLwkSzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284911; c=relaxed/simple;
	bh=tiiU4fhVUQEB19QTaOuBcfNutCZqp5wo/ZWaJbkdBXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzXWDwOMNNPP2ClNxxq3FVqZ8moASOIjVN5+6NgzVBRuCGB8IvC7K2CMFk4/hWOrxnSq42AmaQ56PEfnaimq3c2NzQWgrFpgg5dvlCcwp++cGaDlHJTcObiuiBxHza84q8lMb7sr3CxCgRLRGcM1otKbDhOPBDYVaP2s2uz/0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiAYhO1t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so1726318276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284908; x=1715889708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF53ZrlQPVOZxwMOBywpoMFIkR0/AwW24tB6FwevWMI=;
        b=qiAYhO1tl5GQXpJbW8G2fyAV5/lZThRXi0M3Xnmqj16qqPWcevzNWJsEDcC8JeW/rN
         6kkHVngcEm2utU+ZIAtuA1Kk5V4qN49z5n5B5hOns3+ksst+ZCKpOO8lS0dYFF7fvCM/
         yYoDaFVraaSHgSdZ5QfDV1wVu4tr6cbCIO6YAlHOSepnHOIUhtU2fnau0b0MVzVExWVi
         vJOrbPnbotFVA6kT96Oolmw+DLCgvJ/2SFzPMxgSBY/k0h/d9rQRIih5pb4unbxZbcR6
         aiOwg7aVIzL/5C9DeHLZ6U18Ct90xk27+1UXyhFBZje4i6H70wDILL5nHC48VneKO6a1
         bjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284908; x=1715889708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GF53ZrlQPVOZxwMOBywpoMFIkR0/AwW24tB6FwevWMI=;
        b=xM2IHd7Uxqtdm5UmIeP8UfYrO0jaczt623Jk/9A6/7IzgBYUUeMyE9MMDtTwZLDq4u
         h5HgygOZqHrqb3vvTolSsXTaIo/1Y7GMzJBiRiA8ikd6ePDuy62DfRfM7K4UL0BlVNGm
         1nnxwsy2Ngqo9ObtLLgtVYRWIirUkYtN2B03c2OH7cg3JkJ1Jtl1EgTkEsb5zhAr6oL/
         5421XipXR61ArQCveo4NXSBUe2cBR6XSzlz6rUxUbhiIB+dtid283c2uW7QA1aBfb+gP
         2QIPq8/qWW04SKdAtt8m05ZjZaYl1GwYWiT/CCLpmAr4fici9xQqXO9TGXUoIf8SeZcE
         ZxrQ==
X-Gm-Message-State: AOJu0YzuQ6krRYgiH3wQXcqFvkk9qw48xxPGARyNmXid5pZRQvxeJI3U
	5Ng6HeUiGcu2vBaI6FWbYUDHp/rLGfNjaa8uoZMkFMeLeZ5cfLZGb279JmncY0kmeJgr6S7URGG
	F9A==
X-Google-Smtp-Source: AGHT+IFHb/HuEhyDn1MIUx0fSYkl1rLs5xBYd/7U5k8UOq4+y5dsSBiAfEgu9kUMOF/OgV4z5gWzXa3nqdA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b0e:b0:de5:3003:4b64 with SMTP id
 3f1490d57ef6-dee4f1b28f1mr63511276.1.1715284908019; Thu, 09 May 2024 13:01:48
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:13 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-22-edliaw@google.com>
Subject: [PATCH v3 21/68] selftests/futex: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..8e41f9fe784c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -16,9 +16,6 @@
  *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
  *
  *****************************************************************************/
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
-- 
2.45.0.118.g7fe29c98d7-goog


