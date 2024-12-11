Return-Path: <linux-kernel+bounces-442090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1A9ED7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E38188B147
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB608231A5A;
	Wed, 11 Dec 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+QIUAOw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37B2288F7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950612; cv=none; b=Yoe/8iSYQH/hyyMT259d1pu13KkAc5TZ4nkWc5GhGtne25C3j90DUhpkJ2mFLuGDJT6/nhO6x3Zsb3zDwzENE6hkaGkB3Dy0N43UO2Bq5GaCHVymuJvyNQ2YRDy1d8JEOmfjOp/9U2EjFON3qhwOvvObyoryfm/wErTEEwsKDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950612; c=relaxed/simple;
	bh=MdA6jUjSFbi6LXtxa7CFaIjgOlJPpUWrkhpWboRBHcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krBzyiS9ggoikLxiZptCmI1VhtUp4x2vSMU8t907F6294eOUJ+PT0k07TWyLNMhvPqgeFb1k9MLA9l/VnZAzItLbF7QL8j7wl9jCowea0ABoq/t/HYg5uJEjC9V2FkTAGGsuwyBj8qjOTZc3UlCW6FH/EgiTve9F7keuu/U0qSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+QIUAOw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2155c25e9a4so1885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733950610; x=1734555410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2bEWtlbySt6ThDuoSUVHIUH+ChNKWKXsxj9RWznny0=;
        b=p+QIUAOwrVXUxVBz56vj9DJVnhzzxSj+2hqD757tvsKuuyoSdGnE6taPpNTJwpZ7OC
         YaZP0wRoSJHJHJtsGAJKFM/FOQxYrblDR+4ru3YM1NpNOrl04HnyFhPW5JvG9Llsw4+P
         JEsnjSgHD6f9iKkSxciXcbT9d09nAGJ9sYCu7TY99gdwmy36U2UWvHPz/suRCsNp9XSn
         ocvpjJNtCdfes5WeYf41bjWMX5UN9GGXdASzcLgGXWOlEyz91gjh1gs4xAOnw8tPlmwO
         nPkhxUAGfFPH0nEXmzOFgCWMRY5Sg/8wEgVTutErus5BykTqx5oxXZS+nDuSAy1QBaYG
         WdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950610; x=1734555410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2bEWtlbySt6ThDuoSUVHIUH+ChNKWKXsxj9RWznny0=;
        b=kT3umE4wuI3/fgmk5M6MS+GjyBdqgQFaKt/L7hB9jAAS0CydV+j2y9nYfIsTt6pjk5
         iFWa2qO5z2XMesk4ohr6kuoZd614e0S1iZ7aj13fDckdqCIvTcZOX0E/vfhY4DaNENMn
         V9pP3UU5JJscPW5Giz9W174qRW8MBkJbhD/uxMhKtpn8CKB+lXcAYLIZ+iYxqAnAeTb9
         Tt8i5knObD/4HDvQtUw1C9e1RQWtQve6xOY2nZYOlyJH0miaNOvR2gyi0B1i4IuQ70M6
         IokB5XmBi4MISs0Lbm0TsbwG4xEmLnLW2viMgujXPJH/keffCraUw3HxMothQRt7N2QA
         g3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXh3QflsctYlyxeEaxDun25lQ8XuBrlrHuT8OwtlF82Cr8EluUSvtSAjw6gJVBJP/CczDyCc5vFMjJP6HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHw9FfdqwAxboml1U7falWG1lMRnTIAugaQPZD4JpQZrzY1UZ
	QvleE0z+HyDOCZZ+Pio7/uHUJHPdJfCTtYACeSSo58blU9I/NY0zlASvrxp3Sg==
X-Gm-Gg: ASbGncsAJa2HUA1dp5qXpc8/hrUuw8wz7I2mPCturfFkMnyU36gxx/N+bUxlrEQKli/
	ytU+LMgAqG1cTBkS9eD2JVqRkSJ7VUqiVt0BOTLgYneDf29K+PZc+dVivhodktuADso1EsLPMEE
	Z+F0NtXYIkPe8OPNqw94JoWZC4axubhEs4z9ZiZtSKPz33dukOBqLOJcw8MsvZKFe6iTJOchu0M
	Qv3h2143LIK9HeCgHVKO8i6uy172TrTELo+sWQVz2ne7AkJ0B0mGw==
X-Google-Smtp-Source: AGHT+IFUNUV8Jrq3x7wIFFEJfhzg2GCvPKk4dGIRi3a8yhYwkgT2llKFjahr6PSlf2mmjBrVxBh3yA==
X-Received: by 2002:a17:902:f98f:b0:215:9327:5aed with SMTP id d9443c01a7336-2178e7378a8mr470435ad.20.1733950609623;
        Wed, 11 Dec 2024 12:56:49 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:31a7:de26:ce93:3f1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa162sm107919945ad.125.2024.12.11.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:56:49 -0800 (PST)
Date: Wed, 11 Dec 2024 12:56:44 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z1n8jOmH3nxXn7du@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <Z1NjCQgwHo5dwol6@google.com>
 <3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local>

On Fri, Dec 06, 2024 at 09:14:58PM +0000, Lorenzo Stoakes wrote:
> On Fri, Dec 06, 2024 at 12:48:09PM -0800, Isaac Manjarres wrote:
> > On Fri, Dec 06, 2024 at 06:19:49PM +0000, Lorenzo Stoakes wrote:
> > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index b1b2a24ef82e..c7b96b057fda 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > > >  		if (!file_mmap_ok(file, inode, pgoff, len))
> > > >  			return -EOVERFLOW;
> > > >
> > >
> > > Not maybe in favour of _where_ in the logic we check this and definitely
> > > not in expanding this do_mmap() stuff much further.
> > >
> > > See comment at bottom though... I have a cunning plan :)
> > >
> > > > +		if (is_exec_sealed(seals)) {
> > >
> > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > I've not tested this scenario so don't know if we somehow disallow this in
> > > another way but note on write checks we only care about shared mappings.
> > >
> > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > the data into an anon buffer and doing what you want with it, here you
> > > could argue the same...
> > >
> > > So probably we should only care about VM_SHARED?
> >
> > Thanks for taking a look at this!
> >
> > I'd originally implemented it for just the VM_SHARED case, but after
> > discussing it with Kalesh, I changed it to disallow executable
> > mappings for both MAP_SHARED and MAP_PRIVATE.
> >
> > Our thought was that write sealing didn't apply in the MAP_PRIVATE case
> > to support COW with MAP_PRIVATE. There's nothing similar to COW with
> > execution, so I decided to prevent it for both cases; it also retains
> > the same behavior as the ashmem driver.
> 
> Hm, yeah I'm not sure that's really justified, I mean what's to stop a
> caller from just mapping their own memory mapping executable, copying the
> data and executing?
> 
That's a fair point. In that case, I think it makes sense to enforce the
seal only when the mapping is shared.

The case I'm trying to address is when a process (A) allocates a memfd
that is meant to be read and written by itself and another process (B).
A shares the buffer with B, but B injects code into the buffer, and
compromises A such that A maps the buffer with PROT_EXEC and runs the
code that B injected into it.

If A used F_SEAL_FUTURE_EXEC prior to sharing the buffer, then it could
reduce the attack surface on itself in this scenario.

> There's also further concerns around execution restriction for instance in
> memfd_add_seals():
> 
> 	/*
> 	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
> 	 */
> 	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> 		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
> 
> So you probably want to change this to include F_SEAL_FUTURE_EXEC, and note
Do you mean adding a case where if F_SEAL_FUTURE_EXEC is in the seals,
then we should clear the X bits of the file and use F_SEAL_EXEC as well?

I don't think the case in the if condition should imply F_SEAL_FUTURE_EXEC,
since the file is still executable in this case?

> your proposal interacts negatively with the whole
> MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED mode set in vm.memfd_noeec - any system
> with this set to '2' will literally not allow you to do what you want if
> set to 2.
> 
> See https://origin.kernel.org/doc/html/latest/userspace-api/mfd_noexec.html
Sorry, I didn't follow how this would impact
MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED. Could you please clarify that?

> > Thanks again for reviewing these patches! Happy that I was able to get
> > the gears turning :)
> >
> > I'm really interested in helping with this, so is there any forum you'd
> > like to use for collaborating on this or any way I can help?
> >
> > I'm also more than happy to test out any patches that you'd like!
> 
> Thanks, I'm just going to post to the mailing list, this is the discussion
> forum I'm making use of for this :)
> 
> I will cc- you on my patch and definitely I'd appreciate testing thanks!
> 
> But yeah, to be clear I'm not done with reviewing this, I need more time to
> digest what you're trying to do here, but you definitely need to think
> about the exec limitations.

Thanks for sending out the patch. I took a look and tested it out and it
definitely makes implementing this a lot nicer!

Thanks,
Isaac

