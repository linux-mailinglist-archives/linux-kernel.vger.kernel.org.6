Return-Path: <linux-kernel+bounces-352380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A6991E55
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF8A1C20C22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE3174ED0;
	Sun,  6 Oct 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzO4EVu7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913E1714CA
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219673; cv=none; b=AMduhxLgY79auoGxIHxUw1JdiD08+clumH/2V7oekRAG66EwO8Wx1W2uUmPc3rJoR6jBqGpLq4fQNms3K34e1yiMkXKM/4woMJRJJ6ZfVZ3KiPJORUvW/u0KPPhxGWhHlug8Jc4L2k5X2fbto5MN63K0gK1MF3AbQDC/ozbOgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219673; c=relaxed/simple;
	bh=2VnhaBKoiKnvbvZLh5UaG8L4IaAW/+XmVtsN90RWgfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9ktRkLbhQPTVGOp4DG9I5QElDcD6yfo8rHT9m+RrBzYuinqmqXUIWjbONVx0Gw+rdV1Xkde3FoMSIUWrSFBxkVJDQBHTXSaVmDE0GqETldJLNj6qJxJBJxPfMwiilafZoRGs4jOHXaFFoP32usi1ig5XtDiBa5IGLAGldhTXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzO4EVu7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53988c54ec8so3991230e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728219670; x=1728824470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsbmwdYmbEYG1d12bOYA50NdOqIUXNRGrBdplvigFAQ=;
        b=ZzO4EVu7j22v1HAxu7F9ilr1OJsR/r7DlP2c2t0dgwg4pNgLV1ufSVkvZ9KKVyEwbF
         +4+P6Rv0Su9FPjbRBN6m/JuCeqetxEu7cZiRTHdogs0c8/Wdchdhr89y3dHLm5Z1fGKj
         lkjT4Cv9m1jYmmZLIyMf+r1+vOxXBxbEFE/Dq+DOdti5jCUS3NF4dDP8G45k+ietEt4a
         rFEsN+wCP/z1LNcpuHIUN2LiabJzDqzKci6/hSQbcBDazYB5oBEMQPlDTO6m68yNK5V6
         aMEccblYpgGqQ41lo7L2HSeA7/bBpkRl05fRLTZLesVqOrTO8989cC2KFf2DVRfifjaB
         JrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728219670; x=1728824470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsbmwdYmbEYG1d12bOYA50NdOqIUXNRGrBdplvigFAQ=;
        b=NWJ4oUJcrHL3Zi/5tXNSnLinqny/mecsBUnCEtbjyGTw94F2HKn0G0Pms80eI1IxU4
         WtbQvz6Pi4oDUpPa5mwCmL4+Ul0rQz0jYKQejIxg848y0yNTYIiVObmKCQdy1hydxXOS
         V5cFFOkbN+m99jL/38PQhhHB9EZfTNVVSv3yz+36XYMuYB2qmXNEiCBW55kTchgQKR0D
         8LPFwJ0zEeXxpvWwcAEwWTJCWfoFQinWSikUWVtUaiKK1P/66HhJaKsNCBwmp15ZyH1J
         nxK0rLEBaalZs+Z/1u9U1PT3YiGAFmN/H08tdI8ogOLdDSMKG5JjXrDi33D17exNsLh6
         xxwA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWkIwIWwY3janSepchIaUro7pxtfL6mTfSeFwS7l9g6Snyi2qqEsr9z4YOp9rBvDe18QuiU7hcwnoRtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ATO7MvOuY1jcILa4O72qfYVdWa+UNe12vmWzhD+qKCC2uIlz
	oaj3eK7xA+mGtfFIEIYBQXrKu0j0nmmBUOflZt7IQVu2Rn1C7MCspm7EX7bDpvLQbPmmhqHCbRB
	BC6OKareZK38dSA9DC+vGxeIfuPA=
X-Google-Smtp-Source: AGHT+IGsR/AY7mIlLnkAKMntgnao9Z+Uo6jDWTVDiCuKICpSLi1+jzFVyrEXm9euaeI4qtsCpEWjIVrC3YlgwHezfkM=
X-Received: by 2002:a05:6512:2810:b0:533:43e2:6ac4 with SMTP id
 2adb3069b0e04-539ab9f0ccdmr3561856e87.49.1728219669664; Sun, 06 Oct 2024
 06:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006044755.79634-1-yuan.gao@ucloud.cn>
In-Reply-To: <20241006044755.79634-1-yuan.gao@ucloud.cn>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 6 Oct 2024 22:00:57 +0900
Message-ID: <CAB=+i9Rfy_+4vvbbuLPrVUDU=9n-Mpp2ab5t2f2fq6NG=RAXYA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mm=2Fslub=3A_Avoid_list_corruption_when_remo?=
	=?UTF-8?Q?ving_a_slab_from_the_full_list=C2=A0_=C2=A0?=
To: "yuan.gao" <yuan.gao@ucloud.cn>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:48=E2=80=AFPM yuan.gao <yuan.gao@ucloud.cn> wrote:
>
> Boot with slub_debug=3DUFPZ.
>
> If allocated object failed in alloc_consistency_checks, all objects of
> the slab will be marked as used, and then the slab will be removed from
> the partial list.
>
> When an object belonging to the slab got freed later, the remove_full()
> function is called. Because the slab is neither on the partial list nor
> on the full list, it eventually lead to a list corruption.

Good catch! Thanks for investigating the cause and fixing it.

> So we need to add the slab to full list in this case.

While I believe that behavior is not intended by alloc_debug_processing(),
I can't think of a better fix here without adding some complexity.
The approach looks fine to me.

> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06..a99522b9efc0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2746,6 +2746,8 @@ static void *alloc_single_from_partial(struct kmem_=
cache *s,
>
>         if (!alloc_debug_processing(s, slab, object, orig_size)) {
>                 remove_partial(n, slab);
> +               if (slab->inuse =3D=3D slab->objects)
> +                       add_full(s, n, slab);

Shouldn't this be (folio_test_slab(slab_folio(slab))) instead of
(slab->inuse =3D=3D slab->objects)?
Oh wait. the kernel also should not call remove_partial() for non-slab foli=
os.

So I think it should be:

if (!alloc_debug_processing(s, slab, object, orig_size)) {
        if (folio_test_slab(slab_folio(slab))) {
                remove_partial(n, slab);
                add_full(s, n, slab);
        }
}

By the way, SLUB always messes with struct page fields even when it is
not a slab,
and I think SLUB should avoid modifying those fields before confirming
it is a slab.
(specifically, calling alloc_debug_processing() before updating
->freelist, ->inuse fields)

That is beyond the scope of this patch, but do you want to address it
in the next version
of your patch series?

Cheers,
Hyeonggon

