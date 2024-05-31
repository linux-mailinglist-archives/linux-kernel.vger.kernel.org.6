Return-Path: <linux-kernel+bounces-197282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44E8D68B4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF101C22E90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C1517C7DF;
	Fri, 31 May 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIBDe8H9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA5158D9C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178858; cv=none; b=apNpykHjSrWZJjFrjoArF1c9SPhszo6yMYkwBApHtiiqpbHsC/mMCnJOmLD4EMg9f/lE0dUhbSn2MCMPWVnw0FjydpqPaBRR+D7Zfi+j7McWensHMb91Ty19jCrpUrZs0KadnFDyzWEkQhpr0KpV+gwSliJMExTRQ+ll0ZKLQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178858; c=relaxed/simple;
	bh=kokI0fSxhWHyPtWmtJobf6bwdSbFlJBXmQ8Mh8x+NGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCs3rcOgUT6jpwuslhCdr4WqeDlQRzWNGHxGAkdWgQXZz1G/QiqL28dd483v3gr9T65uX7UiXKAMmyt3VOeGBD6le1VVVGxrVgjRJbmx8l2lv2Mp54IAikYiQltdrr6g6IwCo8IXqx1YgAz1gVKLSZj06e8V7RiQlY8eo8Avyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIBDe8H9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a033c2e9fso2935283a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717178855; x=1717783655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya2Mxculd7njAcy1+bzu0IEd1bx5A+sr4iky2perI8k=;
        b=KIBDe8H9bkl2kgNlMjYhHqyYA1QeRP1Bllb9oDJUAjzSwRj/qnBU+hs78IGxEtN6D5
         f2MXm2S2JNuYR2aY2t86ZYPkHRRukudTIyOw2Zj12ePSPst9exGwE7+VdxcFLvP5NvcP
         y3I1WfYOS/iC2aVwz6UF7IMCVY3aEf7jAkQdiFK/uGDpauDYJkRba878iGRuA0GOLWpO
         e22SX3ylTraRr7tHywhpI7koAdl1qo/kYPLd5oBpb8AEr6yyM2oCnSYO+9xCzGx2EnT6
         h05NhgK29pyBn/1brGkZN+BdxCEZlwxMRGh3Rf3bBVJhJytCR+KmvsdZQIRRt4Nx6Yyv
         uCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717178855; x=1717783655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya2Mxculd7njAcy1+bzu0IEd1bx5A+sr4iky2perI8k=;
        b=M7pPCyLmZSRC74ffLD9FboxzQUUm5Sik85HXnG2PenXre+YjN+eqtPo2MiTaEvaiO3
         KZ0Nm053NXHFUIeo1aJFVUvrRdsKuNs+W1qE6cOwwgNWCvPd4dI24kK6upW8q1xsTwPL
         C3bvOznj00mtNAdkzQKwb8TjRsNkXJ42bkXDNjE+Jo+4IzjvHX5YNAiuG4YEFD0FaGP4
         +qhjlFWAfg7wdMPIYaKI4SWXrP8nGrF6zlO4JxQ8czdZNJdy9HlulXyEMgLDJ/ncVDfW
         Xv7X1bsa3G+02K9jjbmldsI4+Ya2ZPNVp8F+E2mTSL/BF22FfrlD0TDUi4/lctfyjZ3x
         EOtA==
X-Forwarded-Encrypted: i=1; AJvYcCVhzrryDeJro6vxtLVR7IMUBY2kb6lPJqbbS3xVJsUJTfcIFEO0Po308Vqiao6LuUWn0aZnp8bMJuze04s/Yx/qypMOUhFJ/0+3h58+
X-Gm-Message-State: AOJu0Yw8ftQKTVL9oWF4uvXrNIND3db7JAvwZWt5bZV7644w2OlGZbIZ
	zp2jxRY11slcDjncjsEqNaw6s6+CE9fiDLxEO+vaOtQB26/foR8cjWspmghZQNOAwf6G9vWRdNv
	XG1V3sN7dHmvePfvZflts0vzFZ6Y=
X-Google-Smtp-Source: AGHT+IFK1e4A8rjTqX9SajY77+rAqXwkGJv+JNpnpHYgH5EmOryrZi4WtBi42nt1SjSxMGbiDC0I+6wtCLTgRZkjMzc=
X-Received: by 2002:a50:f691:0:b0:578:6410:1d50 with SMTP id
 4fb4d7f45d1cf-57a365c5ecdmr2109652a12.34.1717178854568; Fri, 31 May 2024
 11:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
In-Reply-To: <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 11:07:22 -0700
Message-ID: <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: David Hildenbrand <david@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:46=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.05.24 18:50, Yang Shi wrote:
> > On Fri, May 31, 2024 at 1:24=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> >>
> >>
> >>
> >> Hello,
> >>
> >> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" on:
> >>
> >> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger an=
onymous mappings on THP boundaries")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80b9=
2fbc]
> >> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272=
d26a]
> >>
> >> in testcase: trinity
> >> version: trinity-x86_64-6a17c218-1_20240527
> >> with following parameters:
> >>
> >>          runtime: 300s
> >>          group: group-00
> >>          nr_groups: 5
> >>
> >>
> >>
> >> compiler: gcc-13
> >> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 16G
> >>
> >> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>
> >>
> >> we noticed the issue does not always happen. 34 times out of 50 runs a=
s below.
> >> the parent is clean.
> >>
> >> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
> >> ---------------- ---------------------------
> >>         fail:runs  %reproduction    fail:runs
> >>             |             |             |
> >>             :50          68%          34:50    dmesg.Kernel_panic-not_=
syncing:Fatal_exception
> >>             :50          68%          34:50    dmesg.RIP:try_get_folio
> >>             :50          68%          34:50    dmesg.invalid_opcode:#[=
##]
> >>             :50          68%          34:50    dmesg.kernel_BUG_at_inc=
lude/linux/page_ref.h
> >>
> >>
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@int=
el.com
> >>
> >>
> >> [  275.267158][ T4335] ------------[ cut here ]------------
> >> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
> >> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> >> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6=
7.0-rc4-00061-gefa7df3e3bb5 #1
> >> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.=
h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> >> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 54 =
11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 ff =
ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be 0=
4
> >
> > If I read this BUG correctly, it is:
> >
> > VM_BUG_ON(!in_atomic() && !irqs_disabled());
> >
>
> Yes, that seems to be the one.
>
> > try_grab_folio() actually assumes it is in an atomic context (irq
> > disabled or preempt disabled) for this call path. This is achieved by
> > disabling irq in gup fast or calling it in rcu critical section in
> > page cache lookup path
>
> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
>
> Is called (mm-unstable) from:
>
> (1) gup_fast function, here IRQs are disable
> (2) gup_hugepte(), possibly problematic
> (3) memfd_pin_folios(), possibly problematic
> (4) __get_user_pages(), likely problematic
>
> (1) should be fine.
>
> (2) is possibly problematic on the !fast path. If so, due to commit
>      a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Pet=
er.
>
> (3) is possibly wrong. CCing Vivek.
>
> (4) is what we hit here
>
> >
> > And try_grab_folio() is used when the folio is a large folio. The
>
>
> We come via process_vm_rw()->pin_user_pages_remote()->__get_user_pages()-=
>try_grab_folio()
>
> That code was added in
>
> commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Jun 28 17:53:07 2023 -0400
>
>      mm/gup: accelerate thp gup even for "pages !=3D NULL"
>
>      The acceleration of THP was done with ctx.page_mask, however it'll b=
e
>      ignored if **pages is non-NULL.
>
>
> Likely the try_grab_folio() in __get_user_pages() is wrong?
>
> As documented, we already hold a refcount. Likely we should better do a
> folio_ref_add() and sanity check the refcount.

Yes, a plain folio_ref_add() seems ok for these cases.

In addition, the comment of folio_try_get_rcu() says, which is just a
wrapper of folio_ref_try_add_rcu():

You can also use this function if you're holding a lock that prevents
pages being frozen & removed; eg the i_pages lock for the page cache
or the mmap_lock or page table lock for page tables.  In this case, it
will always succeed, and you could have used a plain folio_get(), but
it's sometimes more convenient to have a common function called from
both locked and RCU-protected contexts.

So IIUC we can use the plain folio_get() at least for
process_vm_readv/writev since mmap_lock is held in this path.

>
>
> In essence, I think: try_grab_folio() should only be called from GUP-fast=
 where
> IRQs are disabled.

Yes, I agree. Just the fast path should need to call try_grab_folio().

>
> (2), (3) and (4) are possible offenders of that.
>
>
> Or am I getting it all wrong? :)
>
> --
> Cheers,
>
> David / dhildenb
>

