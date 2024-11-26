Return-Path: <linux-kernel+bounces-422794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47809D9E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935FB283F43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEA71DED7F;
	Tue, 26 Nov 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d8+r9LOh"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021661AAD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651888; cv=none; b=XNviMbOgwmem504w6mZemc1uSk3A9t3RDa8Kh/Hr5Ah0nEAkljCPcA4m20+lY01tiAEjK/BrvKmiqYJNRNGHn/mWdiLoO+pC7dHHilah8tUeaIgsmWstuCbbUGEC3qB3Ly4/l1gj0HKkruHkcRuFreoBrZ84XdviY9T8YQR+LVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651888; c=relaxed/simple;
	bh=SeH7OIHiUg3z8Wf2hqJkp+pQtUuB6QfuZSWj7tBe97s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK9mT5GQCGG6OODexR2Y3U2V+moVsh7E+/uosxNMnmTIj2aGEVBhxWgXTM4D7a/izn6LbDQyP1hYSKiQ8PZyfieOmN8mgDbIQO9f6Q4SqgE+sAOferr7KGD9DbIbNVVnQEBLGvxp7SG4Whe8L/EdTJhwMgTLpM7hOsyUvlsNA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d8+r9LOh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d071f70b51so1168026a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732651884; x=1733256684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBieZ/H43H1parSNnvMLRoyFZN/PdHvN6lrqybfxtdA=;
        b=d8+r9LOhkV+JUSTJLowweRNej7tVGFJ1Uoef8EJQa2nWLGVRzylzcaZCwrMK9TtRAb
         prBNA/yKkxwzDDyxjOtNTIt5R9h0xvPVXol1eHImrrs9YjjZicp8auW8YexgulevTDdQ
         AOCDTMbWBcym/WNtFn/yqg7W2R4LBp+QRCaZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732651884; x=1733256684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBieZ/H43H1parSNnvMLRoyFZN/PdHvN6lrqybfxtdA=;
        b=N11GroMEIPEeJCl0QiHJ7fjeLxbIpdXGMjl0CSkvgEmvt4rIfJGfxL3JicJu0fWvfx
         lvrtbN5/sFMzmyEfXNiq3RQNFxnaBx7+3KLSFYXzNkoVEBym1TmIZu6+KXHCD1QYHvHR
         7IJ0qQyVOv45Mm9ACvGAk66NAaIwVsFBJvTlnwETgtfTcRcxNR2HlFRFsyEq3T8VCOCv
         lVvXnHA2dJXFvlDSZnl9mPXpISFnBdGc+lCVGMApJ0datnpSSqWDqqLLjhIQyDOjkgG3
         KWz1u+/m6rohwFp4uesMzxgnEjJe6z+OT+H1LvKdeIFJ7/409YY9iaH3eFnd+2bYs+tI
         qwVA==
X-Gm-Message-State: AOJu0YzhpMXQqHHtO0jKzW+LYGfB73zNTsbfhBQj5KYfLwW0rBvdNVAk
	o263bmeIneFql6K8xsc+yMp9ML8SaZqU5ZmO+xkystEQ/fHKIZR4hQc3maS1QpUGwZaoy8fuZXw
	7TZu+pQ==
X-Gm-Gg: ASbGncs6biAnIpmaknHBoYwrzY1j2VH+tw1Q4Y5TxZ9ax5KBjAtQwoqS6sgDA4DOu+y
	PPXyEj1tO857WxErv07dhVamB2RckXUXoHTyyK0bJxapPUqpTIgCSYr9x8Og9H2NW0awyQ5CsiB
	kzZQ/1N0M1VP5XL8TFHuNcmf84AuqA7ohej0dXfM+SZm/3Bv2VovaJSJetTI8TO58kO5mx1SjVY
	uYP8FyJFH2NIMS3/bNWW0929N43Z2gq+Nk6RsSz+OMPHHXv8b0HyscdTzuHIfWJMw5qKYzoHXGL
	Ny6JopUmWyPH7lOPsuMst31k
X-Google-Smtp-Source: AGHT+IFuablBweluNoAErF8Ts6izUCEqEiWd2XIkTPhB1CIl+koFc48f3twKc4y0CmIZJ86ZwyhYew==
X-Received: by 2002:a17:906:3299:b0:aa5:2237:67af with SMTP id a640c23a62f3a-aa580edf62dmr18804866b.9.1732651884050;
        Tue, 26 Nov 2024 12:11:24 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa51ae7e5a3sm591107866b.160.2024.11.26.12.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:11:23 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa545dc7105so473403666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:11:23 -0800 (PST)
X-Received: by 2002:a17:907:c0d:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa58106648cmr22735266b.51.1732651882967; Tue, 26 Nov 2024
 12:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
In-Reply-To: <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 12:11:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
Message-ID: <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 21:10, Kees Cook <kees@kernel.org> wrote:
>
> For the new implementation, do you want to wait a full dev cycle for
> it to bake in -next or should I send what I proposed based on your and
> Al's suggestions for this merge window?

So honestly, the more I look at our current implementation, the more I
dislike this code.

And it looks like __set_task_comm() is actually buggy right now,
because while we have a comment in linux/sched.h that says

 *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
 *   always NUL-terminated and zero-padded.

that isn't actually true, because it looks like sized_strscpy()
actually adds the final NUL at the end. I think that's because Andrew
only merged a partial patch series.

The task_lock() doesn't help that issue, because readers don't take it
(and never really did: the '%s'+tsk->comm pattern has always existed).

End result: I think we should get rid of the pointless task_lock,
explicitly make sure it's NUL-terminated, and do the actual comm[]
setup in alloc_bprm() where we make all these decisions anyway.

So something like the attached. But it's *ENTIRELY* untested.  It
looks ObviouslyCorrect(tm), but hey, things always do until somebody
finds some obvious bug. If this tests ok, I think it could make 6.13,
but ...

And I'm looking at the other uses of bprm->filename for the fdpath
case, and it's all horrible. Yes, it's the scripting, but it's also
bprm->exec + AT_EXECFN. So we're passing in those fake pathnames that
won't actually work if the fd is used for something else, and that I
think could be used as an attack vector if any user space actually
trusts them.

That all looks horrid. I *really* wish we generated the real pathname instead.

Oh well. That's a separate issue.

      Linus

