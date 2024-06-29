Return-Path: <linux-kernel+bounces-234981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8335691CDE8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F066B21973
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DA84D14;
	Sat, 29 Jun 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="fIveWBJk"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735D4175A
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675157; cv=none; b=WXu0L4a6bpaFWixpITiWHdT8eP9NZH7e4g/q3/FXgLtBEDQVGzcYfqXM0zFHigyfCBeY8T8P9MvgIYwsCtn34cU32o+WizNLs37iPwgap2zDOG3H59n0XHOhCSBPDekwTxZbo0pHrl5vS2dgKMOLoutYDISGrZaR3oLVfrE1sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675157; c=relaxed/simple;
	bh=ARk1CN4SNcrfhu3AqT6RA6aL1fK6aSQsAxE+h/7vxhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPGM5xeNOx64m7Zykhfz0ZzeDCKKxtpP469lDWzVCqV18BqSpGN0DaUG6OT+YMJeB51H+kRGlHA51gz2tNdzvANz1pkAdFzKBI5CVIwT8ZLrq99OgfGHhQTydsoX1N4Y+j+gEDqMzfE/5WhYrKt0rrY5irgInJrQ9aaLaYYWBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=fIveWBJk; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1719675146; x=1719934346;
	bh=ARk1CN4SNcrfhu3AqT6RA6aL1fK6aSQsAxE+h/7vxhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fIveWBJkSHRuccK8cvS5m9EEIOm7OhJ7/rp9IPhhkZjWp0WSdqOExdFE+mGuPkHxP
	 cDBCGiR0XfY7FeY5UNf0VG2msGpfX/4bJcw3JAemv4hFre+JtpXjqk66x6mbxAINIG
	 YtCb39zRvqmZTFMNcC3ko3NNGtvvLMawB+DyLvvH9NOh+l9+271W9CVR6+bOFBREho
	 FdRso2Eg4Q8fA2PjhPnFni1RodWQ7zDN+ehoB4FUZpCwAqh6D3jNo4slCK+rs2wVeK
	 YS68CZVR+6wz5fg8T9/alry7xsyYtXBkL/fY+J1vZgoAYwRazqsUt4kxHja+RQ37HI
	 2t0pJJOyRBVQA==
Date: Sat, 29 Jun 2024 15:32:20 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Message-ID: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
In-Reply-To: <20240622170951.738735-1-andrealmeid@igalia.com>
References: <20240622170951.738735-1-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: eb194cda8e85e2e446f855a2521d5ab3ca4f3c8d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, June 22nd, 2024 at 19:09, Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:

> Allow userspace to use explicit synchronization with atomic async flips.
> That means that the flip will wait for some hardware fence, and then
> will flip as soon as possible (async) in regard of the vblank.

LGTM.

Would you mind sending a patch for FB_DAMAGE_CLIPS as well?

Reviewed-by: Simon Ser <contact@emersion.fr>

