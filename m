Return-Path: <linux-kernel+bounces-347745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283D98DDF6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D331C23F66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9401D1F7C;
	Wed,  2 Oct 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="giS3x0+g"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9F1D0BB0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880676; cv=none; b=RUSDvPn8SaRRq8e5r1BhWFkypy+PSTEa0qOqG8CJatzJcMCLOxNnF66CcTs/pLM+jRFcTxoqzDmqNLDo2vU5HborFZzFwNYAxhIBk8I0POcgFunRARH0wx5afx1eGoQebkrOq6NMnUStC34ZVfaOnzAxXLl+c9KpkhaARnkorb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880676; c=relaxed/simple;
	bh=NlCN07NBCbK+Nekm7+SqexVSiuiW3p9UhLnBlxmV2UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyqF0hVCB4rpHbFyjefyRslhCeEoMhb7sgl4cZCsXOwOwqrFpvo6dn6pK65CNoJBOj+fprn3qw+/oZNMCdRhWDr76bk53zFkVHu/zT7mfrfFqiH52Zk4HzxoRwW3ncq5rq9e1OcU619m95iReAgoXZz/w3LSLtusCvcB7BDVxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=giS3x0+g; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E508F42BFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727880667; bh=dv2c4uQQw9Jrf51Rjg0ifhhbGMu1TSlUbiUdqfpC2fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=giS3x0+glSIeNOmHDqOTGmly11dKSYlXwtd5JyZkl30AzBaBJprdU3b24Sp2xhPOI
	 JzXIT567r82/mKqT0ape86ouB2j+h7cjLfc4ba051W5SzXrR1RlBWUyrPKYLTps4Kc
	 BiH1fw8dv1ugcj5bQWR6t9170NxfWZuIVSmST09nvlIkR6drKi+F0KlUG+2FOxLVqQ
	 M9d8CyfQbRxx3PmeaquFCU4dPm4y6iSgt+k0nxZlXJYtGibzVlGE9S0Rk+RnOkQU+Z
	 GOw361Jb04LzF4M7gw1nr8D5GE0atesFyTRUMUJMBsbFgChGzGM+hjU1GsaFjKn07C
	 mPzSRsKGTTrUw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E508F42BFD;
	Wed,  2 Oct 2024 14:51:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
In-Reply-To: <7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp>
Date: Wed, 02 Oct 2024 08:51:02 -0600
Message-ID: <87ikua4kyx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

>> Even stranger, to me at least, is the backdoor symbol-export mechanism.
>> That seems like ... not the way we do things.  Was the need for this so
>> urgent that you couldn't try to get those symbols exported properly?
>
> Yes. This is a chicken-and-egg problem. Symbols not used by in-tree kernel
> code cannot be justified for export, but I can't prove that loadable LSM
> can work unless I export symbols.

Honestly, this is the part that concerns me the most.  The normal way to
deal with this is to create a series with both the exports and the users
so that they can be evaluated together.  Instead you seem to have
created just the sort of shim layer that we have not allowed in other
settings, then pushed it upstream without review.

What will you do if, for any reason, one or more of those symbols cannot
be exported?  Either you will circumvent that decision indefinitely with
your "temporary hack", or you will remove the hack, regressing things
for your users.  Neither seems like a good outcome; that is why we
normally want to actually review things like symbol exports before
pushing them into the mainline.

jon

