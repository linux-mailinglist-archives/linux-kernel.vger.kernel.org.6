Return-Path: <linux-kernel+bounces-543287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E21A4D3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8625F18826F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFD1F4E4F;
	Tue,  4 Mar 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nwhz3ddh"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8C1DC985;
	Tue,  4 Mar 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069601; cv=none; b=ghkjM2oyaOyXBptXKqJHxyjiZpxGDlxFt+GU71Mwz/WZWiWJ0rAePg+HOfFTA6/AR0CdTOctX3lL70UJ/kwMCOHx9zdAWQPX4fUpRZ4mx4nlg/uWbAvksdn7dvdWM6GK+Q98ubvk++6W/9x2rifu5zHp8mrMWM9Ok8jz9U7AefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069601; c=relaxed/simple;
	bh=Qytyx0Oyad4uFUbxPJxtPM+fVpsqV8+npLyXPgw3+o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bBRpmXz/OJ46D1kU01HvyJjR/j2ItwUKMBvcCj7PZzxhTPVa1oqBTPkllX0ZBgJdKyQThAx3zNLzbPMVF+XPl32iVjtR8C4mSGudOwA9penmTX8czE+0AXZK7UQned2OS8vayFNQ5rDs+r0uW/Lw3Nmqw5fO04K52HSGyjBKGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nwhz3ddh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5246QCRD03215721, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741069572; bh=Qytyx0Oyad4uFUbxPJxtPM+fVpsqV8+npLyXPgw3+o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nwhz3ddh0oPIM62HStFEN+T2DlQn40opMBBWnIMJGTs2jDyFlYvRulcPpX1BaSjTR
	 5IAiHOTN7X/IeTRf9GYk7xFuSGdSTCup8GWCRNrjEDintxpkMUrkViK26odxs7c6mI
	 eK4jeFcK+qRMhkQ3K+QpCibC0smhHWe+/yK7A4+iezgRrFqYyMHY3gPzhJ1kR8kp3I
	 +iwgmNlElPHMzCTdNqb0xlalo/4qn19wR3tnKu1ZYtOgNn0TFZryboTPTb67jLXtVc
	 YXz3qmQ6jq2BC3QVeZMNFn/EDvBekU2JHQjEmrSpXFJilwTrkUHXlT4IfQBgshzre0
	 7uUkwrXE2oiOw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5246QCRD03215721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 14:26:12 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 14:26:13 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Mar 2025 14:26:13 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Tue, 4 Mar 2025 14:26:13 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        "Maciej S. Szmigiero"
	<mail@maciej.szmigiero.name>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
Thread-Topic: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
Thread-Index: AQHbgSMJVrDFmK8Mp0CrjaEmJFua+rNLUekPgAL4rhCAAARNMIATIxStgAEn/FA=
Date: Tue, 4 Mar 2025 06:26:13 +0000
Message-ID: <31416b81a4f646239d8a17a0fbc71e79@realtek.com>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
	<87h64s972a.wl-tiwai@suse.de>	<6224620265674b09b5762f908b5158f9@realtek.com>
	<2fea9fe8-312f-45a0-9bed-455c910fba43@maciej.szmigiero.name>
 <87ldtme10m.wl-tiwai@suse.de>
In-Reply-To: <87ldtme10m.wl-tiwai@suse.de>
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

Like below.

Acked-by: kailang@realtek.com


