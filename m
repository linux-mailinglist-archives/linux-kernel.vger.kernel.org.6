Return-Path: <linux-kernel+bounces-521078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11BA3B3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517AE189662F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301F1C9B62;
	Wed, 19 Feb 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fjy/QdeU"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E1180A80
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953669; cv=none; b=RSiQfL0REn63Ks+TE71DrLnMDRneeKraEUM6+1xI6k5xAXDxAQdgm3MHzNl4sM9pJNX0MwzIz7vrS+wSoW37XhAE5UzrihYK8hlxNW8Z9iqk5kDcC+VlXXbibu0OP1DtOhz8kO5VdhaZ47bGRUuCQ6uciGaVYxM7v7xhtKDfRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953669; c=relaxed/simple;
	bh=MdE5hy8GgaZsGdMeNrTMbtatiPNpR+GtJnfA63p992M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tF4iGJhOYAmty1mPap1Bq56A9+fEf0G/Wu9gBeFDhjdvUOVsTqPhjlJs4QWuix0p0YbHURuLifycIE+beJA6U4jOfVgZ1KOpYKpklgzwQ3Gr0tXDgYNeeGPBnXnTvFW0O7G1aIH9Ka7RK0cqzHpyC9Be421ibghyVUYPrsEpCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fjy/QdeU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51J8REngC3080172, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739953634; bh=MdE5hy8GgaZsGdMeNrTMbtatiPNpR+GtJnfA63p992M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fjy/QdeUpGg8+zcbOEwon/tQnKp3ljLB9GmfUZs6NpR8zW31eFJ5bxP7U8E0elPj1
	 BX425b9nc4HDzT0zECq2qAkeC3UnNSKeP45jQziyncJkhhBRinD9zWzzskSkRbV2Qf
	 MucmecOXgFNFnFs85/uuf08CwGArvQJg/0jMK0Hi9Mb8dUuaaUArA+emfpCG7yNz99
	 kSu5EAer8Mb8nvYwDhgbkhTjSKxwfeFLogN0Cq6rnOdj+9kf46upc+9Lk9nRdGHNpm
	 n3jvUqWj+iruJQsQDqljAFkGxhG1h4aZN2+S7IrMjlnxOMC63txO/f7PXKfZtoH7S8
	 4icTbKhqLzClg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51J8REngC3080172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:27:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 16:27:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Feb 2025 16:27:14 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 19 Feb 2025 16:27:14 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        "Maciej S. Szmigiero"
	<mail@maciej.szmigiero.name>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
Thread-Topic: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
Thread-Index: AQHbgSMJVrDFmK8Mp0CrjaEmJFua+rNLUekPgAL4rhA=
Date: Wed, 19 Feb 2025 08:27:14 +0000
Message-ID: <9d44b8ccf3ac47ef972ad68c11c96a9b@realtek.com>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
 <87h64s972a.wl-tiwai@suse.de>
In-Reply-To: <87h64s972a.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Hi Maciej S,

Could you test plug headphone then speaker will mute or not?

Below was why I close the beep mode.
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=
=3Dfcfc9f711d1e2fc7876ac12b1b16c509404b9625


Hi Takashi,

COEF 0x36 bit 13 was the enable bit for pcbeep passthrough for 0x14.
If this patch no PM issues and speaker can mute by plug headphone or headse=
t, I think this work for me.

