Return-Path: <linux-kernel+bounces-209841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490FA903BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A70283256
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBC17BB1D;
	Tue, 11 Jun 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="j8vmmxGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2NIfbMe"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFF40BE3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108217; cv=none; b=CymNuy3DRqlgjQ358aUbQ9USB8NvyqjBa6fgcpdOyc/izdBR4+leMDdeoTrTuy4Vn1FBnU4QsYUy6mCxifjnZ8L9z4Kw/vPPn3kRX/XoK0lx0KXQDaTzD0HdIsm5dk9VigLU3edC/Gl6GS305rt9c/jM7B7XUR5LDSrFKPhMOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108217; c=relaxed/simple;
	bh=dMLOuB6vTrbJi5z056OnkfYD5DIMQBzOssYXGkDnRj0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oX2v6qvOwEnLqQBqH3WBfuxWYHSPc1k/nMD53TguY0FeXmCrjQfl6cxLLarLxAbocYHPrstcKCUq/DbvGARs487vVx/IY5vIAIm19Gw/zVqj0Ly727JyicQrV283UAsHuxaUPqcfh3LAaze/QyUs/oWY5M0fugP0Lo1LkyXEnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=j8vmmxGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2NIfbMe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 89C311140097;
	Tue, 11 Jun 2024 08:16:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 08:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718108215; x=1718194615; bh=uCLVYI7kbT
	F1rOtKnqCjgfIRd/jX63wlKCQmYmN9H24=; b=j8vmmxGJMZf6FFaHbbFD3bGrcM
	v8dUTV54CuY+lv/XRHFS/nECyuoclOa0FCbfbTT7qrVrfnixnDr1xjtk9Ifstr6L
	wk6ysbViGVNXWEWtUA5H2mJBMsJC0aRFZcNixuKMetfQRbPDcGR5cIykjHxIlw4+
	KFNb/lBWNCdDotl8bEwPrpWM58RGPGIXNnPwzz4rAIRrmb8SI7aC2b4QesySqdiB
	s2nQ82kgdXnIIz+Yd8+nnTaq/IO+recER3jcXqahUhk1d4XptURO95LS41JjIRmY
	sBDdAlKJmC8ygszRBrSE0W10qUKFKYcYW4ohIcA2sgSdO99NpYf0kSRzceOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718108215; x=1718194615; bh=uCLVYI7kbTF1rOtKnqCjgfIRd/jX
	63wlKCQmYmN9H24=; b=Q2NIfbMePAPCYWqg3AOw7Bxb+7n825wwL74SiSVa9BYU
	HssjAAmcQ7yU/S90ZnduhCbV6ZKRrleDfZkUUL1zP0E2L1VZEUqHvoQVgnvsCs/+
	OGDRqoYPpDlYl5bUJ2eaEy4N4uVCgtyAmmNoyqgUQ0Sjde9u6Yo9yUEkgkH4K018
	VDBqITIZ2yKbeObXtq/4pwdqFY30HOJb0m0+xJx1jbJ/Fl2gXkF9wY4Nz0xVa+GB
	BH/7ShNhQ1iGP6jwXeAX/XREqFJ2PypI9nLS/l/Gflz503O/IbFesfwXqG/mTWqc
	gbW0Li34bf0Sa+p6Ingo0tUtxjqDCVoMXu+4twv3UA==
X-ME-Sender: <xms:N0BoZsZkmEU7UxLB24TjKLOic2og-jznREsVq_4m78Zxp-3UeKkBEQ>
    <xme:N0BoZnbo6m7WdyDT9cwACE2HLk8btWHSGw9FPfIbKbZNXYDWI3_XCfiL70K5Bm7KV
    IMg9mBIr2gmbPLnnjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:N0BoZm9WB99_Gc0Hff0EXBi_JJdLb0Dny8BlX8uOO76tRAggSIzSDQ>
    <xmx:N0BoZmrz_sI8DZ0GmWmSBQDzvbvRlN5Qu5GW2TVpNEsOuS_SDIsj4A>
    <xmx:N0BoZnqkOqMWxu8HWbegIQs44v4JVXi0SSH4bG3GAjolul_0TEarog>
    <xmx:N0BoZkRAHB0IEAHqYGGcuBflkl8TPlOEzYEhgQw9Nc36FcOL8i4cdw>
    <xmx:N0BoZnYcgtEbVSlK_5dQFQ1hRkbdIkXMXTXESdJzr-N2xeNCnojgf2z7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 252CCB6008D; Tue, 11 Jun 2024 08:16:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f548071-7f6f-4d05-87b8-4bab5d3f4754@app.fastmail.com>
In-Reply-To: <20240611115820.1269805-1-vaishnav.a@ti.com>
References: <20240611115820.1269805-1-vaishnav.a@ti.com>
Date: Tue, 11 Jun 2024 14:16:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vaishnav Achath" <vaishnav.a@ti.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Udit Kumar" <u-kumar1@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Nishanth Menon" <nm@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable MTD support for Hyperbus
Content-Type: text/plain

On Tue, Jun 11, 2024, at 13:58, Vaishnav Achath wrote:
> TI Jacinto 7 SoCs (J721E, J7200) have Hyperbus controllers present
> which can be used to interface with Hyperflash and HyperRAM storage
> devices. Enable the necessary configs for Hyperbus support within
> the MTD subsystem and the specific Hyperbus controller as module.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Looks fine to me, I assume the K3 maintainers will apply this
to their tree and forward it to soc@kernel.org along with
the other 6.11 material.

      Arnd

