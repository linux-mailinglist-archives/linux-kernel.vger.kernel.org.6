Return-Path: <linux-kernel+bounces-227841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BE915723
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3C31F25C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC81A00F7;
	Mon, 24 Jun 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gF7CDuFF"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FD19FA75
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257255; cv=none; b=lARE2OUFM1swXPSFULrywLrdBXWqK+JuXmL5aX8+xOKkOCtuoybWi48LaWHPZuoKGLDpiyBHzSn54tmpfkZ4dxxvs5Xqo/YOlVWbZWUlxZ5cHKzeiiV/AvypIkPJ5VTdhD9cfyYbowcReFg+RIFMmmzRDRosnwgwz/k/2ie78mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257255; c=relaxed/simple;
	bh=aPrgENly1DR9PH/wdtIbg/hUadyOA+qJD/H7Iz6sMP0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IaQg99HO1/plZn3bUBXPywyRL6CVlgf74JXZa46/5BpUzzLHvDL+q6zTTuZbkwJN4zawtfzhiPyIokLDrCc+S79hrVcTJIfZubPFmtKk/pU9N00adkzSZYVOjWLz+V9cTuq/983tKVouPbM2ofXEmfMg/LfBT6iUvuuacg3xnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gF7CDuFF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719257235; x=1719862035; i=markus.elfring@web.de;
	bh=aPrgENly1DR9PH/wdtIbg/hUadyOA+qJD/H7Iz6sMP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gF7CDuFFsPMkq55gL++PZQnaBvPNfrsLcFDaC5Gn6ETiz9h1NCfMbw1kS1cjDAFL
	 4roaIiv0lQU4VNam3oWBGaq1rNRQudAxstQFKSl6eQMHXzBKJ3Gvg0oCDS8OQGMZk
	 iPuwDclIMKq/N82kjzh33YZOcWB/wStExXYqk7eiOC/brFUpC2ziZjiCyTO8xgu2m
	 JQOeyR68hH4R78gRclgjehaj2260/FnRDLLaZ1maEMpFkzPIiCeFs4kxPS25LIjRK
	 ShL5QDaIbp+5qlbC3nS2yzW2isjgEgRoy0YwpOy0qfvPvx+ye6Fo/+f5oyxy9puE6
	 SkwZRwOi1hyq95aEtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1sBgTe0HC1-001mBe; Mon, 24
 Jun 2024 21:27:15 +0200
Message-ID: <b3492198-5345-4bb6-ba89-5efed7ee2440@web.de>
Date: Mon, 24 Jun 2024 21:26:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Check pipe_ctx before it is used
From: Markus Elfring <Markus.Elfring@web.de>
To: Ma Ke <make24@iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>, George Shen <george.shen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Natanel Roizenman <natanel.roizenman@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20240624024835.2278651-1-make24@iscas.ac.cn>
 <8d9791ba-14cf-481f-8964-341880865a0a@web.de>
Content-Language: en-GB
In-Reply-To: <8d9791ba-14cf-481f-8964-341880865a0a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QsoC4SXldUzuk375Wc2WXmE91WuMdOt4J165MAo1T/Xm4WI8sDt
 UkA4C/GmyyhBo/SKIBS9z1TwoSbHvJAxi+X86SGr2txUMITQrkUGi/UMa7HA/z4s9RE7kKV
 kUzBUHz8aPd/H5w/C1UoLAeLcefnWp00R43lS8UC+sUjR9hNeAFetTmL8psYtT44BbS4M0E
 1VxnGZ6svJM3C2cRjgoEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Js37ALAPEAk=;yne6aFhk+Z7F/RX1fsfiZBHhWLF
 HFyvXBX4LgW2UjswFYv6nrBC+5q3DRepStb137Z0h01MG15wDNLJkpMzBexoYTosFHDIPwr/K
 hR67oFGyTo3pNZFNVBT+A+veLGbMxw/c00AtHgm9wzz7mwwbCJN5bIo90iA1bnaCBTKGYRKWh
 O/JT37JysiO98iYXC2JuTyqEPZxNneG0/vgFiZrtH038Le5uvvifif2s+iZBps8KmO7yZ10aT
 4QzQGkf3k1F5BjwUeHacmA8Izzn83Q1mmUcQYBc8rNdI3+i+MhFGLy4vQp9saa1lw4CFXi72A
 rDbrVBnWxfoLEXQ6HI52yNJDgcXJuq8On4uEF1UhSp4qyy/P6bxc5KwyD0zWJJ9TBIf5dsjTn
 4yzYRDbswggBHnEzqy057B560PTQHXPOgD7Mu2wBTqMFC3yVpTTfKXnTxvJtjJi2iYHkt6kEK
 OYl/rti+o0wx02VIIy0AmoSv2a0+X7tHo0JOy17LQDqeBAnpTm4nvBKPRx8V/E4z4UkF+rrW7
 3HfkKK17zO52uMrHP60Ta/gbBm3pVHfHtHahPL7lAi8c3b+gW69+BMJ9W3wDzPDBUNdDND2LU
 i0XfUkd8KJly6YXFOCZBGvV3Sypj1/D5Ehv+Y0tPxiS5H7qxqX1FCYO+R32/IA3pQoRnNDW6X
 eQIhn5kTiKaKCnC6hZrM1kiacz46gCO4L+ngCS6zo4dHCgomrMJnHJSEpt+5eSb8OVZftNW15
 IdLl23Pdz8Lt71q/Hi61PUv2ksuc69D46DMEXcia/X+PMIs0mju8EwjrN3cQCfSuKw+P87bOU
 kZRPWCYoVFjnIVbHHLgdndT6RdGn9lH6T1iiIDv6o1x68=

>> resource_get_otg_master_for_stream() could return NULL, we
>> should check the return value of 'otg_master' before it is
>> used in resource_log_pipe_for_stream().
>
> A similar fix was integrated already according to a contribution
> by Natanel Roizenman.
> From which Linux version did you take source files for your static code =
analyses?
>
> Please take another look at the corresponding software update.
> [PATCH 16/37] drm/amd/display: Add null check in resource_log_pipe_topol=
ogy_update
> https://lore.kernel.org/amd-gfx/20240422152817.2765349-17-aurabindo.pill=
ai@amd.com/

How =E2=80=9Cinteresting=E2=80=9D is it that a similar source code correct=
ion needed
to be repeated by Hersen Wu?

drm/amd/display: Add otg_master NULL check within resource_log_pipe_topolo=
gy_update
https://lore.kernel.org/amd-gfx/20240501071651.3541919-31-chiahsuan.chung@=
amd.com/

Regards,
Markus

