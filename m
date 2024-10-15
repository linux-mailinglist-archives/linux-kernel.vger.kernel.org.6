Return-Path: <linux-kernel+bounces-366471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEF99F5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689DD1F25148
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129C2036E7;
	Tue, 15 Oct 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZhUkLyh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCC13C3F2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017527; cv=none; b=iT7u3nyrt5ND26Bq4GFlc4qiOpSoGSdZwd+AkSLRdmeW6NFd5ie2LpVhOcTixsjHJbkV4d5XrR0dKboJIUwONSxNgMCSRsiYYzvXs5bSANKS7kPwj0j2AzRegx2+Umg3gph2tThQxob6Xz3KTLoa4fRJpmmSc+YNgkAC8qryGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017527; c=relaxed/simple;
	bh=GNXj3nUhSvxJmdbJQREeSXSa7GaHWSES3dEtYsyt5IM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=TWaPrDB/+4wLyw3PtSuR2ZkwPapyBOh9/TNzVAorn7aZQQfHo3aqkMxBDsL0Qy+E7YsOh6qegmmMrGpEgYVuQp6Sqm9zxSJXAzkPp/YOH5WAcDtavx3m0CbgagU67uo+U3vj0rqV/mllmwGZ9qQeYT4V+YIkeyVhJnaBB9x2zAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZhUkLyh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32b43e053so72083917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729017525; x=1729622325; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elVcyqBRot1hWy/7wsiTZrHkBjkpf9b46nIr70Zlz4E=;
        b=hZhUkLyh2BGc4EW69zU5tdUAkPbN9ptgOymoIciW6nfEYv35WmmBwDmoBPUwAYuKS+
         h+1+6TBit5SuszabeKCrQ4A41934DR3hX5Ab1o70vuHc4SXZrZg22HK8RrVrazsny08n
         lWvHVmgHrYl1ruL4FwiR1RLmm4i5JZ95L+5MMF5LCWNDawAljYmYnnbFMSRxH6uwyguQ
         JaK9d/7t3Kb+yW2Qy28WzjRVdGzZ5qV18XsvAL9Rz+O0gXt4/E4mhOA98Qhz0d8VURFV
         zsviVUpxbi+zjHGLmoAW0xpyAS0/dUw6jELTqKVFxJTb/sZMuiYmQPXvOfOUoDnKb62g
         6o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017525; x=1729622325;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elVcyqBRot1hWy/7wsiTZrHkBjkpf9b46nIr70Zlz4E=;
        b=CzW9Xo1HQosf+0dih8WAi2IEkbSQaBKs5LBy1fURiWv7zGgyOTGv9HXGEZIfzg50SX
         g2zj2M5qRDoh8gODvenLOZhYzhZfxZbniiXJMAGZES0hbEc1hKQOwHuRNFLQpomFtu8z
         yMT0Bl8ejYWpvndPo6CRQC4w4ibIQyqbsMNkagtCRjPtFq73P5iGYORxwzG1H1bpLAF6
         YzDzfIIGcruZoZKxKmMJW4xqX1pvLkDnI1uAbZGcKHn0oEPrgMilyW74m2jPa7gq+RUg
         DzBz7ZEGK3n6b6HYGlGXaWhQCMMEE0jy9npV1YkqWfP4HT1i++368BHui1aU2yXioqK8
         ZTMg==
X-Forwarded-Encrypted: i=1; AJvYcCUMTiYpWGDYdmSzypq6ROkNlFKEtKRDEWlYc9b3AmjNfYfjOkeKkBvnOOaXHOe1bqN5Mhl7YhM4bEoJBgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0STPLwfBvpN5Qwdlc9Ohqz9oq/n27/JTsPI5McV4H5q7U6ie
	P4hcgJlMuiUx1KNihsOGEPakVZBSyxf3HmgmjMv4X7PH+dOcnxNdaS6mMw5c7cxeyXd0mtggHtO
	ErMK83A==
X-Google-Smtp-Source: AGHT+IEyK7rc0w1b7082t7PmrW0ZPtserOhvsOb+4IAJFUB6ZgGx9hjsurpK767oQk9+ppFpQnIWnoXlh8wl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a25:9702:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e297857f673mr582276.8.1729017524932; Tue, 15 Oct 2024 11:38:44
 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:38:22 -0700
Message-Id: <20241015183824.1014964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 1/3] proc_pid_fdinfo.5: Reduce indent for most of the page
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When /proc/pid/fdinfo was part of proc.5 man page the indentation made
sense. As a standalone man page the indentation doesn't need to be so
far over to the right.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 man/man5/proc_pid_fdinfo.5 | 50 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 1e23bbe02..0c4950d5d 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -8,8 +8,9 @@
 .SH NAME
 /proc/pid/fdinfo/ \- information about file descriptors
 .SH DESCRIPTION
-.TP
+.TP 0
 .IR /proc/ pid /fdinfo/ " (since Linux 2.6.22)"
+.P
 This is a subdirectory containing one entry for each file which the
 process has open, named by its file descriptor.
 The files in this directory are readable only by the owner of the process.
@@ -17,9 +18,9 @@ The contents of each file can be read to obtain information
 about the corresponding file descriptor.
 The content depends on the type of file referred to by the
 corresponding file descriptor.
-.IP
+.P
 For regular files and directories, we see something like:
-.IP
+.P
 .in +4n
 .EX
 .RB "$" " cat /proc/12015/fdinfo/4"
@@ -28,7 +29,7 @@ flags:  01002002
 mnt_id: 21
 .EE
 .in
-.IP
+.P
 The fields are as follows:
 .RS
 .TP
@@ -51,7 +52,6 @@ this field incorrectly displayed the setting of
 at the time the file was opened,
 rather than the current setting of the close-on-exec flag.
 .TP
-.I
 .I mnt_id
 This field, present since Linux 3.15,
 .\" commit 49d063cb353265c3af701bab215ac438ca7df36d
@@ -59,13 +59,13 @@ is the ID of the mount containing this file.
 See the description of
 .IR /proc/ pid /mountinfo .
 .RE
-.IP
+.P
 For eventfd file descriptors (see
 .BR eventfd (2)),
 we see (since Linux 3.8)
 .\" commit cbac5542d48127b546a23d816380a7926eee1c25
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:	0
@@ -74,16 +74,16 @@ mnt_id:	10
 eventfd\-count:               40
 .EE
 .in
-.IP
+.P
 .I eventfd\-count
 is the current value of the eventfd counter, in hexadecimal.
-.IP
+.P
 For epoll file descriptors (see
 .BR epoll (7)),
 we see (since Linux 3.8)
 .\" commit 138d22b58696c506799f8de759804083ff9effae
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:	0
@@ -93,7 +93,7 @@ tfd:        9 events:       19 data: 74253d2500000009
 tfd:        7 events:       19 data: 74253d2500000007
 .EE
 .in
-.IP
+.P
 Each of the lines beginning
 .I tfd
 describes one of the file descriptors being monitored via
@@ -110,13 +110,13 @@ descriptor.
 The
 .I data
 field is the data value associated with this file descriptor.
-.IP
+.P
 For signalfd file descriptors (see
 .BR signalfd (2)),
 we see (since Linux 3.8)
 .\" commit 138d22b58696c506799f8de759804083ff9effae
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:	0
@@ -125,7 +125,7 @@ mnt_id:	10
 sigmask:	0000000000000006
 .EE
 .in
-.IP
+.P
 .I sigmask
 is the hexadecimal mask of signals that are accepted via this
 signalfd file descriptor.
@@ -135,12 +135,12 @@ and
 .BR SIGQUIT ;
 see
 .BR signal (7).)
-.IP
+.P
 For inotify file descriptors (see
 .BR inotify (7)),
 we see (since Linux 3.8)
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:	0
@@ -150,7 +150,7 @@ inotify wd:2 ino:7ef82a sdev:800001 mask:800afff ignored_mask:0 fhandle\-bytes:8
 inotify wd:1 ino:192627 sdev:800001 mask:800afff ignored_mask:0 fhandle\-bytes:8 fhandle\-type:1 f_handle:27261900802dfd73
 .EE
 .in
-.IP
+.P
 Each of the lines beginning with "inotify" displays information about
 one file or directory that is being monitored.
 The fields in this line are as follows:
@@ -168,19 +168,19 @@ The ID of the device where the target file resides (in hexadecimal).
 .I mask
 The mask of events being monitored for the target file (in hexadecimal).
 .RE
-.IP
+.P
 If the kernel was built with exportfs support, the path to the target
 file is exposed as a file handle, via three hexadecimal fields:
 .IR fhandle\-bytes ,
 .IR fhandle\-type ,
 and
 .IR f_handle .
-.IP
+.P
 For fanotify file descriptors (see
 .BR fanotify (7)),
 we see (since Linux 3.8)
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:	0
@@ -190,7 +190,7 @@ fanotify flags:0 event\-flags:88002
 fanotify ino:19264f sdev:800001 mflags:0 mask:1 ignored_mask:0 fhandle\-bytes:8 fhandle\-type:1 f_handle:4f261900a82dfd73
 .EE
 .in
-.IP
+.P
 The fourth line displays information defined when the fanotify group
 was created via
 .BR fanotify_init (2):
@@ -210,7 +210,7 @@ argument given to
 .BR fanotify_init (2)
 (expressed in hexadecimal).
 .RE
-.IP
+.P
 Each additional line shown in the file contains information
 about one of the marks in the fanotify group.
 Most of these fields are as for inotify, except:
@@ -228,16 +228,16 @@ The events mask for this mark
 The mask of events that are ignored for this mark
 (expressed in hexadecimal).
 .RE
-.IP
+.P
 For details on these fields, see
 .BR fanotify_mark (2).
-.IP
+.P
 For timerfd file descriptors (see
 .BR timerfd (2)),
 we see (since Linux 3.17)
 .\" commit af9c4957cf212ad9cf0bee34c95cb11de5426e85
 the following fields:
-.IP
+.P
 .in +4n
 .EX
 pos:    0
-- 
2.47.0.rc1.288.g06298d1525-goog


