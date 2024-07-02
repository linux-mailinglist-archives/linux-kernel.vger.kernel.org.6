Return-Path: <linux-kernel+bounces-237837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BB923ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC288EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210AE1B4C32;
	Tue,  2 Jul 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxzqycnu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEE1B47AC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926505; cv=none; b=SgwhSCNQRIdIGYrdf+MUsdRcR6bRh2WHW7VfOYclp6sepfjh0itGjg8DiqfS26xYvF4RNa12LKbx43Z8JXMhhKqXzlZWLJd2qWK/fXpYLR7iZf49th8AfGuDviKTndZsZ6XrLpuFY8Kk7kWvfo90USH0EvmO9rTmu2kuCEsourg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926505; c=relaxed/simple;
	bh=CpK8Vs8g1q+34mFns0P+SSpywqgEqmBYY4pWEhGNMwU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ibp0N1jvkPO8149urPtNWpsREhJV5WJVPvo7bqllIaZYBTchwNbeWr3pBvk0p5Egs0hW0QMAuOzcPjZ9ibjNnMH8VyGbeUjpTC9Pt9FmirrDX6LX7bi6hQj7tjw0rmH5AqDAgbnSYoKEDQoSIz3in3ImdWRgZBfCqrVG05WW8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxzqycnu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d054b1ceeso70802197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719926503; x=1720531303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hhKXhYrzfxh/rcH5rhg00qdwvGaDRGv233TWfBtt8ow=;
        b=jxzqycnuQMhGIxi/gjvCCIzo+Toui6S3sCUZxCm1y+21UgRo+wfHp5196uIZPushgP
         Ht4sksGxwOurVfzYqp+L0NQmk5kK20T73er5P+t+fhLcSVuhg7vypAwjolGPTgeSDkbi
         eeg5QtbXQvUpV5EvrTfV+eQpUulRB7JzJsDcizyEpmELmXhS0gUX6qmXdTBszo3ohBgl
         aaMp2pWWckd7r7yF/tS+l+IXiF75fbG4Vh48X2hlnuc1fMUyrkqZsdZh6hwLhprvn2kk
         gniZcovw/f7TJqjMQU4uRw1pt5+vMMCZQb768PgY5fJPzb5QhvjAQJFMVJHoI+HYKX24
         EaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926503; x=1720531303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhKXhYrzfxh/rcH5rhg00qdwvGaDRGv233TWfBtt8ow=;
        b=dqupcDksT7Xp0ArTZ/umF701vsDOpYmuZLfdCqP1XZXXd4lk3NKX9eftfSPNd58MYD
         qwiDhY7PDVr4viKbjvzT/cfWFpLxYQg65YAZdWiLUZBdtBbTXLxrq0e3rJZbzHJYBSvx
         OiXMc0aq2kVK3LX6+YSQUg5SMNyVsDNJ6H52vVin98ZC9gibTOqGv5tNO0VikPmD+24U
         rt4f8Oq3760t2DK57AlazuIpvLLK9e+tukXuIOT2zPprlt/AHJGI/fejpihskvkKE/os
         e3JIGrQz9AwkWJMqLnA7UyilV+B5/+gypAAC17vQEV2MSPXuwTVwSarTdMWTfGS+coJr
         pMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWLz8lVlJrMq2qqwYIAnmM3yc2qvNQMkA/sZ0vN9cn5F1ZQ3omyHeB2loYnz/uTYcvwkUbRfskRopTiKKpmLgFdbL811Up70eau5KN1
X-Gm-Message-State: AOJu0Ywb1yNdWRucWyUSEmT+0ZLvjKW1Udxwvg94X/UBEkGx9ifGAdf/
	kzZ5PcnlZPsk3VFFSj0FuqN21tn7ka6xDFZrzIC0cSWmVVeszrKPLsDNnTbc5ysVaw196wUXboZ
	8MrGi5do+yV8vRwH4wA==
X-Google-Smtp-Source: AGHT+IFhrR8/1AVaUeKAjimUNiNcEXyIPVmNICv9iqQp5yyXMQvYoOHL1JnwP0JxNLqOXlGHT/mwLjhpuU/mOvDg
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e646:0:b0:62f:22cd:7082 with SMTP
 id 00721157ae682-64c7685e929mr365947b3.5.1719926502763; Tue, 02 Jul 2024
 06:21:42 -0700 (PDT)
Date: Tue,  2 Jul 2024 13:21:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702132139.3332013-1-yosryahmed@google.com>
Subject: [RESEND PATCH v3 0/3] x86/mm: LAM fixups and cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

This series has fixups and cleanups for LAM. Most importantly, patch 1
fixes a sycnhronization issue that may cause crashes of userspace
applications. This is a resend of v3, rebased on top of v6.10-rc6.

v3: https://lore.kernel.org/lkml/20240418012835.3360429-1-yosryahmed@google.com/
v2: https://lore.kernel.org/lkml/20240312155641.4003683-1-yosryahmed@google.com/
v1: https://lore.kernel.org/lkml/20240312035951.3535980-1-yosryahmed@google.com/
RFC: https://lore.kernel.org/lkml/20240307133916.3782068-1-yosryahmed@google.com/

Yosry Ahmed (3):
  x86/mm: Use IPIs to synchronize LAM enablement
  x86/mm: Fix LAM inconsistency during context switch
  x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits error checking

 arch/x86/include/asm/mmu_context.h |  8 +++++++-
 arch/x86/include/asm/tlbflush.h    |  9 ++++-----
 arch/x86/kernel/process_64.c       | 25 ++++++++++++++++---------
 arch/x86/mm/tlb.c                  | 15 ++++++++-------
 4 files changed, 35 insertions(+), 22 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


