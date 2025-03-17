Return-Path: <linux-kernel+bounces-565162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34EA661F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D0A1799C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049B204840;
	Mon, 17 Mar 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KLGgCNcW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169031D934D;
	Mon, 17 Mar 2025 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251753; cv=none; b=VzRLtv8DmhbLdq5lIfk+gA4+jKXFYEGhhLHw80m7M9tVp4P/S0cIAgsOOrmu97rmAYRKmYLLJyUnpEvllUUTQ8IyErT62yVHownkqqn8Xrr9XtRAnBy+Y4QEEYfwnAtFvJ0YIKrNUsgTufyaMaRH2TOnw5EUjyKLIS/Qx4S5JBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251753; c=relaxed/simple;
	bh=NGELh5FK8qxoafb9BF1ie8d4BLSd7FdWC4zqeQ+Rxac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6VM+Zdb65rsyKnMwPc7StbfXrMkojLDGx/BUCVMbwEcb/iGr1Xw1hJK+RNtUxePs7rN5qHQ3w1lURFABBwVJxv+KgjmYWTZyTEx2byzx+Vw0F6fgj7QBgvv6eMxRE0HzRexzqBXT7OTodFn6RZeRMbJ2xofcNhD6ZEqhn/s5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KLGgCNcW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2CD4641081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742251750; bh=6PN7nApfM8X3fCGrZAu8H3kE5UNylVr653ipaeqlmtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KLGgCNcWvvI6Y3yEwPPqklYWBk3UrzBO2iFMqx9MPIei57VVTGRMxiW1kKUImh7Hb
	 6snMD3IfD9S2r2MoSxL76n1DgnxII0bCBd6gFnmNvKOlZSHhPDyrF68JtIVAuBbhtr
	 /G3UVvPqlbjs27GiOBL4xcxL9ANOUpdEaSpB0C7fyqxz78ZvTUTTFUK4yDqjMd5SAi
	 ncmG4nO2LHTmCZ9sCTIltU+66XtGg4t8ZYwxhQJsPnpbmLKSHwA0sl9oDRdpyXfyBa
	 5kC8bJtVFOFftAmVCd8xCix7JIVrZwlJ9aHbPpDqCRJrQHIBDzo4+t2/vAOiaS4bzG
	 FYKtP2FZgbAPg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2CD4641081;
	Mon, 17 Mar 2025 22:49:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] docs: clarify rules wrt tagging other people
In-Reply-To: <87jz8tlvqa.fsf@trenco.lwn.net>
References: <588cf2763baa8fea1f4825f4eaa7023fe88bb6c1.1738852082.git.linux@leemhuis.info>
 <87y0ydzn1q.fsf@trenco.lwn.net>
 <8b87b297-b68b-4276-95ae-e04650c3360f@leemhuis.info>
 <875xl7nfxg.fsf@trenco.lwn.net>
 <431b3825-8ed6-4da2-af9d-4f95e9d08606@leemhuis.info>
 <87jz8tlvqa.fsf@trenco.lwn.net>
Date: Mon, 17 Mar 2025 16:49:09 -0600
Message-ID: <878qp3e0ii.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Sorry for being slow ... but also, I guess, for not communicating my
> point very well.  My concern wasn't about somebody not wanting to appear
> in the repository at all; it was more with somebody not wanting their
> tag in a specific patch where they had not offered it.
>
> It seems I'm the only one who is worried about this, though.  It seems
> like we should go ahead and get this change in before the merge window
> hits.

OK, I have gone ahead and applied it ... though I'm still not 100%
comfortable with the wording as it is... :)

Thanks,

jon

