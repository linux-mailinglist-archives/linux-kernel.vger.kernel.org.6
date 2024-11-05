Return-Path: <linux-kernel+bounces-397264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E19BD98E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7881C22860
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8A216204;
	Tue,  5 Nov 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2BX/N6x"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95F1D2B34
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848632; cv=none; b=WWRUEnTWnAsEjIoxrDO1tcODuFghvq7R2IFqIac9SYsPI+u8JOWiazZTltU4CJGaHyb4L7leRwKgr5o5CGFheGeR1lo4WlW6JBW3uZTTNB+WvTph4sFybxonfWDT/QKEWINL8vCz1TjxZWuIj8rS6VRo/KvksXrwdaYAKQLWSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848632; c=relaxed/simple;
	bh=5qt7Ibi85FEWHC/bfzY0vxU9v8/ancpuXt9yo6HPuAg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WMWuP3IBvHU4hwz2aq5b4NqDdithE0X/ZKOg3pnZW0axkOK/N6+VijrBFYFMSuIBc6JRWocXRrsEG2+PziXYdUucVbd/f8d/FGaVBtkKLYGdFmmdhmOquVeyHw/t1o+5QDMQn/aekSymiy97PWl4+r6ZLApH/agd7CluoRN4Gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2BX/N6x; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C19E61380459;
	Tue,  5 Nov 2024 18:17:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 18:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730848629; x=1730935029; bh=A1QeUDH290eQC9bcrM//999oKdePIO7D6OZ
	jqggZPbw=; b=K2BX/N6xrboJwgxrRjmIiQieOBmaGLpnryrCKIXAQo7KEM4D/go
	KWjCXJrnVJrnySK8u9/WhlfJRnFrVT0ifOBT1lrwuU15N3Aja8+GSyhjs3yfUeoO
	xgQ0EcYjKzSNao2zp6v3o1jBbHfnp3bVA8qXlsmwsRbmV4CU9W1YNTPB+PXBPXly
	h4t4uMaqyuPyvYsySYtDUK+DWImOk/X2QfqLpnANytfaA5uLzWrcjmDrpq0qrC44
	uw+7xiSZ7p9n4NVRcSgJ7ns6onZoxp10jWwteDpyZkadq0PDjdwngh6Bt/ysPh9/
	K8d/QQRgcLUvnIuxSAMmEt55YT0BqT9JzVg==
X-ME-Sender: <xms:dKcqZzpv5gIM52Akqvm808Flsn_wxnhJSfkKHDfo5qoZjU09ghRVMA>
    <xme:dKcqZ9qTeWHP5vF_xVHBC6pFqZRo73i1AKBurHhCZzW8lmtr7aq0zlCTHkmhrCOMq
    H1VH7YDhf01pDpxs4E>
X-ME-Received: <xmr:dKcqZwMo8gueqdSB9SSExcIej_Dh-4-1c4dusdv32856b20fAuDhki6d34HsV8y1sPotAyB8MpXw2s7cKAKHOc2i3YbK1_y-q3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfh
    rhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdroh
    hrgheqnecuggftrfgrthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeefffff
    tdfgjeevkeegfedvueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvvghrtheslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepuggrnhhivghlsedtgidtfhdrtgho
    mhdprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dKcqZ24ntWdYysEgplidJS7Md_ie22q6wUY9wTDSafa3LXJalmqR1g>
    <xmx:dKcqZy5iOuP9XkLpgKotSPCktkB6pwXKA5phUyzoAZ-2xk1blDIOOQ>
    <xmx:dKcqZ-i9Xxvt7NFq3jiT5KEaRvGnFzAQXfBFBbbA44iKqcbiNm-cWg>
    <xmx:dKcqZ07d32B7k7d4YqLTJv-sBJFxzqOUHhYyeHY4OCmTTvfKveVFTA>
    <xmx:dacqZ92Hhkp5ZBmk0yB5PSX-xrqtpcmaRH7tO8EoWjT-M31JTquWDeWu>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 18:17:06 -0500 (EST)
Date: Wed, 6 Nov 2024 10:17:17 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Daniel Palmer <daniel@0x0f.com>, stable@kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mvme147: Reinstate early console
In-Reply-To: <CAMuHMdXR6gN44MiE3Nc-bU6u92_RA2PWx37ndBKA7AD+gKErTQ@mail.gmail.com>
Message-ID: <d321d30f-df85-f6d8-69d4-4dfb68cb9b93@linux-m68k.org>
References: <b6112556472c657762f064ec5328f153e3ed03cd.1727926187.git.fthain@linux-m68k.org> <CAMuHMdXR6gN44MiE3Nc-bU6u92_RA2PWx37ndBKA7AD+gKErTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 5 Nov 2024, Geert Uytterhoeven wrote:

> > Cc: Daniel Palmer <daniel@0x0f.com>
> > Cc: stable@kernel.org
> > Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > Reviewed-by: Finn Thain <fthain@linux-m68k.org>
> 
> As this patch differs from Daniel's original, I guess you want
> 
>     Co-deloped-by: Daniel Palmer <daniel@0x0f.com>
>     Signed-off-by: Daniel Palmer <daniel@0x0f.com>
>     Co-deloped-by: Finn Thain <fthain@linux-m68k.org>
>     Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> 
> instead?
> 

No problem.

> > --- a/arch/m68k/mvme147/config.c
> > +++ b/arch/m68k/mvme147/config.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/mvme147hw.h>
> >  #include <asm/config.h>
> >
> > +#include "mvme147.h"
> >
> >  static void mvme147_get_model(char *model);
> >  extern void mvme147_sched_init(void);
> > @@ -177,3 +178,29 @@ static u64 mvme147_read_clk(struct clocksource *cs)
> >
> >         return ticks;
> >  }
> > +
> > +#define SCC_DELAY do { __asm__ __volatile__ ("nop; nop;"); } while (0)
> 
> Please keep on using a static (inline) function instead of a macro.
> 

Will do.

> > +
> > +static void scc_write(char ch)
> > +{
> > +       do {
> > +               SCC_DELAY;
> > +       } while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
> > +       SCC_DELAY;
> > +       out_8(M147_SCC_A_ADDR, 8);
> > +       SCC_DELAY;
> > +       out_8(M147_SCC_A_ADDR, ch);
> > +}
> 
> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

Thanks.

