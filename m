Return-Path: <linux-kernel+bounces-404632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF279C45F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940991F2321F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E031AB537;
	Mon, 11 Nov 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUHbXEQz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2A4594D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353706; cv=none; b=ahQqVSNepIeY69+fIENu019mitCiz8SHiucJTmUDlP4ptOQUboZsNEWAaiRUTOvGyqZ8xHmucmetWeVheKr8y4aQaBWK4zSA9EakbT8KzHl1Kzz/ny9ga7BTEwVeNdKxLjlZC/XopX/Nst5r9thDdI1EsgYm24X+BH0mSK2doF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353706; c=relaxed/simple;
	bh=Fmd0jt4SVTzXXEqmiBXZpbtRp+OYwS2QYiUg6wHbaaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AxiIQIXyBiYSuJPPDEEquzX19TgGZr9U1Xm1Bt52+iWuh84ssGpoe+zV5VQBnga/TpRSlrFoOBvajUf2xX/JeIM6JJeonpi3jfAPFmZ7NNikfAy1ccNCCgY4sYfqPit316MOJ7L+tPtcqkmpdZB/7PTbZ1drxTTPZVSN5QVr0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUHbXEQz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e681ba70so4139e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731353703; x=1731958503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/t3JbccJVG0OeXi5yzmGti0muJW9xHWmBUgKUa5FgE=;
        b=JUHbXEQzuN+B7P/H32PmKxuzFPxfpoT8tAznjqhEcKIcZRyGn8HTJm8TAQi7dnNo60
         19wkuuKHanZu20+LsGJwSLRTNpiiUtZVW9IGfShG0fdvmPysuFZHfI2rlYSsyTZmF+La
         nPhHLPI0cmWLkX7XthWbS4bVOYR3iVtMR9vFhWBPl4MHgfAG52h9986mTPP7b2Pevkf6
         Vp/g4b9jC7Yd0h2RqWpQSnWsXWoHTUhgyXbb2NIrkVO/97YUZyzSXxwZY3MAAFDgtb7K
         jHjh3ZYXH9yXkYrzxKlxSaUkGthv/acE1kb218YkworK/4epbyVgqbCArtdHM+c4ll8c
         GtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353703; x=1731958503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/t3JbccJVG0OeXi5yzmGti0muJW9xHWmBUgKUa5FgE=;
        b=rSsI5axiOgJb5/PMi5KpbKzU+ZcNBsSTwFJAffWIsbcFiEd63FQy9WufhdXGwuLHOW
         ajlSs/pk0Qz8vrKV+3lqCKQZUlRFbAtbJzVuVfI17THhN5RJmYfDZ/OgjyWPjo8rd0e+
         LACiGT9oNDy/5kcU+0DHPFZQNp47mlPL7Z18W1TqKAAPOM10MugCuq4MtCk4m6SqAa33
         li0mmXUrj069/4ck9iG4yW23y5b7V9/XdrPmTwIkq4h661gpvhRm7TTp3UR5SpHGU93b
         oO+DLnlSsGwfAgriCjD8XvYy2WIbCXKJIWEga3p2jMgN80Rr5JK7F9YZ76BJZz3VvAVW
         0DoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzyD72nMjK/pJPWgFAjo0+HmPxjnxGBQxngQMQDG9lzmoKh5o2q/PY++6M8OYzFiLP5vGGCU7OmU01Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw591Zg2ewwVrgpkYL7uUXHiqZqfHH0x/cHqcizfuDq+ooTYIxA
	CZosJTe0G/iNNyJqC7oV0ffzwh+zaV4mLTxrWIsMgKmT3xFoId3I9fSOzDh2iw==
X-Gm-Gg: ASbGncvASVTOKhBa/Xy0CPUCc2LGvq23t9w3CRHwec+wxELfP0VaioIBWGONdRlmv9p
	T+E1/+H9uUHf12zpzK1J1VUQI+oKyjvorQLLuuqAVe+mCd5o4eXi6WdGGxeuDCcn8Ro+VTG6SUf
	sIbLBiuf6TfL9MnPafe8B/B8M1btjwzi5SXw98v+N2lbkdfRTjOVLFgmHRXL0o1opyHVQdGwrSA
	7Q6rUNZDJGQeS1+BewSK2CVe2a9r9dc5KP5Lw==
X-Google-Smtp-Source: AGHT+IEYtnWUZtOotkCC9UDjB614pbuOxRlJ4R9dN6eWksTxKY9YMzMVqGKgp7r2IgwlypAlwfFzBg==
X-Received: by 2002:a05:6512:516:b0:539:e436:f1d1 with SMTP id 2adb3069b0e04-53d99faf48cmr35251e87.1.1731353702234;
        Mon, 11 Nov 2024 11:35:02 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:b587:e083:b8a:f21f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda137dbsm13395338f8f.110.2024.11.11.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:35:01 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Mon, 11 Nov 2024 20:34:30 +0100
Subject: [PATCH] mm/mremap: Fix address wraparound in move_page_tables()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
X-B4-Tracking: v=1; b=H4sIAEVcMmcC/x2MSQqAQAwEvyI5G5hFGfAr4sElozm4kBEVZP5us
 E9dUN0vJBKmBE3xgtDFifdNwZYFjEu/zYQ8KYMzrrIajPzgKrT2B3o38Im3aA1VsKYO3kRnQLe
 HkIr/b9vl/AFUPVKaZwAAAA==
X-Change-ID: 20241111-fix-mremap-32bit-wrap-747105730f20
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731353678; l=3300;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Fmd0jt4SVTzXXEqmiBXZpbtRp+OYwS2QYiUg6wHbaaE=;
 b=HKCWM0hlpVeSuOWbSBaUNdSpn15E0S6vPZEnDHTJTEQlWcs/a32DNfXc1e/gIeCZn3MqatVsA
 qEDUbOvWDhjBQIFa4NOxnjBZymQeDehMmV+6XlaEn0n2ai+pHfK2yW0
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On 32-bit platforms, it is possible for the expression
`len + old_addr < old_end` to be false-positive if `len + old_addr` wraps
around. `old_addr` is the cursor in the old range up to which page table
entries have been moved; so if the operation succeeded, `old_addr` is the
*end* of the old region, and adding `len` to it can wrap.

The overflow causes mremap() to mistakenly believe that PTEs have been
copied; the consequence is that mremap() bails out, but doesn't move the
PTEs back before the new VMA is unmapped, causing anonymous pages in the
region to be lost. So basically if userspace tries to mremap() a
private-anon region and hits this bug, mremap() will return an error and
the private-anon region's contents appear to have been zeroed.

The idea of this check is that `old_end - len` is the original start
address, and writing the check that way also makes it easier to read; so
fix the check by rearranging the comparison accordingly.

(An alternate fix would be to refactor this function by introducing an
"orig_old_start" variable or such.)

Cc: stable@vger.kernel.org
Fixes: af8ca1c14906 ("mm/mremap: optimize the start addresses in move_page_tables()")
Signed-off-by: Jann Horn <jannh@google.com>
---
Tested in a VM with a 32-bit X86 kernel; without the patch:

```
user@horn:~/big_mremap$ cat test.c
#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <sys/mman.h>

#define ADDR1 ((void*)0x60000000)
#define ADDR2 ((void*)0x10000000)
#define SIZE          0x50000000uL

int main(void) {
  unsigned char *p1 = mmap(ADDR1, SIZE, PROT_READ|PROT_WRITE,
      MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
  if (p1 == MAP_FAILED)
    err(1, "mmap 1");
  unsigned char *p2 = mmap(ADDR2, SIZE, PROT_NONE,
      MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
  if (p2 == MAP_FAILED)
    err(1, "mmap 2");
  *p1 = 0x41;
  printf("first char is 0x%02hhx\n", *p1);
  unsigned char *p3 = mremap(p1, SIZE, SIZE,
      MREMAP_MAYMOVE|MREMAP_FIXED, p2);
  if (p3 == MAP_FAILED) {
    printf("mremap() failed; first char is 0x%02hhx\n", *p1);
  } else {
    printf("mremap() succeeded; first char is 0x%02hhx\n", *p3);
  }
}
user@horn:~/big_mremap$ gcc -static -o test test.c
user@horn:~/big_mremap$ setarch -R ./test
first char is 0x41
mremap() failed; first char is 0x00
```

With the patch:

```
user@horn:~/big_mremap$ setarch -R ./test
first char is 0x41
mremap() succeeded; first char is 0x41
```
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index dda09e957a5d4c2546934b796e862e5e0213b311..dee98ff2bbd64439200dddac16c4bd054537c2ed 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -648,7 +648,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * Prevent negative return values when {old,new}_addr was realigned
 	 * but we broke out of the above loop for the first PMD itself.
 	 */
-	if (len + old_addr < old_end)
+	if (old_addr < old_end - len)
 		return 0;
 
 	return len + old_addr - old_end;	/* how much done */

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241111-fix-mremap-32bit-wrap-747105730f20

-- 
Jann Horn <jannh@google.com>


