Return-Path: <linux-kernel+bounces-365320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE6099E077
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F68B23730
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2B1C57A5;
	Tue, 15 Oct 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEl8zEsd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41511BF804
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979855; cv=none; b=NDtgxiIewMAHFJ57svhsk5F6zbOG7SkaKX05uY30ZQ49Ac/3FE2rQ6cEo8Lup1ljv1g4Je7cD5xgBc01sBAsgf5WkffEynqvPWUE2/Fq7v/gX7Yb6f+Evbdc1krOROJx3q8N/9Ly2i0Pc/V2EosdPJ4Kwjiejy6X7wU4x4k3vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979855; c=relaxed/simple;
	bh=KvE7gAeW8sXhIWJBpSNrJV9X+nydWZGu3u6USXH/JFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX+qTxD7I9zMCxz2ZWtJlLVo7MpHfdPeFYg5vIYP2NlCeq6RxoOfo5AA4Yo7xXMHQEF0YeGojEI281rPbwETVLix0knAtT9BoNIGPJwcEW/rWIVyXPJIOrZVAyQdr+j1AKWJ8hta16wFrVJmBReuKXdjF0ccGXxQJHHYRiXqy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEl8zEsd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so663061166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979852; x=1729584652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvE7gAeW8sXhIWJBpSNrJV9X+nydWZGu3u6USXH/JFE=;
        b=TEl8zEsdlCq75LLFnDiukeJAwlSHT/3QIqRwSPU2J2MWJrxN0GLbfuqMMmywJ8/PCm
         gV543OyynyBZIFPMRlocx7y5veZ9TZr0Y8U+h5G3mpeInNTQ2dPkeaDxrGVir32PqJ2k
         o62FsT8d/PIWcFk3IYrTx0hEwMTXFpmqQpPYWffa9x768svl6orfZwUSMznhAjJeJPTu
         jkwFEwd1FwyMmoh7w5hNfLCD65q+I3g1Kdw25hcsEGUW1LeVdHYjMkVPoANAZzOHn1P6
         TEJ+3jiGdBMvU9lSCrVavxTdRgZ7P8vVhHYnVMHa0KrwJF02xNxtH75ld3TDsLx2Ran0
         ahXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979852; x=1729584652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvE7gAeW8sXhIWJBpSNrJV9X+nydWZGu3u6USXH/JFE=;
        b=GsR6BDFdlKOxNPlg6WCAT16/5JL8ylTLQWeiwwAKo4SBG/B8IqjKokjdRkwiSNyKpU
         mQdSeZVttmZ3+fEJSrns7u7KGAWTl4l+es/xPuL9Vruj3PPgkGjv0Le6vak+bJXuEf3f
         3IkEeG/fIMzINuWEX3VVw6Aa+JzCkcaaSyAOru3RofJIIBCGAd9H3qJ+UbRfZH/8g7Wn
         MdLhDtPKg8yGQ9xeiqR8JdHzIfq09P5zNah/5NLZqmdBi2OBl1/fbRor2oqKi14My6da
         5SdO0xDLqL3b5L7yDZvMSPw+RabffkdnZD9hRtOMF13yHyO1OmOOd5cY/sAORfqBV5zU
         YYVw==
X-Forwarded-Encrypted: i=1; AJvYcCWBEEKUGePbmhOH9cgtYb26JBXfGxRiPJSslXZMhZH4AOOnn9fM7LHnNXZ9Xju3Mdzd5Lv/mlkrLdIjg5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXO21dPUxeYDTh4Xh5K71LFv2+dpq/8T6Y+081BAHD7D74oNT
	XRtPnhi2p+d/wpjCCRKWxlvzUQe9uuielCPIt9Ques3XfIWf5xjD5LzDAka6bhbHAIq+HAfQYcC
	1vSzENlSEnXo73faATZyH/UaftKgRCq43mqc2
X-Google-Smtp-Source: AGHT+IHj3pap7JooFFjvVueeXA2+cvcJjG4tmLO9wFNQuWlLuixkFRBrdGwr8xAFLl+BwvBI0CIXr/tQT4JW9Ohs+5g=
X-Received: by 2002:a17:907:7b8b:b0:a9a:2e12:1a06 with SMTP id
 a640c23a62f3a-a9a2e121be4mr61446266b.51.1728979851608; Tue, 15 Oct 2024
 01:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com> <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
 <ba888da6-cd45-41b6-9d97-8292474d3ce6@nvidia.com> <CAJuCfpE4eOH+HN8dQAavwUaMDfX5Fdyx7zft6TKcT33TiiDbXQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE4eOH+HN8dQAavwUaMDfX5Fdyx7zft6TKcT33TiiDbXQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 01:10:15 -0700
Message-ID: <CAJD7tkb7UTpNWwJ84TZqB7SyZ2eyQrraOJ0g2qDmxS6C6Y1AtQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:58=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Oct 14, 2024 at 5:03=E2=80=AFPM 'John Hubbard' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On 10/14/24 4:56 PM, Yosry Ahmed wrote:
> > > On Mon, Oct 14, 2024 at 4:53=E2=80=AFPM John Hubbard <jhubbard@nvidia=
.com> wrote:
> > >>
> > >> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> > >>> On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > >>>>
> > >>>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> > >>>> references directly in the page flags. This eliminates memory
> > >>>> overhead caused by page_ext and results in better performance
> > >>>> for page allocations.
> > >>>> If the number of available page flag bits is insufficient to
> > >>>> address all kernel allocations, profiling falls back to using
> > >>>> page extensions with an appropriate warning to disable this
> > >>>> config.
> > >>>> If dynamically loaded modules add enough tags that they can't
> > >>>> be addressed anymore with available page flag bits, memory
> > >>>> profiling gets disabled and a warning is issued.
> > >>>
> > >>> Just curious, why do we need a config option? If there are enough b=
its
> > >>> in page flags, why not use them automatically or fallback to page_e=
xt
> > >>> otherwise?
> > >>
> > >> Or better yet, *always* fall back to page_ext, thus leaving the
> > >> scarce and valuable page flags available for other features?
> > >>
> > >> Sorry Suren, to keep coming back to this suggestion, I know
> > >> I'm driving you crazy here! But I just keep thinking it through
> > >> and failing to see why this feature deserves to consume so
> > >> many page flags.
> > >
> > > I think we already always use page_ext today. My understanding is tha=
t
> > > the purpose of this series is to give the option to avoid using
> > > page_ext if there are enough unused page flags anyway, which reduces
> > > memory waste and improves performance.
> > >
> > > My question is just why not have that be the default behavior with a
> > > config option, use page flags if there are enough unused bits,
> > > otherwise use page_ext.
> >
> > I agree that if you're going to implement this feature at all, then
> > keying off of CONFIG_MEM_ALLOC_PROFILING seems sufficient, and no
> > need to add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS on top of that.
>
> Yosry's original guess was correct. If not for loadable modules we
> could get away with having no CONFIG_PGALLOC_TAG_USE_PAGEFLAGS. We
> could try to fit codetag references into page flags and if they do not
> fit we could fall back to page_ext. That works fine when we have a
> predetermined number of tags. But loadable modules make this number
> variable at runtime and there is a possibility we run out of page flag
> bits at runtime. In that case, the current patchset disables memory
> profiling and issues a warning that the user should disable
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to avoid this situation. I expect
> this to be a rare case but it can happen and we have to provide a way
> for a user to avoid running out of bits, which is where
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS would be used.

If this is in fact a rare case, I think it may make more sense for the
config to be on by default, and the config description would clearly
state that it is intended to be turned off only if the loadable
modules warning fires.

