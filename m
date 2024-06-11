Return-Path: <linux-kernel+bounces-210653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F89046CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC5C1F259F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F76155381;
	Tue, 11 Jun 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGNiR/Pv"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9815539A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144006; cv=none; b=UAkzpQjS4U4GJdNv+WqSYMWzERTwKgPekfXF554V2JgmCvxgvGa9k6Efndd/urOMsWB//ofju22yak3coBnX4eCAt24Rs76o1S1L3oTkKVxae6r2Ytk2+ZiuR+kXlqk+dqhnweaPT/94CujHbNDApDfmCSP+O4uZP9nGy/lR9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144006; c=relaxed/simple;
	bh=hNxV7nUm4BZp3aHzOz33n9VM+ORBdtrunIf7qmuXuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUqwT9OWztWhul7cNbVWdjj8WrXp1yxQo4bljMJS5KGjm4KdEH9mP+xx9oHrnIUXuChJd8byf7PDI1A9VRMUnoomDufeYDzqX+frkgoBD7pSBz1pjQI/GAOcJSLg8c6PIAdofZgNGPj8tw8bLSbiFwrixQt3T5wf1+nOO0es6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MGNiR/Pv; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254871388d3so2215668fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718144004; x=1718748804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/RbUlD9RSy3SmNM3pNSCFE7to3GVSt1XCBQ/rScoWI=;
        b=MGNiR/Pvz4cL+/fS+FxIYotOq7ol2dhmzPH8ECXONwJbzS5woCdsV0xLD+x9hofEGo
         N00p0/43qqXOnZtdSBzYfzqTC2NxZ9tYLEJMYizei5N0KcvXtKwO2xVuu17VB3vhXaGA
         LwoJvpok2QsJsJIZih0pAN5/hpcIEtO3j8URU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144004; x=1718748804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/RbUlD9RSy3SmNM3pNSCFE7to3GVSt1XCBQ/rScoWI=;
        b=LUc4ja7gJpHsrE69Otnw4DxJkXBe5DOl8h+x+086KnSjvAbTmy6m0CNBN7fkNJ3JKB
         5c7GX1um7C2yaZcn3JhU/mrkzo9HBKe7QYDFq55vzgEVwugTsUFbwGTtDmHHqM5yTS8Z
         nti7j6jkTvQcfwgZCb2P4vLW77Ae96mDl8XKD5Ld8u3Z9KRymcUUVr0uxVYQOueINdX/
         33LkR9P+HVvB7mqFzZB1vkg/pdkfNnSBP2Bca2RZ1uC0ppgZGQh1woosRv6K0TJwLCZr
         9JjlHPYt9CTSfH0oEU2H4CuL3kBF8r/9b2FZKUa18IyTIc7lw5qxiBHXcyctfpEMEwqL
         OSTA==
X-Forwarded-Encrypted: i=1; AJvYcCVPxRVbixDil37Frz9SRTUDMqx1ny/UwkF349lRsdeH5gGugDzSGFLIZbWWvGRWa8weyVIy8VlURsaCbhinzY/yRHhmu+Ys9E8/w/Gg
X-Gm-Message-State: AOJu0Yx6kZmGY38N/IhNt/yBxQDMKOFtx5dKVhapPQ3J+R28Y9fcoxSF
	bbdkpdDKu3VSZTjkK9Bj72gwxCwehW50kaj7yXBk2lw9aWU9hWZLWHEeGMqqAuJznfsNiDSqqEa
	bkfKh9XzHn+4t2zp8PqtlMTySQxrIdEqJNZHB
X-Google-Smtp-Source: AGHT+IEJHs/owLDHBz61i5sXWUn8lCoKIE5qfi2LpoqdDH4d52H8W07OJU7MgzfJFQiAbVeL8ORu7ExwgY5tgNYlY6s=
X-Received: by 2002:a05:6870:c0d1:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-25514c17af0mr165271fac.19.1718144003936; Tue, 11 Jun 2024
 15:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606224035.3238985-3-aruna.ramakrishna@oracle.com>
 <20240610213934.3378947-1-jeffxu@chromium.org> <2DB720B0-0921-4912-8C5F-F0EDDF77845D@oracle.com>
In-Reply-To: <2DB720B0-0921-4912-8C5F-F0EDDF77845D@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Jun 2024 15:13:11 -0700
Message-ID: <CABi2SkVZA0-7_PPbvycaojr0qBPVn7DPW1F1CpNTZwT_Hi0xiQ@mail.gmail.com>
Subject: Re: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Keith Lucas <keith.lucas@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	Andrew Brownsword <andrew.brownsword@oracle.com>, 
	Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>, 
	"jeffxu@google.com" <jeffxu@google.com>, "jannh@google.com" <jannh@google.com>, 
	"keescook@chromium.org" <keescook@chromium.org>, "sroettger@google.com" <sroettger@google.com>, 
	"jorgelo@chromium.org" <jorgelo@chromium.org>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:05=E2=80=AFAM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Jun 10, 2024, at 2:39=E2=80=AFPM, jeffxu@chromium.org wrote:
> >
> > The orig_pkru & init_pkru_value is quite difficult to understand.
> >
> > case 1> init_pkru: 00 (allow all)
> > orig_pkru all cases  =3D> allow all
> >
> > case 2> init_pkru: 01 (disable all)
> > Orig_pkru:
> > allow all 00 =3D> 00 allow all.
> > disable all 01 =3D> 01 disable all.
> > disable write 10 =3D> 00 allow all <--- *** odd ***
> > disable all 11 =3D> 01 disable all
> >
> > case 3> init pkru: 10 (disable write)
> > allow all 00 =3D> 00 allow all.
> > disable all 01 =3D> 00 (allow all) <----*** odd ***
> > disable write 10 =3D> 10 allow all
> > disable all 11 =3D> 10 disable write <--- *** odd ***
> >
> > case 4> init pkru: 11 (disable all)
> > orig_pkru all cases =3D> unchanged.
> >
> > set PKRU(0) seems to be better, easy to understand.
> >
>
> I=E2=80=99m not sure I follow.
>
> The default init_pkru is 0x55555554 (enable only pkey 0). Let=E2=80=99s a=
ssume the application
> sets up PKRU =3D 0x55555545 (i.e. enable only pkey 2). We want to set up =
the PKRU
> to enable both pkey 0 and pkey 2, before the XSAVE, so that both the curr=
ent stack as
> well as the alternate signal stack are writable.
>
> So with
> write_pkru(orig_pkru & pkru_get_init_value());
>
> It changes PKRU to 0x55555544 - enabling both pkey 0 and pkey 2.
>
Consider below examples:

1>
The default init_pkru is 0x55555554 (pkey 0 has all access, 1-15 disable al=
l)
and thread has PKRU of 0xaaaaaaa8 (pkey 0 has all access, 1-15 disable writ=
e)
init_pkru & curr_pkru will have 0x0
If altstack is protected by pkey 1, your code will change PKRU to 0,
so the kernel is able to read/write to altstack.

2>
However  when the thread's PKRU disable all access to 1-15:
The default init_pkru is 0x55555554 (pkey 0 has all access, 1-15 disable al=
l)
and thread has PKRU of 0x5555554 (pkey 0 has all access, 1-15 disable all)
init_pkru & curr_pkru will have 0x55555554
If altstack is protected by pkey 1, kernel doesn't change PKRU, so
still not able
to access altstack.

3> This algorithm is stranger if inti_pkru is configured differently:
The init_pkru is 0xaaaaaaa8 (pkey 0 has all access, and 1-15 disables write=
.)
and thread has PKRU of 0x55555554 (pkey 0 has all access, 1-15 disable all)
init_pkru & curr_pkru will have 0x0 (0-15 has all access).

Overall I think this is a confusing algorithm to decide the new PKRU to use=
.

> After the XSAVE, it calls update_pkru_in_sigframe(), which overwrites thi=
s (new)
> PKRU saved on the sigframe with orig_pkru, which is 0x55555545 in this ex=
ample.
>
> Setting PKRU to 0 would be simpler, it would enable all pkeys - 0 through=
 15 - which,
> as Thomas pointed out, seems unnecessary. The application needs the pkey =
it
> enabled for access to its own stack, and we need to enable pkey 0 under t=
he hood
> to enable access to the alternate signal stack.
>

I think you are referring to Thomas's comments in V3, copy here for
ease of response:

>User space resumes with the default PKRU value and the first thing user
>space does when entering the signal handler is to push stuff on the
>signal stack.
...
> If user space protects the task stack or the sigalt stack with a key
> which is not in init_pkru_value then it does not matter at all whether
> it dies in handle_signal() or later when returning to user space, no?

The userspace could register a custom handler (written in assembly) to
change PKRU and allow access to the stack, this could be written in such
that it is before pushing stuff to the stack. So all it requires is
that the kernel
doesn't SIGSEGV when preparing the signal frame in sigaltstack, this is
where PKRU=3D0 inside the kernel  path helps.

Even today, without patch, one can already do following:
1> use PKEY 1 to protect sigaltstack
3> let the thread have all access to PKEY 1
3> send a signal to the thread, kernel will save PKRU to the altstack corre=
ctly.
4> kernel set init_pkur before hands over control to userspace
5> userspace set PKRU to allow access to PKEY 1 as the first thing to do.
6> on sig_return, threads have PKRU restored correctly from the value
in sigframe.

That is why I consider "let kernel to modify PKRU to give access to
altstack" is
an ABI change, i.e. compare with current behavior that  kernel deny
such access.
It might be good to consider adding a new flag in ss_flags.

Thanks.
-Jeff

