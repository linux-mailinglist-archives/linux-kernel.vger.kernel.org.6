Return-Path: <linux-kernel+bounces-366084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C499F0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9021C22CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7471BF2B;
	Tue, 15 Oct 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFrdZQBU"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB001CB9F0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004810; cv=none; b=QcDl0Lmo2HMZRUy/tuF/iGI+ysTxE+It2MdSgVVl9Aup9bwgONBPae9y1MTJrv/4EnJQGZcgTWV24Vvs9n0+DquuadgmA8TzIBamHUbKyWIcHjrpjec7iTaUgoKzWYftFdZ2mN8I6+V77vPYCv+RJCmMld2r4XeJlfLuDfGoxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004810; c=relaxed/simple;
	bh=ZQl9UHMbS2zpthn3YlCftCta2N9I8PKzHq+fgsLN3WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT3pS0DI+9Hql57iGc/WP4lRCwN9/Y1LP0JOz+2OwksqKXdWTxn/NReZ7zwOh7+meEym72qgj2EDSEH0ZghTxbd+d0RRZlDDGQYBEhjjwEWoKnMjNLlUC2ggZYJ2uTbGhgzDyR8yaC7icJQq4pKV4AK/cfe8Q/54qw8txeSoxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFrdZQBU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460395fb1acso761721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729004808; x=1729609608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQl9UHMbS2zpthn3YlCftCta2N9I8PKzHq+fgsLN3WU=;
        b=rFrdZQBUwK7/8NHpvnye4lKlnZjtShFi8/CGdGyDUgsw9iBJbNYqowB2MYXZMyuYNs
         DXeayvOWXYxm1UK1zGyecFMNZXpowo4dQstkyZboIiMzvB6BGTLuNAPnVEAJzNn1kdRz
         aV0ERoMyWi71ULYetk8d62Tg0R4QlrgaPk4iZ1TDdon5dxzoxlrjk03aSESlIDti5RSP
         OJjQolWHPY+QIqDm+4Msr4Ve+Upcr4Yf43JqYR7o9uiK0nxZXTNOIUEhVRC5Eeu+1VUs
         gzH52tuJU6ZR8qoDb/R8Zmj16ORnbMA/bsLyDkjtIpKG4HXkaDNRGExOhdWBh77AtbFa
         I01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004808; x=1729609608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQl9UHMbS2zpthn3YlCftCta2N9I8PKzHq+fgsLN3WU=;
        b=Mb4qfgzWuEn4wm/SeQPzXo3YC9eSiYHLcPzHK/rcwr4Vixd3gtS7Jz+0wFuJJp4EPh
         bgvrrsPCmC6qtLTWFsnfX8ICTl9q28b0B8amP3440DDoNQyx/XwtDR/ndZl6mjP+Tm8V
         ujkqM6E+4ObH2rAHSNZcM5WPULr8gG6DHvZa6rgSMdWrrUFiauzecmxTWYM4VNwCOEl+
         gJJa45kz8uWM/sMMpfdRZLq/48IiJP/iwjN+2gaVNERwPmvvO77uBS9lscFM4k6G7KXX
         ibQstZe5ShK2/o419srhilJnixQE0CFg1hVHJsmFVmNbDlxoAvXkOMXsVuuCILasq62o
         LJgg==
X-Forwarded-Encrypted: i=1; AJvYcCVvf0uywFTsDGh5Rxuaa0M1CLt2ZzGIb5OHE602u+InAUQVW0zFWotZSh8I7SPni3dIVN1hF+QDKvHBbLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdmoJYUUmTxWenrHZ7+gi0GfP9wd3E4SBrmKsFJSnulg0zyoH
	j6L/OSBAZVgQ/b+O1vJKo7aoRPsKxHg2FKudW9tknQGEHcuP3DWCXEiYCkxcRJx0sPua3mPzii3
	5JxeZyetinn/SCVLuYs40UErmIGQfs6cZFhw+
X-Google-Smtp-Source: AGHT+IFz49w7sJh5aAv5suX/gv44ZHvixIsfk7pLi4CHMT74qdTtREKObwESHWojwr9bWtWWKSGe9xN21xl8GKoggmw=
X-Received: by 2002:ac8:648d:0:b0:460:8406:2c2c with SMTP id
 d75a77b69052e-46084062ef6mr1391331cf.25.1729004807352; Tue, 15 Oct 2024
 08:06:47 -0700 (PDT)
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
 <CAJD7tkb7UTpNWwJ84TZqB7SyZ2eyQrraOJ0g2qDmxS6C6Y1AtQ@mail.gmail.com>
In-Reply-To: <CAJD7tkb7UTpNWwJ84TZqB7SyZ2eyQrraOJ0g2qDmxS6C6Y1AtQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 08:06:36 -0700
Message-ID: <CAJuCfpF=EJ2CZRdg-JEdzkRCp_TtSXduB_hxqdEu379Z0OKAKg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Yosry Ahmed <yosryahmed@google.com>
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

On Tue, Oct 15, 2024 at 1:10=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 6:58=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 5:03=E2=80=AFPM 'John Hubbard' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > On 10/14/24 4:56 PM, Yosry Ahmed wrote:
> > > > On Mon, Oct 14, 2024 at 4:53=E2=80=AFPM John Hubbard <jhubbard@nvid=
ia.com> wrote:
> > > >>
> > > >> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> > > >>> On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > >>>>
> > > >>>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> > > >>>> references directly in the page flags. This eliminates memory
> > > >>>> overhead caused by page_ext and results in better performance
> > > >>>> for page allocations.
> > > >>>> If the number of available page flag bits is insufficient to
> > > >>>> address all kernel allocations, profiling falls back to using
> > > >>>> page extensions with an appropriate warning to disable this
> > > >>>> config.
> > > >>>> If dynamically loaded modules add enough tags that they can't
> > > >>>> be addressed anymore with available page flag bits, memory
> > > >>>> profiling gets disabled and a warning is issued.
> > > >>>
> > > >>> Just curious, why do we need a config option? If there are enough=
 bits
> > > >>> in page flags, why not use them automatically or fallback to page=
_ext
> > > >>> otherwise?
> > > >>
> > > >> Or better yet, *always* fall back to page_ext, thus leaving the
> > > >> scarce and valuable page flags available for other features?
> > > >>
> > > >> Sorry Suren, to keep coming back to this suggestion, I know
> > > >> I'm driving you crazy here! But I just keep thinking it through
> > > >> and failing to see why this feature deserves to consume so
> > > >> many page flags.
> > > >
> > > > I think we already always use page_ext today. My understanding is t=
hat
> > > > the purpose of this series is to give the option to avoid using
> > > > page_ext if there are enough unused page flags anyway, which reduce=
s
> > > > memory waste and improves performance.
> > > >
> > > > My question is just why not have that be the default behavior with =
a
> > > > config option, use page flags if there are enough unused bits,
> > > > otherwise use page_ext.
> > >
> > > I agree that if you're going to implement this feature at all, then
> > > keying off of CONFIG_MEM_ALLOC_PROFILING seems sufficient, and no
> > > need to add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS on top of that.
> >
> > Yosry's original guess was correct. If not for loadable modules we
> > could get away with having no CONFIG_PGALLOC_TAG_USE_PAGEFLAGS. We
> > could try to fit codetag references into page flags and if they do not
> > fit we could fall back to page_ext. That works fine when we have a
> > predetermined number of tags. But loadable modules make this number
> > variable at runtime and there is a possibility we run out of page flag
> > bits at runtime. In that case, the current patchset disables memory
> > profiling and issues a warning that the user should disable
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to avoid this situation. I expect
> > this to be a rare case but it can happen and we have to provide a way
> > for a user to avoid running out of bits, which is where
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS would be used.
>
> If this is in fact a rare case, I think it may make more sense for the
> config to be on by default, and the config description would clearly
> state that it is intended to be turned off only if the loadable
> modules warning fires.

Just to be clear, I think running out of pageflag bits at runtime (as
a result of module loading) will be a rare case. That's because the
core kernel has many more allocations than a typical module. Not
having enough bits for the core kernel might be the most prevalent
case, at least for large systems.
That said, your suggestion makes sense. Since we have to keep
CONFIG_PAGE_EXTENSION dependency (for the cases when we have to fall
back to page_ext), there is no advantage of keeping
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS disabled. I'll change the default in
the next version. Thanks for the suggestion!

