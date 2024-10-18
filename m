Return-Path: <linux-kernel+bounces-372101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606E9A4475
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DB8B2268F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82622036F0;
	Fri, 18 Oct 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccCiWrKX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2162022EC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271883; cv=none; b=P//ZqtNI/i60Fv0QFeJfu3Ko6oS+WQFMN1JnV+sg/8npVNtki2NP4hWk7LqQe4QQA+QmMj/XW/QxOMJqL9sN2yBK68qZVvJg0bWr57cxvog+MCiSnGYYQ0zmIU4hHTwezf/+12I9diZn9A4KgpC/cbmmXW0FbyfZbFD0AHy70w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271883; c=relaxed/simple;
	bh=6zIv8qaC2MF0PAeithobf6McIrhz33xdEzcVAo2qmaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=adCh+4gsBjjgnECQciU4zIYkgou0NKUQVqhQAM7TGQl3HAXisROFXdmdhaVxwBmO8hFKHojobpZtppHBC1X6v0Vz40j0i4j6M6GiffJ0MY8tpjb2k4kW6sEtv6Oq7miiNqAeJkRI6Qgid/IVP8EcaI7HRnL772d6fH9sagqgN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccCiWrKX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd9ac1fa89so2262454a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271881; x=1729876681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTNVYPiWjX5aJw3gbHhx/dfN4r2wbZRz9L5hpyoPWtU=;
        b=ccCiWrKXk6N+et7ClJcpJJ/ici88/VgRIgSfRPBo4hQFHxIMQmkhuaCEvh80O0LbuT
         tUAog1kbtC/B3S37y7bZN2kQCDwwkXUMSnW/eMByIKShx0bICIH63gGNKW91jQPgvA+c
         SRAOBTomlFOSXXdRK3K6sGl1bUhtrTYC+D5hT7Jn4Dv/tN0CZDLtsCE1e1fzZQ2dv9a/
         IqwgQOPhXsos505LIyCgYnoXKRio/6ULfPcd66rHu3b5TpscgzokNrY7Nf3zCiEyWPD9
         UsizTj0ZUvJ4xWb/1tLzknRiMrKS1Tz4VyzqGm9/omHbH3hKNa1GX3nqG3mEKrTD+mg+
         V1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271881; x=1729876681;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTNVYPiWjX5aJw3gbHhx/dfN4r2wbZRz9L5hpyoPWtU=;
        b=TW8Lq18s2yuGYJUDWBMkDx8etr7Y5fIXw0z6UrQSTK+dy+TBoEj+WbsvJUPpgBeqOM
         fZzc9D+3vNalebK70zhc5YusJg5Zg5l+7sCk8iwfoW8Q+/RxjpzqtsBbEonPLxYvVr4O
         U3spASIlGH/soXIn00xIE0uSwHI1sepmjvx4QCeiANech45jb+eEMlQeqGK1C/LChLxy
         ctk6tt+aaF6h7uttTsYhJkaEBP7yAlZuy4nQTlXm2ArJYqYLRb3VG0oFTiDfVDjp/4qW
         AyJUCoDC747gsIItsmU1zx5VeUM089waIG7Q15jd4JcNxijR1+aDonrLbzC/ow8BugD/
         FMDA==
X-Gm-Message-State: AOJu0Ywpj3y4yIQ5RgQ5DREJ0fkIhcJAXkwkLApCO2QQQktPh0ObGMTr
	vFgntuI5opxDnnuoEmi7a9zEN8hoEjwGAz8yabLQ/+QNMOr4PMsyBqq1+2XPP+rPlar+VAqDOvK
	LdA==
X-Google-Smtp-Source: AGHT+IGUfl9GQSQppEfYTWqLUY/W6PAOeXf37xtPPG6ChQb9EBzsCyY3TVPop9oY9SIr1FcimBbACvDURRc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9552:0:b0:7db:1b12:5e08 with SMTP id
 41be03b00d2f7-7eacc6fcf3emr3491a12.4.1729271880505; Fri, 18 Oct 2024 10:18:00
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-1-edliaw@google.com>
Subject: [PATCH 0/3] selftests/mm: revert pthread_barrier change and
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android arm, pthread_create followed by a fork caused a deadlock in
the case where the fork required work to be completed by the created
thread.

The previous patches incorrectly assumed that the parent would
always initialize the pthread_barrier for the child thread.  This
reverts the change and replaces the fix for wp-fork-with-event with the
original use of atomic_bool.

Edward Liaw (3):
  Revert "selftests/mm: fix deadlock for fork after pthread_create on
    ARM"
  Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"
  selftests/mm: fix deadlock for fork after pthread_create with
    atomic_bool

 tools/testing/selftests/mm/uffd-common.c     |  5 ++--
 tools/testing/selftests/mm/uffd-common.h     |  3 ++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 24 ++++++++------------
 3 files changed, 14 insertions(+), 18 deletions(-)

--
2.47.0.105.g07ac214952-goog


