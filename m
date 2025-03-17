Return-Path: <linux-kernel+bounces-564020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7DA64C23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C893A925E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466491D79B3;
	Mon, 17 Mar 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NKGCmiIR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33B236A7B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210266; cv=none; b=nI99yEEf+WUwEfNkcdm7j/GXE5QqJWh7JDsn6Qk5oVFIy4c1bsQJ+KTdSFj0w1fVE+FtNLoIuPJIDkKITb/q80fvapcBk1jMiz2KckJBnArmN/+qbK1Y9qrCLLVXehMJns32QO1kHivyXwev4pbYV25EfeZhvau2r9kjn4h/PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210266; c=relaxed/simple;
	bh=zBMrzjhDEoENG0cx7jVM5zbDjkh5Hafdqv8uGRyG+EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuAIQpvADlPLgUQglOuDUqEBWlCMPDIFLZE8AYplnFLO3Ee18SohxmwTRUQ8XufJkhMhtUn/ajZ2/Chgm5OV6g1lHxYozZkybhPY0MN34g9w4cX1K6eXr/UnGo8NpgSbQSrk8E2hJYhAK7v/7Yv95sGucL+Rb0hoZCsxBMxUaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NKGCmiIR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so20126805e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742210262; x=1742815062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjO8wZhfLshl3t4eiJF/ZoYHpW+SANCczo4fSdh+4pM=;
        b=NKGCmiIRO8cYqPbNv9ZpwvpBm3ZbjsHq44Vnni7Z5hVXAtel032Gn17kFPL5MNj3/T
         iAI2PdsvVFCtcXkbfks8aKMdXXyK5DUwB+8ofKI6OahM9qdDI6ftMNTiIS/pVj5XZLd2
         E4f7mOJeGrxEAOCFk3NG+JhMNthL/Z0N1z92bRegUwEoR7UFfpCglug6dCq2NS0nqeph
         VahUgwH0pN5X888wJfqR9x36HYyX3mN8MSypSOqhmxDg2DqZX76/EZ91hC7Les4kzMFc
         Dj6yGytHZQpLHbhsVttKBJ1Lu/n4lFQH9cmU5iTwIAbL8Bb+glLYDu/2OcteTs8iccYl
         dRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210262; x=1742815062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjO8wZhfLshl3t4eiJF/ZoYHpW+SANCczo4fSdh+4pM=;
        b=uU/c6sxDj7bAEOzrr7eCi/n5YdjMTTxLwquHrXU4NqILE2kfyDeeT51Gcd9apSQkYR
         FUVY3CfRb+iA/jnQ+wD196sAUUbBunatJzmOLr2b75F1NG93rCiHxpZBrCvumlablxH4
         Y+yXZfis9hDM7vNAnQzg3iOZqS64XCCnhf43Ff2esLnB0yXD+sxsovN8yH00SZI+KV6/
         58xwAPylms7gmXfR8s2WkdLThZRKObjkmBSGSDa7CiSQEkP6VdNo1nOGx6YdjxRyudBM
         du9O1gLysu9ITkCgsr+QgF6Q0UgKEz5QZQKgGmM5QxwMDvWuy2su6AeLeZYju7OsMQ65
         /X+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwz15OWlraAfspDQV7jH8XtmAmKigAB6s5pGrC1vybJWv/WCDRg7CFHRd0Mye5MwSZdDneLypH8o1PVDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypi5Uo2EjcYF6vkEjFGEB7/17HSd2Sjwu01DCQgR637MjC6qB1
	GhBguz0Yv2OUAn7bWJOlB9kIKKV6GBGzlAmIE2U5VROPdhLtZzXg3CD5WMLENY4=
X-Gm-Gg: ASbGncsNOsIzQ+cfZ4xppXIsYLIt5AlKhAvfmD639w0HvMeO/y6AwFQZ2bANkLpsOof
	RagTN1XpwW9/L2hfjAUrzEFcd2OCR8a/6ennoGqlQz6z3iHcdDC6vc70ihB7Gf0HB3h1nX3m7Hq
	ny97M2Y3nYp+OOjA1s7af97cWy+PQ6EOHU8xNyUliLwuPAn2mKWO4DMbl7tjx3K734//OZDxQUq
	yYqa7jApP+XKc8oFTeAmj3pnRT7Il3ngrIFWEbrldf6+KqMOkrJnhIGVZt1FzGD74ZBp+aUlY8I
	Ug6LuBFmbJzWc9r4XnOSejytUoa9zWFP0rwVjM3jPpXRbU0gCw3PtikHJQ==
X-Google-Smtp-Source: AGHT+IFRKO1J7Kmy3N9ZPTGo03XaSalHTdVs0NfUTHKX0BeDLIXyoYs7wREqe3Jxq+EOFVfXXugO9A==
X-Received: by 2002:a05:600c:548e:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-43d1ec74ec4mr122834825e9.3.1742210262577;
        Mon, 17 Mar 2025 04:17:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe6a1c7sm101845505e9.39.2025.03.17.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:17:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:17:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v1 18/19] Documentation/livepatch: Update documentation
 for state, callbacks, and shadow variables
Message-ID: <Z9gE1B__mP6F0b9N@pathway.suse.cz>
References: <20250115082431.5550-1-pmladek@suse.com>
 <20250115082431.5550-19-pmladek@suse.com>
 <c291e9ea-2e66-e9f5-216d-f27e01382bfe@redhat.com>
 <Z8rmCritDCtNmw64@pathway.suse.cz>
 <566cfe7c-d5df-6407-6058-b78de5519e04@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566cfe7c-d5df-6407-6058-b78de5519e04@redhat.com>

Hi,

I am sorry for the late reply. I have read the mail on Friday and then
forgot to come back to it last Monday...

On Fri 2025-03-07 10:50:42, Joe Lawrence wrote:
> On 3/7/25 07:26, Petr Mladek wrote:
> > On Thu 2025-03-06 17:54:41, Joe Lawrence wrote:
> >> Finally, the patchset adds .is_shadow and .callbacks.  A short sequence
> >> of livepatches may look like:
> >>
> >>   klp_patch A               |  klp_patch B
> >>     .states[x]              |    .states[y]
> >>       .id            = 42   |      .id            = 42
> >>       .callbacks            |      .callbacks
> >>       .block_disable        |      .block_disable
> >>       .is_shadow            |      .is_shadow
> >>
> >> is there any harm or confusion if the two patches' state 42 contained
> >> disparate .callbacks, .block_disable, or .is_shadow contents?
> > 
> > Yes, two incompatible states with the same .id would break things.
> > The callbacks won't be called and the old shadow variables
> > won't get freed during an atomic replace.
> > 
> > It is responsibility of the author of the livepatches to use
> > different .id for different states.
> > 
> > I am not sure if we could prevent mistakes. Hmm, we might add
> > a check that every .id is there only once in the patch.states[] array.
> > Also we could add a human readable .name of the state and ensure
> > that it is the same. Or something like this.
> > 
> 
> Well, providing the same state twice in the same klp_patch seems highly
> likely a bug by livepatch author.  That's worth a WARN?

Yes, I agree. I'll add the check and warning in the next revision of
the patch set.


> I'm not sure what to think about the same state id provided by two
> klp_patches.  For a atomic-replace series of patches, if the state
> content is the same, it's effectively like handing off cleanup
> responsibility for that state to the incoming patch, right?

Exactly. And I could imagine an usage of the same state even without
the atomic replace. For example, more livepatches could share the same shadow
variable. Or they might need the same semantic change of a data
structure which would require updating the data by the state callbacks.


> If the state content changes, that would mean that the incoming patch is
> redefining the state... which could be ok?

Using the same state .id for different purpose is _not_ ok.

We could also imagine the state as a reference count of its users.
The pre_patch/post_patch callbacks are called when it is introduced
(refcount goes from 0 -> 1). And the pre_unpatch/post_unpatch
callbacks are called when the state is being removed (refcount
drops from 1 -> 0). [*]

This won't work when two different states share the same .id.
The callbacks won't be called when the 2nd one is added
or when the 1st one is removed.

That said, I do not know how to check that two states have different
semantic when the atomic replace is _not_ used. We could prohibit it.
But I think that there are valid use-cases, especially when
using cumulative livepatches. So, I would keep it allowed.

[*] Note that the current code does not count to refcount number.
    It just checks whether the state is used in other enabled livepatches,
    see is_state_in_other_patches().


Best Regards,
Petr

