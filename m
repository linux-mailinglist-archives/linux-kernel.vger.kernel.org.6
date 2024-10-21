Return-Path: <linux-kernel+bounces-375169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413C9A91D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E959928417B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE21E1A18;
	Mon, 21 Oct 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2vTWIXgp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64E1C7B63;
	Mon, 21 Oct 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545216; cv=none; b=HnR8nSD6jh7UR4PraAkF8eOpYilJ/7x6Q/ujUHpk7b7WcRXxdl9Lj5wXHCgwjcHurWXAHwA4BnkAcyDNT6oJ2wqlCxhwgpIVpXKNC9PfNRzOVNt0SPOWBLgv4mDwnpFJtq+K+6JaYG7JJHT2JsdSqoRVW2sjTRXJsQEPTdjKZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545216; c=relaxed/simple;
	bh=ZD2Ww8RcYSzH7HNc76n9boPaUdOwx6e2peZhY7ytNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtUp4aKUG8eWlpnQ01+/vVcvGwGzz/0w1olsw9kPvh/pBiL2YN2shJt+QZW0+Yt2HrzfUv+BGl9dYTSGX95sSTYVurylswnjhLfyUv6tyMDCqdWl+wpQcmo3EFy2WgRPklvLK0UDLr0AFE869xPAFHBG5S4VdWGv/pzvjSnBMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2vTWIXgp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=crEkYSL1ZWIpJ5RzCy63Q/db3MfgxBkRXlQQoYE2jF0=; b=2vTWIXgpa4eoI9sowH6C55x50L
	HPDsSek9652bk63ioC7XfRSNb57hWXm7NWcJSWV88qGTMBzqWp7Pkubv0CpnTdflwduUK8FybPJ+5
	/Xu2emA/a5lEBv0NCg3AQnaYskF2fs4KRn5nhA86Vj3RT0aooBcVzkCGxXw+G2FmvWL9Yx81Qiy4T
	dfmD8HnXxw32RxBdmOceQ0LDoGupH4S5pTDvdeBLxI7PqcUKiGctlpjScsNCkj9cCFFM0PIMds9q7
	mJ8DTrquuJuFwQRpZmpUvQ88mdHtZ6CTIJ0BIH4IX/8fVdxk7oOzUpXcf79FmaZ40FwJ/gjJqFvyk
	cpZqZfZg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2ziD-0007k9-UL; Mon, 21 Oct 2024 23:13:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Diederik de Haas <didi.debian@cknow.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date: Mon, 21 Oct 2024 23:13:13 +0200
Message-ID: <22466915.EfDdHjke4D@diego>
In-Reply-To: <20241022080103.332d3024@canb.auug.org.au>
References: <20241022080103.332d3024@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Montag, 21. Oktober 2024, 23:01:03 CEST schrieb Stephen Rothwell:
> In commit
> 
>   273070dad96f ("arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes")
> 
> Fixes tag
> 
>   Fixes: a3a625086192 ("arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 2b6a3f857550 ("arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes")

thanks for noticing.

I've now double-checked the commit ids and amended the commit with the
correct id accordingly.

Heiko



