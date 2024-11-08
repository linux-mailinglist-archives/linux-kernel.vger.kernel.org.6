Return-Path: <linux-kernel+bounces-402289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B319C25E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C583282486
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A431C1F00;
	Fri,  8 Nov 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="O0fPdLDr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EA366;
	Fri,  8 Nov 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095630; cv=none; b=X3cvV/yn15hEsxX9qZ5CyJPhpJtchr0M6YpMDb6cTDwcJXzdQzfxG30j+xyNv8t/LcWT0tHoMAUyrEYdaWqqL9UuXUZvXysUcskg+VatJ/yxQevGt9YmGMhlCT4/5UyGQ4zjZ6uLTsEGVxnjWCQ9VVy/Xhiq3pcFplXZtAjChVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095630; c=relaxed/simple;
	bh=/oidlqrNQ3l/EFyWYvYeFCVPhQshkZt+TNAXopXR2wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOio4FISvcR5t22CunNfVF9PMybSJd6wqNvdvgEkO+Si9/65m8r+Q5HhRxtDQ33Rl36sA0MBgjZsJAou9fKJ79BwPPD4shrpKX02XonNMest6X1jBPFN0x4CidSSNBzfM/G2pGQ/KHodrWOr1i5ghHBYPnToZABCFvuasxF3e6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=O0fPdLDr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F50542C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731095628; bh=9XYDoCikxKxiTtZaLvgudI4lTOoyfuMFGD8Ozfp2uzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O0fPdLDr7Sr5d3Vt751Gl4Z+gyOPfl/3/onxyN5hF6oyzE8pwyb5JwDeyFQY4a4FG
	 0g+bAicQEr09BOgZp+sAtHBViOytAiLdoEtUvQwuwNoZJjQIwIDPF+1zNHsaFrwAz5
	 KB4bnLFCNiQJDYAcvu6yZUPEjBsXDIyXzYrxEYEpEgcw1XZIXWG0aCv12o+aDf8Lhr
	 7kWZrzYtNJhsTaHm9BL+gw6zDccCbk4PwhootnZ6rME/bEy0R2I6iWh+bX5woHmkCZ
	 0pf5K2Tfe9ACV4M3xnCKeUJz+Owzqy6yTT4MHGnLIrvlemw3Zx0ZBHsUb9mO9expsR
	 lcYgh2YNCbjpQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5F50542C17;
	Fri,  8 Nov 2024 19:53:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: machine: update documentation
In-Reply-To: <CABCoZhCpMVwA5qzUL4NcSkhuW3+FnD9pH5Grhic3AWrrqX3g2w@mail.gmail.com>
References: <20241108192413.10751-1-yesanishhere@gmail.com>
 <87y11twmlx.fsf@trenco.lwn.net>
 <CABCoZhCpMVwA5qzUL4NcSkhuW3+FnD9pH5Grhic3AWrrqX3g2w@mail.gmail.com>
Date: Fri, 08 Nov 2024 12:53:47 -0700
Message-ID: <87ldxtwlh0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[I suspect that your HTML email will keep your response off the list -
don't do that.]

anish kumar <yesanishhere@gmail.com> writes:

> On Fri, Nov 8, 2024 at 11:29 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
>  anish kumar <yesanishhere@gmail.com> writes:
>  > +In the above struct, dai=E2=80=99s are registered using names but you=
 can pass
>  > +either dai name or device tree node but not both. Also, names used he=
re
>  > +for cpu/codec/platform dais should be globally unique.
>  > +
>  > +Additionaly below example macro can be used to register cpu, codec and
>  > +platform dai::
>  > +
>  > +SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
>  > +     DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
>  > +     DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
>  > +     DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
>  > +
>
>  This will not give you the literal block you were hoping for.  Please
>  actually build the docs after making changes and look at the results.
>
> I was not hoping for literally code block but rather just a tab. I just p=
asted Bagas comment as I
> thought it is better way to say that about the change.=20

The "::" you added above introduces a literal block.  Yes, that is what
you were hoping for.

jon

