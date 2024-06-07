Return-Path: <linux-kernel+bounces-205853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D021790014D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C268282CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460B18628B;
	Fri,  7 Jun 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UamXqT+D"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5461FCE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757816; cv=none; b=MqmW15lnt5XqY/DIqAN9d77uBfI1mgB+dpLa8VHBPfvqD5fikUZyw/8cMNi0Az29r+TLv2GlrNqt1Ean4bqq2AwT4l0pf07gSIEtocq15MRJOWjDqWSmvC/ZPXGea2nP5T4qVCNIHtDum6baXKdAnhvdGF9SzH0HoFMSfuaLZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757816; c=relaxed/simple;
	bh=/+d7Wn/qMudLa2zAxLbxLZiAOTzrsS9FyyESoHVhefk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjrQeN1RDeCkcnKm7WPULG9O3wGyVoQYgrdvDzXIhCajMSHp1b+db2ciQFDLJRHFCikuECLGfN5FT0r8qJA9ldiGTqh2rgqdWKqb+TOBk6I+iNNatPCmQaYVYgvfs9ptm6NFKT0Ji9lTW7NmI4hBTomeuCrr0+F9xW5Srw4w+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UamXqT+D; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35dce6102f4so1643909f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717757813; x=1718362613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJ/zPWu64aSX8lW8Me3yRm5L5VkYOhKfhalZeis3Aps=;
        b=UamXqT+DYlCiLsZlguhSckzVB1gPrCfxQ4sNLNHrHo237OC4+3GtjSb1phkQED0h72
         //CFMbXTTdsocAn2S3k/d/6EXHQc2m0BC2+/H/aXvwGl/OnyxEo3ZnxVuISxmJgBXSz8
         B+0EatsgTQTOcNx9Bup/CS57+l1VYkbQwVDRXF9yzikf2rs+hFPywecag+lQuqTTNwIJ
         APwicOkkHJyX+Ynzdn5Ho0YPs/s+EtXZJpHlDGolxO5MjGeaOLvlCi9XNajjcazQwERi
         BjeOsNiI8Vj0Rlgc669SOCsg7OC3/V8ymDiYR1g5wU7ADi4t1lqVazWNFwNAEZ9BKpu+
         OPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757813; x=1718362613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ/zPWu64aSX8lW8Me3yRm5L5VkYOhKfhalZeis3Aps=;
        b=t/4A2V1UMiLL0m5aJ0fTQv4YZGRB/ejazPQhqg1UitISzyaRMXZJpbaYrKJ0t6n2e+
         ajnso3u48wSdo0ULWccgLOMlIXv8eH9p8eeqVNFCzdLm/AbR8f1bRX9XP+WOj8XrO8bY
         u2yARJ6lAVeZ84KBZwGD6OR92FXFAni53PHiLSYVB95fMJhYxtyGdxTj60sAFD0H4Da6
         R2vkLVTp1snAFtg8N7s6dpm5vXnxgSqQpYjMRniFGJFJydub9lGtDa/ewYd09AhmhBE+
         8kjk5xFs0GLnnECe2DS9AO0PMFxSc0lrKnrO2AqIx+Ns7b7DBvkjyj+RsvG2U/FeIiU0
         ebMg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8VnQ6MF4wrr6+JOCwLmLxZQVpKvW//kYPa4Gdh674z9a32JkOuwrhO0WUn+B7ZHnN/Ey4+X7m+WY6QdQzzFRs2rAWHEUawCHUcN5
X-Gm-Message-State: AOJu0YyRs0V275285HRe8VLE2j3mdMaVil3pVSmu+9U7Jmr1UU3v+0ON
	WFlsXU33mDhWylRjXTmSvq2Ur9D0i/78UxtzR96aWQ6v2mKLOFC0
X-Google-Smtp-Source: AGHT+IGreFV8e4dCstwBQMzX7yJXkRZGntuqUmIqWtp1xbf6uyUvnaeFN290QNmyReyJF+vy2kd7hA==
X-Received: by 2002:a5d:5686:0:b0:354:fb1d:694e with SMTP id ffacd0b85a97d-35efed64b39mr1767775f8f.29.1717757812279;
        Fri, 07 Jun 2024 03:56:52 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d2e73dsm3808103f8f.16.2024.06.07.03.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:56:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 7 Jun 2024 12:56:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/3, v4] x86/fpu: Remove init_task FPU state
 dependencies, add debugging warning for PF_KTHREAD tasks
Message-ID: <ZmLncUYpm8A0P02N@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
 <ZmFziN0i10sILaIo@gmail.com>
 <20240606120038.GB22450@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606120038.GB22450@redhat.com>


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 06/06, Ingo Molnar wrote:
> >
> > I changed the debug check to test for PF_KTHREAD, and to return NULL:
> >
> > +#ifdef CONFIG_X86_DEBUG_FPU
> > +struct fpu *x86_task_fpu(struct task_struct *task)
> > +{
> > +	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
> > +		return NULL;
> > +
> > +	return (void *)task + sizeof(*task);
> > +}
> > +#endif
> 
> How many users enable CONFIG_X86_DEBUG_FPU?

Ubuntu does:

  kepler:~/tip> grep X86_DEBUG_FPU /boot/config-6.*
  /boot/config-6.8.0-35-generic:CONFIG_X86_DEBUG_FPU=y

Fedora doesn't:

  kepler:~/s/tmp> grep X86_DEBUG_FPU ./lib/modules/6.9.0-64.fc41.x86_64/config
  # CONFIG_X86_DEBUG_FPU is not set

So it's a bit of a hit and miss, but at least one major distribution does, 
which is all that we need really.

> [...] Perhaps it makes sense to check PF_KTHREAD unconditionally for the 
> start, them add if (IS_ENABLED(X86_DEBUG_FPU)). But I won't insist.

I think Ubuntu ought to add enough debug coverage - and this check isn't 
exactly cheap, given how it replaces a simple build time structure offset 
with a full-blown function call ...

> For the record, I think we can later change this code to check
> 
> 	task->flags & (PF_KTHREAD | PF_USER_WORKER)
> 
> but I guess this needs some (simple) changes in the ptrace/coredump
> paths.

Sounds useful, would you be interested in cooking up a series on top of 
tip:master (or tip:WIP.x86/fpu), if you are interested and have the time? 

I'll send out one last iteration of this series today, otherwise the 
changes seem close to final for an upstream merge via the tip:x86/fpu tree.

Thanks,

	Ingo

