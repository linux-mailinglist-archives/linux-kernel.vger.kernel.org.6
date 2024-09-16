Return-Path: <linux-kernel+bounces-331113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E897A899
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D01428438B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F315D5B9;
	Mon, 16 Sep 2024 21:11:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83A1311A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521089; cv=none; b=g3sRfiVg+ZIg32+dyfgyglqttuFTZp4JCHwIU6szi8q64Nr6h5MlkVtBYSCaEfmVAsZg7S4qN3xFGqdyaA956IsO+erEcvKmNxBVb8YQ6LPsdcexUuX0Kpc4W+Aq0vc46zDoh3sAJXiuIVZyRl1274bbvXLL6NNdWTvrmcR4YFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521089; c=relaxed/simple;
	bh=jmSfuEUrhwC9qpHMi284UmCTPB4qm0jn2YlcQYS7kCU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LNgIbn/nTCltovfeb0sCR7JBw+6CJy9Tj+wPkMWss2cRi0n52A47355fEopbdg0sRU+ENrMZLScoA0o1fkUppgrzND9ue8xLpm/OREKu4/sYM5h8KbkM658RgrtwTPQPlzWl+SBjQnPTW6KJI5o7l5Eejioza03oA6GJzs4kxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d094a0010so944433239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521087; x=1727125887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5N4uYf6s+LXUZlbqPJ7hWffiKAAz+jotJCGePBHdRY=;
        b=NxzqLer8zuBKVruuqK/OeIlunxnLilLwORT91ZM83P57fwe0wbKmPq9nNWwt8dgdgD
         /xbzFgTZMcmMliqxcdENnGLpEGvtYrgjhhLBjegKTDwBI+2XPt7bRhj6fWsYZHEvkcUj
         h29K+CCN1KopD+illhooVXTkMDPSmG4Tnb81A5pp2o/lX6JbvjwirXqAtN8AcHtT5h4G
         9vQvHajixDGuL1EeE7cTA6NQI4Ii3YnsUE35xltPh20tuRjzmsGNUhfQpw8aNm2uD0qP
         OBGZs7LZ/+im4DjP4Ut8iniRvARF6/qRxHOCKeDveM63WvvC5oaeiafGFJ8O/ntvWCy3
         bHPg==
X-Gm-Message-State: AOJu0YyO9D2rLCPBrXGps7twJ0+UdCbF2QKT4Ur9oi4GFtb61obh5NWu
	afA9OWoKDwEbM5YZVptd6O7orqzwlOzBtCXs62UqSkqTlJhYJaR/WhonLIcQZrHclFw5aSS4r7Q
	lg+2o60mpnnaUvmSgxyjMFs0CvWdMTSr6GckwqBSgsWurpFUuWwXCXz0=
X-Google-Smtp-Source: AGHT+IGRDcy+dK6UmYkLW/UYbTq/fgiWZv8b8ObTcjcptIJuuSiUERCjPh/pSax3hdg0VcwXBvxMpmu8bNlIdnG+e13HzyHyltsH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340b:b0:82d:16a3:55b3 with SMTP id
 ca18e2360f4ac-82d1f98b004mr1654979239f.10.1726521087009; Mon, 16 Sep 2024
 14:11:27 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:11:26 -0700
In-Reply-To: <000000000000b5ca0f06223dc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016ba66062243042e@google.com>
Subject: Re: [syzbot] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in prt_str
Author: djahchankoike@gmail.com

#syz test

syzbot reported a null ptr deref when printing mount options [1].

This happens because syzbot can pass options such as ',appraise,'
with no value associated with it, since it is a unknown option and
is not in the 'noopt' form it does not check for null values.
Change so that unknown options with invalid values are reported.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/bcachefs/opts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index e10fc1da71b1..1ccaed5c340b 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -482,6 +482,10 @@ int bch2_parse_one_mount_opt(struct bch_fs *c, struct bch_opts *opts,
 		val = "0";
 	}
 
+	/* Unknown options with invalid values are reported */
+	if (id < 0 && !val)
+		goto bad_val;
+
 	/* Unknown options are ignored: */
 	if (id < 0)
 		return 0;
-- 
2.43.0


