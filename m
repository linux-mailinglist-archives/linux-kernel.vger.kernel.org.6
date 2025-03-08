Return-Path: <linux-kernel+bounces-552409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54FA5799C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D597016D902
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401DC1AA78E;
	Sat,  8 Mar 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="AfqRn1ho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xzrqzp7W"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395614A0B7;
	Sat,  8 Mar 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427469; cv=none; b=YefUMPeimPzThPds1kQI3Re0uNTKQnDHQQ8cX9ZGyVFRGuUFSYZ7CA8ppnlM6yjmZlVOuPfBLs06yukHyFKG9j8uJoy/YCbpBPwoG5404XA2x9BPZTtOaXHvM6L4ra6gsKd3i5Rt7C/jXMnipPbDDWmM/vhcg+TMY72OTeX/o3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427469; c=relaxed/simple;
	bh=Id80U8v2uBW901XmmB+DRmaCJiaToKjtFbz2EHfcaK8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VKkLOglya1+HPI0EijRRTt/0sSvLUoyYaIJQCdkL5IHFqkzJq360Pxglm3gOCokrNMl8yKBo4Oo2bp+jLZhpZ11ibDLd+d2VDRIDZN7C+ZDphT4a8GSM8/5GfP5apkFDL9n3vnRc1MqcpW2Qsr1Q+u/bM42OPRi/i0q/Yj9Hv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=AfqRn1ho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xzrqzp7W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 70BFA138283C;
	Sat,  8 Mar 2025 04:51:05 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Sat, 08 Mar 2025 04:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741427465; x=1741513865; bh=Id80U8v2uBW901XmmB+DRmaCJiaToKjt
	Fbz2EHfcaK8=; b=AfqRn1hoQFOCcMe1/Vxfxrx+ZZ/raQW3mZoARtgK6lIETf2V
	YG7H6+8Dryag+nuHPg96I2Ua4KNZEu9eADQJv/RqocJ6xEETKWtjZr/+oTtHdtTA
	ba86Evsszm02TU1+TfBimrjkIFQxkq/f/Zujw0s8k6oH49pWk2i5E6Eeq/ISQ6gd
	7nkvNKpsMlZi7q6TnE+nMC7b5ys/1n83uyPT+zAUsmZ90JcAwfZBy9PuuK0lSmq0
	sJu7NUO2djA2GvbqtLHPEYKjWQELfKsDb1gs9LNw2sHswuNBjtmadBlzFDy0uHMy
	ZVk+RyXOmNn88YcTW36TSpwvbfvS2bzQhB+IGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741427465; x=
	1741513865; bh=Id80U8v2uBW901XmmB+DRmaCJiaToKjtFbz2EHfcaK8=; b=X
	zrqzp7WJR48R6EWkoYTBAool9kBMTiWa+CowGLeR89xyrPanGxAgdkF77j59UgqZ
	mW9qKYMoGoUgMGCqQz6u/y2S4PuxVEn+Cpidz0CWaciOa687N8xfPbBAG7b/c/t+
	SqkLMvkIwfLDKP22NbsmqrVUwbzrvp997ph/k8rQlTxK7AJKa2pkWzTHSJSEVARU
	bUERiOw3BhmirCA0u4jMYPM9ofRb6TBTgMz3QpfDBexphbG4VS+wYn74aeX9wGzQ
	gZRt+6QUP6K72lSZbE1j9FmdvaBNdL2Nc58ZY2SpkPuC6MIuFKD3rf9BJs2ijsMt
	g1D13XZ46mfTQ9cBXHF5A==
X-ME-Sender: <xms:CRPMZ-4hA9Wzr9Ncd7JokmUY_a_kw5nkNC_qKYk4PoQ_jYfFKZESEw>
    <xme:CRPMZ35iL3b86BAJwS-ikiL0cIU_JuBCrU5SBEW-tDVZAThoaK7mdInbHpP3inRl5
    H91Ojy4CCkZ1uR1-IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhnkhhlrd
    hkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgv
    thdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihho
X-ME-Proxy: <xmx:CRPMZ9d7MuwznOq0e5Miq4-S3oa5nKtoKoARHmnipTMSWwhqlNE1Vw>
    <xmx:CRPMZ7JQ2c3LlokOGJOMpgqsYkOWGpv2VV0MIBAVth1HHGrQbaXAWA>
    <xmx:CRPMZyIMY-Cmz-60aixSQpW3NMsEc5R4iziQ2pp0nVWFFM95vvJOMQ>
    <xmx:CRPMZ8xSUbNj7jxnzdVcPrxTrd0ZQHad5FArb2-CX1Qc4FcpO6uUGQ>
    <xmx:CRPMZ_DqDI_j-r5q7ch7SQOCUREA4U0NGlOqUYlQre1o-0up0ILk3uAI>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A337BA006F; Sat,  8 Mar 2025 04:51:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 10:50:43 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <ff7dec26-5bf8-4c0b-af7c-76064f3386b7@app.fastmail.com>
In-Reply-To: <20250307-spmi-v2-1-eccdb06afb99@gmail.com>
References: <20250307-spmi-v2-0-eccdb06afb99@gmail.com>
 <20250307-spmi-v2-1-eccdb06afb99@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: spmi: Add Apple SPMI controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 7, 2025, at 21:08, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Add bindings for the SPMI controller present on most Apple SoCs
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Thanks,


Sven

