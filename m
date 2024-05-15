Return-Path: <linux-kernel+bounces-180254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E828C6C13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AAE283105
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D935158DBF;
	Wed, 15 May 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/Tanh7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD335158845
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797281; cv=none; b=AE3KmBp18EqZn7PO4iC6mLuVboEa3JB+fzy3L2RaQUPydsVpsOLv7UsH3PY/nL+t94ojjymEvHtQB9mDQvc+33S7qZv77tjvaTY8eIIZ76e4wh7Uik+5xKZYrE7aRIj/XxR0T9CmabdzHluRw+3symucRRxcEhBFrQ+PzUYe/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797281; c=relaxed/simple;
	bh=iHD0UyuivF0i6K1yPM2fcXtvuDCZkUObbv4SHRUgfxM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qUqXldYXNcm+1W6frw76+sTA3MsFS4RT+qYkoQtt8xMi1GyXjMNWhOwctKY8JspSXiMYnV9ze7o7YWBgpc/Q7ZUdl1TyJnV6+U/aMSY5+4PughZwG/28NEZH+cP66VsFju8EXMH0Wa1XZyHD01DbrGiWaxAWm6Vec9pRD2HblSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/Tanh7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87CBC116B1;
	Wed, 15 May 2024 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715797281;
	bh=iHD0UyuivF0i6K1yPM2fcXtvuDCZkUObbv4SHRUgfxM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H/Tanh7zlVXO/XkPU5wjs/TcpDqzgSFP5zgAknY2/lMMXC1wJulIoJAfPCp3Y9dFd
	 WawIgKFkdMU9xeYwb8KumloKYo/NJ4riorfx6iU4BERfGi6YBnLGTgZDuYA6/+vnB0
	 tYjwtu0MQSPCE/QU4sCPKZtFV9A5wrj7AlFEXvMOO7RhnqO/upXdEdrnfvgxbAG2zs
	 gWBHVuh8EprYAO15PLmq4dIxmO8rfq7r4EtYuGo06k8ywEX0pUd2Ven5bxGN20minr
	 e8w1wkFvhByaQTOzH+I/mYdz2s0NlgqcQYHq1mj+uZPeP0xc5RKrRndHdtBqX6ufDW
	 KBocOPT/K/OEg==
Date: Wed, 15 May 2024 19:21:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
User-Agent: K-9 Mail for Android
In-Reply-To: <ZkT1K/c9hWsfOwWf@ghost>
References: <20240515-comic-sketch-3b40e6676f55@spud> <ZkTnlEnoFFrQdXi2@ghost> <20240515-slander-stranger-683758537aee@spud> <ZkTuc4fxXcS/g7hC@ghost> <20240515-bootie-patriarch-769c0ebff4b1@spud> <ZkT1K/c9hWsfOwWf@ghost>
Message-ID: <39FEF902-2495-42A2-B279-C9FC95828F00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 May 2024 18:47:23 IST, Charlie Jenkins <charlie@rivosinc=2Ecom> wrot=
e:
>On Wed, May 15, 2024 at 06:30:36PM +0100, Conor Dooley wrote:
>> On Wed, May 15, 2024 at 10:18:43AM -0700, Charlie Jenkins wrote:
>> > On Wed, May 15, 2024 at 05:56:30PM +0100, Conor Dooley wrote:
>> > > On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
>> > > > On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
>> > > > > From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>> > > > >=20
>> > > > > Commit e47c37c24024 ("riscv: Introduce vendor variants of exten=
sion
>> > > > > helpers") added includes for the new vendor_extensions=2Eh head=
er in
>> > > > > the T-Head and SiFive errata handling code but didn't do so for=
 Andes,
>> > > > > resulting in allmodconfig build issues when commit 589e2fc85850
>> > > > > ("riscv: Convert xandespmu to use the vendor extension framewor=
k")
>> > > > > added a user of a macro defined there=2E
>> > > > >=20
>> > > > > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendo=
r extension framework")
>> > > > > Signed-off-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>> > >=20
>> > > >=20
>> > > > I was going to fix this in my next version but was waiting for th=
e
>> > > > reviews on the thead stuff=2E I wasn't anticipating these patches=
 to be
>> > > > able to jump the queue :)
>> > >=20
>> > > Yah, the reason for that is I asked him to take the non-vector part=
s of
>> > > the series as 6=2E10 material so that we'd have less stuff movin' a=
round
>> > > in cpufeatures=2Ec so that Clement's Zc* + validation changes would=
n't run
>> > > into a bunch of conflicts etc=2E Same reason that I pushed for gett=
ing
>> > > Andy's vector subset stuff merged today, but that mighta been befor=
e you
>> > > hopped in=2E
>> > >=20
>> > > Cheers,
>> > > Conor=2E
>> >=20
>> > Yes I was a couple minutes late to the meeting, whoops=2E
>>=20
>>=20
>> It's prob at like 0600 for you, so w/e=2E
>>=20
>> > The subset of
>> > patches that was pulled into for-next is odd to me because there is s=
ome
>> > of the thead enablement code as part of the vendor extension enableme=
nt
>> > so that there was a user for it=2E Since the subset on Palmer's for-n=
ext
>> > does not have the rest of the thead code there is only a
>> > half-implementation of the thead code, it allows the kernel to probe =
for
>> > xtheadvector but it doesn't probe anywhere=2E
>>=20
>> I dunno, I think that reporting that the extension is there constitutes=
 a
>> user, it's not gonna be dead code=2E There's plenty of extensions for
>> which all we do is detect them and nothing more=2E
>>=20
>> > In my opinion, a better solution would be for me to get rid of the th=
ead
>> > code entirely from those patches=2E So that there is still a user, I =
can
>> > replace the thead code with the andes versions=2E
>>=20
>> The Andes stuff is in the subset he applied though, so=2E=2E=2E
>> >=20
>> > Since Palmer already pulled in those changes maybe it's too late=2E T=
here
>> > is not a critical problem here, but it seems like it's bad practice t=
o
>> > introduce code without a user=2E
>>=20
>> =2E=2E=2Ethere is actually a "real" user in xandespmu=2E I did miss tha=
t
>
>I meant there is no user of the xtheadvector addition=2E
>
>> "riscv: Extend cpufeature=2Ec to detect vendor extensions" actually
>> contained the xtheadvector detection though, rather than just the
>> infrastructure=2E I think it is probably harmless to have it, but
>> shouldn't be too hard to quickly drop the thead bits either I suppose
>> if you're worried about it=2E
>
>And the adding vlenb to the DT patches is unrelated to the subset of the
>series that was pulled into Palmer's for-next so spinning that off into
>a different series would be more logical=2E This is kind of a pointless
>rabbit hole I am getting into, but when we start splitting up series
>the code contained in the patches start to diverge from the cover
>letters that end up in the merge commits=2E

 The vlenb stuff is also one of the things that I want, it's useful for th=
e validation stuff that Clement is adding=2E

