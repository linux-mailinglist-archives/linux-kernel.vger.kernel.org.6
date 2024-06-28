Return-Path: <linux-kernel+bounces-234023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDD91C109
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF07B217ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2C1C0059;
	Fri, 28 Jun 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSJextqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27BB645;
	Fri, 28 Jun 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585195; cv=none; b=eLAdzO9Ue6RLqA8p2QTvGbHsRoQaSYiNLBR4pWxFCb1idgeVN8OHJctic/57nPW6obFCpuquPB1M37CjcHKx3V4saFZt3CUdg50hWJsq1ttu370xBcRBrGf6giJKBp8RMVf2G3JB9d4MFTRAt4ayaemhUBBPXa2cBb6/gbwhRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585195; c=relaxed/simple;
	bh=WyJTOIt7cxoBsyCF9/n3lzkLNe+gMV2BR/X+HP7Nh14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOcsuv7BknlxorCqltO//Cojxhu7hr5QL2NNU0BIuddn+uKovrtqfWaz6g3V6xrlzf+K6vVEv9jVIWN6Sesd9rGk+kg87uYnML4uLulV4P8eIPc8P0BNcjvr2HcY9KOFFQDQdSArvbZDTXE7J6TAh3FE3F971231YmK9gZr3lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSJextqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014A6C116B1;
	Fri, 28 Jun 2024 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585195;
	bh=WyJTOIt7cxoBsyCF9/n3lzkLNe+gMV2BR/X+HP7Nh14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kSJextqCb8VPmwyeeBKoJucKrv515A2ecPmjbGI2cblgalwPUGsPGjOdMtbTUNAY0
	 RbXkfbKwefn8wkE+QiIVEElnQFpWrcrPXAMpAvxt3ygFXbeUAsvJs9m1E+8EYxIrQj
	 1DI+Wr82ufbhIGLLhss6Rz66piDafzFITIOiFfOi5mQkEK9jAekDijIKsZovUA213+
	 bmY3qB7At3HgJ43Rgy8WvRpHYyS595Wt7n4yvpJmvwTJNP1EqiFYd4fOq7Rp5WTn8b
	 JV0IBCk5zMaA3q/Op8Tp7HrLEBIfZEFEl3kj4/GsZrVjcQgySwe9Tph9GYSCYhCdfb
	 5RvjOZNsGjt3w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63bce128c70so5982737b3.0;
        Fri, 28 Jun 2024 07:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVkZ9ITFfn4P3ybDDAXWSx9K4T5EHDXnGGqmvNZIFndfVUXLie5J52Fzo0QhKHpoPswwermF61sqQGoA730tX/UENaDV8T/Z6g41X8y6MLw41kuXgaRPFTzM1aAe+yDfrm67P7Z1ts4Q==
X-Gm-Message-State: AOJu0YxpegKmdseQ6Pr8PWC3dCCOAQr5+cQ5rAxoHOZB6S8/4eduxT6x
	Cg9lxZB+5e/EwlKy9naslrN+Wx8N5BJnAMeoY5uoKAcl7Pcq/EnL1yzsMPrZYd67432xgD74+s3
	IYqCADDxLP+K8t8Hy9906rplmGw==
X-Google-Smtp-Source: AGHT+IFU21dt8LrHcxEjSvfyuAYkAPL8NoSPX57Ogw11Hxuy3RaXgmL/H8pjad+U48hUpOLdI/HW0KJwJNHfNteQZ8o=
X-Received: by 2002:a05:690c:397:b0:62f:19da:a53f with SMTP id
 00721157ae682-64af0532705mr11197707b3.0.1719585194209; Fri, 28 Jun 2024
 07:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org> <20240528191536.1444649-2-robh@kernel.org>
 <20240602160020.azbf7pytiu57vwo5@bogus>
In-Reply-To: <20240602160020.azbf7pytiu57vwo5@bogus>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Jun 2024 08:32:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLE_KKEYQQc098vVDVopSD=_7ESC8qWVFakp5fZjYH1nw@mail.gmail.com>
Message-ID: <CAL_JsqLE_KKEYQQc098vVDVopSD=_7ESC8qWVFakp5fZjYH1nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator nodenames
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 10:00=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Tue, May 28, 2024 at 02:15:32PM -0500, Rob Herring (Arm) wrote:
> > With the recent defining of preferred naming for fixed clock and
> > regulator nodes, convert the Arm Ltd. boards to use the preferred
> > names. In the cases which had a unit-address, warnings about missing
> > "reg" property are fixed.
> >
>
> Thanks for the cleanup.
>
> Do you want to take it through DT tree or prefer me to take it. I think
> I have one another patch from Krzysztof for Juno DTS IIRC.

I *never* take dts patches. Please take it. And I think you need to
take patch 1. Not completely sure, but I expect there's some context
dependencies.

Rob

