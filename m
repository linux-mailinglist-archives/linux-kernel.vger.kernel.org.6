Return-Path: <linux-kernel+bounces-174859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514E8C161E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68741C221B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856E84E0C;
	Thu,  9 May 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCwUYfrI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4F1311A2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284888; cv=none; b=gKgpOMJbWOM0jmAADLwT0o6+YdI1RXzeS1ODM/hcYHWL/uV74a+PJIQtadZ8Aps4hfbNdsnHAERQyfc+iFQDvYl39s6SEhTehv6Y/u+B9cwZ1e42G0Csk+VNlF11/uaa6Fegx+LBa0jXNeRHynk/i0GbwQPdsvdE9vEhUYLs2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284888; c=relaxed/simple;
	bh=H0xNOT4MYx4yQ3KHHxBXKyqMMscf8BIYORk36eDuIO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2QDgVa4t1YRu8TWryG7+iWk9NRfZVQjQHagtF62PrBULeciNHcCVFgUPdebFs7WbHlmCWQFpWqEXNXslzDxVn4MmxWc8oaGjWJo14lrSfnN1cZuimdrsRvsNfv4j4OGXhe7i36d8hS2AdbRh6+dRflMv3VHvsunKlSl+/pWjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCwUYfrI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee2f06e652so12177805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284886; x=1715889686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=FCwUYfrId6z54JrRqF5cV0StvlVLJTB0VHNWy2rtbqOgyBQBd0IsCxgU8QYRAEbd0y
         erm4+Gzp23EjsRxbGj88oBKYzxSSn+UE0T+3LnYJgjAyK84I1UUH4QJ/6G8B9ZFVWMKY
         G0Qh/eDc4+0KI5t0I9vVCXuNmFTm/WF9wsaS81w7MJCIhNNDJYlJrpcsLBeMQYYaEtxO
         HDxV2tikjkOxggYVoLn91NkJVEpVtITYhGhHX/4kIZ8v+N9eXCNKZd5hTWiMlEE75IxH
         WXy39lGXRViNrtVCCtZAu3Fg2nwX8vDeO3mZ1oPpzeDNZkJXpLkDjydYMAnOw3yZ0pPr
         dhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284886; x=1715889686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=TU803hbzNa70b2rUTWhiGCfOxFOvw/rNurqgeuCI6+vyOdOxCtu0R/Um4teKP2cNX+
         IjCwqF4CY6hB5E+MI9W0RvN6wzDsHU75Bj5RrYEUgFBC/0XKFZHDRdQQH6NFmbjLCglV
         DYWn/9f/eZbq54soN83yj+T3ReEBwvhhXSCMNMxZfayCWUsXUmmSZTC+KgeFZsQXLRNG
         iMIJTXHyuP9RtWFVKYQiVlfXfRCrt9zl/afDyLc0Uz/OQf8DrCfjIaakDwPV/fnii3xN
         +BPOYYfVan1oN6g7mexeeqeExtFXH3pyRLI7LdU2YocbWWirjRaj/nAFezdgDxwIb4KZ
         1d4g==
X-Gm-Message-State: AOJu0YyLr7hEYi+GO4gjhn+lbJ5uEV2rIlqVw1eYQcEx7UAqjQiWWc5m
	A9VyNdv6yYw2WRmE6YuOt9qsVJBsxKBFcVCkmnqFelDoniQWaI7WNuzJgZKv2uDoT8l3NZy/9Yu
	LEQ==
X-Google-Smtp-Source: AGHT+IF+9O8AdOrC0sfYwymi9nDgS8P3uCdoKz+tbRqRCiftF6S/rlAyRlPcJO8FmcCJmXEqc5hw6LgYks4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:cecc:b0:1eb:62c6:98b0 with SMTP id
 d9443c01a7336-1ef44049854mr17265ad.11.1715284886040; Thu, 09 May 2024
 13:01:26 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:05 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-14-edliaw@google.com>
Subject: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
 .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
 2 files changed, 5 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..7a17a03d555c 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -2,9 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..4aeac55ac93e 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,8 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
-- 
2.45.0.118.g7fe29c98d7-goog


