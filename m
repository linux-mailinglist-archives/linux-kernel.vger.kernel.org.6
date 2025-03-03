Return-Path: <linuxppc-dev+bounces-6702-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FAA4E4EB
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 17:06:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6gXZ4cd9z3bn8;
	Wed,  5 Mar 2025 03:06:22 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=160.75.25.116 arc.chain=subspace.kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741104382;
	cv=pass; b=NI4+/zVqyScWW0fuJWPvoblXkVZcq8IuaIjznSthCeVBjP5VrPUIeIWsjP50gqymqPGn0tJg/Y7qdTU0K04CntSt+01O/2BJFStVfDdHqJf4We4Q/hGgeJIYWgkifyoa82CuBXU+eSBjV3suRXieGF58jXtI5HHd7cfpKfWw26v6sJ6tDD1L7gmx1F0oqP2Vba8H6WlM2Im6ZWZNmTiYmo8Mg6ZCiq+X4hCebzt6XlaPshRPbxqj3fk3ZPPJM8OTNTUdR3VA0uJ9RqMpq3A+VHl5opraqKY+79/6DQq/Jc46qZpUF2V77WWxWiUHkToW1Bv05RTLsPq/Zfv78PtwvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741104382; c=relaxed/relaxed;
	bh=vjU04JpOMtdNBA9/4I1BdSaS2kqSMDI0ttOV/OE/J70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owGBQP/CRmeCPTMhK0hvShkiH+3lsEQGVcle77bZxfOrV0DOdScFpDMJEsVEeleLDN46w1uZsw+QpIUY/dOxZbKUAohMSerld7K4C+a45UqxOQhaBTVXBk4+/7xNCiHRANFUwqu/2JY0S+edUUQcJ7wduuPLsv7W/WEJQOmzj4lIKrGWW24lUWB+rL5Xh8elMMIkXzm9WWIQq4E2L4iWsuBmWIR0BcG118PxZURafr3jbrQP5mXZuSSZbEkR3EpxNM+5/kCcZaI3+4pYU1gTuR9k2VN7RaGcSNWEZ6zwigRJ9FG4mfaotc6lQYhY9hKIKJz94PJ4Y4j1KH6j+Ap1Cw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z/sEm5fC; dkim-atps=neutral; spf=none (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z/sEm5fC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6gXY1f11z2yTy
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 03:06:21 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id A3629408B665
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 19:05:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z/sEm5fC
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gVX2dpLzG22C
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 19:04:36 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id CB6B642753; Tue,  4 Mar 2025 19:04:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/sEm5fC
X-Envelope-From: <linux-kernel+bounces-541753-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/sEm5fC
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id AF5FA4234E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:03:50 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 85E203063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:03:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E553188C583
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1720FAB9;
	Mon,  3 Mar 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/sEm5fC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1221147C;
	Mon,  3 Mar 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006996; cv=none; b=K/QaASpNXOTWIRK6Ep+tpSbsuP41HivLzX7RhSTBKzFf8bRfFakDJSxsdMFUWDWPW3kobw4mib5Ifdx732ZgD60Pki892u4HgwL4NQEb277mVzTANF2PQRRnOiERhsfPlXIsH8H1LrjSAUvQhLYFIwcd8ZmmRgJ+belWIyZQ9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006996; c=relaxed/simple;
	bh=oSR/KHjI9MSt0N2w8+L2Fx68vorquw7bUIpd7Zjxu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8G3B1a7YJS+hSvq9fYsYx4yVN4aIWPyVvekBBvlO9YSfR2nPQ62/dN8lWLI6Egod8v0fffryEIJTmrZQgIV1SjC+ixSS9DrCUEOv3gQYlYeMRDNLVa9AFnS3Og4BpAp9/xgxjXZjh63wSvpTz1QwUDLMugDcCk7DK7dqzPmlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/sEm5fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B335BC4CED6;
	Mon,  3 Mar 2025 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006994;
	bh=oSR/KHjI9MSt0N2w8+L2Fx68vorquw7bUIpd7Zjxu6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/sEm5fCwsRHugQtLNJsfW5yPPUlDiCwJa4NkvnByLNoMfQhw0BvsRfgKtIHNQGHc
	 tSMD0zD8Tdo3b5qweXFYRAXreJXTW9+Bb1QDiAyJCI+MpFf5cJohYXBIG+SWY3GXTd
	 ENnE8u+b9iRvuUHp0A9+nivyYUvvsLZq5MEpfDBWPxJtn/UnUSW5ZPv/LLJ/Q/4L2f
	 QoTG+DCpcqSm1R4BGUCN+8sYyqIu/xTZPM5oMZrT63m1DylnVlsjxoPDDwVscE3Sff
	 q7Ouknnsio+E4OUH092C60Zd8t8cUPssNpCMvX3ZHMsEMj1ZBvQTgdd63IHRXM7e64
	 sLBUOcBgvb3iw==
Date: Mon, 3 Mar 2025 07:03:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, broonie@kernel.org,
	nicoleotsuka@gmail.com, krzk+dt@kernel.org, festevam@gmail.com,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, perex@perex.cz, conor+dt@kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: fsl,sai: Document audio graph port
Message-ID: <174100699235.1416596.7740734064527505113.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-2-shengjiu.wang@nxp.com>
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
In-Reply-To: <20250226100508.2352568-2-shengjiu.wang@nxp.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gVX2dpLzG22C
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709100.27276@Kw2cz6en+053XxDpkgkwlA
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-1.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org


On Wed, 26 Feb 2025 18:05:05 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,sai.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



