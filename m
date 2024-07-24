Return-Path: <linux-kernel+bounces-261505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3993B80E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E2D1C21697
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218F73446;
	Wed, 24 Jul 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="iJQmG+V+"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4E13A242
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853208; cv=none; b=pRRqYV6nruMuXBz9+1/y1BHN1/afl8IF/xAUqpprc2NMLmLPHrsambYxc/1oeuP073lC2XdkMZYnGcog068b2BeyJDZX1ukBafaqTcT0pkP+M4Ia+asRatQBnQ70GuN1OQwhLG2qwZsQQNtKqDU7l58j9SqELG5xg0FHAncG0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853208; c=relaxed/simple;
	bh=FxkZLjS/Cs8nVTPJrVESBf4SjNawFX6e1SO/8tWHL8g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Oz9o+xKzf2RyGbBMmNCKwRmJKwyuZs24xR1yI3DnAoE3gHIfjPywlF2bPWmVWfmxtBfgc7XubSzZtdsVBv3h99XdrTMsrG4TumhBsL+Gf4rw8xt390B7vM/eWNXMBK96EjMqGFNHF+89nmDLa4zhJrkd5swmq4vPUMAoN/atSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=iJQmG+V+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a05c755477so8824785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721853205; x=1722458005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWxIEgcB4vNva4JPDGqrKuZlK47/5uUP1kyWXInS1OI=;
        b=iJQmG+V+vew5l8wEX8Ji4VvKHk3kujss6hSri+3DwiauAmLdoDT760ArmNJ7tqI2sJ
         MKoKYxNI0JWLvk1wS2v8D7zweN4/agmXG/5td5NDU+qGASfg4vPkf1lWh70IVUgrqZWR
         OEWyGLJ9wnGBuqtAQ+41J5VB94o6M3xoMc/kzPoPx0RMBbQoFH3pkasSIARgBN+SyhmB
         /rVt6eHsNQ2Y82FrO8gEkZMY8z0VnAIDXpiqPM8TkJbNuSm0rAfWOqCQHd+RMwV23E2k
         FZwX5sub1iWG7II9MqJ1/+3YmWxoSFXI0X0Bajf6Fslcu0yEWl+FPtyYi6+qHdoSdnhc
         ImPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853205; x=1722458005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWxIEgcB4vNva4JPDGqrKuZlK47/5uUP1kyWXInS1OI=;
        b=HxCOCdJAwzcb/u6kA5lJZY7/JiTOwbqbNS7bjDRdlPfDZw+WHERHUVrWqui+hU/OzY
         YwgmsLFnslJZhuJ3/ol4xYItcSSGMsoZwwt+b9d3lAEdnz/+2diKYUSCxiCASqQyCCNa
         kVQZOQte2IVMjKtlpyRc3Lc8eVm5wC9t1JKth3+3PJ7jyoUd1mMNbLaAyHch6w+2mP0E
         ErlycCyltCmL1ZihSCUmmEqJ7CNFtUeHXd3EIS0zvZ8fqk0a2/iCmy175VX/aRg4ig35
         MLaQcqsP57JIv8iEiZtgsaBl3FWYcA/3eMqtNLqB1OJbaw0UDF7IB8SUmhOn+vDYoi5n
         OPug==
X-Forwarded-Encrypted: i=1; AJvYcCXN0x5dy8nTxPcskHHIgfZmD4MW+fRyamVgGtOOHS1aBVyfZJuRGKUP6SwTvZkUNTUOP0NP2jkqDqY7DhWKuZt0Ca08TGGE72zsP/w8
X-Gm-Message-State: AOJu0YxYZlBMnsBSjrKM4JYGTiYizyiZ7iKwkdrBqXwwkugWQ2ccwwcG
	i3ZDR1yp/zxL5Wd+9LrxTavTY5M1QLcIEbAFjTqKlpf85UohvHQAMmUfq/Vr6wA=
X-Google-Smtp-Source: AGHT+IHSALr6v6vzwBUEUWPezOtwnLgnF7lZxxXB5NdyNsgIcfEwO2tcQEiVgbcmYZENcYVkncoi5g==
X-Received: by 2002:a05:620a:f11:b0:79c:f0e:f792 with SMTP id af79cd13be357-7a1d59d0c6fmr96424385a.51.1721853205399;
        Wed, 24 Jul 2024 13:33:25 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1786sm466485a.33.2024.07.24.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 13:33:24 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 0/3] Kernel stack usage histogram
Date: Wed, 24 Jul 2024 20:33:19 +0000
Message-ID: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide histogram of stack sizes for the exited threads:
Example outputs:
Intel:
$ grep kstack /proc/vmstat
kstack_1k 3
kstack_2k 188
kstack_4k 11391
kstack_8k 243
kstack_16k 0

ARM with 64K page_size:
$ grep kstack /proc/vmstat
kstack_1k 1
kstack_2k 340
kstack_4k 25212
kstack_8k 1659
kstack_16k 0
kstack_32k 0
kstack_64k 0

Changelog:
v5:
Uninlined stack_not_used() and kstack_histogram()  per mailing list
discussion
Use count_vm_event() instead of this_cpu_inc()
Increase memcg_event limit from s8_max to u8_max.

Pasha Tatashin (2):
  vmstat: Kernel stack usage histogram
  task_stack: uninline stack_not_used

Shakeel Butt (1):
  memcg: increase the valid index range for memcg stats

 include/linux/sched/task_stack.h | 18 ++--------
 include/linux/vm_event_item.h    | 24 ++++++++++++++
 kernel/exit.c                    | 57 ++++++++++++++++++++++++++++++++
 kernel/sched/core.c              |  4 +--
 mm/memcontrol.c                  | 50 ++++++++++++++++------------
 mm/vmstat.c                      | 24 ++++++++++++++
 6 files changed, 137 insertions(+), 40 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog


