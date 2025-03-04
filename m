Return-Path: <linux-kernel+bounces-543483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF94A4D633
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3BF3A99DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE81FBE9D;
	Tue,  4 Mar 2025 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLOc3JW8"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD843172
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076661; cv=none; b=oW/okyfcVr142dP2qXCPipFKZVq/pQiP/yHxxUM8OoX2TbDAsUiZqoB1UgY+q1VKjkbimEUSgWQOOLvYo73PXJ+PAex2DJupwrp8a75Mu7pGFa959ydrVGr5L5c4Q5YBk3SEW+Re/dCkZWEQZHjNP/Pn9xFO+ScRmWzXfItfN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076661; c=relaxed/simple;
	bh=NAd+1izxe+eaSjF3MUUZH/SoL/xIWiIHI04ae61ywag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2FKvJlrf0W5b3IV9gU4GhnXdmUf4Fz/zjr2wqcy8n3mnkBH8GyUXw/fK5BTg1ijYHMtv0jByt9Qlxy8ncp391DPm5nZ16fdPDq6YwV2wKiHDS6R+0eukYTWlGAADU2xxtTNkahmzfussDuzoz8NAt8ToWvyG0mFejDbCVp/akI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLOc3JW8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf64aa2a80so450811666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741076657; x=1741681457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilSMtdNdsliGxA9UF1qUw5o9oqOJ+G3vMgmcwIAvt+E=;
        b=bLOc3JW8fsj9CxU/mkclDQTbp6JDqiwM9JAD+dD4xzrSkv5V0oIgudZTj/CNVlpg9c
         PSQYwJWPFd64RFhuvzVdRBXu7Ia+WT5C//xsrQnjXfrqwATZt95z+LWYpSkhEhkC0Jlq
         9fNngg7coN65hRP4kcpCWYfdiHWu0TmNiZaFbCj8B0p3tiC9/YMl9L3NqDrdDLAmKxGJ
         vdeqrEYlrv/PtXUvJNcUAWXhjx9nxj2T3yIJOQLkHMK5YA3ykPhs3zCMw4xNH9K+Vkn1
         nJnEV5vUWiSoeZ3sUQVUE+wVhDOtgA+bogpQp7POIaQEV1NBcxH+fLAHxDmm8gKMliPb
         I/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076657; x=1741681457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilSMtdNdsliGxA9UF1qUw5o9oqOJ+G3vMgmcwIAvt+E=;
        b=cKsmvrro0bv92leMxVByLv83tBBpVKlz3iHHH3FQLLCwhAiMf4Q/7dF/GtCurfJc3a
         Le2Wm4q6h0r3Z1gsvlTwLV54FEid4lMxSqrsZ1H2jjYrpuVAGJG8D1lqbL0oH5aHI1lr
         uqF+Kf+6hYHHBmgxxlqABodOGVupQiN70dCNNc1OkUm6bIeciUynhNWofOzajw0dPZnV
         PZG26LD2/EXNur5OJj6tUSPSTZZ7SiB7HpAc5maJCNDJTDX+foodaXZYeW5PnxLFIIJf
         ItZTLSbK61wkwREQmz5mKFbFkZR3coLNqArBTmAzZgWiXDGQcFIqITs2xLx5ilr+NPlf
         4x6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEOvNkS92zQF0qmmLEF9+3I0UOoq44iCDqkFpEnglFrqj+MRtOSGD5Fj5ol/Kia1DuSP6GP5iHsvUq+Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZAZttlvI6JMtOhA6/UQ0opVp7cDArFylJoE9tmXaUlaC2QMi
	7cB/4/MzaNSBdjrG4vK50O7xg0vfYHswtHzWZmnBv9gWHEl3PMGg
X-Gm-Gg: ASbGncsaKi000PPhCFaK/M50XyDdvFNecRQ+Ei8He7D9NY7jtKkW6Br2TcIiwK+cjWe
	v9MVEzQEboajTGBNzusRf+Ut9Ecfv1HEvXq3rLBt02GYYbOhc4q+6Z1EVzTO2V55w88CMqCSqnw
	+W+MVy20nTl/x8Rk3ORzDsmxbM9qNbg07+thm/yz2OmUJwN1QX0+hdVJQAutlscnnnngtp3h2E4
	vawAL+HBZd0gBHIcKbrGyDoOpcbSB3UVUm3iwPkuFtvk15aIrcFM9+K0QBWHFazsjyRdMF+QPwN
	DiF1aY5MpyKGIj5Go0ENhb1PbQgX5/bXx0KgmzggvH2fYo6Q
X-Google-Smtp-Source: AGHT+IGAek1A6P3Ha+7ueQirgdhy2Ux6efWtUdnbiEC7nzfgGCERjiuz9cfsSyk1cpCIt1yMr4fXCw==
X-Received: by 2002:a17:907:3545:b0:abf:44b1:22e4 with SMTP id a640c23a62f3a-abf44b12416mr1228115966b.11.1741076656579;
        Tue, 04 Mar 2025 00:24:16 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf3f3bbfb3sm675248866b.77.2025.03.04.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:24:16 -0800 (PST)
Date: Tue, 4 Mar 2025 10:24:15 +0200
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
Message-ID: <Z8a4r2mnIzTD2cZa@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>

On Mon, Mar 03, 2025 at 08:06:32PM +0100, Vlastimil Babka wrote:
> On 3/3/25 17:41, Lilith Gkini wrote:
> > On Mon, Mar 03, 2025 at 12:06:58PM +0100, Vlastimil Babka wrote:
> >> On 3/2/25 19:01, Lilith Persefoni Gkini wrote:
> >> > If the `search` pattern is not found in the freelist then the function
> >> > should return `fp == search` where fp is the last freepointer from the
> >> > while loop.
> >> > 
> >> > If the caller of the function was searching for NULL and the freelist is
> >> > valid it should return True (1), otherwise False (0).
> >> 
> >> This suggests we should change the function return value to bool :)
> >> 
> > 
> > Alright, If you want to be more technical it's
> > `1 (true), otherwise 0 (false).`
> > Its just easier to communicate with the true or false concepts, but in C
> > we usually don't use bools cause its just 1s or 0s.
> 
> Yeah, I think bools were not used initially int the kernel, but we're fine
> with them now and changing a function for other reasons is a good
> opportunity to modernize. There are some guidelines in
> Documentation/process/coding-style.rst about this (paragraphs 16 and 17).
> int is recommended if 0 means success and -EXXX for error, bool for simple
> true/false which is the case here.

Oh! because of the emote I thought you were being sarcastic that I didnt
report it properly.
Thank you for clarifying! That should be an easy fix!

> >> I think there's a problem that none of this will fix or even report the
> >> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
> >> all objects are free. This goes contrary to the other places that respond to
> >> slab corruption by setting all objects to used and trying not to touch the
> >> slab again at all.
> >> 
> >> So I think after the while loop we could determine there was a cycle if (nr
> >> == slab->objects && fp != NULL), right? In that case we could perform the
> >> same report and fix as in the "Freepointer corrupt" case?
> > 
> > True! We could either add an if check after the while as you said to
> > replicate the "Freepointer corrupt" behavior...
> > Or...
> > 
> > I hate to say it, or we could leave the while condition with the equal
> > sign intact, as it was, and change that `if` check from
> > `if (!check_valid_pointer(s, slab, fp)) {`
> > to
> > `if (!check_valid_pointer(s, slab, fp) || nr == slab->objects) {`
> 
> You're right!
> 
> > When it reaches nr == slab->objects and we are still in the while loop
> > it means that fp != NULL and therefore the freelist is corrupted (note
> > that nr starts from 0).
> > 
> > This would add fewer lines of code and there won't be any repeating
> > code.
> > It will enter in the "Freechain corrupt" branch and set the tail of 
> > the freelist to NULL, inform us of the error and it won't get a chance
> > to do the nr++ part, leaving nr == slab->objects in that particular 
> > case, because it breaks of the loop afterwards.
> > 
> > But it will not Null-out the freelist and set inuse to objects like you
> > suggested. If that is the desired behavior instead then we could do
> > something like you suggested.
> 
> We could change if (object) to if (object && nr != slab->objects) to force
> it into the "Freepointer corrupt" variant which is better. But then the

We could add a ternary operator in addition to you suggestion.
Changing this:
`slab_err(s, slab, "Freepointer corrupt");`

to this (needs adjusting for the proper formating ofc...):
`slab_err(s, slab, (nr == slab->objects) ? "Freelist cycle detected" : "Freepointer corrupt");`

But this might be too much voodoo...

> message should be also adjusted depending on nr... it should really report

I m not sure what you have in mind about the adjusting the message on
nr. Do we really need to report the nr in the error? Do we need to
mention anything besides "Freelist cycle detected" like you mentioned?

> "Freelist cycle detected", but that's adding too many conditions just to
> reuse the cleanup code so maybe it's more readable to check that outside of
> the while loop after all.

If the ternary operator is too unreadable we could do something like you
suggested

```
if (fp != NULL && nr == slab->objects) {
	slab_err(s, slab, "Freelist cycle detected");
	slab->freelist = NULL;
	slab->inuse = slab->objects;
	slab_fix(s, "Freelist cleared");
	return false;
}
```

What more would you like to add in the error message?

In a previous email you mentioned this

> >> I think there's a problem that none of this will fix or even report the
> >> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
> >> all objects are free. This goes contrary to the other places that respond to
> >> slab corruption by setting all objects to used and trying not to touch the
> >> slab again at all.

If nuking it is how we should hangle corrupted freelists shouldn't we
also do the same in the "Freechain corrupt" branch? Otherwise it
wouldn't be consistent. Instead the code now just sets the tail to NULL.

In that case we'll need to do a lot more rewriting, but it might help
out with avoiding the reuse of cleanup code.

