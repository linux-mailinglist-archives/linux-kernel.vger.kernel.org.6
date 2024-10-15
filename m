Return-Path: <linux-kernel+bounces-366709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166499F8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339531C21489
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4921FBF79;
	Tue, 15 Oct 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEiZ1G/V"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FB1FBF4E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027048; cv=none; b=cok4y2wkJKLQL1AGGqWCGjAuPJPidoDdxJarPPLsTKWwHQND8WTpHsS5RFlDLSpBjlCWfXp8VB7gzsBkIt4u+ABoq4eBWzBnXQ4hPAz7g1WYe1iL97fqUlpiEAkvPL4K0PZ8JX2NnnLblEteMfUZLCvLexysQVIjnQb3+A0+Eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027048; c=relaxed/simple;
	bh=OSoPMP8TH1jfd3P9ZF+OhgEsxfXDixx91HnmKCjgVsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EtzrvghWYHuCaAok69b4mNu4LIXhmDbrQ0tLhVg5f43oXtuTfW4Kqys8xCGLlWFQRLfTYI56WdBZdGi4wCTfkHmQSRME3IgZEpT0VjR2YyiBQyKZfZiFlgsCqsA8/3RfKlyks2T1mwmb3rOjEReTC/h5uUlQqTCPepz+g/gJe3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEiZ1G/V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so90708577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729027046; x=1729631846; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qp+83TpI3TezfCC8Dtvl97cBiL4JnurBtXXrj0jn8lw=;
        b=OEiZ1G/VzKh7qkEFf05UtRiMt4M9HpOf0xtZdPffVGZd+/L+OPG1PgXHAuO05Oco1T
         B5SAJ0xO06TA4b7uaAiwDA6vaCjtrE4XVPBwCJ7tuY3TGTpgrhwFQ2OM6UKqh4b+FR7/
         C/Z6KRmfOWI90D0l/NyCcCpl8PDhgVEzvedLN3uEk+jcS3MjoJBw8CUb/nIo/ayljW5V
         ikqOlBxSENxkP1uscYDHf6KRu/wRXl7dH1reK1m+XuXeHUsJrlGA29wBtYs4CJv9w28/
         VuLtTuPgiw7+7iYJdCjdVbZbej5ibXdst1vfSvJn7rR7JO66t3NtKAJjnR5svvRoy/L7
         LHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729027046; x=1729631846;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp+83TpI3TezfCC8Dtvl97cBiL4JnurBtXXrj0jn8lw=;
        b=JFMjlj1NkG6lQ/UKXQSHokFuqCOtM2D2l2WePgpBWe51kQA/VY/3635hx0T3mAeISB
         SnT2WtHyw5MZD+ORDOrWKDyH6U984MZjJ47UjQrmZP1/SBJb/pYt+je6WhAw2TeiWOJK
         gsiKPHmjxphf40UOGKabP1DUs2PfkQA/DEu0u3XRnOVzij4AD2sHEklj49TRhd9JBgaK
         LQr8LpfSMepg8An2DHeodSR8aoC2MkfsprhpXSooKHxswe/93aS+Up+EsgYTtA9XDTvS
         3MUXjIZSeBE73iPFf9HHlB9BuDV4etD7PoCl0JOy9f9Jk6WueZ2wtCvLWE1rX4MfTgCA
         VrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzDjIpaokEC+A8XrBVQ0iiZCxhbpQ4hMWmTvld5xRzLRBKwxSKxK7u4qa5j5z++AAEKhvcracJEhG/2ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5mvqEeWvrLVBJvS32rZZoPcrOj+Qx2gfLOq+BP+XvVitcZMK
	zPFW5is/Bjq+zDkRSf+jaZsvwkEC0XHZEZSJWRCoIFaumo9B0Y6nnX5mjlliiHaaKYiuBNXX6hz
	5kkunOA==
X-Google-Smtp-Source: AGHT+IEl3NSU1WdQwze6KAXwiH4egozRYT4wu4exGFfYWyRpDzyjB1F5KOwgYO3ID9qtJyh31DrebhRjau2i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:690c:7281:b0:6e3:1f46:77a6 with SMTP
 id 00721157ae682-6e3d40a2c01mr388767b3.2.1729027045640; Tue, 15 Oct 2024
 14:17:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:17:18 -0700
In-Reply-To: <20241015211719.1152862-1-irogers@google.com>
Message-Id: <20241015211719.1152862-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015211719.1152862-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 2/3] proc_pid_fdinfo.5: Add subsection headers for
 different fd types
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>, "G . Branden Robinson" <g.branden.robinson@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the sections about eventfd, epoll, signalfd, inotify, fanotify,
timerfd better separated with a clearer subsection header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 man/man5/proc_pid_fdinfo.5 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 8678caf4a..02eceac04 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -57,6 +57,7 @@ is the ID of the mount containing this file.
 See the description of
 .IR /proc/ pid /mountinfo .
 .RE
+.SS eventfd
 .P
 For eventfd file descriptors (see
 .BR eventfd (2)),
@@ -75,6 +76,7 @@ eventfd\-count:               40
 .P
 .I eventfd\-count
 is the current value of the eventfd counter, in hexadecimal.
+.SS epoll
 .P
 For epoll file descriptors (see
 .BR epoll (7)),
@@ -108,6 +110,7 @@ descriptor.
 The
 .I data
 field is the data value associated with this file descriptor.
+.SS signalfd
 .P
 For signalfd file descriptors (see
 .BR signalfd (2)),
@@ -133,6 +136,7 @@ and
 .BR SIGQUIT ;
 see
 .BR signal (7).)
+.SS inotify
 .P
 For inotify file descriptors (see
 .BR inotify (7)),
@@ -173,6 +177,7 @@ file is exposed as a file handle, via three hexadecimal fields:
 .IR fhandle\-type ,
 and
 .IR f_handle .
+.SS fanotify
 .P
 For fanotify file descriptors (see
 .BR fanotify (7)),
@@ -229,6 +234,7 @@ The mask of events that are ignored for this mark
 .P
 For details on these fields, see
 .BR fanotify_mark (2).
+.SS timerfd
 .P
 For timerfd file descriptors (see
 .BR timerfd (2)),
-- 
2.47.0.rc1.288.g06298d1525-goog


