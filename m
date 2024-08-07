Return-Path: <linux-kernel+bounces-278141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B747994ACAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD0283782
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2684DF5;
	Wed,  7 Aug 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CJ2cnmwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOGYOilJ"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DC84A46;
	Wed,  7 Aug 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043939; cv=none; b=bP0ZdZ07X1100KurWGmU62QpKmhK+D776dVE/yRpWYR9JYJe7xv+HeyGwAM8pGd3oDOZzOEAH70uHN7Q9DbazqTrYycy7C3zL63Km9OjoYPv3An/QClGYzZ+wdIM7oyb8RSUuw8RqIh6hRJxUcUmufH7wpT4CUBqQ1zdCmpPnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043939; c=relaxed/simple;
	bh=+qZZeT927FOmxfKXQK6ON0ULbpMZirg+jrl3U78lHNc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uuBfNOYg3IAkbygoRP6QiwBt5+/9w2VAcZkYOhEKqiA6uuTb8RCRdqL7WqL2ym4uit+ODyk66eARzPAmS5qrXOGjcuzUrenLyNOzfmWjhZ3M87odveaiMoaIsEL/rLJHgV32Q6PlCxAoz9QBYcu9yU60Lr6mc5JuBSleC/KSwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CJ2cnmwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DOGYOilJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 532E3114E9CF;
	Wed,  7 Aug 2024 11:18:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 11:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723043936;
	 x=1723130336; bh=Ix+ORU9sOaSfeu9FweBXTe9+ziQO/CxzpJRM5DUlm8A=; b=
	CJ2cnmwelvl+f0+2nfTlWZyfWx6chPZYvcPyYDMM9/33xMqUoRfaUYyRzaIONpgM
	cac4R7mP4kwm+M235pj85+/bwSj35dJtS86E7jLi8zR5p1QWVkwK6NoGhr0rvKZ8
	c948Ind/enDh/zGFXz31Avt1TLotK5EoypBP6x3qHu4XzH/409VUB3dwRinEVN6M
	LsTmJBwsdKYKN/RRArexdQq9j04yAtTEJaHtTLy8kTdmjdLGF71dQSev1qnSjtNq
	v0bdMz17jAFE/N9bAVv1K5ceo/UPOYKfQR9F+tujROO4EfCnqzM8FGDeFq3oMStQ
	hUKfMWXXqWYNUSNtZqftOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723043936; x=
	1723130336; bh=Ix+ORU9sOaSfeu9FweBXTe9+ziQO/CxzpJRM5DUlm8A=; b=D
	OGYOilJz7Ue/2OWXiAvO9CmLfqJ6pN9pK+f2W9GSaxQ54Zl3Tp52Dh/r6WMUdUXq
	3glu+NorPJGZpbyAnrk/vgztvCNj2/MsFr9xit0qEWp2Y08PN5Iphl0hKcCJcIv5
	vp0xgXoBd9sLba8GCFFb452cmG7g65/4uEVZbEeY+SSOGR5+niS/85tG8X4kt7zC
	5agm46kYotOjLivVjjMyp6e2OBTia4DQBqOoEz2dKmTVPjtyfLOnOaJh8B5NnMMj
	mYbms75bEz2/c0KFuIVybDflMEnkSWxdB+cVil2ZJDsyJepujv+kEwdVZhEbaj+/
	QZ2SlKhT/63o1mjMRHvUg==
X-ME-Sender: <xms:X5CzZpiiaku8TDBO1Z-0Gi5ur1eu29VZVSIFDCr03W7mgmKYYvxRVA>
    <xme:X5CzZuDmkeaiLNxmb_MlsRnc2pUaxEOLlcsVehacHYkZ9CeMy5nayhe6QpRIrsHnz
    eGUsvs9J_L9r-JX2Pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:X5CzZpHlbE-cswoUrIg3I2hTMMOn2optOwEcOlU9Q6d_2aNm9sG8mg>
    <xmx:X5CzZuRwLUxSF6xomnxPwbRfCqLz1dhhkxOOemWTrc0OvgGYzqAEwA>
    <xmx:X5CzZmytOUmjxoKs5Nvn7yDsBE8-wYGiJzOTtxVQ66vWGJFYumjX3Q>
    <xmx:X5CzZk571AeiwoDIr5nYApYxhdbKXr8hskkXao0t4GiuRpArD10Vqw>
    <xmx:YJCzZjxpdt8poRk8wTp-W4bear_X24aYLJlhWjods_wFGXVz43o6UqQt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B28E0B6008D; Wed,  7 Aug 2024 11:18:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 17:18:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
 "Daniel Baluta" <daniel.baluta@nxp.com>,
 "Seppo Ingalsuo" <seppo.ingalsuo@linux.intel.com>,
 "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Brent Lu" <brent.lu@intel.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <d988fe89-104e-46ce-94b7-6754f2c7a455@app.fastmail.com>
In-Reply-To: <731fa66a-bed7-45fb-9187-a9263612eac4@sirena.org.uk>
References: <20240807080302.2372297-1-arnd@kernel.org>
 <731fa66a-bed7-45fb-9187-a9263612eac4@sirena.org.uk>
Subject: Re: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 17:09, Mark Brown wrote:
> On Wed, Aug 07, 2024 at 10:02:27AM +0200, Arnd Bergmann wrote:
>
>> From what I can tell, this was unintentional, as both
>> sof_ipc4_prepare_dai_copier() and sof_ipc4_prepare_copier_module() make a
>> copy for the same purpose, but copying it once has the exact same effect.
>
>> Remove the extra copy and change the direct struct assignment to
>> an explicit memcpy() call to make it clearer to the reader that this
>> is what happens. Note that gcc treats struct assignment as a memcpy()
>> that may be inlined anyway, so the resulting object code is the same.
>
> The effect of the copy is to ensure that if the function fails the
> argument is unmodified - did you do the analysis to check that it's OK
> to modify on error?  Your commit log says "the same purpose" but never
> specifies what that purpose is.

There is always a chance that I misunderstood the code, but
yes, I did understand that the idea is to not modify the
parameters inside of sof_ipc4_prepare_dai_copier.

The only caller is in sof_ipc4_prepare_copier_module(), which
achieves the exact same bit by doing the same:

         /*
          * Use the fe_params as a base for the copier configuration.
          * The ref_params might get updated to reflect what format is
          * supported by the copier on the DAI side.
          *
          * In case of capture the ref_params returned will be used to
          * find the input configuration of the copier.
          */
         memcpy(&ref_params, fe_params, sizeof(ref_params));
         ret = sof_ipc4_prepare_dai_copier(sdev, dai, &ref_params, dir);
         if (ret < 0)
                  return ret;

So when sof_ipc4_prepare_dai_copier() fails, the caller's
local 'ref_params' structure is no longer used anywhere.

     Arnd

