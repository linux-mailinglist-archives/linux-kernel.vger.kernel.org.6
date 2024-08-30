Return-Path: <linux-kernel+bounces-308990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021A9664DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB014288CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D41B3B2F;
	Fri, 30 Aug 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGrLo0Vf"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B334A1D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030146; cv=none; b=ocBReNoZ91N/si9lMM3P9YYkz/fpVwJk55Yvh4lf6CphOh6Q8QJzZAldfAfRFqdXGINhIWXOn5PXrqgLsg3ZRKpg7ihz5KAziThZGOB3TEf9eBH80kZhzyexxQS/RvIttzEU0hnuFDMy6/B2KoKF0IgLl+iXs4+9kSOaEk1hXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030146; c=relaxed/simple;
	bh=AILzN68lSab8VXNv5fqc9c3V8pHHR6f1qS7FRlmah98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ikt6c3sv6vmPC9cJoXY4FrcRmiz7yLAs47xlwNjMaKnhfgTJ+q+or38psamYAEr7oZzrs8xHF6QobGue6WYVqzzlQR2w2U6OI2nO2gCXwPBcZl4f2/431CCvORwSV4qLV2cFj27uyBk9LTZCbReR6lVG6KRkHA9+lIfA9cuY1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGrLo0Vf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3f163e379so31329761fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725030143; x=1725634943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBqUCjP2z4q8Ck9371f9RZNDmMuqYU2i582bK7SbKLE=;
        b=lGrLo0Vfm4kwjWRY8RR+O4B3LX9Lbc/spKWShiV2y5hGmZ9OY/aNX7lOQZ6QP/nN7C
         yJxow/RS+wRqUBk/Jyn8oIF998RdV2BYmnzNOlTOMUytBan/sAspcQLHhsaefxjWpjpn
         0qqPpvhX4ri5uY8VZ8NHouWCQWUOMQNijTZ4BzAnGpGKHPIaam5GEmgn+mSDu571Dedm
         LhD42bRqsTMf2IXtN0XgaR0LR4yOLA6eQ4asyTcXj6sJLBsQkCAqCurjVoYjFyu6ltIJ
         NPoZgWdMmE6QqvQaXu72nnhpK2kpY2+sImo8DTjn1vlV2D/HgTey8abOaSBcy66ovF1N
         Ip9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030143; x=1725634943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBqUCjP2z4q8Ck9371f9RZNDmMuqYU2i582bK7SbKLE=;
        b=Ywxtb7w0Vw6ZM6/oTBRgXXJM7bGgUKlbX0wv4MMVWdMtwY7gRR3asK1KfZgYSRc/EM
         VhpdqB5bYzrnZYj70feviomWLPIsaLqdxzeeJC1jlL4gNEmzEejjFh6OfQaaHXU5H7A5
         ySZQPKWlv0EHckeSBslgLzdJU+4w6zJ2EWwHPlxmhYdCmINPFWdnnBx4YPYT0ClhBQOl
         82iwueIUUwaUccODTGzSkWdGuERq8wgowHpWhlcJeNCxNdcorZKbWQc4D2CZI2asrJMs
         fH40ynkxLVe78RiwQg1PBZyVPQkV4Ou7+4VHUULv0kzxGRGC/5ipmoQmqGcf39BC8t49
         LkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlfDptx5pwJ3IGX5nBD0SpVxC2ZURGr3yxQizh1iUy7D80UHx90PQzO/dvA/K2EnLbXgokSd6YMUU71xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzywswk94hHN81SLcPXIUolHl1RRViE9/4pjR/SIUHiNSAtZcqy
	xUQbTbUOA28OB6ULxXYGGMu1wOFJ84c7gqcwwOPRh3lGiw1NtORW4LMSWwpJLk64lTn2ffoAgcH
	O3lnl65Bti0hRn6IQN37ZQKMPfMK9cQo1vQWU
X-Google-Smtp-Source: AGHT+IF6OWXhi/QYgrKse/5LBfXmNOIL1XvQcJo43ioM2OsU1D1JREuiMlXv59EKl20qFEzCQyUoqKFlFva0P017LuU=
X-Received: by 2002:a2e:515a:0:b0:2f3:cf43:c2a8 with SMTP id
 38308e7fff4ca-2f6108ae2a1mr43649891fa.42.1725030141793; Fri, 30 Aug 2024
 08:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008f55e4062036c827@google.com> <20240821201338.GA2109582@perftesting>
 <CACT4Y+aSV8ZptNaLqVg+QgOyDn+tJ1WUyBxQ-9hk7joqbmT6GA@mail.gmail.com> <20240824193835.GN25962@suse.cz>
In-Reply-To: <20240824193835.GN25962@suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 30 Aug 2024 17:02:09 +0200
Message-ID: <CACT4Y+bsEPHkzofGZPHkhpj1jnGRwFmqR-scJGX0EXAZLe-Zng@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, syzkaller <syzkaller@googlegroups.com>, 
	syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 21:38, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Aug 22, 2024 at 02:05:01PM +0200, Dmitry Vyukov wrote:
> > > > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > >
> > > Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
> > > annotations for our tree locks, so we _easily_ cross this threshold on the
> > > default configuration.  Our CI config requires the following settings to get
> > > lockdep to work longer than two or three tests
> > >
> > > CONFIG_LOCKDEP_BITS=20
> > > CONFIG_LOCKDEP_CHAINS_BITS=20
> > > CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> > > CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> > > CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> > >
> > > but there's no way to require that in our config (nor do I think we should
> > > really be able to tbqh).  It makes more sense for syzbot to just ignore this
> > > particular error as it's not actually a bug.  Thanks,
> >
> > Hi Josef,
> >
> > We could bump these values, the last 3 are already this or higher on syzbot.
> > Do you know if increasing CONFIG_LOCKDEP_BITS and
> > CONFIG_LOCKDEP_CHAINS_BITS significantly increases memory usage?
> >
> > Ignoring random bugs on unknown heuristics is really not scalable.
>
> This is not a random bug. The warning has been reported many times, it
> does not point to a specific problem in code that uses lockdep but
> rather some defficiency in the lockdep mechanism itself.

By "random" I meant that the predicate is some custom English
sentence, rather than something that can be expressed in the code. So
on the global kernel scale it's hard/impossible to filter out such
reports.

Additional complication here is that the predicate involves knowing
that exactly system calls triggered this warning, since the warning is
generic. We don't generally know what exact syscall sequence triggered
a report. So it would only be possible to ignore "BUG:
MAX_LOCKDEP_CHAIN_HLOCKS too low" globally, which is not good.

> > Consider: there are hundreds of kernel subsystems, if each of them
> > declares a random subset of bugs as not bugs.
>
> "If each of them", no this won't happen. Or, if you add this one and
> reject the others you'll still make people happy.
>
> > What's the maintenance
> > story here? And it's not syzbot specific, any automated and manual
> > testing will have the same problem.
>
> Yes this does not avoid reports but at least it won't be a syzbot report
> that somebody thinks is worth time. Everybody else will be told "ignore"
> or poitned to documentation or the report ignored completely
> (https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#bug-max-lockdep-chain-hlocks-too-low).
>
> > The only scalable way to mark false reports is to not produce them.
>
> In an ideal case yes. So far we have only the workaround with increasing
> the config value (which makes sense on a distro config), otherwise I
> remembet locking guys to suggest some fix but I can't find it now in the
> numerous reports.

I've bumped LOCKDEP parameters in syzbot configs:
https://github.com/google/syzkaller/commit/f4865e39dd0bcae7e5f3f5d59807d6ac9a8a99ba

So this can be closed:

#syz invalid

