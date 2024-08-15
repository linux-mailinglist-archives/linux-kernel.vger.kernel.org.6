Return-Path: <linux-kernel+bounces-288532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9271953B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D92D288124
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1470149C7D;
	Thu, 15 Aug 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dJrKcURp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842385A7AA;
	Thu, 15 Aug 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753136; cv=none; b=Gwvn2crANZjaluf15/QLaXLN9/Py9VLD44emdRirb1eBbIEBv6vykuVtPF9Lo91Fw4X9wLZjDUgw+ZnG+N82kNxVfbqTzSxz4aZq1Pyp4/YIBhiJHps9zQgJ9yjXtOYBlvjtcUDdmmJQVkOPGztmU2GjfFgpZy8jCdcGC4H7UQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753136; c=relaxed/simple;
	bh=gh+2c6UWUT7beH9QS1s4JW77pMBmvnJpIo9Q7oiM0CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+V6ClSN81a9L6p5f5uD4GtlIrPsg/Y+Q9weBRkphAVRTe2ocFZ8+9B5L01b7exeJW6NPiKlZ+KaJq5on/k2KVDH0AmqV4dJ73DmAbrBY2c+K6z+pnBTp/+0rBf1r6acEH530T6T3bNf3SAT/84lkQ+b8YtYsQN/avnXy2KjVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dJrKcURp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KKgkR8ojg4wvNEdG2ZIzvqY8AZXl6+a4eWkFHmnNGLQ=; b=dJrKcURpBeeaDIq0qrO5P5Q7Vh
	6Q0PTYOmKsCZP+pl+Maj+k0ww9sSDQHUz80HnRF+m5DbLb4zBPQJRrzr633WWDikx8y/uqchFKj9p
	MV7uaN7pRfk7cParKKZ9nYBBifYpR40Yj1ZbJz3N1IGePDeMrIH9i1E6ceC7xIcO8YBhCXLpCnPx+
	N1vyNnVHBUjTZ1gnU5rRSCVzeJyztGwfZPv01W7ol9SAGOtM4HfmW/VUjeTBmiPofH78EoC/P8bKJ
	0rLFk/cu612UzgKYGr5y1t90Gqh3pnT/8yZPm+tRCa3nZSJCnnDzGZn+DxXfTg96kTBJrodp6jP2q
	mSNIphfg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1segvn-00089v-Rc; Thu, 15 Aug 2024 22:18:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	aurelien@aurel32.net,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: drop obsolete reset-names from rk356x rng node
Date: Thu, 15 Aug 2024 22:18:44 +0200
Message-Id: <172375308158.820196.13213858925251248943.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815162519.751193-1-heiko@sntech.de>
References: <20240815162519.751193-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 18:25:19 +0200, Heiko Stuebner wrote:
> The reset-names property is not part of the binding, so drop it.
> It is also not used by the driver, so that property was likely
> a leftover from some vendor-kernel node.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: drop obsolete reset-names from rk356x rng node
      commit: ec532f3591ce6e6ed5ec6c35773a66aae118e1f0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

