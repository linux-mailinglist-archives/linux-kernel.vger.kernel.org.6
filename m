Return-Path: <linux-kernel+bounces-551449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B53A56C99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D80717835C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4D21D3F2;
	Fri,  7 Mar 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9+35CJp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1421D3D5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362649; cv=none; b=aeGjkqdVesVkzpvAbV0yG1Gt0JfNK5gZrbRe8G909WBd83dt3uwPQQy8SS0IGjEEuO4FW55fnVdEwGimYWA5G+C+pCKNyw0Qku3Dpvco4M2vT54HIf2pRSoEG7ApIlKbqpxVYeOrKHk4pwengZjF6hYj30CqaRab+T+20I9g8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362649; c=relaxed/simple;
	bh=iXGYjBWdULJWCrP71xmD0+Dbl0c5VJX4/HXIc9O2icI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=VapMR+lAy3vMa/ChvJhUTsPwvPiDxEUSkebVvOQtiBfxon2bNfkHkBblny3YiGpvJZv2PXphptWF39ZUr2QDh0hLdeMbhOomnPQqn9JFqnvFohF7jrNH7+Csybd+VW6pTyJL8vjsPGW1EqupFVrS9kK0qbRt3UfHMlXBh+VRfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9+35CJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741362646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYEpkA1N+H9dx8XJCjT8MQ/PI+vw7jshcFKkIi9I5lI=;
	b=Y9+35CJpHdx74WfdVx/S5IOnrSpFE4wGwvBdlPYQV8Sc9LfSb0YB0dE6vf38EUI5X8mhqe
	j36vWCs9hDioClQpAtHQGfGezER6puPkHzcT9XygRTtJoAOB9fRPPQzu3qrgZEkoV0fMx3
	OPBUQca5+psZRoErFgoiwe2PeOXsCoM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--EL9eUw7NXyoxVMyZ7f4Zg-1; Fri, 07 Mar 2025 10:50:45 -0500
X-MC-Unique: -EL9eUw7NXyoxVMyZ7f4Zg-1
X-Mimecast-MFC-AGG-ID: -EL9eUw7NXyoxVMyZ7f4Zg_1741362644
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b53373f7so520580885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362644; x=1741967444;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYEpkA1N+H9dx8XJCjT8MQ/PI+vw7jshcFKkIi9I5lI=;
        b=S4TPMQuBPf50Islhzl2j8Q+DlO2+somHEKrqQTffkwp4p0yeN/2CLYoYHdiH6S4DSd
         otNG5uxe6PukClnfCkhZ4vXSNNWvQvKeM22Q+ZZss3qh6UUS2S5YEH2vcZFyz7FLsGCY
         /3z0sZSHKF1jWHKPdQgsR1YPy4dOLph6w9J4p5rNVgmyTQI35rv/DUScIUjAc3g6GzwE
         FHr41HEzzdInPWtKPAHXpwPb3Xb67ecyb9musQjsYP1SqCw6tvd6lYJDbXgBXjD2YQ10
         gMrKYJqXBb3YihyTstJ32OWOpsr2Sg9E0MLn9CVVoAc6RibtGPThoMl7RjfYVg0mHVJK
         W+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX+O1ev616YqzN0G9mb6YQZ7RKGuBcNJn52IIXZijvy8pdBYY8Zf1UgRUL5SK8ceSkQJh/xDUDLaRGtdYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCNZyMbZ+1smKtGRIwXrbUpDcP2pPGnj9kDg370V7lrss5DM0
	ebOEUAyrepC3MHR98Z6tRPbZRkcyuDWNahMRQ7U2l2XbWf2te4NjgATB6n99SBGGEKNaHX69nH6
	PTHec525jgS4GfK4r40+GNA0AOxTD6FdL1MMpJuxQU2Ktm/99OVSoM9y6p/djug==
X-Gm-Gg: ASbGncuF7MVleXqpOhw/Qt4peYf1bHyTnwJ52pbBhg0taeJPsjTsytybA+a3GiQT1C7
	yqTeL+DpcSWtpwoh9YlIqhaduIh92QMHoFjGLH3+cnxRQfSVKewIUz9V/wEVpO4lF9MDwK+gS/b
	mc8N+65oP2g46CKwPfF5fN7IFZgjYaRwwA1Th09C5S7EBnIwCtx2UUuC0ly5c5qCVtfTVq7+lW2
	pgyOES/cJIE+Gd8NoJXL3rUuebcBh20yWB70toQUjSRL0naFWS7GAP9/WscokDJDGHEYmZvD1CE
	CDvblgZE0YUzRTvxrT80YVqCDjM5DgPiiiO/VwLCSNqxHXO7LCL7O985TcbA59F6EJRKGoFxsg=
	=
X-Received: by 2002:a05:620a:8811:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7c53c0aabe8mr40488685a.4.1741362644494;
        Fri, 07 Mar 2025 07:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJbVW//Hd7MkBfbQxMBNrneqKSkHySglXtj4bk8ymVE1LQpMC61/SkaXOudIU+dGIzv8U3DA==
X-Received: by 2002:a05:620a:8811:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7c53c0aabe8mr40485785a.4.1741362644127;
        Fri, 07 Mar 2025 07:50:44 -0800 (PST)
Received: from [192.168.1.61] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5339dfcsm258120485a.2.2025.03.07.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:50:43 -0800 (PST)
Message-ID: <566cfe7c-d5df-6407-6058-b78de5519e04@redhat.com>
Date: Fri, 7 Mar 2025 10:50:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>
Cc: Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>
References: <20250115082431.5550-1-pmladek@suse.com>
 <20250115082431.5550-19-pmladek@suse.com>
 <c291e9ea-2e66-e9f5-216d-f27e01382bfe@redhat.com>
 <Z8rmCritDCtNmw64@pathway.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v1 18/19] Documentation/livepatch: Update documentation
 for state, callbacks, and shadow variables
In-Reply-To: <Z8rmCritDCtNmw64@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 07:26, Petr Mladek wrote:
> On Thu 2025-03-06 17:54:41, Joe Lawrence wrote:
>>
>> With that in mind, a livepatch state could be thought of as an
>> indication of "a context needing special handling in a (versioned) way".
> 
> I am not sure about the word "context". But it might be because I am
> not a native speaker.
> 
> In my view, a state represents a side effect, made by loading
> the livepatch module (enabling livepatch), which would need a special
> handling when the livepatch module gets disabled or replaced.
> 

Ok, yeah "side effect" works well here.

> There are currently two types of these side effects:
> 
>   + Changes made by callbacks which have to get reverted when
>     the livepatch gets disabled.
> 
>   + Shadow variables which have to be freed when the livepatch
>     gets disabled.
> 

Right, these are livepatch-native side effects as we're providing the
API to introduce them.  Nothing would stop a livepatch author from using
states to handle their own interesting side effects though.  (I'm trying
to initially think of states in the abstract and then callbacks/shadow
variables are just implementations that tie together in the livepatching
core.)

> The states API was added to handle compatibility between more
> livepatches. I primary had the atomic replace mode in mind.
> 
> Changes made by callbacks, and shadow variables added, by
> the current livepatch usually should get preserved during
> the atomic replace.
> 
>>  Livepatches claiming to deal with a particular state, needed to do so
>> with its latest or current versioning.
> 
> The original approach was affected by the behavior of per-object callbacks
> during the atomic replace. Note that:
> 
> 	Only per-object callbacks from the _new_ livepatch were
> 	called during the atomic replace.
> 

Ah right ...

> As a result, previously, new livepatch, using the atomic replace, had to be
> able to revert changes made by the older livepatches when it did
> not want to keep them.
> 
> This shows nicely that the original semantic was broken! There was
> no obvious way how to revert obsolete states using the atomic
> replace.
> 
> The new livepatch needed to provide callbacks which were able to
> revert the obsoleted state. A workaround was to define it as
> the same state with a higher version. The same state and
> higher version made the livepatch compatible. The higher
> version signalized that it was a new variant (a revert) so that
> newer livepatches did not do the revert again...
> 
> 
>> A livepatch without a particular
>> state was not bound to any restriction on that state, so nothing
>> prevented subsequent atomic replace patches from blowing away existing
>> states (those patches cleaned up their states on their disabling),
> 
> I am confused here. Is the talking about the original or new
> semantic?
> 

... so nevermind about this.

> In the original semantic, only callbacks from the new livepatch
> were called during the atomic replace. Livepatches were
> compatible only when the new livepatch supported all
> existing states.
> 
> In the new semantic, the callbacks from the obsolete livepatch
> are called for obsolete states. The new livepatch does not need
> to know about the state. By other words, the replaced livepatch
> can clean up its own mess.
> 

Yes, the new model means that the last livepatch providing the state
also handles its cleanup on its way out. This is much more intuitive
than the previous semantic (for which I missed the step above :)

>> subsequent non-atomic replace patches from adding to the collective
>> livepatch state.
> 
> Honestly, I do not think much about the non-atomic livepatches.
> It would require input from people who use this approach.
> It looks like a wild word to me ;-)
> 
> I allowed to use the same states for more non-atomic livepatches
> because it might make sense to share shadow variables. Also more
> livepatches might depend on the same change made by callbacks
> and it need not matter which one is installed first.
> 

IMHO the non-atomic world only made sense with cumulative patches.  I
see some folks reporting that separate operating groups are layering
non-atomic patches across subsystems and my head spins.

But we are going to need to consider the use cases (or perhaps prevent
them) for the eventual documentation.

> 
>> This patchset does away with .version and adds .block_disable.  This is
>> very different from versioning as prevents the associated state from
>> ever going away.  In an atomic-replace series of livepatches, this means
>> once a state is introduced, all following patches must contain that
>> state.  In non-atomic-replace series, there is no restriction on
>> subsequent patches, but the original patch introducing the state cannot
>> ever be disabled/unloaded.  (I'm not going to consider future hybrid
>> mixed atomic/not use cases as my brain is already full.)
> 
> Yes, this describes the old behavior very well. And the impossibility
> to remove existing states using the atomic replace was one of the problems.
> 
> The API solves this elegantly because it calls callbacks from
> the replaced livepatch for the obsolete states. The livepatch
> needed to implement these callbacks anyway to support the disable
> livepatch operation.
> 
> And there is still the option to do not implement the reverse
> operation when it is not easy or safe. The author could set
> the new .block_disable flag. It blocks disabling the state.
> Which blocks disabling the livepatch or replacing it with
> a livepatch which does not support, aka is not compatible with,
> the state.
> 
> 
>> Finally, the patchset adds .is_shadow and .callbacks.  A short sequence
>> of livepatches may look like:
>>
>>   klp_patch A               |  klp_patch B
>>     .states[x]              |    .states[y]
>>       .id            = 42   |      .id            = 42
>>       .callbacks            |      .callbacks
>>       .block_disable        |      .block_disable
>>       .is_shadow            |      .is_shadow
>>
>> is there any harm or confusion if the two patches' state 42 contained
>> disparate .callbacks, .block_disable, or .is_shadow contents?
> 
> Yes, two incompatible states with the same .id would break things.
> The callbacks won't be called and the old shadow variables
> won't get freed during an atomic replace.
> 
> It is responsibility of the author of the livepatches to use
> different .id for different states.
> 
> I am not sure if we could prevent mistakes. Hmm, we might add
> a check that every .id is there only once in the patch.states[] array.
> Also we could add a human readable .name of the state and ensure
> that it is the same. Or something like this.
> 

Well, providing the same state twice in the same klp_patch seems highly
likely a bug by livepatch author.  That's worth a WARN?

I'm not sure what to think about the same state id provided by two
klp_patches.  For a atomic-replace series of patches, if the state
content is the same, it's effectively like handing off cleanup
responsibility for that state to the incoming patch, right?  If the
state content changes, that would mean that the incoming patch is
redefining the state... which could be ok?

> Yeah, as I said. The non-atomic-replace world is a kind of jungle.
> It would require some real life users which might define some
> sane rules.
> 

Yup.  I can kinda grok things with cumulative non-replace, but it gets a
lot harder when considering other use cases cases.  I'll put non-replace
aside for now and continue diving into the patchset.  Thanks for the
explanations!

-- 
Joe


