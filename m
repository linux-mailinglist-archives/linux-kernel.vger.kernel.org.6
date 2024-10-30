Return-Path: <linux-kernel+bounces-389277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AFD9B6AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B61CB21291
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B41F131F;
	Wed, 30 Oct 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGIX8l/D"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EC1BD9E1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308818; cv=none; b=dzIaj2Br17f3ZLNFF7YruzoEQFggMpNyogfC8Dt6Cz35j+YLEdd7DiZyEbqZWa9kGc20MB7NuK518jq5rdntRW2ttN10G5Z1J20F0PrbwIuXZSdWNNP0wTcHbGPlSkVLWxn3q1fi+0EXSI7A1Dq12Q50qU7asZTBoTLVCWOgJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308818; c=relaxed/simple;
	bh=gxaWEGY6OQ4tuNoSTe7NIiwN+sNJjFe7RPhD8VYisHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e8VP49cEWXh0lVxXqWTyyTctyYb22KKAHB1UeiB+gq3F7zfy+VEkkeXfLiwHtmdOcT3ZovwHBAAKmWmrNhO3RFio7ud4yjLWkz7Y8Cy6NtbRI+TNcvdst8RsllRR0q4NDEtTt5OsRELco3Nt73HauqgwqJEEo8PymGuWg6cVplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGIX8l/D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so145184837b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308815; x=1730913615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=TGIX8l/DsFh6IQc4/QFGJc9TCcbIx+7+2kn44uuFrhYfDPGWxqX8Z5i2ByMCzaROtV
         vjOr5q1VhgBkE8yquSGuo8yIn4Hm/Vd/BiT54ZCtITeJliLtn/PJVywBCm77XFE/zhEf
         TRa4xzkW76M/NLrgHnUn+PjN3h4lzzk1dyxoaiK4PxRNvdiXKYYN4iAhfhi2W7aWngcS
         kVqXcH8zpOSOx2jmrnrCXbrwShmM5lx8LMj7nwjCr4gaHXXZAT+TfRs07lLi+e9dWzvf
         mEddM1YuFd68hgedw6tPPBjbCrvts/94udQz7umgiarUJgbdbkWdnHHftra4g2S82fws
         tRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308815; x=1730913615;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaIhJ/i5AA0dydp29ds7cbKSvUDwa4uTzDrHzj4EZ5Q=;
        b=gxW2bbaI3g+jZ8jmV3LbaO8fzboCUGaULniT7b5KHvhm5W+jQSb9tPpgS8PDat4ayl
         iX17NV4CL8XgEEeUmtFnYo9uR0Fsb7xSzDa/GNgSzoMk6HkxqejHjXBWIwuogrXIGY5e
         oxyZscU/+4O8JsCfulA6S9gdYqPaksTrTZCZdXsM8YqAAoiJRPizobF6bf+XkjhqBvtH
         MP8GGCw9Nzs1bB0t/7h1PgJ+QTo7T6vOZMGM3xkG+pAXpwSGVXpQ0hMxrQ1xu/2t+mKS
         /Mf8KVrt3vcBPtVM+T/Qp/iXIbt66s+0GsHxrYxbyVtLTDpLS2f9AUu/jDfBXJIRp/Xz
         iHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUzHwKxhFp5lmfqh8In+ON1UJv+3BCoJINCIMssm+YhPwsjuIWn5onif8YDzCynG/+hRbFPduiW7Gk7Fko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaZktlGQBF9NmmuIxuGx803IIMmc2zeoEehWUh9DhQi9syUn0
	z+G+gmX/5u6DHTbdrePlmieBCHZCsbrW2HDZ0uE1FPdgFNUaoGAFCKVttQmLD8YnCkl9Z1wyKxQ
	bj/YDN6BTXcwX+tsyOjYtYg==
X-Google-Smtp-Source: AGHT+IGBpQPuMEOVpamNolybCR+mjTbMPDt7+NshVJpSoNsW5gjRbhZ3g6gIduYS77bJPcwbAfWWiWqoJEWjy6Vnug==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:cd83:0:b0:6ea:4983:7cbd with SMTP
 id 00721157ae682-6ea49837d4cmr283447b3.7.1730308814679; Wed, 30 Oct 2024
 10:20:14 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-1-kaleshsingh@google.com>
Subject: [PATCH v2 0/3] Tracefs mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is v2 of the series fixing the tracefs mount options.

Changes in v2:
  - Update the commit descriptions, per Eric and Steve
  - Fix ordering of the patches, per Steve

v1 can be found at:
  - https://lore.kernel.org/r/20241028214550.2099923-1-kaleshsingh@google.com/

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Fix tracefs mount options
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test

 fs/tracefs/inode.c                            |  12 ++-
 kernel/trace/trace.c                          |   4 +
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
--
2.47.0.163.g1226f6d8fa-goog


