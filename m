Return-Path: <linux-kernel+bounces-553347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1804A587EB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D547716AA5E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13421639A;
	Sun,  9 Mar 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="R8fx0Ehx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rieZVbq5"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFA215F64
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549562; cv=none; b=oblXBSmIiLeYuhpJDIeDByh4xAwh/zrWhFJIKdnJou4LSD1rCPD4NQsZ/ATRxPX8wc4luY2z08pd/zjLAw4B8f3zAl6lmetpn+7NKZb9BlWNilGg2wwoEYnhUZoCoU85SV/90l2gw9zkn43HP8A1tz0gU7mE5thxtoaeRdV6Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549562; c=relaxed/simple;
	bh=Lf4BrFENd05hmG5PESKDZoLIDgO6K4nLrF/qfMOjtAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeoLn1ZoQJPCObM2RiyeQWU7kybsnYvHDf8XGyCP48E40g4yn56M7eoFih/EJRd2YDx4TDMhQUxs/Lz+y1ECTwP7tcOzZjJOrfaxHQXT6aHBSSAGj3KNH21CYhoAhUntfoKuzX4rf82of1fHMHuxqNTRIPtYEcG9V+rPe0UIaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=R8fx0Ehx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rieZVbq5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 31D8613809A6;
	Sun,  9 Mar 2025 15:45:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 09 Mar 2025 15:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741549558; x=1741635958; bh=BD/hVb2SemsVg0IwRyhTyxsbti4JCV6r
	s55j397BRYc=; b=R8fx0EhxTGtmyhm6cWzfF1GspBdj1wxiSW5GdBGmdrCiZnu+
	w4CW+FHGoRzITUUyHGSAnJyouxsD/NOVR0jUStoJinj5CchjlrsvJMimVto8gdV2
	ONTYV2xpqNis6tLgWwghCUXeSvx85uw9jYq+qY8Qmw5fCYTsdK2dkex2Dfj71pQI
	KMb5Vv/HV0xPHmOMU6xgCQlheUlwjRV6/l9sUcFq8JwiI4UeEvNg7niGRtGhmnRx
	47iNBGNxB47H0M5hbZq25MWDktkn835uaYqyqny44B43i7oCHITJwi6oP4Pab4bz
	tr5HkbtL9xWf/TkbXKAXUsH7js0v1N4TQmU7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741549558; x=
	1741635958; bh=BD/hVb2SemsVg0IwRyhTyxsbti4JCV6rs55j397BRYc=; b=r
	ieZVbq5WLZ3V83sy3ehz/nNCYdmEdvEkpaLLgPTLNaTyK8vXJAdG6GsshAEajYwn
	s9Go8Rcuz4bCh+7sSIfIShcT4m/hYLVxQfxj+PFJNHgOP4681eB5xFIyKJ76feIr
	2KFLIt/mKqxVg37sh1FbW2f47rBlXhFLLKAoVIWU6RUx9Ml4JOO1MqcvXFpcW4TQ
	OEcgjHe3/cybSILNx9R+7b3h1ycNOW0RtR6o9x43zluu/Llkhy3sdU8TpJaiAvLg
	d7Dwij0wqvyOY4wK5rE9Hs8D5oA0zShzquEGIl3Lk80AWSD6ZHqY5MlScrngJVe7
	SsimBU3TMiJamlnI5fNbA==
X-ME-Sender: <xms:9e_NZxaqqzP0H4OAYQW8s1JVgkBo3gK882ts2NE8tKKIBoGrt-Y-Tg>
    <xme:9e_NZ4ZLJWP1Nd68TroZZVHxYp8C14YU88KJsGvPvYFP97xgU3jntL2w-cwXPuRCL
    YoEzwh4kgETcolSKpo>
X-ME-Received: <xmr:9e_NZz_ko4M7nnuugkVqtZAitqC6nD_o2FcT-KVQ6KUrjCsb6zqNvHlTL7Skg7B29mEMPAw8qYr6BKXEooJugb88O4XFxfDtsxutTRAxiUDWJtBnU09hiCG4oFPG30Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrh
    druggvvheqnecuggftrfgrthhtvghrnhepleetudehlefgteduffeijeehfeduudekhffg
    fedvueekvedvveeuhefgieetgfegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhes
    shhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehsvhgvnhesshhvvg
    hnphgvthgvrhdruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrlhihshhsrges
    rhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:9e_NZ_o00JzXlX8jUt6GhiNnwqNLUxb0Q7K1iAEw0L_nBYs7hCHXEg>
    <xmx:9e_NZ8ru-rLdq4ln2RGvsFsheUqmOkp6FaXy_rine-H4Ttb3lvcEMQ>
    <xmx:9e_NZ1TEf3anjlevF0X-vhDQ6v8XhC1VG0IYylf9uDLpo-rjm2-S4g>
    <xmx:9e_NZ0qh14YLQk9TF4oJfbHxhy8aHHzhuRVVNBbK7gP9rkdVm1wdWg>
    <xmx:9u_NZ0LDMOJkdXaXtsV8PqUtxDkcQLcO0_dAQ5NdONbutNGu9OiKm4lX>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 15:45:55 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: asahi@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>
Cc: Sven Peter <sven@svenpeter.dev>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH] MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support
Date: Sun,  9 Mar 2025 20:45:47 +0100
Message-Id: <174154951957.51578.1010090388720574063.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250303154012.1417088-1-neal@gompa.dev>
References: <20250303154012.1417088-1-neal@gompa.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Mar 2025 10:40:10 -0500, Neal Gompa wrote:
> As a member of the Asahi Linux project, I (Neal) have been involved in
> reviewing the patches downstream as part of enabling the Fedora Asahi Remix
> distribution for years and have recently been reviewing patches for upstream
> submission as well.
> 
> This formalizes my role as a reviewer for ARM Apple system support patches.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/maintainers), thanks!

[1/1] MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support
      https://github.com/AsahiLinux/linux/commit/3a0d2facfa64

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>


