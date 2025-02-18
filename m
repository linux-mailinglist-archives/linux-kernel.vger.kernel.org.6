Return-Path: <linux-kernel+bounces-520485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BBA3AA73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD603B9256
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5C171A7;
	Tue, 18 Feb 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iNmlna4W"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810D286281;
	Tue, 18 Feb 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912353; cv=none; b=Xv0n028hoyIqFRC08HzG1nGCGgj3S2fuDPBMHeQgKKZYIrsASf2j4aum9z/UgcQaiicTj9pM+S8vURvalNo0N2odaUBrfaPB24jrjM/K0ypOoZi10R9kGzUdu5B+MPeUtad5fVYxOFIe0S7koYY054A0Sfaw8HezlkpR2YqGTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912353; c=relaxed/simple;
	bh=FFcCgxhkRrZf0oO7SvDjg20o6b0gL5z2N8U26yKZW40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0captvVqwdXTZDVYecE1biXzgtQqpOattkBw5kAi2LgExwtsVPUjckP0gD/tMy2WWZmDKBskTnl/i+Oq5Vz7hcz8tQbhS7eTsRgXvN98jgc6ieCb7GHujDmyo4T91QdRbIy1EM8IQJlU5ZbpAXvZ8zfhaUswTlpupZoR+WkYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iNmlna4W; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 03450411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739912351; bh=xob5bPJV+0BIwWpZL0BhJlMQzelJ36QmFOJ8Wa+YI5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iNmlna4WYoaBHRJGtRyvwiNKLk0ZLSqJriSERXoLLJjWViyDSaslUGE3HcReA3ZH/
	 QSdsTD3hGP/FHAtOXUKjsZLTPwOI8diQ78Np1cUKwUbOPTKre+YaizfDuUzOMYBtv3
	 zTOOtKxCBS1JRDZPP7KkAF/+bsPLoAtQWc6i8UxoIrhJ0lwsPVY0X7SeFbAy+6wVve
	 BNWjvW7zvN+pcyNwCqIFoV65fHElImLXiSj3Udo65H8R0D9iQRtS7cQQ7lBBCj6dvQ
	 OCMtNHXgvdw45yelT8PSzX+JyejFmb5yQTbNTE0XaxswX/AHF2N33jDxVowVe2HPIP
	 PJntKSV/BD5YA==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 03450411AF;
	Tue, 18 Feb 2025 20:59:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
In-Reply-To: <20250214032457.6444ee93@foz.lan>
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
 <87wmdt6bv5.fsf@trenco.lwn.net> <20250214032457.6444ee93@foz.lan>
Date: Tue, 18 Feb 2025 13:59:10 -0700
Message-ID: <87wmdnm0kh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> With regards to the Python transition, since our Makefile allows
> switching to a different script since ever[1], I'm playing with 
> the idea of sending a patch series with:
>
> Patch 1: 
>   - drops Sphinx version check from both kerneldoc 
>     (-sphinx-version parameter) and the corresponding Sphinx extension;
>
> patch 2: 
>   - renames kerneldoc to kerneldoc.pl
>   - creates a symlink:
> 	kerneldoc.pl -> kerneldoc
>
> patch 3:
>   - adds kerneldoc.py:
>
> patch 4:
>   - add info messages on both versions related to the transition,
>     and instructions about using KERNELDOC=<script> makefile and ask
>     people to report eventual regressions with new script.
>
> patch 5:
>   - change kerneldoc symlink to point to kerneldoc.py
>
> We can then keep both for maybe one Kernel cycle and see how it goes,
> stop accepting patches to the Perl version, in favor of doing the needed
> changes at the Python one.
>
> If everything goes well, we can remove the venerable Perl version on the 
> upcoming merge window, and change the Sphinx extension to use the Python
> classes directly instead of running an external executable code.
>
> What do you think?

Seems like a fine plan in general.  I wonder if we might want to keep
the old kernel-doc a bit longer just in case, but we can decide that as
we go.

> I'm in doubt if I should split the Kernel classes for the Python version
> into a scripts/lib/kdoc directory on this series or doing such change
> only after we drop the Perl version.
>
> Keeping it on a single file helps to do more complex code adjustments 
> on a single place, specially if we end renaming/shifting stuff[2].

Do whatever makes it easiest for you at this point, I'd say.

> On a separate but related issue, perhaps we should start talking about
> coding style. We don't have anything defined at the Kernel, and
> different scripts follow different conventions (or most likely
> don't follow any convention at all). We should probably think having 
> something defined in the future.

I've generally tried to stick to something that looks as close to the C
coding style as possible.  Formalizing that might not be a bad idea at
all.

jon

