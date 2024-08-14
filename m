Return-Path: <linux-kernel+bounces-285918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFE95143F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F27B23E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C5137C37;
	Wed, 14 Aug 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JhfeJuIn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17A7E765
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616031; cv=none; b=o4nsiCNpDJYntFfPyCVGdr4hbdCIkLRoU9pRawUXMfamikGbg3SUsjO2oAY1oK3s403hnBezL9A58H1QwFEp6EL9bpCUuP9ddqW/aqOEP3SiefdA7f2HsMrSLjerWGv6zvnf5AKgOKJAYBMzUBGIZ/pODfo5RuJ26gyD314EBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616031; c=relaxed/simple;
	bh=aXTFyE65R+jOx2TPz2fNvhDRaEt5S9PiLZfhFlQKlbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbsQjdm9T5HDYcEzuBYvblWIIlwBkgPSZbv8gEaMLaExBIlMyqL56gPhLU2caJyN+TKnBNcFEBafV0rWI4hcsKPW5/vj1c1Xdoa8prAUHI2nBo8xkpmJxBWclNge3opJn07WHIYUwiBjBVBeB48WADxzRnW8Gdiq7sDnXQOW6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JhfeJuIn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j21engmFs3GELUMW77iDDQjhaPDOeHUS9ui1dl3zxrw=; b=JhfeJuInZJtIHq01Ek4VKUtrGO
	LiuqF/40ahXHrkWuILM0WLlqQezvG21QVLvdljpoVYdGvsuqLkCGtJNL1x14Or1GVa4KoEjyeSxtH
	aIRULXOGnDFn6QiKteTyipFz1NxtOn7PgH9xu8LRq55U+JHN3sVuSmJI+NFqOCW8RDkGvjz+zfikn
	7lQhWZUFXSB+dZah5x7BrGo77sLM24ieisnPrBbXrE8CY+RWSiFHbRZD0xJfZ1zj18kIs9DCWLFYE
	0yPxFcGLnBDBLM8ZiYBa1pjtg1ziCv8H90rNfwpnizYQPl8d/u6Wyw/MOBzdXdgT70aCZszVfa6lR
	QSwHMhlw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1se7GJ-00007F-LA; Wed, 14 Aug 2024 08:13:35 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Liao Chen <liaochen4@huawei.com>
Cc: linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com, wxt@rock-chips.com
Subject: Re: [PATCH -next] mailbox: rockchip: fix a typo in module autoloading
Date: Wed, 14 Aug 2024 08:13:34 +0200
Message-ID: <2181332.62m94kTkzf@diego>
In-Reply-To: <20240814025147.3875634-1-liaochen4@huawei.com>
References: <20240814025147.3875634-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 14. August 2024, 04:51:47 CEST schrieb Liao Chen:
> MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match) could let the module
> properly autoloaded based on the alias from of_device_id table. It
> should be 'rockchip_mbox_of_match' instead of 'rockchp_mbox_of_match',
> just fix it.
> 
> Fixes: f70ed3b5dc8b ("mailbox: rockchip: Add Rockchip mailbox driver")
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

nice catch :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





