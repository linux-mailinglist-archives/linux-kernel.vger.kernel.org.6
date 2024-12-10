Return-Path: <linux-kernel+bounces-439549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E949EB0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3169188C273
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD861A08A8;
	Tue, 10 Dec 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwO5/JkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36523DE98
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833997; cv=none; b=JMmpoX1bsEHGWo24cN5mGk2LjceHeFPJVR+S5E1csnU/Hoi90YlLdCzqeW2sps5oByNV7QBH9AHWhVbJxY9qU5kmzY7D10av3K/0DIRiyYsMG8OLAr1VLoWyCcLMQSidubJ3gH+2cpv3hLTD0ktIE4wdl7rwssJxqO3LLOG/ovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833997; c=relaxed/simple;
	bh=1refFvJwpXu7jA/2rpx6c/vVbYKQgz+ySB3pnIvROVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaZknT16crnwHc4jdG8BkTCKAIyc8mY78G4EKR5GNkXVkZgNtgILd2F/y9rdIvZT4Ep0GhnOe3Olo4NrBRpvi1YU0ECb8pNb3Q3lfYgzyifH/q82cpAiatzOfVxibGc/uYVaD1RB3aboOoPDi2WSVTNiLsD+1zUPNL0YClUBvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwO5/JkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7169C4CEE2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733833996;
	bh=1refFvJwpXu7jA/2rpx6c/vVbYKQgz+ySB3pnIvROVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XwO5/JkYzVBVsT60Duxt5kmriH8Hz01MQOwKEZmvfw+FZohCUQ+i6ubEUIVEEpNoR
	 UQ5VpkiAJYYs/Z1NB+lpdB62wkwNOBh5680RNJekH5wXpmELcdP+43yeS3WgoXwHpZ
	 QEPg+piyCmf6USORWWqvgEWUr6RUWNHz2P8Ya4TFssKy9taahddXx3eVCOzcsYiB5v
	 idSgagR6DB6r2F6If/gzca81IRbYTaqaVqYZXExy3rMX2Y5lG7NTvJE/1PweuRPDOe
	 p1+xn/tEboRbrm9G4IF7NCq9P5KQGcp5fg9uAbnqmtScc2F1SDwqm8m3frE+MpJnqr
	 ga9S09nvqkzCQ==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e399936829eso4265900276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqJBQ+I5rT3e8XjhN6Dj01egd8bnuerhfVUSQZzIXg/BOn5GubFIZiLIB2uMOJvtBs681pZ7ufiYvfBpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj889c4D+hoNngI6+o9WUEivqziZ2xWmgT7PVmzUKQPGbMo8yW
	8kthFnjSKGVVGWm8IVW1iln9qWIlxwfzP1NvFnsj0kKhGnQ89xNutTTjHgPcUglSp4CUpYLP/gx
	MtnFKm3MK/IuQobPr18OMtnAkWw==
X-Google-Smtp-Source: AGHT+IGfifeKEvGSM+06XazkH5EHRUTKQdda/atAq+zte6tidcn8zgrZWbwY3HWGpJsnKZL/D1BEtaO1fQoNYCYO9kc=
X-Received: by 2002:a05:6902:1106:b0:e38:9bce:241e with SMTP id
 3f1490d57ef6-e3a59ace56fmr3693237276.10.1733833995888; Tue, 10 Dec 2024
 04:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204000259.2699841-1-robh@kernel.org> <2024120450-jogging-duty-fad4@gregkh>
 <Z1eBotg2DiaXLWqn@google.com>
In-Reply-To: <Z1eBotg2DiaXLWqn@google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Dec 2024 06:33:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5cQHqoJ9wAgt0moU94Bddgsw+Q3TEWDqQ+-rryJPS1Q@mail.gmail.com>
Message-ID: <CAL_Jsq+5cQHqoJ9wAgt0moU94Bddgsw+Q3TEWDqQ+-rryJPS1Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't match device with NULL of_node/fwnode
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 5:47=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Hi Greg,
>
> On Wed, Dec 04, 2024 at 10:37:06AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 03, 2024 at 06:02:59PM -0600, Rob Herring (Arm) wrote:
> > > It recently came up that of_find_device_by_node() will match a device
> > > with a NULL of_node pointer. This is not desired behavior. The return=
ed
> > > struct device is also not deterministic.
> >
> > It's not deterministic because a NULL pointer will cause that to happen=
,
> > or for some other reason?
>
> It'll pick the first platform device with no of_node. That likely yields
> something very wrong, but doesn't produce a visible problem until a
> caller does something with the result. Commit 5c8418cf4025
> ("PCI/pwrctrl: Unregister platform device only if one actually exists")
> has plenty of explanation of what really goes wrong.
>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > It would be a bit more efficient to check this up front before we
> > > iterate thru devices, but there's a number of users of these function=
s
> > > and this isn't really a hot path.
> >
> > Yeah, this should be fine.  Does this fix a problem now and we need it
> > merged for 6.13-final and backported, or can it just wait for 6.14-rc1?
>
> It's a preventive measure to help head off future confusing bugs. It
> doesn't need expedited merging or backporting.
>
> FWIW, last week, I also cooked this change locally (+ the ACPI change;
> and a kunit test for added fun), before I noticed Rob submitted this
> one. If you'd rather, I can submit my patch series. Or I can submit my
> patch series on top of this. Whichever you'd prefer.

If you have a kunit test, you win. :)

Rob

