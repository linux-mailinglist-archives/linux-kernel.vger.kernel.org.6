Return-Path: <linux-kernel+bounces-400742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE39C11AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EDE1C211B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B823218D94;
	Thu,  7 Nov 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A9Ntjv1m"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25243218306;
	Thu,  7 Nov 2024 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018322; cv=none; b=amx/7cDbLGm38umldJopJORdc1Uo4RjER20+E0/vuo68oQHTzkc0VIVBI9Tf94OELh91VJPBClkaeZrjmgRFNovc4oGZTj8mC44cJHlP8ZbCbermkv0NMnubbPaA8tgra9zVvHQUwXSTJ1kflzHv+utiUvmt3Ti5a8i2uI86Djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018322; c=relaxed/simple;
	bh=LB4FFbbG9FQX9CbtOsLlWJgy8JORZOMl/73glWgRL5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AH6F2yqpQafjDH2qL4v5sMpGeihM3HYbseuxABU0ym72T2KizjCq+n3QhMAYecp3MN2wCZ/70hQ+UNbch71e9iOPrd1dCmPga6nmLhiS0JEGX1AqLw5aydwZzh94N0l1nz5n0E6IC4SWkEWZpEXv4v5yFHzb4u1eLNLcvtwEWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A9Ntjv1m; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D8B142C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731018320; bh=+09Zpjsb0D2A7dOmZw8gGv93ty5283cS27S+BwA5uT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A9Ntjv1m15N94mNqr45KDN1gyffUjhuglZFZR/Mx8TopBl/gl8URjXdO+eyjBeNCp
	 if3hrMO/wW8ckYNyZElcIwMZV7tH7mMJFjIooJQYX62nC9BB0eocy/+t/2swPzXyR2
	 Gv1cpDfObyD4A6wRjaAmqewxGliN5uszK+dQHskXmPtMFH7K6AyuT4IEU1MRvNifFM
	 Ef8AC8iJJ+4pZuX3utjGXMerSsnGtSkcgCANEf7FH8l0pmypcl/BKeMZsQfLlCzJwQ
	 GW+FgqqEKkcbdW20klEZLeCL7voURfqGKZRtIHHJVF30RZF3pF3yLryt1yooYvlX5e
	 DvF/7AN1xcmLw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4D8B142C31;
	Thu,  7 Nov 2024 22:25:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, anish kumar
 <yesanishhere@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, Sebastian Fricke
 <sebastian.fricke@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
In-Reply-To: <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org>
References: <20241107200835.3033-1-yesanishhere@gmail.com>
 <87cyj622oc.fsf@trenco.lwn.net>
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
 <874j4i205j.fsf@trenco.lwn.net>
 <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org>
Date: Thu, 07 Nov 2024 15:25:19 -0700
Message-ID: <87v7wyznow.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> I see a few possibilities, none perfect:
>
> a. in Documentation/driver-api/debug/  [not quite driver-api though]

No, it's not API stuff, and not limited to drivers.

> b. in Documentation/core-api/ along with debugging-via-ohci1394.rst
> [maybe in a new /debug/ subdir]

Again, not really API stuff.

> c. in (new) Documentation/debug/ and invite the kernel debugging
> community to add some of their docs here as well.

If we really want to separate the mechanics of kernel development from
the associated process information - not always an easy separation, IMO
- we could make a top-level "development" directory, put a lot of the
other relevant stuff there, and include the debugging stuff.  It seems
really weird to put debugging by itself, though; it's only part of the
picture.

Why is Documentation/process so bad?

Thanks,

jon

