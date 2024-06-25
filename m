Return-Path: <linux-kernel+bounces-229277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F656916DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A12B2710B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FE171E64;
	Tue, 25 Jun 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TbpO7cCF"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387514C59C;
	Tue, 25 Jun 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331565; cv=none; b=docRSgrlyfwVgvcmDWniBfX1NQ+tsKRt7wS2n6qai1F3CP5xy07n/gE/ATwlvSY4opPKfmCijGsR5uc72GMJ6jj5P9PmyeigXH81VHf4VT5mgVULSBl3OwQY9s/dKQRSIFsI0BCtzj0tXXnBjjnEdIBOIlkkeGaoMklCf4WvhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331565; c=relaxed/simple;
	bh=1Qv0d+LigROQRA3MvAbMgGCOZbrrUmwvp4w7rjburvc=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=GpWxoGuqzqqRp4H05SEOAH2UqRa7QAmJXVBMTXNyeARhkJ1Jc39RQ3UcmNkZ3vQQW+h4Eae/7yI2+YSc9eGUkjskN6FEVewdotHIr1C6LEDo2iq5lDNgcmrsLsH67zlqz3GDjjl5si7oC/fINps7EbfiT86nVej8dkvJ/ss0K24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TbpO7cCF; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719331551; bh=DFA9ATURDnDHmT+JTZbTU4zjVWWw3GnhqNiNhKiKk5E=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=TbpO7cCF8xZubDRe0KJq5OeVG1SjmuktMKWbYEtusuKmeNABjdCNRQaITqz22S86A
	 CR9G9NIW0OrK9qUNGYFqy5Cw7P6Jl+dM+8z7GpxBjqxodqGmsiTAoNWdaHGnRQM++m
	 Ei+/NB/DAOr4/pbu7cZVumk2588FkGO7AwrmamcM=
Received: from smtpclient.apple ([2408:8207:18a1:c8b0:f5fa:3cc7:251d:184a])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 1251260D; Wed, 26 Jun 2024 00:04:37 +0800
X-QQ-mid: xmsmtpt1719331477t7a5x97rd
Message-ID: <tencent_B61C9F718362BC42F61A8BF95A046BB44D09@qq.com>
X-QQ-XMAILINFO: NfHsM/dq2nWI8qGjggedwfiwSv+7cxrMVxIdxyxZk5tawVnqa9TJNjGTXSdokx
	 yRygcOG6PkSKP7UlCCBYRTQWZnKZdsMDCs+ppB8n2diKK2Re283eWXa+EBw8Z1JUvBVSnYZ/WHbJ
	 mOnIibbT3pBxrvC/tIWArW4jXso5Mrks3yLoMUK0jhEJlKw/HHlHtC0hyVCpTELbDz7uq4XGhXLd
	 5QM+UoXxjraNPcJi9qiMxAd/vDmm/vpjhTlFNtQ1QXFav3JfpqFqaChk/DdQgKdg/tQvYlOetAZB
	 ZxG9zY5rB5qNtZUvYzM14PCqj1VUItdSYvW74cBpI1y6ZKv4Kwkn/k/YIHb9sJnSuJ2QXbziikJE
	 JzeoM3uncUGJHBdJt7GxXROxgZofkyDh9k3KbBfLQQvy0M+4TEtxGiOaTSXJR4/8epICblISBjNP
	 2BG6OkfvAK+iQmNLOKzPWKs5z8/9Bl8S+9wxJ2xvIZL6H4C2Kazk4Hy93A+s8dgtgxkJHlgtkl66
	 3IL9MoNMLQhB4C0EQQD/yIaKzwyjW6Zi11IH7ThOrj3kbi8u+v07LDlz2Y8yAz6AayJAIB+iO6kw
	 XU/SF8Hff3X9XCnKFnYT8BccVR9RRw8WgdYRgATcbhp8H8hZxXKghscMTsYTwTH3+SnHhP3VRcs6
	 n4eUWJWMzKX5is9MPeBl2ehaMl4cWPeSvmrJWBHD330lm9rSVFg47npfOrPB4t3Pdm4Mn+YX5SWG
	 R/XZa7rGWiP20prkCrB8lLLFp9g7XOKTHHC2PCsNfIe6A1IjJHbJF7zMDLBgQ6IH8AaY87Uv76xl
	 GgIiZDI9lP/U+bh2cY/IKLlwrViEUR59GF5M2q1+Ph2ZownIi8vj6r0FMDWqyqulSaloGDx/qKLq
	 TSsQTdf8ScaWEwRJqiWZpQ8cnCW1FdSh1vCz8CIG+93x8T01gaLIa/eweYo4Wxy1Hp8+nRkmLXB2
	 JWfUHTL12RzVaTIIutEgjwTf0ERBtUX7vZkxgcvwi7tjfdJHNT4w8cRmrsZPN3XAPzXVE+taY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240619-hammock-drum-04bfc16a8ef6@spud>
Date: Wed, 26 Jun 2024 00:04:22 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <FA81E124-32CF-4158-AA34-1EA0B603B027@cyyself.name>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud>
 <20240619-hammock-drum-04bfc16a8ef6@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 19, 2024, at 18:45, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>=20
>> On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
>>> K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add =
initial
>>> support for it to allow more people to participate in building =
drivers
>>> to mainline for it.
>>>=20
>>> This kernel has been tested upon factory SDK [1] with
>>> k230_evb_only_linux_defconfig and patched mainline opensbi [2] to =
skip
>>> locked pmp and successfully booted to busybox on initrd with this =
log [3].
>>>=20
>>> [...]
>>=20
>> Applied to riscv-dt-for-next, thanks!
>>=20
>> [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
>>      https://git.kernel.org/conor/c/64cbc46bb854
>> [2/6] dt-bindings: add Canaan K230 boards compatible strings
>>      https://git.kernel.org/conor/c/b065da13ea9c
>> [3/6] dt-bindings: timer: Add Canaan K230 CLINT
>>      https://git.kernel.org/conor/c/b3ae796d0a4f
>> [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
>>      https://git.kernel.org/conor/c/db54fda11b13
>> [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
>>      https://git.kernel.org/conor/c/5db2c4dc413e
>=20
> After some discussion on the k1 thread
> (https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, =
https://lore.kernel.org/all/ZnA6pZLkI2StP8Hh@xhacker/)
> I am going to drop this series. It's not very useful in the current
> state and there's not really been any interest from people in getting
> the platform to a more complete state. Jisheng made some good points =
in
> the k1 thread about the missing clock controller stuff, and I think =
I'm
> going to make having basic things like clocks and where applicable
> resets and pinctrl the minimum requirement for the platforms I'm =
looking
> after.
>=20
> I've thrown these patches into my tree:
> =
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dk=
230-basic
>=20
> I do have one of these boards, but I'm fairly limited at the moment =
between
> the various linux-related and work demands on my time, so it's pretty
> unlikely that I'll do anything with it myself.
>=20

OK. I understand about this. I do some initial support for K230
only for my evaluation purpose and propose this tree to provide
information for others to boot up a minimal kernel and also have
another patch [1] to have a USB node so we will able to run a distro
like Debian over NFS rootfs by USB ethernet which is on canmv k230
board.

But I want to say I may have no time to do further driver development.
I have done this for my evaluation purpose to get some performance
metrics on real RVV chips for research usage since I=E2=80=99m a Ph.D.
student focused on computer architecture. I have to devote my time
to my research work.

If anyone wants to do some further driver development, please don=E2=80=99=
t
hesitate to do so. Don=E2=80=99t imagine I may be doing this, so you may
do duplicate work. I=E2=80=99m too busy to do that.

[1] =
https://lore.kernel.org/linux-riscv/tencent_E9B853316D217B8D1E7CDF8288DA5E=
8ED908@qq.com/

Thanks,
Yangyu Chen

> Thanks,
> Conor.


