Return-Path: <linux-kernel+bounces-521151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D296BA3B522
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D4F188A3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C841DE3DB;
	Wed, 19 Feb 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o7Pc3b5f"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAD1DE3AC;
	Wed, 19 Feb 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954394; cv=none; b=AzFt+NJ2owUhNKh/eU/EGy1Ja8su1wtLor1jVtbxcxiPAmhf/NS3brJgvKwJM2dKfppUbUoaI+vIv8b7vEZdJ4bFAwJq1ty1Ko0N+FMopfpfJ6LGzWpA2TtrWh95K1ZkU6ICxnNlekl2xab3xjnFdyZP1BwWAACqTOD3oKwHV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954394; c=relaxed/simple;
	bh=VAzyzemlx4t2eUJLd09d54BbdfsXKkEuJHEH/d9W9Rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=G/T7EeUuapmBYg09TdpmjJxSwmeUSW002oNKRduQZrG6THre8ivtIOKNrTNCY9FvALOA+tZxm6jtIyGReScz9p8qgEcWzMRCvjnww8A2o7quM/GlZR9vAwySmyMKRAl1niNet1IbLKMtGvFZmz51jRtN+vwA52hpOeA5daUCBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o7Pc3b5f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51J8dZNx93095045, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739954375; bh=VAzyzemlx4t2eUJLd09d54BbdfsXKkEuJHEH/d9W9Rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=o7Pc3b5fcpxRaAvsa94AOdcKf70JCtSbdFI9TdZPb2Ftz7BWmmrw/hxGR3x8hemNO
	 Z290A0BW7+3L9fDCrdrHvyVUlS+zLysZlD+3u/Zgn2iueXM9Z01J88h8NxCuk++aWH
	 mQ/oRnZWepUZld9H6w8OOm9vXXt/M2+dq5H5un45vrWfQaei4bpY+0K+XFYrJTxSZL
	 D+6efgtFlR3QSWQKaXk+8ARtLMoUjIgOnPScLQu740ji6slOdrD3/PIypyLxujQ+9X
	 mNPljJgD2Q4bx0L2pI2fmIZ6Ri06v88lCpCi6qqofwaFhdTynmItwOkNzRanr8X3AP
	 w4Ylz5hpl+TCg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51J8dZNx93095045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:39:35 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 16:39:36 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Feb 2025 16:39:35 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 19 Feb 2025 16:39:35 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        "Maciej S. Szmigiero"
	<mail@maciej.szmigiero.name>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
Thread-Topic: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
Thread-Index: AQHbgSMJVrDFmK8Mp0CrjaEmJFua+rNLUekPgAL4rhCAAARNMIAAAgOA
Date: Wed, 19 Feb 2025 08:39:35 +0000
Message-ID: <3f8c4726cac24e86a6c106efcdc84d7f@realtek.com>
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


Paste link again.
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=
=3Dfcfc9f711d1e2fc7876ac12b1b16c509404b9625


