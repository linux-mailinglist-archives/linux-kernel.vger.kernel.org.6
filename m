Return-Path: <linux-kernel+bounces-252402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF89312A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F14284523
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8D1891AE;
	Mon, 15 Jul 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sJ7Musss"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7418411C;
	Mon, 15 Jul 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040735; cv=none; b=lVohwsu2Rr7Vg5vF/mVaXqt/UrhdXSjBvFQuxQYA8/1UHWHbx6T+J+tSJf2l2oiRrDQx1BcbqFv3ESihfkCTSxeqbX0BigLVaiLPlfEQqYjZLuHL9mr0I20GR9x065DRIPBtLDwrp1LEJKU8jBlWMATJArR+bFjqFR6oOD6o/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040735; c=relaxed/simple;
	bh=0ffIqFMhgd62MRjku7YOL5+9xOlnOuR2WZLZmX447b0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ibtroRXX7lfSzTTAo+xPQtmVXbixoszwCSQT19gMb2e+l+TXQkq9FMu6xwThlUNdVTZiQ3qw4+BJwVHfTjVYQcin99jaLEbhwFiGFlnzZ5O4vbgi9DOzzKG6EcUI3Kmq53rmkTgygt/ewzyKvpMc8W5VXotFOu9yXvzluZx828I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sJ7Musss; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721040728; x=1721645528; i=markus.elfring@web.de;
	bh=HE81+eZZ6QrvNNv/IW9iPA4uF80hwznlTx71KPwroGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sJ7Musssy8QG/WOwueBnBFptBlRexNoXi4l+JklyIlijLc+wzO7DiGqIlxLu2mmh
	 zft9lEQ7/LeVSyMS8LVTe6ROXEPZdNP9hYilMSZmsix5eSluarHT+kQY6TsOWBTHD
	 ylicIq55e6ieeR2GQDBRS3soYfp0pZ84TktTc1ObQvAz1Clhysd8iQHLqU0owd9aV
	 b1DJaLj675IP0MhrpgJILPX5npzOqwMRIhR2cnrORH4XjE/vaY4J7zYrHy9GLUGVC
	 6RaVfnnGVjZZrK7M4wbbhLEiaud0egr8b8RW0aRUMGIFMe51DN6ncMcbLUQjrWk0p
	 TUfVWYwJcIrZS5hISg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1sL5ng3hDf-011DNf; Mon, 15
 Jul 2024 12:52:07 +0200
Message-ID: <f69334a0-ccdb-4caf-b5b4-177cbf0ed1d7@web.de>
Date: Mon, 15 Jul 2024 12:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gfs2@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Alexander Aring <aahringo@redhat.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 David Teigland <teigland@redhat.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dlm: Simplify character output in three functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Vridu5YqH381X6uz5LbU5TKudpxIA7pichPMTsY2HmUpGQH3pX
 WCHy8n3D+LenESIj6JhctSYEKKRZpxrxoZImTMpczvpUzeR+1Ap8jzslD4wvMNo0AoKXHaG
 8hv/7Nq46U7PvnYgHOESj/ppRNqafD4pxhf0WYT7mtALzHJDy0l1uZgE/LNT5qq1SUkSFet
 y/ol+fmXwQx5uwSVnY1Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MVsrPNsOdCU=;uEGUbUv1yWP+h4W+v/FYIfFrOl6
 9M49U5qSBF9Lyq077ScapIhwvXiOw2+B4FlpyYYUPiVg17mLTjfoz3DrG6SiI44Le1Hfj5HZX
 +vsK6E5/lB0JSHUv8H1ly+6y3TmvSSCtcPBtK1LAXfqnnj4onm6XJSvuGl5uyxggsnceD2rUU
 Slpc7ay+tEtvh8CcF4qD6j40KoYX85rSUOZimJ71U01ALB7L7GMCrRglSDQn2o6C1ke9LVuBg
 rmYIgSWJPZ9Wu8eAkyDZH3WzvpKEm0cj3zA5el9uHuWzTV2dnUBgp2YM2G3ueHI5BxnDle1+X
 CyKXiHOazQaBVTZ0vTN7XfxTq6+MEK5749C2xG4XtV2Sm7pUDRR9WwwXM1qScCQNeTV3ykBwo
 q9fR/MlduoaMAKyLVdUo1cDg6Zi3v3W4HpQHOjZ6MhbFblToL8tM+xzfuzYnUBh6E6f/hpgjS
 cqifQmAytMbxqhTcxriSE0ndPQWGJ2cH4AmRR0uP8ZuZLv0uLwGgjTKiWbhtZHIhlBrktxsfx
 A5b8S4knIm9jjSi11Gxk7U8Ucl0SNs9ESwhHtqUzHCEgHNT7gcZuKyZ41ZcFHM/y8uUle070g
 fC+CgE8rr+Je/kEvp2BV+A70E3pVdFgNIB+Bc5nA/SPaP5DY5ff0Kv9ZHLBLcAw3f4R6+1Z3u
 HZnR4XPeApD3ymBzvUpRsAVtE6A9d9vFQ3q5vXB+B1OmgsrNJqHXGvNzbxRV7xD50tdBRtlea
 y6I4bDuEcGfYukX+lZ/we3l1G/OA+W/Qes6Y4HZfpka+0hPewE0bGnhYPzrOb04dFwo6faJfF
 0l4gLG2JMss4gtDDt14/lv5A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jul 2024 12:36:44 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for three s=
elected calls.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/dlm/debug_fs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 7112958c2e5b..0d21007930ed 100644
=2D-- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -81,12 +81,8 @@ static void print_format1(struct dlm_rsb *res, struct s=
eq_file *s)

 	seq_printf(s, "\nResource %p Name (len=3D%d) \"", res, res->res_length);

-	for (i =3D 0; i < res->res_length; i++) {
-		if (isprint(res->res_name[i]))
-			seq_printf(s, "%c", res->res_name[i]);
-		else
-			seq_printf(s, "%c", '.');
-	}
+	for (i =3D 0; i < res->res_length; i++)
+		seq_putc(s, (isprint(res->res_name[i]) ? res->res_name[i] : '.'));

 	if (res->res_nodeid > 0)
 		seq_printf(s, "\"\nLocal Copy, Master is node %d\n",
@@ -284,7 +280,7 @@ static void print_format3(struct dlm_rsb *r, struct se=
q_file *s)

 	for (i =3D 0; i < r->res_length; i++) {
 		if (print_name)
-			seq_printf(s, "%c", r->res_name[i]);
+			seq_putc(s, r->res_name[i]);
 		else
 			seq_printf(s, " %02x", (unsigned char)r->res_name[i]);
 	}
@@ -358,7 +354,7 @@ static void print_format4(struct dlm_rsb *r, struct se=
q_file *s)

 	for (i =3D 0; i < r->res_length; i++) {
 		if (print_name)
-			seq_printf(s, "%c", r->res_name[i]);
+			seq_putc(s, r->res_name[i]);
 		else
 			seq_printf(s, " %02x", (unsigned char)r->res_name[i]);
 	}
=2D-
2.45.2


