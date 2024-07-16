Return-Path: <linux-kernel+bounces-254405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B59332D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AA0B2371E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0E19E7D0;
	Tue, 16 Jul 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQof89cL"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418B182B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160968; cv=none; b=bR18+ZZq+OZAvaRfAxjcXwvfNMALmoB3llU21PuBI8j65WjX2lWim+uqfT6mWAww44F+nKntKS1mI7F06+MH5xnhuyFBv5tLzxbOFjScfAryQHapgweOHXJyzgvBLKrcKplybe1dBdEU76C2IngaB90R5TpikRzHUrnmevHNpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160968; c=relaxed/simple;
	bh=dnaPIvyley+tVm36xG7i3GtKaPtw/WjvFph4yvfeYCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgU3XucwL9g7WcPPjrlWXxKebeayuqi7e74XkpX1Vtv6exPMVgNtHVTjNYOJaS51WZ9Pa3Th+xhwroYbG9sWFh2y+bqQC70PmD4Es6geM+Imp7lNp5D6XURpTsLmFkrhoz5sbPrVSFhcyssSzzk02hoPnDd8Z1WN7O/hl8o8LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQof89cL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65cd720cee2so53960107b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721160966; x=1721765766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4r5i/GL7gQrxXPMEHJ1P9sQCgQu/V6Mo3LoCvPIMgzo=;
        b=jQof89cLIte6j+oss7wqdGufbKUl+scNQFr74/D7L0QUwCwX4/0Mjkx9rlZ7JBvk5E
         n3J7551tkWoPRGwcY6ZjrDKhpTyoV44kgc0ydt3bKkjTMJHl9MJFzfoHHrgnAUUyjLjV
         fbOBCKxQYS1w9K1V2BLrxF6gV3+h9PJ9wQquH3T8otA3j6brhyxu0nFMyLQT8OGbE37F
         4EBBRHCv3ytGmLqhGh7f9JG7U70CRuoWBXZdI/VYihLdqYmxtAd0fkP/oOr4in8lRWBr
         MkP2OV3s9H1je3PauVoL1Vy+7dXa2SGajaOUzRCf04pqPdrQaW45zUI6auM3eHSleEu+
         aPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160966; x=1721765766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r5i/GL7gQrxXPMEHJ1P9sQCgQu/V6Mo3LoCvPIMgzo=;
        b=IbKPXkXCSnFBi3mR/dIVJE3v2DlDz0g8PWRcySnUavZAcGWByQAHb5kA3FUczZdrvW
         8YtCyPtihG0wNlGzzJwzihTb/NMlvAjqLnaALC6tBoDlRt5e+edzF4VzzZ3pdmv/8TAC
         BLzdkqeZW+KwtxdDDjOIuEjfwz3hYRr+qo8SZ+klN/8aq9Bn0pn/gJXldInVRA6yVbaN
         LhIndxhiuSAoi+zrLyLO9yz35t1AR4wsd3ancdNr0E7RmFHer0nd4cfgwh7UmiZEVVid
         0QnXN1hf0WttFGVmGBiU8jaf132DZNdtCb70oTJBxcXuCxYFLqVUhv59A69hiIPlPJgi
         +8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXbsmWaa3/x9Ge+ndZuDIMTmEKqDGzV5dOHzp6WUMbLw8y1WjTrqXc35N7QoO5ihhdhTiW2FrPog7Jd7mEo2cTIvj8wwSNShz0OebVX
X-Gm-Message-State: AOJu0YyQSjaFjyWzLXusnCkIlpxP6BmXoksX4yb0ptDnL9ZzR+UE0x2H
	3cniGxI7f2F7zJVjmEkr2PmvngZzPcZ5B6BPsLYCGsdw9MqkwzopMKzHUockp/1bDdtXkawPA9U
	PZsSOsUz7AVvEisCvxCdIxujdjXGqBWWkHLSk5g==
X-Google-Smtp-Source: AGHT+IGgeeS6IJv/UGyjYLIS7MqCl7Q01RWDc3s9Js6V/opyH1mB5VO6EF6NYyVT9CRVp9JUv6NXuTvf98RvF2gZAp0=
X-Received: by 2002:a05:690c:d94:b0:64a:79f6:2f2d with SMTP id
 00721157ae682-66381105a8fmr46658017b3.31.1721160966101; Tue, 16 Jul 2024
 13:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
 <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com> <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
In-Reply-To: <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 16 Jul 2024 22:15:55 +0200
Message-ID: <CACMJSetbuZ4u64fksB26AxMxYpiB2_i5=NJefDW_aN_-aHd62g@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: driver updates for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 15 Jul 2024 at 13:59, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > soc: driver updates for 6.11
>
> Christ people, am I the only one actually testing any of this?
>

TBH it never occurred to me to test pure `make config`. I use `make
menuconfig` almost exclusively and never noticed this issue for that
reason.

> > Bartosz Golaszewski (14):
> >       firmware: qcom: add a dedicated TrustZone buffer allocator
>
> This causes me to get a new and COMPLETELY NONSENSICAL question on my
> regular AMD Threadripper workstation config.
>
> I'm getting quite fed up with all the constant complete disregard for
> any sanity in Kconfig files. People are putting in COMPLETE GARBAGE
> here, and apparently nobody bothers to test it for any kind of sanity.
>
> This kind of crap needs to stop.
>
> I think the fix is to just add a
>
>         depends on QCOM_TZMEM
>
> to that thing, but on my Altra machine even that doesn't fix this
> horror, because it turns out that everybody and their dog ends up
> doing
>
>         select QCOM_SCM
>
> and we have QCOM_SCM doing
>
>         select QCOM_TZMEM
>
> so it's hard as hell to actually get rid of that pointless churn,
> because you have to figure out which random driver ends up allegedly
> "needing" this.
>
> Are any of these actually _needed_? Because while I like automatic
> "select" things just picking the infrastructure that a driver actually
> requires to work, this all does *NOT* smell like "required
> infrastructure".
>
> This smells like random "do you actually want this?" to me.
>
> And the answer is "No. No I damn well do not". Particularly on my AMD
> machine that most definitely does not have some Qualcomm TrustZone
> thing.
>
>                 Linus

There's a patch from Geert already on the list[1] that should address this.

Bartosz

[1] https://lore.kernel.org/lkml/74947f7f132a811cc951749907b01bd25dcf23e6.1721135509.git.geert+renesas@glider.be/

