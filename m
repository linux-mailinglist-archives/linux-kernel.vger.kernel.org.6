Return-Path: <linux-kernel+bounces-398885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C10E9BF790
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E06E1C243BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986820ADDA;
	Wed,  6 Nov 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YEbxf8xA"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1967198E84
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922407; cv=none; b=WiLFIW9P2SJHHXDDJSL3Uw2I5xR2R/Ync0nyGz3pJOaavuDO/tiTLgEn/VrVeGK/oLmz5lrz2829zCQiPUnOhsUnmZ7skRk+AMmthgyLNlrigWswwm2FPpHOfsQlykYakSQsLkZpN47WiKsctG89XqIvhCsT2k0Msa94m9Uzytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922407; c=relaxed/simple;
	bh=K2awndQknakjdOq77EGKJQ8hOxyvyMZ4GKfFZgD3mKc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gGOpl0OzKgtUwaAIGNitWDGBE3BW1kr7E7CoYLocfP2AP/lM9gHe6yJgQMazMWfAGP7pqw1FxqCdBQae2y8CDrAODXzUpT+NGLTyWljbnOm0A1M4O5Ra2Ab32fZbcMbnQ0+QS3gH3tvwqFdNtKrzrZS1AJiaNo9yjdIvAk+DHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YEbxf8xA; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ljeba2hqujcqhmfjficduval3i.protonmail; t=1730922396; x=1731181596;
	bh=dtbft4B2+EsrFasopBOUlBm3/MzKwTs0b7RtEuwBrGg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YEbxf8xAmgN5C8hnUC5He9V4dd+u3A0DYBbjXkNbtLuJUuDHYEy/arlWvhpspV4yq
	 eUIN3usmi9J1EQD2F5D8tU8cpbPSJssPj+H7fecElnQ4AhN1XGPVKxVvqewFDaPNFR
	 tVsEdEEwYnpZ0Ia0dBLWXZtvnHHJ3nBj+8B9D7SuoqOiGNGEzBR0F7WaLMidSIyaOs
	 oAqSQmZJyb4pxHMULCuI+FKLod+0Fa6W9TuZK4oGXl3F2jvIqAGElubT1A9eiYPE9h
	 f7TNhPqCMrJie6cusJQyZrizkCCqc4ib8cQ6YTUU7CTFS+iX7lVFU6unaKKEnIXrDv
	 PxUJyWG4kUb8w==
Date: Wed, 06 Nov 2024 19:46:30 +0000
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>, syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
Subject: [PATCH v2] Change OPT_STR max to be 1 less than the size of choices array
Message-ID: <20241106193443.307896-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: a968a975ce0104e86926370136b298be11883566
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Change OPT_STR max value to be 1 less than the "ARRAY_SIZE" of "_choices"
array. As a result, remove -1 from (opt->max-1) in bch2_opt_to_text.

The "_choices" array is a null-terminated array, so computing the maximum
using "ARRAY_SIZE" without subtracting 1 yields an incorrect result. Since
bch2_opt_validate don't subtract 1, as bch2_opt_to_text does, values
bigger than the actual maximum would pass through option validation.

Reported-by: syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dbee87a0c3291c06aa8c6
Fixes: 63c4b2545382 ("bcachefs: Better superblock opt validation")
Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---

Notes:
    Changes in v2:
        - Instead of subtracting 1 in bch2_opt_validate as in
          bch2_opt_to_text add -1 in OPT_STR macro definition
          and remove subtraction in bch2_opt_to_text.

    link to v1: https://lore.kernel.org/linux-bcachefs/20241031231823.68891=
8-2-pZ010001011111@proton.me/

 fs/bcachefs/opts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index 83f55cf99d46..49c59aec6954 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -227,7 +227,7 @@ const struct bch_option bch2_opt_table[] =3D {
 #define OPT_UINT(_min, _max)=09.type =3D BCH_OPT_UINT,=09=09=09\
 =09=09=09=09.min =3D _min, .max =3D _max
 #define OPT_STR(_choices)=09.type =3D BCH_OPT_STR,=09=09=09\
-=09=09=09=09.min =3D 0, .max =3D ARRAY_SIZE(_choices),=09\
+=09=09=09=09.min =3D 0, .max =3D ARRAY_SIZE(_choices) - 1, \
 =09=09=09=09.choices =3D _choices
 #define OPT_STR_NOLIMIT(_choices)=09.type =3D BCH_OPT_STR,=09=09\
 =09=09=09=09.min =3D 0, .max =3D U64_MAX,=09=09\
@@ -429,7 +429,7 @@ void bch2_opt_to_text(struct printbuf *out,
 =09=09=09prt_printf(out, "%lli", v);
 =09=09break;
 =09case BCH_OPT_STR:
-=09=09if (v < opt->min || v >=3D opt->max - 1)
+=09=09if (v < opt->min || v >=3D opt->max)
 =09=09=09prt_printf(out, "(invalid option %lli)", v);
 =09=09else if (flags & OPT_SHOW_FULL_LIST)
 =09=09=09prt_string_option(out, opt->choices, v);
--=20
2.47.0



