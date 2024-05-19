Return-Path: <linux-kernel+bounces-183194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0C8C95CA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB48281833
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02234D595;
	Sun, 19 May 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mm7zhmJ+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D2D2FF
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716142644; cv=none; b=AMNGoCAPK2y0TOCwkETa8AqCeWsorFx9TFKEMjRDJL6v0sPmBxZRRkeD0pdV/boQK7bVJJHoVWuxDaYm/grUomuZMGx0D3F+sXkR64EIU2F8tH1GBN0ZPt9A+K227jMvdXp3KxF8kKWQeYkuTa1FTHapOb9LJQA0nLdRiZB7hpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716142644; c=relaxed/simple;
	bh=2s5g+zwfMTvziUNuBm+f7vvR7h8jdexplwL+ieGhwOU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=oytVi1JtpWLeN3jQf7+bvVaCC0FaJ7Clq1ylqQCugeuHEOo4v2e8pVYEH3vjd6nqeHOlcR3nTPHDlZSmu+23rFiX8drscZHgCy76gKyBSsM4aF2MhwjcO8sNYDCc675B2/pO+fsWdYdTfji6j/0ot1MD30RBndM97OQe3qu3AUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mm7zhmJ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee5f035dd6so16159299276.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716142641; x=1716747441; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EF57d/oSo3Tiz1+Ri035kfCFIPne1iVfqsIeBXpa+mA=;
        b=mm7zhmJ+Dn7S9KUFk/8y22EXpiq3lQgY89mQ3tj51qB42iZ3lA/MD7Vu5rVAzZ0AUQ
         mujjAhEGTnM3z7aULDG9KNk3sRsHZP73X+Fe8CsUw/P4v6Ntsx82aYRIiKXesl7EEPMp
         PxTmux3cePpZuiPfOQ1mMSsc+KvSXBvD0UQ1pV9Ou/FwZowOBmmB0+5EDppq4OijGio/
         DmKl6MoKbVI5E1uWT1uiZiORb/fmnVOHqNaiN1D4gkS0dRxP9GWQuffP8+/bpxSfCU+m
         2HqO+R43/8eBONn3Ue40HxBwvZ73tDjqzh3eHwo9xCufkK+jIASnxIOfJRAmqOAPdtaJ
         1SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716142641; x=1716747441;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EF57d/oSo3Tiz1+Ri035kfCFIPne1iVfqsIeBXpa+mA=;
        b=VDC8QL2DJf9i1g1D/PdNV4CCmXUeWzOx9UcjFACeU2g5zSnkg90oYIunLYErPNcAGl
         ad41OgRNOuZGFMjPLvfhMpTEsBOoslICo86L7o83cbkeSEPjfg7Uvop+FNwkh6vrEdkE
         X2hgapkQ2a77ZkDlxfdTAB1dCnTOWHNs5WJ0hMkUaSp0O/35IfRA9eSRnYEph1LCGz1k
         emO38kLFIVi6Wr1xFVydcStPNgX1tL7Yukf9tjHdJJXAOc+nWXQv8ddSJouN4H6fCzug
         K6tel/v0xgYwDgfObTMfSityDHBabFcVIxAz9eSe2l3VX/K2LEewdilpXPlXycsnwA9Q
         9fPg==
X-Forwarded-Encrypted: i=1; AJvYcCV0VgrdKfqXB9MT+wQ3PBQZ2kkp0ZIGZNwJlH+/+0CYg0sdADtD0CY6E43z8qyAT5BHiNcG14EZ0WVHxo6j3pkyAHM1n46wCZ28+bom
X-Gm-Message-State: AOJu0Yw8PKy5O0G90Xm44/dl4Xl8ETUNNEM+EgovYBcK0ESXnogOlnik
	AAhQY7fNyqH54glqxweQEwvmxbS+4MuUpgvPC68Ewlex+FjcA3bwpx/08sSZWTXQgIo44TKtKLs
	7TsU2CQ==
X-Google-Smtp-Source: AGHT+IFX2CyWCwQfx/kdQYayR3AJIKR/mn3cf14Llmu17FFVI55/2e1typh2ueAzDGhVlMaDIzn64DxLf7cw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b6d:77c7:e6ad:c2a7])
 (user=irogers job=sendgmr) by 2002:a05:6902:114d:b0:df4:97ab:3673 with SMTP
 id 3f1490d57ef6-df497ab39b3mr1174299276.5.1716142641040; Sun, 19 May 2024
 11:17:21 -0700 (PDT)
Date: Sun, 19 May 2024 11:17:16 -0700
Message-Id: <20240519181716.4088459-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] tools api io: Move filling the io buffer to its own function
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In general a read fills 4kb so filling the buffer is a 1 in 4096
operation, move it out of the io__get_char function to avoid some
checking overhead and to better hint the function is good to inline.

For perf's IO intensive internal (non-rigorous) benchmarks there's a
near 8% improvement to kallsyms-parsing with a default build.

Before:
```
$ perf bench internals all
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 146.322 usec (+- 0.305 usec)
  Average num. events: 61.000 (+- 0.000)
  Average time per event 2.399 usec
  Average data synthesis took: 145.056 usec (+- 0.155 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 0.441 usec

  Average kallsyms__parse took: 162.313 ms (+- 0.599 ms)
..
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 53.720 usec (+- 7.823 usec)
  Average PMU scanning took: 375.145 usec (+- 23.974 usec)
```
After:
```
$ perf bench internals all
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 127.829 usec (+- 0.079 usec)
  Average num. events: 61.000 (+- 0.000)
  Average time per event 2.096 usec
  Average data synthesis took: 133.652 usec (+- 0.101 usec)
  Average num. events: 327.000 (+- 0.000)
  Average time per event 0.409 usec

  Average kallsyms__parse took: 150.415 ms (+- 0.313 ms)
..
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 47.790 usec (+- 1.178 usec)
  Average PMU scanning took: 376.945 usec (+- 23.683 usec)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 84adf8102018..d3eb04d1bc89 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -43,48 +43,55 @@ static inline void io__init(struct io *io, int fd,
 	io->eof = false;
 }
 
-/* Reads one character from the "io" file with similar semantics to fgetc. */
-static inline int io__get_char(struct io *io)
+/* Read from fd filling the buffer. Called when io->data == io->end. */
+static inline int io__fill_buffer(struct io *io)
 {
-	char *ptr = io->data;
+	ssize_t n;
 
 	if (io->eof)
 		return -1;
 
-	if (ptr == io->end) {
-		ssize_t n;
-
-		if (io->timeout_ms != 0) {
-			struct pollfd pfds[] = {
-				{
-					.fd = io->fd,
-					.events = POLLIN,
-				},
-			};
-
-			n = poll(pfds, 1, io->timeout_ms);
-			if (n == 0)
-				errno = ETIMEDOUT;
-			if (n > 0 && !(pfds[0].revents & POLLIN)) {
-				errno = EIO;
-				n = -1;
-			}
-			if (n <= 0) {
-				io->eof = true;
-				return -1;
-			}
+	if (io->timeout_ms != 0) {
+		struct pollfd pfds[] = {
+			{
+				.fd = io->fd,
+				.events = POLLIN,
+			},
+		};
+
+		n = poll(pfds, 1, io->timeout_ms);
+		if (n == 0)
+			errno = ETIMEDOUT;
+		if (n > 0 && !(pfds[0].revents & POLLIN)) {
+			errno = EIO;
+			n = -1;
 		}
-		n = read(io->fd, io->buf, io->buf_len);
-
 		if (n <= 0) {
 			io->eof = true;
 			return -1;
 		}
-		ptr = &io->buf[0];
-		io->end = &io->buf[n];
 	}
-	io->data = ptr + 1;
-	return *ptr;
+	n = read(io->fd, io->buf, io->buf_len);
+
+	if (n <= 0) {
+		io->eof = true;
+		return -1;
+	}
+	io->data = &io->buf[0];
+	io->end = &io->buf[n];
+	return 0;
+}
+
+/* Reads one character from the "io" file with similar semantics to fgetc. */
+static inline int io__get_char(struct io *io)
+{
+	if (io->data == io->end) {
+		int ret = io__fill_buffer(io);
+
+		if (ret)
+			return ret;
+	}
+	return *io->data++;
 }
 
 /* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


