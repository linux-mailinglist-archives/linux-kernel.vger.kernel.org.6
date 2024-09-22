Return-Path: <linux-kernel+bounces-335316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2797E40F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A271C20F72
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1867B3FE;
	Sun, 22 Sep 2024 22:24:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C0BA27
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043864; cv=none; b=Y7dtQz5zogshb6BIvAtDya0zNNlku8m2hP9p8IobK6/VlISf/Yw3LrBijilMk8MVb+7w2/0sbr4KyYkohfopykNKX2O9N/7xuAVZGSySsNx8z8dKsGhCrTCOx0auGn4Vp9+z2sKMZrOSSDV5DLMK2viyXF3wWb2ARE2paW4USyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043864; c=relaxed/simple;
	bh=p0RP+qvpCQafS8G29s8Ao9cJrk8SLU+JGvaq7RStRgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q9opc+2WHw0KI/167xrJjtTmk0VecWuHf0Dii0NrlJiAvLZsOd/nHZ1gcFe35fpgSRcvlmCDUyHcMebljOgpT2bJJ/5pkJJIl6E3xM9saLIflTP0ogq94JD5+ItzlYP/pfRbzsb5yUuspyhuRmEsrX7pAYYE0aoCR7rvhV0FKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a05311890bso46144105ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043862; x=1727648662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoeJShUhpVHo/VuBccx7J1TwhGANTRRBcaMENLA9OE0=;
        b=te3nspyNEgLEmmxysy+vbnrRkVRpopBkLakX2ed/uDU4w1uuoWyEN/vmLaVMtamkvr
         Hx/LkjoIILIL/s1H3+SHWl1AXllAxa74AwAa+4zsh+qc4vBQGDTIJkpZHv8Zj4c22u70
         Rsb1AsIi+eE7pwI46zG7SKWpjVdPTFFEvbXhOJy3tQJanBpfbruQWhyjKQUooLk/tRhO
         9fKNvdeUPAdg6RpdPizVMsCI2I7FHkDFtko2KM+28EJbJ0MOOCth1mPb6qyIYUTNr24R
         GC7opqnHybM1I4CKf7cSy4mtgweSimSL0fbi3gyKCp8GnirSU6nmYaxm7o2VBRs2r26M
         h/bg==
X-Gm-Message-State: AOJu0YwXn/9yFkOMkCyJjH+oHs0gF8/qUHiIM3fv4g94QMhpSyyDk1bQ
	+w3fByesoc3Yyvp3btARSodWgAsaGFkcWpp/SRhGRPNyDxNFuEFyYk4srx0fHaPbNdIg9mhoZWa
	nRu2FX4VE6g+ddcn11e5GRxtjatQeQ2U7WoN1LGfe2S34MB5LqRk2iV8=
X-Google-Smtp-Source: AGHT+IHxNiLaHfjz4SOt+Ak8v5AL1vzjEkf8Mm4T97mg5FgFvxL79EcGgghfVXDD9Z0Ye3lI5uElPUhlA+T8Rcw/Nht3OuvOcZtP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a0:8eb3:5160 with SMTP id
 e9e14a558f8ab-3a0c8cf65a8mr91167835ab.11.1727043861876; Sun, 22 Sep 2024
 15:24:21 -0700 (PDT)
Date: Sun, 22 Sep 2024 15:24:21 -0700
In-Reply-To: <66ec9a7d.050a0220.29194.004a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f09915.050a0220.3195df.009e.GAE@google.com>
Subject: Re: [syzbot] [PATCH] bcachefs: replace function div_u64 with
 div64_u64s to use 64 bit divisor
From: syzbot <syzbot+24beef64217854da05a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bcachefs: replace function div_u64 with div64_u64s to use 64 bit divisor
Author: dennis.lamerice@gmail.com

Sending again because it seems like I added weird spacing which the syzbot
didn't pick up.

#syz test

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 fs/bcachefs/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 1b8554460af4..cea162b99864 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -64,7 +64,7 @@ static int bch2_pow(u64 n, u64 p, u64 *res)
 	*res = 1;
 
 	while (p--) {
-		if (*res > div_u64(U64_MAX, n))
+		if (*res > div64_u64(U64_MAX, n))
 			return -ERANGE;
 		*res *= n;
 	}
@@ -140,14 +140,14 @@ static int __bch2_strtou64_h(const char *cp, u64 *res)
 
 	parse_or_ret(cp, parse_unit_suffix(cp, &b));
 
-	if (v > div_u64(U64_MAX, b))
+	if (v > div64_u64(U64_MAX, b))
 		return -ERANGE;
 	v *= b;
 
-	if (f_n > div_u64(U64_MAX, b))
+	if (f_n > div64_u64(U64_MAX, b))
 		return -ERANGE;
 
-	f_n = div_u64(f_n * b, f_d);
+	f_n = div64_u64(f_n * b, f_d);
 	if (v + f_n < v)
 		return -ERANGE;
 	v += f_n;
@@ -360,7 +360,7 @@ void bch2_pr_time_units(struct printbuf *out, u64 ns)
 {
 	const struct time_unit *u = bch2_pick_time_units(ns);
 
-	prt_printf(out, "%llu %s", div_u64(ns, u->nsecs), u->name);
+	prt_printf(out, "%llu %s", div64_u64(ns, u->nsecs), u->name);
 }
 
 static void bch2_pr_time_units_aligned(struct printbuf *out, u64 ns)
@@ -477,7 +477,7 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
 			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
 
 			u64 q = max(quantiles->entries[i].m, last_q);
-			prt_printf(out, "%llu ", div_u64(q, u->nsecs));
+			prt_printf(out, "%llu ", div64_u64(q, u->nsecs));
 			if (is_last)
 				prt_newline(out);
 			last_q = q;
@@ -511,7 +511,7 @@ void bch2_ratelimit_increment(struct bch_ratelimit *d, u64 done)
 {
 	u64 now = local_clock();
 
-	d->next += div_u64(done * NSEC_PER_SEC, d->rate);
+	d->next += div64_u64(done * NSEC_PER_SEC, d->rate);
 
 	if (time_before64(now + NSEC_PER_SEC, d->next))
 		d->next = now + NSEC_PER_SEC;
-- 
2.46.1


