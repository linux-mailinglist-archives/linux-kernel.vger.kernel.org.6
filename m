Return-Path: <linux-kernel+bounces-315124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495A96BE4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1960B26EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB61DB925;
	Wed,  4 Sep 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJsZFz5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889951DB553
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456036; cv=none; b=m5hPXl0b5IIH3SU/Nt5evaWmBy/4hmi0OTaLr9zQTHlF2cYtlh6/FuJvCBZWqKG3BYxnr83/APlMNOa4x+uFzkb5A8rzsNW6/tgk9JKSYn31EQOlOkGvlKxpwE4pniuYfx3XsasaR68oHWDEYxI9DHgufzX6NWDBeQ5McdIaqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456036; c=relaxed/simple;
	bh=FKTa0ccBW+t0sOOH3+Vm+CFDwDQZN6PnitaKA9ZtHh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftxP8ggc8klht5Z86TSw4IDZI1lVwE+oBtUmHM6P+WAqJ2G6iiBrVadlp1XJYuft9PXh+/TxkwES1NnzOsnX0aM4ocygbt+wT+kuxswvwoZpNmN+Q3clErxO0bCAqu7C63sPWmn2CZainhejAOBmJYGMGiM4aGIjs2U8hZRFH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJsZFz5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8B8C4CEC2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725456036;
	bh=FKTa0ccBW+t0sOOH3+Vm+CFDwDQZN6PnitaKA9ZtHh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dJsZFz5cZ2GboF7s03ho1Ecz+Yi9e8oGILj7KXJKAvMnpgwvmitKZDO7scHUmuQdz
	 t1RpzCah7bcszWJuEd6ZqYSUZb9bw3t/GfMv2u1P34IcFB4Eg41Us0GzKNze15uu3t
	 7BvuMVtsYHBRWhJe/F9gT0sZwBlCErfuby0YgCEo1HsJHLC6CxtTvsB6b2rm36WxKj
	 XxBOq2Gth7+FnMXSh0HrKznHlvBykfcwtYCUmMYK3Koqxpm58JW8vJdMSaClDo4Zcq
	 x7XDSTaSeWFrIx7mbHc7qYTEroH5/Nde5obx8LtdBWBV17eeE4q66ctsRzkKC88Hv3
	 XdTdqRzE2nusQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533496017f8so8702758e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:20:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwbfljcenCNe4zZNdmVRcJAwvIt5XoJU6jkeYLgzxS3YjYj7VM
	kfrzdYB9cShRmmbf3vWvqp339FVM+DtC1ENzZ6OBfUT+N0zZPli4v9Q/GStg+2H2X3QmTwXycRr
	LNg5uEx0UWfSNOK9ja0xdXhjjwQ==
X-Google-Smtp-Source: AGHT+IHK8e4JjGyLp+znR+KIfvV/9NaWZnXWqTXb2jlvM00CsWKxewgzFAXff02IqZK/Pi+koiCWcacA6IcP4YOtYnU=
X-Received: by 2002:ac2:4e06:0:b0:534:3cdc:dbfe with SMTP id
 2adb3069b0e04-53546b2b9f3mr10534108e87.28.1725456034436; Wed, 04 Sep 2024
 06:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201608.1840977-1-robh@kernel.org> <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
 <CABb+yY1W53SJ1r1yspQpaBjMH+JPC89yBM7G9+WoewSJgjD+Mw@mail.gmail.com>
In-Reply-To: <CABb+yY1W53SJ1r1yspQpaBjMH+JPC89yBM7G9+WoewSJgjD+Mw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Sep 2024 08:20:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFT1y6+LkVUOYhGqTN=1jYescxTbSFGLfu8zrO2ijLSg@mail.gmail.com>
Message-ID: <CAL_JsqJFT1y6+LkVUOYhGqTN=1jYescxTbSFGLfu8zrO2ijLSg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_match_string() instead of open-coding
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:05=E2=80=AFPM Jassi Brar <jassisinghbrar@gmail.com=
> wrote:
>
> On Tue, Sep 3, 2024 at 2:18=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Wed, Jul 31, 2024 at 3:16=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> > >
> > > Use of_property_match_string() instead of open-coding the search. Wit=
h
> > > this, of_get_property() can be removed as there is no need to check f=
or
> > > "mbox-names" presence first.
> > >
> > > This is part of a larger effort to remove callers of of_get_property(=
)
> > > and similar functions. of_get_property() leaks the DT property data
> > > pointer which is a problem for dynamically allocated nodes which may
> > > be freed.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/mailbox/mailbox.c | 22 ++++++----------------
> > >  1 file changed, 6 insertions(+), 16 deletions(-)
> >
> > Ping!
> >
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Don't need an ack, are you going to apply?

Rob

