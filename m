Return-Path: <linux-kernel+bounces-355811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A8995771
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678632867A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC22139B6;
	Tue,  8 Oct 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qLdXnwme"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C91E0DFB;
	Tue,  8 Oct 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414791; cv=none; b=Q/LhEFxyJmZFgpA/O6Rx0yJStMIfX9fUhHlALzinCHtQFjDR0W47cspt7ppKDOe05uaORJC22UwMJumHVtBKQ7CQxSMsmiWqFsRy5U3SxBkxNrGMw0P1lkdXmxig6NuWyrjMp+KrX6sX/zO35uzQW0GBo1LFW8VI1wFpg2jzGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414791; c=relaxed/simple;
	bh=kdhDIQr6x2S5P5866h6FlTn+jW0YicIiTTjLvHlc1+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJjsRnajfpDk/Ysok19mLtYSeZTqz+1ZR2Gj4hw8hz5bKyfxDl23IWhEwZpzuD1/bk1h2EUw+QEQ+p3DkZA57Jjs7fweg2ga/cCHRcj92XIYZ2c2+BaQmAJe0BdY8tU9YunAEKcXIo1iG0yzJwYEp28sN3REaVC2k28QxzKPzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qLdXnwme; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pfemj97Szu5rqGkLgAB+jA3DEc9X/IUNSyYuIAE3eMs=; b=qLdXnwmeMYsXBHBHqAkQeyPNEz
	UyzGtTaZkUy/Dlkz0BmXHiCvsVM+zF22z4IyeOncv4uB9IZI+LEC7Eiv7FK608fqjHOT5RonpjCsW
	crXvPFx1JVvrBOcENkXDeOF2y4TOxItA1jfa+oAlkhKOpjDeq9EKGk5atI5bHK07ceN9nKTxudVoj
	cF4eCuWro2ojKPlFkbz8HyRjFvSAsvpReJpWhlhuRsEo1cMJVUPOMUw9SwFtQ2ckPbm5si53Q33ky
	5ETNbTJnyzA+91xDTM3eMlbT9Y+id+V8CuIVUP2Pl9KAFZfy8/yuQac3bif7PkF8A4e93FjLuDr3f
	mdmopz/g==;
Received: from i53875ad9.versanet.de ([83.135.90.217] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1syFdk-0006jR-9B; Tue, 08 Oct 2024 21:13:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	linux-clk@vger.kernel.org,
	jbx6244@gmail.com,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	linux-rockchip@lists.infradead.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 0/3] rk3328 cru dt-binding conversion
Date: Tue,  8 Oct 2024 21:12:57 +0200
Message-ID: <172841476778.2559610.12687245532264895912.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930215001.1999212-1-heiko@sntech.de>
References: <20240930215001.1999212-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 23:49:58 +0200, Heiko Stuebner wrote:
> Johan already did the heavy lifting of converting the binding in [0].
> The binding conversion itself already got a Reviewed-by from dt-people
> only dropping the superfluous compatibles needed a bit more investigation.
> 
> So I did go through the mainline kernel and also the vendor kernel,
> looking for any obscure usage.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
      commit: 5011cc7ad9aeea98029385f8a0e81a0ebfc45bed
[2/3] arm64: dts: rockchip: fix compatible string rk3328 cru node
      commit: 17a50042b9f63f7c5e9d7f1d1a285387e2b2d955
[3/3] arm64: rockchip: add clocks property to cru node rk3328
      commit: bc639b0ff7a8121bd72954bf8354a81f074dbf42

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

