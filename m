Return-Path: <linux-kernel+bounces-197612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FD8D6D13
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D61C23CFA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4573224;
	Sat,  1 Jun 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlprIsFk"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F321852
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717200093; cv=none; b=qMw3qORX+jKICEF02xeAm1+yxjlB6seVXoKaEvXWOPa05irf14lrXZURz/lL+s/H1X7Z/s9ZPqh9ROPTOqWJWCQtvcHzu5ZTXw6BnnyaL1K4fu92Us9QJ5k4pkg/ECdjcNdKI+BSiV8e4up66RoE2+ssJAFMA4+h7M65SOFUTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717200093; c=relaxed/simple;
	bh=MDYykw9wHYPRfns++qQzwZ937rYBoOC+12jgBzqGLNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsbs4h5sI3Jc/GIGmn0602ect5661B++s6sdqP+WffI+PQncrTxIz2wrTWFvONaGUrcHbngoE5vbpapVy2x4/zO0X64NeQXzgVOuB0Sljbjq8v1+k54D/FspH2VgElnoyq7hZrJs27T0N9fFPknWkWXIbpu2jL/Jri2WpMFdaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlprIsFk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso3026997a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717200090; x=1717804890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=524zdDFTH+Cq7WRnmF848UGfgcIcWPLE/iJesHfvItA=;
        b=LlprIsFkCxvvA/O++mujNMddaVEGfggJycbiGxJi0Gym/hhJVsTtGdGcHiA8W4+qTm
         4IPOBtLYgiXwqJKOBVMPuTTFGeOUOOODYa3NgN8F7I3MS6jfEPhxrtHIlF2/zhMxf1Ka
         aqlFroatut2Vqtl62stvLDItNNhDnK2J7w+PFlsc/3yz3+O6rzRHObbK3SQ/mDJR6nkp
         pUfsjqRJQBE6PeOJV8LXWjoYL5UMPblOkG/3yIP9u00WNH+8UH5NQb3zAJ69EWP3xVQ9
         yAJxebFLmyuL7/lgXIJyLl16CHHWkKD8JSx6P+dFHR2o7GVlxpLqiQIaV2qM9aE8CF9B
         PvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717200090; x=1717804890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=524zdDFTH+Cq7WRnmF848UGfgcIcWPLE/iJesHfvItA=;
        b=WNyWp6IWrxkRNPynCMOIkDNVg6hbwSSqeR1p9zMoATXEtk6fctRqWrsdG8iu6UR5I2
         9Xz50Ghg04Jcd001N4LKkg39h3FlgIeMg2f99ICqF4plQaiuHr8ydI9hqaFjGCgbe29H
         8n/i8Mp/DCl7wAIB71my0hqtsvt5oK1KwV+eDJjYq+N4bzRz8GYDNTd5uv/ltErUEMVG
         jtIVohrDui7UxhXdwTPppGvt49Y8QnednY4irREH61o2AY5YQF02MbnOB8JXxNqZ3JDQ
         NQfGKT7IwjQkXWWreqE6qXbqrHqmyt714yLvgWiCJxuDJGhhdO/97p7niFCM8iYNLuuo
         ObYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE6emqH9rThbzECq/4ajSfvHZe8LIT5dchwjv4VIAgB6v98DA54W5ZHXwkKe+wxgeobeN6RBW9zxWZXu3n0hp0niSowyAyvHSK0yVW
X-Gm-Message-State: AOJu0YwtrIGbeWg62mHDyH8kHEPC6JMsSAbFvbZrxu6KB4VcR/I/kaqa
	x37P7NWdxVgbv5BjUEifdwFcwc0l7GO6FlMxeR9Tf10EGUFM62FcoCiGQm+aWYOkqiWvYbOsDCv
	lK8tmCb2qSDdnlKs+ZIIjXGBeRto=
X-Google-Smtp-Source: AGHT+IGiU+0QniSLGCdZ7m/gT5QmO5VbQH36IAG/Heow8ZDZt51xdXJ24cdppqh1Q+wptzwGMRQ+2h9KQz00O+oLkG8=
X-Received: by 2002:a17:907:5c4:b0:a59:9af5:2c9c with SMTP id
 a640c23a62f3a-a6820902b7amr309245266b.38.1717200089952; Fri, 31 May 2024
 17:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <ZlpcRnuZUEYJJ0JA@x1n>
In-Reply-To: <ZlpcRnuZUEYJJ0JA@x1n>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 17:01:18 -0700
Message-ID: <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, kernel test robot <oliver.sang@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 4:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
> > try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> >
> > Is called (mm-unstable) from:
> >
> > (1) gup_fast function, here IRQs are disable
> > (2) gup_hugepte(), possibly problematic
> > (3) memfd_pin_folios(), possibly problematic
> > (4) __get_user_pages(), likely problematic
> >
> > (1) should be fine.
> >
> > (2) is possibly problematic on the !fast path. If so, due to commit
> >     a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Pe=
ter.
> >
> > (3) is possibly wrong. CCing Vivek.
> >
> > (4) is what we hit here
>
> I guess it was overlooked because try_grab_folio() didn't have any commen=
t
> or implication on RCU or IRQ internal helpers being used, hence a bit
> confusing.  E.g. it has different context requirement on try_grab_page(),
> even though they look like sister functions.  It might be helpful to have=
 a
> better name, something like try_grab_folio_rcu() in this case.
>
> Btw, none of above cases (2-4) have real bug, but we're looking at some w=
ay
> to avoid triggering the sanity check, am I right?  I hope besides the hos=
t
> splash I didn't overlook any other side effect this issue would cause, an=
d
> the splash IIUC should so far be benign, as either gup slow (2,4) or the
> newly added memfd_pin_folios() (3) look like to have the refcount stabliz=
ed
> anyway.
>
> Yang's patch in the other email looks sane to me, just that then we'll ad=
d
> quite some code just to avoid this sanity check in paths 2-4 which seems
> like an slight overkill.
>
> One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid of
> its RCU limitation. It boils down to whether we can use atomic_add_unless=
()
> on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
> (get_page_unless_zero, etc.) in generic code and I don't understand why
> here we need to treat folio_ref_try_add_rcu() specially.
>
> IOW, the assertions here we added:
>
>         VM_BUG_ON(!in_atomic() && !irqs_disabled());
>
> Is because we need atomicity of below sequences:
>
>         VM_BUG_ON_FOLIO(folio_ref_count(folio) =3D=3D 0, folio);
>         folio_ref_add(folio, count);
>
> But atomic ops avoids it.

Yeah, I didn't think of why atomic can't do it either. But is it
written in this way because we want to catch the refcount =3D=3D 0 case
since it means a severe bug? Did we miss something?

>
> This chunk of code was (mostly) originally added in 2008 in commit
> e286781d5f2e ("mm: speculative page references").
>
> In short, I'm wondering whether something like below would make sense and
> easier:
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 1acf5bac7f50..c89a67d239d1 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -258,26 +258,9 @@ static inline bool folio_try_get(struct folio *folio=
)
>         return folio_ref_add_unless(folio, 1, 0);
>  }
>
> -static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
> -{
> -#ifdef CONFIG_TINY_RCU
> -       /*
> -        * The caller guarantees the folio will not be freed from interru=
pt
> -        * context, so (on !SMP) we only need preemption to be disabled
> -        * and TINY_RCU does that for us.
> -        */
> -# ifdef CONFIG_PREEMPT_COUNT
> -       VM_BUG_ON(!in_atomic() && !irqs_disabled());
> -# endif
> -       VM_BUG_ON_FOLIO(folio_ref_count(folio) =3D=3D 0, folio);
> -       folio_ref_add(folio, count);
> -#else
> -       if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> -               /* Either the folio has been freed, or will be freed. */
> -               return false;
> -       }
> -#endif
> -       return true;
> +static inline bool folio_ref_try_add(struct folio *folio, int count)
> +{
> +       return folio_ref_add_unless(folio, count, 0);
>  }
>
>  /**
> @@ -305,7 +288,7 @@ static inline bool folio_ref_try_add_rcu(struct folio=
 *folio, int count)
>   */
>  static inline bool folio_try_get_rcu(struct folio *folio)
>  {
> -       return folio_ref_try_add_rcu(folio, 1);
> +       return folio_ref_try_add(folio, 1);
>  }
>
>  static inline int page_ref_freeze(struct page *page, int count)
> diff --git a/mm/gup.c b/mm/gup.c
> index e17466fd62bb..17f89e8d31f1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -78,7 +78,7 @@ static inline struct folio *try_get_folio(struct page *=
page, int refs)
>         folio =3D page_folio(page);
>         if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
>                 return NULL;
> -       if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
> +       if (unlikely(!folio_ref_try_add(folio, refs)))
>                 return NULL;
>
>         /*
> =3D=3D=3D8<=3D=3D=3D
>
> So instead of adding new code, we fix it by removing some.  There might b=
e
> some implication on TINY_RCU / UP config on using the atomic_add_unless()
> to replace one atomic_add(), but I'm not sure whether that's a major issu=
e.
>
> The benefit is try_get_folio() then don't need a renaming then, because t=
he
> rcu implication just went away.
>
> Thanks,
>
> --
> Peter Xu
>

