Return-Path: <linux-kernel+bounces-230178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3206917974
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AED71F222FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31515A488;
	Wed, 26 Jun 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KodcBZfI"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB898153824;
	Wed, 26 Jun 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386151; cv=none; b=U2GLMRBp+uAbXEXc3hfPa15qhmHcuW+7VvxEjUMw66GttBpzyKX/OOGJ5hN6a9rwfVzfltWFCvg+ZXIeC1I4pCMT7i3gS47O6zuU7VcO8qs4NAB6FUzkC3yc2ztC1A8+XT6KgHZ+99zXHCoNlLNt1Z+i1WD6D1oc52fvWeH4zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386151; c=relaxed/simple;
	bh=uZ32ru/v0nJwiwpXmKA4UVati12eZuAY7W95xNiPPac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpD0ohc8zIRHe2i0TsvLsObYSJ9ZCwLHA4N8g4pxgkcgoc3QnkwYWxIlKypeWVlyXHnKXmedz2xOzu6meweZbnEFUWRuEvYA9wXOu17Naf/T0VtZpwcMu+uOXew3UAMWNbg34pjgXN9hHqIVZ65XvxwGSzJ/XandMpmtFOOdxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KodcBZfI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CE2F11380583;
	Wed, 26 Jun 2024 03:15:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 26 Jun 2024 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719386148; x=1719472548; bh=1h7GPGeucNCM2cQ8u0wLzjvPitmE
	x8vWv6Fpkp64wzQ=; b=KodcBZfIvPErNHi2gWUmX3poCuHkgVgpRwKuokVu6hDS
	AGJZs70Vu4Uib7Sn5oKhjmS7BF9UY4xlTCov4SUmuUrEsKhFzGjczOCdvVFLqmA0
	PdCQfeY0aG/GtPmIwSFEEkxyEGmWRDS+oSraRJPNh6tTHSwV7L5aELBZnPI/6bse
	InrwIZDktCo1LW0IcoJeCpu7R2IsvF8SRJZv4Vz6mJxrYNZ6oU89wQiec2GoDncM
	rD0sNiLAgXXRGGi+RgYvaO/w4JWAC/NMDZaCSR4Owqx7P4y39CBdXiA1WdM9TRGm
	5yvU4xPtiOxMtX+QGUKS7ZNWjGbRWJkJn03fHD1UMg==
X-ME-Sender: <xms:JMB7Zg23ZTU75EVOqdKOWqKt8uzevNl5aW3OOzj64N02s0O2eGmpPw>
    <xme:JMB7ZrG6tmzicb5w1sFKsMIr-E7_smYrNnubd608-DRBYAQO-xl03CabXe_glZPsR
    9GvsG48VF2yAsY>
X-ME-Received: <xmr:JMB7Zo7bFAYFNzFUm-pVHwSPth3u3PiF51Rcc-sxcpvS10pMumrL-ebYd3PY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:JMB7Zp177iNnP-Yp7uOiNyZgf4AmsLhlaUvWTM2J6WsLGrqZwTv9xw>
    <xmx:JMB7ZjF0meYwC29NLCJijgSIFVbiKfMcltiSC-yP_MsR_wG4e5b_7g>
    <xmx:JMB7Zi8bzSkMHezT8BcGHVtu2_SyTbRDwf9M_OxLTaBICLuZVH8qdA>
    <xmx:JMB7ZoleslbDEn40jjTnqmm0ykYkKo6R4sOLwczIU_T0HFjx09HbGA>
    <xmx:JMB7ZicTx0SKa9lfQCFZor81Td62qVbXegdmgH4zKRdqAFmKp8jjDilb>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jun 2024 03:15:47 -0400 (EDT)
Date: Wed, 26 Jun 2024 10:15:38 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/10] net: psample: add user cookie
Message-ID: <ZnvAGkyXXUH5cA4R@shredder.mtl.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-2-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625205204.3199050-2-amorenoz@redhat.com>

On Tue, Jun 25, 2024 at 10:51:44PM +0200, Adrian Moreno wrote:
> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
> 
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

