Return-Path: <linux-kernel+bounces-446233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E49F2186
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC157A0F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAD1B6CE0;
	Sat, 14 Dec 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RnqVn1Un"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26A189F56;
	Sat, 14 Dec 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734217880; cv=none; b=mZqPN7IQK5AMnkasmj6TmmnAvf8nd9C0y3q0s65QLQ407OKP+Pgogb9r6TqfXu5cc2hjac6lfbdVoW1YzDOazKDqakt2+f0Q7hQSp6tMPn74vUWOnSN+8bwPu6/qPxKW6MU1stQd+l68ThGwcKEBlB7O1PUatgASOzvCwNy0GxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734217880; c=relaxed/simple;
	bh=jujhRYcPVTrUs0etkvfX0ryjQvD9n3p3jl6EHZ+CLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPLuqGYEFth0rRznt2EMlfiEXS/SWoh7Vv5U1WrJX6cIGD+fnDk0qcARbdarJvirUljURlxwgaeyGzqkkfeHN+5RaUvMB14eksnxqcoWvkP9LGRvmAEbbVdQaxXRhbiJIEEsSthZ+g6Rshp97DsGdxM84sSiNm5tlgHxpar/BMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RnqVn1Un; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XnK2zDuvd06Q2CdiF2Jh3uNypUBp9FI0ZgGJeXwzVXE=; b=RnqVn1UnoQXWoLja4YR73nNs8V
	f4ojahwjcd60HFpXz2b0Zd3coUK1ak/NqeB6Q3bXPTRVnWcJ3EaBwBvSGBAiqfyqCtfVlzweOYtV4
	kxTXMtq/WxATh47oyPHXSKtBloW3pWaMupYtl8h23D/oAT6EXDslUk2oFIeMHGwKmQhj/2z0tbVxu
	dEjtwCJowbzD+pez8qS9vOtXmOz553JZnoIGLXMfC6grpNyQ9M6SROoQGOy9fE9QVrQmDb0wNZ/vy
	MpvIiEzBEbi+hBLufxhoLPKmkVM/kxtgOchxnS8J3x5/8UdQutVHqG1sS7KnIkmPqmFWBzVI7wBib
	HP51q6JA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tMbHy-0000hg-VZ; Sun, 15 Dec 2024 00:11:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v6 00/16] VOP Support for rk3576
Date: Sun, 15 Dec 2024 00:11:07 +0100
Message-ID: <173421785408.212079.5671999900653465901.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241214081719.3330518-1-andyshrk@163.com>
References: <20241214081719.3330518-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 14 Dec 2024 16:16:59 +0800, Andy Yan wrote:
> Thanks for the basic work from Collabora, I can bringup a HDMI
> display out on rk3576.
> 
> PATCH 1 is a carryover from the working when add support for
>     rk3588[0], is very usefull when some people want me
>     help debug some issue online, so I really hope it can
>     be merged at this round.
> PATCH 2~8 are bugfix of rk3588 alpha blending which report and
>     test by Derek
> PATCH 9~13 are preparations for rk3576 support
> PATCH 17~18 are real support for rk376
> 
> [...]

Applied, thanks!

[01/16] drm/rockchip: vop2: Add debugfs support
        commit: 779964556c64cd3d76ddfeb34738ef78020fae84
[02/16] drm/rockchip: vop2: Fix the windows switch between different layers
        commit: 0ca953ac226eaffbe1a795f5e517095a8d494921

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

