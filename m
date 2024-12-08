Return-Path: <linux-kernel+bounces-436549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937669E876F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835DF163FE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837D14D2B9;
	Sun,  8 Dec 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="XnKh72I5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bk6h9pUs"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DF3E47B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733685158; cv=none; b=Dym/Y9puPW/ntcSUvp7BPgINqG5gNOw+PV3G6XJjaKWjzooOfpSPy/IiLZ2mwhIXU4uWSF+OJExXsy9OkaF9803UiErGmSKG5FYUu0BDyU0yy9g8gvy2zFPGU0WYNcnbhx4EbKMgTGpo2+AOx8RYJDLHBOoCYhUs8fu/mOidBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733685158; c=relaxed/simple;
	bh=d+MDNW2pYqKc7KCSkvzHVQC6JYFEGq5XNoP7a+PR72U=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=clA4lx/n71XUGg/eJ+9mG8x+P3ZSIhllmP+YU7WCWc0rxF+XxNXy4I5jl1W1gMQRy46NLCbuoZpt189mblsIFdkacH/6iDQcDmczK8X6tfUsjOBXBKoIisS+GKSiie5e2P5d8woqPJ8Nar1DNl3vQ7Ua/S6vZ5MFIoRIYfwIWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=XnKh72I5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bk6h9pUs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 38DDF11400C7;
	Sun,  8 Dec 2024 14:12:34 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Sun, 08 Dec 2024 14:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733685154; x=1733771554; bh=d+MDNW2pYq
	Kc7KCSkvzHVQC6JYFEGq5XNoP7a+PR72U=; b=XnKh72I535m603FOb13Xa9p9bG
	N6/aEZWI0LyahmMcjcYnLfLHtrh3yw1GHsKdWl9jyzuYqdhMJkG9dX0Tl6tblOlf
	K2gWbNN8TU1qywKFw3C1E6PQ2nlkvxaGYDv7WhX13p+m648kdzyfSA0RZDatCR2C
	RURZlaQ1zwmXkdezk3puXcoq4uH0CTdS8zCvwc6UpcISRgsCdHmJxx+Ny+BDyZEW
	EFdKbgVIsicjUQRS3EVlWmeGI2+kJXBudJ0SEVOYNOAWlMQYqljS7iul5hhzuWp9
	7yPB2WWzT6wkWJZ1i0FQY4ii2v5WxGQqknVbghKRbgCvp4oheoOh/5m6yA3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733685154; x=1733771554; bh=d+MDNW2pYqKc7KCSkvzHVQC6JYFEGq5XNoP
	7a+PR72U=; b=Bk6h9pUs4+rBx9Gfc5UtAfZUoOKbVaDC4+Cxc0/ULoUCOMNev8G
	otwhI/0g+ErElUo/aaAEVarSarldc8gT0BAwys08kNyGPssv9cH6xjHHGFVQnbi0
	oPf3MgsvOW/k5e1/9odmeklG4/Gd1EE7GEdYuh/kfwhjpLqNL6ECCCPsVW6Oqe7X
	ljSkBmCbW92UjmvdKxAYpmK+dw6+1yv2eaGutA6noHJ3c/CGwN2koG3I0ANBUok4
	NI2c8uLckjn8EjkXbQ2xnee6zFZ2AVX2oCkBcFSJ2xxZwzQVufQlDqwaQuB11Z2h
	KwWee4+jhxg5rC8LBWXLzm0Ju0BW2M4XtOA==
X-ME-Sender: <xms:oe9VZ63_4mHSOJKV0JWZohdytKFy7fBwFCBUSnPr7mdngzvSQoZEmA>
    <xme:oe9VZ9FmzqBjJ-yneDw8lYlVU28FyUybxpHDlLusFoMd--WMIQrUtqW7jpuImH2qk
    WHAzAldMN5R4aCdqdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefotgggff
    fkuffhvffofhgjsehmtderreertdejnecuhfhrohhmpedfofgriihinhcutehlhhgruggu
    rggufdcuoehmrgiiihhnsehgvghtshhtrghtvgdruggvvheqnecuggftrfgrthhtvghrnh
    epkefggfetgfejheffieevleevgeeftdehkeeuffffleelfeefiedtteetudfgffdvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgiiihhnsehgvghtshhtrghtvgdruggvvhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgriihinh
    esghgvthhsthgrthgvrdguvghvpdhrtghpthhtohepshihiihkrghllhgvrhdqsghughhs
    sehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehshiiisghothdogeejle
    grfhhfhedusggsfeeiudgvfhehrggrudeksehshiiikhgrlhhlvghrrdgrphhpshhpohht
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oe9VZy7lTebuKRJNAQnR3gluhguvnjRhutNKDthod9jodVZbb3xGVQ>
    <xmx:oe9VZ71UXXqd4PE7ykK0o0GorwXi9Y1KG32eDFDxqmgRU2WKgdrsEQ>
    <xmx:oe9VZ9GmXjSaMG99uPOXRGdKRZnqEbIPkhdIRS622Tjoiu_5rFP8ww>
    <xmx:oe9VZ09pv92B4RTxIzDxjBDpvttfdEUICAEYlwNXQoJkd4X1HbyaQQ>
    <xmx:ou9VZ9AJKKckA__AnM5OlGaBhmIXs9JW5r5DKEnDshQZcQ-HHDcVBkrL>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB5B71C20068; Sun,  8 Dec 2024 14:12:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=d2b98651a55833052975bec3182971688e20ea76c29171ac77536078d22d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 08 Dec 2024 22:12:32 +0300
Message-Id: <D66K3G6JFJ4C.1UV5Z5BMPMJDB@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "Mazin Alhaddad" <mazin@getstate.dev>, "syzbot"
 <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D66FXFUEV6V3.3SKKXVBD0Q1OY@getstate.dev>
 <6755cc1f.050a0220.2477f.002b.GAE@google.com>
 <D66J2UCA2K95.14GOLVW7ECBK2@getstate.dev>
In-Reply-To: <D66J2UCA2K95.14GOLVW7ECBK2@getstate.dev>

--d2b98651a55833052975bec3182971688e20ea76c29171ac77536078d22d
Content-Type: multipart/alternative;
 boundary=657d74f73129d993ed32d6e4d0f46405fa488573636d9dce1cdd2974fe38

--657d74f73129d993ed32d6e4d0f46405fa488573636d9dce1cdd2974fe38
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master=20

--657d74f73129d993ed32d6e4d0f46405fa488573636d9dce1cdd2974fe38--

--d2b98651a55833052975bec3182971688e20ea76c29171ac77536078d22d
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSBmZDQwNzJmNTQyMDBmYjNhOGE0NDU2YWM0ZmNmOGQxZjg4ZWQ0YjU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBTdW4sIDggRGVjIDIwMjQgMTg6NTI6NTQgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8ICA1ICsrKy0tCiBuZXQvYmx1ZXRvb3Ro
L21nbXQuYyAgICAgfCAxNSArKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hj
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
cXVldWVfcHVyZ2UoJmhkZXYtPnJ4X3EpOwpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9tZ210
LmMgYi9uZXQvYmx1ZXRvb3RoL21nbXQuYwppbmRleCBiMzExOTJkNDcuLjk1NmY4MDk2NSAxMDA2
NDQKLS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2JsdWV0b290aC9tZ210LmMK
QEAgLTU1MTksOSArNTUxOSwxOCBAQCBzdGF0aWMgdm9pZCBtZ210X3JlbW92ZV9hZHZfbW9uaXRv
cl9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIHsKIAlzdHJ1Y3QgbWdtdF9ycF9yZW1v
dmVfYWR2X21vbml0b3IgcnA7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7
Ci0Jc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07CisJ
c3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcDsKKwkKKwlpZiAoc3RhdHVzID09
IC1FSU5WQUwgfHwgY21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1JFTU9WRV9BRFZfTU9OSVRP
UiwgaGRldikpeworCQlyZXR1cm47CisJfQogCiAJaGNpX2Rldl9sb2NrKGhkZXYpOworCS8vIGlm
IGNhbGxlZCB3aGlsZSBkZXZpY2UgaXMgY2xvc2luZywgc3RhdHVzIHdpbGwgYmUgaW52YWxpZC4K
KwkvLyBhbmQgY21kIGlzIGNsZWFyZWQgYnkgX19tZ210X3Bvd2VyX29mZgorCQorCisJY3AgPSBj
bWQtPnBhcmFtOwogCiAJcnAubW9uaXRvcl9oYW5kbGUgPSBjcC0+bW9uaXRvcl9oYW5kbGU7CiAK
QEAgLTU1NDAsNiArNTU0OSw4IEBAIHN0YXRpYyB2b2lkIG1nbXRfcmVtb3ZlX2Fkdl9tb25pdG9y
X2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAogc3RhdGljIGludCBtZ210X3JlbW92ZV9h
ZHZfbW9uaXRvcl9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhKQogewogCXN0
cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOworCWlmIChjbWQgIT0gcGVuZGluZ19m
aW5kKE1HTVRfT1BfUkVNT1ZFX0FEVl9NT05JVE9SLCBoZGV2KSkKKwkJcmV0dXJuIC1FSU5WQUw7
CiAJc3RydWN0IG1nbXRfY3BfcmVtb3ZlX2Fkdl9tb25pdG9yICpjcCA9IGNtZC0+cGFyYW07CiAJ
dTE2IGhhbmRsZSA9IF9fbGUxNl90b19jcHUoY3AtPm1vbml0b3JfaGFuZGxlKTsKIApAQCAtOTU0
Niw2ICs5NTU3LDggQEAgdm9pZCBfX21nbXRfcG93ZXJfb2ZmKHN0cnVjdCBoY2lfZGV2ICpoZGV2
KQogCQltYXRjaC5tZ210X3N0YXR1cyA9IE1HTVRfU1RBVFVTX0lOVkFMSURfSU5ERVg7CiAJZWxz
ZQogCQltYXRjaC5tZ210X3N0YXR1cyA9IE1HTVRfU1RBVFVTX05PVF9QT1dFUkVEOworCQorCW1n
bXRfcGVuZGluZ19mb3JlYWNoKE1HTVRfT1BfUkVNT1ZFX0FEVl9NT05JVE9SLCBoZGV2LCBzZXR0
aW5nc19yc3AsICZtYXRjaCk7CiAKIAltZ210X3BlbmRpbmdfZm9yZWFjaCgwLCBoZGV2LCBjbWRf
Y29tcGxldGVfcnNwLCAmbWF0Y2gpOwogCi0tIAoyLjQ2LjAKCg==
--d2b98651a55833052975bec3182971688e20ea76c29171ac77536078d22d--

