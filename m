Return-Path: <linux-kernel+bounces-565415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB70A667AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74D8422E63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DE1ADC90;
	Tue, 18 Mar 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJfilUFh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ACC2114
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269397; cv=none; b=BYkWyuM+LpjJieJPYKZG0rom+LdE8Vb3RQqrefpEvXtkxsMkAVlrsKV6k0BZuak/Xsv0hke+LJ5SAFemaaqim15bC+CKA78MkpYJXw2DqLLziNa1K11gDzeG+z1JUGX7u639F/EgFnrRcSR+t7cS5xYyNB9c+pL4Vmpmt7uh4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269397; c=relaxed/simple;
	bh=zC4lcP2V4IiIPxr9JpgDGjzM2a58MVUtBq6gOOCS1H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGFdhwsaDq6ckYMk8ukpDUz+gaCRRN4GTJUVzZ8vGogxwaukatXWEZA6K+1R7tX6rOg5D1xW0SaPjhjhEc/vKTU3Z5ziamyMqQDUu8yNJHGvnCEEjBKchWBP5RtrVmQsDmMLJ6cfHLKQtvQuO5wb7mJbZGZ7tBY1AyakJSJrlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJfilUFh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso67953715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742269394; x=1742874194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbe7RI1DhdJmmq13I+ma0flbSEXGJRuSSXWMj76ljDs=;
        b=aJfilUFhClfaSBr7ZEFukmpuIgeFYtvompvDDhxEbskCGQvUifgYHTBtjDGvnzpoCx
         5VR1VecFHPt8uTA8+170+mCnbgHMatwxDuTVKOVgnNJweC/U5FfOnBSCJgotu1g0oEmp
         mYB9x5v3IGox9bYUuQWwpVVgg8R5rtXfdk5OBlbLfNFQmcv+alED00m/pXYFeJslTaMv
         KIgrkofObAfXZOWB1RO5Nyekpi8KBEHyQFDzjKqXWpRtsAy+knEURt88+gaHGUnVh7Uc
         6Ne9qByVinmZublq7ttK37IGZH4qUyBb5vtVUsUojnEod9Sc9D57yx9d+jTiQetBEgKM
         FrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742269394; x=1742874194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbe7RI1DhdJmmq13I+ma0flbSEXGJRuSSXWMj76ljDs=;
        b=anu7XTkyvsMb2iNaPP9F+hGi6BiynkaR7crYxPMJwTojzr35shqV96UkhUwptGaSIc
         +eGTu2n+FW6njTjepOB4sXikEI+Ec5b1NwvErp9fo7K4IZikELLYCsecbYLWmQrKZ/TT
         3BTXZZpG12yRgJkIRrZ3mQ3wiEOjBDj+551xBybrfHcwRG3i/SEvdxUZoQGvaC9yqen1
         /vvmjBTLXlcEaE5rQ1Bln1cd9Dm0pvNG/IVl6IoG7V27KbaB3qJW/BBPQhgXLoZykIDw
         76327MKbKUMN6tgtPbYtUwH5vwt8fp3uvqSs4K0t1zMw0T0bmy/P90RFASMfskOZnq5P
         976A==
X-Gm-Message-State: AOJu0YyVu6l+HEtRZx6FzpkAvb5/E2Wj3yqs6b4/KpkDjsHfqWTjlycs
	7iwxwqSItruKH2zN62gM9OuLc9M4emCr4M0w8eHR8cPm/Q6CEWHm
X-Gm-Gg: ASbGncvN5sWV/so5j2SkZtKmKYVqh5h9vRGjUv8CNqSna/c1UVXzwqWcWGd7bJICBqU
	qqEFX4GUJ3ws2zmh0wlJQOHgZoyUyH2ZUCIKxaPatRh3TNCeIRDZ7GsnegSEbQ6+UQ3G9x5V/My
	Qskiviryrp+2LckKD7V4f9nmh2JwDbE9apy8YHFjPT95NkY4Y/NdKf0ZGMygpPoD3M1t04by1fz
	8wseKmyCjR+HjjdyU5W3daUs+n90jW9maPdN/Z01Hpi9FO19F1gVebe2nEgoq69p1Q8AxKNSpzX
	7yJsS6YT4B7syfqipsi3wHcDDkKLUGbtT2uLRGjT3trdcIWxgIZTccKAKO0m3g0B6B1st3L8
X-Google-Smtp-Source: AGHT+IFJQn/cOgw7EyLdb6WHd/Ewe8xwoPRaksNngkE4NI4fE8kg9IuFUAmiQpsXkIZKRDFRr5FG5g==
X-Received: by 2002:a05:6a00:928c:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-73757794828mr2545778b3a.5.1742269394341;
        Mon, 17 Mar 2025 20:43:14 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:86b4:46:3f1e:43bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737113d71fbsm8407612b3a.0.2025.03.17.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:43:13 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] fat: Refactor fat_tolower with branchless implementation
Date: Tue, 18 Mar 2025 11:43:09 +0800
Message-ID: <20250318034309.920866-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Elimate the need of if-else branch within fat_tolower, replace it with a
branchless bitwise operation. This can reduce the number of branch ~130
regarding to the test script[1].

Test size can also be reduced:
$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-68 (-68)
Function                                     old     new   delta
fat_parse_short                             1901    1833     -68
Total: Before=22471023, After=22470955, chg -0.00%

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
[1]:
static inline unsigned char old_tolower(unsigned char c)
{
    return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
}

static inline unsigned char new_tolower(unsigned char c)
{
    return c | 0x20;
}

int main(void) {
    for (unsigned char i = 0; i < 26; i++) {
        if (old_tolower('a' + i) != old_tolower('A' + i))
            return 1;
    }

    return 0;
}

Utilize perf to profile the difference when using old_tolower() and
new_tolower().

$ perf stat -e branches,branch-misses --repeat 100 ./old

 Performance counter stats for './old':

            2,6302      branches:u
              2334      branch-misses:u

       0.000754710 seconds time elapsed

       0.000000000 seconds user
       0.000804000 seconds sys

$ perf stat -e branches,branch-misses --repeat 100 ./new

 Performance counter stats for './main':

            2,6172      branches:u
              2338      branch-misses:u

       0.000782670 seconds time elapsed

       0.000853000 seconds user
       0.000000000 seconds sys

Best regards,
I Hsin Cheng
---
 fs/fat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..77d212b4d4db 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -35,7 +35,7 @@
 
 static inline unsigned char fat_tolower(unsigned char c)
 {
-	return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
+	return c | 0x20;
 }
 
 static inline loff_t fat_make_i_pos(struct super_block *sb,
-- 
2.43.0


