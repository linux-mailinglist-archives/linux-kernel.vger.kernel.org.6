Return-Path: <linux-kernel+bounces-418619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB99D638C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC39B29A45
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB71DE8B0;
	Fri, 22 Nov 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dViaIwAC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512731DE3CF;
	Fri, 22 Nov 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297546; cv=none; b=hJprXxAgL15+90RT5I2NvCeNxGBipy+iiWTGk9wn3HkElhHS+dSMNg02HoP5G7iPIFrBdlwr/9Yxak2TCg62HRfuiGPgr2yA07FFnHO8m02GyA1j6YVseRFQdV5y8Z40gw5VBdcn3wKiQTgBGRRUtmSRYnZkJlir9f/eY724zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297546; c=relaxed/simple;
	bh=vo5DD1G4HjAe0fJgN8P4fzE9QAvxxL7XdNWAXnMCSD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o9s/yGKPr3DRgsd8MiQItYLqA7oNEOD8o/VHfAqLybhWGfwUQWw3/WANugsXYWuyTW9v2AJDR9PMO7izxYTuUGmUcrMEgQhm1tc5af+hKJbn+3ebYpwH1AIGFFuo63V4HB0w24a4M6nV/+OcVLcx4NN6KuWX6NC67/UD2fyNI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dViaIwAC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D11A403E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732297544; bh=WPSuqGBXOdJi9AKpOIzbIVnx/Y85j5L193AofJsBr74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dViaIwACZ70Y65Lmsog2t5yeJ0Mq2lNfO3SwoYHD8C27nX8XDrUrsXAdbTK3S2HHS
	 pmo3KNSDOEgHAkxq1wf0xmpDA01ZZymg4/FS+2fcyrLoKglZNyb+CtrfOxg+EStfYM
	 ZNEolV/MFyph83DKhyN7upaBlbYM/+kUAwN+HmWcKI3lKfnhI84gdJbesT8LLsHIAt
	 Lqni9luRvm4hL9ULMtwlci8q4A1LR+Z1ALxzynhZJsR4B35uFFPH14cInmcK8WFnHF
	 W3tzhWWg/V/glcDS2XdOQzbfTa1IfaUTn0NCSxUllahBq/Gfi9wGG2hWkdfMG8FBUn
	 /iylAglaH68TA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6D11A403E5;
	Fri, 22 Nov 2024 17:45:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [PATCH] docs/licensing: Clarify wording about "GPL" and
 "Proprietary"
In-Reply-To: <20241115103842.585207-2-ukleinek@kernel.org>
References: <20241115103842.585207-2-ukleinek@kernel.org>
Date: Fri, 22 Nov 2024 10:45:43 -0700
Message-ID: <87iksf2md4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> writes:

> There are currently some doubts about out-of-tree kernel modules licensed
> under GPLv3 and if they are supposed to be able to use symbols exported
> using EXPORT_SYMBOL_GPL.
>
> Clarify that "Proprietary" means anything non-GPL2 even though the
> license might be an open source license. Also disambiguate "GPL
> compatible" to "GPLv2 compatible".
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
> Hello,
>
> these are the locations that I found by a quick grep. If you spot a
> document that needs similar updating, please tell.
>
> The change in license-rules.rst looks bigger than it actually is due to
> changing where the line wrappings occur. With `git diff --word-diff` it
> reduces to:
>
>     "Proprietary"                 The module is under a proprietary licen=
se.
>                                   {+"Proprietary" is to be understood onl=
y as+}
> {+                                "The license is not compatible to GPLv2=
".+}
>                                   This string is solely for [-proprietary=
-]{+non-GPL2 compatible+}
>                                   third party modules and cannot be used =
for
>
> Best regards
> Uwe
>
>  Documentation/kernel-hacking/hacking.rst |  2 +-
>  Documentation/process/license-rules.rst  | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 9 deletions(-)

There seem to be no objections, so I've applied this.

Thanks,

jon

