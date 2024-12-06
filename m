Return-Path: <linux-kernel+bounces-434093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BD69E618C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4936918852BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7581CDA15;
	Fri,  6 Dec 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UML7nSbS"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493C1D54D6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443222; cv=none; b=e6+ittP4AzCSitrBXgtZtNbg8mz9Qqv/Qmn5g8JYDSetoOFFc7KjRNJhVkz0X1e/KP5+f5TX6zpnMCZ3I3jMC8JHmRviujXy6P2jT+3Q71Qz1nRbtT0Lg6DhDBfDz5Ox5ES9EfE5gfJvjCCHs3phe4vK5YLvoV5VVP8oC5lzuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443222; c=relaxed/simple;
	bh=L/trRsiYTSIwUEykX2awa92KDUkkNy4kOCmbn9K1kG8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=SObcxPkXWapir5+Nwc9k5Eifai0iyE97T2MwV9oiXEelKrKE0rDbXZkPQCgbrNvbBR6JEoXtwBU9gLJ0peC8B/COthDi3v0ru5tl0MXDiTtqp+s+9sqdfV1CO8DG4R8Rg1fP2TECScQTY5GdV3hClAAR69Uz8NJdymC62PEYAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UML7nSbS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd097721caso1875630a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443220; x=1734048020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kI5LS/EqpIdkgQTXJwnJxCQHfGQwplQh7VfUNRXEbrs=;
        b=UML7nSbSy7eCh5mqxYcwq8NWqNjAslX8SUFh/CBlcFfZSj9IHh+b0bweW6Fa1nGsrU
         dTu48D/jgh653E0wMg1c7dwJtV6untA2NhkrMF5a0S9Q1Ja+v56n0Pwf2vWf2cb3f2FS
         wIeEhODt4GZlnTvcCCr9kdyLoWEkSGkS0gnZ7Mo25t6p9UEi2W31Fmrd4B9YkAFT5Zcm
         9Gh7TG1POskoBPuUpIClPh4arpXwvnEuXi8FJqye2Q5B9ioyJdNMH3kTRVRYRJZBO6nH
         IzWFHsHTWLpF2iUueUweTILeE5tp5jfMhEJgiwiK87O1Fg3BgmBaqxctX5CeOC6t04iw
         DXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443220; x=1734048020;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI5LS/EqpIdkgQTXJwnJxCQHfGQwplQh7VfUNRXEbrs=;
        b=vbfjjw/3buFCcGi3u95Hb6k2dDTOWWxoNhhmkzHDttSqquBsoM4VTMgZGTjMAbD3LU
         JOkIfLyM0W9xzcuN9wBavZzMoc79hmVrQXPsS045iTWbFJtCkvsqFUlxXbr7PcLHWtUa
         lnpA5idPFoo829r0zSyQBuJuzMmY20Y8v8dRx72OMO1yNjxr/QlOOJkGIRkxqJ26PB2B
         v04pXvIOgK8vPGMlCcz/BLHxl7AzUBj49NuYIvqgPwx3CyEpZXyvcDpDxvulykQ/0bQK
         vdy5Muucxc9ldNLNeWBSzfP4ea1fbx8YchcuJa45cANUfj1b88bPC4mRYrk3idU8FlzE
         e2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUiOVgubdWoAY5hda7xSR+lVULH6dJllEw0Vr1SNWgPYje/1cvRrq7WCUShcetA8ASEpbx9RNbh7+U02jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxVJ0CcYiA9Eu74FI7+516HaAj6y8fPv++kP8d0AopCXrQPcN
	MhZm/ld73GLe5UHe5RvuJUK3fZ+1y2XC+rBMR0YJ26feAhlxKV2B4f9x1Hu3Mf68VrLd1Q==
X-Google-Smtp-Source: AGHT+IF4Gg+RuFCA/+SlXEjGQMgqzGLogetJtXXTcf3vWVJQ8NVn18sdZuqBoto6tEi2wjAaaoVcAQUn
X-Received: from pgbdk11.prod.google.com ([2002:a05:6a02:c8b:b0:7fb:8dc7:e915])
 (user=elsk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7893:b0:1d9:c615:944f
 with SMTP id adf61e73a8af0-1e1870bb8femr1711008637.11.1733443220418; Thu, 05
 Dec 2024 16:00:20 -0800 (PST)
Date: Fri,  6 Dec 2024 00:00:04 +0000
In-Reply-To: CAABy=s2i2u_KtqwP1GVZkEB7WVF1dsu1_r3uFm8eZMM_3kybBA@mail.gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206000012.440827-1-elsk@google.com>
Subject: [PATCH v2] kheaders: prevent `find` from seeing perl temp files
From: HONG Yifan <elsk@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthias Maennich <maennich@google.com>
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

This change store the results of `find` before feeding them into xargs.
find and xargs will no longer be able to see temporary files that perl
creates after this change.

Signed-off-by: HONG Yifan <elsk@google.com>
---
v2 <- v1: change from `find *.h | xargs perl` to
    `find > file; cat file | xargs perl` because Masahiro discovered that the
    approach in v1 still causes find to see temporary files. The new approach
    is more robust.
v1: https://lore.kernel.org/all/20241107005831.15434-1-elsk@google.com/

 kernel/gen_kheaders.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 7e1340da5aca..4d70e6377da5 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -84,8 +84,12 @@ for f in $dir_list;
 done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1

 # Remove comments except SDPX lines
-find $cpio_dir -type f -print0 |
+# Use a temporary file to store directory contents to prevent find/xargs from
+# seeing temporary files created by perl.
+find $cpio_dir -type f -print0 > "${cpio_dir}.contents.txt"
+cat "${cpio_dir}.contents.txt" | \
 	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
+rm -f "${cpio_dir}.contents.txt"

 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
--
2.47.0.338.g60cca15819-goog


