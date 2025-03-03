Return-Path: <linux-kernel+bounces-542337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F879A4C8A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551591895DB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59725243387;
	Mon,  3 Mar 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STCFEw28"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4324336D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020072; cv=none; b=oFHW1/y62LyJA3gMhLPOqOMFGc5sSpiILSxckGq18+tg0hmJZ4ILCZKLU7vIWN+lfuG61TAtsBC90bXLu2YP5AWyMEOg3cjd6U7NlDQjg1Y2hUkgBwSJ1mHXyt14x+M5ibCDID47IHjlo5al7LZyZzp24JbFOxFvwOdnxJb7lbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020072; c=relaxed/simple;
	bh=/DajE2WEluHdU8xm6fzjzj50ibeWggcgMoJEkZdGFqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAkw+0XGDrSMJ0gLkCqqjIigd6ZZFPG/zB6wvPBFKxYQQJ+0xs+CHXShINCkl3FMCimqm82dn+0mHy7s7++hrNp9jbZzbaik1pxjHUzSbd2eTme5yRdoJIpArVfX09RXaSuscWOavMLlmPMEC+Adn1rjP3NpAfn/snm/4fAWHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STCFEw28; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so7532768a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020069; x=1741624869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqnnQUXra5YEywZ0wX2Sp8a+P/AC2GWjQtYbvVteKU=;
        b=STCFEw286LZlc9U6sC3nPQ/lCMEfqHuvK261DC8JK8UG0qQAiG+VSDwqfFla3XO+wr
         1312KValdJWFA/57HNoKgAW6sjdofxrYJgXiIzuvSai7fjkZ0Ul47HLcpcf5gTVyTvSg
         idyXaa+35dEjXBfIeyIEwGhKlP05WlaxjV3QU3Avmc0gLlAAo6lmvtXgjp+G89WTo/q7
         +E0tdbJr4LVjxFp0eCh+2KBdnUoScTtuKoDM+sAK2Ef68EjKGO0k/HXJBIWCYgU8suIy
         hPaWykWopjESrB7u5Roylz69jJq6yihn0OGESXo983P6QJwioIQcbd7hpIM4X9NnKHSC
         4OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020069; x=1741624869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvqnnQUXra5YEywZ0wX2Sp8a+P/AC2GWjQtYbvVteKU=;
        b=dp55q+SQOBo/SZ7OHMBW/S6Q3mu7ZjjbG7bohYMYTxdoYlHa3dpeRLPPWm+1p6/d41
         eMWrXoZzZ33ZKqqPcO91xKLlVLsJJ5rhiy+8PZaF+zydvoB1OS/+lN2mnweXG3yoXsPw
         eW8ytF8sUf5osD7WENbRoh7YmiB7/MQ2h8yvmdp4JHL5hIphbsVYD+HMEMjCkPQjip6g
         gkY7xLO2wT0HE4FKxVWcFtrib7k9WiiYUm0pDD42eJ9IuDH0Fvgrfpe0zamjxbzzYL7R
         VGtvtRQe607JiF5YLU+3ihlpZgoCO0EFZIEMBcpYYRUr+SWTspfJBGXt9rN/NB3pilQn
         Fe0A==
X-Forwarded-Encrypted: i=1; AJvYcCUALZ8vRuf2usVki48vZ39Qf1sISSY9jk+IC1sqJHep/nXLaFF4FDJsgV/blt94tiMUBUkqLGNMkccT4Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YySK1H3s/O2ZbYzIe3EOpSkbqkGTVvJRqfYGYIP3NPLKdDcMri8
	ghRGMjqFIgBjxojvh11qlOCiJDZ9/ugwSGmTPrR9dcodPEBut+TM
X-Gm-Gg: ASbGncvVIgQuQt21R2JebKJxwT0YAJaly1nnMUPs3cV+sMK0ChXxr4nwQb7uTxhzBSP
	YRjBxGKRRcMACnUG4er9dDyLtBIuV8zSDmFR3wuoR2B/NCeYn6wqgIHabCJucKGQSa2UBG4Vmku
	deaGURpo0Gc0I60ykQrUonB5k5bYavfjTTnaHIJbc6wkaX/8l3KK6tylpLFmHlon1vOR0wxJ9QE
	rqaLq4BC1YuPsz7pKTX5BcqvoZR55DVTIyGU9eUXeAd6vPNg6gMWJ0dWV9PDcw+M36r4hqavm7v
	x1xSE4zVaU2dLmmHLoWT6SaZPrCWXjCgXlDCXCc5ZHY9Cpxz
X-Google-Smtp-Source: AGHT+IHptwN4z1UitG3zPhGklcJYmkgc6L+Crp78KVNPE+rj94O41011bBx0yjydGTnZD57F2csRPA==
X-Received: by 2002:a05:6402:2789:b0:5e0:52df:d569 with SMTP id 4fb4d7f45d1cf-5e4d6b852d0mr13937191a12.28.1741020068864;
        Mon, 03 Mar 2025 08:41:08 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b6cfd0sm7053052a12.28.2025.03.03.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:41:08 -0800 (PST)
Date: Mon, 3 Mar 2025 18:41:06 +0200
From: Lilith Gkini <lilithpgkini@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, harry.yoo@oracle.com
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z8XbomV9WCabATIM@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>

On Mon, Mar 03, 2025 at 12:06:58PM +0100, Vlastimil Babka wrote:
> On 3/2/25 19:01, Lilith Persefoni Gkini wrote:
> > If the `search` pattern is not found in the freelist then the function
> > should return `fp == search` where fp is the last freepointer from the
> > while loop.
> > 
> > If the caller of the function was searching for NULL and the freelist is
> > valid it should return True (1), otherwise False (0).
> 
> This suggests we should change the function return value to bool :)
> 

Alright, If you want to be more technical it's
`1 (true), otherwise 0 (false).`
Its just easier to communicate with the true or false concepts, but in C
we usually don't use bools cause its just 1s or 0s.

> I think there's a problem that none of this will fix or even report the
> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
> all objects are free. This goes contrary to the other places that respond to
> slab corruption by setting all objects to used and trying not to touch the
> slab again at all.
> 
> So I think after the while loop we could determine there was a cycle if (nr
> == slab->objects && fp != NULL), right? In that case we could perform the
> same report and fix as in the "Freepointer corrupt" case?

True! We could either add an if check after the while as you said to
replicate the "Freepointer corrupt" behavior...
Or...

I hate to say it, or we could leave the while condition with the equal
sign intact, as it was, and change that `if` check from
`if (!check_valid_pointer(s, slab, fp)) {`
to
`if (!check_valid_pointer(s, slab, fp) || nr == slab->objects) {`

When it reaches nr == slab->objects and we are still in the while loop
it means that fp != NULL and therefore the freelist is corrupted (note
that nr starts from 0).

This would add fewer lines of code and there won't be any repeating
code.
It will enter in the "Freechain corrupt" branch and set the tail of 
the freelist to NULL, inform us of the error and it won't get a chance
to do the nr++ part, leaving nr == slab->objects in that particular 
case, because it breaks of the loop afterwards.

But it will not Null-out the freelist and set inuse to objects like you
suggested. If that is the desired behavior instead then we could do
something like you suggested.

