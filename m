Return-Path: <linuxppc-dev+bounces-6708-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DCEA4E91C
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 18:36:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6jX55P3zz2xdL;
	Wed,  5 Mar 2025 04:36:05 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=160.75.25.115 arc.chain=subspace.kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741109765;
	cv=pass; b=HOl19oMGWYQXMi4wPCnkFTS1mnDK6a5vM5+sGFmq9kHoS+KVXwzl6Lj29ArWahJSaIa+ShDK7W+7uCOwjrtW127U9pyOVMwdSRVWxq6j/IVywl/Ki0PMdCdU4jWre4xVLeap6yMtM+6elV3ffpGusAz2E9a5Zejuz7o6HmKZ6bPTzfgWj1WObjONO+ci7cyO8xbsAewRTzaHJAJOy4MDusrrrtkymxjlNHYynGGoOb5s3cJrSwH8EFHUsfEhYHfG38P8vZFcTT7DDBj2xxKxnHRRkjlAskCWeuLPFvLG7WMrBKrhS1IZ47nM1dUZgQhT3wrGuHnDF43EG3oGp2Jzkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741109765; c=relaxed/relaxed;
	bh=IMaOPh6vyf9pjRTlxSpAkNUTmyTxFaj/wWEqA4QJp8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuM0kZCl16KmAnbrEermgZbVQoCJVfOGFc6h2kiHVxK5AvaYzLjLzU84yVGHHG6eZt1Zr/uwY/UKsqLqZWrnZF7l1hvfVqJFz+vKUaum2W89VRzS968wnRUskOI61jfst8nqCl4PeFnYOSs935kZjc/PAcKuIQM7S7SKxTIamOUiVaR4+Oz6nlJainZ3JXZEHtolVOyRnRWLhk5QpCupNi0XU6L/kxk/g5k9IOOPUDljS0E6OMfN/irO8SnjvecgzM18+DgCECrYFI/XUem23s7n+5su8BAjleAvTGSJP9gF96AwcOPTS20u8LLN4Y54geC6Iewj34sOZ9u7U1blCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z12p8awD; dkim-atps=neutral; spf=none (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z12p8awD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6jX12F6Fz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 04:36:00 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id AAA0A40D4DFC
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 20:35:27 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z12p8awD
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dDb3l7DzFwXs
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 17:22:23 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1116D42720; Tue,  4 Mar 2025 17:22:13 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z12p8awD
X-Envelope-From: <linux-kernel+bounces-541754-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z12p8awD
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 0B6E841A7A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:35 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D78CF3063EFF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:35 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C79E188DD35
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED521147C;
	Mon,  3 Mar 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z12p8awD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653213FEE;
	Mon,  3 Mar 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007047; cv=none; b=Fl1GJyO+UDx93l6UVIhuGYn0pZQUXKOY2D1Sop/UAFXyXbQg1M1jB+trmRcCZcWkxSApkljGjgCQEqhmg3wYqn4jCWEzWKCn6yLOxxT6Ne+9bdBBV87XS5DI0+lHqaBQ6VXzmrqmamSZ5MvQnlXBXA4Roi8U6Gl2oUyLtD6wu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007047; c=relaxed/simple;
	bh=iyUoLSPXMiRrDuj1QjSG3Se/xMam/JZHpS5wjuiJGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnbY1yDDbi7TgiXg8Y1CWfqNcJNSq/PI9Kgyd23qiu6zfevTR76m0k4fmxY2sU3lBhSGLD5ksSIs4UnuyQ7QYX8eJHiwXQGbjXrYPdId1Jkl+PBFEBizsGVwpEW7BAn94P+Yt6H3pTBg1i6ei7XxRdITViJ4/k3SQuTI/NNarrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z12p8awD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C800CC4CED6;
	Mon,  3 Mar 2025 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007047;
	bh=iyUoLSPXMiRrDuj1QjSG3Se/xMam/JZHpS5wjuiJGpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z12p8awDHjQe/xOPfCA3gI1tAXP8mLksekgMbbmPdzcdtitUwiV7Yyq2jcz4gS2V+
	 4BvijIr4YBpjkW6eWZIkZDi/d3r2DGNMfKyB953LdUDfV9qnjhoOeNMsTiEpIv83rX
	 XPeVzEL+WOCUtd1k6U4+U7Gm3bBr4KeEEcm90UZHK+WaKtxI7rG99ASlrWEUkI9gmE
	 CLEC/Jl8RBr6uMIwCmYGPk/MGoUcHP3Sh21gIlMXISziRl1H3xZtxvRmZokhKJwaqv
	 nZeGLy69SDMhNPdTjws2M6WROHYK4VCLfaEMmlw86KA7AJ7nR2/CSMOQLWIzSP0WkF
	 1a+l8nvRzV+Qg==
Date: Mon, 3 Mar 2025 07:04:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, broonie@kernel.org,
	nicoleotsuka@gmail.com, tiwai@suse.com, linux-sound@vger.kernel.org,
	krzk+dt@kernel.org, linuxppc-dev@lists.ozlabs.org,
	shengjiu.wang@gmail.com, festevam@gmail.com, perex@perex.cz,
	devicetree@vger.kernel.org, Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl,audmix: Document audio graph
 port
Message-ID: <174100704415.1424041.5644377914048631835.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-3-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100508.2352568-3-shengjiu.wang@nxp.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dDb3l7DzFwXs
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714388.75944@CYAs2oTUWHUlmocpDyLkww
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-1.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org


On Wed, 26 Feb 2025 18:05:06 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.yaml | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



