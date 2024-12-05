Return-Path: <linux-kernel+bounces-433590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846099E5A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F61716AF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D81218853;
	Thu,  5 Dec 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="E9H4F2Ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azk6D2O6"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBC1DA602
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413930; cv=none; b=IfvkjhGUIywayM0EDf90ABJTyaK3IDnRH3VvIe33N+dKtk/5PiDJMkRam67BCjp0DbqPfcT3kkNXzYPvcOgmgrZ10r2tFhHDicGn6vfCJkXdfDm9BFUGYXnP+EhZBU2Gz2zpYxmgTKSdDvjDvUalXG8FBuI8nomIGRSfwPtH6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413930; c=relaxed/simple;
	bh=OZQCEOsZviOt/+gEERCgtV6QQsCALDDyAuaswMWO90M=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=GUdfd44UOe+LXLbDhcLQwtqwi7jyyAjov1//1dDWsBuWW2YXYBOcmERkJJkfystYhuadb4EFZ3L3FE7Rn0WS6qyrBHo9p2qZA9MBhZQ78FhnWPExDReFNK4t2Xk2W5AUAgYvraprw/pD/qM/E0tvQ5bjy33AyuUvlahrYZwaLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=E9H4F2Ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azk6D2O6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 680A9114013D;
	Thu,  5 Dec 2024 10:52:06 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 10:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733413926; x=1733500326; bh=OZQCEOsZvi
	Ot/+gEERCgtV6QQsCALDDyAuaswMWO90M=; b=E9H4F2RioJ6rBtPLBJRkaIheE7
	Yo6Qsv0ybnaOdqkJs0EtDw2mhhWslyxx/GGcvMZExyOkbOl2uWnzc1tKEx169Jso
	qSkwMWqvFJOYNA97lLSf6CgSTzcSzhR292Fe5kZvXplg/TXaEWaDXcDCY3OHEKnt
	U1yZLcd2tEHQD0q1eSA2HxhZqHuY09AhCxOhLS3zQPru++ctxlkj9ITAv+UEGJPs
	KJaIm47pn8BnjTdmsZ+TT5X0EDSCCdknvzMUbrAjcy8MDES5alA7RtCpqR1v9TKo
	AaiwJJ02Wq54tS49m0kQkaXjaOufId2xDwE8sV/a+TRc84RHYMIfKTzUb8iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733413926; x=1733500326; bh=OZQCEOsZviOt/+gEERCgtV6QQsCALDDyAua
	swMWO90M=; b=azk6D2O6OYY2Z5q/kBoXFEuPBXfZRLRtK3C1PaAHM7gGjAJ8CBM
	/ZgjdA+y9ZRM9ktsyvQQ51bA6rH6iFggg8A/XlDxsncnmnx65wQ6RFw7QpGZqZIu
	YhT2yfNM4W6yTZOXtR8JP/Fh8aQLMGC62vIdMuJGMNL0BpYCZHJpWW04n1VEDhKt
	FxZNtOWXZnB32hmu5VK4YHvkmbqs30TmHyABxrowFhlbzO/bP9xCU3BTlFIE/KSH
	3gGZOaIEqAgsTXvkM0TljVQB4s6pw+lpot2231gH2695GhfV6PX1y4FRXIBNRtQT
	qX/YwW5DQR+pdm9QssEwJ7MhkQfOYWHqlkg==
X-ME-Sender: <xms:JsxRZ-tRqlZa0Gd9ytOGpBn1NloM25QBriBKkvDwOT-f7doq83xxfg>
    <xme:JsxRZzcfuIJ_5okwhsQ_DIQQMOFhu5rXHqP5U_LHWNtBGAknuYTeORTsoj2P5qrPg
    RUGKFAVgyOzyQ0qssE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofgtggffkf
    fvuffhofhfjgesmhdtreerredtjeenucfhrhhomhepfdforgiiihhnucetlhhhrgguuggr
    ugdfuceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhgeekkeeileettdfhtdekheefleekuefhhfdtteejteffkefghfekteeiteekudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgriihinhesghgvthhsthgrthgvrdguvghvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiikhgrlh
    hlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepshih
    iigsohhtodegjeelrghffhehudgssgefieduvghfhegrrgdukeesshihiihkrghllhgvrh
    drrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JsxRZ5wMhYRx9wsidLa8UZP3LZGPZOSFzoVfKFCYTg3HhLGc65M5WQ>
    <xmx:JsxRZ5PyrSIMy7cZRrpS1FObA0OgazA3e6Vb9DbIo5oJoLfP3tfq6w>
    <xmx:JsxRZ-8eyGGWWy1Q3RkgvwP9x7aD6rg5LvF5R8zhYFc7DTdmHDm42g>
    <xmx:JsxRZxWCOrWyK1v_IMatTutSz9YAmGwYmniCzn39oUFHgYE9w8B-VQ>
    <xmx:JsxRZwJ7WIwjWBxAIKiOochR8K1dwiF01ITZRCB3JCuw1mNxoynr6uld>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1ED1B1C20067; Thu,  5 Dec 2024 10:52:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=f5e7387a293e7bf68846c8ea59650aaac8df31b4baa3676f28af4998e347
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 18:51:57 +0300
Message-Id: <D63VY8C6B77L.2EEUFPWVWLWFB@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
X-Mailer: aerc 0.18.2
References: <D63U54UUGORX.2CRU0YBACQARS@getstate.dev>
 <6751c15a.050a0220.b4160.01d7.GAE@google.com>
In-Reply-To: <6751c15a.050a0220.b4160.01d7.GAE@google.com>

--f5e7387a293e7bf68846c8ea59650aaac8df31b4baa3676f28af4998e347
Content-Type: multipart/alternative;
 boundary=7102c5f40c199438a4a4798cd3f5cf3776cd633b177e842fa52dc60f6425

--7102c5f40c199438a4a4798cd3f5cf3776cd633b177e842fa52dc60f6425
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--7102c5f40c199438a4a4798cd3f5cf3776cd633b177e842fa52dc60f6425--

--f5e7387a293e7bf68846c8ea59650aaac8df31b4baa3676f28af4998e347
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSBmZTEwMzM3N2ZkM2I0Mzg4ZGFjMzJhMWNjYzkzY2FhMzc2MmY2ZjhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMTY6MDA6MDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYyB8IDIgKysKIG5ldC9ibHVldG9vdGgvaGNp
X3N5bmMuYyB8IDUgKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuYyBiL25ldC9i
bHVldG9vdGgvaGNpX2NvcmUuYwppbmRleCBmOWUxOWY5Y2IuLjZiYTJiOTUwMSAxMDA2NDQKLS0t
IGEvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvaGNpX2NvcmUu
YwpAQCAtNDc4LDYgKzQ3OCw4IEBAIGludCBoY2lfZGV2X2RvX2Nsb3NlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2KQogCiAJQlRfREJHKCIlcyAlcCIsIGhkZXYtPm5hbWUsIGhkZXYpOwogCisJaGNpX2Nt
ZF9zeW5jX2NsZWFyKGhkZXYpOworCiAJaGNpX3JlcV9zeW5jX2xvY2soaGRldik7CiAKIAllcnIg
PSBoY2lfZGV2X2Nsb3NlX3N5bmMoaGRldik7CmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hj
aV9zeW5jLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggYzg2ZjRlNDJlLi5hYTVh
YTNmZWQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQvYmx1
ZXRvb3RoL2hjaV9zeW5jLmMKQEAgLTUxOTcsNiArNTE5Nyw5IEBAIGludCBoY2lfZGV2X2Nsb3Nl
X3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJICovCiAJZHJhaW5fd29ya3F1ZXVlKGhkZXYt
PndvcmtxdWV1ZSk7CiAKKwkvKiBmbHVzaCBjbWQgIHdvcmsgKi8KKwlmbHVzaF93b3JrKCZoZGV2
LT5jbWRfd29yayk7CisKIAloY2lfZGV2X2xvY2soaGRldik7CiAKIAloY2lfZGlzY292ZXJ5X3Nl
dF9zdGF0ZShoZGV2LCBESVNDT1ZFUllfU1RPUFBFRCk7CkBAIC01MjM0LDggKzUyMzcsNiBAQCBp
bnQgaGNpX2Rldl9jbG9zZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCQljbGVhcl9iaXQo
SENJX0lOSVQsICZoZGV2LT5mbGFncyk7CiAJfQogCi0JLyogZmx1c2ggY21kICB3b3JrICovCi0J
Zmx1c2hfd29yaygmaGRldi0+Y21kX3dvcmspOwogCiAJLyogRHJvcCBxdWV1ZXMgKi8KIAlza2Jf
cXVldWVfcHVyZ2UoJmhkZXYtPnJ4X3EpOwotLSAKMi40Ni4wCgo=
--f5e7387a293e7bf68846c8ea59650aaac8df31b4baa3676f28af4998e347--

