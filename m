Return-Path: <linux-kernel+bounces-425001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E769DBC46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362C2B21A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF11C1F06;
	Thu, 28 Nov 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xxp6Frrc"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71917BA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732819979; cv=none; b=RXO/qqiSesYS3GqL09eeDPlhd1E7kT+UpZn48lD0lMxRtn0Xaw5OwWOO4jidV/JgQNBuaA5sWamO6vo1vA7uYesYnToeGWwj7OhedpKr60XA62cJa91D/sJ1/LFu64/K2ZguetowRcgPQZZI1cMRTCSCLigOx9ONwtlj/mLYkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732819979; c=relaxed/simple;
	bh=bxhU+2R6fKMNp8QczFnE1XT/oKlNnt7oabQLskWLBeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUb5SkiwTfSyuW3/b6gNc1b3yoXsnYRdTGwkR+rPz75Bn580MAS0fU4eLlOexBtcYrarurUXGZvpGIQ5EZ8edOfgbY8zi1jiY3wF1RkrRQbu3t/kxmkZoNgFch3UR98ay01pnPfQsWiHviAurE3CEVXiebinK9ZUvQYyuXz1qkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xxp6Frrc; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732819974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv3YNayreJui3brbt7+Hve2t+AzYfQ9bh9cAAPetcn4=;
	b=Xxp6FrrceyJTjdDN3m+S/IsSGu/HG1Ppbl1u3Ziiy3Xv3rnr4dtNaCCAeChL/bLp4+37UW
	LLmyk5NJtwz6L3ftu+/cxYejszbjwfxZoFNToTUezjm5VSOWs7CiESAhGfWEAl7JB/PqvZ
	tQnabmOQQ6dJqzNIqYQiPcZs1j/Y334=
From: Luis Henriques <luis.henriques@linux.dev>
To: Alex Markuze <amarkuze@redhat.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>,  Xiubo Li <xiubli@redhat.com>,
  Ilya Dryomov <idryomov@gmail.com>,  ceph-devel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when
 doing a file read
In-Reply-To: <CAO8a2SjHq0hi22QdmaTH2E_c1vP2qHvy7JWE3E1+y3VhEWbDaw@mail.gmail.com>
	(Alex Markuze's message of "Thu, 28 Nov 2024 20:19:31 +0200")
References: <yvmwdvnfzqz3efyoypejvkd4ihn5viagy4co7f4pquwrlvjli6@t7k6uihd2pp3>
	<87ldxvuwp9.fsf@linux.dev>
	<CAO8a2SjWXbVxDy4kcKF6JSesB=_QEfb=ZfPbwXpiY_GUuwA8zQ@mail.gmail.com>
	<87mshj8dbg.fsf@orpheu.olymp>
	<CAO8a2SjHq0hi22QdmaTH2E_c1vP2qHvy7JWE3E1+y3VhEWbDaw@mail.gmail.com>
Date: Thu, 28 Nov 2024 18:52:45 +0000
Message-ID: <87zflj6via.fsf@orpheu.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Hi!

On Thu, Nov 28 2024, Alex Markuze wrote:
> On Thu, Nov 28, 2024 at 7:43=E2=80=AFPM Luis Henriques <luis.henriques@li=
nux.dev> wrote:
>>
>> Hi Alex,
>>
>> [ Thank you for looking into this. ]
>>
>> On Wed, Nov 27 2024, Alex Markuze wrote:
>>
>> > Hi, Folks.
>> > AFAIK there is no side effect that can affect MDS with this fix.
>> > This crash happens following this patch
>> > "1065da21e5df9d843d2c5165d5d576be000142a6" "ceph: stop copying to iter
>> > at EOF on sync reads".
>> >
>> > Per your fix Luis, it seems to address only the cases when i_size goes
>> > to zero but can happen anytime the `i_size` goes below  `off`.
>> > I propose fixing it this way:
>>
>> Hmm... you're probably right.  I didn't see this happening, but I guess =
it
>> could indeed happen.
>>
>> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> > index 4b8d59ebda00..19b084212fee 100644
>> > --- a/fs/ceph/file.c
>> > +++ b/fs/ceph/file.c
>> > @@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode,
>> > loff_t *ki_pos,
>> >         if (ceph_inode_is_shutdown(inode))
>> >                 return -EIO;
>> >
>> > -       if (!len)
>> > +       if (!len || !i_size)
>> >                 return 0;
>> >         /*
>> >          * flush any page cache pages in this range.  this
>> > @@ -1200,12 +1200,11 @@ ssize_t __ceph_sync_read(struct inode *inode,
>> > loff_t *ki_pos,
>> >                 }
>> >
>> >                 idx =3D 0;
>> > -               if (ret <=3D 0)
>> > -                       left =3D 0;
>>
>> Right now I don't have any means for testing this patch.  However, I don=
't
>> think this is completely correct.  By removing the above condition you're
>> discarding cases where an error has occurred (i.e. where ret is negative=
).
>
> I didn't discard it though :).
> I folded it into the `if` statement. I find the if else construct
> overly verbose and cumbersome.
>
> +                       left =3D (ret > 0) ? ret : 0;
>

Right, but with your patch, if 'ret < 0', we could still hit the first
branch instead of that one:

		if (off + ret > i_size)
			left =3D (i_size > off) ? i_size - off : 0;
		else
			left =3D (ret > 0) ? ret : 0;

Cheers,
--=20
Lu=C3=ADs

