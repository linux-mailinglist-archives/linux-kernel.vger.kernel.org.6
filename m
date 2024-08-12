Return-Path: <linux-kernel+bounces-283899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFC94FA19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470911F264C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E0170A3E;
	Mon, 12 Aug 2024 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjim33fV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDB14D28F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503704; cv=none; b=B4NyEWsA06teOdjLOYmLvBMNo5XIlpWHp6JzMtsACON9pJ+zBa9h9bI6Rl8X4IqX9EMa3UwIVk4zSWYPcxYRHd92SiLYbxto9zzacDnI/C3JK8GK/K988yOkwkRfsOnI1B3iYQFmP9zTnDjm3y1w/Xu5NbSAe+SKowD9fJS24pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503704; c=relaxed/simple;
	bh=lrG8HtQAtkdwY8gFK/Fnunjn38cL5iuo5eo7p882zqY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PW+jNcUoEZtYfAGhDPX+/Ms7YL+ftZftX42YXTjI31ABNFMA2KRSpFbtNDeRW1DQ2OhY7uPKYju/i5vjs5qY5MPUklNhG0039qN00Ar+M/I0nd/HMT/55buNux7iMV2fE3GBZ8RY6uKd6ZMBkPLE2d2fxHsGPMzKcEtHy0bMPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjim33fV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68d1d966c06so113164227b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723503702; x=1724108502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfsoeXp0VYueelYq+juo7I7r/MAdCnC8Avrr0E7K6fE=;
        b=tjim33fVzD2eAKlPx7MkUkZqKqtSAMZeoi6AVcO0kWAwSDKeb7mDEYZc4AzfQf1RdW
         pL8l1WRmr/QCKGoYSm4xylaG2OA9I7GCi9lN/hqIhBYMp7QrEVdgtEZoWY9CGo+pRCk+
         IF4n676C74i+WG2wBdWsFbaJjsA9e4WpqgUJ6H2UwWk6YbC1kKyL/8vkxoonh0aY2169
         CLLrT2a6taNeGwI3GsvSVE7yxLnxBWYsbhsfwBM5Mn58rvPWCFLMXgPDc14/ly56XqOl
         pHRSSTCO12/+mrvrOyW3ck01sPTQCrRrpP9mIajXDbqv8jDto0G6vrYGJKDJZ7ZlU/Wu
         bzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503702; x=1724108502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfsoeXp0VYueelYq+juo7I7r/MAdCnC8Avrr0E7K6fE=;
        b=wB8mIgXaiSO8uhxZ7AYTLMxyeBuwaAUIE/b6gXkdsMAf0fFjxfcLiTexjrwBOc3WEI
         HmAdrYXpKVQhz48YWptsSyCjJlBKkIN02DeIO04pfzxpGTtJl6dIRbNkdcat38I+K1ET
         D27w37EUA9RxqV5xzoz0MfNCa+QFp+OAp2Ule2AzBWm6/f6p4YdK2q+6TP7QrtbCoXTA
         t9DViK4smpGip807EvrLMjjA2YACQNor6TZnZlgWvDIofIGyWZtcOv2aqs5lD4VvtVdb
         4LBYtQ8i1/wRdz+Al76Vy1vECL29lXBwbUE5LBAiYe3tYsj59PPwWoP3AQkiVdu3nESJ
         zuOg==
X-Gm-Message-State: AOJu0YyquVJUdFh6iU1Y+fxqmqiqwgBSfr1FJ4nOjcHf8q6l6e0YleZS
	xxjbDWQzFWkvCHG62cbHo1IvUlaVX7w4kjb1C7fvmHQHFS3FH6HwY0eAMLvHCY8K28PwgZKWCo3
	P4zxreH2ojQ==
X-Google-Smtp-Source: AGHT+IHBSn6dAr56bsiqvNWde7qkAxBoyo9jgqBjLEKUkxXlH40b+Kc9d/j7FuS0AamMVU2c9s2QR+AYmFRuMg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:6:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e113d064afemr126491276.7.1723503701997; Mon, 12 Aug 2024
 16:01:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:01:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812230121.2658059-1-cmllamas@google.com>
Subject: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
From: Carlos Llamas <cmllamas@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Brian Johannesmeyer <bjohannesmeyer@gmail.com>, 
	John Stultz <jstultz@google.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This reverts commit c02904f05ff805d6c0631634d5751ebd338f75ec.

Such commit assumed that only two symbols are relevant for the symbol
size calculation. However, this can lead to an incorrect symbol size
calculation when there are mapping symbols emitted by readelf.

For instance, when feeding 'update_irq_load_avg+0x1c/0x1c4', faddr2line
might need to processes the following readelf lines:

 784284: ffffffc0081cca30   428 FUNC    GLOBAL DEFAULT     2 update_irq_load_avg
  87319: ffffffc0081ccb0c     0 NOTYPE  LOCAL  DEFAULT     2 $x.62522
  87321: ffffffc0081ccbdc     0 NOTYPE  LOCAL  DEFAULT     2 $x.62524
  87323: ffffffc0081ccbe0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62526
  87325: ffffffc0081ccbe4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62528
  87327: ffffffc0081ccbe8     0 NOTYPE  LOCAL  DEFAULT     2 $x.62530
  87329: ffffffc0081ccbec     0 NOTYPE  LOCAL  DEFAULT     2 $x.62532
  87331: ffffffc0081ccbf0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62534
  87332: ffffffc0081ccbf4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62535
 783403: ffffffc0081ccbf4   424 FUNC    GLOBAL DEFAULT     2 sched_pelt_multiplier

The symbol size of 'update_irq_load_avg' should be calculated with the
address of 'sched_pelt_multiplier', after skipping the mapping symbols
seen in between. However, the offending commit cuts the list short and
faddr2line incorrectly assumes 'update_irq_load_avg' is the last symbol
in the section, resulting in:

  $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
  skipping update_irq_load_avg address at 0xffffffc0081cca4c due to size mismatch (0x1c4 != 0x3ff9a59988)
  no match for update_irq_load_avg+0x1c/0x1c4

After reverting the commit the issue is resolved:

  $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
  update_irq_load_avg+0x1c/0x1c4:
  cpu_of at kernel/sched/sched.h:1109
  (inlined by) update_irq_load_avg at kernel/sched/pelt.c:481

Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: John Stultz <jstultz@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index fe0cc45f03be..1fa6beef9f97 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -252,7 +252,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 --no-group-separator " ${sym_name}$")
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
-- 
2.46.0.76.ge559c4bf1a-goog


