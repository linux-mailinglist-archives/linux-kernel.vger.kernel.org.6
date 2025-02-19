Return-Path: <linux-kernel+bounces-521120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EA1A3B44D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5595188B4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC91E32A0;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jU3C9QoP"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A41C68A6;
	Wed, 19 Feb 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953973; cv=none; b=BDf+dxa54fot2n5J1RzikR1P6WAGKt6qW5aZ6Mx79/mg1namOK/burvWGGco1Kozuz3MoTmfs8L9QkCyXgF6jzMmACPHWr0Zq2PBFUpI6PaK1FPiWEk5khrqw7S7sb215Z0718+Mw6zvXyNvyiwz6qd2W8a0UYxRK5I1jyRYGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953973; c=relaxed/simple;
	bh=p8ISVEVcjD4emNEQ9vavFRhlStV/heXGlu9P8t2vCZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=GArxT/iOu8jqN9GUNlqGkHCAHYvVz2QbD0f948U4kokRBXyv1JcuR8Y/DzezHQU9JMArWPTtyhpQ58zDjk1Y5WoSVc4qKaTKwHM9c8zGtwzLaTrn1D8T3Oi7vTGG4T5R8HXh6XqgCWpVB+EodThHOu0FC5+q1Y5BT/LEdybyEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jU3C9QoP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51J8WXCW03088461, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739953953; bh=p8ISVEVcjD4emNEQ9vavFRhlStV/heXGlu9P8t2vCZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=jU3C9QoPyx9XbGeBLusDbwNv61wxaR431cfXjw91xOEv9ZDuxVXzc+iXx1Ty31jkg
	 HiUQMgzs7lTc0fksAvGB5wY5LtY8Rhn+NE8Y4PdurrSrHkUYTxeaIXslNjX57QH2DK
	 sbDg5pzZR5U/sldT+nBN8X15Ugy/lo9y/GkRw6lbZlR2X7DnlEmgdDCofVFC90C1Bc
	 pXuRoPJEPSOEtvplLnf/CQGKMlEgGTFxS07qoLyBJL6BK+dUSIRSPPAhfhtuSz9ASR
	 BMoVLEr3DL+d2uoRAcFl/nKGY+2b5SMCDhZ5WQi0MYbkjYw7YoPjxud2JNG2IY1iJx
	 gXw+Hi8VxfHYg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51J8WXCW03088461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:32:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 16:32:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Feb 2025 16:32:32 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 19 Feb 2025 16:32:32 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        "Maciej S. Szmigiero"
	<mail@maciej.szmigiero.name>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
Thread-Topic: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
Thread-Index: AQHbgSMJVrDFmK8Mp0CrjaEmJFua+rNLUekPgAL4rhCAAARNMA==
Date: Wed, 19 Feb 2025 08:32:32 +0000
Message-ID: <6224620265674b09b5762f908b5158f9@realtek.com>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
 <87h64s972a.wl-tiwai@suse.de> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Hi Maciej S,
=20
 Could you test plug headphone then speaker will mute or not?
=20
 Below was why I close the beep mode.
 https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=
=3Dfcf c9f711d1e2fc7876ac12b1b16c509404b9625
=20
=20
 Hi Takashi,
=20
 COEF 0x36 bit 13 was the enable bit for pcbeep passthrough for 0x14.
 If this patch no PM issues and speaker can mute by plug headphone or heads=
et,
 I think this work for me.


