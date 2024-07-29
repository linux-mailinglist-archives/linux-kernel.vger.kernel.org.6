Return-Path: <linux-kernel+bounces-265682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4F93F45E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C82281B75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A8145FED;
	Mon, 29 Jul 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QjAfDo5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XcbfXzYE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E79B8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253491; cv=none; b=Q/1ivF/kcEHxxDnH9HPZ7N+AraPoGUOQ5qvZT0yZpTr167pJyq+QP7f2k8Iv1+ArSFwUmwhcbvVNXt1dCbD4kSTjGbTysOfP350p6ZO/MPv1qhXAE17i2QZNFFBiJ5wTgP2eHaCTo6DLNzuoMeFudV4vU14VBK1pnS816WZ/dD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253491; c=relaxed/simple;
	bh=0tmFNypyshnRwkpg51uHNNisxl2nXHYyJxMT0DsI7EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFGtRd1XODOKztvQwRZNJfKgXqm4Jpn70McMkfWA4Gbqs+YBHysXTAZQdQLOU8Ug7LmYWBvgBH8wGqNaG1m8kYuP8cW/ZfxMqtIP3OtUqe9O+Ngj0Ix70OMwH12jWrHY6GKo94NpxGvceZKNOVutdNp5Eh3royhrVraGEGoXGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QjAfDo5v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XcbfXzYE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722253487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tmFNypyshnRwkpg51uHNNisxl2nXHYyJxMT0DsI7EM=;
	b=QjAfDo5vU2fxJ+UagZoVc6NX4d9xN+KazfRA3LTgdNpUbJ7BBinSR1UQiCaD587XKQ5Wji
	CMrmHwXhe+cPCJidB9K+yeQp5jV8TNwD9JKzMdWTNeaA7/6vpdNJmFfd5Jtv+I7dfktwTX
	nG4xCShu0+l0uHwnMDa1+jQMWiFMAZndHVjKffBBPatlTB18nHp6WQmtAt/g/s3IQEQ/Wx
	/Xg3BAVs4gkJU+hb/zRlxET2BfZkVI9kLrN7ix0F6hiDg+irShPpF746y6zin/1HF9gLmx
	3bZ6cxJbcHDpTsZzlpNTOeqCA7OG1IoGrSyrSFtDIT40FigZ/tojuK5A/QqeoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722253487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tmFNypyshnRwkpg51uHNNisxl2nXHYyJxMT0DsI7EM=;
	b=XcbfXzYEBAqt0exLFcDLaJilej8ah8SNEOftkTqRVmXA9D9qCbxziTibE+h/SnKduH4Epn
	8H7qpPLTJWAJoACw==
To: =?utf-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,
 =?utf-8?B?5byg5ZiJ5Lyf?= <zhangjiawei8@xiaomi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?546L6Z+s?=
 <lingyue@xiaomi.com>, =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, =?utf-8?B?5qKB5Lyf6bmP?=
 <weipengliang@xiaomi.com>, =?utf-8?B?57+B6YeR6aOe?=
 <wengjinfei@xiaomi.com>
Subject: RE: [External Mail]Re: Race condition when replacing the broadcast
 timer
In-Reply-To: <87o775uh0y.ffs@tglx>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx> <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
 <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
 <bc1a086b932f454f9379c49221983675@xiaomi.com> <87o775uh0y.ffs@tglx>
Date: Mon, 29 Jul 2024 13:44:47 +0200
Message-ID: <87frrs8lsg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10 2024 at 22:30, Thomas Gleixner wrote:
> On Mon, Jul 01 2024 at 02:11, =E6=9C=B1=E6=81=BA=E4=B9=BE wrote:
>> Jiawei,
>> Please update here when you have the test result
>
> Any update on this?

Gentle reminder.

