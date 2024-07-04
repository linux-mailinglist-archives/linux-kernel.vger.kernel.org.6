Return-Path: <linux-kernel+bounces-240484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF88926E39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C61C21574
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746B1CABF;
	Thu,  4 Jul 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZEsrgAM"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77E1B7E4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720066090; cv=none; b=bHD67Nq5KdwGzcls8PowxE44+lmEabXCTNJ8r+akkYZstdMHgcT6QIRmMOAKwQvNH7X+NOyI13dDIKDGC3INIy6/l/QPwWfzfNOUlZrIi9kMuiPHGjnS+cggERUBWOYj7XyNDgtW2Sy2kgMHDzs9K77yruA3eWoh20h1iUb6ZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720066090; c=relaxed/simple;
	bh=sVzwQGpEtTZ9VPZpO/dn4osr4xDpCK7B2xm7LBlKsiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUuqnWSVMr10EFMHKhc7zBzt8EXgh3AoDSJhghdO9nZROnZfyfrR5H+8FcXLEgHFtJI6bjW+9LKuZFbFLHygolErRR9ujpRmIKJ0iCsqSIYx55FK7o65qNB9uVcNU5hvILPYp7KraavEQ1oq9GqwXZqs8kzojSgiWA/pYmM6AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZEsrgAM; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0360f890a1so1139013276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720066088; x=1720670888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4W8iMWOfUbIlBFkiyj5B8QwDzBKAId9kwruxZhp8GA=;
        b=TZEsrgAMJHJoVHBPMlIFVuSz2rfdq2YqlVORoJfw4AYeqKC72MGq+wUlu1OTGvz8vI
         W3wSN1wjMhslY7dhy2nrmMBwqZKw+RnwWsDpvaEug5vtAnWkqnCcm38v218dwwPe429F
         cbQuw2CumfBb0TFlZfufGMOKusNxUYGnZIGQ2cIFzIdyYrH0iDV7m6v5ELlzefi+/nUQ
         U/G+6pXvrTQ4ICy425OZxXYXe+KRCQ8m1OBPwMB7JP5EzZ93K6Ac01s13vJC1uB0aXaH
         VYBAkthabzAoAzxMcih3KHPmtHxsqaLU5KGKUk//LwySZLa5Y7GGILLk2zMRPyQJ8cU5
         YsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720066088; x=1720670888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4W8iMWOfUbIlBFkiyj5B8QwDzBKAId9kwruxZhp8GA=;
        b=KZU0Tjt/2m998sVbAV++f1/VRnkRsK5bFcXr1Qx6Copoz+esS5/cucV95ROR8qhg2R
         ArGln8vHoKdQmrSexmW2/kTrH0moZRfufcL9UE95avLFBSysBa7jlPdUQWui5kzEwyrh
         zk3uSKrLn9g3qQzhAeIHShUKGYlvSeoSPeUyhCuy78aCBGHwGoAj//Ie0uE43kygth0Y
         oelMV73HL6PgArZc30/7uIDkg6d/o79biqrZ1VHhqku2WPnaJ2GRmo5wM/cI+rEUEa1t
         ML3DDtTbNyFj9WapIM7oORnEnPw1aA68xKikM0VB2iXJpNwLVtlD+FkuP4rIAiowOmsF
         dMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV//t1tjR3a01vC5job4zHtn82Uj+tatW5qL3w/IRLT7KIsS0sCAlkm80jmYBUQT99WYXMC54W+IXILP6O0562wvPEVBRrOi0Njs0RR
X-Gm-Message-State: AOJu0YxeikTaB79qcRr4LvZWfasM2TgtLwGC5fq8tf5O9lmzumjx9zN5
	XtvK26cwZwiYQzKhoq6fa65RrkhmvrysBicjXodZNucSt6ub8zjKC4AZVF/BbUQCL1TpQEmhGCg
	ioaJMsva7ZvAM5Y5fBZQy/fgtEj06ezOLiNNr0fG7ysilqabf6zAj
X-Google-Smtp-Source: AGHT+IFquybJaaiNcmnD9lkloPn7hAWl4R4+RMqROPOG3puqzyHTJzxlw6zh/RP9nto7j4fHf4BkeBJCESyo32rqdF8=
X-Received: by 2002:a05:690c:10c:b0:627:7f2a:3b0d with SMTP id
 00721157ae682-652f640f734mr1697617b3.14.1720066087779; Wed, 03 Jul 2024
 21:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703221520.4108464-1-surenb@google.com> <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
 <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
 <CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
 <CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com> <20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
In-Reply-To: <20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 21:07:56 -0700
Message-ID: <CAJuCfpHvNjFQYU0zHOuang2mNOLNHHiNfaWACPWuP4mSMX_OmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:54=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 3 Jul 2024 20:46:11 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > Ok, I confirmed that the warning is happening due to the access to
> > "current" from alloc_tag_save()/alloc_tag_restore() functions. I guess
> > when these functions access "thread_info" variable:
> > https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/a=
sm/thread_info.h#L96,
> > compiler flags that because the variable is on the stack of an __init
> > function while alloc_tag_save()/alloc_tag_restore() when not inlined
> > are from .text section.
>
> Well, is the warning legitimate?  I don't see why an automatic variable
> of an __init function should be considered to be .init storage - we can
> assume it won't become an invalid reference while the .init function is
> executing?

I don't think it's really a problem. __init function is executing, it
calls a function from .text (say alloc_tag_save() that was not
inlined) which in turn calls get_current(), which returns a pointer
somewhere inside __initdata. That should be fine since this can only
happen during init stage. If this call happens after init,
get_current() can't return a pointer from __initdata. If it does then
we have a much bigger problem.

>

