Return-Path: <linux-kernel+bounces-217944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3C90B6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A8D282248
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5CD161904;
	Mon, 17 Jun 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NNOqrFRU"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0A1662F1;
	Mon, 17 Jun 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642393; cv=none; b=ryXUprTBpZUoVks629AFieo5aYwBYmY7gDTEDlVdAKsflKPuYVNuipKifVFmhe1Ogm0h+YnJBgDwt77aSObihXXZZRX95+YT+z/R4P103gpU8yhGR8SBtmGDLT0os30Re5x8IOgyORGwo8U7jvMmllMC24t3hfNLtw5OUYnzhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642393; c=relaxed/simple;
	bh=yWu5HGyod0Hqgkf/UB5zwjPSabjeuN52Zx4RwAv1beQ=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=BUJr9mcEEv8kN+ljAt4066JSaC2k6RA+l4iNVFcZ1uRMNlAP2yz+pO3djEouBd+QUNsB1yFCBir0RSJ03kvPkYG2qs39iYmQemjg1JkYKCHR4XuL45wToLEulim7gSfYOIckIsXUbnoPFcdu64U3QBTgWJBDcdvmi0LjjfIOXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NNOqrFRU; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718642387; bh=BebjWnIfbICzDDv9y7lrGwILWCLv2pqxrduvH9z3ffQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=NNOqrFRUTLwoMJjNpWfQdQROXWYNG7m4M1XE74I8ekkw/M3O1ZgCkS+nL74hJs421
	 2rNKY+oLd4u7flDdqG4+OYImh4A2vIaF1oIldrw+dilHloftG7wwoI7LMWETE57tfq
	 Q0PbIooch1TxmEeD9Le1WQMlDgpnbDTTviKLQ7vg=
Received: from smtpclient.apple ([2408:8207:18a1:9700:9c85:7ae:3ee:45fe])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 9EB21275; Tue, 18 Jun 2024 00:39:43 +0800
X-QQ-mid: xmsmtpt1718642383toizuvsk4
Message-ID: <tencent_26E7381EE1F6C5188428359AF3F908CA680A@qq.com>
X-QQ-XMAILINFO: OaubouGXmhNz1eavt//OG67Ozorm+d9p6vpUKabw3YPJTuKPcNJ8Ij2qUZMBFa
	 nVKydnjfymoPQ/5j+JNvKXHTDtEn27QluWmav9cFNNYIy8GxuEcsp5NA3ziH7FpT0SSVYGhGl/04
	 KFpeXGdnURvFsGES0B7ETFALeC1Q8+tdXgtqNHDIDTXWCW02rMdXB4dsIVPSkubVSqqn6emNmjuO
	 KJe8JXP14+HqHNStw+xT0oMUz/Wcw+HQmOTt1spd7p0pvR9EwyS9aQdP7bNC61tUYKJaV++UlMew
	 4NrNR8o+3mAvTbQ7Chxp7a3OI+wdK3wY9fpKn2ANTzgA2HRySX5ApkMh+dFB/DqE43kq5tcDYd89
	 8POo74IIMKVzWAb3O0BCiB18oUMPc0vob1EGCz7LzogyQSk+xDB0QdHCgMP/ffIKsMS5fo3flxX1
	 X8CXctOKFk0N8EfKyXeWj3afsO3B0/oG1DvR4R0RcNEoBq0LBX7jNjazRNOFbFQ6WN7BgNsbLsS3
	 7XXEPW3yR1vyJ8xJHG4L1am67XBlaZijzRSs8exUgRQSSxbbTXQG+BrNGe3XXR899VZkiougTPl3
	 tlcLLEMSITBGknSqFUvAezFY7B0XQ4wi+zKVyNyhj++zliEAEvH0wozMMsKW9xRgYSns2E75wEkX
	 MgOtkHHp1NQz+3hvgY3BJCYjIoK1MkMgpVFRSEK8PstUNGY8GLryRGcxIMuz/reZlg/zS3imjhZU
	 1Gajcx55fnXhPmuPYewNRH48KGHa1oumc/eJYXkcqWTon3g6yzYWGZe9qFI2vast/hKnB5EGKfQX
	 yKVzyaTE/+hUrJBH258DJkv6JfJHa057EnYgk8cl/bMLylXsQFnNIXJ4eTyHsvLYEbWXtBzrgNQj
	 we/IiL38++khSKqFnTG9A4XRPqKUoslMFLXOqvKsMvAk8UydPq17phjMt/klF6HhPhhF63r5K1aA
	 zNoeIhn7ok1ydM3AdGEhJ8HLdL8eFP7Eq2mLPZbSPPorB/IQFCoA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240617-synapse-carmaker-0a59c7c6edb7@spud>
Date: Tue, 18 Jun 2024 00:39:30 +0800
Cc: Jisheng Zhang <jszhang@kernel.org>,
 Yixun Lan <dlan@gentoo.org>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup.patel@wdc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jesse Taube <jesse@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <452EAAE8-594D-4265-8100-D95EAAA970A0@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar> <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 17, 2024, at 23:32, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Mon, Jun 17, 2024 at 10:11:17PM +0800, Jisheng Zhang wrote:
>> On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
>>> Hi Conor
>>> Thanks for bringing this up
>>>=20
>>> On 19:35 Sun 16 Jun     , Conor Dooley wrote:
>>>> On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
>>>>=20
>>>> No MAINTAINERS update, so I figure that means you don't want to =
maintain
>>>> it going forwards? If there's someone out that that does care about =
the
>>>> spacemit k1 (Jesse maybe?), then I'd be more than happy to have =
them
>>>> look after it.
>>> Yangyu kind of has limited time, too many stuff for him..
>>>=20
>>> I'd volunteered to help on this if it can fill the gap
>>> Also I'd be more than happy if anyone willing step forward to =
co-maintain..
>>=20
>> Does maintainership work like this? Is willing to do enough?
>> FWICT, maintainership involves active patch contributing, reviewing =
and
>> maintaining the whole SoC. It is better to take over the =
maintainership
>> after showing enough patch contributions and understanding of the =
SoC.
>=20
> I was going to reply to your other patch about providing more complete
> "basic" support for the SoC, but I guess I'll reply here and address
> both points. After the k230 and th1520, which were both merged with =
very
> basic support and have made very little progress towards being a =
useful
> platform, I'm pretty reluctant to merge another platform in a super
> basic state. I was going to make this point before you brought it up,
> but it's good to know I am not the only one with that view. To be =
clear,
> I'm not pointing blame for those platforms, I'd just like to avoid a
> repeat. If Yangyu doesn't have time to do any development work on the
> platform, I'd like to see someone else (and as I mentioned Jesse is
> interested) take on getting some of the basic driver patches written =
and
> merge only when those are accepted. Having no in-tree clock and =
pinctrl
> drivers is definitely a hindrance to other people doing parallel
> development of drivers and I'd like to avoid that.
>=20

That's also my concern for the first time when I submitted initial
support for K230. However, for SpacemiT K1, things went differently
for its UART, and the vendor patched OpenSBI with their NOC-based
HSM. They didn't use CLINT-MSWI as SBI HSM driver.

The vendor uses a special intel pxa uart driver, marked deprecated
in the kernel and incompatible with ns16550. If we use ns16550 in
the dt, the behavior of uart is like the uart has no interrupt and
stops working permanently when fifo overruns, making many developers
not know how to start unless they use the SBI HVC console, which
needs to turn on CONFIG_NONPORTABLE.

For the OpenSBI, the vendor does not provide enough ISA string,
which their chip might support, such as Zicboz. Thus, the OpenSBI
does not correctly set up the corresponding M-Mode CSR, making the
kernel panic when the ISA string contains this extension.

These two things takes me about one week to get the initial mainline
kernel with full ISA extension and UART to work. Providing this
information in the commit message helps attract more developers to
start developing quickly.

I don't mind whether this series patch will be merged or not. The
meaning of this series is just providing these informations. However,
I think some details about bringing up a very basic kernel are
essential to attract more developers. If a platform has already
attracted some developer's attention. Providing initial support
with the commit message to show how to bring it up is not bad.

The point is that if a developer like me has already done this but
does not have much time to do further development, should the
developer become the maintainer? If not, should a developer submit
patches like this to the mailing list to provide this information
in the commit message and make it easier for other developers to
do further development?

> Getting back to your point in this mail, whoever gets the platform to
> that state is well suited to looking after it going forwards. Some =
other
> interested parties could also join as reviewers. I don't want to see
> people joining as maintainers that are not going to have an interest
> in the platform going forward, as that'll just end up with me as the
> defacto maintainer.
>=20

I agree. I also have no confidence in joining as a maintainer.
That's why I didn't change the MAINTAINERS for the first time.

Thanks,
Yangyu Chen


