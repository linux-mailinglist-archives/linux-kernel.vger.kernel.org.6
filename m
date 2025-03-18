Return-Path: <linux-kernel+bounces-565807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE8A66F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C501A188FC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912551FECD1;
	Tue, 18 Mar 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KAen0TNk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C31E5B60;
	Tue, 18 Mar 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289331; cv=none; b=Db55S4n3b2VSCK0QssUtP21l5SF0XMdXR0tnZkRpUxbsM4EuaIQhZsoWNi8FyoqQSyiQRHX6/IiRbs1YE0fIkRJ0fJ5c0jFNeYdVUC8fLBdbBP60uQHMBR+EE1tEoCQnN+RSG1QJu4Iso+ZIVpQbrabi5e37lZ1e6VActOsj0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289331; c=relaxed/simple;
	bh=wj9vhvcZ7Q6rRxe8IKV57WE45iTK8IXT/ogUqM9IbaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA8L6DzyJX4f0dTXDtR5yBkIyLPgjv/zRjtDX8Yb7pulp5E3Sa02HxDaRKCpokWz2JJW39uE6gRtPyRBdsY6G7UuBfo0UGEmlfhR3hSywHxKFKzPce+nU4mDTbvjeJVruzRrgcAVyvW9TrAH9Em/RNkyxIdzzJ4ix6XEA8Ruaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KAen0TNk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kCpda69+4YOXyPlxXr4rhlyiXJ6ySWZXtY4yz6bQvNk=; b=KAen0TNk1/Ch9gRLVmwOAqN7ww
	i8CBoeBw5RGn57F5AZuWcWu4MPWtC4wrXn/F4nN08gu77G9JPuXmghozKSX5eA8iUxvCI2kqsw/WX
	s/nsdo/5GeQmU8wlXqQ5la71KnKow0xmY49Kwtwl1eHisQm+g8fQBciWbRbeUK0CIZ+Wi9Nf0x6kA
	qS/TpBmnwOF0UGe+ysJBYblLf1YHh+jcACbf/M8S+NuD6H28+bC9kzYB7Rbv5D6m9Fpqx0xzYCmlv
	l7ojCYq4k5hXsxJDEO5LyP4RA0MsjazWJCuIL3WeL9/CQlbrHwX4+++XMpL62qGg+klNt/1nRHKNR
	lbHZMGtA==;
Received: from i53875bc6.versanet.de ([83.135.91.198] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tuT2g-00054Z-JC; Tue, 18 Mar 2025 10:15:22 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, detlev.casanova@collabora.com,
 sebastian.reichel@collabora.com
Subject: Re: (subset) [PATCH RESEND v2 0/6] RK3576 OTP support
Date: Tue, 18 Mar 2025 10:15:21 +0100
Message-ID: <2364081.ElGaqSPkdT@diego>
In-Reply-To: <173978599692.25901.15315285566342669137.b4-ty@linaro.org>
References:
 <20250210224510.1194963-1-heiko@sntech.de>
 <173978599692.25901.15315285566342669137.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

Am Montag, 17. Februar 2025, 10:53:16 MEZ schrieb Srinivas Kandagatla:
> 
> On Mon, 10 Feb 2025 23:45:04 +0100, Heiko Stuebner wrote:
> > This enables OTP support in the nvmem driver for rk3576.
> > 
> > I expect to pick the clock patch (patch1) and the arm64-dts patch (patch6)
> > myself, after the nvmem-driver and -binding patches have been applied
> > (patches 2-5).
> > 
> > But kept them together for people wanting to try this series.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] clk: rockchip: rk3576: define clk_otp_phy_g
>       commit: 3e081aa132bbefe31ac95dd6dfc8d787ffa83d0b

the applied message says you picked the clock patch, but it's not in your
tree - probably because you realized that it's a clock patch? :-)

So just to make sure it doesn't land in two trees, I should probably pick
up the patch for the Rockchip clock driver, right?


Thanks a lot
Heiko


> [2/6] nvmem: rockchip-otp: Move read-offset into variant-data
>       commit: 024e21343f3cbcde0343473fcaf094d2c19cc7bf
> [3/6] dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
>       commit: a1bf00100d06ad69286154a63e548ae6f6ce8539
> [4/6] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
>       commit: 8c94337ebbfb840944574f82df0cbe35930d8df8
> [5/6] nvmem: rockchip-otp: add rk3576 variant data
>       commit: c5ebefe4e20d9fd99ae49cbfd1c18632cf338fa5
> 
> Best regards,
> 





