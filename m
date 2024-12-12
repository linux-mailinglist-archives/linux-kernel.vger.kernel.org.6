Return-Path: <linux-kernel+bounces-442722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDA99EE0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3195282B45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FF20C013;
	Thu, 12 Dec 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR/0VgML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971020CCEC;
	Thu, 12 Dec 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990581; cv=none; b=LWZDEBOlj011m/Qvt707XCnY8zKjFISHdeExgRIp4hN9ronN1Ld1ZvzFre7QfpNIrKApmQg7YU13in8qv9Qd1C7XReYHWUMzByDS9F4kjIbQ5np0eiy2wzIT6/KcwTXNU4LdLGXMQKjNW25XuS0Qby815rT0fssiK5WO8KgtjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990581; c=relaxed/simple;
	bh=gEtg6k4+jAA27/mwhy/FA8PtloL7/FESqCtmrmaO7BQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=JiDevLav5t0qneUMMeDHZlmFalxMta5rH1WjlTmW3lNJotC77DT7DT8a4VY4A7o/wZRWbUcnAJ8bx/GKbIsnduL8Zv9nxHt29RZL7fj124NED3vrincerAtkM7px4lHKaBFDQFM6u47r6NoPdY9LwE+xrtzM8QspLYxhLz55RN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR/0VgML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449E5C4CEDE;
	Thu, 12 Dec 2024 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990580;
	bh=gEtg6k4+jAA27/mwhy/FA8PtloL7/FESqCtmrmaO7BQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=BR/0VgMLmeBvtGLMhmxicV1p3cT0rJrL7HMfyUDwbFDKrTsWMxIezNqF03ItvwzQm
	 BWCxKncYJ4DuvDj28nHX8gF66YLkzRa1jyLtovsPam05NUHK+UaTOTdCWvH1UnPCLG
	 djylASve6pz+jBANGjaOinZxwQ6zFmwWRO2nUDx1j5qbxXnA5iEvrpy5SjzDdvtap4
	 fEn8ZD5mI0ACd9DQdVfsJOFoRAfNI9lQqedW+hUGKJjSSLxXcIrRTYVKzgVYJtlFwN
	 Me41vB3x9e2uoQCbKy12dIp8ygwLzGaLeSQqsqN9vm5h/T9NXLrah9H/7TeMRI4qMT
	 xDUi3JlSL+CLg==
Message-ID: <f3051a8c08d8af623d686cea162c945e@kernel.org>
Date: Thu, 12 Dec 2024 08:02:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 12/19] drm/imx: Add i.MX8qxp Display Controller KMS
In-Reply-To: <20241209033923.3009629-13-victor.liu@nxp.com>
References: <20241209033923.3009629-13-victor.liu@nxp.com>
Cc: agx@sigxcpu.org, airlied@gmail.com, aisheng.dong@nxp.com, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, festevam@gmail.com, francesco@dolcini.it, frank.li@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, p.zabel@pengutronix.de, robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, u.kleine-koenig@baylibre.com, vkoul@kernel.org, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 9 Dec 2024 11:39:16 +0800, Liu Ying wrote:
> i.MX8qxp Display Controller(DC) is comprised of three main components that
> include a blit engine for 2D graphics accelerations, display controller f=
or
> display output processing, as well as a command sequencer.  Add kernel
> mode setting support for the display controller part with two CRTCs and
> two primary planes(backed by FetchLayer and FetchWarp respectively).  The
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

