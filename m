Return-Path: <linux-kernel+bounces-520469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2EA3AA41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E35C1896D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB01DE893;
	Tue, 18 Feb 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="X0kRO6ZZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645521CEAD3;
	Tue, 18 Feb 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911327; cv=none; b=osaLmoIZik2A2USW5NkZ5yVq5jR+hLvV+Cr0vP6zTpjQAmiZCLCHDm1V+M3ucaiWkS537W2GcablT/JaZYq/BXrQVfiln9wp7i5OYhJWuEOKVjFB05q/Z2r5Xew0h/lRMRnlnXkwNV0DHcGEHstnmh+0eYqkzfnPJM0Te5wxSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911327; c=relaxed/simple;
	bh=jlnMhgUBn+KNGwTcDq1KyRwfwnwlN5Aid3j7yRTC4RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9sv/3jPTnhs7M8763RYGYjlRtlv235qtG4QNjPpNUDdAK807LWsB1sUUC6hdoWSnmcqJHi8B7RYQDN2KixTa2/1+k81f486TSoP3JuxW3jjoNGBk3GzFTRIT+0enCtlTeoeljr5YZg7hEblaiYvU7i/tCG6PLHkPINfxy04IDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=X0kRO6ZZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2F9E1411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739911324; bh=Ki8gRBbGB/KJNSGpL6x6nHmueMOkGwWkGW1LfR0GGKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X0kRO6ZZMUtOMpeGVKzpbSc84sVBIWeqsCn3KUgpuNlFgYrhpCyk46N5ZplGVwvOu
	 m3ybIDw1VzcMESZrOFLGMH3Q05faA2Gv3kMgrNg9oZ/upAMVD3k7/ke3qWK4f/yLII
	 NhjKe+frievIehY3xosL9QCPmki6y57Ma4HG57PnIgXRU7emtAbxIxhfumkzzvRwWv
	 HEtoPPZ6bMM37a4tQyLpTp5FqFRfbd3BOaspDxT0nXPgZR73Yc6L2PDqPyxCPVm07a
	 vKweP6Xfrs5/dRmXKUcRq5SDM9gnyDhz7RbFOIdXBZvh33D7fjcpMGplWGCxrdxicK
	 Wwtue9A6ZHpNQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2F9E1411AF;
	Tue, 18 Feb 2025 20:42:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] docs: clarify rules wrt tagging other people
In-Reply-To: <8b87b297-b68b-4276-95ae-e04650c3360f@leemhuis.info>
References: <588cf2763baa8fea1f4825f4eaa7023fe88bb6c1.1738852082.git.linux@leemhuis.info>
 <87y0ydzn1q.fsf@trenco.lwn.net>
 <8b87b297-b68b-4276-95ae-e04650c3360f@leemhuis.info>
Date: Tue, 18 Feb 2025 13:42:03 -0700
Message-ID: <875xl7nfxg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry, fell behind on things again...

Thorsten Leemhuis <linux@leemhuis.info> writes:

>> - It would be awfully nice if we could provide this advice in exactly
>>   one place in the document.  This is one of our most important docs,
>>   and it is far too long to expect new contributors to read through and
>>   absorb.  Avoiding making it longer and more repetitive would be
>>   better, if we can.
>
> Well, in 5.Posting.rst that was possible. In submitting-patches.rst that
> conflicted with existing text in three areas, so some changes were
> needed; in one case the new text even got a little shorter, but overall
> those changes did not add a single new line.
>
> But sure, the new paragraph added a few lines. And it is identical in
> both documents. But that is a more complex and existing situation this
> patch can't solve. But of course I could avoid adding the new paragraph
> to submitting-patches.rst and change the "(see 'Tagging people requires
> permission' below for details)" added there already into "(see 'Tagging
> people requires permission' in Documentation/process/5.Posting.rst for
> details)". Given that people requested a even more detailed paragraph
> (see the other reply I just sent to Laurent) that might be wise; OTOH
> submitting-patches.rst right now AFAICS tries to be stand-alone, so it
> feels wrong at the same time.
>
> IOW: both is fine for me. Could you let me please know what you prefer?

Adding more cross references certainly won't help, I guess we'll leave
it as-is for now.

>> - I wonder if it would make sense to say that, if an implicit-permission
>>   tag has been added, the person named in it should get at least one
>>   copy of the change before it is merged?
>
> Hah, that is where I'd start to say "that seems like a bit much". And it
> does not help, as the cat is out of the bag once that copy is out, as
> the name and the email address someone might prefer to keep private
> would have made it to mailing list archives then already.

The cat is out of the bag but not in the repository; the thought was
that it's polite to give the person involved a heads-up that their name
is being taken in vain.  Certainly I've seen enough "what, no, I don't
want that tag there" reactions over the years to think it would
occasionally head off a use that the owner of the name doesn't want.

jon

