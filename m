Return-Path: <linux-kernel+bounces-319549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A386B96FE53
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF81F23A52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56215B10D;
	Fri,  6 Sep 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Po55viVX"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193961B85DC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664297; cv=none; b=Q3dU16AY1aAvnbhNAEVm0P0hVkkvW/+XkSSyD7OfRh3xp8nZ4R6waQcHahz7M94mBYJxH0gR7OoMWDKzrHPrZVgUe5KK/3wd6zLmIHgwBKcIbtZCpjXo+QnmPQomvqW4p7j2N/HiONevWU8N+nPuKYg2q3H/3tONd+dnazpu3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664297; c=relaxed/simple;
	bh=Jm92GTizLR+q2XdM8uwVHTvYGhJOZyIzzzePNtb5tXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwN58AAhQnBUndWOQBGawvkEVG6D7k6PjGgdsk+gUt8a+8AxrvGttL/1/vpX+99UyeeARksZHvGtb/U8GQwDSkCz4+Rz92zuPliULw47SX3G9Mj8mbW2AYmTWkRoHsLOFXGPS0TETJsNRAT4fSeTihuftPYdaPc94LpO2Yj7G2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Po55viVX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725664291;
	bh=HEF6t61oQcZPeWEFUYghSOz/WmQUigaLAqj5lwawg9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Po55viVX1hlmgK10Q8yQDjvyM2VHZheLwnbXdnxlKNaW/54rsQJsaCNwJQjO1AX3P
	 WEwGP9gXr6Mfpng9r8/4K1F1BnVNo9dfXHUA+gYiQ7R7rTPT+iQjCXRLVrMH+0aeLE
	 bO1pQ5VJFH0MgjafH2HAS3Di72fu1PWEmnJsNNY5UIGArOnZ5mAnIvp1GJXMUf59Bz
	 9Lu2PD2+1F0krDeVAnsFPjuYYyI8+gfs36WPUNvpBU2NuV4bmvgB3cFQLCWPlCdw+k
	 st3B1BfRpe0lW6TEOmBQkZ4b2+83p43dY5KEczwDl/JI0OPfw3hADpcvERmJb2j9EA
	 8VMdqgg5LnAEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0sRl3CtQz4wj1;
	Sat,  7 Sep 2024 09:11:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-3 tag
In-Reply-To: <CAHk-=wj6L6Qb10jVk+eHH2D3oHFathTc2nnZRpKKbqKuO3Rkow@mail.gmail.com>
References: <87ttet3rz9.fsf@mail.lhotse>
 <CAHk-=wj6L6Qb10jVk+eHH2D3oHFathTc2nnZRpKKbqKuO3Rkow@mail.gmail.com>
Date: Sat, 07 Sep 2024 09:11:30 +1000
Message-ID: <87o7504btp.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, 6 Sept 2024 at 05:08, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Please pull some more powerpc fixes for 6.11:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-3
>
> Hmm. New pgp key? Please don't take me by surprise like this.

Yes, sorry. I switched to it a few weeks back but this is the first pull
request I've sent since.

> The key looks fine, I see the signature by Stephen Rothwell, but I get
> worried when I suddenly see a new signature with no notice and then
> have to go looking around for it.

It's also signed by my old key.

I posted it to the keys repo:
  https://lore.kernel.org/keys/87o75pp2bt.fsf@mail.lhotse/

But yeah I still should have mentioned it in the pull request.

cheers

