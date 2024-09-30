Return-Path: <linux-kernel+bounces-343766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39196989F27
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EE21F23023
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A118C35F;
	Mon, 30 Sep 2024 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsWGuivA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FD18C014;
	Mon, 30 Sep 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691183; cv=none; b=Imdm5zDSKUk1ENLpcHN0A6A9VEayawSsaVUri6upqC/O2Le6hljFEfeay/Q/VR3tuulbv5H+iCN22Zii+vjAHj7QaTe/YhRViBS3SvaJzf8Dg6Hawqarbp/PTpcc+2oKNphDS8EAeo9vOO3patyHbPrfySibG2H8cBjJX3T3TMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691183; c=relaxed/simple;
	bh=Iz6FpqvkzvFBZrnexnvWzVFW8uhmotoxGGp3oXUlCk4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fWY7e1ew5bmlyetTVI+NUxdww5Q6t4aejwHA4f/U2fN9bxwT7I4xVjgs+Q22ti3b5P4hCZXaMLGNkayoAa64lX6gWlnOShjsp0OVmr8tcQDKgo7HVYwSRT0rKsqgANU6pBi+FNS/qR7reEBmDpVvFnVSDTte7wnScYQGmJCBa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsWGuivA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7191fb54147so2996713b3a.2;
        Mon, 30 Sep 2024 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691181; x=1728295981; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg9QbxXqBJRz1Y4pX/no4eFBUpG3N+9Vg2SGSZ259dc=;
        b=RsWGuivAxiZJp/guYRUHsH3zNtV9azIMpY0w6nwVAS2UhzFuvoz08TEBeKrQUONLRs
         W4FmSB9v+Z7F613dDdtCd/XPJeKD41GZGbdZbzQQFlgxe9+c6h1Ee4TbT0ZddH03oGHb
         Hp2gfaUqQ3WL3dCaEz61i9DjW1mul583d5mOE2qhzZrEL5ScF1AGl2JdZQOBNUCzgC0u
         pKWMQNTLcWRdoVjMEAMMkHl/gB8npt7VZR8Uw93f/vJN9kgQB3s9Nl76yO3eLrWkVYfh
         9bPEBgO+/TUQA7OaF09hsO03Z6OF9AxGiP3eD7S31Tfq/QaXcYFaarX3vpPZ+1Wp+cGr
         Aajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691181; x=1728295981;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg9QbxXqBJRz1Y4pX/no4eFBUpG3N+9Vg2SGSZ259dc=;
        b=VuzLBrC5x2OKx3/uugQaa2MTbysW+H2Qf468aLWDj/FxH4n9Y8nrgImx5Eb8vNR0yq
         12SgFVu6EtLzOJVsgJ4KMdS3zXa+nGVBxOJaRe0ElCxvnA/nLFbSi5hZdzPiZsT2pwRr
         zsfWF4oyAB/zZmrXYWjm0KQh1aeOkncnbzyDzHlvWk1TrzNEomlGV08SBUumV8lrw31t
         A1U8UAZYdZq00bj2A9vClTR2EboUYAMA0AysCCFCUOHkv4mmV/q5CRB+n68V0KYlLcnP
         ie+jZUdfCMu8vwu0WUm5/4UyWFN3xZIYcExesfzMLzZl3YYj5N8OEkqfRehUeMEOOyds
         XPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxhnaneDGnA6IdRlCv8QD4WUzyx+QpqXJHYmXrQLp32SD+38mutt4kL4pvKUVuDFCofQpTaciF3ic9g4o=@vger.kernel.org, AJvYcCXHuUdBS0Wq7vg2w7689dg3qT2fJrL+pbeTnw+LgXIhOClOONfu9ViiW6FsITYkXJhb+IBE@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwCz8BtoBT45HyFjG6axuukht+oqhY2TD++bG8WUSfIHVyMhO
	9BnPgXIDZ+IVH3zkLP6rrLj/m9eZx+kJuHjmcfBVPVUoVov/+PaR
X-Google-Smtp-Source: AGHT+IEbgAIZDqyappTGr1yzQ1aGd/957Pqi4TS5TlTr0GffL5y1TZCfeRy6GsGkuVOxghOCWTncWA==
X-Received: by 2002:a05:6a00:1956:b0:710:591e:b52f with SMTP id d2e1a72fcca58-71b25f01b93mr17882746b3a.5.1727691181043;
        Mon, 30 Sep 2024 03:13:01 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264be25dsm5880730b3a.84.2024.09.30.03.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:13:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <c2e5b1ee-eeee-4614-9b42-d6bbf7a67162@huaweicloud.com>
Date: Mon, 30 Sep 2024 18:12:31 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF8BEE57-2F7A-4BD5-B062-F4C268E8494B@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
 <8d20cf79-9fa5-4ced-aa91-232ccd545b59@huaweicloud.com>
 <EEAE4623-DCD7-4BBE-8E06-7F6FF6E3070B@gmail.com>
 <E2551572-494D-46A0-A1D5-DF91DDB8B9F9@gmail.com>
 <c2e5b1ee-eeee-4614-9b42-d6bbf7a67162@huaweicloud.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
X-Mailer: Apple Mail (2.3776.700.51)

On Sep 30, 2024, at 17:33, Jonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> wrote:
>=20
>=20
>=20
> Am 9/30/2024 um 11:27 AM schrieb Alan Huang:
>> 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 17:15=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 16:57=EF=BC=8CJonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>>=20
>>>>=20
>>>> Am 9/29/2024 um 12:26 AM schrieb Alan Huang:
>>>>> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote=EF=BC=9A
>>>>>>=20
>>>>>> The motivation for introducing ptr_eq() is indeed because the
>>>>>> compiler barrier is not sufficient to prevent the compiler from
>>>>>> using one pointer instead of the other.
>>>>> barrier_data(&b) prevents that.
>>>>=20
>>>> I don't think one barrier_data can garantuee preventing this, =
because right after doing the comparison, the compiler still could do =
b=3Da.
>>>>=20
>>>> In that case you would be guaranteed to use the value in b, but =
that value is not the value loaded into b originally but rather the =
value loaded into a, and hence your address dependency goes to the wrong =
load still.
>>>=20
>>> After barrier_data(&b), *b will be loaded from memory, you mean even =
if *b is loaded from memory, the address dependency goes to the wrong =
load still?
>> Sorry, *b should b.
>=20
> That's exactly what I meant to say. In my understanding, it can happen =
like this:
>=20
> a =3D READ_ONCE(*p);
> ...
> b =3D READ_ONCE(*p);
> if (a =3D=3D b) {
>   b =3D a; // inserted by compiler
>=20
>   barrier_data(&b);
>=20
>   foo(*b); // compiler definitely use the current value in b
> }
>=20
>=20
>=20
> In the end, the address dependency is from the first load, and the CPU =
can speculatively (with register renaming, forwarding etc) execute
>=20
> a =3D READ_ONCE(*p);
> b2 =3D a; // speculatively
> tmp =3D load *b2 // speculatively
> b1 =3D READ_ONCE(*p);
> if (a =3D=3D b1) { // confirmed
>   foo(tmp);
> }

I get it now, thanks for the explanation.

>=20
>=20
> best wishes,
>  jonas
>=20


