Return-Path: <linux-kernel+bounces-433220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448FD9E5542
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50231883DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4B1C3C03;
	Thu,  5 Dec 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="Omma2SKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C23ADhN5"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4C214A73
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401223; cv=none; b=Hh1xz2ro6mNB/JxiK9WnvfwAJh+BcTrDLIU7uCpo8OEX4FrCTl6OLMDYyWpR9ipedF9gNRCNhdSzmiVcbD1DMXE5wm41yY8eIFE9VjlOd2ATIfaT7QTFiNU/A0Y9KUJQ8UrH6JjWGRO7j60t3rTMKF1LVuo85WjQmN/sRaYGGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401223; c=relaxed/simple;
	bh=lgLBUqYkrb/DvC/LbIRNQkPKFMmS9ZvB9vsa/1XSgJg=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=D8fZFiMGKJZOhjcHdX0/AvTWRGS/5VjY/ngpEyaCnq4yg5fOoHuRflrI0txc+zdzO/zIQ5yfbTG416lCSxa/5/MFifivZa1ZaIOZbh67Yp2OkNRHhPrkDNcda3uy/qHUHvWlg3bcPBKmnvswo2fggQeMPfrF+4+LrrQSGEsDcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=Omma2SKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C23ADhN5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36FF211401E7;
	Thu,  5 Dec 2024 07:20:20 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 07:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733401220; x=1733487620; bh=lgLBUqYkrb
	/DvC/LbIRNQkPKFMmS9ZvB9vsa/1XSgJg=; b=Omma2SKtiMAw0GxolQBszJvSAH
	SPM4UeMuFDlTMQFUk093Hih/4KM6FCPDCyDQvw9yOG2zxfF5IevOXFs7dS9MPMwX
	hdD4C/Uzth3BtY36Lk9BydSX16lgDHC7gfKYU0Fy1R0URyPpyny5AaChG8y1wJs4
	Y5TJsO85t7/VwFwQKilveprA80DOVP69rjFjpgq/U6Xevf/CHYg6xYB9Ctk6F/9A
	fVMfqKD4gTcJQLUNQDor/uYNw9UmM8E6+jNnTryVIj4mZe4cHxDOfAqq6VElE/gs
	wQEm+PsbZhdg2FF/ZIHpuatobzIbpi2M3TPZBUS5fUhXTrxbELDn0RHighww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733401220; x=1733487620; bh=lgLBUqYkrb/DvC/LbIRNQkPKFMmS9ZvB9vs
	a/1XSgJg=; b=C23ADhN55FcChxB352odqvsrdzKJZVnQ+iL/henbgOiJ3aPboXS
	xvJk7BI2MEZMMNr9DRsK7Z3ayHyx6xAYJcMl4NwSpm8uYsn0BFSprfU0TXJ62e3S
	XU2WztylLH62GDYlOW0SsrCUMr0UHrwxlA02tCI/Oo9rApQN2AUl/qdq0SiFSxQA
	l9H7uolpj4hXV59xYd4bdGJW3EOxdH3HT6ScaDjhIMG16NQJVDksL0K3+u9vcll3
	c6QOthGF4+oHhE9HUrCNNygw0tbcIoic5nv9s1X9I2bLH/rD5vhyczkFh8Ms0TUy
	Bxg6h3xLkCf7yPaOfM/rCr4YdRNi99h1zYA==
X-ME-Sender: <xms:hJpRZ09aGBiD-O39-SxQK5WPCaeTjnmLVUwPPnosd2zitGlVb3M6Sw>
    <xme:hJpRZ8uJSy4MtoEnArNsz8_OXkMzxpQuMj0rJ-i2B0MxnALCAggGm2gi_l_af2NAI
    4nbih62ai2eqA7YQCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdefjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:hJpRZ6BlepxP9y9aY_6Wuppc92XCuxKhAsSpAPVedqN_BwL5pSpU3w>
    <xmx:hJpRZ0dxzkubjqzrXPJDGhPu7MpPnj-hudQp_o8MJgueIHra1dMOvg>
    <xmx:hJpRZ5PJY_x_1qvmK0_6A0Tw6xu-DPbvYQrX7xtCuzWJwyGl9Fq0xA>
    <xmx:hJpRZ-mBAewvAdWOk8s4gundsjoPuFo9V-_Qum0LhqeTIRHkw80kIQ>
    <xmx:hJpRZyZWGa--awgmtXrmj3jRV9yC8uSTUoAmsJl4spb_ytexgRE9ZhPU>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED13D1C20067; Thu,  5 Dec 2024 07:20:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=4fde8cd099ccb869b8d21e2a28c1dc72aaf3193dfed5a215fdbd19fe1106
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 15:20:10 +0300
Message-Id: <D63RG2V1SJD8.3JVR47OT0IN39@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63QK91VZ3BS.3IA9R221PTFE5@getstate.dev>
 <675196b3.050a0220.17bd51.009c.GAE@google.com>
In-Reply-To: <675196b3.050a0220.17bd51.009c.GAE@google.com>

--4fde8cd099ccb869b8d21e2a28c1dc72aaf3193dfed5a215fdbd19fe1106
Content-Type: multipart/alternative;
 boundary=eb8ede06504d4b9dc313ef4baf39538d8773cfeb01143cba803d192a17fc

--eb8ede06504d4b9dc313ef4baf39538d8773cfeb01143cba803d192a17fc
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--eb8ede06504d4b9dc313ef4baf39538d8773cfeb01143cba803d192a17fc--

--4fde8cd099ccb869b8d21e2a28c1dc72aaf3193dfed5a215fdbd19fe1106
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSA5ODZmMjc2NjY4NzQ3NDVhYWQ2YjcyMmNiNzdjZWVhY2I2YTYyNDI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMDQ6NTU6NDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8ICA1ICsrKystCiBuZXQvYmx1ZXRvb3Ro
L21nbXQuYyAgICAgfCAxOCArKysrKysrKysrKysrKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3Ro
L2hjaV9zeW5jLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggYzg2ZjRlNDJlLi5i
ODljYWQ5NGYgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQv
Ymx1ZXRvb3RoL2hjaV9zeW5jLmMKQEAgLTUyMTIsNiArNTIxMiw3IEBAIGludCBoY2lfZGV2X2Ns
b3NlX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJaGNpX2Nvbm5faGFzaF9mbHVzaChoZGV2
KTsKIAkvKiBQcmV2ZW50IGRhdGEgcmFjZXMgb24gaGRldi0+c21wX2RhdGEgb3IgaGRldi0+c21w
X2JyZWRyX2RhdGEgKi8KIAlzbXBfdW5yZWdpc3RlcihoZGV2KTsKKwloY2lfY21kX3N5bmNfY2xl
YXIoaGRldik7CiAJaGNpX2Rldl91bmxvY2soaGRldik7CiAKIAloY2lfc29ja19kZXZfZXZlbnQo
aGRldiwgSENJX0RFVl9ET1dOKTsKQEAgLTUyMzUsNyArNTIzNiw5IEBAIGludCBoY2lfZGV2X2Ns
b3NlX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJfQogCiAJLyogZmx1c2ggY21kICB3b3Jr
ICovCi0JZmx1c2hfd29yaygmaGRldi0+Y21kX3dvcmspOworCWNhbmNlbF93b3JrX3N5bmMoJmhk
ZXYtPmNtZF93b3JrKTsKKworCQogCiAJLyogRHJvcCBxdWV1ZXMgKi8KIAlza2JfcXVldWVfcHVy
Z2UoJmhkZXYtPnJ4X3EpOwpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tZ210LmMgYi9uZXQv
Ymx1ZXRvb3RoL21nbXQuYwppbmRleCBiMzExOTJkNDcuLmNiZjRmYjFmZiAxMDA2NDQKLS0tIGEv
bmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2JsdWV0b290aC9tZ210LmMKQEAgLTU1MTks
NyArNTUxOSwxMiBAQCBzdGF0aWMgdm9pZCBtZ210X3JlbW92ZV9hZHZfbW9uaXRvcl9jb21wbGV0
ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHsKIAlzdHJ1Y3QgbWdtdF9ycF9yZW1vdmVfYWR2X21v
bml0b3IgcnA7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7Ci0Jc3RydWN0
IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07CisJc3RydWN0IG1n
bXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcDsKKwkKKwlpZiAoY21kICE9IHBlbmRpbmdfZmlu
ZChNR01UX09QX1JFTU9WRV9BRFZfTU9OSVRPUiwgaGRldikpIHsKKwkJcmV0dXJuIC1FQ0FOQ0VM
RUQ7CisJfQorCWNwID0gY21kLT5wYXJhbTsKIAogCWhjaV9kZXZfbG9jayhoZGV2KTsKIApAQCAt
NTU0MCw4ICs1NTQ1LDE1IEBAIHN0YXRpYyB2b2lkIG1nbXRfcmVtb3ZlX2Fkdl9tb25pdG9yX2Nv
bXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAogc3RhdGljIGludCBtZ210X3JlbW92ZV9hZHZf
bW9uaXRvcl9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhKQogewogCXN0cnVj
dCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOwotCXN0cnVjdCBtZ210X2NwX3JlbW92ZV9h
ZHZfbW9uaXRvciAqY3AgPSBjbWQtPnBhcmFtOwotCXUxNiBoYW5kbGUgPSBfX2xlMTZfdG9fY3B1
KGNwLT5tb25pdG9yX2hhbmRsZSk7CisJc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9y
ICpjcDsKKwl1MTYgaGFuZGxlOyAKKworCWlmIChjbWQgIT0gcGVuZGluZ19maW5kKE1HTVRfT1Bf
UkVNT1ZFX0FEVl9NT05JVE9SLCBoZGV2KSkgeworCQlyZXR1cm4gLUVDQU5DRUxFRDsKKwl9CisK
KwljcCA9IGNtZC0+cGFyYW07CisJaGFuZGxlID09IF9fbGUxNl90b19jcHUoY3AtPm1vbml0b3Jf
aGFuZGxlKTsKIAogCWlmICghaGFuZGxlKQogCQlyZXR1cm4gaGNpX3JlbW92ZV9hbGxfYWR2X21v
bml0b3IoaGRldik7Ci0tIAoyLjQ2LjAKCg==
--4fde8cd099ccb869b8d21e2a28c1dc72aaf3193dfed5a215fdbd19fe1106--

