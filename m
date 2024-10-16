Return-Path: <linux-kernel+bounces-368262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A19A0D66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CE7B2187C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541920E004;
	Wed, 16 Oct 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sG7AtR3h"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEE212F13;
	Wed, 16 Oct 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090370; cv=none; b=PR3xaMsHsIbHLSDssc/J+yi0ZIk9MPP7wdS4NnCDEt2rv0/XG67do6OfBMClbBLs5MRMXshk2d/xzAelwBX4FW2WQ1/Roc6pIYmMMyBd0HCGbf61j/Pw0x82pzQvINCh42Sb+twwz5F3/QkuHr/CFr0Fc67jtTeyaOWQvB8z42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090370; c=relaxed/simple;
	bh=pqkRlIAl5dDEfH3Z126a7ZXKSdRQuLa8iK2JZ1XN4fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpWf0j1fIwQeO7XIuBRFGXZYHrx1sKBWFUy1CHJTV18eiLfA+OQo45UdlFLxV8ZQAkgFZwo0I4xUehFDDX/hycVlOMLQDUihAGjkcAhpP3fxsDc1TgkHd1rwEzuKzuLyhA5/znxMWM76AR2bHbDoZciWxPElhf3cOOLJA1k93P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sG7AtR3h; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1443342C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729090362; bh=hrEbj5bpeB01P7bbH3mV9rjR6Y1usox02y6Xk6iwfRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sG7AtR3hrHYmDbYoI9CQsPEcKg7Zdp/ibP2ORln3SNjLLHhiEZAbKEq8N9jpTas3Z
	 LeYPKGMOnqMd9E5zTfcThSzsA9YEic/QGKpR3BR592h1VB/QCYs0EOnVVlRzFEaooZ
	 kQd/CS5IoSGGT7woX+msugMh0teB/7uCW3IjIkC3CYmiJPnDL1Css41R9y0jGP3A2C
	 aGg76KjDlKGD1osZ/QmAErGSlRg8AhO/aclpO030mUqMEqvTcGnnaiZalqTFfgP/LC
	 OhR/jPhinO//iuSuRDAplchC3zUs4kawrFludLaPLt7Fu5zq7fYXytiB5mP/lifMC7
	 bVKsJBtbMG/AQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1443342C28;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dan Carpenter <dan.carpenter@linaro.org>, Marco Elver <elver@google.com>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/dev-tools: fix a typo
In-Reply-To: <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
 <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
 <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com>
 <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
Date: Wed, 16 Oct 2024 08:52:41 -0600
Message-ID: <87msj45ccm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Tue, Oct 15, 2024 at 04:32:27PM +0200, 'Marco Elver' via HUST OS Kerne=
l Contribution wrote:
>> On Tue, 15 Oct 2024 at 16:11, Dongliang Mu <mudongliangabcd@gmail.com> w=
rote:
>> >
>> > On Tue, Oct 15, 2024 at 10:09=E2=80=AFPM Haoyang Liu <tttturtleruss@hu=
st.edu.cn> wrote:
>> > >
>> > > fix a typo in dev-tools/kmsan.rst
>> > >
>> > > Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>> > > ---
>> > >  Documentation/dev-tools/kmsan.rst | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-t=
ools/kmsan.rst
>> > > index 6a48d96c5c85..0dc668b183f6 100644
>> > > --- a/Documentation/dev-tools/kmsan.rst
>> > > +++ b/Documentation/dev-tools/kmsan.rst
>> > > @@ -133,7 +133,7 @@ KMSAN shadow memory
>> > >  -------------------
>> > >
>> > >  KMSAN associates a metadata byte (also called shadow byte) with eve=
ry byte of
>> > > -kernel memory. A bit in the shadow byte is set iff the correspondin=
g bit of the
>> > > +kernel memory. A bit in the shadow byte is set if the corresponding=
 bit of the
>> >
>> > This is not a typo. iff is if and only if
>>=20
>> +1
>>=20
>> https://en.wikipedia.org/wiki/If_and_only_if
>>=20
>
> Does "iff" really add anything over regular "if"?  I would have thought t=
he
> "only if" could be assumed in this case.  Or if it's really necessary the=
n we
> could spell it out.

Somebody "fixing" occurrences of "iff" are a regular occurrence; it's an
attractive nuisance for non-native speakers.  For that reason alone, I'm
coming to the conclusion that we should just spell it out when that is
the intended meaning.

jon

