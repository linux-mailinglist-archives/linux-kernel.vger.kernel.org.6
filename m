Return-Path: <linux-kernel+bounces-292195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B34956C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E00283BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64816C6A4;
	Mon, 19 Aug 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLMeI2yc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A89D16B74D;
	Mon, 19 Aug 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074724; cv=none; b=EqQhtxT+sHmv1/nMbyDfiLexOBf7C4ICTa4GoJ9Jm97sU74ykV9OEE2cGG3uvC6Heni0iBbANFfFvt0HyJSoj/whdprypD5/0NdgSnhhTdhkerz6j/HJALqlV9296kjKOmuVmfAavLWABoG6SPNFTTrWUh3aU4aqX/5AVQcT4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074724; c=relaxed/simple;
	bh=HnXHpBWJd9U3kd3NxwXtSvzJXtDDSPMfs14A0MtrVYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFJdknAeck/31fsukV7wX9iZXsoew190a0GO6fRuT7Lc9NN8tm/GSlcaT95wQwtS33nyB2jWxTsvoYOWl/UoTZEk/9Faq+qOKffDozO0Un0Q9n80icNItdwmw0tZrdj5FF6SeBT+RwCQ2dN2JL5AXoTUWJyUxYfmC29rDIwONGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLMeI2yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FDC4AF10;
	Mon, 19 Aug 2024 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074723;
	bh=HnXHpBWJd9U3kd3NxwXtSvzJXtDDSPMfs14A0MtrVYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZLMeI2yciU1w5rR1VogeDAC7sDNpYgWowCrd0sanjrciwnzGUMB5fVEsC2VJocG4O
	 4BH5/klMMGTj4eDhfvNzXwMsa1CW/WsdD2Bo0OjX5HH3BG4X0PvITRubRPDmSz7sAL
	 wqVf+NQ++vO7yeXpAjkmToVDbHajmK4oKYQli4RiVviLx8HGyjifxN+ngmwMteetbx
	 NewD8eAI7Z175LYGgeXzuGr1imTSwg4qYsEsNh3orjo3O6Fp3Q1qV7bBgG4wiD/Nj6
	 o2Ym3/Mv7g8484QiLuH5F6P2E4EwAQtxBmplhoA6gW9lB8WZmVb8xF8PbwqqWgK21G
	 BFRiTB5UAVO3g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so48732901fa.2;
        Mon, 19 Aug 2024 06:38:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeaZuGlR8JaCZ8X1aQpKxZfvT9TJPleo9a05V6UIvgDBM/IIso/kwYcnhi9bPc1smTG1pPhh6XLWbEurYtn9emye5Q5oJifoQ56teLSv9+Nu4TBMsfNpGh1vGupktRRYj2/9Iy5rGkUg==
X-Gm-Message-State: AOJu0Yyh9KHvMHFSYV9yPl03sJ2FXwpYtu7qy2mKU90unI4zRV95o3Ex
	XTF07ZlnL4CIrRoZNwSpPPfWj5/yfA/nlrA37K2EH2stq2M3jf2pLNFjpfHiKHucXi6S7kWqpdF
	5UeDBrZb2VNA7Ub1jDK7dcdPkBA==
X-Google-Smtp-Source: AGHT+IGa3K9gt89RK6o4xZ8EoS40LEXM1QdCH0OX9oHmervlw6KfmM/3z5RbDfsnlV0DTeLX2ktRdryZFtLoXNizcHE=
X-Received: by 2002:a05:6512:6cc:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-5331c6e400fmr7761393e87.55.1724074721988; Mon, 19 Aug 2024
 06:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP> <20240815140046.GA1603296-robh@kernel.org>
 <Zr4Sze8ea3q4d+Xk@standask-GA-A55M-S2HP>
In-Reply-To: <Zr4Sze8ea3q4d+Xk@standask-GA-A55M-S2HP>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Aug 2024 07:38:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZEAOgEacGmfoJeuNpTpy9oXnG1ghJhAZP8Gkp700ynQ@mail.gmail.com>
Message-ID: <CAL_JsqKZEAOgEacGmfoJeuNpTpy9oXnG1ghJhAZP8Gkp700ynQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: sprd,sc2731: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:38=E2=80=AFAM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:
>
> Hi Rob,
>
> [skip]
>
> > > ---
> > > Depends on:
> > >   - eFuse YAML conversion: https://lore.kernel.org/lkml/9fba73ce66f1f=
3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
> > >   - RTC YAML conversion: https://lore.kernel.org/lkml/ZrBzmQI0IAL7LI3=
e@standask-GA-A55M-S2HP/
> >
> > These either have to be sent as 1 series for 1 maintainer to apply (Lee=
)
> > or you'll have to wait a cycle for the dependencies.
>
> I've had this patch sitting on my harddrive for over a month now.
> Both of the dependencies have been sitting on the mailing lists
> pretty much unchanged for about a month as well...
> Also, there are technically more dependencies, but they're in linux-next
> already, so I didn't include them here.

From who's tree? That affects who can apply this as well. I guess
those are other child nodes.

> Just wanted to get this out to get some feedback (and hope that it would
> move the dependencies along).

And now you have.

>
> [skip]
>
> > The preference is one complete example here and drop any partial
> > examples of the child nodes in the child node schemas.
>
> I can add a more complete example here, sure.
> But I don't understand the point of removing the examples in child node
> bindings. Seems to me like all that would do is provide less documentatio=
n.

It's not less, it's just 1 copy instead of 2 (or more). The problem
typically (in the old bindings) is that the parent node is shown, but
is incomplete which is a problem once the schemas check the examples.
And if some of the child nodes are required by the schema, then every
child schema ends up with a complete example of the MFD. And then when
we have to fix something later, there's more places to go fix it.

Rob

