Return-Path: <linux-kernel+bounces-269691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F29435DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201981C21CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADDA482DD;
	Wed, 31 Jul 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="DQ2Dvjgr"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E54084E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451968; cv=none; b=AKXb47KZBOZSEJUtf3uh9hQ92XFqwZqtnzklfgXG182f2UASfKuKwWN+Jv1tc/U8BmQ5t0OXIjeiAi6gaGblSZJ8u81izU9bWS/4jAhb0xI+rwC8xJ+6AQXzH4YrbIZs2MJ3W7XEvEjvbN8078HrnR6t5NNXFSG8hUIYHChd3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451968; c=relaxed/simple;
	bh=j/5XcbIq07wd41SYVofw1c/EmPcr+Uvp2VwHqgGr8jo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cqe27tNho8sPBgrU6gdbB2D2BLmfKdh5B8GBVWZCXyNpY9s3EyF6J+VWrTf5ikP21GtPWd/c7EWW5Fa6QHlOkxVx8eyxEBJjcLoAzueBt3GAOTmUSz0uJyVzqzvd9JgYYBbAzihjdOZAfboLHTK3QwI+AOF/w3yaEiPC/crNNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=DQ2Dvjgr; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail; t=1722451948; x=1722711148;
	bh=j/5XcbIq07wd41SYVofw1c/EmPcr+Uvp2VwHqgGr8jo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DQ2DvjgrMj87kjzwf8jblERsqNIWu2raUVL/kDFfCLOELB9bVICBbEMJfihsimCil
	 rKAncQ4152NlLnpthTTbs+Nkampkv3Ee9wZU675TwYTuW6tqPemIvsDEhWUBr4/912
	 ShPRrPqTqazB53/11Ge8rWZobXdQbRc9v/8S4vm1PUrrNIKZ55arxQxuLd1W+UUBX4
	 WI+OHuUwVRyFzM9ejuDG8JJQda0SqQpMtFmC4E4gp4LyPD2J0/bMPKG4VpxvtwkYtL
	 4KpuRCro8iCfgLERO8R58av0ddAwYBJyqrH8AYJUN9GOKRurNc+MHFBbh4Sb11RZaz
	 fyKlYcSzPZxSQ==
Date: Wed, 31 Jul 2024 18:52:21 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/atomic: Allow userspace to use damage clips with async flips
Message-ID: <OI4kMMLEzKSiSFR7TdYmIUAnUicSI0lW14YSJb_ylxwRrHGMCiNLnqFIe73K_s87v0z5nzRYASZD68SqgQAR08GCdLRMRCPWrWdA0hS86xI=@emersion.fr>
In-Reply-To: <Y7XXNRZbyuqt9XZPtxVFRJgywsSTpsDwdWZjhxWnYH3lPSwa0-hVV1kgXzb0q8BAMRvH8eEMdPHOvgAn2KI5HcaWazmQvRyfI7NvQBAU4Z0=@emersion.fr>
References: <20240702212215.109696-1-andrealmeid@igalia.com> <20240702212215.109696-2-andrealmeid@igalia.com> <Y7XXNRZbyuqt9XZPtxVFRJgywsSTpsDwdWZjhxWnYH3lPSwa0-hVV1kgXzb0q8BAMRvH8eEMdPHOvgAn2KI5HcaWazmQvRyfI7NvQBAU4Z0=@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 3cc181851783a7a624f055a95095882c63f6a6fb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I've pushed both patches to drm-misc-fixes, thanks!

I've added a Fixes trailer accordingly.

I'll rebase my patch on top of these two.

