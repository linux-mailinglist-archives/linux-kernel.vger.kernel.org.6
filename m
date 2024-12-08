Return-Path: <linux-kernel+bounces-436460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D619E861A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EB4164863
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB415667B;
	Sun,  8 Dec 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="GKXn5sbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrL5GIxJ"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE114F9FF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673402; cv=none; b=WmGdUaeA+Z+zdXVnj1plbMGHyhNvHW/ZuU0vz/xTz9iwOxfxsDBMMp+pXGtnCP15J2QlS1VDa10bysEgY22zGjZwgJlYJWJgehl0trjJn9mVa18S2noeAzZbV7RT1jP4u9G3+eZjHaOzja/MoIj6bNjpwiMH8ZgXUYg8UHVZOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673402; c=relaxed/simple;
	bh=xcg7Y1+vUzUfTNCWE0j+csz4cLkiFIcmYnQRbFWRKSY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=hfCi4UCYJ6ha4L5+8xIkuWBfJzcds39OfEXt9k6i2KB+ky4w93MQEJcSMB/MgqBrMh9INYdE/ij1V+f9hBZc4IgHNhiVIY0OuhOoMR4RHV9AC9hmSx3LYP7E5onZ4XEB/DWjd7ueXWo2S2SoWS7QzQqeqsfE56nqXUqDHczh6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=GKXn5sbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrL5GIxJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB918114011B;
	Sun,  8 Dec 2024 10:56:38 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Sun, 08 Dec 2024 10:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733673398; x=1733759798; bh=xcg7Y1+vUz
	UfTNCWE0j+csz4cLkiFIcmYnQRbFWRKSY=; b=GKXn5sbdW5kkjA6drKeYVPafDH
	XgWw5he8QmYbY3fD7/QbSakMK041sw/6TwJKkbUiTk8GcAs2dNGzvPrzJt7w1QPc
	EJG5yw+hhoxt6QRZkGjYg06towAzQ6vVCsH8Z7jIko2RY/IM1/3tmX04MolmjXao
	UuiJoQZjCCcUICz/R29hXl6LDyg1rmVTq3O54QSASRvV8rJ5MmG0934szAlarlxn
	fSIAA236cUae2HhQi/grnTECPngs4cG043qbxt0YqGPEOI7taL3o0GtrcteF55Jd
	URuTKsTJQzkEBD3pZpk/mfz0/JtkeEt6yhGb7EWfZEafaNGq+2HBDOuMS/iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733673398; x=1733759798; bh=xcg7Y1+vUzUfTNCWE0j+csz4cLkiFIcmYnQ
	RbFWRKSY=; b=NrL5GIxJ1l4IIHGIedx8eys/u8FkFB7HXy6rDbh2j2S8MVV013x
	HOYN5ZEiC9N48UKHUG11oxE3cGF9DwGLS1kAMSE4AVPir8knJ3ljNfq2emMj3buh
	Q6nZm/hrYuzRt1mHpHyGZS1bjDrA3HhBxptm+2lPAvkB7SiAubSlkcWWXzIpdAwd
	GQ71FvV6WTmj/TdXZcxF+vPAfJFCE8nOnCeSt/9z62nXDxITRahiZNvb72e7HgEu
	jQPkQ0FJAnURyvBpNNZGFeKw8ACHdm+mE9eGA3a/kOTv/lWnuwNali3XcFJe4vUi
	+fCW/qkd/A2cvJ/o4ITJHv1Gri97IbxlJBA==
X-ME-Sender: <xms:tsFVZ725Ui1rSUHJpbyjgaR9S6ByQN3oaCQ3RDS12Cv92Bgk2j26FQ>
    <xme:tsFVZ6H_Sgdu_rNcosTq5inSYLhh-5wZkSq_a7COKDcPVd7wHO0dCC3y2_QqT5ABu
    qkdTe0mMBGuFuBRrC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdekvdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:tsFVZ77VZboqQEarT5H2GoWMA9e1xdFZ_FTaFsDBjmQ1ULJ2-G_Gfg>
    <xmx:tsFVZw0icO88QL9e7S-guuPryywUBvW0Rbmh4cvZbMoz-eH2CUFdzw>
    <xmx:tsFVZ-HxlZclAq2XPwAjqUPiHGYqi082G4zuehwe-h5cBn-O_r2V3Q>
    <xmx:tsFVZx-_etzuMnu77s0WmAdXPrcIEIuKbqKG8zZvT9cEAs60sLHyOw>
    <xmx:tsFVZzT63hzLIzKp15oG3UsH68J-JDdVOuKQAWrkVjWy8q4lBM1oOvRX>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 756701C20066; Sun,  8 Dec 2024 10:56:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=1c30941c5254062c93d3b128b50a520d6bce1a927ab6948729f7a3da0461
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 08 Dec 2024 18:56:37 +0300
Message-Id: <D66FXFUEV6V3.3SKKXVBD0Q1OY@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63VY8C6B77L.2EEUFPWVWLWFB@getstate.dev>
 <6751d7db.050a0220.b4160.01db.GAE@google.com>
In-Reply-To: <6751d7db.050a0220.b4160.01db.GAE@google.com>

--1c30941c5254062c93d3b128b50a520d6bce1a927ab6948729f7a3da0461
Content-Type: multipart/alternative;
 boundary=32cea76254544f5e6465864e986ea3540cbb46b7f5d02db6afc08b55aa93

--32cea76254544f5e6465864e986ea3540cbb46b7f5d02db6afc08b55aa93
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--32cea76254544f5e6465864e986ea3540cbb46b7f5d02db6afc08b55aa93--

--1c30941c5254062c93d3b128b50a520d6bce1a927ab6948729f7a3da0461
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSA0ZjU0MDdjODQ3NGVkNjc0N2Q2MTQxMmI5MTVjOTQ5ZDlkOWM2ODA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBTdW4sIDggRGVjIDIwMjQgMTg6NTI6NTQgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8ICA1ICsrKy0tCiBuZXQvYmx1ZXRvb3Ro
L21nbXQuYyAgICAgfCAxMiArKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9z
eW5jLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggYzg2ZjRlNDJlLi5hYTVhYTNm
ZWQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQvYmx1ZXRv
b3RoL2hjaV9zeW5jLmMKQEAgLTUxOTcsNiArNTE5Nyw5IEBAIGludCBoY2lfZGV2X2Nsb3NlX3N5
bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJICovCiAJZHJhaW5fd29ya3F1ZXVlKGhkZXYtPndv
cmtxdWV1ZSk7CiAKKwkvKiBmbHVzaCBjbWQgIHdvcmsgKi8KKwlmbHVzaF93b3JrKCZoZGV2LT5j
bWRfd29yayk7CisKIAloY2lfZGV2X2xvY2soaGRldik7CiAKIAloY2lfZGlzY292ZXJ5X3NldF9z
dGF0ZShoZGV2LCBESVNDT1ZFUllfU1RPUFBFRCk7CkBAIC01MjM0LDggKzUyMzcsNiBAQCBpbnQg
aGNpX2Rldl9jbG9zZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCQljbGVhcl9iaXQoSENJ
X0lOSVQsICZoZGV2LT5mbGFncyk7CiAJfQogCi0JLyogZmx1c2ggY21kICB3b3JrICovCi0JZmx1
c2hfd29yaygmaGRldi0+Y21kX3dvcmspOwogCiAJLyogRHJvcCBxdWV1ZXMgKi8KIAlza2JfcXVl
dWVfcHVyZ2UoJmhkZXYtPnJ4X3EpOwpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tZ210LmMg
Yi9uZXQvYmx1ZXRvb3RoL21nbXQuYwppbmRleCBiMzExOTJkNDcuLmI0MTc3NTZhYyAxMDA2NDQK
LS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2JsdWV0b290aC9tZ210LmMKQEAg
LTU1MTksOSArNTUxOSwxNyBAQCBzdGF0aWMgdm9pZCBtZ210X3JlbW92ZV9hZHZfbW9uaXRvcl9j
b21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHsKIAlzdHJ1Y3QgbWdtdF9ycF9yZW1vdmVf
YWR2X21vbml0b3IgcnA7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7Ci0J
c3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07CisJc3Ry
dWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcDsKIAogCWhjaV9kZXZfbG9jayhoZGV2
KTsKKwkvLyBpZiBjYWxsZWQgd2hpbGUgZGV2aWNlIGlzIGNsb3NpbmcsIHN0YXR1cyB3aWxsIGJl
IGludmFsaWQuCisJLy8gYW5kIGNtZCBpcyBjbGVhcmVkIGJ5IF9fbWdtdF9wb3dlcl9vZmYKKwlp
ZiAoc3RhdHVzID09IC1FSU5WQUwgfHwgY21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1JFTU9W
RV9BRFZfTU9OSVRPUiwgaGRldikpeworCQloY2lfZGV2X3VubG9jayhoZGV2KTsKKwkJcmV0dXJu
OworCX0KKworCWNwID0gY21kLT5wYXJhbTsKIAogCXJwLm1vbml0b3JfaGFuZGxlID0gY3AtPm1v
bml0b3JfaGFuZGxlOwogCkBAIC01NTQwLDYgKzU1NDgsOCBAQCBzdGF0aWMgdm9pZCBtZ210X3Jl
bW92ZV9hZHZfbW9uaXRvcl9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHN0YXRpYyBp
bnQgbWdtdF9yZW1vdmVfYWR2X21vbml0b3Jfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9p
ZCAqZGF0YSkKIHsKIAlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKKwlpZiAo
Y21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1JFTU9WRV9BRFZfTU9OSVRPUiwgaGRldikpCisJ
CXJldHVybiAtRUlOVkFMOwogCXN0cnVjdCBtZ210X2NwX3JlbW92ZV9hZHZfbW9uaXRvciAqY3Ag
PSBjbWQtPnBhcmFtOwogCXUxNiBoYW5kbGUgPSBfX2xlMTZfdG9fY3B1KGNwLT5tb25pdG9yX2hh
bmRsZSk7CiAKLS0gCjIuNDYuMAoK
--1c30941c5254062c93d3b128b50a520d6bce1a927ab6948729f7a3da0461--

