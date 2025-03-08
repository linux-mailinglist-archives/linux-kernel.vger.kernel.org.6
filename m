Return-Path: <linux-kernel+bounces-552660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A85A57C69
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787A83B2B8D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1258920C019;
	Sat,  8 Mar 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xvTAMJJ2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F1204699;
	Sat,  8 Mar 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455146; cv=none; b=XMVlgIyzTgOtxigr4BEhQ5EzhaYicgPTeTQafc0X6Xs+aH98yOoPefk5rJ+TjV5F/mAqJxwmotQT4LelgoJPhYU6PrroUwR7ipJRooWT30G/sOgYVJSA1ucJejH4EpPf27I9gtybovTv20E0Ly0I6NaoXu0PybqG9HVrWf5LqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455146; c=relaxed/simple;
	bh=RrBxp3zxd/YzFzKbvcGWdMm6Dmufc6Pd0CU05EsmvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7QNBIuERohAb9CFlCDsb8JxanaK843liJMbFnBSYNyLt86u03EF0r/ngYDATYBSux2JghbxOHg9AVNBWb7bXqfFC61V3RZ8JJVS1hDeF3nuLAXwUnGa3fhIzEqMAVSDZEh1aB0VnIxWm4lyqHsSG+EoJY78FUub/oXm6HpkYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xvTAMJJ2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Le3hYMAYg2a39hHnv9MXC3X/fcJZT6of4UTCrB3LqeQ=; b=xvTAMJJ2wKtjHzrOKxWewBTJJR
	peeqDCycSz8HiAn5rP9LOsc/6XXeNrCLNj0p0riJg3bqyl42B2FpVOyllKuEJNtUxRzIJnFRSBD2f
	Gem/rZ9fkpgjw1xmw72IHnFY+e4eGvEcpNS4h2zbOY/m9sTVLKSl6bt5y/b9nYxkEHPM/nHTiB3Fr
	+j6xD3/GHr+9DvqXPI0jNty1/9H6tjUIvDvJjourq9yPMhfV+gDldN0Er2h5QEPuoz181D+V8YZzt
	iPsQomT8w5+K8C6oDAZ6hmAOgppVF6u0IEHGVSZCh6OMQltX4VAYHE1MfDiiizMk9jgWgNdtCSJ4C
	kVhduGWQ==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy20-0004Tx-GC; Sat, 08 Mar 2025 18:32:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: slow down emmc freq for rock 5 itx
Date: Sat,  8 Mar 2025 18:32:06 +0100
Message-ID: <174145503579.101861.2973510887051189420.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228143341.70244-1-liujianfeng1994@gmail.com>
References: <20250228143341.70244-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 22:33:08 +0800, Jianfeng Liu wrote:
> The current max-frequency 200000000 of emmc is not stable. When doing
> heavy write there will be I/O Error. After setting max-frequency to
> 150000000 the emmc is stable under write.
> 
> Also remove property mmc-hs200-1_8v because we are already running at
> HS400 mode.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: slow down emmc freq for rock 5 itx
      commit: b36402e4a0772d1b3da06a4f5fbd1cfe4d6f1cc0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

