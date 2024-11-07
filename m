Return-Path: <linux-kernel+bounces-399104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546939BFB18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771E01C21E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D9747F;
	Thu,  7 Nov 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAOaW7gB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DE6FB0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941116; cv=none; b=eO28BPUGT2QN/IMtM0qJb3TFRfi6K/zrfyS7DubtRo8rJoFxTUFmAIlEcfvaZR/t93sUfqKbndE9BOwGUBk63Ixo7T0FoX4XlHkPP8lkbTIFk+XstbkqpsVZ2ehIk+5f0O0gCyaqPOlSARFz3+hQBaMXLAEDKR9oTHjSPnLxhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941116; c=relaxed/simple;
	bh=t1ou46iIjzvaBggY1vgzIiMrGrl24o/1E+AHBi6et9M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NOircJKm23D+blQLmlmHrLJJpbV+3ZVIoIIa5kgNl8m6Rfik40pysCbVC9WfbC1X1qrES+i11+2EusD6IgZn1b8mLKbE6g/kPC995NyYgcFrSVHY+Y5e0x+CPwzeNwz7Nr8tD+4ffmeU9J6AloQ95GViLfvkEVRnybhPLYUWHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAOaW7gB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e76eabc7ddso473182a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730941114; x=1731545914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z89P/t7blucBdhCfGt6c7It+8Y+g3IjQVR7h5Yrblaw=;
        b=uAOaW7gBEbY4gVm3m9kIiONB/F1qBR5uHWApzV8O26cYn7VgONa1OiBgjM3ZgtUhBS
         slVHP5T5AxUgCUg6EQNWoEBbva3GwLH42dlrjWNMOpziKEd8HrVyMMyLxYbWWC4raJtr
         5XpkJUZkSE4rAbxIrSIn4QqxoM28OZLHmXHAIJjUe8oXJYGV4myR/sDymCN6wGTfr7bC
         hdNhlqYp84AD78Qlx7GjsqTICMhVvfMpyqCiFxvR2hFmE1wI8e2Oeos6LyVidrrwutbc
         0Kb9ZJQqGoBWAov1NRkiJkeUZDk7L1nyNxo13C9C8+h5bUV5BGvrU/sHefThKiMSrUsn
         wSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730941114; x=1731545914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z89P/t7blucBdhCfGt6c7It+8Y+g3IjQVR7h5Yrblaw=;
        b=YNX7nJCYXeuxAbdGCb5XjVUXMVzLBJO1bqaORr4JDiHGQKml8btx0IzVxbh2HkeNdE
         eUkrzQU8UnoQeUnjM1LvdppAdJH4ye9S0YwNS7bGfNRH5tC7tkMgo0FIRMBulxvdb0Cm
         0kR0RMQYmMLGhvITDYeBKeNMlCdj0lsE+uwmxT6lnND60CCIKkJHdWGUxDgGCbiAweuc
         COMQtNvpaIlDNuzrq0P1FURPDI/QLrpZNBC0mh/emQsNBWI0KOSMWg2OH/sqtCOzABYH
         H1KgyZaDR83Efjv+Qhkl1yAxhJFzhd4qc04inkjwaXm1EVZroh4J95ZGngpn9ehSgegm
         A5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLiEc02j2n070D9V7w/ycXMI5G0uyTDhPnqX7TQgIuN5O0Li1dr49a6qM2Djigkig8SVRRARj8h1cvcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKTqoyOlalotAp/o998KpEgG1v/raP0DjQcw/MeML5OlhSg7X
	Km+eRiLRlFaNgzirR+Sa51PaWGR9hjcdJXVq8c7c3MDHuWH2q/yIS4T+35J+eKvFqs+8jA==
X-Google-Smtp-Source: AGHT+IG4FbKF5lZcEtqGPqnIQxBy+JAMjt/FHT9Q7WKxQzYxhBcEObiD+4vqZqlbWcqkb3tdnnRv+mAh
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a17:90a:8c07:b0:2e9:9234:2db7 with SMTP id
 98e67ed59e1d1-2e992342e5dmr29009a91.1.1730941113839; Wed, 06 Nov 2024
 16:58:33 -0800 (PST)
Date: Thu,  7 Nov 2024 00:58:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107005831.15434-1-elsk@google.com>
Subject: [PATCH v1] kheaders: prevent `find` from seeing perl temp files
From: HONG Yifan <elsk@google.com>
To: enh@google.com, ccross@google.com, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthias Maennich <maennich@google.com>
Cc: HONG Yifan <elsk@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Symptom:

The command

    find ... | xargs ... perl -i

occasionally triggers error messages like the following, with the build
still succeeding:

    Can't open <redacted>/kernel/.tmp_cpio_dir/include/dt-bindings/clock/XXNX4nW9: No such file or directory.

Analysis:

With strace, the root cause has been identified to be `perl -i` creating
temporary files inside $cpio_dir, which causes `find` to see the
temporary files and emit the names. `find` is likely implemented with
readdir. POSIX `readdir` says:

    If a file is removed from or added to the directory after the most
    recent call to opendir() or rewinddir(), whether a subsequent call
    to readdir() returns an entry for that file is unspecified.

So if the libc that `find` links against choose to return that entry
in readdir(), a possible sequence of events is the following:

1. find emits foo.h
2. xargs executes `perl -i foo.h`
3. perl (pid=100) creates temporary file `XXXXXXXX`
4. find sees file `XXXXXXXX` and emit it
5. PID 100 exits, cleaning up the temporary file `XXXXXXXX`
6. xargs executes `perl -i XXXXXXXX`
7. perl (pid=200) tries to read the file, but it doesn't exist any more.

... triggering the error message.

One can reproduce the bug with the following command (assuming PWD
contains the list of headers in kheaders.tar.xz)

    for i in $(seq 100); do
        find -type f -print0 |
            xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;';
    done

With a `find` linking against musl libc, the error message is emitted
6/100 times.

The fix:

This change modifies the command so `find` only emits .h names, thereby
skipping the temporary files. Another possible fix would be to store
the results of `find` before feeding them into xargs; I didn't take this
approach because the current approach appears marginally more optimized
and involves a smaller change.

Signed-off-by: HONG Yifan <elsk@google.com>
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 383fd43ac612..271e0145f406 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -84,7 +84,7 @@ for f in $dir_list;
 done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
 
 # Remove comments except SDPX lines
-find $cpio_dir -type f -print0 |
+find $cpio_dir -type f -name '*.h' -print0 |
 	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
 
 # Create archive and try to normalize metadata for reproducibility.
-- 
2.47.0.199.ga7371fff76-goog


