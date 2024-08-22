Return-Path: <linux-kernel+bounces-297295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A295B5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFD61F2272A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7E1CBE85;
	Thu, 22 Aug 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DD0iR9Q"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C651C9DE7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331522; cv=none; b=E7znk1M3syq5ZrmdEJERNJ5rMbqoZQYYXmp3AHbaQBTbh373vDtKy43f5C5DeEOneAyuZjHmjfDV2Bfqf0axJckS3hy6RV8gwL6Iq7z5DCAPokSnU2phXrLX3BAhG9jPJrnf9hOUs2m+UGq4CPzi2E8b4BdnM/9Si1qVGSWz6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331522; c=relaxed/simple;
	bh=YKwteYP82haLOcFnCOnu5PEZstb4pn5XmxZSe6SLH08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpRkU4L1s8D2bm9cUgrL/Afe7xzqETAO+Y6ByVjJMy7szR62JqfWtrDItRIRRS3GewznQhQPyw6l5vFUhMzhAfomW++egGEoRuJNmHAzWqT/RM066w7pFWdOCwBkoZw97wXJrkN8O4k9ijqfKYz7nCgopW1/AT1oHSiH23l9FiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DD0iR9Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428119da952so5937345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724331519; x=1724936319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v1ljrEV8B1sl82whHi7rcYWs7is5tEbFgZoqdCgmEg=;
        b=4DD0iR9QNwwAEzY1ZevAWCvpj/PnzlliPRf3OKJQT8lQ6XeKQ6aOY2rxV3RZJFpQS0
         OiX3TQtRJTGXV8P31AUegTFFBDv3T3X5qhLLEm1cEiIKLxpHlcWJPY153MsZLMaET9ta
         2KksLrbQcFRqAnTqHMDr9n9QSj55hNJK0vQ1/RAzv6zA5IT33ZAv/S5yDOop/EdzCeSv
         eTg2s+2JZIDmOW0C3tsliynHKRQRczu5lxh/19JlXaSHVegUsGEnUepVBI6A6hLxV+4c
         h8HPxOkarU7tI2xzs5nAnzOzlfXiqqYoG9DeWEsH2osDk430VyUZ38aiivNXKI/htYgx
         Sdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724331519; x=1724936319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v1ljrEV8B1sl82whHi7rcYWs7is5tEbFgZoqdCgmEg=;
        b=qgYs0BIu1ex7S1AgUW/ZJbAJtdmhdDo3EwG048mtP0NQNrjyFyZ2V+mLjgi/TjPJcp
         jKvGMye21ZOfG0iWypXgVVtyN6XpPPR1Aq3FD+1KFZT3YxkXTzyXTnQptyujRufSBXAG
         JgcoU+dcLF3PEvoG9BDzM08sN5ZDrRU+lUkujlNTCZcwTHqmlzznFZS76EL7kPR479bc
         YSRJd6hlEqgtJYb6BWryDO9FNT9k3h9D72wQKNYYKhD4OxtdFXRsf5BZ3uh5ub2C9x51
         ZUFzXD444BwKy8wosECbOWfgnauxmHI21kBbBjH9mxBJ7fCaH4X78pYgAT7uaVXW4dLo
         QDUw==
X-Forwarded-Encrypted: i=1; AJvYcCVEPANlK1st+WOQ4KVrq7l7CVgmkxaE+Hbrr+P+WPwckTg3Ld/D7EjR0wMTy6w2zQGQAlJT/70+/soGLks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVA5/Om6SM6/dFfWa+uMqC0AikXbJnGGdxkGlPaQREV3IZF02h
	AirsYR5mQ6vCwTxKJDqOMWm6LJowQ0BChoYt+S25T32QJAq39/+ipLxaLgeO/Yy27rwfqSL97cy
	PdEzRggscK0BMUOCpoQYZm/3u3bXYwTMWpBum
X-Google-Smtp-Source: AGHT+IGQK+oMCGpVMlGDTiPQ1AZnVSQ0UV9HAjnelAkl0ox1QHvKMel3zzthgoJQcVcwxgCsltxdRO+B3DXGwMM1kp8=
X-Received: by 2002:a05:600c:524e:b0:427:9dad:e6ac with SMTP id
 5b1f17b1804b1-42abf0a9948mr38113705e9.34.1724331518606; Thu, 22 Aug 2024
 05:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813222548.049744955@infradead.org> <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
In-Reply-To: <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Aug 2024 08:58:26 -0400
Message-ID: <CAJWu+opjcGs8vs9=NcgSU_nuWZE+z73rMaOO7s7OX_=AHvSOiQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:41=E2=80=AFPM Joel Fernandes <joelaf@google.com> =
wrote:
>
> On Tue, Aug 13, 2024 at 6:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > Hi,
> >
> > These patches apply on top of the EEVDF series (queue/sched/core), whic=
h
> > re-arranges the fair pick_task() functions to make them state invariant=
 such
> > that they can easily be restarted upon picking (and dequeueing) a delay=
ed task.
> >
> > This same is required to push (the final) put_prev_task() beyond pick_t=
ask(),
> > like we do for sched_core already.
> >
> > This in turn is done to prepare for sched_ext, which wants a final call=
back to
> > be in possesion of the next task, such that it can tell if the context =
switch
> > will leave the sched_class.
> >
> > As such, this all re-arranges the current order of:
> >
> >   put_prev_task(rq, prev);
> >   next =3D pick_next_task(rq); /* implies set_next_task(.first=3Dtrue);=
 */
> >
> > to sometihng like:
> >
> >   next =3D pick_task(rq)
> >   if (next !=3D prev) {
> >     put_prev_task(rq, prev, next);
> >     set_next_task(rq, next, true);
> >   }
> >
> > The patches do a fair bit of cleaning up. Notably a bunch of sched_core=
 stuff
> > -- Joel, could you please test this stuff, because the self-tests we ha=
ve are
> > hardly adequate.
> >
> > The EEVDF stuff was supposed to be merged already, but since Valentin s=
eems to
> > be doing a read-through, I figured I'd give him a little extra time. A =
complete
> > set can be found at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/=
prep
> >
>
> So I booted queue.git sched/core branch on a newish Chromebook (after
> applying 700 patches for making it boot and spending 2 days on it
> since we boot old kernels -- I wasn't joking when I said I would carve
> some time up for you this week :P).
>
> With sched/core , it boots fine with core scheduling disabled, but
> when core scheduling is enabled I am getting hard hangs and
> occasionally get to the login screen if I'm lucky. So there's
> definitely something wonky in sched/core branch and core sched.
> I could not get a trace or logs yet, since once it hangs I have to
> hard power off.
>
> I could bissect it tomorrow though since it looks like a manageable
> set of patches on 6.11-rc1.  Or did you already figure out the issue?
>
> I am based on:
> commit aef6987d89544d63a47753cf3741cabff0b5574c
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Jun 20 13:16:49 2024 +0200
>
>     sched/eevdf: Propagate min_slice up the cgroup hierarchy

One of these 29 in sched/core broke core-scheduling, causes hangs.
Haven't narrowed it down to which. Not much time today. Will probably
try to collect some logs.
https://hastebin.com/share/uqubojiqiy.yaml

Also I realized I should apply the 9 in this set too. But very least
it appears the above 29 broke core-sched vs bissection, probably the
delayed-dequeue or task-pick rework?

I will try the sched/prep branch now, which has the 9 in this set too..

 thanks,

 - Joel

