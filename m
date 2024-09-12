Return-Path: <linux-kernel+bounces-327235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008CE9772A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABDE1F22D03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB451C1734;
	Thu, 12 Sep 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="R8+YILA+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FF6F2E8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172307; cv=none; b=IKISFfTI3MjRKAvz612Qtr0OzN/J99E477i/jbYij9DyFdv3tsC3FIZCugClNt7G3qoa5Ci0AEiDGdKCrY7ELdbTvihapBP37UYxeNEkMF/tUqVSjwT1tXueCN3yO4wYyUYAHRWgu+TUKvHwU6e/6hwar71RjxhIN8LvW6rdhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172307; c=relaxed/simple;
	bh=sqEGLsiVe1px2T7K/5jR6/t8UKmJUdNGHqzq6qUMBDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYFxqfewCyt7WXLAfMAzfh84yxEF9+2AMr9BXtTWC7WtKYJHSOnYL5o5FrWzS7TyOm03YpYpB4MbjwdEOcSj5NQQPhdgmQmVakECgB5KCoRjM/W82eds2pTCxq/+7FCrTwt4WeiY46sNwkrBOZ1DGYvX/LntRTfcHnU2jj+eiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=R8+YILA+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726172303; x=1726431503;
	bh=sqEGLsiVe1px2T7K/5jR6/t8UKmJUdNGHqzq6qUMBDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R8+YILA+dKmb1Ok6pCZCJXvNQJMqwlQRmIip7KIIsQJ6LuxP0rU4HUqHGnxXd5aRn
	 msytPCvs2JN0+0FOVqtv335B9s8uXkScF91IERSHWNy7clg/vVoZF94GPnSfJfCM7L
	 I9O1+aKpbgTnYEzA/4EGNsA/18M5VQp54li3wYsep74kYH31vVHjpb9WTvRoPH9NfB
	 dFpyygy6MuC9yruJseELMP6tCpqF5d9HRnB0TVoY1HZs26is4oRtRW+F0QKT2iAMYe
	 9ziCLqaIiGozewN3lwXjikpKKVneH0Gi+r7xtpIS7j325R9AvsNHOZcALExpv+ByJj
	 BvmYkoi1kDDRA==
Date: Thu, 12 Sep 2024 20:18:18 +0000
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: mac.h: Fix possible precedence issue in macros
Message-ID: <ILhrP61gFh-bKmnqG1DTIWCjW8yXNVEI1mGa2Fm-y_yhZ4kV-WCxXoid_Yuy7w4-kyH4QVT7B3h-OUUBH0rAtjCM8P5tMQxG_zLjKrq4NEM=@protonmail.com>
In-Reply-To: <f4e58090-0229-4a72-9bb6-d57757eb708c@gmail.com>
References: <20240911180149.14474-1-dominik.karol.piatkowski@protonmail.com> <f4e58090-0229-4a72-9bb6-d57757eb708c@gmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 27318e477fc62929080976404587b24280042317
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, September 12th, 2024 at 21:29, Philipp Hortmann <philipp.g.hor=
tmann@gmail.com> wrote:

>=20
>=20
> On 9/11/24 20:02, Dominik Karol Pi=C4=85tkowski wrote:
>=20
> > It is safer to put macro arguments in parentheses. This way, accidental
> > operator precedence issues can be avoided.
> >=20
> > Signed-off-by: Dominik Karol Pi=C4=85tkowski dominik.karol.piatkowski@p=
rotonmail.com
> > ---
> > drivers/staging/vt6655/mac.h | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.=
h
> > index acf931c3f5fd..a33af2852227 100644
> > --- a/drivers/staging/vt6655/mac.h
> > +++ b/drivers/staging/vt6655/mac.h
> > @@ -537,9 +537,9 @@
> >=20
> > /--------------------- Export Macros ------------------------------/
> >=20
> > -#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_P=
AGE1SEL)
> > +#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG=
_PAGE1SEL)
> >=20
> > -#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_P=
AGE1SEL)
> > +#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, (iobase) + MAC_REG=
_PAGE1SEL)
> >=20
> > #define MAKEWORD(lb, hb) \
> > ((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned =
char)(hb))) << 8)))
>=20
>=20
>=20
> Hi Dominik,
>=20
> git shows your name with the following characters:
>=20
> Author: Dominik Karol Pi^Etkowski dominik.karol.piatkowski@protonmail.com
>=20
>=20
> I think it is better to change your name to only english letters.
>=20
> If you send in a second version of this patch please use a change
> history. Description from Dan under:
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>=20
> Thanks for your support.
>=20
> Bye Philipp

Hi Philipp,

Thanks for testing my patch.

About the mangled author field - it was sent as
"From: =3D?UTF-8?q?Dominik=3D20Karol=3D20Pi=3DC4=3D85tkowski?=3D <dominik.k=
arol.piatkowski@protonmail.com>"
and =3DC4=3D85 in UTF-8 is indeed '=C4=85' character. When looking at linux=
-next tree,
previously accepted patches also seem to have '=C4=85' as intended. I am no=
t sure
why you are seeing "^E" instead.

Thanks,
Dominik Karol

