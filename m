Return-Path: <linux-kernel+bounces-392952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACD9B9A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107702833ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943131E47A5;
	Fri,  1 Nov 2024 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ngxtxm5P"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155601E32C0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495919; cv=none; b=Ffpn+uvqjXEA7eWzAAumbHq5YRN1HRWnzRyKYUSbIadbeJP4ufTMXkP1a7kOVyHCM0H/NjIVRx46yfHv6fH3jXXt8B1o/wI1KR7l28GoTzmDRZIEd7ClY1lSerOs7XuobtHsgQI0JshAubLvg2gpHfZynGqJSXfGzDcmgIjV0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495919; c=relaxed/simple;
	bh=GZLGwFaeGlBzE/rs3TJH9JgA+VbP5Z9nT/OMYG9FaZ4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NgNeQe9aHL1G0CzEP6KGy+QdxoIdBxrVW0vrKqyrKLfUJCuvJA67fNqcLHaKaH1gE6uWMl+PHifMGH0lZ+dLMLmN6GiF7iTeHebU/vhjmMRMh3xXcgnzoHdUSwki0Y/s0J6nen58YLd6LkYOf6YG7sOHxTtHIO6qHPqElb6MnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ngxtxm5P; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38562155bso48511097b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730495917; x=1731100717; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKAUdhOSS2JqfDDbXfpdKgYJP1GP/t8//+MWRIuse6M=;
        b=Ngxtxm5PCOCrVv9fyZTNO5J3wZ/1qCiGFEuIYdhWCzcF+frLGRPyH8y91OgCsWme6z
         +OTMq1NLEzCcZ1GHRyf4vsP7n1vLsf8/b6PAUolh7v49Dvg68R9VkYepcxO+P3dA8YmL
         Cc5+ay4WsxoLqmyRBtqBYFTPPZAV58BziqPgOpeS2HYnN4E7eJPZqXVqKYioX5WusQ3g
         kHY7e/TGjC4Cg6V5rSc5PR3OxS9hMmv/kZcMdhO8o5yg+rzjANoupbVOPbyYDaYUzjIg
         yW/t50p0glRhrfuD9y0WLr7pZnli/vtRJ60V4zhPEKNaXbTrEqknmb00k5eKLdCiMS7D
         2fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495917; x=1731100717;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKAUdhOSS2JqfDDbXfpdKgYJP1GP/t8//+MWRIuse6M=;
        b=YR+CrcRhoJ6oH969pIwjNh7M9oFvSx7KiDjcpjCA4jbAd2opckVxj2Dptc+7i6fYX+
         XbWjmIwmPzm96YKv4vCfQevCD4uZBM8KOHaHeLnxXTrPekHO3KO+jALHMMZzCN17MzlP
         n87NHz0iz1bglGvIVe8BbbgLWPAtkTnqsT9RbjIbwfKhxgpf7oLU8vkB/TCS2V0U3avI
         oq7fnR55aQ2T3S3IvbIkNMZXHL3qZnuK9t97BVfWaHk297e0QpT5LUr47Fo7RDC0Tfmm
         zNAnYwgSpvn4uMQ7mv5PWGiGajt3y0JzLkx1r1PxQ2D+9Z6SeMqAHEFFxiY0kkOJonf2
         EmQA==
X-Forwarded-Encrypted: i=1; AJvYcCVf4+PBzVNo1/Xe9CuTxKUjIirRcx3TRWdIvNzWXJ6dFPLFHT5OW/64wAH9INPxKZ/kFL8TgtGobDE0EQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xw4wlpCISgobPcg6hXQj7dNLGdjtpjofcZLjsh4UNdc17YYM
	UdS9fgL+Y3ZT9dWevauA4A7LaSeIjKqw5JDGJF2vfyTlTlkGznAf2S/PWA1nCgTbzPZX6EQbRHH
	pnjne4g==
X-Google-Smtp-Source: AGHT+IHmvQkUsmaHvVLtx8/JrbsBlfHJP8YWtWyFWTuZIqJiUwu2npKVN3KrokNzcinZhefYCbmDQ5uspY8X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f2e6:5ab5:a95f:35cb])
 (user=irogers job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with SMTP id
 3f1490d57ef6-e30c79e1861mr13963276.8.1730495916629; Fri, 01 Nov 2024 14:18:36
 -0700 (PDT)
Date: Fri,  1 Nov 2024 14:18:27 -0700
Message-Id: <20241101211830.1298073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v4 1/4] proc_pid_fdinfo.5: Reduce indent for most of the page
From: Ian Rogers <irogers@google.com>
To: Alejandro Colomar <alx@kernel.org>, "G . Branden Robinson" <g.branden.robinson@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When /proc/pid/fdinfo was part of proc.5 man page the indentation made
sense. As a standalone man page the indentation doesn't need to be so
far over to the right. Remove the initial tagged pragraph, move the
"since Linux 2.6.22" to a new history subsection.

Suggested-by: G. Branden Robinson <g.branden.robinson@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v4. Move since to history from Alejandro Colomar's <alx@kernel.org> review
    comment.

---
 man/man5/proc_pid_fdinfo.5 | 51 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/man/man5/proc_pid_fdinfo.5 b/man/man5/proc_pid_fdinfo.5
index 1e23bbe02..ad739bd84 100644
--- a/man/man5/proc_pid_fdinfo.5
+++ b/man/man5/proc_pid_fdinfo.5
@@ -8,8 +8,6 @@
 .SH NAME
 /proc/pid/fdinfo/ \- information about file descriptors
 .SH DESCRIPTION
-.TP
-.IR /proc/ pid /fdinfo/ " (since Linux 2.6.22)"
 This is a subdirectory containing one entry for each file which the
 process has open, named by its file descriptor.
 The files in this directory are readable only by the owner of the process.
@@ -17,9 +15,9 @@ The contents of each file can be read to obtain information
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
@@ -28,7 +26,7 @@ flags:  01002002
 mnt_id: 21
 .EE
 .in
-.IP
+.P
 The fields are as follows:
 .RS
 .TP
@@ -51,7 +49,6 @@ this field incorrectly displayed the setting of
 at the time the file was opened,
 rather than the current setting of the close-on-exec flag.
 .TP
-.I
 .I mnt_id
 This field, present since Linux 3.15,
 .\" commit 49d063cb353265c3af701bab215ac438ca7df36d
@@ -59,13 +56,13 @@ is the ID of the mount containing this file.
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
@@ -74,16 +71,16 @@ mnt_id:	10
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
@@ -93,7 +90,7 @@ tfd:        9 events:       19 data: 74253d2500000009
 tfd:        7 events:       19 data: 74253d2500000007
 .EE
 .in
-.IP
+.P
 Each of the lines beginning
 .I tfd
 describes one of the file descriptors being monitored via
@@ -110,13 +107,13 @@ descriptor.
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
@@ -125,7 +122,7 @@ mnt_id:	10
 sigmask:	0000000000000006
 .EE
 .in
-.IP
+.P
 .I sigmask
 is the hexadecimal mask of signals that are accepted via this
 signalfd file descriptor.
@@ -135,12 +132,12 @@ and
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
@@ -150,7 +147,7 @@ inotify wd:2 ino:7ef82a sdev:800001 mask:800afff ignored_mask:0 fhandle\-bytes:8
 inotify wd:1 ino:192627 sdev:800001 mask:800afff ignored_mask:0 fhandle\-bytes:8 fhandle\-type:1 f_handle:27261900802dfd73
 .EE
 .in
-.IP
+.P
 Each of the lines beginning with "inotify" displays information about
 one file or directory that is being monitored.
 The fields in this line are as follows:
@@ -168,19 +165,19 @@ The ID of the device where the target file resides (in hexadecimal).
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
@@ -190,7 +187,7 @@ fanotify flags:0 event\-flags:88002
 fanotify ino:19264f sdev:800001 mflags:0 mask:1 ignored_mask:0 fhandle\-bytes:8 fhandle\-type:1 f_handle:4f261900a82dfd73
 .EE
 .in
-.IP
+.P
 The fourth line displays information defined when the fanotify group
 was created via
 .BR fanotify_init (2):
@@ -210,7 +207,7 @@ argument given to
 .BR fanotify_init (2)
 (expressed in hexadecimal).
 .RE
-.IP
+.P
 Each additional line shown in the file contains information
 about one of the marks in the fanotify group.
 Most of these fields are as for inotify, except:
@@ -228,16 +225,16 @@ The events mask for this mark
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
@@ -296,5 +293,7 @@ fields contain the values that
 .BR timerfd_gettime (2)
 on this file descriptor would return.)
 .RE
+.SH HISTORY
+Since Linux 2.6.22.
 .SH SEE ALSO
 .BR proc (5)
-- 
2.47.0.199.ga7371fff76-goog


