Return-Path: <linux-kernel+bounces-255657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825DF934357
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8D4281CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5731849C4;
	Wed, 17 Jul 2024 20:43:55 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB51CAA6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249035; cv=none; b=ROF5mb4cThndhn64gw+driEYvRe/PF0ESCoas2scwYMD8ihGRVBcM2jmmmGs3fMmG4Da0mvkuHSGylXkXsmpHsGxr6Sr2VLMqL+XQ24EaFV4qohXF1lCVeoIUEiUKg+WPdVxAYeVWd+/BP62mYs8HxmASc05FJqY29rsnvPCe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249035; c=relaxed/simple;
	bh=iVXmB6YrVENZMLXDuu5cPYEF8gKKsjFQMakRGFE6dGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tU1TJaOr5irRS/iVJqm1YSKQ2v73NA4G5uco9H3BZ8gQ9DI6cCxmQlxBdZW4ku/PK93UP30RF8fCUekWI5bv9mFt3EgrnSDS5MKEMDX8bFiv5BXoO2xgdU7AdpgTfvMFBWaU5I75bWJr3RIgkws63y+FVGDO4ESuRoYsMh7G/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37715eaa486so545105ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721249033; x=1721853833;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbJ2EIQT4oikVjfi6q2SJ3LCIyOpSABsdATxXFzpenw=;
        b=puG1H/5hGzAy8tit+Je7gRe56U6JYjbihkUxeS9Q/pdabA479sX5npnUC2CVo8/EQj
         c4oPwDZbpHjD/vd6y8JXPWYKX8awZdnt6l3iScwrWBu4mA/MaZz2qL+hRoeu3bKDkjJ2
         40OQHwuqxEZOXo2q9cc2aDSBUXA+IE40WRrteHZ/KZEmHj36WqQOLExJpyKm/OA3B3sz
         YgXX/w01U3V+eGW1Xm2FX2/BiBjmGKdH2TtY4qygHj6Ud6w8ksifQQ4MqBFfkbjhP1k1
         iNKbCjKAV2XX2V5LAkcNlAdLl3ryoVAtkEywNeLH97gV5SK/FMCCv1Lk89S1aQXndFOH
         9ykw==
X-Gm-Message-State: AOJu0YwFPVzO/3O9hADxEdrO9gtaxIunk6yszqaq4nh0BBcmE4UyVz7v
	n7DflLE8k4iaf2oihrNTtbThjHz1W54pTwJbgIoNA3ALgKyTl09cJ6WHX7EVFJspjOYZrtYCqoh
	Auw2L2eXqpux7i1uljqMHR6Erwb9PA3HpX5FlmDYc3pF00pcL+c0uowA=
X-Google-Smtp-Source: AGHT+IHotuBshogsd8ztEwEwb8/0gTWedzByZnk14Wluz9tAOd6w3JOrp5UOSB39eCfW0BUj8XVp6KaPnd1vlmopQouA3o2635w0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-39558956168mr2414115ab.6.1721249032856; Wed, 17 Jul 2024
 13:43:52 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:43:52 -0700
In-Reply-To: <000000000000e4d9eb061d719657@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c7ba5061d7785a7@google.com>
Subject: Re: [syzbot] [PATCH] Fix general protection fault in bch2_checksum
From: syzbot <syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Fix general protection fault in bch2_checksum
Author: cam.alvarez.i@gmail.com

#syz test 
Checksum for types BCH_CSUM_chacha20_poly1305_80 and
BCH_CSUM_chacha20_poly1305_128 are only computed when c is not NULL
because they require the chacha20 cypher stored in c

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/checksum.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
index 3bd3aba90d8f..77b29c73d7a0 100644
--- a/fs/bcachefs/checksum.c
+++ b/fs/bcachefs/checksum.c
@@ -220,10 +220,11 @@ struct bch_csum bch2_checksum(struct bch_fs *c, unsigned type,
 
 	case BCH_CSUM_chacha20_poly1305_80:
 	case BCH_CSUM_chacha20_poly1305_128: {
+		struct bch_csum ret = { 0 };
+		if (!c)
+			return ret;
 		SHASH_DESC_ON_STACK(desc, c->poly1305);
 		u8 digest[POLY1305_DIGEST_SIZE];
-		struct bch_csum ret = { 0 };
-
 		gen_poly_key(c, desc, nonce);
 
 		crypto_shash_update(desc, data, len);
-- 
2.34.1


