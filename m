Return-Path: <linux-kernel+bounces-568277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB0A69300
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30734802F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00219DF99;
	Wed, 19 Mar 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sK31l17/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6DF9DA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396982; cv=none; b=IAQKhdk6FwWYFI5JuxVy/+oHfzJJ7jQ67VI2Z/bwxyQsj90a3y1VIXkfqtrkdqhwNs1oqcS1kODswZJZn3/wteBvlJIALNYmqWzFGxa4p17894S3k16mQWXkePfl1fCu8+X5MAV62asezWkcqz25fs9PS4JEJb+wliMcfdTs+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396982; c=relaxed/simple;
	bh=Z8DwlWLeaRzLilOyTh09RfziRSu+3ePODVOYkk6Kpm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbc60vrm95GKNwcZ5cjhs/lilHMiEauwXXS4nq+dFIjXcNq27I1ThzeDxG0Dg7dv1hC4E8prFVRUrQ5Pd6/MtWTcawkHKaOUEwtAq9VrSA1aLaak1VZsBLK8mrth7HF4Ijk5LPPwgIuiT0FBb1xn/ot0C0jrxCw3nnnvHSMtboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sK31l17/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB8EA3F718
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742396962;
	bh=8aBOIVOtwTJyDKkbjMF2Aak4oYSj8+ED8AjxSctFyBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sK31l17/ZcCYekQ0KG4i1s161A2CT/ZU9U2BNw5WU6zX7bjwEbZ8yS3kMGV8g5jKB
	 jKkFY369sy1J3TsJRscSzEMDDw7758I8FbNeHRciY6MfpqHXbFveht5zRgxdYrOAvt
	 YGcD94P8OPS3ZmV3Uujb7kxy4/RIAQ9HxxMWvT0rTpkdU4hBFKjucU6aD9uC5b1H1o
	 hykhTsuYH4VUxMMm9ofzetr4Kk0lav0otomX/LdXukBCubn19cZkndgx4168gS3cqp
	 KvA9Q6rckJid4tXfO2srErM8L5JP0Wgcb5ue56J/5n9eMRutICW88+S0gN1bdFZyWf
	 awupl4juDqi8w==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-523f9fafc5bso1412745e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396943; x=1743001743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aBOIVOtwTJyDKkbjMF2Aak4oYSj8+ED8AjxSctFyBo=;
        b=bel1vr2NfSRIgDIl4l5YH29BRkJBShSSF+/3mzSUILkarrGgan2HfXIrJAUbcx2svV
         NxQOo768n9PwYaL9fxs4uTPiARwoXoMkytPAhTp9Y0x69NFcotq7v//M3/Rv1m5HMhp+
         2eXweeItLikRkPqUryYw7AOnj9HN7Lmm9O08F6HUXgm/whnkskKZgxS8VIa8KaURCYvd
         oG1AKv+IkTOX4d1OGRLdGAJf17+PYgkg5lrgFEhl6hd/Oj32KcHtLzjZIfTS4QWrIMhe
         4rjELi6uTM44yin+iVNrfg4jjQv7nDT+qkpOJotwHoIYxfrrG+xHE6SbOr65rncbrqHY
         78xg==
X-Forwarded-Encrypted: i=1; AJvYcCVupWPRxNf8O/0INrT4oOIhIvIWz9AtO6jYthJUTanmr3KUI4pN9mIuU8wH+P46QtrrS/ip3kqkOIFBJ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrINpKSLo5C4be9pPNZcedM+Ms5g0jGhyD7ksVtQbL1hBRp+w
	frhyafhex+VOf2N610DghoGR1IGD/4Yih5rVZUYVUVcL1Cc9iKY0hie16llFEbFiSvF/WT1vqFu
	BPOCxi8VdcIOGmX6dqaPYnEHXpcDaeu6GQ/+E/ljdI3UJCFO0mvOOrs5A8MrhbXTGkrvz0ozuo4
	1C6KRUhO+cd+DSXLiOGZxxpf1M1bRjUOy8lSWfyZg8tGfMO6Cv94lx
X-Gm-Gg: ASbGncvWiMi1tCqPgFAQnGaPfs6BLiqgrjXlBjCA9lrVIPFv83t6+xHt7mQjZlPMqny
	C9Y4CYr8Zog+G+Ge/UEDIC1yFdufjswamp2KelwvP+nZVxA5fK/k4Ajj08GSIWp8/5/N39ylpAg
	==
X-Received: by 2002:a05:6122:4710:b0:524:2fe2:46ba with SMTP id 71dfb90a1353d-5258929589emr2290070e0c.11.1742396943249;
        Wed, 19 Mar 2025 08:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZZ2JRERhNw6fQtgv1k3Uevcdo+N02hVl/dbQz5Ech6qMnUThFI0UpnwTJfu5OuJvFHJ0IevrcJdPwqxH/+ng=
X-Received: by 2002:a05:6122:4710:b0:524:2fe2:46ba with SMTP id
 71dfb90a1353d-5258929589emr2290011e0c.11.1742396942930; Wed, 19 Mar 2025
 08:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h> <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
In-Reply-To: <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 19 Mar 2025 16:08:51 +0100
X-Gm-Features: AQ5f1JrrL-o1nzunyhb4dVJT7qp6u8-CUZOYotSFXxMDYx9WLb26b0mVdqfOBmg
Message-ID: <CAEivzxf8jG3BVb9zdpVy+-q1DNZ1NBDbWUvOUkzni=B=Pvq4Ww@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, James.Bottomley@hansenpartnership.com, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, arnd@kernel.org, 
	brauner@kernel.org, chris@zankel.net, deller@gmx.de, hch@infradead.org, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mattst88@gmail.com, muchun.song@linux.dev, 
	paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org, 
	sidhartha.kumar@oracle.com, surenb@google.com, tsbogend@alpha.franken.de, 
	vbabka@suse.cz, willy@infradead.org, criu@lists.linux.dev, 
	Andrei Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.03.25 15:50, Alexander Mikhalitsyn wrote:
> > On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:
> >> Userland library functions such as allocators and threading implementa=
tions
> >> often require regions of memory to act as 'guard pages' - mappings whi=
ch,
> >> when accessed, result in a fatal signal being sent to the accessing
> >> process.
> >>
> >> The current means by which these are implemented is via a PROT_NONE mm=
ap()
> >> mapping, which provides the required semantics however incur an overhe=
ad of
> >> a VMA for each such region.
> >>
> >> With a great many processes and threads, this can rapidly add up and i=
ncur
> >> a significant memory penalty. It also has the added problem of prevent=
ing
> >> merges that might otherwise be permitted.
> >>
> >> This series takes a different approach - an idea suggested by Vlasimil
> >> Babka (and before him David Hildenbrand and Jann Horn - perhaps more -=
 the
> >> provenance becomes a little tricky to ascertain after this - please fo=
rgive
> >> any omissions!)  - rather than locating the guard pages at the VMA lay=
er,
> >> instead placing them in page tables mapping the required ranges.
> >>
> >> Early testing of the prototype version of this code suggests a 5 times
> >> speed up in memory mapping invocations (in conjunction with use of
> >> process_madvise()) and a 13% reduction in VMAs on an entirely idle and=
roid
> >> system and unoptimised code.
> >>
> >> We expect with optimisation and a loaded system with a larger number o=
f
> >> guard pages this could significantly increase, but in any case these
> >> numbers are encouraging.
> >>
> >> This way, rather than having separate VMAs specifying which parts of a
> >> range are guard pages, instead we have a VMA spanning the entire range=
 of
> >> memory a user is permitted to access and including ranges which are to=
 be
> >> 'guarded'.
> >>
> >> After mapping this, a user can specify which parts of the range should
> >> result in a fatal signal when accessed.
> >>
> >> By restricting the ability to specify guard pages to memory mapped by
> >> existing VMAs, we can rely on the mappings being torn down when the
> >> mappings are ultimately unmapped and everything works simply as if the
> >> memory were not faulted in, from the point of view of the containing V=
MAs.
> >>
> >> This mechanism in effect poisons memory ranges similar to hardware mem=
ory
> >> poisoning, only it is an entirely software-controlled form of poisonin=
g.
> >>
> >> The mechanism is implemented via madvise() behaviour - MADV_GUARD_INST=
ALL
> >> which installs page table-level guard page markers - and
> >> MADV_GUARD_REMOVE - which clears them.
> >>
> >> Guard markers can be installed across multiple VMAs and any existing
> >> mappings will be cleared, that is zapped, before installing the guard =
page
> >> markers in the page tables.
> >>
> >> There is no concept of 'nested' guard markers, multiple attempts to in=
stall
> >> guard markers in a range will, after the first attempt, have no effect=
.
> >>
> >> Importantly, removing guard markers over a range that contains both gu=
ard
> >> markers and ordinary backed memory has no effect on anything but the g=
uard
> >> markers (including leaving huge pages un-split), so a user can safely
> >> remove guard markers over a range of memory leaving the rest intact.
> >>
> >> The actual mechanism by which the page table entries are specified mak=
es
> >> use of existing logic - PTE markers, which are used for the userfaultf=
d
> >> UFFDIO_POISON mechanism.
> >>
> >> Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> >> mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> >> handler, so we add our own specific PTE_MARKER_GUARD and adapt existin=
g
> >> logic to handle it.
> >>
> >> We also extend the generic page walk mechanism to allow for installati=
on of
> >> PTEs (carefully restricted to memory management logic only to prevent
> >> unwanted abuse).
> >>
> >> We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
> >> remove guard markers, nor does forking (except when VM_WIPEONFORK is
> >> specified for a VMA which implies a total removal of memory
> >> characteristics).
> >>
> >> It's important to note that the guard page implementation is emphatica=
lly
> >> NOT a security feature, so a user can remove the markers if they wish.=
 We
> >> simply implement it in such a way as to provide the least surprising
> >> behaviour.
> >>
> >> An extensive set of self-tests are provided which ensure behaviour is =
as
> >> expected and additionally self-documents expected behaviour of guard
> >> ranges.
> >
> > Dear Lorenzo,
> > Dear colleagues,
> >
> > sorry about raising an old thread.
> >
> > It looks like this feature is now used in glibc [1]. And we noticed fai=
lures in CRIU [2]
> > CI on Fedora Rawhide userspace. Now a question is how we can properly d=
etect such
> > "guarded" pages from user space. As I can see from MADV_GUARD_INSTALL i=
mplementation,
> > it does not modify VMA flags anyhow, but only page tables. It means tha=
t /proc/<pid>/maps
> > and /proc/<pid>/smaps interfaces are useless in this case. (Please, cor=
rect me if I'm missing
> > anything here.)
> >
> > I wonder if you have any ideas / suggestions regarding Checkpoint/Resto=
re here. We (CRIU devs) are happy
> > to develop some patches to bring some uAPI to expose MADV_GUARDs, but b=
efore going into this we decided
> > to raise this question in LKML.
>
>
> See [1] and [2]

Hi David,

Huge thanks for such a fast and helpful reply ;)

>
> [1]
> https://lkml.kernel.org/r/cover.1740139449.git.lorenzo.stoakes@oracle.com
> [2] https://lwn.net/Articles/1011366/
>
>
> --
> Cheers,
>
> David / dhildenb

Kind regards,
Alex

>

