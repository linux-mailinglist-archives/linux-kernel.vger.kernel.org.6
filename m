Return-Path: <linux-kernel+bounces-403355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7979C3487
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C18F1C20B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE4146A7A;
	Sun, 10 Nov 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="S5wwPJIr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72426AD3;
	Sun, 10 Nov 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731269636; cv=none; b=HmOChAkC6LNobIjxSr4HzWox9bIZonKk3HqWlzzxzl3b8Gqq2EvmJUV7g06hXjTzlXPKj3J21Pk0tSqjVcH0seWOBt20h3nmwFD8Xb0tJTDNbWHM5tQHkzkVM0CO4xfBy6mYBCE4AF/ItWFXXVTn2Vb+dCaQ54cz0Ecp6FCFEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731269636; c=relaxed/simple;
	bh=C9HsFIh+Eh4zf+xDUJQ3mrYxCqpkzo7JtxVzG47FDgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmD7IPjq2gzJ4PmI/F80KdkJoLT2zJK/SAVrILvkwtMCxos/qEonN5mYf/pKKj8n/bbG3jeyjvEwA5bd2BuoLT6Uwt44wlwBZNBlBRAGAQrxPJdKA9IK5EtuSux1A/JQDUPgIfH/ZMrm0JSZYEe0ZqcCx0D0msNQ4dJkMjF4nGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=S5wwPJIr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TDWmgip3DngD0WSpM90Yi3gjWO6wAcgOvU2+84kSLeE=; b=S5wwPJIrHk0JA4HlAJJQVQQaE5
	mXroOqQZdoQvH3dFzv1BCceZ7xGfBThBlbQnEpZLMH0A6bcT2nlkcImC6S03q4/balPTsIJsc+e7/
	uXlFY+fVXQcr7yECUSMyAQwwGVQFzkev0bF/Dgt5KZmgUBRsbfQA1Jo0DMbZVTp7bxelMSn1uCzfX
	9FAUhU5NKW8fUoAcddK57xhMiVRENAneHZcsSMX1Qqh/NQTUSAa7vrWdxCIfxNszRBz/S6prO4+3i
	y4hFN/my0OrwZVqI2HzcuwQBy2JxEOhI9DDieoOEAEP8aAiriDj7zbBrIK0n6k3mc58hElQ6AR2Cq
	aY0biM6w==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tAEJh-0006eU-I2; Sun, 10 Nov 2024 21:13:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] arm64: dts: rockchip: orangepi-5-plus: Enable GPU
Date: Sun, 10 Nov 2024 21:13:43 +0100
Message-ID: <173126942616.136493.2934640786889277471.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025175409.886260-1-wens@kernel.org>
References: <20241025175409.886260-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 01:54:09 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Enable the Mali GPU in the Orange Pi 5 Plus.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: orangepi-5-plus: Enable GPU
      commit: cdaf2acc401c691105baa3ee3e9fda3b19dc570d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

