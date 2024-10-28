Return-Path: <linux-kernel+bounces-385954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B029B3D79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A029B22514
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369B185B56;
	Mon, 28 Oct 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx69UkXP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAF190493
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153110; cv=none; b=GBVmHoJzspDdOwWat30hvxcfHcQEYSqkfurHxjSrBI6mf5hLpxC5fG7R3t/ER2tc7OMDlDOceVz4dGHP4EO+GvKXn4TUjJrx+kDCm0PlROSDEE9CCqaHM/l57UcAECMgn2TvbZPT/lZ+qct3lUsBYgWlstiNF7vnhxZ209LNBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153110; c=relaxed/simple;
	bh=0hoHck181vRn1NSr2f2PwuVWiPIZTgKgLGSUOf4IQxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hzew4oha1PnPdL2qd+BeraK0Nn+cqpX3JudjnkojmVEAF6KOzgcmF0OvGKHr8I8d8qNTwBcIL7b5z/a3ZsAdFpbGo5pg6xzMto5ME7ujyS5+he7YKwlZqjEIbjD5TZ5aRIiitSBGSPLBJ5Bv3mGdMv+rLU0kkMZ/LK4gqfZqGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx69UkXP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso80408147b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153107; x=1730757907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=Mx69UkXPMwQkgGdN/igewvdBssfAnJIUmSPMX1dVSFcmQptL2aKyzHFv12uwgTkGi+
         9QXQOAnvHaC7d3rxZ8gPM+FM1l/SiIJEjesgVVUoWfMoqNxu7jJ97muVPKtRMMcGWYOH
         nIIKfI2QGF6bK/3RMdBqHXP5LYklBzFrvmSRDMxs12uv+hNyXERiBXziiF+2FTnufiXP
         WjsFNlyxIcCp8iTjyEveW2bDAmGcDLTGBkuV5SxXAfHNt43s0whqouNBpIZpeHofCOWF
         i+Ambb0jQmhN/YFFbSF+B4m8ZzJWfgPGyFfEeXvUWHb+ZHTv8zAdHUgE59Ef7gvFFu6Q
         ZLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153107; x=1730757907;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWhquCb49LKi5H2UYgYKpnhN10davrTJtCE6vqtRvG0=;
        b=pzcho2o041SjEqP0gG/WKivRTJf3n/34EANbRA6A8YLxahvSXwGXs5sxFBHYtDf2Dg
         HT5rBt3jPKR5biSZxh3u9uEAa+YTqUf7HJRLHL/J1FWxNSsdyT1m8qPHtxuNEDkmRZoC
         Wa0MgqugMqeGPZAtO0n1ke1sfpRXN9wiwZ7pV2j5YcbfHssR/+F+7j3pDpYdOw8Sunfc
         SnTd9zLA0UpHRRHZdOLCBei2hY2n1ive7n7SSkAcUKMxCcwTXQPuhSfSrya8ivpoIS7b
         z0fLZ7PS0S3N/fImR1x8P2lwbc1wuLkCtXTm+hWTvfrH3kAfdlrkHgrD0YZ+7aYkzeCJ
         Pl1w==
X-Forwarded-Encrypted: i=1; AJvYcCX7aBkQaB13uTHGvrQZJnvDGyFsG03CHaiM9dZ5bU+Jis2wJXttnSW7kue0skE7CnQBu/Bqf5M0yV0xEak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZZo0fYxGoNDt+MuQZE/3zAwNfQAs2CJ95O4tVyBoqUDWKzs3
	sm4L7mpJJQhkhgB4Xp0zOv6NWJDHUOTgtY6jusDzF/KF03wLYZ59ucwJS6I76fC6I78UCm2NK8c
	McY9n30w6pWGWVkqxOb5HvQ==
X-Google-Smtp-Source: AGHT+IEAnCfdVLBm6ktQBhqpFyGMf87tkH/Lnfvvyg2A06ArHO+JMopPeHeJSfmCQLpmkvHXVSBQbL+oME5hPCmQMQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:521:b0:e29:7dd4:a945 with
 SMTP id 3f1490d57ef6-e308784b3c3mr25736276.2.1730153106526; Mon, 28 Oct 2024
 15:05:06 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-1-kaleshsingh@google.com>
Subject: [PATCH 0/3] Tracefs gid mount option fixes
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series is based on v6.12-rc4. It fixes an issue with the  tracefs
gid mount option. Adds test case to prevent future breakages and updates
the tracefs readme to document the expected behavior of this option.

Thanks,
Kalesh

Kalesh Singh (3):
  tracing: Document tracefs gid mount option
  tracing/selftests: Add tracefs mount options test
  tracing: Fix tracefs gid mount option

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


