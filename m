Return-Path: <linux-kernel+bounces-433914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A979E5EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE871885409
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4D22B8CF;
	Thu,  5 Dec 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dWF3sTNz"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8191224B0F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426459; cv=none; b=C3u53KPHjV9Q3b+cKSfv78DsVPaib9e1NloIIJ37y/RK/yqs/ph0Cz56stufJnjVgaOGC6l0vQoTMW0zeXWPllR/be70lQEMhoPOizAbPuYznKwbIZ14orIaZq3q1fBBaZW8wI7fzqd9A5O4qF0xJZCCUSATWF8KFD+lV8+eDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426459; c=relaxed/simple;
	bh=UhG2+qRp1QGdoBJFxjJn/SiDilmXPiAbureWp/ugTQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S7szWmFNRm+tjaC6YKGogoZCJWWyquYCAzZEdoG7fr8fFWIBiXhyj4kD/MkDwzY4jocjht8mzCf4BWJwJhbBDSEOSvpVcNb2Rk0S3KTU3JfRQfZFg6y5beaXjqJvawixHubZ19iFurZ0srXb8VTixacHQd2OHExu3GwhM15gh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dWF3sTNz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so593171f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733426455; x=1734031255; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KG5d4/bI+0hCDCr7rk6eq8R+9Ulgafy5ATIvCrtRl9Q=;
        b=dWF3sTNzPYB7P+/RPHLZNf71DxkvuEL8xTRxNyHLAUJxLzce0ANpyQFh8ha2cfwaOn
         nnxm2UK3KgOzyeXz3zSG0aX+nbEVtTtGw98fNm9uu/1nBXhkP8mD3zZ3hxMxEMKrEb8R
         jYjHbcNm8aL45YPbAdNteoGW4/9+MKCZua5+ot/Siw71x5cWXadF6McQXZofSVimZzjM
         nYudUqk9SkpVwLHysrcaacFrmfVqpXqRfoI8BICGxwmBBlKBQnQZ50D/VMbSterO2jLw
         LskCHAgUoiHiYLQfCXhFIgN3/kSTmda7qQlKK/3usSQIiIOfnzW2WpqD2MmXNmHrBd+N
         lvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426455; x=1734031255;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG5d4/bI+0hCDCr7rk6eq8R+9Ulgafy5ATIvCrtRl9Q=;
        b=sjvrGwD6DNOVlign7DhoankLDL+T7xz521PiE3j9k6BQgucXYL/RbbaZwJJKK99Glr
         1rwoPZLZ6rM/RDputbcLQQq3yUsBKPNcmhA/b9bik1OtHwOlfoeYFZhOBxxAa5Hbrzr3
         LBJaCWnlO7pZDdEi9HM2Ss6zjSMKu1tyP4zx9CpGfy7Nkjg/rIlKwyp02EV9POKL5Ioa
         k7tc3OaiyC+odzsRt3FrcBl3Xv89XoMwQqLP7UlJQ9ugDq0gcVZ6j6LdsKSuTm/8xqTn
         h44o978fYbvIIw+1U+Fv2Hf198gBzBrD3huQoO3eWRZfUxR+/CUd84XjS6blpcVYdXRT
         1Kcg==
X-Gm-Message-State: AOJu0YzBaMqM2jdiLKSiHEk3kHHQgJTeGXcjrjL/cQ9UjEVrnAYhTNaw
	Qb/PlgIG4bR4wPFOwGOW+WCzOgJgoqPNjkybEHBLk4eG+AyObb/kGBC8/kyUwDjfJPhLFj7Nu9D
	N
X-Gm-Gg: ASbGnctRQEXSg6nhXgF5KFGac8H9nT+aUYVjmIKNg4u2MZGmUSZ2xXthKkeCVvjKRT+
	OG6Vbd9/GHkLh6enG0HmhtHbMI0eVAcw3kz/XKLSdKMiJTRTZ76dzj5FFXLjAMvxry8hTiQH5tG
	N1D8nF3ekWulmL1heGh9AuwbqrU4hKk1I25Cxvl8JHi+bEuxpiMedKhwg19dfedmSua7ga1G183
	XPMna1J9fUIeesgUgGsr+I0MCxRsfml0f5ArQ==
X-Google-Smtp-Source: AGHT+IG5UYk36DyaDuSWNnOub1oo2AiabwSYJ0BdhQMzpxoiQdTduICOEEbrjUemUO4+pzeU/RQ+2A==
X-Received: by 2002:adf:e18d:0:b0:386:1cf9:b993 with SMTP id ffacd0b85a97d-3862b368d56mr255768f8f.26.1733426455118;
        Thu, 05 Dec 2024 11:20:55 -0800 (PST)
Received: from localhost ([152.250.153.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b0fsm3634600a91.36.2024.12.05.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:20:54 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Thu, 05 Dec 2024 16:20:50 -0300
Subject: [PATCH] ktest: Check kernelrelease return in get_version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ktest_kver_fallback-v1-1-8029b9189527@suse.com>
X-B4-Tracking: v=1; b=H4sIABH9UWcC/x3MQQqAIBBA0avErBNqqJCuEiGWYw2KhUoE0d2Tl
 m/x/wOJIlOCsXog0sWJj1DQ1hWsuw4bCTbFgA12LTa9cJlSVu6iqKz2ftGrE6ZDGtAu0kgJpTw
 jWb7/6zS/7wf2X94lZQAAAA==
X-Change-ID: 20241205-ktest_kver_fallback-d42e62fb8d88
To: Steven Rostedt <rostedt@goodmis.org>, 
 John Hawley <warthog9@eaglescrag.net>
Cc: linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=rbm@suse.com;
 h=from:subject:message-id; bh=UhG2+qRp1QGdoBJFxjJn/SiDilmXPiAbureWp/ugTQU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnUf0UVY8LmahaC7x/0GI182sXcEqxbFCUUb5T8
 M3Jj+g8zg6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1H9FAAKCRDJC4p8Y4ZY
 pqMiD/9KgB5jC9ERUC/5L63fAD3apTQdR6lpTVZFGw8ndPeAQZwYW/n/6kAjeAL5My6Pw2pL3AR
 RzMKNDZrYuNX7WSVHoLRnIU+Nydcq//BrXQbq1KMCW3OpWqiaQT+Hig9MDz4NIfFdIQ11q1fSdi
 ojRPke58Wbk/4iLxFxSNJ/aE8qR7fjfDBzkei/Kq4rUDx7XJTnXpV5sfs+5wNKbnN+UXdCkVDrq
 Je0eKNnB4ikRCq3aTh1N0F451ZxUTCLcgzJV0lXZ0dtcJv05Yi/tgKayIX3la3gVdi9rMqKPNvo
 NEzb3Fd9ezb9qLlLr9Bb4/AnxEZGtC2ieVBGQMboJLn+mAFX0Xnm7lYvJwwQeK6atDhnJ235kNH
 PkyQMvKGVQEOALqi5qJqSOz0GjaO9OvOeDt0oqmniYzDRNZs1XsGneEDxyLBCdvEMnnEqTzavch
 lCJxo3/TSnfNtFOL10IqVEx1m4MWDRdN3F8X8C0+BTJMpOE9Ff3gC8mtEg7S+CuqKU9t1LOkrUY
 tb1y3cW7RRCBpFErtd6ke21WdzUt3EqqGbUY1/LzRaCTWyFVkV5Sc8nW9Su9evlIvpT29YPFTSy
 2BJC876Xa2FKYdRk9XOOukAf2sxdQedTdb9PC4XfEXai3odtLvjsScMCFZBq4trZhJdtdOcQVhZ
 JOOqu/4q0OBWMEg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

In the case of a test that uses the special option ${KERNEL_VERSION} in one
of its settings but has no configuration available in ${OUTPUT_DIR}, for
example if it's a new empty directory, then the `make kernelrelease` call
will fail and the subroutine will chomp an empty string, silently. Fix that
by adding an empty configuration and retrying.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Hi! I'm not sure if this is the best fix, but here's the gist of the
problem:

If the test has something like:
POST_BUILD = echo ${KERNEL_VERSION}

Then the option will be evaluated in __eval_option which calls get_version
before there's any configuration within ${OUTPUT_DIR}. Like if the
following happened:

16:08:09 rbmarliere@opensuse ~/src/linux/kernel/master master
$ git clean -fdx
Removing build/
16:08:13 rbmarliere@opensuse ~/src/linux/kernel/master master
$ make O=build/ kernelrelease
make[1]: Entering directory '~/src/linux/kernel/master/build'
~/src/linux/kernel/master/Makefile:777: include/config/auto.conf: No such file or directory
make[1]: *** [~/src/linux/kernel/master/Makefile:251: __sub-make] Error 2
make[1]: Leaving directory '~/src/linux/kernel/master/build'
make: *** [Makefile:251: __sub-make] Error 2
---
 tools/testing/ktest/ktest.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be42a86f9680fcb50b65d1f3a78afb5..a57b6cb9d817e2a3351a64de96092bd47733f5e3 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2419,6 +2419,11 @@ sub get_version {
     return if ($have_version);
     doprint "$make kernelrelease ... ";
     $version = `$make -s kernelrelease | tail -1`;
+    if (!$version) {
+	run_command "$make allnoconfig" or return 0;
+	doprint "$make kernelrelease ... ";
+	$version = `$make -s kernelrelease | tail -1`;
+    }
     chomp($version);
     doprint "$version\n";
     $have_version = 1;

---
base-commit: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
change-id: 20241205-ktest_kver_fallback-d42e62fb8d88

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


