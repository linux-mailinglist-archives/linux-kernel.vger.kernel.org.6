Return-Path: <linux-kernel+bounces-347331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42698D130
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0529A2822D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48881E633B;
	Wed,  2 Oct 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DeYiUKwu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96072564
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864854; cv=none; b=ZFZViKNX0VfEFnZsssREh7oDfGlikm7+sT8LNKAnPB1kzlPlGl2V+mZDIimftEffpjuM8dOYycShDXET2a7flsssQ/+qlIlX7AsH4AtCnjYQw+Dws8BeaSuI5zbeAa+4gvQFpnfuuQLz52P3vIQmOSm+xfVV+rxM8j5rEkjs1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864854; c=relaxed/simple;
	bh=QhP8dAfjWNSaYUmoZ4flnUlLOBgW5BBKq7Dys4CJcPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz6ZBr1xueLu657zhIc7ly6EuiUFRIWfnO3XuOsW9AhG440sA/eRlP8pKWJcOYt9CuNDh3g9OPPO0YyUdB20rRIq/wVR28jaRhPoHueguZyt/4eI3nu7VptvmMDhC93zYH2Bhv2sQ53/JdWztKmuIybvMRxNNl/vfSiWRA9NZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DeYiUKwu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so5493167a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727864852; x=1728469652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhP8dAfjWNSaYUmoZ4flnUlLOBgW5BBKq7Dys4CJcPU=;
        b=DeYiUKwu4J9nNTYpb+DB82MvLkFxjyeCiy38RxltVFFjrbtL7H3zTECTXjYclDDXem
         Cyw9/3sSiBMHOky+zQys3wFRkU3jB4oyy5d2Y+eeFk0/LfPixXihAFR7h1kOr0rgzoyG
         ldndZjwlrtXJ2VMAcilNAC6NezVqZNgcKGiVDbsUpvYVbxuryef1TXSS0xxV9hG0ntOb
         VNNvYP4oYcoW+bPxkkF/Wh+RDoK16+/XFabxe9CWaVUorW/4J9cX4FxJJGMHa8rQWFCR
         62CF1t7JPjnXhs+EoQNb/941Lr50+ia5f31cGt7Gad7VdDtNjjO8Po7OvdFojsBCZv/H
         BUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727864852; x=1728469652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhP8dAfjWNSaYUmoZ4flnUlLOBgW5BBKq7Dys4CJcPU=;
        b=lVaWiKsGFW7QwjqfOot2plRYUhIG2SE9gZjWQ8wFS8wu/u2jKs6xy6tslhkZLk8L8U
         h0sv3A6SRSZrFxayCyBEa0n0KF2/m6TYZ9i/v1xL3YrAIgw2ii+c455eX7MZi5rEV2XC
         ocu6Gxj2BXt6k4fE25RcJvTiuSpwryCh1dhZcexfKgGGgSVy//vejK95dtGiadY9XzYe
         1Hyhp+jiwbW25hxSKOc18FqnFHMF553oKLrVuowqkc1ay1hK0jJuoXp3V1IvwPB1SNZt
         F0tGTwBHLvf6JjY/9SmUQyZBi7bwNxeWRUpU3umNrJJjAmOEMzr6pzgBgtxIlqAieCII
         6u4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2X8riDz0Fb4Fbw99eYAUjNIN13HNOpQdrymh+cJ8wX6C4KFN6bZSOnbb/RMpqd1PHvm7um664EckiJ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEO4Z9ICXhxbCTtRWc4E/iW21+pUdqOnbn6XUwyXn2jpz42+0
	PbETLOASlZyjFu1mdRr+SJGEjF0nL+tyGB5fGLL/DcMNmrLtrs9cz+3qM1Wuz43/laV5bv1AYZP
	Gb/MmSKUyjraS3R1fF4hnIApUB9oSdNaBgapcqw==
X-Google-Smtp-Source: AGHT+IGiI611bF0LSNL9d1Wo5FWjadPESUy6tI49+wZGoCskFJasqOAr97AM7LwOhTLXYHQPCWHSierz4rQt1kIywXA=
X-Received: by 2002:a17:90a:ce84:b0:2e0:788f:6253 with SMTP id
 98e67ed59e1d1-2e18455899fmr3665606a91.10.1727864852193; Wed, 02 Oct 2024
 03:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com>
 <20240919094339.2407641-7-billy_tsai@aspeedtech.com> <CACRpkdbFD9CiqVwQ5xxZ9SfQtVvDJGCr=8spxBG4u-JQ0PKJ3w@mail.gmail.com>
In-Reply-To: <CACRpkdbFD9CiqVwQ5xxZ9SfQtVvDJGCr=8spxBG4u-JQ0PKJ3w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Oct 2024 12:27:19 +0200
Message-ID: <CAMRc=MdvV7Z2yPpoR9mXLH6UCF5uA=TbkC_qUSj=akP_09M0WQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] gpio: aspeed: Add the flush write to ensure the
 write complete.
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com, Peter.Yin@quantatw.com, 
	Jay_Zhang@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:18=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, Sep 19, 2024 at 11:43=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtec=
h.com> wrote:
>
> > Performing a dummy read ensures that the register write operation is fu=
lly
> > completed, mitigating any potential bus delays that could otherwise imp=
act
> > the frequency of bitbang usage. E.g., if the JTAG application uses GPIO=
 to
> > control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the applicati=
on
> > sets the TCK clock to 1 MHz, the GPIO=E2=80=99s high/low transitions wi=
ll rely on
> > a delay function to ensure the clock frequency does not exceed 1 MHz.
> > However, this can lead to rapid toggling of the GPIO because the write
> > operation is POSTed and does not wait for a bus acknowledgment.
> >
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>
> If this applies cleanly on mainline I think it should go into fixes as-is=
.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

I agree but it doesn't. :(

Billy: please send it separately and - while at it - use a C-style comment.

Bart

