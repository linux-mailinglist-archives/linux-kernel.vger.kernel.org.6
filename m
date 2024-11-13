Return-Path: <linux-kernel+bounces-408404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DB9C7E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3A3B236B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4718C01B;
	Wed, 13 Nov 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eVQ8dECy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MpVxabEm"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8ED33CFC;
	Wed, 13 Nov 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537828; cv=none; b=eyMAW+8n4sEkBXIUg7f91+bQpSFwMQ2mopjTtKf93ymdfPXV44oh52TQDsqkcBNkKMlI2n3lNTWUQePJU/fFGY+TRyNbJAEnBadU40cFNlR5rr9O+Odu0WhcpBVQyHLkfx6P6NGt8OjkyeMwEwwzxKzRXBZO97b/Ayu3pKU+1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537828; c=relaxed/simple;
	bh=e6N6jBMF/NFbuAbQJ0ATdRAlfGpetC8vcmbamz2iU0U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nqj196N8DKqTOo39XZM/lvEb2rhuXWWONqOB155DRZ/RHFAKTnGb+iP7K9a/VlQ07FsM5v/lSpevH5PHW7EI9W9dG6JH/LU6Fcr/sTkJJTS2tXxzf/LDw4XO+4+fI8cyfddGTK4pZMCbnGkBEXX0hagdkxoEVAvSrSMRKM2ju08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eVQ8dECy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MpVxabEm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6979A1140207;
	Wed, 13 Nov 2024 17:43:44 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 17:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731537824;
	 x=1731624224; bh=czIXYuYkVBfX6Ui02g9qzpLxBgPPnotbplS8jYeNbtk=; b=
	eVQ8dECyK+t9Du4YhRkbshwH9MHvCAk+ld/mE3hMk2vGUBxXDBc6YJdRdXqOj9ge
	QYayzhL7y/9VHBvKR9NMHHVVmz9io8MxU9zH3lwUKUeuzehbFdTF2nG5dHPOFFyQ
	pXMLLPCLc349ut1msQAM090uhY+XAI4/LWkjQBD/RgZn9+PV/u7dYTkrcmJCKwZQ
	qkrXYPLaaJCyOizumE+BImJxj6T1R9yXor4GZ2wsdiPvoaPmR3GtgsaR8vU9j3rh
	GyCgqYwiL+yZ7BDuqZSIB9G4mh9dVqPS4QWhwAy6tt6SjVsIjqusiKv+c25ifoTo
	Emk3X8QAzFc36QSBapgKcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731537824; x=
	1731624224; bh=czIXYuYkVBfX6Ui02g9qzpLxBgPPnotbplS8jYeNbtk=; b=M
	pVxabEmQcxocdOnHOZcrcHSPlX1q98MeXhG07gSPbga4q16g7d6EjlGl33hGqnZi
	+pf4hjsLzixcKXaIO9LPMvLOyWaFSP36WIyUcSwpErbgpbbmfWWKU8yDXw8USC7s
	mLu+A5BK2F/p2xV6KoRAfb3flSXWhI0FT7n+49bX6Gaki9dFToIXneKhkUMmYpC4
	D7HiXnXBrmz26bBvuF2XQs7VKPXLwnEbZh0U64ogNjrTMWL1O2OB2U+zjfyX/yy6
	5Lap5caCPjOHLeUx8F2+4yILfcpyG4uE5Rl+ebuVpD3PJunAoRojP/CEPZvExckO
	1v6sjUQBI8NrJCui2mxcg==
X-ME-Sender: <xms:nis1Z8wk5To5zQeAWRdFZ0iL8nkKRkujGdFu4TdEf3Ok8ABwO0CxZQ>
    <xme:nis1ZwQPpg6o0jlzEXavaOBUg7IY32ix9sZj-KZllFli6iiLzY_0lpBRXuhqA0GLP
    lF4wwxr66KTlkFyaAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghnghgsihhnsegtmhhsshdrtghhih
    hnrghmohgsihhlvgdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhishgvohhkrdhjohesihhrohhnuggvvhhitggvrdgtoh
    hmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhho
    ohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghrvgigsehpvghrvgigrd
    gtiidprhgtphhtthhopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhsohhunhgusehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nis1Z-VUQrVBWPJUDpUqRIJs5v22pKL8INCu35tfCU7DdIpdfXQlpA>
    <xmx:nis1Z6hPg-MvP9k4dpmRwXy_b13lssWA4X6yCWO28bzzI2XXkoEXPg>
    <xmx:nis1Z-CenTNEuXJl4hSNGky2YXJhx9LopysCHS8YHlwVaSFkG853wQ>
    <xmx:nis1Z7KBQM7yza2bvT3RuLXJCBqw4D8-zLjUFE3WTKq2uBa5WJMf1Q>
    <xmx:oCs1Z61A9Bm0GV15j2BAmBXfsxpQuaboD9FrH34tmN4uocYkhBuFnf0U>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B80AD222006F; Wed, 13 Nov 2024 17:43:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 23:43:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Kiseok Jo" <kiseok.jo@irondevice.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Tang Bin" <tangbin@cmss.chinamobile.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <253ed1d8-fdbe-40ac-9791-843f3e1ca226@app.fastmail.com>
In-Reply-To: <ZzSoeF7dnWDw6rqj@finisterre.sirena.org.uk>
References: <20241113115708.4772-1-arnd@kernel.org>
 <ZzSoeF7dnWDw6rqj@finisterre.sirena.org.uk>
Subject: Re: [PATCH] ASoC: sma1307: fix uninitialized variable refence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2024, at 14:24, Mark Brown wrote:
> On Wed, Nov 13, 2024 at 12:56:50PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When firmware loading is disabled, gcc warns that the local
>> 'fw' variable fails to get initialized:
>> 
>> sound/soc/codecs/sma1307.c: In function 'sma1307_setting_loaded.isra':
>> sound/soc/codecs/sma1307.c:1717:12: error: 'fw' is used uninitialized [-Werror=uninitialized]
>>  1717 |         if (!fw) {
>>       |            ^
>> sound/soc/codecs/sma1307.c:1712:32: note: 'fw' was declared here
>>  1712 |         const struct firmware *fw;
>> 
>> Initialize this to NULL as that is what it gets checked for in
>> case of error.
>
> This is just shutting the warning up - looking at the stub the real
> issue is that there's a return value from request_firmware() which isn't
> being checked, we're checking for the initialisation of fw instead.

I sent the updated version earlier, now just checking the return
code.

> There is one path in the actual implementation that returns an error
> code without setting fw, though most do.  Either this caller should be
> updated to check the return code or if checking fw alone is valid (which
> TBH does look like the intent) the stub should be updated to set it.

From what I saw earlier, the fw pointer gets set exactly in the
same cases that return success (through *firmware_p), checking one
or the other is almost the same, but you are totally right checking
the return code is the right thing to do here, plus it avoids
the pointless release_firmware(NULL).

       Arnd

