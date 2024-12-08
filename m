Return-Path: <linux-kernel+bounces-436538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897E9E8744
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B589E280FFD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50637189B84;
	Sun,  8 Dec 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="Kd41ww8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVVsrvii"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBD1EA65
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682290; cv=none; b=Y7Eubpenr6HU/ff0bKQQo8t9sF8oRrc4C+OZGG/p3o191DzZ/I4RL0+u0ZnomqGYClUDzjNYF3CxiKuM+XOam1Uha08Sld4bTXtmN2/eLdBxdneN/O5w4Aj8NGmKXt3v/iWzEimT4QopXEJFi9A07gv6rCvy5CNn3G/dP+/bP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682290; c=relaxed/simple;
	bh=D9MvZn/jOWe9usRgRlLD0dwf4+Ator1VHzOdXGlA+Sw=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=WysTtKvvcBMMMJvhhi4Y+M6zG2bn9RZPUqnjXhlw3f38Fb9AYe4Y2vqOWhN5Qy6UNRPN7v8t60fWuqop/1K0wkzoFIoq1jV2U6PJBo9utkbvFS12J91CrH1a04AjvnH4bA+OHJYjX5PADb5yX3tNmQzvXCpHzOybqYG4P+dyQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=Kd41ww8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVVsrvii; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9907011400EC;
	Sun,  8 Dec 2024 13:24:45 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Sun, 08 Dec 2024 13:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733682285; x=1733768685; bh=D9MvZn/jOW
	e9usRgRlLD0dwf4+Ator1VHzOdXGlA+Sw=; b=Kd41ww8erfgzLpf5jHs2iHGNk9
	Qfg6Y9/+jaa3xUcaKW805lY7KuohVzw3JpmvwOd2uRPipfjIJdtbBV553VR7UPj6
	H0pKkXivSUSkoIXdCB1RIznMMkq5suVj/K/NLfnDBFlaxGqiGS6YrHVv3Vv5XgDl
	RrvjrvQnEes3lqVZNMO/bxKEkde+QCGQ5oZp5dHHvp4F0cB1yyAdLeL0fR5trOoP
	Pk+Gr61QGJGcebWSEtsnoJnF0NbzYGS+Nmj+3VtJ5nFcAf5b7bSHNaiTT9+rZxIH
	eOzmZl6lgCDjF1fhWk9ud5w5mUFPv+6y76qAzK9jbP+SQ53YeLy7Fiyf35HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733682285; x=1733768685; bh=D9MvZn/jOWe9usRgRlLD0dwf4+Ator1VHzO
	dXGlA+Sw=; b=aVVsrviigq0tnNys6J2bniUHaMLfO8IqzjM+wUGVOnvojivJfdA
	QY5xN1KzQ5ung/Zb674cZ0SwFbuxM/HpuBxnuOITPnzfj5oLiEovszd/Fox0aq8I
	eZznZYfxiOMSL319K8o0dfgg/oZD76RJaoT8pZykx4sWxYxzR8X0Y8l9MPo1AAl6
	IcYyycdhcPDhE9BvgZm2uTUM1DJY65pxLqmVvcnKm9KmVFJgo3AHMcNKePmUrgM7
	3Nuadqq59gayGJzunG2gE6I7uxL/iD2Oq2jNiTL9i/UcWMEYlgFzOvgmBUyECa+A
	aQHdVfwxebLjgQS0Rs2xsMFyAv1Wu1KUyPg==
X-ME-Sender: <xms:beRVZxLOaiasxYh5DeN5DWQ2QB-ZICDc1NwW2hON9wcJZ01sxko2qw>
    <xme:beRVZ9IFLC0FMbVLrczgAQGmfWrWRozTr22iAqMe2hbhM1u5VHzHTiQTKYNkkw5BJ
    JqIAI4GdHUmIpy4qs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefotgggff
    fkvffuhffofhgjsehmtderreertdejnecuhfhrohhmpedfofgriihinhcutehlhhgruggu
    rggufdcuoehmrgiiihhnsehgvghtshhtrghtvgdruggvvheqnecuggftrfgrthhtvghrnh
    ephfegkeekieeltedthfdtkeehfeelkeeuhffhtdetjeetffekgffhkeetieetkedunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgiiihhnsehgvghtshhtrghtvgdruggvvhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshihiihkrg
    hllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehs
    hiiisghothdogeejlegrfhhfhedusggsfeeiudgvfhehrggrudeksehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:beRVZ5t-8TlahycogabdKgD4fp049gSA1MhSwxVNPTtqtlzJcatb-g>
    <xmx:beRVZyaWWQn71mes9K5n7uPJho2sxTQ4YYLZhXDaXRXxLVz7oY1UlQ>
    <xmx:beRVZ4bWVhOwTDkQMO3a0KBITwqKgiTHlL8Wxu5FhC_LMGbXgdbMAQ>
    <xmx:beRVZ2BXJLmKwUyIhvd32fPKZLFsD2wVHsyDlJFMelH2eDjmplBNDQ>
    <xmx:beRVZ3nul2VyH8fXAG8rM9HQtzSNfFr5JbSDLI9ZMcBt1iwtr-xW3Xuw>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23E641C20066; Sun,  8 Dec 2024 13:24:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=86e67f2b77acc9c351e12f921f9b02ae66164f2a1446e1df757cc62f4b6c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 08 Dec 2024 21:24:44 +0300
Message-Id: <D66J2UCA2K95.14GOLVW7ECBK2@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
X-Mailer: aerc 0.18.2
References: <D66FXFUEV6V3.3SKKXVBD0Q1OY@getstate.dev>
 <6755cc1f.050a0220.2477f.002b.GAE@google.com>
In-Reply-To: <6755cc1f.050a0220.2477f.002b.GAE@google.com>

--86e67f2b77acc9c351e12f921f9b02ae66164f2a1446e1df757cc62f4b6c
Content-Type: multipart/alternative;
 boundary=07f00825c2890c3ba9d987d635e063c8a0f64160e71e4a767e60a9b42f2e

--07f00825c2890c3ba9d987d635e063c8a0f64160e71e4a767e60a9b42f2e
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--07f00825c2890c3ba9d987d635e063c8a0f64160e71e4a767e60a9b42f2e--

--86e67f2b77acc9c351e12f921f9b02ae66164f2a1446e1df757cc62f4b6c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSBmM2EwYTY4ZjE1MGYyYWEzMzNiMTgyMmYwYjBmY2YxMDNmYjUyMDljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBTdW4sIDggRGVjIDIwMjQgMTg6NTI6NTQgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8ICA1ICsrKy0tCiBuZXQvYmx1ZXRvb3Ro
L21nbXQuYyAgICAgfCAxMyArKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lf
c3luYy5jIGIvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCmluZGV4IGM4NmY0ZTQyZS4uYWE1YWEz
ZmVkIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKKysrIGIvbmV0L2JsdWV0
b290aC9oY2lfc3luYy5jCkBAIC01MTk3LDYgKzUxOTcsOSBAQCBpbnQgaGNpX2Rldl9jbG9zZV9z
eW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCSAqLwogCWRyYWluX3dvcmtxdWV1ZShoZGV2LT53
b3JrcXVldWUpOwogCisJLyogZmx1c2ggY21kICB3b3JrICovCisJZmx1c2hfd29yaygmaGRldi0+
Y21kX3dvcmspOworCiAJaGNpX2Rldl9sb2NrKGhkZXYpOwogCiAJaGNpX2Rpc2NvdmVyeV9zZXRf
c3RhdGUoaGRldiwgRElTQ09WRVJZX1NUT1BQRUQpOwpAQCAtNTIzNCw4ICs1MjM3LDYgQEAgaW50
IGhjaV9kZXZfY2xvc2Vfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldikKIAkJY2xlYXJfYml0KEhD
SV9JTklULCAmaGRldi0+ZmxhZ3MpOwogCX0KIAotCS8qIGZsdXNoIGNtZCAgd29yayAqLwotCWZs
dXNoX3dvcmsoJmhkZXYtPmNtZF93b3JrKTsKIAogCS8qIERyb3AgcXVldWVzICovCiAJc2tiX3F1
ZXVlX3B1cmdlKCZoZGV2LT5yeF9xKTsKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdtdC5j
IGIvbmV0L2JsdWV0b290aC9tZ210LmMKaW5kZXggYjMxMTkyZDQ3Li42NjFiYmU3ZTAgMTAwNjQ0
Ci0tLSBhL25ldC9ibHVldG9vdGgvbWdtdC5jCisrKyBiL25ldC9ibHVldG9vdGgvbWdtdC5jCkBA
IC01NTE5LDkgKzU1MTksMTggQEAgc3RhdGljIHZvaWQgbWdtdF9yZW1vdmVfYWR2X21vbml0b3Jf
Y29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsCiB7CiAJc3RydWN0IG1nbXRfcnBfcmVtb3Zl
X2Fkdl9tb25pdG9yIHJwOwogCXN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOwot
CXN0cnVjdCBtZ210X2NwX3JlbW92ZV9hZHZfbW9uaXRvciAqY3AgPSBjbWQtPnBhcmFtOworCXN0
cnVjdCBtZ210X2NwX3JlbW92ZV9hZHZfbW9uaXRvciAqY3A7CisJCisJaWYgKHN0YXR1cyA9PSAt
RUlOVkFMIHx8IGNtZCAhPSBwZW5kaW5nX2ZpbmQoTUdNVF9PUF9SRU1PVkVfQURWX01PTklUT1Is
IGhkZXYpKXsKKwkJcmV0dXJuOworCX0KIAogCWhjaV9kZXZfbG9jayhoZGV2KTsKKwkvLyBpZiBj
YWxsZWQgd2hpbGUgZGV2aWNlIGlzIGNsb3NpbmcsIHN0YXR1cyB3aWxsIGJlIGludmFsaWQuCisJ
Ly8gYW5kIGNtZCBpcyBjbGVhcmVkIGJ5IF9fbWdtdF9wb3dlcl9vZmYKKwkKKworCWNwID0gY21k
LT5wYXJhbTsKIAogCXJwLm1vbml0b3JfaGFuZGxlID0gY3AtPm1vbml0b3JfaGFuZGxlOwogCkBA
IC01NTQwLDYgKzU1NDksOCBAQCBzdGF0aWMgdm9pZCBtZ210X3JlbW92ZV9hZHZfbW9uaXRvcl9j
b21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHN0YXRpYyBpbnQgbWdtdF9yZW1vdmVfYWR2
X21vbml0b3Jfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSkKIHsKIAlzdHJ1
Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKKwlpZiAoY21kICE9IHBlbmRpbmdfZmlu
ZChNR01UX09QX1JFTU9WRV9BRFZfTU9OSVRPUiwgaGRldikpCisJCXJldHVybiAtRUlOVkFMOwog
CXN0cnVjdCBtZ210X2NwX3JlbW92ZV9hZHZfbW9uaXRvciAqY3AgPSBjbWQtPnBhcmFtOwogCXUx
NiBoYW5kbGUgPSBfX2xlMTZfdG9fY3B1KGNwLT5tb25pdG9yX2hhbmRsZSk7CiAKLS0gCjIuNDYu
MAoK
--86e67f2b77acc9c351e12f921f9b02ae66164f2a1446e1df757cc62f4b6c--

