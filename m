Return-Path: <linux-kernel+bounces-433444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD39E5879
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6593916ACF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D198218AB4;
	Thu,  5 Dec 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="YFjEehpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY3r6MBv"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3A17579
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408829; cv=none; b=KoirzE/d1mX/FZFPV7rcLJPzuLH3U1hjvuV9gJW1JFwGx4/khWa9fZOMw8nFdQ8X33q6Xjn3FkvrpwTuz5XPH+mu+6nZp9VvPs2owGfL8ETtsRLTMJ1sGuDVTSa5A7zcYVebvct+wbi+yD7/M5LtPrUcrLbmvVUcSFJekXvKpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408829; c=relaxed/simple;
	bh=vbuWrBi3xlmgnCoEMbdJm96eoqTA+mDaV197R1S3r2I=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=S4WncVhbUlBe712qqHBit+gTKToI7NHznlOH2y1LGYvhh/4jrX02u6TxEgbGmuc32SKoQKLPChkHXjVe5jJyAWDl6gF5JV3OgfVlqd/rrL3UctMg6ImbzkUZtC9d/LZSlbZTNTyK/qJR6SE1SmkolNP0SEI3dkWazgw8bphuE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=YFjEehpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY3r6MBv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 15E7C13820C9;
	Thu,  5 Dec 2024 09:27:05 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 09:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733408825; x=1733495225; bh=vbuWrBi3xl
	mgnCoEMbdJm96eoqTA+mDaV197R1S3r2I=; b=YFjEehpmdak6duqJfs4RblmBFR
	H7ClFwAvufVmBsFTIk3gDQlqBnmkToHPsVndFySaob7ytjeV/oeSaGzzVKXLqoAT
	s2awbwqxbUsA3t7BfHDi5AmMKJf90jXAMEmRxR7RBd0CST/ztZXi282xbZ10xUpK
	Hqi/kJ6o1qQMYfiSXRrP1VR14iKXmclQkBYuSw03TjoyBIPU1P+QMZ/quNpJAIkP
	Jjlkfaez9Fg20XIIoeMua5vvALIs99SIGZZspx+e7326QxbvYnMqGeZp9wc6/9PE
	PTPdOaZq0TPZFinib/mo54G0m3/G6E/x8rPEU/vkbDxR37PVjcMEGj6ABFUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733408825; x=1733495225; bh=vbuWrBi3xlmgnCoEMbdJm96eoqTA+mDaV19
	7R1S3r2I=; b=dY3r6MBvXGHGmMVKxRTfnYQnjTxkrm16Bja+D1saiFmuJ432rZO
	AtB2Jjx+g3Vnb4G9wYOJ/0PPDBkI3J8IHie05B5ddSH6UEXqXIWLXORT5ztHwLhx
	6IDCP1KPAK5D6KCRvvpA2RU7NoNjsuOWHIG7bpbmdL8GtDy6LgCLfNEWKg+3IQcO
	YpwAvCqQTOus5/xfpvTPr00CcwRG8G/5ysiBNjQpJpVcWJksHfHdWGnzziKzVRUk
	QyU12nAyYrGe3yIGpbDZ1y/GH4kHdkwGr5k0kMujUuI272gL6z4Pcxavw7LZ6XrT
	/w0WrI5M0kjfHH4rXG5NYoFZulg+lhrM4mQ==
X-ME-Sender: <xms:OLhRZ58m5NWTvcqgyAwOsJxUvDnfV3j1mrIZLF5SNkEoebccDd9udQ>
    <xme:OLhRZ9tnYdF96FJ9c1kyenusFkNV-QHX8vJWkXDEOK18bw4SlUk43KubuzdoATXq7
    CwKbNdvSX74yeJYyrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofgtggffkf
    fuhffvofhfjgesmhdtreerredtjeenucfhrhhomhepfdforgiiihhnucetlhhhrgguuggr
    ugdfuceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpe
    ekgffgtefgjeehffeiveelveegfedtheekueffffelleeffeeitdettedugfffvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgriihinhesghgvthhsthgrthgvrdguvghvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiikhgrlh
    hlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepshih
    iigsohhtodegjeelrghffhehudgssgefieduvghfhegrrgdukeesshihiihkrghllhgvrh
    drrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OLhRZ3BSDEkMOYvQ-iB5aA9v8jAaf8Uh7ZBbQB0PgI30Yalwp0vDxA>
    <xmx:OLhRZ9clc5BFF0Rw9oAnscwHmrG0IjQFwcgc0VqisRsE82nZeu_u6w>
    <xmx:OLhRZ-MKfoW3BnBw0wLIc0wEnTy5VA3pM5BT_RldOJehJgZCZFR9_Q>
    <xmx:OLhRZ_kwnXjVqTpwTjHIPVYyDfIpq6Os67yFTBM-m-Lo904rsQR2tw>
    <xmx:ObhRZ3ZxnMrcXNdgJTqMSlE83p-KGZInd8dcZ3OvLm294K8ij6n31-Xl>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC1441C20067; Thu,  5 Dec 2024 09:27:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=e1e410b999e669fad1e099ff84a4674ce9801619977bb0e30d8f7d83c5e9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 17:26:56 +0300
Message-Id: <D63U54UUGORX.2CRU0YBACQARS@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63TE6HWP7IF.2VGLGANFA6OGW@getstate.dev>
 <6751b43b.050a0220.b4160.01d5.GAE@google.com>
In-Reply-To: <6751b43b.050a0220.b4160.01d5.GAE@google.com>

--e1e410b999e669fad1e099ff84a4674ce9801619977bb0e30d8f7d83c5e9
Content-Type: multipart/alternative;
 boundary=e0a970c926e37a078c7f1681e4b2bb4b799bf20abc69110f923dc9798f2c

--e0a970c926e37a078c7f1681e4b2bb4b799bf20abc69110f923dc9798f2c
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--e0a970c926e37a078c7f1681e4b2bb4b799bf20abc69110f923dc9798f2c--

--e1e410b999e669fad1e099ff84a4674ce9801619977bb0e30d8f7d83c5e9
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSAzMjliZmRiYjRmMDk2OTYxNzMwZGZjMWU3NmRmNzliZWVlMTlmOGY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMTY6MDA6MDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0
b290aC9oY2lfc3luYy5jIGIvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCmluZGV4IGM4NmY0ZTQy
ZS4uYWE1YWEzZmVkIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKKysrIGIv
bmV0L2JsdWV0b290aC9oY2lfc3luYy5jCkBAIC01MTk3LDYgKzUxOTcsOSBAQCBpbnQgaGNpX2Rl
dl9jbG9zZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCSAqLwogCWRyYWluX3dvcmtxdWV1
ZShoZGV2LT53b3JrcXVldWUpOwogCisJLyogZmx1c2ggY21kICB3b3JrICovCisJZmx1c2hfd29y
aygmaGRldi0+Y21kX3dvcmspOworCiAJaGNpX2Rldl9sb2NrKGhkZXYpOwogCiAJaGNpX2Rpc2Nv
dmVyeV9zZXRfc3RhdGUoaGRldiwgRElTQ09WRVJZX1NUT1BQRUQpOwpAQCAtNTIzNCw4ICs1MjM3
LDYgQEAgaW50IGhjaV9kZXZfY2xvc2Vfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldikKIAkJY2xl
YXJfYml0KEhDSV9JTklULCAmaGRldi0+ZmxhZ3MpOwogCX0KIAotCS8qIGZsdXNoIGNtZCAgd29y
ayAqLwotCWZsdXNoX3dvcmsoJmhkZXYtPmNtZF93b3JrKTsKIAogCS8qIERyb3AgcXVldWVzICov
CiAJc2tiX3F1ZXVlX3B1cmdlKCZoZGV2LT5yeF9xKTsKLS0gCjIuNDYuMAoK
--e1e410b999e669fad1e099ff84a4674ce9801619977bb0e30d8f7d83c5e9--

