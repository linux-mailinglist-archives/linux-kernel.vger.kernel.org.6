Return-Path: <linux-kernel+bounces-436599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2449E882A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 22:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37418280F14
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB46190685;
	Sun,  8 Dec 2024 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="NCvZ9oAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5xdPwd+W"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE21DA23
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733694279; cv=none; b=BdCyAxEIolGchFIeg1FlpYL+D4zlEO3u303xqx3RMlLf12Xg2CAhE8SLYvUrmsN60uq/TNRs9EpDLe2eRtW7JFHE8xLxwNRyfZbb7tDV68xmQvceSTk9nKKDb/isvmQMOpfav5oFTu8k7I0zsYP3CNZRMue/r60MrmDDVDtXlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733694279; c=relaxed/simple;
	bh=hqhBCRPrqdg+w1wtoxjl1UnEdlYe3LA9omWqbb64ifc=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=qsdX0lOe4+3E+hNC2l4z3osFQGtVEVuroPGEsD3IDIZNp/o8GLB2CQzRaRzbRJalZIlr/g6Y2Q4t4GJVm2ZcA2IQgyaCEGyIKF9i/h+aTnI8KBkebhVYgDBwfQLf2FXYwI7pF/m1AK6Xx9grHFsB8g1bLWwc4X5KS8F11CVBI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=NCvZ9oAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5xdPwd+W; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 08B951140108;
	Sun,  8 Dec 2024 16:44:34 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Sun, 08 Dec 2024 16:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733694273; x=1733780673; bh=hqhBCRPrqd
	g+w1wtoxjl1UnEdlYe3LA9omWqbb64ifc=; b=NCvZ9oAQWJObdNXAbxcFNGYpra
	9cFCNst0NuzicdTi0JiI465N5R/lhI3zb6mjfhjlzh7fTngiAvfsDqDAt285M10N
	JfoP2cLGr8ZMOTkpr90OqRu9ZWT5pejIBtDSBxCuF33tCNX6Ce+c0tseKNmmNph7
	KJewGeY255bZjQQk5mxn6HiGa4Q75566kZjQszJWBFup6eh6f6sVEOhkJnjpxyl5
	H7chDDAOyicFeGIwdZr1OI0Xg0h8+4ma6icS01ativIX5MV31CX8fUZs/ucnbmdr
	5VAcU4/17K8vqV1Wted0wXzzq5+aimwMBtrAzu53wVDJPS8oH0xhZvV8wsZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733694273; x=1733780673; bh=hqhBCRPrqdg+w1wtoxjl1UnEdlYe3LA9omW
	qbb64ifc=; b=5xdPwd+WrBV0VJ/D9wdCHqCU8TubCxrCdSuI3ris9V36gc5W6wQ
	RmnFONkRhePiizca2peqMRWEHoj/gIeCYRyJna1M+JyZ1VhKsbipSSQRPJLDRByj
	K6i7l72/GcLT5RwXJIPFQqYKQgrE9bqp8LkZHk2D5hEz1yA0hMU+wum/pgcqplyb
	+5GRlF3/bMUDo4Ls14Zsb+KgE+KvY8WAH1HLDuoTV6y98gDSDg4mMf6QVPU/sVgQ
	tkRNd6H7TT2r72/CsJGDdFzTwfHdd/FFbr6AYi6XItnAFoKhKVXr+foBMihP+KVQ
	aCN/XmLxLqG9qMs37KtX/0qbF3rCbPeZiAA==
X-ME-Sender: <xms:QRNWZzJ3h5Y_zJiw_-nKordmoM0h56a0YGpEooNBK-xE5v_7NMUgiQ>
    <xme:QRNWZ3LI0lJJnlqe1carr_yQmXaBRyu7Keun21n8qF88o81kw6XkxVqbGDzOURKJ4
    zSvkxY2cqpVD7OmwFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefotgggff
    fkhffvuffofhgjsehmtderreertdejnecuhfhrohhmpedfofgriihinhcutehlhhgruggu
    rggufdcuoehmrgiiihhnsehgvghtshhtrghtvgdruggvvheqnecuggftrfgrthhtvghrnh
    epheeiuefhgeeihedtleekiefhkeelvddvjefhuddvkeejudetveevhedvveffhfdunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgiiihhnsehgvghtshhtrghtvgdruggvvhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshihiihkrg
    hllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehs
    hiiisghothdogeejlegrfhhfhedusggsfeeiudgvfhehrggrudeksehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QRNWZ7scTkDPWKhaMdCuOBI3XUqjFjI2pg160sX_lmlM9IRHrkS6Pw>
    <xmx:QRNWZ8apWXqxLEJr6YZFZdO-zQFVQ_4htuH3lxTs7FfPF-xJhblZEw>
    <xmx:QRNWZ6bxgBn01fXzNHwaVrteZgYsAUHyKA33Dh_9oSLOsbcgwJDW1g>
    <xmx:QRNWZwCk8O6Kp44gmGw7zEaj2SFYxH1ZwaU1-sXCQh9s7YVIi6zyFQ>
    <xmx:QRNWZ5lNfiPiJP8fGxoleEFNFPoEpgWHB554G4TfcoEux-t806FCkMbJ>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94C821C20066; Sun,  8 Dec 2024 16:44:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=10ce97ee9d4055c2cd560c150fbab082d97aab7447bd15c6836e7b912b06
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 09 Dec 2024 00:44:32 +0300
Message-Id: <D66NBTS05F94.363JPCPCZ9AZS@getstate.dev>
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
X-Mailer: aerc 0.18.2
References: <D66K3G6JFJ4C.1UV5Z5BMPMJDB@getstate.dev>
 <675612aa.050a0220.2477f.0030.GAE@google.com>
In-Reply-To: <675612aa.050a0220.2477f.0030.GAE@google.com>

--10ce97ee9d4055c2cd560c150fbab082d97aab7447bd15c6836e7b912b06
Content-Type: multipart/alternative;
 boundary=19bc651f2bf0854b3243ff56aaf84006065b1afde67caf2ec395b7917eea

--19bc651f2bf0854b3243ff56aaf84006065b1afde67caf2ec395b7917eea
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--19bc651f2bf0854b3243ff56aaf84006065b1afde67caf2ec395b7917eea--

--10ce97ee9d4055c2cd560c150fbab082d97aab7447bd15c6836e7b912b06
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSBjNGYyZWJkNzQzYzYxOTZiOWMyNWU4MjljMDdhODJkNWFlZjgwMzQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBTdW4sIDggRGVjIDIwMjQgMTg6NTI6NTQgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8ICA1ICsrKy0tCiBuZXQvYmx1ZXRvb3Ro
L21nbXQuYyAgICAgfCAxOCArKysrKysrKysrKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3Ro
L2hjaV9zeW5jLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggYzg2ZjRlNDJlLi5h
YTVhYTNmZWQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQv
Ymx1ZXRvb3RoL2hjaV9zeW5jLmMKQEAgLTUxOTcsNiArNTE5Nyw5IEBAIGludCBoY2lfZGV2X2Ns
b3NlX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJICovCiAJZHJhaW5fd29ya3F1ZXVlKGhk
ZXYtPndvcmtxdWV1ZSk7CiAKKwkvKiBmbHVzaCBjbWQgIHdvcmsgKi8KKwlmbHVzaF93b3JrKCZo
ZGV2LT5jbWRfd29yayk7CisKIAloY2lfZGV2X2xvY2soaGRldik7CiAKIAloY2lfZGlzY292ZXJ5
X3NldF9zdGF0ZShoZGV2LCBESVNDT1ZFUllfU1RPUFBFRCk7CkBAIC01MjM0LDggKzUyMzcsNiBA
QCBpbnQgaGNpX2Rldl9jbG9zZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCQljbGVhcl9i
aXQoSENJX0lOSVQsICZoZGV2LT5mbGFncyk7CiAJfQogCi0JLyogZmx1c2ggY21kICB3b3JrICov
Ci0JZmx1c2hfd29yaygmaGRldi0+Y21kX3dvcmspOwogCiAJLyogRHJvcCBxdWV1ZXMgKi8KIAlz
a2JfcXVldWVfcHVyZ2UoJmhkZXYtPnJ4X3EpOwpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9t
Z210LmMgYi9uZXQvYmx1ZXRvb3RoL21nbXQuYwppbmRleCBiMzExOTJkNDcuLmZhMzY5Yjg0NSAx
MDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2JsdWV0b290aC9tZ210
LmMKQEAgLTU1MTksOSArNTUxOSwxOCBAQCBzdGF0aWMgdm9pZCBtZ210X3JlbW92ZV9hZHZfbW9u
aXRvcl9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHsKIAlzdHJ1Y3QgbWdtdF9ycF9y
ZW1vdmVfYWR2X21vbml0b3IgcnA7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRh
dGE7Ci0Jc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07
CisJc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcDsKKwkKKwlpZiAoc3RhdHVz
ID09IC1FSU5WQUwgfHwgY21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1JFTU9WRV9BRFZfTU9O
SVRPUiwgaGRldikpeworCQlyZXR1cm47CisJfQogCiAJaGNpX2Rldl9sb2NrKGhkZXYpOworCS8v
IGlmIGNhbGxlZCB3aGlsZSBkZXZpY2UgaXMgY2xvc2luZywgc3RhdHVzIHdpbGwgYmUgaW52YWxp
ZC4KKwkvLyBhbmQgY21kIGlzIGNsZWFyZWQgYnkgX19tZ210X3Bvd2VyX29mZgorCQorCisJY3Ag
PSBjbWQtPnBhcmFtOwogCiAJcnAubW9uaXRvcl9oYW5kbGUgPSBjcC0+bW9uaXRvcl9oYW5kbGU7
CiAKQEAgLTU1NDAsNiArNTU0OSw4IEBAIHN0YXRpYyB2b2lkIG1nbXRfcmVtb3ZlX2Fkdl9tb25p
dG9yX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAogc3RhdGljIGludCBtZ210X3JlbW92
ZV9hZHZfbW9uaXRvcl9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhKQogewog
CXN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOworCWlmIChjbWQgIT0gcGVuZGlu
Z19maW5kKE1HTVRfT1BfUkVNT1ZFX0FEVl9NT05JVE9SLCBoZGV2KSkKKwkJcmV0dXJuIC1FSU5W
QUw7CiAJc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07
CiAJdTE2IGhhbmRsZSA9IF9fbGUxNl90b19jcHUoY3AtPm1vbml0b3JfaGFuZGxlKTsKIApAQCAt
OTU0NCw4ICs5NTU1LDExIEBAIHZvaWQgX19tZ210X3Bvd2VyX29mZihzdHJ1Y3QgaGNpX2RldiAq
aGRldikKIAkgKi8KIAlpZiAoaGNpX2Rldl90ZXN0X2ZsYWcoaGRldiwgSENJX1VOUkVHSVNURVIp
KQogCQltYXRjaC5tZ210X3N0YXR1cyA9IE1HTVRfU1RBVFVTX0lOVkFMSURfSU5ERVg7Ci0JZWxz
ZQorCWVsc2UgeworCQltYXRjaC5tZ210X3N0YXR1cyA9IE1HTVRfU1RBVFVTX0JVU1k7CisJCW1n
bXRfcGVuZGluZ19mb3JlYWNoKE1HTVRfT1BfUkVNT1ZFX0FEVl9NT05JVE9SLCBoZGV2LCBjbWRf
c3RhdHVzX3JzcCwgJm1hdGNoKTsKIAkJbWF0Y2gubWdtdF9zdGF0dXMgPSBNR01UX1NUQVRVU19O
T1RfUE9XRVJFRDsKKwl9CiAKIAltZ210X3BlbmRpbmdfZm9yZWFjaCgwLCBoZGV2LCBjbWRfY29t
cGxldGVfcnNwLCAmbWF0Y2gpOwogCi0tIAoyLjQ2LjAKCg==
--10ce97ee9d4055c2cd560c150fbab082d97aab7447bd15c6836e7b912b06--

