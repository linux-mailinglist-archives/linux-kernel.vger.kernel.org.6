Return-Path: <linux-kernel+bounces-181067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A48C7718
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A951F21CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3B146D6B;
	Thu, 16 May 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB/tRvnq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A0146D51
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864698; cv=none; b=K/kQholEB041lnk/e0gnR9Sbb6iCh/IDDqw6caqmoqvSzMC8mOsCX12onncfWlDYgzTC+W1mjZXLqqxK3+VjrqIiacnnbP/duRRf5qyeYuAZ/m6tD76llHZ0j8UJlXod0fJlIecd/oyqLWHMIL/JyaX7dygTwnEFXRq6qZlCbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864698; c=relaxed/simple;
	bh=415jALTlWUO89NXSLBZTpbKURNjit+DVVwNfQ4tH4nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr/Vfoq+grDcg0/lXDIYa9JTqAXypP4jom5SJszxgtvNK2Ded4w8KItcMHYOEDh+dxbwH9y2lN422IicGdm7CjjSUOzVHkrVNLQsbU8EAFHr7jamUNZ2MVNw3BoDjChmva7BKK5ZlN5R2GL2IXGrLkOg2vflGVJ+v09Y2OShtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB/tRvnq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6001399f22bso130447a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715864696; x=1716469496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHzuz0CH6x1TfON6MZpHmTkKmz49+sk28IRI1d2Qybo=;
        b=UB/tRvnqRILkKfNegr9GKmsws5kthxvL/LwO0b5tp8fvCxcfy8H0pkOCj+kyWMhmQN
         TNOsUg0Jdk90MgZSAqOFrJXqLUSQjXORrd+KbcP0tdOGO+G3nD83rMZCMVJuwcOBElvF
         vfSAM+X2tNF+uPxZ8rGcvZ1uFhcBd+GD4spF/ZBC9QTefrbbhzZpBCkLoLOvjZ2F2eDP
         bDM4veSkaGwsel10BYdR85yoLg1OP4yJGH8w99HT1r4QTIse521wIuAYqXOH38BSkTJm
         7rnsJvoizenYXZsoV6N5roBw38WSLSfyS2OFHbHOHm/yxJQLJcYIfEPEBTTTuWO8MiAI
         UG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715864696; x=1716469496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHzuz0CH6x1TfON6MZpHmTkKmz49+sk28IRI1d2Qybo=;
        b=Wu8cHAi0pjlpaCdUetQpISUMn34dBARvO86cTwvBilliFV5ak70zAk12vCjOUXOO+q
         0M11IfIElNAhbfy4i1D1F0p8gcpBTFf3uO4T/na1oa+yoGHf/c05BS55bfbJMTqmdIEV
         5qQXoa4p+t94ieV1xDqDnwlyDzGEr5jLystD+yg1Rw6pkrggjKBzjvGmGGPgeBX6/Ic2
         YjR5fC6RKZ0ENTCPF/NXEwqEZJlapnHEmNreVJGrxtZbQ/yyZPKIy0mlNRy9P5vxR3Kq
         vAjbH9pFhN4jGVFhqqRsXIdfrP3y3wLE0Fm27zNOYnwD0qCTZyChvf662eM+wMGwQYS/
         qDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwj5Qll16RHO2Pu8YVrMC0Bp+eyPDKNJOVPAp3CpAk9yNhMABjf+gNII59BGng5qGfeRdymOIKXh7bxKdF5GrLamu8JBiOf6zl02mN
X-Gm-Message-State: AOJu0Yw7yCvTs+fFeGgkKIkJhM6IMtAU02DvXhodl+vnr073Y3Jt17bn
	wBQ1dkbUJQf+iwmUCeSLPrLEP8m5rh4qJMaixg1n6LVZ4A9JDFrPjIPgL/Euih65Sp4+Hj4q9M2
	LMAim4pqxEvuNziaxjUl9bM+Q+9mY7Q==
X-Google-Smtp-Source: AGHT+IGD6aSzAfB1khSEG7/IvHVW4QgklsGIhvcD1YMnYiRrZrtPPyg+BeZe9Crho+h371LSrzuIesWHhZK9P4g1BzY=
X-Received: by 2002:a17:90a:778b:b0:2b6:5156:5b9b with SMTP id
 98e67ed59e1d1-2b6ccd6c165mr16100840a91.35.1715864695987; Thu, 16 May 2024
 06:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
 <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
 <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
 <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
 <CAHk-=whuCX-NAGOLzwn5sObPDJX-pdqamZ7YTpHFHODAMv4P+A@mail.gmail.com> <87v83eb2sn.fsf@intel.com>
In-Reply-To: <87v83eb2sn.fsf@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 09:04:44 -0400
Message-ID: <CADnq5_Nw_Tr5DABc3XGFpzQhePnVNGW-tzSZAQq0CL=s0iT8sQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:42=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 15 May 2024, Linus Torvalds <torvalds@linux-foundation.org> wrote=
:
> > On Wed, 15 May 2024 at 16:17, Dave Airlie <airlied@gmail.com> wrote:
> >> AMDGPU, I915 and XE all have !COMPILE_TEST on their variants
> >
> > Hmm.  It turns out that I didn't notice the AMDGPU one because my
> > Threadripper - that has AMDGPU enabled - I have actually turned off
> > EXPERT on, so it's hidden by that for me.
> >
> > But yes, both of those should be "depends on !WERROR" too.
>
> Fair enough. Honestly it just didn't occur to me.
>
> The main goal here was to ensure the drm subsystem does not have any
> build warnings, but without halting CI on any non-drm warnings that
> might occasionally creep in and that we can't fix as quickly.
>
> If there was a way to somehow limit WERROR by subdirectories, without
> config options, I'd love to ditch the config.

Right.  Same thing for amdgpu.  Our CI was often breaking due to
-WERROR in other subsystems or with compiler updates.  Maybe it's
better now.

Alex


>
> > Or maybe they should just go away entirely, and be subsumed by the
> > DRM_WERROR thing.
>
> For i915, this was the idea anyway, we just haven't gotten around to it
> yet.
>
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel

