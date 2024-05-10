Return-Path: <linux-kernel+bounces-175143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C88C1B38
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E8C1C203DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D713B28F;
	Fri, 10 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3UAtSei"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81F13B298
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299883; cv=none; b=fPQffS+lymhTlDfzT70JF7jdzRD7tQBsVCFpSG0KvfpUGtW7w5NOGdGPQ68GszghlDF4Hs1BJjCSO2VqsY1nDYZYjfQLoIaHi6R00s4TjH+iBsX3V4Pf8vMjLmgKYzmXrG+D9IGcf8+GUnScoAgJ43aRV64mtLUfdqvNd0UcVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299883; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uS1SRgZXHFWtigrCyTYtflMf+aynK3hdd3B/4lEAynqKF/PPv3af8rbTCOzJsdIVJ+NN4q/sv6TtIR9eKQZMgv4J+yWAs+5OWH51JKS1IknxuIlw46PZ5OACXzKotp0eA+Ewo1P+5yPNruWSD82B6c4IGFeSP8uHNXOqQY10G8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3UAtSei; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so3240011276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299881; x=1715904681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=N3UAtSeiPrlt9OW2F0rY6m+iv9lq7dDYhKPowMfiXC0i4M50l9Dq0C9BY4cBKpwwg7
         4g6Mso3wfhFFxAlqDrz2MZQMJX/BVKKsTSO0W12iZ0mWIZagIVaL1MDW33UdTQmbTbE+
         lwyQuyKgkExHf0eOHbu/v+DVpB7mWUq0XdsaAJICDUe9zrvd7cg7OddH7V1tZtlvSHwD
         HKgaAxuHATqOmhoKn76xQshp45Ob9vFkc06thVQ8OpsulnW+BalfUaJQ8pXpEpDV7geb
         suWaXWhKX4tDdAjpjzOtOqlzSVoqjniLl6CS3BH4zRnuPDy/NZmeoCatx+ZfUc/pCvLo
         spTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299881; x=1715904681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=VtuiqJ3fYylvDuqAwqZfEj3B54vTdzT/d1JP484dtzyZxMqSvaBk/hlRHTLVOpN9tj
         XeCvZte8jdj4pF0PyIQqTcTvyLtB3LO0+/uCzFhFukEVNYpfgszD/cWbP10TlntqBzOV
         W47UMvg6sqrUntPm2fzWHqZzazWa3hZm66aImSk2K5+j706LnB4TEFkukjqjGV+YsnVF
         axTtwNsr6KXd5erxTPBerwLyYJ7tyjo4Itd0WFb36uVN23QRXPYcWeXYtJQhjfjni3y6
         +tYShLHL0Oq4Ik6gXqz1tzOdL9Nh0p8OulXWrg5vP7PeRZz0l4B7CZ3w03vdh+Dy3/ja
         8r8A==
X-Gm-Message-State: AOJu0YxaVf8w/fxYfTfrk1+Otv7FvLDMUSRMjuvy+YlnYQhWcgl3jHfW
	vyB188No4Wt7iMzpk+ZK2Yk0njo2MGxwFInU+DK2s2lyqvv2rkHwk4zjbsIBdrkSXE59j5q3DQW
	UIw==
X-Google-Smtp-Source: AGHT+IE/x9wCS8dXfiCveNKLMUww3zuulXyRB+TBegOeq8yRgm7kXDMXOCAjHlMh4xirNEVxhfl/HnwXW8Y=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr363352276.3.1715299881350; Thu, 09 May 2024
 17:11:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:03 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-47-edliaw@google.com>
Subject: [PATCH v4 46/66] selftests/proc: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.0.118.g7fe29c98d7-goog


