Return-Path: <linux-kernel+bounces-231369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40E91948F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AEA1F234E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F904190069;
	Wed, 26 Jun 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TM6eDvG/"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006B14D458
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428437; cv=none; b=CjkIB3X1vmTL+VLUjbGX6GjL3L0UnkSLTIOg7gg+S7WM97oZf0QIs8MG73A+/uI5FY4ZgY7XEIPHQfmvSEJcSYHW8vW1S6PF559P2ibUzlGRoj43V2P52jJR8sJW/qnFPsYYH9I6qklE8OM9vDgmPRyB3LSCzvQ3xApQqgdJJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428437; c=relaxed/simple;
	bh=29KHwZye0kesocr9dbrXEFn2i9JHQORDS/QSHCR5JkE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mJczZ/JCpMnbdIxHuBVoJSD83dDRJvyQrmbKtBE9qb8MxgyEXBUkTDtXVIJIwCxkhIQ02/8gWwC7WwLj/NLmfkSwBlJkazN8Oqv6tPR7RpYCwkkhF53Pz69DK16rXs4xIL9aCb20Jjqxuvg/k37sMIDXsG2dYnYa6uqmu9TSgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TM6eDvG/; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719428410; x=1720033210; i=markus.elfring@web.de;
	bh=29KHwZye0kesocr9dbrXEFn2i9JHQORDS/QSHCR5JkE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TM6eDvG/9OoSM+SVdICxRRIMdx6I/27LLao9HyGCgKqu7eCw9JftV/l1QQcQ9190
	 nWpBPHbBiVsaTqz9RpURaQJ2E8tezAtmqts2UpDMY862srNiCQXTto9U5iiuE+tkT
	 EP7FvY3FL3Tv1+4CsPoVICzDDgDNSbdjolOm3v1vxoDfQkWkvwo38WJtzBDSkxB4u
	 ug//suhD2qi6q36ep/1ZBhYO6HYr8hc7pw2JSnkbq1pHNUJRe/TVYt3QHS5jB7tr+
	 Am7ktLx52BCbqIFT/9RImbkwbKKGyort17DVS68D+mjAmgStqA7vc5/m9I5J6aW4/
	 AljtGV8lDzXjWV2bhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1sP50t2yXR-00vvCj; Wed, 26
 Jun 2024 21:00:10 +0200
Message-ID: <9789db5b-faff-422f-a772-d3c4be1fbb37@web.de>
Date: Wed, 26 Jun 2024 21:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Ma Ke <make24@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
References: <d62e10cd-6e27-4498-b90f-3ec891686070@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add null check before access structs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d62e10cd-6e27-4498-b90f-3ec891686070@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+qiR8aDMloWDxybWsjmFMuQPscTm7+84T56DXRpPb7kAjI+KLE
 QKSu6Cie3RSPvfNjF9vLArLxaIC10u2DbIZO90rISaM3A5u/q54aRbz9XGgM+NjARiRZ/x+
 snzgJPAw4CMgppfsFLBK1YMZSNgtIDzKzkAMhO1rLYUNe9acr5zntwppUrKOCnQY1yFnjPT
 f11Qgzqylv6rb97vfcIlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GA+IBcd9gGo=;KPp2FlQiLy41n6X8fBfmcAFqaq0
 RJ5OB2Um2s3/olhxCjMg7LX3VaydggOTlQvvvmUh5Pb3W5KycafMTDtvEVfvP16V3C3nZi7Go
 sRMz6pdU6sTx76HCWh80gsKzXsjl/ds1alc4ZtB1Q5Jl7srqVN4QLkIRa3mhxSnqGfiODls+j
 fU7DUiWsWQmynL2XEBRIHHttqOjyEBQgZOAO5SO9UzdlhtPn9FgD8zJOmDhZmbuy7P3FjiDS+
 LZGHkUNcCiq0nj+smNehKsz/5UIzn8yFe8m6YigK3erzVApNKxo/b7/dqFH6zPy1/+y78uOyS
 LKdrQCp4G5RtkAPUNRco5pfeGWgbk6MVnHYcluAQxXG0rpWawSWYLT6hr6fM9v0/aH1L82onQ
 cs9Wntd1Eh78F1sHQSeBKKyjhrOIIG8RmzbrigUBaw/a3ijEtyTZoo4Yyjj94cfONcqkepZ9C
 0xkRyrv7SiSdx5+g5roKJ9l25sxxkFDTZghj0U3dhPOYGvaer24U3csUB5/32fSSwrH2fYh0v
 NRTc3KV6x9lOT3ZdljZTrm2zHfUFhO3HxTgMdqCyVFrLml90H2XuO87E53PJTSvkNITsZOV73
 fVFuZiBtrlnH0EuyL7VbBpBESAQ3PVpx28G06NDMOC8FXnSvo0CA7fQcIK/7/rNly3/vt3ju6
 /WxqBs7FlOePcuiUgawwhG8vb6SLvfyaA/GJ1rUJz1GHuxUIB2f2hDxRXZQnlUi2FiQGp43PA
 ZQAD1zrweILEHI8S04RNB/E3ZZqSL2IHTLkwQeBaenOk/mkYvXB3zf8ZY40JvhvKqiqgKEj7w
 B7pKbbtFV6kGV1Wx6ijEpNPYgGdR6/TryDN8gYUkOmhgA=

> > In enable_phantom_plane, we should better check null pointer before
> > accessing various structs.
>
> Thanks for the fix, I'll apply this.

Do you care for better commit messages and summary phrases?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n45

Regards,
Markus

