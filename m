Return-Path: <linux-kernel+bounces-542690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207CA4CC78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FA6189714D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729252356CE;
	Mon,  3 Mar 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="WXjVaEnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmI0BGAp"
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A149215065;
	Mon,  3 Mar 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032252; cv=none; b=ZDW/ghArfZu1N74ahr2Ado5krR3KCqE30TZD5WnmE2QJcl3BMp+1Fj3nSp1FBr2s6HSiWWWymPXMoMqMaLgMzNwt6MvPsEwPCXl5p9lqpv0WwvR+wbT57NrlwwSyNpzIgnj1aDmCyG12Z74xojPH9cxaFaEJi+5FUd6Pm5R17oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032252; c=relaxed/simple;
	bh=WmwwteaKVSEELRkso5aFwtcgNpCVXuic6iStoQWMryE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je9nNoJVFh8WuZ5yatPhx8geCn8WO9SN29h3fMCJXbv5OjIdt50Kk8qMvki2dedt5xjSEMDz2Vj5OlHnXdzZRb2/QS7XtJyxStdkUHLVjOjE4+LHG5+dxkChFQLlJJO/9zBvn1Jx8NzdqXr+KoGQJ8Vdau7NseQgeoZFOBAppmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=WXjVaEnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmI0BGAp; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D2E521D411E3;
	Mon,  3 Mar 2025 15:04:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 15:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741032248; x=1741039448; bh=pD70oFS3M4Bnr8rEfLIbi5W0ZWGc/ux+
	HB8INioexGU=; b=WXjVaEnBX6IOGqXQHJ2m4dPzu0BGbHs8jAYcklH1EsVXpUXA
	pqUGVJJnJcqmW2tTkd4SDwFl+vvxlTF/9Ex485SAzkL1LsuEbavHI51bhrSvn8Eb
	RDcHwgX5RV+Kt9bkX3l/3hjBzOluvkVazeqmK+JI7ZSJD3DRSUDjlA+r0ksurTS0
	3656EgNb/UC60rxKFY+ixNTfUc2J/5WFwFsJqRRJrNmzj3u1iAE74pZt9hRbNjh0
	7nxYSB9jXXbu6lOrkqSr8ybvaNgCXvvEbIiLrE3IIgieadqaHJ0EHPHQlkvYtDg/
	5HEfzNx4Ez0bZFuB4GbprEUpWLPiLgDs2tWYLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741032248; x=
	1741039448; bh=pD70oFS3M4Bnr8rEfLIbi5W0ZWGc/ux+HB8INioexGU=; b=P
	mI0BGApw4lGroXEvS3GMBBbu5wz/SwprNLdFIrFs0JrYT28a9rwrj93ED2MJ6rXZ
	tlnb+yZ1spjol6GrqGnYmBBlUXo0O7kmxnnnNFAxX3aU31zCHckx9w+H2IGdOWPr
	HA6r/VQjvIB0qFk8RtYr+tFgl4hUKkoppEd9lcGyE5PWGWZTLscqW1ZfP/4GdMAV
	52QnrFhcfj6GpanBBMdXN3ZSGS+3CwifkzIJrDWo8DMji//3+0Zy0yCqvn6q+dgx
	n2fGiHGWxbYkjOJYa0CwC9m5r5bQXgmINdLrl9Pqc093V9e53oeClFjOZyhvTLv1
	a/7JSQ5SMgSbAui/6En/g==
X-ME-Sender: <xms:NQvGZ_VMM3RtP1DKODTRwtlwJzNkwcbcmPn1s-O22DbPhk3WmR7GpA>
    <xme:NQvGZ3n-zUADSrIYQbPCxcyd8SqQa4YWv9dAYP3FcuTmo2XJtGXQw5z1hJwUfI4V8
    rigKHwTmTvjJQIJSuo>
X-ME-Received: <xmr:NQvGZ7ZnQiedxDTR5CEajnguSPyYFsheJa4MtuRHvJ-RqCiqbUarzWHEAtzZxiH6XIqs3UmrI3X1k47UsDdmQcLdSbAzyKliGlVA24Hk3WCOkEfRux8vCJvExEkI8SU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddttdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrh
    druggvvheqnecuggftrfgrthhtvghrnhepgeeihefftefhhffffefhheekveelveeiteef
    geekhefhieffgfehheeijeehiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgt
    phhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhnkhhlrdhkvg
    hrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehsvhgvnhesshhvvghnphgvthgv
    rhdruggvvhdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtth
    hopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehmrggrrhht
    vghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    epmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhm
    rghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-ME-Proxy: <xmx:NQvGZ6UYHxVWkZf7UtPX9TwDArprBk0BWSBdpveHMJd4CkkzrHt6kw>
    <xmx:NQvGZ5mAwfjIDz1C18jwijwve-ADRksOJRo2PDpzeZQ6xiOeQaWbDA>
    <xmx:NQvGZ3fT339mfLcSW5qQfav0c8o47LLgQ5fG1WVOxCQQ8dkF_dD1EA>
    <xmx:NQvGZzGFmyC2hu3N7Vq5zjNkUx1dHg92NTiwpEThN4TPfcGOgk03-Q>
    <xmx:OAvGZ7UFo6yl2jRQYv7xu9S__Twf17INMbiJr6VmJP1Hhx5oxAy2M1kN>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:04:02 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	asahi@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alyssa Ross <hi@alyssa.is>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: Re: (subset) [PATCH v7 0/5] Driver for pre-DCP apple display controller.
Date: Mon,  3 Mar 2025 21:03:58 +0100
Message-Id: <174103187680.75921.8965235926191911132.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 12:39:30 +0100, Sasha Finkelstein wrote:
> This patch series adds support for a secondary display controller
> present on Apple M1/M2 chips and used to drive the display of the
> "touchbar" touch panel present on those.
> 
> 

Since the dt-bindings are now part of drm-misc-next I've also applied
the dts change, thanks!

[4/5] arm64: dts: apple: Add touchbar screen nodes
      commit: 7275e795e520c7064af52ba67c74d7bac27eea4f

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

