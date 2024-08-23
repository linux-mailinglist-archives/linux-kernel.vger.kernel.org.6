Return-Path: <linux-kernel+bounces-299411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4E95D43F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E0C1C22027
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948F18EFC9;
	Fri, 23 Aug 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awgmg/j/"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B718E043
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433883; cv=none; b=MD6VE84ocloQFf/GhLfR0Fc3S/ChCFSt+YwbKwXS4fpVol0b02ZDPYWcRepdSZts1OJ6TTeoWGvpULt/EXS5AiA0cnqpS0BkOkPMe0+7HJb/8fCj/bUtBrhh/CS8DU57KjOKYd4mqGDNvu6FNuUBouyvfO37gMmwuiWTzFptl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433883; c=relaxed/simple;
	bh=II/l/BYUB8+ym0Bf6l9XPtXLxQdNIdTv3o6q40RMEhw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YgR0kf7UkfUSME8Sn6JsC9LLv7Dge/uAxc+VT7sbylLt30LVYIC8+suhPp6VF4K7FDDqTNbntyaBOy+hNBngI4Cf5jCO5srkdKS9fSbVZQ+1kGDn8UG3NUcW+WeaHxQjRR+akY0u/0nTNeBRVcRUUnnC8JdG6/O2E+B/61Vh7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awgmg/j/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f2868783so15016541fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433880; x=1725038680; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA90O16jMgd8CWh2MnYobE93W15NHZgeiwtdthdRGp4=;
        b=awgmg/j/4xuJMP3FGmIJjjniJ3zDQe7LxE0O3yR6ildWAqi4poJ35qXJeoAyRzgy41
         1B1WmTus9UzLG+ae5/GiggpAmhGTX8DEOEpaSjyAJD8KnM10SvWfjh/lfyjk6Ps8KI4Z
         hEYMnq/vBMgR68carbrsWUpEKCnwM36k0s9FCkvUz4GfmrI9gjLss+YXdQnQIda7mlNT
         M0ysqQmirOpP/DiCOUnlJAxkLVtloquTe6Fpp5nfj5s2hu2tNPUNfACjeruMvBiahAE7
         thU6i7Nprg6zMeZLaTxO39J0jX3K2cHcaimXAmyuPk4iIcnuw6pjApHhUwImhLXR5swT
         vKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433880; x=1725038680;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA90O16jMgd8CWh2MnYobE93W15NHZgeiwtdthdRGp4=;
        b=nKHtY+aQOX/5oA0x4ABKyn/eWLyv9eetOG0Li3Xvcsm5Sa5nzPu3JVbPy//x+iqhhm
         xVqvBiKQ5JbvthE/JJNRfttMjSjh27HIxPoLWr6AajFnDsPmIP9wP0njjKCnx74yEIx+
         NzJc0Yg5rjFuRc5DTZAG80BcsNwj31diYh12vUgHCf2wMFWXxKoW77Mcx8f8mJi1R1Fj
         CtgByHEiiDVTsauCI5OEFZdX/KEvwIRyvyQDdlEnxoG/hLwdwOStajogBWVyuOiFvdu6
         KLZtT6TByX1dqrvP6DJOsszZ4PFJs2c4Q5qQWooALN96N8BivySqTmqo+OcUVGG7Ap2b
         q6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4CrBBq+j0F/X7cIxQL3lLkoRYEd6wqYsiM8Tb5teeB2S9ebAaR2P3AmyQ9DV4uk1Ca3/UT5R1AhcCCE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIw12ZCtXkqC8Fu3wTNlADiXpy5kh1VcUhV6gLI+wTi3VXm/8
	W/iCXvmK4JMMXNfh1pa0MCTdwrOQlurYYy/s53jEYhmKt3UYt8n8nHzQsQ==
X-Google-Smtp-Source: AGHT+IFZHmqXsjrxBKhdu8OBEsZNOg0v/ZZ7Ci9CMduEvA+77wHDailfpz0DSdPAgrJBCpingvQDRw==
X-Received: by 2002:a05:6512:3089:b0:52d:b150:b9b3 with SMTP id 2adb3069b0e04-53438785d61mr1902615e87.32.1724433879707;
        Fri, 23 Aug 2024 10:24:39 -0700 (PDT)
Received: from smtpclient.apple ([188.146.32.62])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea88f82sm600036e87.257.2024.08.23.10.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:24:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
Date: Fri, 23 Aug 2024 19:24:27 +0200
Cc: Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9793DBCA-13F4-4B47-AD57-12A62F7DD8DD@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w =
dniu 23.08.2024, o godz. 18:16:
>=20
> Have you tried with 6.9 yet? IIRC, there are two major changes to
> zswap architecture in recent versions.

No. But now building vanilla 6.9.12. Will install and see=E2=80=A6
(This will take some time as catching issue needs days of compilation)

>=20
> 1. In 6.9, we range-partition zswap's rbtrees to reduce lock =
contention.
>=20
> 2. In 6.10, we replace zswap's rbtrees with xarrays.
>=20
> If 6.9 is fine, then the latter is the suspect, and vice versa. Of
> course, the minor changes are still suspect - but you get the idea :)
>=20
>>=20
>> btw: we can go with elimination strategy.
>> So what i need to change/disable to be closer to finding root cause?
>=20
> Could you let me know more about the setup? A couple things come to my =
mind:
>=20
> 1. zswap configs (allocator - is it zsmalloc? compressor?)

Well - I=E2=80=99m not using zswap.

[root@minimyth2-aarch64-next piotro]# swapon -s
Filename				Type		Size		=
Used		Priority
/dev/nvme0n1p3                          partition	16776188	=
294164		-2

>=20
> 2. Is mTHP enabled? mTHP swapout was merged in 6.10, and there seems

I don=E2=80=99t have used config at the moment, but =
/sys/kernel/mm/transparent_hugepage in I see:

=E2=94=82/hugepages-1024kB
=E2=94=82/hugepages-128kB
=E2=94=82/hugepages-16kB
=E2=94=82/hugepages-2048kB
=E2=94=82/hugepages-256kB
=E2=94=82/hugepages-32kB
=E2=94=82/hugepages-512kB
=E2=94=82/hugepages-64kB


> to be some conflicts with zswap, but Yosry will know more about this
> than me...
>=20
> 3. Is there any proprietary driver etc.?
>=20

Only 2, both ryzen9 monitoring related:
https://github.com/leogx9r/ryzen_smu/commits/master
https://github.com/ocerman/zenpower/commits/master




