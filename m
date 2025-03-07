Return-Path: <linux-kernel+bounces-551071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1ACA567C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2777B3A700C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACD218EA1;
	Fri,  7 Mar 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fNukd8N6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046A184E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350417; cv=none; b=PKbUCjjM84s8Uk2UQaVcMSOwO1xLnWvgwYwqxcx0+qd62i5E+MRSFNn5OvVnx/eA3rGhVAdwHzhk6h6fZlhXDTniWb8ubiw7PC18VOa8RzsOTNoPf7WB9q7siuxVpA5pr0itPYchOWTvpTc7acfriQLocT8bWGZ+2Q2NxHMA5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350417; c=relaxed/simple;
	bh=YPShAx7gxzHy/nt0Zb5nG9FD+BBNf8EQ3ubvhFM4QLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVTN/JfUiAqNSmnjaZdfDoe1b7PAZJ4Af68YOg6qpP3lTmKXaoLEBHATA3LkzpjuU34Tv4dte4V+mq0MR9Drb+kE+qfd5sPK417h8M+zkiaisKoyNpLoASqV6shbmSKfwzJSGAqi24Uk4PCo0nloIQOs3MlGEMQcJKnsOuqK3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fNukd8N6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso10956715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741350413; x=1741955213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=622gC19O29sF/UG8gdkcpvRKb1VEu/RpIToN5VE4nb0=;
        b=fNukd8N6HclQjklZj0WsKBfexeYWGX/9xE3samKDt13gUXyJYBbMJJPhbxNd1HpWHe
         yJpZULgaKuEGL+d7AQP5GqeqwEzJrx0lzZbznqW72X19ZI+LdFS2PMHemFBZhedPZikT
         +AvIf7zwIZc0yXatu/rD/7agDjrAUXGFMu/EN98jTrEEBYolPk9Y1hQjzzYK4KgrbVUG
         /kTTQUg5E1t9M+Nkh1GwPDf3eI/PY/DJWbzKclc0GnbWnil4uICKWoWnXbFJl0aOonWi
         zSbY+OjwlF8U17SBJxETvJrCdlr+gQNxIFCxe31sNlEplhf2VNSqGg2JGYY/OondWmLX
         ocGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350413; x=1741955213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=622gC19O29sF/UG8gdkcpvRKb1VEu/RpIToN5VE4nb0=;
        b=AmZxrU6fX9qfbODUWW0lIld9uUt5VoWeFBSSYLAmABC4wOlBEOA7ZpvHRX4fDj6UJs
         ZDc0dBnYLwrX6TVe8puyCaaHoVKPTqO3MaH+JkXWdEJ5BVzWdce826druS72zeP8Rc8K
         l5XM43/lWzvTuxhaORgIIt46Du0mFjUSx6SoV8Wej149L96GmbZHt57gm5kzAHenV6nn
         DKXamKI46VtN6Bj4RiMZkEs2gNt/HbO0QwOfi+9nioAAFKvjdAFUPYFoKh0KhcfU4JZ0
         8R/UvthMryHhH2kXY3I9TDOOQBfulX3e1MuJUCO8NOuVPjFhmNwaIXGKuTog6lpKQhPU
         PMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjK3uJFLRKl3+nw85JvP31x2OTeAtok9TjnvMXl1y4CuWbEyHD+1dchM2sopAFC1MQeORX5VBPQNExMFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkix5rYipckNFENZUcWPtCQcRl6lA1lStTtXkz8bAIPiCJK4H3
	7+4QB+DzUE9IZ7ORxMh6a2w0wT3VVRkpD2medVmk9KTr3JpW2wS+dmH17jnNQxE=
X-Gm-Gg: ASbGncs7QFm0tvfBjuAVeg64usmPBscG6QCFSCNjB52ol7mXjjnyDb4K7OHzzxD483Z
	kyvlWGr/yPd4cMqbqh30aiykz3yXMaS853pYKDQzApuByzugJr65eYqpZquN48tpQXubvGiaJpK
	DAtoKWQsO7wLBM6v0JvxqyrIaONI4upRJzuV6jpz9HcrT/LKyReAOHQZGnUj/HXX0/xDEVNkrnC
	YhuiVK2At09Dpv2EIAdtnjr0m7rkx7Puka/vf84F1SkerUDabOVeoSEMrlBkAyCFwyZepIYmfec
	SZy/fBO2GTpHQk3lLS77+967+YgpZDhho5cJEZ9iBtbykcY=
X-Google-Smtp-Source: AGHT+IFlJh9KCyp47/EBaV4vqEAwmLf0JhglHzGouct6yQA7Cq+HmdPar98x8XzgyJX1RCfEXaVeNw==
X-Received: by 2002:a05:600c:350a:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43c5a60ed04mr27392585e9.16.1741350412878;
        Fri, 07 Mar 2025 04:26:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42916a0sm79707725e9.9.2025.03.07.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:26:52 -0800 (PST)
Date: Fri, 7 Mar 2025 13:26:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v1 18/19] Documentation/livepatch: Update documentation
 for state, callbacks, and shadow variables
Message-ID: <Z8rmCritDCtNmw64@pathway.suse.cz>
References: <20250115082431.5550-1-pmladek@suse.com>
 <20250115082431.5550-19-pmladek@suse.com>
 <c291e9ea-2e66-e9f5-216d-f27e01382bfe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c291e9ea-2e66-e9f5-216d-f27e01382bfe@redhat.com>

On Thu 2025-03-06 17:54:41, Joe Lawrence wrote:
> On 1/15/25 03:24, Petr Mladek wrote:
> > This commit updates the livepatch documentation to reflect recent changes
> > in the behavior of states, callbacks, and shadow variables.
> > 
> > Key changes include:
> > 
> > - Per-state callbacks replace per-object callbacks, invoked only when a
> >   livepatch introduces or removes a state.
> > - Shadow variable lifetime is now tied to the corresponding livepatch
> >   state lifetime.
> > - The "version" field in `struct klp_state` has been replaced with the
> >   "block_disable" flag for improved compatibility handling.
> > - The "data" field has been removed from `struct klp_state`; shadow
> >   variables are now the recommended way to store state-related data.
> > 
> > This update ensures the documentation accurately describes the current
> > livepatch functionality.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Hi Petr, I'm finally getting around to looking through these
> patches.

Great, thanks a lot for jumping on it.

> I've made it as far as the selftest cleanups, then skipped ahead to the
> Documentation here.  Before diving into code review, I just wanted to
> clarify some things for my own understanding.  Please correct anything
> below that is incorrect.  IMHO it is easy to step off the intended path
> here :D
> 
> The original livepatch system states operated with a numeric .version
> field.  New livepatches could only be loaded if providing a new set of
> states, or an equal-or-better version of states already loaded by
> existing livepatches.
>
> With that in mind, a livepatch state could be thought of as an
> indication of "a context needing special handling in a (versioned) way".

I am not sure about the word "context". But it might be because I am
not a native speaker.

In my view, a state represents a side effect, made by loading
the livepatch module (enabling livepatch), which would need a special
handling when the livepatch module gets disabled or replaced.

There are currently two types of these side effects:

  + Changes made by callbacks which have to get reverted when
    the livepatch gets disabled.

  + Shadow variables which have to be freed when the livepatch
    gets disabled.

The states API was added to handle compatibility between more
livepatches. I primary had the atomic replace mode in mind.

Changes made by callbacks, and shadow variables added, by
the current livepatch usually should get preserved during
the atomic replace.

>  Livepatches claiming to deal with a particular state, needed to do so
> with its latest or current versioning.

The original approach was affected by the behavior of per-object callbacks
during the atomic replace. Note that:

	Only per-object callbacks from the _new_ livepatch were
	called during the atomic replace.

As a result, previously, new livepatch, using the atomic replace, had to be
able to revert changes made by the older livepatches when it did
not want to keep them.

This shows nicely that the original semantic was broken! There was
no obvious way how to revert obsolete states using the atomic
replace.

The new livepatch needed to provide callbacks which were able to
revert the obsoleted state. A workaround was to define it as
the same state with a higher version. The same state and
higher version made the livepatch compatible. The higher
version signalized that it was a new variant (a revert) so that
newer livepatches did not do the revert again...


> A livepatch without a particular
> state was not bound to any restriction on that state, so nothing
> prevented subsequent atomic replace patches from blowing away existing
> states (those patches cleaned up their states on their disabling),

I am confused here. Is the talking about the original or new
semantic?

In the original semantic, only callbacks from the new livepatch
were called during the atomic replace. Livepatches were
compatible only when the new livepatch supported all
existing states.

In the new semantic, the callbacks from the obsolete livepatch
are called for obsolete states. The new livepatch does not need
to know about the state. By other words, the replaced livepatch
can clean up its own mess.

> subsequent non-atomic replace patches from adding to the collective
> livepatch state.

Honestly, I do not think much about the non-atomic livepatches.
It would require input from people who use this approach.
It looks like a wild word to me ;-)

I allowed to use the same states for more non-atomic livepatches
because it might make sense to share shadow variables. Also more
livepatches might depend on the same change made by callbacks
and it need not matter which one is installed first.


> This patchset does away with .version and adds .block_disable.  This is
> very different from versioning as prevents the associated state from
> ever going away.  In an atomic-replace series of livepatches, this means
> once a state is introduced, all following patches must contain that
> state.  In non-atomic-replace series, there is no restriction on
> subsequent patches, but the original patch introducing the state cannot
> ever be disabled/unloaded.  (I'm not going to consider future hybrid
> mixed atomic/not use cases as my brain is already full.)

Yes, this describes the old behavior very well. And the impossibility
to remove existing states using the atomic replace was one of the problems.

The API solves this elegantly because it calls callbacks from
the replaced livepatch for the obsolete states. The livepatch
needed to implement these callbacks anyway to support the disable
livepatch operation.

And there is still the option to do not implement the reverse
operation when it is not easy or safe. The author could set
the new .block_disable flag. It blocks disabling the state.
Which blocks disabling the livepatch or replacing it with
a livepatch which does not support, aka is not compatible with,
the state.


> Finally, the patchset adds .is_shadow and .callbacks.  A short sequence
> of livepatches may look like:
> 
>   klp_patch A               |  klp_patch B
>     .states[x]              |    .states[y]
>       .id            = 42   |      .id            = 42
>       .callbacks            |      .callbacks
>       .block_disable        |      .block_disable
>       .is_shadow            |      .is_shadow
> 
> is there any harm or confusion if the two patches' state 42 contained
> disparate .callbacks, .block_disable, or .is_shadow contents?

Yes, two incompatible states with the same .id would break things.
The callbacks won't be called and the old shadow variables
won't get freed during an atomic replace.

It is responsibility of the author of the livepatches to use
different .id for different states.

I am not sure if we could prevent mistakes. Hmm, we might add
a check that every .id is there only once in the patch.states[] array.
Also we could add a human readable .name of the state and ensure
that it is the same. Or something like this.


> I /think/ this is allowed by the patchset (though I haven't gotten too
> deep in my understanding), but I feel that I'm starting to stretch my
> intuitive understanding of these livepatching states.  Applying them to
> a series of atomic-replace livepatches is fairly straightforward.  But
> then for a non-atomic-replace series, it starts getting weird as
> multiple callback sets will exist in multiple patches.

Yeah, as I said. The non-atomic-replace world is a kind of jungle.
It would require some real life users which might define some
sane rules.

> In a perfect world, we could describe livepatching states absent
> callbacks and shadow variables.  The documentation is a bit circular as
> one needs to understand them before fully grasping the purpose of the
> states.  But to use them, you will first need to understand how to set
> them up in the states. :)  Maybe there is no better way, but first I
> need to correct my understanding.

Yeah, the documentation would deserve some bigger refactoring. We created
separate file for each feature but it is not easy to get the full picture.

I hope that my answer helped a bit to understand the change.
Feel free to ask.

Best Regards,
Petr

