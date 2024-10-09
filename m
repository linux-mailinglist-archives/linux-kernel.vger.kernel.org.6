Return-Path: <linux-kernel+bounces-357987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375A9978CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8697283E73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5E1917C0;
	Wed,  9 Oct 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCbGk142"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA828F5;
	Wed,  9 Oct 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514907; cv=none; b=uGLqLuVukoBcOc1YN1iuOl89AA3LGy54hyPn6uRraRLjx6x5SXzAa0P7RlyPnJVpxhPLmWCwxOPcnYPIv6N8fxFsvBZa49vHcsByHFgGZCDwiHf24RyVWDkozJthE7TgMap2tRriUfF2IODEOF/TmGtR3gNWi9mo69iIecOGGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514907; c=relaxed/simple;
	bh=vmw6SJWQe8SICYrRf6J/NKeTEhnmkp9sXHM+NZbJeCw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=LJfnQQK+jSSE0aCLG1g+CA3QgCuu28GCXVCk0t8cR4zh1jkpy96G75cvGdctK5VPIMEIGyuRLW53D8hg3Q9VAxFGvPbLh8frL23Yqf3SchMPPEldDmlkipnGA3i0hfFGvXfRpjXSNFan7QCo3zode1FlsNKH+2VjQ7JjQzDaRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCbGk142; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A944C4CECE;
	Wed,  9 Oct 2024 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514907;
	bh=vmw6SJWQe8SICYrRf6J/NKeTEhnmkp9sXHM+NZbJeCw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CCbGk142gr0+izaVFRXP/QZEs8GTqTbZ4+nmpLAL7CFCLye4rovCfQMjmFy0G7Mh+
	 xKN+WxjJyLk2Iq9LI3KR5cH2R6PV73V6WRsxJXR9K/5gKFuh074PSIJziJJxVwZ4Ml
	 tHSzkxeRwZv3BimvhiToiBqM1hhjDt4QwnSQaXXD6Uk7zeaMHlJbV4g/N6FpdsWdA2
	 dlSriQAgOlkXxAt3zYINlrwAHSS1AMaca6d2mxY3cx8iCzQw8T1Zcn6AyQxbPKoZmC
	 Il4Poqo0TCI1nHEXvl5uUIBGrp8g8SUMkpDN5dx/HEHwsZs/fImNR0zqN3wAzvi2yr
	 lWZQd551MZzaQ==
Message-ID: <b8f0036b3775c49ec10c949c1ddb3ceb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240918123150.1540161-9-u.kleine-koenig@baylibre.com>
References: <20240918123150.1540161-9-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] clk: Drop explicit initialization of struct i2c_device_id::driver_data to 0
From: Stephen Boyd <sboyd@kernel.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Wed, 09 Oct 2024 16:01:45 -0700
User-Agent: alot/0.10

Quoting Uwe Kleine-K=C3=B6nig (2024-09-18 05:31:51)
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Applied to clk-next

