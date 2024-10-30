Return-Path: <linux-kernel+bounces-389280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF839B6AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4751C230BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFC21765E;
	Wed, 30 Oct 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8NzOemP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B221502C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308860; cv=none; b=PmjZp3hCvEBwzLw0EravG0eMADBpGenlcv4g0hHL3FmDOGJbH8LxlZ+g/5Z8rcnBV+wJWmOjfzmQ1hjOmzsXOaK3jSx7mUhBirHOynzTR88vWthfKuEBJcfCakKz3VFz28s3bp3ITzNYtnkOY71ZJ5T+7GDgTUjoeZiyViIEeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308860; c=relaxed/simple;
	bh=rDPKRF5nbM8EQhE80nGXFbHhdN7TfLAQ/0VKEszrmh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYzDRnNNFT12E2ZgPdk3Ipfb5h+8YM1+JGnPfqgPJLF35p5W1lOpyUrGLNVGa2xN29S1BMwfWIH2DGH5SBjXeXLHJoxVV2BBQ4x8taw7WXfuymyXcjnuo3MNMdtiuBMzCR5QxBmEpp3p68T7RtjugTzms1edmYrv2ooJfjEKn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8NzOemP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so117020276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308858; x=1730913658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=S8NzOemPfn4rEDI0nLWGoTTtAHvuwN4ComisPg4fLysh0Sbh3ayOcWXwpmwZBg/Q0D
         eZmfa6eTu+pUtDXDLjWkMU9m5qDjZ94q6dFMjpL6fqlXWQ4+uwaK9dtk3VS5IVZrueDh
         fvBlEiXebtPtw5dh9WA2jv2wgd2vrtSkuA1dfS2DrzWY476gY8rQflI7ETD4Gqc8M30S
         hMikTso6579EY7/Q86lVhCgGUyso2U4+LBk3ZDor9sWAF9K6CWZkmaalmkffRj/CGPYN
         52iBHveR+X9qhfiejFQmwAnTYgbwED6Gr0FiPbnOruEtEu60Ga+chVSyGYpCnlrtXnTX
         N4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308858; x=1730913658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=i+SfABT+vkIlrReWV+RlzWtWVUqHh8mZvF86chZlc3WANfR9/9scezX7zXWz+opi/k
         mHWucfOzfH3cNJ0tFudkVMpGM79XVjBq+27IDcTAnIKXAjlKrjcGbv5O49CAjEfeDpZ9
         R7z5W582l6sZw5hswsh0a1o30LxC0Ts8wOboTr+rJ0/b/IF1zHQnRMUJ4egEA5R4xbCo
         3kA7ivhydzioDHHuo0vymp/iFhb7WQjDOhhXcPVuPouwdkBWhoKRVYxIWg/SxXsSAvI/
         U8sTycQwfPNjUWfON6sA1NS/CDPHPcpwwGG1/uByWJvPprfGld+QugxA6ZFDAk4Quxsd
         ffnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYdmPVLm1VTVfzOSELHDW6mB0uQ3eyT4zA07dHExSzXBPlJ2l0WVbDy4Y7WGK+/VV9jGgksZBQb9U3pxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWF+smwvtQKgqKZwj4Aaz0+XJdXXKAN8hwScngl0SsxT3k67Dm
	+EEGZbmWfizkt7HYu9SbAuZHAlq0bfPTLzUBRmCnwBTE6Or+6G/n/SbabW0RIZgQft42uuRycE2
	yWCnNErA7j4L2klQ0vgU9wQ==
X-Google-Smtp-Source: AGHT+IFmFQ2+ilc/frkLStjSQyf19IpIYrW2nD/6coGLs4CVgqbF3qEYdPRbZm6F8+l8PBqgjQXpJziq3HiTUEpEQg==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:d4c:0:b0:e30:bdc8:567f with SMTP
 id 3f1490d57ef6-e30c190221cmr60305276.4.1730308857554; Wed, 30 Oct 2024
 10:20:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:49 -0700
In-Reply-To: <20241030171928.4168869-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030171928.4168869-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-3-kaleshsingh@google.com>
Subject: [PATCH v2 2/3] tracing: Document tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit ee7f3666995d ("tracefs: Have new files inherit the ownership
of their parent") and commit 48b27b6b5191 ("tracefs: Set all files to
the same group ownership as the mount option") introduced a new gid
mount option that allows specifying a group to apply to all entries
in tracefs.

Document this in the tracing readme.

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Reference commits instead of lore links, per Steve

 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..2b64b3ec67d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {

 static const char readme_msg[] =
 	"tracing mini-HOWTO:\n\n"
+	"By default tracefs removes all OTH file permission bits.\n"
+	"When mounting tracefs an optional group id can be specified\n"
+	"which adds the group to every directory and file in tracefs:\n\n"
+	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
 	"# echo 0 > tracing_on : quick way to disable tracing\n"
 	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
 	" Important files:\n"
--
2.47.0.163.g1226f6d8fa-goog


