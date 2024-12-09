Return-Path: <linux-kernel+bounces-437981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3859E9B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957D81885865
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125F136671;
	Mon,  9 Dec 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TBLTHCMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvGr9RJE"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53146233139
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760495; cv=none; b=bAtJs6qmd+7K769IRzAuHhnIH5pZOddzTPt6Ahbx20bTOARC/DlZmzV49QAbe3UO01NspWV71LOw7E1myLeB8Lh7OTQE3r9ZtSOIYIo8n+COLFdkodGpF/j6tYM/S94G8vIsPKghVFZ3AoKLOk7aCCJvfmeVERFNpdSqWA5N30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760495; c=relaxed/simple;
	bh=lGGzdxKs99WIvOvhHGBuDPDZWmYDMpqFQRNBN6fwpSw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hIFiS9e7H6ml6Qc1I4VECsSihAbOG5AtQXEXxvJsZZgrl+PWNZqNOOB/Nz9+QOIgPxPnnvJ8W6CU//zaPxi2oEKHWOMch6EGhVw0N4sO35Xk/aK8JGDMMgatb5h+Gg+PnoYAo8JxFPbzApnMEG1dXrrCAZbvq5KTHZ3hz/D9fM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TBLTHCMp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvGr9RJE; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2458A1140192;
	Mon,  9 Dec 2024 11:08:12 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Dec 2024 11:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733760491;
	 x=1733846891; bh=lGGzdxKs99WIvOvhHGBuDPDZWmYDMpqFQRNBN6fwpSw=; b=
	TBLTHCMplAQlJdeuQQkMM42PUgi3ZqruQ8Jw4QMtNE8/2V0vyb8XjhcGzScGH24n
	XmMvnYKhhhamUi8B+/7Dyq4k0jUaHA+g+jQ+DrViFmI5dFjvA/hEUwvS8EE0xxMF
	hJdmI5eWHJM6wgJSQiU1AlKJAleGf008VF8QZjDFjffizPJyL1uqumSMxm8L/l+7
	WOUInjjhPhydDvcWUNn1xKp2/WVWiALIQ8+KiIetCCJ11ENKHEoNpNFCbWP68FGN
	0L1miB6SH79m+tijSQKh4d5chjpHN01ziMjStD4bLb763x3otd8j4sFNCeBpyFd6
	Epi330aKMHQL/93/b3QODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733760491; x=
	1733846891; bh=lGGzdxKs99WIvOvhHGBuDPDZWmYDMpqFQRNBN6fwpSw=; b=l
	vGr9RJEsg5snz80iOXaT3YI60d8ndjMSPOp2dwht+WbMYyHNhLc6dMsTiDoifh1p
	1fqXguOCKZeH2oXDxCUHFLPfFTa5TubcZxujO2IOcZEIeOqjdASMrpDVk5sPng9b
	nfU4J9dld6EsHYVVxofNdbZ+Qz57Jp4llfJRJZgjsFa8i1uEi53t9sxzH+IhVr9E
	eLVyrPJHTdwwyR3JfrPlAe7QTllZ6eSrJPH5wD8DZ5s44biKy7QpIMyEStuPfl4X
	jepIa5A7MFI2bOyN6z279/jBJt5qCs94wwhnMpY5SiL6078pS0mZtC6b92m8Qbjv
	pjH+7WDodtPWkhd4D/D5A==
X-ME-Sender: <xms:6xVXZ1YdRy5luvP_KolHRbeucQwqGXeZgFu_HWCLdSyHzJmUamNS2g>
    <xme:6xVXZ8bd4H9MFb7v_UtQU40jPIKI4QVWsGv_zZu3jt6FGpbzg4-rBGSJ0PG6516Vs
    IsuwurKLog0_xCRG7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeigdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhiuhgthhgvnhhgrdiguhesrghmlh
    hoghhitgdrtghomhdprhgtphhtthhopehjsghruhhnvghtsegsrgihlhhisghrvgdrtgho
    mhdprhgtphhtthhopehkhhhilhhmrghnsegsrgihlhhisghrvgdrtghomhdprhgtphhtth
    hopehmrghrthhinhdrsghluhhmvghnshhtihhnghhlsehgohhoghhlvghmrghilhdrtgho
    mhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    hilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrghmlhhoghhitgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehprdiirggsvghlsehpvghnghhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:6xVXZ3-p5pfO8YOYxyU94ucOT9yL81ex1CEDu31SN2hDc05SK07c9Q>
    <xmx:6xVXZzqxdZEwqEFx5y72G5_2BNeyNeJ718OlImRJGhs-oFPNAj0puA>
    <xmx:6xVXZwpWEpZiQVKzIlv6jSO07--YRBCmAAEWmpoJ5Gk4M-wfj9Miqg>
    <xmx:6xVXZ5Q6Ot2189TBydRQ5wS5LNDeur3Js0FCwfKVr1uADo__emnbqg>
    <xmx:6xVXZ32UoQWhJWnPf8wEmQMaYSUeZHwtPaFr3GZRiLd-akKNSn4CRCqW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 727622220073; Mon,  9 Dec 2024 11:08:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 17:07:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Jiucheng Xu" <jiucheng.xu@amlogic.com>, "Stephen Boyd" <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <5519bdc5-4056-417f-a89e-26f9ae426922@app.fastmail.com>
In-Reply-To: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
References: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
Subject: Re: [PATCH 0/2] reset: amlogic: rework auxiliary reset support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 9, 2024, at 17:04, Jerome Brunet wrote:
> The current implementation of auxiliary reset controller, with the
> registration helper in the same module as the driver code, does not
> allow to properly decouple the registered auxiliary driver from
> the registering one.
>
> This patchset removes the registration helper from the auxiliary reset
> driver and changes how regmap is passed, to simplify the interface a bit.
>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

