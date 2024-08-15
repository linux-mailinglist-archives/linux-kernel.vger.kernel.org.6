Return-Path: <linux-kernel+bounces-287811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0F952CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470741C21353
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B91AC8A3;
	Thu, 15 Aug 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uPemGt1/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D581AC88E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718456; cv=none; b=C/dUobU3BhDxPvfLSYfQ/FYI7JG+POetqaWLEIrjA2AhtcWsUXjEw2pqeG515E0KmSeZ+2GhPj9kYpRkUtYqZSn5CvQdNeV6euqG4VfmJ6pk3DGYQGgFEcnSEf68qoEyAMgWZU4OvVGLbLYnM23AekWwC60qgqQa8lrAaxxgAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718456; c=relaxed/simple;
	bh=PcaTsOoGEPHQnd0euVouxKS23AQ3Nc0N9ibDnvVUt5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtMcn4fP1Tkh17rxKGA2YtiFwY+m7WxEB5r2l4+MAJuXejvhhKmR0FB3WViunAnLX2KH/RoaOxg/11ZJv8jMX3lXrr5kavq/LVHmxdrCfWLESw2ZOIapoIXEwPEdL1B4IfcwaA6RsvtflV2dmPqIvs7QB7MqkNJUmSVqcSjG4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uPemGt1/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5W9Wpx+Nnjyhf+vekam8upWRPfSyFjdBVs1M3EoZVFw=; b=uPemGt1/Ke+dHFyYvX18I4VYkm
	hSvvRaWdLH+nC42xtFH3zJza+93Ew4YaeWy2tx42RzGeQn20mak+fp+pT63yeDibTePn1+YjPaSlG
	Uq1CxO9MTcBPrFE3m74t7uPVPyVA5VMZY7fsS0RI+vWskFD07mT7LWgpTcjHWBqPFYWAElhBbuvXi
	aRITjN6snq5uruze94Jv5u4FTVlo3qHnKrLKxz73MN/7jXTuiOrA+jrdDRYXX9b5ZmFgliyQlvA0+
	cKOou6jerwlt6JLJJRLrpDRlG3kYn3hiG7bPizIFNiI262ptF0eWaZBcbE/R+wotCccH++Ug7Vvv2
	9cIzP/3Q==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuH-0000nZ-7E; Thu, 15 Aug 2024 12:40:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	airlied@gmail.com,
	daniel@ffwll.ch,
	andy.yan@rock-chips.com,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hjc@rock-chips.com,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Clean up a few logged messages
Date: Thu, 15 Aug 2024 12:40:31 +0200
Message-Id: <172371788340.684432.3183669049968037964.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
References: <92db74a313547c087cc71059428698c4ec37a9ae.1720048818.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 4 Jul 2024 01:32:20 +0200, Dragan Simic wrote:
> Clean up a few logged messages, which were previously worded as rather
> incomplete sentences separated by periods.  This was both a bit unreadable
> and grammatically incorrect, so convert them into partial sentences separated
> (or connected) by semicolons, together with some wording improvements.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: Clean up a few logged messages
      commit: f7f4df8851194d2635fb7989582014329dcffa12

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

