Return-Path: <linux-kernel+bounces-356184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B99995DAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DE61F26863
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBC133987;
	Wed,  9 Oct 2024 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="euD4V4ne"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1E17C61;
	Wed,  9 Oct 2024 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440218; cv=none; b=q8Lnfeu+sqpCdi7NddqDhLGcwGFdXVj1vhoYHr3vqAxIg3+h9Wd+kZPB0Kiw70yomdESj1KqnfhnssjnpiG16tyNs3ndr7D+xqADJj8sgNLkayonbgmzdQUQqxFFyQ5e2R+JeXhheXlFbVOR+NlTvFCVPeFrTYj1qXJ1NRSgvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440218; c=relaxed/simple;
	bh=Ag/O9XzHB2k414SUf0LuYKbaX6hIVmwXzgwCMonICZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1lpLuywmWVjddls5gY++fhfGNk8LahG/McX/YdyK4E3j7sUdv+Eld3aO94+Euq8bKC0RhfnVkKn/uvswVb3cuXZGZCGW8wCvq2WO5oRRaDoW6HfTVl+LsIVNAv3aZ1RtvYz/qGkXQvbe0R0e+1vdSi9Y0ohUQAzRaIUMp1iOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=euD4V4ne; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4992GS9p8079717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728440188; bh=Ag/O9XzHB2k414SUf0LuYKbaX6hIVmwXzgwCMonICZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=euD4V4nePE30VBkGbQtKfAu5NQyETO87Xn8mcOMvBKSr8MA9xsMokjSqVWE4LLjQa
	 ACwdFoi03zsd2nKscY5C+tbO2YrNmZ678olUU7uONAJbCY/0za3QAF5qTSF0xfjcv4
	 +77rWaEqRivWHIvn9Gjum97etDstgZKuGLeZMGow4XI9IR84ascBh013RBwKV9GW9O
	 IJ6adhZy2F+SyNBVRZLGihoTm5OXq1mytDYa2RzYILvFdII5y3HoRlLu1jZFjPf5sL
	 7a/lNlCwmDkwbHDoOKAYT0Uecpl2FaY9XD2b6H7OaoZBUO7AeynZ69Ccdgtp0efZ75
	 mO4qMoPa826FA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4992GS9p8079717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 10:16:28 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 10:16:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 9 Oct 2024 10:16:26 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Wed, 9 Oct 2024 10:16:26 +0800
From: Jack Yu <jack.yu@realtek.com>
To: Mark Brown <broonie@kernel.org>, Colin Ian King <colin.i.king@gmail.com>
CC: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of values into uninitialized variable ret
Thread-Topic: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of values
 into uninitialized variable ret
Thread-Index: AQHbGaG8YJlbgZqe9keJkoeqo+O4cLJ8js0AgACaTrA=
Date: Wed, 9 Oct 2024 02:16:26 +0000
Message-ID: <00bfbc805d9746579129083dafdc1bd0@realtek.com>
References: <20241008164707.203792-1-colin.i.king@gmail.com>
 <ZwVmCNAVSOgqT6Qd@finisterre.sirena.org.uk>
In-Reply-To: <ZwVmCNAVSOgqT6Qd@finisterre.sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_00bfbc805d9746579129083dafdc1bd0realtekcom_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_00bfbc805d9746579129083dafdc1bd0realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, October 9, 2024 1:04 AM
> To: Colin Ian King <colin.i.king@gmail.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> <tiwai@suse.com>; Jack Yu <jack.yu@realtek.com>;
> linux-sound@vger.kernel.org; kernel-janitors@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of va=
lues
> into uninitialized variable ret
>=20
> On Tue, Oct 08, 2024 at 05:47:07PM +0100, Colin Ian King wrote:
> > There are a handful of bit-wise or'ing of values into the
> > uninitialized variable ret resulting in garbage results. Fix this by
> > ininitializing ret to zero.
>=20
> I'm very disappinted in the compiler for not noticing this :(

I'm sorry for such mistake. I've sent a patch to fix this yesterday, please=
 refer attachment.

--_002_00bfbc805d9746579129083dafdc1bd0realtekcom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Wed, 09 Oct 2024 02:16:25 GMT";
	modification-date="Wed, 09 Oct 2024 02:16:25 GMT"

From: Jack Yu <jack.yu@realtek.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"lars@metafoo.de" <lars@metafoo.de>, "bard.liao@intel.com"
	<bard.liao@intel.com>, "naveen.m@intel.com" <naveen.m@intel.com>,
	"Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
	=?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
	=?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>, Jack Yu
	<jack.yu@realtek.com>
Subject: [PATCH 2/2] ASoC: rt721-sdca: Fix issue of warning message
Thread-Topic: [PATCH 2/2] ASoC: rt721-sdca: Fix issue of warning message
Thread-Index: AdsZYB5twYpxAqYfT+6Yl9jzt54Bxg==
Date: Tue, 8 Oct 2024 08:57:35 +0000
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0

Rml4IGlzc3VlIG9mIHdhcm5pbmcgbWVzc2FnZXMgY2F1c2VkIGJ5IHNvbWUgdmFyaWFibGVzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBKYWNrIFl1IDxqYWNrLnl1QHJlYWx0ZWsuY29tPg0KLS0tDQogc291
bmQvc29jL2NvZGVjcy9ydC1zZHctY29tbW9uLmMgfCAyICstDQogc291bmQvc29jL2NvZGVjcy9y
dDcyMS1zZGNhLmMgICAgfCA0ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvcnQtc2R3
LWNvbW1vbi5jIGIvc291bmQvc29jL2NvZGVjcy9ydC1zZHctY29tbW9uLmMNCmluZGV4IDllZDBl
OTg1NTY5OS4uYTQyMmRhNmNmNzAyIDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9ydC1z
ZHctY29tbW9uLmMNCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQtc2R3LWNvbW1vbi5jDQpAQCAt
MTA4LDcgKzEwOCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHJ0X3NkY2FfaW5kZXhfdXBkYXRlX2Jp
dHMpOw0KIGludCBydF9zZGNhX2J0bl90eXBlKHVuc2lnbmVkIGNoYXIgKmJ1ZmZlcikNCiB7DQog
CXU4IGJ0bl90eXBlID0gMDsNCi0JaW50IHJldDsNCisJaW50IHJldCA9IDA7DQogDQogCWJ0bl90
eXBlIHw9IGJ1ZmZlclswXSAmIDB4ZjsNCiAJYnRuX3R5cGUgfD0gKGJ1ZmZlclswXSA+PiA0KSAm
IDB4ZjsNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3J0NzIxLXNkY2EuYyBiL3NvdW5k
L3NvYy9jb2RlY3MvcnQ3MjEtc2RjYS5jDQppbmRleCAzNjA1NmNiN2EzY2EuLjIwMWNiNjY3Yzhj
MSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvcnQ3MjEtc2RjYS5jDQorKysgYi9zb3Vu
ZC9zb2MvY29kZWNzL3J0NzIxLXNkY2EuYw0KQEAgLTMwLDcgKzMwLDcgQEAgc3RhdGljIHZvaWQg
cnQ3MjFfc2RjYV9qYWNrX2RldGVjdF9oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykN
CiB7DQogCXN0cnVjdCBydDcyMV9zZGNhX3ByaXYgKnJ0NzIxID0NCiAJCWNvbnRhaW5lcl9vZih3
b3JrLCBzdHJ1Y3QgcnQ3MjFfc2RjYV9wcml2LCBqYWNrX2RldGVjdF93b3JrLndvcmspOw0KLQlp
bnQgYnRuX3R5cGUgPSAwLCByZXQ7DQorCWludCBidG5fdHlwZSA9IDA7DQogDQogCWlmICghcnQ3
MjEtPmhzX2phY2spDQogCQlyZXR1cm47DQpAQCAtNDIsNyArNDIsNyBAQCBzdGF0aWMgdm9pZCBy
dDcyMV9zZGNhX2phY2tfZGV0ZWN0X2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
IAlpZiAocnQ3MjEtPnNjcF9zZGNhX3N0YXQxICYgU0RXX1NDUF9TRENBX0lOVF9TRENBXzYpIHsN
CiAJCXJ0NzIxLT5qYWNrX3R5cGUgPSBydF9zZGNhX2hlYWRzZXRfZGV0ZWN0KHJ0NzIxLT5yZWdt
YXAsDQogCQkJCQkJCVJUNzIxX1NEQ0FfRU5UX0dFNDkpOw0KLQkJaWYgKHJldCA8IDApDQorCQlp
ZiAocnQ3MjEtPmphY2tfdHlwZSA8IDApDQogCQkJcmV0dXJuOw0KIAl9DQogDQotLSANCjIuMzQu
MQ0KDQo=

--_002_00bfbc805d9746579129083dafdc1bd0realtekcom_--

