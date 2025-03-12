Return-Path: <linux-kernel+bounces-558557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD542A5E798
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEEF3B4ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C01F0E42;
	Wed, 12 Mar 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CtQyC/Oy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A91DE3A4;
	Wed, 12 Mar 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819168; cv=none; b=u8rs0+BZ+X0Exnlk6Kuj6nF8ExQNv5Q1i22ZBnM9VsfRekZ8w5tykaLaea6iepIPpP1sxJQ1AoSBiQ6lv5mn+3jmObtvGwyanpKFi5m9/jeSSi11thd94bsnZsNw8cWmwyiITutwDhf6B/K4fnQ6l7W3rofLzFHpJsnXgQAmW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819168; c=relaxed/simple;
	bh=d04iKHxYq/E+Li+Qvs0unn3jinJpPrAAf2uTXuzu75s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLhnuQY3mvFHL+6QIQ64o3Bal2TxTOgu2UDS4HWFXVQdY3rYjONHevwlu3h9Yu2hH9xp75QYf1KLnT3sMTn+VyrQAkEl7CbqrZHawXAWrN0hWaj9jQm0Jbj0MnQgXEhRIWIqjKjW1in+eXzfrJbY+K15Xg11NhePhuIq7D78Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CtQyC/Oy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 274A541063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741819166; bh=lEWiaTjCAZsdNeiF0YFPEvCb61ta87WaMFTY3JjLgJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CtQyC/OyOMOJmuBK8/FXYPVreNI76fmqAJ8dx2kiqh3CVaBryfdR6fthOWFwPqmZO
	 vFxKQv++IoHRA0OpeNr9RgYGdG69nJXVa3xPunVXD1GQG9HCFgZeeWMIvjn+pbv1hj
	 bL8sAv4JPJFQRbL4iPhBAmfkPAMYKZE6SheXIia7egAzGTSe8JyWLpZYZI0gmIQqii
	 Nvge7Cd1iCLRjeYV5OVsE9C03u9LL9reanbzLcgVyazqcmGIKGLM7PbUr0ZwfBLkig
	 t5CeurSebBCmV/J3322ipZTt1sYVIVDjipBy+D3JJ0VGseUe7k8DmDaId3FoeKKYrG
	 hWdKlpnUd4mJg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 274A541063;
	Wed, 12 Mar 2025 22:39:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] docs: clarify rules wrt tagging other people
In-Reply-To: <431b3825-8ed6-4da2-af9d-4f95e9d08606@leemhuis.info>
References: <588cf2763baa8fea1f4825f4eaa7023fe88bb6c1.1738852082.git.linux@leemhuis.info>
 <87y0ydzn1q.fsf@trenco.lwn.net>
 <8b87b297-b68b-4276-95ae-e04650c3360f@leemhuis.info>
 <875xl7nfxg.fsf@trenco.lwn.net>
 <431b3825-8ed6-4da2-af9d-4f95e9d08606@leemhuis.info>
Date: Wed, 12 Mar 2025 16:39:25 -0600
Message-ID: <87jz8tlvqa.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> On 18.02.25 21:42, Jonathan Corbet wrote:
>> Sorry, fell behind on things again...
>
> No worries at all. And fun fact: I put this aside myself for some time
> as I was unsure about the way forward...
>
>> Thorsten Leemhuis <linux@leemhuis.info> writes:
>> [...]
>> Adding more cross references certainly won't help, I guess we'll leave
>> it as-is for now.
>
> +1
>
>>>> - I wonder if it would make sense to say that, if an implicit-permission
>>>>   tag has been added, the person named in it should get at least one
>>>>   copy of the change before it is merged?
>>>
>>> Hah, that is where I'd start to say "that seems like a bit much". And it
>>> does not help, as the cat is out of the bag once that copy is out, as
>>> the name and the email address someone might prefer to keep private
>>> would have made it to mailing list archives then already.
>> 
>> The cat is out of the bag but not in the repository; the thought was
>> that it's polite to give the person involved a heads-up that their name
>> is being taken in vain.  Certainly I've seen enough "what, no, I don't
>> want that tag there" reactions over the years to think it would
>> occasionally head off a use that the owner of the name doesn't want.
>
> Hmmm, have a point there. How about a "s/contributed/routinely
> contributes/" in this sentence:
>
> """
> For those three implicit permission is sufficient if the person
> contributed to the Linux kernel using that name and email address
> according to the lore archives or the commit history
> """

Sorry for being slow ... but also, I guess, for not communicating my
point very well.  My concern wasn't about somebody not wanting to appear
in the repository at all; it was more with somebody not wanting their
tag in a specific patch where they had not offered it.

It seems I'm the only one who is worried about this, though.  It seems
like we should go ahead and get this change in before the merge window
hits.

Thanks,

jon

