Return-Path: <linux-kernel+bounces-366655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236199F850
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663FB1C221D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760911F8F08;
	Tue, 15 Oct 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y3wrCeuf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3wcUSXT"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776F1F584E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025710; cv=none; b=k1hf3t4FkWEBNPOyPLikzuysXvq7+TsnVDxMMGINuKhU+hVWNALV/h2HR5epvuda1BJso2fLNW2rq9sTFEQctOufu050Ry+S6iL+g4hmQJFQdNyv0PaJ7fN/TxyQIo55hgnR0zB2/ukwzaXdssT+v4IkktoV+uvxB1fwUOamrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025710; c=relaxed/simple;
	bh=YmYRxqbQkOPzCcQtgkT/Iz21rZZItsqHASWDAAs2OyA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QJQKlqIPqNAeU5V7Epw1MnGsRMHvThMDKKb14QvM3Qx9IjqKWfR0fDvk+sU/imxHm1N725CE4BDzlqlfoPgf6dfvHvJOE/krz3MFureag7EGqagVbpuTZ0HdElHa6w7rz9PDEk6oLirQqIfPbarXQVQKeSvoCwzTS3nnkDogFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y3wrCeuf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3wcUSXT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89262114017F;
	Tue, 15 Oct 2024 16:55:06 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 16:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729025706;
	 x=1729112106; bh=l3nJjodSpK/VVc6vgLT6oE+JqBcCQt2u95cPO9POPfs=; b=
	Y3wrCeuf1llBsTrnZy8OLM/+iOlHiypvbRCBiDmJD0ivuVSvXaB0UiNRxVGlS5r0
	DG5HQiz5GBP1ZWRjCD37Xn4yxVhPUZtgQT4Rovxq5tuUK7gUbqBTlihGRedCd9ZH
	3GbVnGnlNXGGj/hSTTvLACZpB8Vt84XwcsDMlo976qMQ/D2aZdMDV3OePWdEnCPz
	WN2JVWcbtZGCGb34W4nFfIGpNHqYAANM3ewfI8ElrXgdHx9LdTyhgy0S3/QPZmtK
	TQUWh7HRX2epxiZiTAXQa5/NXRFwPusRIVl8k2xZ8kG0E1RBbR4iBLKhtC3bOaR3
	33F/OwUaiyv1mAsHGm2ikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729025706; x=
	1729112106; bh=l3nJjodSpK/VVc6vgLT6oE+JqBcCQt2u95cPO9POPfs=; b=A
	3wcUSXTp4eswxdmECmOceVGzzuiPxxXTzS5nQ2X/xgITWvS9FngC2ljxP+OWN7CR
	GuOvi3S2sFlfXfWAZQAZE9QEBvD3qztUGHUGjQHh3/UvKfKvd3CrY5eSXflA8PpL
	/B5ChQb/kdYkJrFkAgp3jnTe3QxL9JI3vKLZWI//g7bIkzsMVp7GzK68UbWEKAt3
	bILLRKrYlhGkru5wqy3abnvASQxC/qDY0JThoPds1IvzWVjvOlFc83vLs87LG5Gm
	pFBrSoEb946ZK/RZ+T2nuPHo+E5A2AZLerdBiYcAmz9w2/11zMddiCqwuf61YCUZ
	7CvmJ5Ul/eeQT3nyBAfMQ==
X-ME-Sender: <xms:qdYOZ80FtrsZuc-Y4aWT49ztE4kKCjyqF_5BOwCy2K-krna0u4mlrw>
    <xme:qdYOZ3HCqNxj67NadOnqxOtNmgHV5UEwfNQ997Zd-iiDB6oPb3CpgGuZbrcfeojrQ
    qHs2I2HaUJeXrZ0Nv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhthihnrdifvghltghhse
    gtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghrrghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtph
    htthhopegrnhguvghrshhsohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrght
    hhhivghurdhpohhirhhivghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheprghfugesthhirdgtohhmpdhrtghpthhtohephhhnrghgrghllhgrseht
    ihdrtghomh
X-ME-Proxy: <xmx:qdYOZ06oGMglejHH6nCkHN2F-AfN5um0aMJDWe-2lq27KoZrc4QmHQ>
    <xmx:qdYOZ10pgWqrhnvrRCAl9avcihUAlxuiYs4QPpdjTSavqpOMLBp7EA>
    <xmx:qdYOZ_HuJ2iuEpO9K-AbXnIhEGSpLhcXypb3vKdXP5UM49QN_bMRig>
    <xmx:qdYOZ-_ev_7sEc0laGyTrGPpv8Vc5YrqrZJY90O1-RWDWhFywAuq_g>
    <xmx:qtYOZ2BbV8gZGX7gjqla_LvHFXolHX9gjRDsUT9WGrw-MktjYWN7a9Ah>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B64142220072; Tue, 15 Oct 2024 16:55:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 20:54:45 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>, "Andrew Davis" <afd@ti.com>,
 "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Martyn Welch" <martyn.welch@collabora.com>, "Hari Nagalla" <hnagalla@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <1a88e7b5-582f-4d52-864a-e828f6619bc8@app.fastmail.com>
In-Reply-To: <202410160435.WzzQa1p5-lkp@intel.com>
References: <20241014144821.15094-3-afd@ti.com>
 <202410160435.WzzQa1p5-lkp@intel.com>
Subject: Re: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Tue, Oct 15, 2024, at 20:46, kernel test robot wrote:
>    In file included from drivers/firmware/ti_sci.c:14:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:548:31: warning: performing pointer 
> arithmetic on a null pointer has undefined behavior 
> [-Wnull-pointer-arithmetic]
>      548 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer 
> arithmetic on a null pointer has undefined behavior 
> [-Wnull-pointer-arithmetic]
>      561 |         val = __le16_to_cpu((__le16 
> __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         


Hopefully we will be able to finally address these in 6.13
for all drivers, it's been a decade. Don't worry about
the above.


> platform_device *dev,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~
>>> drivers/firmware/ti_sci.c:3285:34: warning: unused variable 'ti_sci_of_match' [-Wunused-const-variable]
>     3285 | static const struct of_device_id ti_sci_of_match[] = {
>          |                                  ^~~~~~~~~~~~~~~
>    8 warnings generated.
>

Needs this change, please fold into your patch.

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..6a6bf7a2d134 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3421,7 +3421,7 @@ static struct platform_driver ti_sci_driver = {
        .probe = ti_sci_probe,
        .driver = {
                   .name = "ti-sci",
-                  .of_match_table = of_match_ptr(ti_sci_of_match),
+                  .of_match_table = ti_sci_of_match,
                   .suppress_bind_attrs = true,
        },
 };



