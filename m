Return-Path: <linux-kernel+bounces-238929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EE92537D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFDD282D32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC049652;
	Wed,  3 Jul 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="msqADFNG"
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF41DA316
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986678; cv=none; b=UcXxoRdFqVtzd1r47SbH1/K902vMO+kfw84m7aHgP+MZ1n3UPNA14yXNC5N4PXzKR54x290bx5RilP3BHi99nrGW0znAnIZ2KKasSLQzAJbMWR3SBKYSCKtUYfF7iwz5yVd+nQICI6Sdt9FPAlgIX+P4hyqYKDjR6S7Ke0e7gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986678; c=relaxed/simple;
	bh=1Tw2pPg5VcTqdZV+dstC4dUr6AJmx6XOfqPDGcrnLKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eetOnRhCI9BvmgcREUitvdC8A5c7F+uA3PgF3yjPtebXfHFmRRG/jVtBwnb6kpkpa2xY7XJjn5zEouQBVVy8t+Yzy36izgxJfv4751cbKlIU1N/Fqx0A4Uxa60EtSmpcIdB6GVbknd+Iwm4Sh7X9FUitpPmhwbb5PD9e6jI3QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=msqADFNG; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1719986667; x=1720245867;
	bh=1Tw2pPg5VcTqdZV+dstC4dUr6AJmx6XOfqPDGcrnLKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=msqADFNGzz+QGisVihmrsWXDDg+9XIP/sd7IIj2xHjU4DxetwlnXvTzA4eFo35XL3
	 ogYq2hwD2QmhAzYm3JCeVEUHh5UoyZM9ZbBi4MdvE/hCZz9qUoLvWpuVkHwdnCWFp2
	 fuPYP4Rc2I1iG5ZeDglhBAiSHXeA0E3ABlaRWDHVjdFLQDtqI+aGHxIy4lliPYC/V9
	 w9S94uRry3rOpsANQFvp6UbRCodmxMmnypguiAg6Y6tYW3QlInYLDAjfojsWz5SDv/
	 k5U+zhKF5gbUepeFp87VXFn9xe5YZXYpUwJfkmAPczaiqljksXvw1++iAYVadqcu+z
	 ihdClS3v3nKVg==
Date: Wed, 03 Jul 2024 06:04:21 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/atomic: Allow userspace to use damage clips with async flips
Message-ID: <Y7XXNRZbyuqt9XZPtxVFRJgywsSTpsDwdWZjhxWnYH3lPSwa0-hVV1kgXzb0q8BAMRvH8eEMdPHOvgAn2KI5HcaWazmQvRyfI7NvQBAU4Z0=@emersion.fr>
In-Reply-To: <20240702212215.109696-2-andrealmeid@igalia.com>
References: <20240702212215.109696-1-andrealmeid@igalia.com> <20240702212215.109696-2-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 0dd41e430d756e207182de869cba7ff4f635e530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looks good to me as well, thank you!

Reviewed-by: Simon Ser <contact@emersion.fr>

