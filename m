Return-Path: <linux-kernel+bounces-275206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F69481D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97351F21906
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042B160873;
	Mon,  5 Aug 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfXiRepb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2315A874
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883236; cv=none; b=TwDBk600paHH9JonE4XJDsG7toAsq2wOvJmsY/Vktg30zN9810E+iF177LOkfc6oYZ9Fu5K8dCMf2c4DvjXP65Uy0SoBjoBLqqtqb61NQTu/zTj9g1ixlNlibm6dwlU6gJtBru3t1LYD+v0ewZZxAI7AOoZweB2FFyRwnJaDMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883236; c=relaxed/simple;
	bh=qELrm6xWR+vSdfeL651B7iDC32fvpN0UnYZ/nenXXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sApvW2g/BI4utww2xYXmEYmtdxbA44Q5nWOk0bDKxVp1918E70x7uJjrzhmTvYLYGcKKYe7rXlveq3jkEToGjLRG/2w/DGWijXu+S6ruSWVhrk1H7CyUJtxD2UwaY0HbErXuFx5o4zAkn3r0UjCzUI5tbyOtKVbNfEYmyHVM9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfXiRepb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a94aa5080so473480566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722883233; x=1723488033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awSiegGC/aiLfudQJZdzAXeSh+lcoFYzPuFVEvS4a0Y=;
        b=FfXiRepbTqKF9l8pP6FvxODIdwgfjx4DTy0LVMtHJT5KSZqO8k+v8DV7QXipIBYx4C
         csDlhi78DFZ6Lz+od6i7m5anohitgUiWiG6w7Sa07iQayxcgPfiewm05zEa7DAn3ugWm
         YNspaZaNSc8whmPHdlLoYRxqsgx4KudC5aBcLYhvpbiW9Ddw+zepM1OFQrAmDrZyy8e9
         IWAuxJuDLpzi/5hV/9jEFQ4/ZymqMAMii2dZYOcejLvyVG5a7+Fjj+YpmBX8OZF/ne++
         D0ni2KNYh562AURx5iVGc5UrVbimRPBMSxOZRiyPu4ywA+0rSqneZIrbrUiHXCiv7ntR
         5MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883233; x=1723488033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awSiegGC/aiLfudQJZdzAXeSh+lcoFYzPuFVEvS4a0Y=;
        b=W3JwsYoMM2q7VziOUSd9GWK3ptd1kwj5Cg4G9kHJiKpgVFHHjZrSDQ5KZirYh5zhH2
         DgglmLynhItwy+X0QbytOPAAvOdqPzd2Lov73sYDo4JmISys46WXAYhtu+hnnjy3VkMG
         s7SeIyMqbtOjX+ATWYyGYajKE4pQO+Dw0n4kdCnA2RVjd5u5qBCYgcB4dImBREbsWWVf
         xWUx7g3bjDiyCh68nuYqE5MAANujvYv5rJsdWppHq8ibEGtqXIB2gRcjJtalV5EZadhp
         2Wg8moM77/9+8K7GssinLI/4tvJQC2F1Q/Qz7os8ybTqeDRSW74D5cWKjMgUNAyp8jEp
         u4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OK4p2fhlO1vmChNffE9m7ckIz5MTjE6qQSbQgKtX6pDG8wKNINT+5SDfjckw/6ivgcqjk/KegLOrZkaHJWjlQ9h5VNN5EG6KdTlV
X-Gm-Message-State: AOJu0Yz9/+ztuxxSnXq5n9IPpmm7u5lCiRGLA7y7JobiULyum27OWZ2d
	bnWyWkwYVN9muSOMfjjhUi7vEN5FHlWEObpTDCF3uE5OQZ7Fufy6
X-Google-Smtp-Source: AGHT+IG3IJucHUtbQegGWUcxHDuD0ZT7B2y4b+n1mdQUt41gzRRMP1VfFAaDF+0h2xfcpfg5bxqTgg==
X-Received: by 2002:a17:907:724b:b0:a7a:c083:8575 with SMTP id a640c23a62f3a-a7dc4ae31afmr1010343066b.0.1722883232611;
        Mon, 05 Aug 2024 11:40:32 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ad3sm478517266b.88.2024.08.05.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:40:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 0/3] Enable strict percpu address space checks 
Date: Mon,  5 Aug 2024 20:38:58 +0200
Message-ID: <20240805184012.358023-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset enables strict percpu address space checks via x86 named 
address space qualifiers. Percpu variables are declared in
__seg_gs/__seg_fs named AS and kept named AS qualified until they
are dereferenced via percpu accessor. This approach enables various
compiler checks for cross-namespace variable assignments.

Please note that sparse doesn't know anything about __typeof_unqual__()
operator, so the usage of __typeof_unqual__() breaks sparse checking.

Also, the last patch hijacks __percpu tag and repurposes it as a named
address space qualifier. While this works surprisingly well in this RFC
patchset, I would really appreciate some help on how to rewrite this
hack into some "production ready" code.

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Uros Bizjak (3):
  percpu: Define __pcpu_typeof()
  percpu: Assorted fixes found by strict percpu address space checks
  percpu/x86: [RFH] Enable strict percpu checks via named AS qualifiers

 arch/x86/include/asm/percpu.h  | 53 ++++++++++++++++++++++++----------
 arch/x86/kernel/head64.c       |  3 +-
 drivers/base/devres.c          |  2 +-
 fs/aio.c                       |  2 +-
 include/linux/cleanup.h        |  4 +--
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    | 39 ++++++++++++++++++++-----
 include/linux/prandom.h        |  1 +
 init/Kconfig                   |  3 ++
 kernel/events/hw_breakpoint.c  |  4 +--
 kernel/locking/percpu-rwsem.c  |  2 +-
 kernel/workqueue.c             |  2 +-
 lib/percpu_counter.c           |  2 +-
 net/core/dev.c                 |  2 +-
 15 files changed, 87 insertions(+), 36 deletions(-)

-- 
2.45.2


