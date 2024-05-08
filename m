Return-Path: <linux-kernel+bounces-172736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB398BF5F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0731C214E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BC1E895;
	Wed,  8 May 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npOxo7yK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OKGyOIgN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E8182B3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148972; cv=none; b=gt0a9ix3kDkqXUSlqgytI27y2c9aAoTTNKBKa9Pa5Ss99bJybRRrzWPZANofihHl2fsD/dWA+XfDd57h/jZrhVNpCK5+z2lQjB3WOeArp/pOPlB2gzXlQ/5/msZU5CXf3Guv5cnYrdw18Ge4YeXIHdL3iNNyWskRMqvRJQMoXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148972; c=relaxed/simple;
	bh=cFN5oaofICHVd9yjUsMIf7xUSmC8GIS0uQoJG3jvoWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgqf/r2I8mRqGKaHVYj3uQOmBfEbyORK/yTvpETIF38Cc2POI9A6ip8T8fEe3XXo6uYLF/HFr0npwZRQNcRzToJbFbK6wWpovzsDseiukiPa5rg3H2pH4uCkDU0zehiuXaNlxnZIWBAbEIZsXmIWQn89vOL1P/hLb7JT140Lyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npOxo7yK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OKGyOIgN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715148963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoHffgb5mUw/taAJEVbfAW3yichndsSFYyN9Zlm3DmE=;
	b=npOxo7yKygsUSXpLM68E8yxYX+VJa31YWtiKH+21yZBWwL8dlBNULngvP3nEECjPkIF/nz
	QGleaM0nmQu+5Ay9VQ9fBAyogZhGwq1x8VI7W44H7hQiRefxn5KhJYey7byagEHfk2+3CE
	WXRsnElSDEtUqslz2cUuo1uM9GifYGDaMQOE4GXO9Fk0hZu+Ipopb0uSERsLzGUA0YjcDB
	LJle0BmLIJTikB9/63vSW0n/d/PeOTNH4/W/Gp+8emEovX+oV3iDh9d1kjQDJ0yA3a7P1v
	7pjhYP5j0s0h3oB7qAC7t76872vwrNU7JZlOp9iW2iWCpFM2ZypcatF8QWildg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715148963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoHffgb5mUw/taAJEVbfAW3yichndsSFYyN9Zlm3DmE=;
	b=OKGyOIgNuVB3Sh/nt8cb8K8WzLhp4Wd0h7qW2UGIQI1nryFtY/6zxtnYe6krl90uTnggMh
	ciXf3RU6zBCA0ACw==
To: Frederic Weisbecker <frederic@kernel.org>, Levi Yun <ppbuk5246@gmail.com>
Cc: tglx@linutronix.de, Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] time/timgr: Fix wrong reference when level 0 group
 allocation failed
In-Reply-To: <ZjisiuqiR9p76YcJ@localhost.localdomain>
References: <20240505085709.82688-1-ppbuk5246@gmail.com>
 <20240506041059.86877-1-ppbuk5246@gmail.com>
 <ZjisiuqiR9p76YcJ@localhost.localdomain>
Date: Wed, 08 May 2024 08:16:02 +0200
Message-ID: <87seys4yn1.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, May 06, 2024 at 05:10:59AM +0100, Levi Yun a =C3=A9crit :
>> When tmigr_setup_groups() failed level 0 group allocation,
>> wrong reference happens on local stack array while intializing timer hie=
rarchy.
>>=20
>> To prevent this, Check loop condition first before initializing timer hi=
erarchy.
>>=20
>> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
>> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
>> ---
>> v3:
>>     - Fix typo.
>>=20
>> v2:
>> 	- Modify commit message.
>>=20
>>  kernel/time/timer_migration.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration=
c
>> index ccba875d2234..84413114db5c 100644
>> --- a/kernel/time/timer_migration.c
>> +++ b/kernel/time/timer_migration.c
>> @@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, un=
signed int node)
>>=20
>>  	} while (i < tmigr_hierarchy_levels);
>>=20
>> -	do {
>> +	while (i > 0) {
>>  		group =3D stack[--i];
>>=20
>>  		if (err < 0) {
>> @@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, un=
signed int node)
>>  				tmigr_connect_child_parent(child, group);
>>  			}
>>  		}
>> -	} while (i > 0);
>> +	}
>
> Looks good to me. But let's wait for Anna-Maria's second look. The group =
setup
> is not my favourite area...
>

Thanks for the fix!

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>


