Return-Path: <linux-kernel+bounces-316716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6296D309
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6C61F24DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3919580A;
	Thu,  5 Sep 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BkwxLa2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mc/5r8qk"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFF192B94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528216; cv=none; b=RJRBXu7UbZHAbuU0BtlCMIZCJo6VbqKYGiJvhlHs3RR+qlHLwMQEt3A0NDt2KQtnoFJiMpI52hPpbOkO6hZdDcpyQOXL8YN3Dumr4KIK46TrFtb30d/UX0mBXp9Gm6u+JWUxVnlbG7DqA5P3IGTAhYXV+v7Gc8sCjVrawoDYaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528216; c=relaxed/simple;
	bh=wzoRBG1p6hUEbyngwLEFQbkeO/qVa0XWEzA3ZW6L6z8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cvIMpW9Qgp6/l4An4MCCeM7qvjDFpZSxB8RLTVYnqgBpfhIvpg99HQGkP4z0EHld9bAgcUIRq01v88OCWRRtPojqKQH/NBLRhvcMgsRG15nQ669EnqCe5lbTJpPcO+sSIZ1MxfyT8ui/AHj8anH0KT+GZCkTP0cwuvXAFN7H5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BkwxLa2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mc/5r8qk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75D99114012C;
	Thu,  5 Sep 2024 05:23:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 05:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725528212;
	 x=1725614612; bh=/kd72puemH7HG5k90wuxIWlVONqVTbIySxjDZBLyORg=; b=
	BkwxLa2WEoy8SOhL4ZQfEBGnMx9iUu4JMtVeQtWn8xwCPMDarpkqPPLbGHlxCuId
	v0Sh0g3opi/cbrUcFgD8lentdBESbNyTZjLAEsoj7qJ6JVaHKikyuOo0f7ceOpca
	XvwOqM/C1iNrdz5b0w58Jwo0jifr6UtKmRuVMpB1AGleMf8eC2MkpCNS0URKTLFQ
	oCaRr+r1egywwKu9crfzlMtE5ki+iW/a4yx9cZdk60A1E+WzOPWuaIDARChrOtgz
	/NZLHcWuAdLnv/IKukNseXfhiVCs52Rk+BYxwuDa0zIirzPW+H4xfMNxxrZzEks1
	+2kYyknF70Tnn/uhAslWBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725528212; x=
	1725614612; bh=/kd72puemH7HG5k90wuxIWlVONqVTbIySxjDZBLyORg=; b=m
	c/5r8qk0GYWh2cw3TsbKB3aNZIXLr8CTLhciWmeQNmT0jvyYD8Wxm8tToAU4OR9H
	06s5dLq3S3826SHP8k53hfasyJLnHdFFZ+akMJ/ngg7bGcpuaNqH7W5HgOGmvoE4
	Z6OvYCoukTgaiDWeA7ZUi1mXMusqXSREpwIwT2h1Pg93KKWqPWOhyUj9i05Ps3s2
	tHGEI7ZaaWI0ccJnILAEW18kPSSkHsMOksWMnp5C3lfE+Y/1RUbTGAAD3NmdkgYP
	T08qFnPDq7lJmwlplrRmkpcMe8xj1e1ob0OLwpq5KPwtythqcxOtRzylsx5p5U4K
	u1ivnMlQgNWYvgnCixvXA==
X-ME-Sender: <xms:lHjZZlQQ2Qw3yVmlRqsbAFDjpai9VPp69EbjE71ej2RDlSQapf0pGg>
    <xme:lHjZZuyHfapqOLfVsJkivhV8EB6ik-GlVcrqSeoSaowd6IEB6oAKO7xzqe3L2ycz6
    Z9-QT78PIbG8aS9c3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeel
    keeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprhgtphhtthho
    pehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtth
    hopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthht
    oheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvg
    hrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtohepqh
    hirghnghdriihhrghosehngihprdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lHjZZq0_gUxdYs52_lYFfs3Gcxe_laL-EPCwRgcl5860KAfu4aUH8g>
    <xmx:lHjZZtD2nLCV2YRN4VsCWKoFP28K-xSwNB1y5UG9WINURKSJo5OySA>
    <xmx:lHjZZui6l1yvfHJMIJpoeezgW0M48_GP4OGXTmsByBywf97izulwBw>
    <xmx:lHjZZhqhTb3ztlLlAaU5MQciyiTve5aBAPO2hIR1dDi8M7J60cY-nQ>
    <xmx:lHjZZijlSE6Ptrs17NVCvIjDgdPUK0t3wyiXfewthpeyB9d73kfRJNpq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A2312220071; Thu,  5 Sep 2024 05:23:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Sep 2024 09:23:10 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Herve Codina" <herve.codina@bootlin.com>, "Qiang Zhao" <qiang.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "kernel test robot" <lkp@intel.com>
Message-Id: <24dd3479-6fef-43ec-bcec-e70474128e53@app.fastmail.com>
In-Reply-To: <7091c023-c7e6-4b3a-b306-12d73b8f6698@csgroup.eu>
References: <20240905072215.337010-1-herve.codina@bootlin.com>
 <7091c023-c7e6-4b3a-b306-12d73b8f6698@csgroup.eu>
Subject: Re: [PATCH] soc: fsl: qe: ucc: Export ucc_mux_set_grant_tsa_bkpt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024, at 07:31, Christophe Leroy wrote:
> Le 05/09/2024 =C3=A0 09:22, Herve Codina a =C3=A9crit=C2=A0:
>> When TSA is compiled as module the following error is reported:
>>    "ucc_mux_set_grant_tsa_bkpt" [drivers/soc/fsl/qe/tsa.ko] undefined!
>>=20
>> Indeed, the ucc_mux_set_grant_tsa_bkpt symbol is not exported.
>>=20
>> Simply export ucc_mux_set_grant_tsa_bkpt.
>>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409051409.fszn8rEo-l=
kp@intel.com/
>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Arnd, it is ok for you to take this patch directly ?

I've applied this one directly, but I'm not always paying attention
to patches flying by, so if you have more fixes like this in the future,
I recommend that you forward those to soc@kernel.org, either as a patch
or a pull request.

That way, I see them in patchwork and will apply them from there.

      Arnd

