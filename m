Return-Path: <linux-kernel+bounces-186293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E98CC24F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A331F24368
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358414038F;
	Wed, 22 May 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="yvIGFZrS"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAF13F44F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385246; cv=none; b=mM9U1JvUbS5DDgvxC88yYVWBhEGW5Dp/n4+GAmzxKs1pEs6osyH22zIp22NKTf/kARpucrqWWCtHqnqa/isVsp37muVJW7bOAtBz9V3dkpNuOgq6a5CztVuvIh505lHz2jIYR9Q2PTSr9zvlJdddaG5m5w8lyjgQnphlsLRNzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385246; c=relaxed/simple;
	bh=wtv5GehB0RNRrwKNMSpWWR1rBRSVtWsYLFCegIScuU4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sinQ9GoWblbH/R+1Q5faNReEntG7GGCOTxBMeIr+W6yLLNTcEvtGQuP+fPqAZF/kx86cy/d7FD7ZHU+WkphB5xQHZNHp/N5O3Zz9cv4ogiL2Y/Ysu3Qm+wflpI/uY1d2dBtvcuZfXSNreL8mATQpoCbPoll8yvpBKqQmgZysDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=yvIGFZrS; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1716385240; x=1716644440;
	bh=wtv5GehB0RNRrwKNMSpWWR1rBRSVtWsYLFCegIScuU4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=yvIGFZrSL3iRU85LAzfwzh+uq0jLCjADU6LMEGnjMcGt++u5/NLIlJG88CSeTIRcf
	 GPHdN9aBbDdIBmDReF13JTw6whWLxrYdcN0y0DLD7b2XyIHFcoIZu112gaPWkTiop9
	 9N/28V7OxshKIW5zjoaUo7dYNXP58prPUvRtEW7bF2Byi1O5XQxLpTE7v+vsMmhMsj
	 S37g+lawcenjPzcgC6vZF2FwovTw1QBhHXJfxIhw+z3hFV3y2SxlBqrYoipBcVUhNg
	 OI0R4GzDpatz7CDja0Q6bd8q7alaWZx2gzFAzSx0rMeyvVOMOJdesZW+WO+q2m2yRg
	 cCT7AA126qLgA==
Date: Wed, 22 May 2024 13:40:36 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?Q?Rino_Andr=C3=A9_Johnsen?= <rinoandrejohnsen@gmail.com>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Wayne Lin <wayne.lin@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Add pixel encoding info to debugfs
Message-ID: <1XiLpoWd2E_COrHNl9BYkmCXkUKK6Bv1wibdFxiw3Vi6AQOPAIhrIMPNEZmmKAp9yxC8Er4DEMqOqjshMgRqtpV3UkS7MN2OjCsDjllvdRE=@emersion.fr>
In-Reply-To: <666e36b7-5379-46ef-a16b-00ec499fb42c@amd.com>
References: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com> <20240521051140.30509-1-rinoandrejohnsen@gmail.com> <17782a6e-db84-4c20-874a-342b9655ffc5@amd.com> <CAACkh=-B-jH6g7KY7Nn_7Y_+gHPQ7G5Z5AZ0=a=_ifjcmsorcw@mail.gmail.com> <86410711-9b88-448c-9148-109f81b1ca55@amd.com> <CAACkh=9hY7eg_uuH7Psm=XJfSzwQTvzs8bvOXQ=wwkMPrC44SA@mail.gmail.com> <666e36b7-5379-46ef-a16b-00ec499fb42c@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: b585325d54e6bc294fd23a41f27306f095acabbc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 22nd, 2024 at 15:36, Mario Limonciello <mario.limonciello=
@amd.com> wrote:

> > To be perfectly honest with you, I haven't given that much though. I
> > used the 'bpc' and 'colorspace' property in debugfs, since I could not
> > find that information anywhere else. And since I also needed to verify
> > the pixel encoding being used, I added it where those other values
> > were. That made for a simple and easy addition for this property.
> >=20
> > If you want me to do this differently, let me know. And please point
> > me to the standardized DRM property where I should expose the values.

FWIW, there is a patch from Andri to add a similar (?) property:
https://lore.kernel.org/dri-devel/20240115160554.720247-1-andri@yngvason.is=
/

The patch also allows user-space to set the "pixel encoding".

