Return-Path: <linux-kernel+bounces-548506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C3A545C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E13A6C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C72066EF;
	Thu,  6 Mar 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V15rHs2S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lo/U7vzv"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF71EDA10
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251794; cv=none; b=FMW/VMJmbKzS6Pz1CZ6YnLKy527uPyoc0zTF09kh1RIwMYsUX6yd/2kSHJ39z6Aq2Ri98Sgh+/+pcy+SfbLi50uw4cNcIsvD0yo6G8oKzPSPiOLz9NGO644LuPj+UgST8/J3zSZe5ChgzHuSCE3lYeFXhkTzdS4I5zOVq+U015o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251794; c=relaxed/simple;
	bh=T9Sxi7UM96lJZzoWcrB8nkdiF4e8dZcfT3E9sdmD6oQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nCEvOiR5flirVGMD8DRlUge97mIV2a1lmIjc5qSfkbvHGzN35uZYB/+3s5wJYpcRYD+N87GZUp584RHgfLV5bbBO32yChyOfZ49d5Rr7GRPZz+UwFJBjcUm9K8QKqzOTLjqOcmH8pXzH8jhsnl3cBEgV9mllzv6BduiDTZOo7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V15rHs2S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lo/U7vzv; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 564422540103;
	Thu,  6 Mar 2025 04:03:10 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 04:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741251790;
	 x=1741338190; bh=T9Sxi7UM96lJZzoWcrB8nkdiF4e8dZcfT3E9sdmD6oQ=; b=
	V15rHs2SARquaLYXZI2/eQHUlWmBI7MvlxhEk04PptPf9NqMUCW4haq5dDgTlTdo
	NuObg8qsLqYxGTW217FjBPp/Q+cPXlX/83mUlEO3YKRSD8mBPSOARxQBZiaIlxaR
	vswGotNjvNuSkLM87T5A2XelXPd9rgLC4+bGQvUuTAHkw3l3caPPUprVZYW2dBh2
	2/VBF3Gssj8nKy6KnmJjBRj756UpIOErqoJfCBctBw7BcRqm8qXlA96CVTqcGklK
	mSIam4WMAK1E8Wx/Ss1I/ijEMmg0/hOHIK+2tt+Blb8KIurFS3AW+fpU2gSys9+F
	Z1g40xdpoC+dLVBtz4Zymw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741251790; x=
	1741338190; bh=T9Sxi7UM96lJZzoWcrB8nkdiF4e8dZcfT3E9sdmD6oQ=; b=L
	o/U7vzv6zGcc6BHgsCcSMt1Ya/Tk9t5Vhg6md63Ac8LUor1/4PylT9wiI69+6YEx
	Eo+S0xgB2Q8DtQwSettvmJLMtCrQSiI2xQPHVUIqty0kD7ePV9xI5MIt0yzsUP/P
	WDmsUXUAqRkVImIWfiEyjfuZsnxwlShklyDOVLef/BbDrNCyYwM16kiylAt83P3F
	6P7c8qDtbB4SDGOuu8p0S0jL4zdHh1C585QidvAkckNEbCjBYO16gaX4KA18RWA8
	LCxN/ryw6FJYmK4XsSql9dCL7cOMn7+63hFHMMRaRLhuP1/L0R54dKDfsm0bQbIZ
	bLdaXOVGsLadii6qV27ig==
X-ME-Sender: <xms:zWTJZ22cS8InxrZX6ifTZXrwoCoUmsmXiV44cylar0MzvI4-3cwtlg>
    <xme:zWTJZ5GkLauUzoNB79u6ryP0t80t3ssMGe63KFqgLlF4YIqNZYXit0-J0RDpq981g
    fupqyeP2-BN_ZAj7w0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
    dprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsiigvfihskhhisehlihhnrghrohdr
    ohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:zWTJZ-6vVU_hwfA6CpYoqM2_KyGma8sbJjdhwmvqNDAhFx6yZsqcqQ>
    <xmx:zWTJZ30o15uhtICFaA1zmH6UUk05KKBmCcFupwZqcfu2imFlHTPWcQ>
    <xmx:zWTJZ5FPfJ4OcwRRQptLa4sFJGVOBoX7ftFAatrjyFrVEalF7tLKBw>
    <xmx:zWTJZw_D_MJfCB3fBjmoGY96PU-QRXIFco6eSW_JVTcISiHtJ5h0UA>
    <xmx:zmTJZ9h7ajJd_2rJtxZzCwtyFpi-AAHzFpfQAlj3kWwm95_Kiyd3bg75>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D60B82220072; Thu,  6 Mar 2025 04:03:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 10:02:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Message-Id: <1f599860-0276-47a2-89cb-e655e516cf23@app.fastmail.com>
In-Reply-To: <20250306084552.15894-1-brgl@bgdev.pl>
References: <20250306084552.15894-1-brgl@bgdev.pl>
Subject: Re: [PATCH] irqchip: davinci: remove leftover header
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 6, 2025, at 09:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit fa8dede4d0a0 ("irqchip: remove davinci aintc driver") removed the
> davinci aintc driver but left behind the associated header. Remove it
> now.
>
> Fixes: fa8dede4d0a0 ("irqchip: remove davinci aintc driver")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

