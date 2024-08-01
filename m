Return-Path: <linux-kernel+bounces-271385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDE944D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CDC1F2264E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303411A38C5;
	Thu,  1 Aug 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qBz1BiFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3Pm6uON"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147F1A256A;
	Thu,  1 Aug 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520144; cv=none; b=YdCh+Ba8/vgSjQA5c/u3+flJCs1B3tvtozKIqDhHx9FFAbY0MsPsijDDlm2zmFAKTV0bMlZe5MX6nECAO1Q36LUWzxInNSkablB1ZAxNO1NqRwjjhCS83nu9BPXkLo60GjZLJ4mz4HsTeF0EP9UkZHugkIMqXLhma8rbaM/GNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520144; c=relaxed/simple;
	bh=+C52LdFvAjE+mXsGHriIbj6tuuT/lQhCY+ifrbZmo0E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G+Nm7mClD207ya6HnlmuAb+IS9rRaYocAfn51aLqumb7ZiwMvaRs1dffswnZc3fEtxYmg1m/U4z6BNumDS5dk1RdTrRxSKtD0ZdSQL4dC4w35hX2yE94+47fkARjSHC/E7AzGYj03mg1puyWiC4AhrQ6CYdQY7FxaC4zuUa3a24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qBz1BiFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3Pm6uON; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A5BC81384F3C;
	Thu,  1 Aug 2024 09:49:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 09:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722520140;
	 x=1722606540; bh=GJEzgwsKZt4bp3uy6m1hT5few7XxNP8mFrHkdVLGOhs=; b=
	qBz1BiFAH24xnCBN8qJLdTaJO9PQAO2y79hNSNm4S5dABMsXi7Fit3PE+K7VJWZh
	H0Brpz3VF0mjbPyhyvsTE9HZn1RIkObzuuLfbIOtVvFpWzCyPND6atXbO2/PJRAa
	zigyzakOFYj4OZKrTV9kFqJT7BZBT3E3kyjlVxE5TCrrdxoGm/W7KXX1le4xHsaz
	rbnzl/BiLRi9aKMLStD3ojV8Z4tc5ZiJpFkgbtvS9ElkIJ0kOLtFtaJ+lscQsPzZ
	3kHbrYK4Iii+u9ArfCEDDqnyNuW9uuQJC+ux8LnPlJEPk53loZX9djJHPKEv6E04
	Ji45cZeIjexBHHKkhcV3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722520140; x=
	1722606540; bh=GJEzgwsKZt4bp3uy6m1hT5few7XxNP8mFrHkdVLGOhs=; b=m
	3Pm6uONRn1padlZDoSowpf+1nXUPSNDmtVqikfaQjZONq5j8VAGiH4wIOOJkvtdU
	JI85Y+aOI+UgwWGhTxY4TUD+mE5LCL003q5KWKd8StnAhf3bnCG016XBksEBSi2/
	EVSulFupz3nd6f2Mwj8aVQwTmihwsMn033SpOhBzbvfu/cT79/yXpifAJhTgsyV7
	DlyiZVer+yltUROZz2UI3YFEDGC1bPL/QnALh8wN0TE3kGk1MdgB7PupfP2Ey+Nr
	uf3S04Kb5EY7EonoE2OEQUSBhLHze+S8MRcWubbP7NlSzG2UxCHY/+WhW8/Z9izO
	RGueHut2Ha6E011WK/hKw==
X-ME-Sender: <xms:S5KrZsufSRNGkRzfdo699hRN_2u-4UtL9Cno4jYrWZ5DEH07WECn_A>
    <xme:S5KrZpeHA_3HUSQ_MFVkHTyK-rUX7p8Kd676woXY5VPsXlaHtQStXOCMTynaYHtgQ
    LWxNcC-SH-1Ta3ShHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfei
    hfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtoheptd
X-ME-Proxy: <xmx:S5KrZny95s54ZULH78Zp1ZsenH3tfyJomA1xSN_mvGemBLSLn9SmnA>
    <xmx:S5KrZvOBr-G5xshLk9lDbBMPN9s_iC7YVLauz-mD40X4scd4UaFBNg>
    <xmx:S5KrZs9qwoijaUI1wmqYZh2dPC7L5SuTrOIIVUwZ4h_nfc8AJJxiww>
    <xmx:S5KrZnUQeGCwFDDYVDvr1PGL10zQJnQmS2MZMwwJ3hvMMYPl3jczvQ>
    <xmx:TJKrZmfcOU6EJzYnkPYNqKJZPrqSIHUfORlmiuvDbUZaUP7K59AMEm0V>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0EB7FB6008D; Thu,  1 Aug 2024 09:48:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 15:48:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Baoquan He" <bhe@redhat.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Linus Walleij" <linus.walleij@linaro.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <78f2483d-b05b-4738-8d3b-ea96a5b322bc@app.fastmail.com>
In-Reply-To: <6bd73068-4474-4129-857b-39150a31f224@roeck-us.net>
References: <20240730152744.2813600-1-arnd@kernel.org>
 <6bd73068-4474-4129-857b-39150a31f224@roeck-us.net>
Subject: Re: [PATCH] alpha: fix ioread64be()/iowrite64be() helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 31, 2024, at 17:47, Guenter Roeck wrote:
> On Tue, Jul 30, 2024 at 05:27:25PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Compile-testing the crypto/caam driver on alpha showed a pre-existing
>> problem on alpha with iowrite64be() missing:
>> 
>> ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!
>> 
>> The prototypes were added a while ago when we started using asm-generic/io.h,
>> but the implementation was still missing. At some point the ioread64/iowrite64
>> helpers were added, but the big-endian versions are still missing, and
>> the generic version (using readq/writeq) is would not work here.
>> 
>> Change it to wrap ioread64()/iowrite64() instead.
>> 
>> Fixes: beba3771d9e0 ("crypto: caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST")
>> Fixes: e19d4ebc536d ("alpha: add full ioread64/iowrite64 implementation")
>> Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
>> Closes: https://lore.kernel.org/all/CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

>> +#define ioread64be(p) swab64(ioread64(p))
>>  #define iowrite16be(v,p) iowrite16(swab16(v), (p))
>>  #define iowrite32be(v,p) iowrite32(swab32(v), (p))
>> +#define iowrite64be(v,p) iowrite64(swab64(v), (p))
>> +
>>  

Fixed

      Arnd

