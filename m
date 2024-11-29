Return-Path: <linux-kernel+bounces-413566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5459D1B12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E79E285A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A91E883E;
	Mon, 18 Nov 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="FASkpsrj"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0F1E6DD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968682; cv=none; b=lk0ZTBnb7OMssvwPLqIZSsD45jy60j37a0jJSGwcERwTEosqLeestpCxvtL64sNb+XDV1Wmg8vFCW0bMUf/BZaS4+h4znNzIixL+EUYobXGfL4BKJu0gxUV7C3yi2/5gu5jYKsrFzTdnfrgkMFuzu+mNaTyiSTlNI25GPP3VVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968682; c=relaxed/simple;
	bh=mr6iDGZX6WZlOIa/AqtWy4H1dbsMF9ugeMcnS6HxJNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkfNdci4X5US0YzjjtbvIFr2toTmD66OVIlnJ/Yr/iNG5oCki8fPQfKWdnEC6kHpnBeGSV8NAwIWG59KB9yDZO+ZsWvoS0dpwxXpuRXUnuCzVMTlQGAcaJo21WinGTVjtmQAD1Oj8Y++3FdMWlpEpfcBAJTJpi6FmK6wVguoBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=FASkpsrj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460ab1bc2aeso17850141cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731968679; x=1732573479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr6iDGZX6WZlOIa/AqtWy4H1dbsMF9ugeMcnS6HxJNE=;
        b=FASkpsrjoGaamnWrNHj3IJ7LmrVMskP3FHdBcUEZrPq0ROkT0wa2q39WszDCA3pTtt
         KXo0YU1awi84gbfNj1SOJtJ3m3zXvfvsLPlk96vY00XY8IWYgW7QNRsq/6mAWB618SsJ
         HbmNCRv4rx7YyflaUhTZ7Q0nmAEo4HTxJlffte36/nfNiZWeS8tjOJlCSgFOpfGl0mij
         QEm309m0hARE5w7s4HdYnzo/OVPaTqYaOzDbAgNxAIX+r+v7MFVZf11yA+aB6BR3MG17
         VyHcrgx2tUhI0t3pNh72BTxRiQ0JsYwD5mDYhaQ0r6dIJqhn9Wv/hFG6SiYwSgMa1Vnz
         4PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968679; x=1732573479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mr6iDGZX6WZlOIa/AqtWy4H1dbsMF9ugeMcnS6HxJNE=;
        b=fHCy1WvLPeOTDh3KKsHxQeydwBDlxrJQm227LQvef1KXuoPP90zj0feO/bUo7CzNf7
         fsX3OPT78Z+h2CCGDjq/HCAxKkbpSn4vsxm6OBTCueYwNApbcxn3gp/8TMF4mUmrWZe9
         gEnfl7idrs6wl6ccOSB106ZmN9TvR2pfPfTx6nywe2Lbc6+EGAWfNrdANraOg0tb43NW
         FHbY5T2o4prOW1EqvEMbDq4dh1P+OQKusSWx3o4GbQbdt0A3g2nYjkGqJi9Mgdh0/Xbw
         rDXSoiWSReLQxXYvvmhgAYoNGptX40x8RNZetFiVXcp4UU/u3BR6UZNwXiN8jOfD2but
         xpRg==
X-Forwarded-Encrypted: i=1; AJvYcCXQd3wpiNOKhGovVOwC8Br34yJFtG6QFTjzq2OOZlOsacAWECbl/PBXzCJA7SARcolAH91GRAEFlGih9+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZelYe4Jl3YS4e7Fl42ng3fDTOEaX5xBV+RgQrA5DP4DF3M5I
	v7FC3Li2fX1UDLDjte05woPjgNg6BSOd1ewtvFd2HbJO38+pYkrjRBcRdOh6nduLE4bJ3/15+5o
	QKFEA1o/xhCsdO5pi6IZ45ylOJSWREOpVuTRgAA==
X-Google-Smtp-Source: AGHT+IFJn12BEIzoEKgSqnP8cIUM9l+AVMCmmrovlugeE4ncddPOm9spXZtngGYQPZw7li3y2om6vXnU1SKoOL9vTX0=
X-Received: by 2002:ac8:45c8:0:b0:463:788e:7912 with SMTP id
 d75a77b69052e-463788e81b9mr128943351cf.56.1731968679432; Mon, 18 Nov 2024
 14:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
In-Reply-To: <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 17:24:02 -0500
Message-ID: <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:54=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Nov 18, 2024 at 12:17=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > > It operates through the Linux debugfs interface, with two files: "vir=
t"
> > > and "phys".
> > >
> > > The "virt" file takes a virtual address and PID and outputs informati=
on
> > > about the corresponding page.
> > >
> > > The "phys" file takes a physical address and outputs information abou=
t
> > > that page.
> > >
> > > The output is presented via kernel log messages (can be accessed with
> > > dmesg), and includes information such as the page's reference count,
> > > mapping, flags, and memory cgroup. It also shows whether the page is
> > > mapped in the kernel page table, and if so, how many times.
> >
> > I mean, even though I'm not a huge fan of kernel pointer hashing etc. t=
his
> > is obviously leaking as much information as you might want about kernel
> > internal state to the point of maybe making the whole kernel pointer
> > hashing thing moot.
> >
> > I know this requires CAP_SYS_ADMIN, but there are things that also requ=
ire
> > that which _still_ obscure kernel pointers.
> >
> > And you're outputting it all to dmesg.
> >
> > So yeah, a security person (Jann?) would be better placed to comment on
> > this than me, but are we sure we want to do this when not in a
> > CONFIG_DEBUG_VM* kernel?
>
> I guess there are two parts to this - what root is allowed to do, and
> what information we're fine with exposing to dmesg.
>
> If the lockdown LSM is not set to LOCKDOWN_CONFIDENTIALITY_MAX, the
> kernel allows root to read kernel memory through some interfaces - in
> particular, BPF allows reading arbitrary kernel memory, and perf
> allows reading at least some stuff (like kernel register states). With
> lockdown in the most restrictive mode, the kernel tries to prevent
> root from reading arbitrary kernel memory, but we don't really change
> how much information goes into dmesg. (And I imagine you could
> probably still get kernel pointers out of BPF somehow even in the most
> restrictive lockdown mode, but that's probably not relevant.)
>
> The main issue with dmesg is that some systems make its contents
> available to code that is not running with root privileges; and I
> think it is also sometimes stored persistently in unencrypted form
> (like in EFI pstore) even when everything else on the system is
> encrypted.
> So on one hand, we definitely shouldn't print the contents of random
> chunks of memory into dmesg without a good reason; on the other hand,
> for example we do already print kernel register state on WARN() (which
> often includes kernel pointers and could theoretically include more
> sensitive data too).
>
> So I think showing page metadata to root when requested is probably
> okay as a tradeoff? And dumping that data into dmesg is maybe not
> great, but acceptable as long as only root can actually trigger this?
>
> I don't really have a strong opinion on this...
>
>
> To me, a bigger issue is that dump_page() looks like it might be racy,
> which is maybe not terrible in debugging code that only runs when
> something has already gone wrong, but bad if it is in code that root
> can trigger on demand?

Hi Jann, thank you for reviewing this proposal.

Presumably, the interface should be used only when something has gone
wrong but has not been noticed by the kernel. That something is
usually checksums failures that are outside of the kernel: i.e. during
live migration, snapshotting, filesystem journaling, etc. We already
have interfaces that provide data from the live kernel that could be
racy, i.e. crash utility.

> __dump_page() copies the given page with
> memcpy(), which I don't think guarantees enough atomicity with
> concurrent updates of page->mapping or such, so dump_mapping() could
> probably run on a bogus pointer. Even without torn pointers, I think
> there could be a UAF if the page's mapping is destroyed while we're
> going through dump_page(), since the page might not be locked. And in
> dump_mapping(), the strncpy_from_kernel_nofault() also doesn't guard
> against concurrent renaming of the dentry, which I think again would
> probably result in UAF.

Since we are holding a reference on the page at the time of
dump_page(), the identity of the page should not really change, but
dentry can be renamed.

> So I think dump_page() in its current form is not something we should
> expose to a userspace-reachable API.

We use dump_page() all over WARN_ONs in MM code where pages might not
be locked, but this is a good point, that while even the existing
usage might be racy, providing a user-reachable API potentially makes
it worse. I will see if I could add some locking before dump_page(),
or make a dump_page variant that does not do dump_mapping().

