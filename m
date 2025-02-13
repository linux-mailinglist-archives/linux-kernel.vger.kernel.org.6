Return-Path: <linux-kernel+bounces-514067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E4A351F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBEA3A0746
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755922753E3;
	Thu, 13 Feb 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwHjwe/T"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082E2753EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487883; cv=none; b=GqYaEXdPVs10whBU5NGaaMga5f2pE25o46LyAYu7kwu2FZez5dwXk+6cGs3TMYHwAgelp8paGon+5iSK64x1vZRgf9/iVXqTXktFZgHvByRSmvmeild/Hl3I4rXvGdXgK4j1lBdDz54kZNgGBS0prsU+lksKRIL3MPQ65GQk0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487883; c=relaxed/simple;
	bh=0Te9P915LWDuFiq3SXI9sMEX8f27H0RR79AJPYWl/AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtZXePotiDCwgb1s46okXWVg695eDnaiJyyV8SRbJinv1RBe8PEAqZIQ686feuMP0kgyYWbmdLnOwvUPJa08hrK1d9IA+nBrjvO6LJPVlwv1ppWGpOClna13rqKtCg63182cXQ8ijetLn3KMr7WM4l0/WZzM3kTflsL0SXFRvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwHjwe/T; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4718e224eb1so31691cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739487880; x=1740092680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBIR+bt56wtcSqA6PQ7lniFOC3/eEtZ264TeXuADiqg=;
        b=DwHjwe/T0tD+x6+BiW2gOUUI+G4deoTBVFTAMnS1pPxKtSdsMSUH0eHRKoW7hXAQbD
         asiqVXeeUZ42djurxTODZqXFnkG/MGn9zlOxverNfKlnq466Oap93ItzYlHK7H6RK8Sn
         A0O7Go4aYskMcoPeNjNKfGrM7ZFR/6NLaLnkKjTM+sXdfXXh6QCom6uC4T/hYCbWuEfN
         GfboHsiPjwm034qCPYDF6qIeM0CTb9HFV6bYlvHxxmU/n8W2SeuHc705BfrGydrmWFKU
         4mDiXSS+EBN9XSl+pnS0Agv1GAuxOXW/ITHr521mOyhY8vwP2BTA3pa/VAoAbxZj+qVR
         FgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487880; x=1740092680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBIR+bt56wtcSqA6PQ7lniFOC3/eEtZ264TeXuADiqg=;
        b=bvJd4Q2SodU8goqPRBe09Vitrc2ouRRXU8f6mCoNOIyddmQ+cHh+RrPmxckDODsssa
         BhkLnmm3j3VmffZLNQZGDOQeEj7cpYTolAZ9MDIHc35pAGBeTONf9fDQPjRYy2jzZ6jA
         /xoBXxHF22yg8i85GD3XdDak93ntBkyroazJfaVj5t4nkvAJPIO49VDFJVbOHWvWr4PS
         cLj394PjlpvbUpRhmforHuEsWCUJMsXBArwyzTZTwXG61r++NqiR+plExufFlkJvOeLb
         MR6dDKoH/1q+JkrW5qeiCXaH4xQEMFa3oGhVLS516wykCOH56Eh2GP7Stb5uElrrqs1m
         rcug==
X-Forwarded-Encrypted: i=1; AJvYcCXt3fyKKIS6F9g29LxG1PNrPJHIJhGzmP7bdq9aRBhL2F2HYmzyMvFaTLQqCxu88w+hUNWt62WfF9YqdPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1mG/1YX+iARxIhMfBJUhckrhroYP4ngQjUEYPE/6qMYBph4j
	Gu+/kEdbxDJ0xzgccSulDpU/nsKGAhBMWzg2LlC/BtZw3pPgs1TTnV+hSfMFWGgP1iJOspofu3W
	JRZ6N9EoRBMS2fNs266CEmw2Yg/lkMDblDIoA
X-Gm-Gg: ASbGnctenkPfN+viMgzMCWLy3ILH60ONtwDupMOyUMM9P6qzdAteyXPfuJ/tm67EgSU
	TFBvwFJ36QNzoJit44ucr5MEHPEyAL+gMeZcY6cgPSGVYurpT7C0VBeBgHVRuqYNh1732qp1kp+
	ckfU9KK5q+BtV3sF5CV5YlyfefmJg=
X-Google-Smtp-Source: AGHT+IGf874ZRh0zerFODNt7RB8GYHE5ea29qNg8zPbOQBkNZFFwLpiSvmZMzlKwzTmGlhHoTCIIXejfb5EeHZEHOME=
X-Received: by 2002:a05:622a:1191:b0:471:bf59:5f9f with SMTP id
 d75a77b69052e-471ce95eecfmr1150381cf.22.1739487879285; Thu, 13 Feb 2025
 15:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111042604.3230628-1-surenb@google.com> <20250111042604.3230628-12-surenb@google.com>
 <gdipfy63r4wxiqlnglsjzatpej6jjswimuzadm2l57o2e45u56@qfd763n4ysft>
 <CAJuCfpGu4UVXiBaivTVOGNBVVz3rhZ+VY27gT3_R0cTij5fTGw@mail.gmail.com>
 <20250115104841.GX5388@noisy.programming.kicks-ass.net> <20250115111334.GE8385@noisy.programming.kicks-ass.net>
 <20250115160011.GG8385@noisy.programming.kicks-ass.net> <20250117154135.GA17569@willie-the-truck>
 <20250127140915.GA25672@willie-the-truck> <CAJuCfpFuZt7h3gd5Oih74oC_VsSpt=psSoPoBLJWoSam7TFgPQ@mail.gmail.com>
 <CAJuCfpHJedxhZuuoKkKaQXsT-3tPSkhUwHadJRGEdTxSkzRc_w@mail.gmail.com> <CAJuCfpGeHaQu_F6mJo70S+cxWD_PvhDCvfBsD-UXWqwMuOTRYA@mail.gmail.com>
In-Reply-To: <CAJuCfpGeHaQu_F6mJo70S+cxWD_PvhDCvfBsD-UXWqwMuOTRYA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 13 Feb 2025 15:04:28 -0800
X-Gm-Features: AWEUYZlCybXByrvagkzEiChzM_Vh_Z7U51Cwvq0lCWEUfWRGM0B5G4X0WxzOEd8
Message-ID: <CAJuCfpED6Bhxhbo59Q8MitwmWKwzEPiV6Z0e6e0H-0VE8Z=Erg@mail.gmail.com>
Subject: Re: [PATCH] refcount: Strengthen inc_not_zero()
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com, mark.rutland@arm.com, 
	Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david.laight.linux@gmail.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, lokeshgidra@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, richard.weiyang@gmail.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:03=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jan 28, 2025 at 3:51=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:21=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 6:09=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 03:41:36PM +0000, Will Deacon wrote:
> > > > > On Wed, Jan 15, 2025 at 05:00:11PM +0100, Peter Zijlstra wrote:
> > > > > > On Wed, Jan 15, 2025 at 12:13:34PM +0100, Peter Zijlstra wrote:
> > > > > >
> > > > > > > Notably, it means refcount_t is entirely unsuitable for anyth=
ing
> > > > > > > SLAB_TYPESAFE_BY_RCU, since they all will need secondary vali=
dation
> > > > > > > conditions after the refcount succeeds.
> > > > > > >
> > > > > > > And this is probably fine, but let me ponder this all a littl=
e more.
> > > > > >
> > > > > > Even though SLAB_TYPESAFE_BY_RCU is relatively rare, I think we=
'd better
> > > > > > fix this, these things are hard enough as they are.
> > > > > >
> > > > > > Will, others, wdyt?
> > > > >
> > > > > We should also update the Documentation (atomic_t.txt and
> > > > > refcount-vs-atomic.rst) if we strengthen this.
> > > > >
> > > > > > ---
> > > > > > Subject: refcount: Strengthen inc_not_zero()
> > > > > >
> > > > > > For speculative lookups where a successful inc_not_zero() pins =
the
> > > > > > object, but where we still need to double check if the object a=
cquired
> > > > > > is indeed the one we set out to aquire, needs this validation t=
o happen
> > > > > > *after* the increment.
> > > > > >
> > > > > > Notably SLAB_TYPESAFE_BY_RCU is one such an example.
> > > > > >
> > > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > > ---
> > > > > >  include/linux/refcount.h | 15 ++++++++-------
> > > > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/refcount.h b/include/linux/refcount.=
h
> > > > > > index 35f039ecb272..340e7ffa445e 100644
> > > > > > --- a/include/linux/refcount.h
> > > > > > +++ b/include/linux/refcount.h
> > > > > > @@ -69,9 +69,10 @@
> > > > > >   * its the lock acquire, for RCU/lockless data structures its =
the dependent
> > > > > >   * load.
> > > > > >   *
> > > > > > - * Do note that inc_not_zero() provides a control dependency w=
hich will order
> > > > > > - * future stores against the inc, this ensures we'll never mod=
ify the object
> > > > > > - * if we did not in fact acquire a reference.
> > > > > > + * Do note that inc_not_zero() does provide acquire order, whi=
ch will order
> > > > > > + * future load and stores against the inc, this ensures all su=
bsequent accesses
> > > > > > + * are from this object and not anything previously occupying =
this memory --
> > > > > > + * consider SLAB_TYPESAFE_BY_RCU.
> > > > > >   *
> > > > > >   * The decrements will provide release order, such that all th=
e prior loads and
> > > > > >   * stores will be issued before, it also provides a control de=
pendency, which
> > > > > > @@ -144,7 +145,7 @@ bool __refcount_add_not_zero(int i, refcoun=
t_t *r, int *oldp)
> > > > > >     do {
> > > > > >             if (!old)
> > > > > >                     break;
> > > > > > -   } while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + =
i));
> > > > > > +   } while (!atomic_try_cmpxchg_acquire(&r->refs, &old, old + =
i));
> > > > >
> > > > > Hmm, do the later memory accesses need to be ordered against the =
store
> > > > > part of the increment or just the read? If it's the former, then =
I don't
> > > > > think that _acquire is sufficient -- accesses can still get in-be=
tween
> > > > > the read and write parts of the RmW.
> > > >
> > > > I dug some more into this at the end of last week. For the
> > > > SLAB_TYPESAFE_BY_RCU where we're racing inc_not_zero() with
> > > > dec_and_test(), then I think using _acquire() above is correct as t=
he
> > > > later references can only move up into the critical section in the =
case
> > > > that we successfully obtained a reference.
> > > >
> > > > However, if we're going to make the barriers implicit in the refcou=
nt
> > > > operations here then I think we also need to do something on the pr=
oducer
> > > > side for when the object is re-initialised after being destroyed an=
d
> > > > allocated again. I think that would necessitate release ordering fo=
r
> > > > refcount_set() so that whatever allows the consumer to validate the
> > > > object (e.g. sequence number) is published *before* the refcount.
> > >
> > > Thanks Will!
> > > I would like to expand on your answer to provide an example of the
> > > race that would happen without release ordering in the producer. To
> > > save reader's time I provide a simplified flow and reasoning first.
> > > More detailed code of what I'm considering a typical
> > > SLAB_TYPESAFE_BY_RCU refcounting example is added at the end of my
> > > reply (Addendum).
> > > Simplified flow looks like this:
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return;
> > >     smp_rmb(); /* Peter's new acquire fence */
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return;
> > >     }
> > >     use(obj->value);
> > >
> > > producer:
> > >     old_key =3D obj->key;
> > >     remove(collection, old_key);
> > >     if (!refcount_dec_and_test(&obj->ref))
> > >         return;
> > >     obj->key =3D KEY_INVALID;
> > >     free(objj);
> > >     ...
> > >     obj =3D malloc(); /* obj is reused */
> > >     obj->key =3D new_key;
> > >     obj->value =3D new_value;
> > >     smp_wmb(); /* Will's proposed release fence */
> > >     refcount_set(obj->ref, 1);
> > >     insert(collection, key, obj);
> > >
> > > Let's consider a case when new_key =3D=3D old_key. Will call both of =
them
> > > "key". Without WIll's proposed fence the following reordering is
> > > possible:
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >
> > >                  producer:
> > >                      key =3D obj->key
> > >                      remove(collection, key);
> > >                      if (!refcount_dec_and_test(&obj->ref))
> > >                          return;
> > >                      obj->key =3D KEY_INVALID;
> > >                      free(objj);
> > >                      obj =3D malloc(); /* obj is reused */
> > >                      refcount_set(obj->ref, 1);
> > >                      obj->key =3D key; /* same key */
> > >
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return;
> > >     smp_rmb();
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return;
> > >     }
> > >     use(obj->value);
> > >
> > >                      obj->value =3D new_value; /* reordered store */
> > >                      add(collection, key, obj);
> > >
> > > So, the consumer finds the old object, successfully takes a refcount
> > > and validates the key. It succeeds because the object is allocated an=
d
> > > has the same key, which is fine. However it proceeds to use stale
> > > obj->value. Will's proposed release ordering would prevent that.
> > >
> > > The example in https://elixir.bootlin.com/linux/v6.12.6/source/includ=
e/linux/slab.h#L102
> > > omits all these ordering issues for SLAB_TYPESAFE_BY_RCU.
> > > I think it would be better to introduce two new functions:
> > > refcount_add_not_zero_acquire() and refcount_set_release(), clearly
> > > document that they should be used when a freed object can be recycled
> > > and reused, like in SLAB_TYPESAFE_BY_RCU case. refcount_set_release()
> > > should also clarify that once it's called, the object can be accessed
> > > by consumers even if it was not added yet into the collection used fo=
r
> > > object lookup (like in the example above). SLAB_TYPESAFE_BY_RCU
> > > comment at https://elixir.bootlin.com/linux/v6.12.6/source/include/li=
nux/slab.h#L102
> > > then can explicitly use these new functions in the example code,
> > > further clarifying their purpose and proper use.
> > > WDYT?
> >
> > Hi Peter,
> > Should I take a stab at preparing a patch to add the two new
> > refcounting functions suggested above with updates to the
> > documentation and comments?
> > If you disagree with that or need more time to decide then I'll wait.
> > Please let me know.
>
> Not sure if "--in-reply-to" worked but I just posted a patch adding
> new refcounting APIs for SLAB_TYPESAFE_BY_RCU here:
> https://lore.kernel.org/all/20250206025201.979573-1-surenb@google.com/

Since I did not get any replies other than Vlastimil's Ack on the
above patch, I went ahead and posted v10 of my patchset [1] and
included the patch above in it [2]. Feedback is highly appreciated!

[1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250213224655.1680278-11-surenb@google.com=
/


> Since Peter seems to be busy I discussed these ordering requirements
> for SLAB_TYPESAFE_BY_RCU with Paul McKenney and he was leaning towards
> having separate functions with the additional fences for this case.
> That's what I provided in my patch.
> Another possible option is to add acquire ordering in the
> __refcount_add_not_zero() as Peter suggested and add
> refcount_set_release() function.
> Thanks,
> Suren.
>
>
> > Thanks,
> > Suren.
> >
> >
> > >
> > > ADDENDUM.
> > > Detailed code for typical use of refcounting with SLAB_TYPESAFE_BY_RC=
U:
> > >
> > > struct object {
> > >     refcount_t ref;
> > >     u64 key;
> > >     u64 value;
> > > };
> > >
> > > void init(struct object *obj, u64 key, u64 value)
> > > {
> > >     obj->key =3D key;
> > >     obj->value =3D value;
> > >     smp_wmb(); /* Will's proposed release fence */
> > >     refcount_set(obj->ref, 1);
> > > }
> > >
> > > bool get_ref(struct object *obj, u64 key)
> > > {
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return false;
> > >     smp_rmb(); /* Peter's new acquire fence */
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return false;
> > >     }
> > >     return true;
> > > }
> > >
> > > void put_ref(struct object *obj)
> > > {
> > >     if (!refcount_dec_and_test(&obj->ref))
> > >         return;
> > >     obj->key =3D KEY_INVALID;
> > >     free(obj);
> > > }
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >     if (!get_ref(obj, key)
> > >         return;
> > >     use(obj->value);
> > >
> > > producer:
> > >     remove(collection, old_obj->key);
> > >     put_ref(old_obj);
> > >     new_obj =3D malloc();
> > >     init(new_obj, new_key, new_value);
> > >     insert(collection, new_key, new_obj);
> > >
> > > With SLAB_TYPESAFE_BY_RCU old_obj in the producer can be reused and b=
e
> > > equal to new_obj.
> > >
> > >
> > > >
> > > > Will

On Wed, Feb 5, 2025 at 7:03=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jan 28, 2025 at 3:51=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:21=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 6:09=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 03:41:36PM +0000, Will Deacon wrote:
> > > > > On Wed, Jan 15, 2025 at 05:00:11PM +0100, Peter Zijlstra wrote:
> > > > > > On Wed, Jan 15, 2025 at 12:13:34PM +0100, Peter Zijlstra wrote:
> > > > > >
> > > > > > > Notably, it means refcount_t is entirely unsuitable for anyth=
ing
> > > > > > > SLAB_TYPESAFE_BY_RCU, since they all will need secondary vali=
dation
> > > > > > > conditions after the refcount succeeds.
> > > > > > >
> > > > > > > And this is probably fine, but let me ponder this all a littl=
e more.
> > > > > >
> > > > > > Even though SLAB_TYPESAFE_BY_RCU is relatively rare, I think we=
'd better
> > > > > > fix this, these things are hard enough as they are.
> > > > > >
> > > > > > Will, others, wdyt?
> > > > >
> > > > > We should also update the Documentation (atomic_t.txt and
> > > > > refcount-vs-atomic.rst) if we strengthen this.
> > > > >
> > > > > > ---
> > > > > > Subject: refcount: Strengthen inc_not_zero()
> > > > > >
> > > > > > For speculative lookups where a successful inc_not_zero() pins =
the
> > > > > > object, but where we still need to double check if the object a=
cquired
> > > > > > is indeed the one we set out to aquire, needs this validation t=
o happen
> > > > > > *after* the increment.
> > > > > >
> > > > > > Notably SLAB_TYPESAFE_BY_RCU is one such an example.
> > > > > >
> > > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > > ---
> > > > > >  include/linux/refcount.h | 15 ++++++++-------
> > > > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/refcount.h b/include/linux/refcount.=
h
> > > > > > index 35f039ecb272..340e7ffa445e 100644
> > > > > > --- a/include/linux/refcount.h
> > > > > > +++ b/include/linux/refcount.h
> > > > > > @@ -69,9 +69,10 @@
> > > > > >   * its the lock acquire, for RCU/lockless data structures its =
the dependent
> > > > > >   * load.
> > > > > >   *
> > > > > > - * Do note that inc_not_zero() provides a control dependency w=
hich will order
> > > > > > - * future stores against the inc, this ensures we'll never mod=
ify the object
> > > > > > - * if we did not in fact acquire a reference.
> > > > > > + * Do note that inc_not_zero() does provide acquire order, whi=
ch will order
> > > > > > + * future load and stores against the inc, this ensures all su=
bsequent accesses
> > > > > > + * are from this object and not anything previously occupying =
this memory --
> > > > > > + * consider SLAB_TYPESAFE_BY_RCU.
> > > > > >   *
> > > > > >   * The decrements will provide release order, such that all th=
e prior loads and
> > > > > >   * stores will be issued before, it also provides a control de=
pendency, which
> > > > > > @@ -144,7 +145,7 @@ bool __refcount_add_not_zero(int i, refcoun=
t_t *r, int *oldp)
> > > > > >     do {
> > > > > >             if (!old)
> > > > > >                     break;
> > > > > > -   } while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + =
i));
> > > > > > +   } while (!atomic_try_cmpxchg_acquire(&r->refs, &old, old + =
i));
> > > > >
> > > > > Hmm, do the later memory accesses need to be ordered against the =
store
> > > > > part of the increment or just the read? If it's the former, then =
I don't
> > > > > think that _acquire is sufficient -- accesses can still get in-be=
tween
> > > > > the read and write parts of the RmW.
> > > >
> > > > I dug some more into this at the end of last week. For the
> > > > SLAB_TYPESAFE_BY_RCU where we're racing inc_not_zero() with
> > > > dec_and_test(), then I think using _acquire() above is correct as t=
he
> > > > later references can only move up into the critical section in the =
case
> > > > that we successfully obtained a reference.
> > > >
> > > > However, if we're going to make the barriers implicit in the refcou=
nt
> > > > operations here then I think we also need to do something on the pr=
oducer
> > > > side for when the object is re-initialised after being destroyed an=
d
> > > > allocated again. I think that would necessitate release ordering fo=
r
> > > > refcount_set() so that whatever allows the consumer to validate the
> > > > object (e.g. sequence number) is published *before* the refcount.
> > >
> > > Thanks Will!
> > > I would like to expand on your answer to provide an example of the
> > > race that would happen without release ordering in the producer. To
> > > save reader's time I provide a simplified flow and reasoning first.
> > > More detailed code of what I'm considering a typical
> > > SLAB_TYPESAFE_BY_RCU refcounting example is added at the end of my
> > > reply (Addendum).
> > > Simplified flow looks like this:
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return;
> > >     smp_rmb(); /* Peter's new acquire fence */
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return;
> > >     }
> > >     use(obj->value);
> > >
> > > producer:
> > >     old_key =3D obj->key;
> > >     remove(collection, old_key);
> > >     if (!refcount_dec_and_test(&obj->ref))
> > >         return;
> > >     obj->key =3D KEY_INVALID;
> > >     free(objj);
> > >     ...
> > >     obj =3D malloc(); /* obj is reused */
> > >     obj->key =3D new_key;
> > >     obj->value =3D new_value;
> > >     smp_wmb(); /* Will's proposed release fence */
> > >     refcount_set(obj->ref, 1);
> > >     insert(collection, key, obj);
> > >
> > > Let's consider a case when new_key =3D=3D old_key. Will call both of =
them
> > > "key". Without WIll's proposed fence the following reordering is
> > > possible:
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >
> > >                  producer:
> > >                      key =3D obj->key
> > >                      remove(collection, key);
> > >                      if (!refcount_dec_and_test(&obj->ref))
> > >                          return;
> > >                      obj->key =3D KEY_INVALID;
> > >                      free(objj);
> > >                      obj =3D malloc(); /* obj is reused */
> > >                      refcount_set(obj->ref, 1);
> > >                      obj->key =3D key; /* same key */
> > >
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return;
> > >     smp_rmb();
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return;
> > >     }
> > >     use(obj->value);
> > >
> > >                      obj->value =3D new_value; /* reordered store */
> > >                      add(collection, key, obj);
> > >
> > > So, the consumer finds the old object, successfully takes a refcount
> > > and validates the key. It succeeds because the object is allocated an=
d
> > > has the same key, which is fine. However it proceeds to use stale
> > > obj->value. Will's proposed release ordering would prevent that.
> > >
> > > The example in https://elixir.bootlin.com/linux/v6.12.6/source/includ=
e/linux/slab.h#L102
> > > omits all these ordering issues for SLAB_TYPESAFE_BY_RCU.
> > > I think it would be better to introduce two new functions:
> > > refcount_add_not_zero_acquire() and refcount_set_release(), clearly
> > > document that they should be used when a freed object can be recycled
> > > and reused, like in SLAB_TYPESAFE_BY_RCU case. refcount_set_release()
> > > should also clarify that once it's called, the object can be accessed
> > > by consumers even if it was not added yet into the collection used fo=
r
> > > object lookup (like in the example above). SLAB_TYPESAFE_BY_RCU
> > > comment at https://elixir.bootlin.com/linux/v6.12.6/source/include/li=
nux/slab.h#L102
> > > then can explicitly use these new functions in the example code,
> > > further clarifying their purpose and proper use.
> > > WDYT?
> >
> > Hi Peter,
> > Should I take a stab at preparing a patch to add the two new
> > refcounting functions suggested above with updates to the
> > documentation and comments?
> > If you disagree with that or need more time to decide then I'll wait.
> > Please let me know.
>
> Not sure if "--in-reply-to" worked but I just posted a patch adding
> new refcounting APIs for SLAB_TYPESAFE_BY_RCU here:
> https://lore.kernel.org/all/20250206025201.979573-1-surenb@google.com/
> Since Peter seems to be busy I discussed these ordering requirements
> for SLAB_TYPESAFE_BY_RCU with Paul McKenney and he was leaning towards
> having separate functions with the additional fences for this case.
> That's what I provided in my patch.
> Another possible option is to add acquire ordering in the
> __refcount_add_not_zero() as Peter suggested and add
> refcount_set_release() function.
> Thanks,
> Suren.
>
>
> > Thanks,
> > Suren.
> >
> >
> > >
> > > ADDENDUM.
> > > Detailed code for typical use of refcounting with SLAB_TYPESAFE_BY_RC=
U:
> > >
> > > struct object {
> > >     refcount_t ref;
> > >     u64 key;
> > >     u64 value;
> > > };
> > >
> > > void init(struct object *obj, u64 key, u64 value)
> > > {
> > >     obj->key =3D key;
> > >     obj->value =3D value;
> > >     smp_wmb(); /* Will's proposed release fence */
> > >     refcount_set(obj->ref, 1);
> > > }
> > >
> > > bool get_ref(struct object *obj, u64 key)
> > > {
> > >     if (!refcount_inc_not_zero(&obj->ref))
> > >         return false;
> > >     smp_rmb(); /* Peter's new acquire fence */
> > >     if (READ_ONCE(obj->key) !=3D key) {
> > >         put_ref(obj);
> > >         return false;
> > >     }
> > >     return true;
> > > }
> > >
> > > void put_ref(struct object *obj)
> > > {
> > >     if (!refcount_dec_and_test(&obj->ref))
> > >         return;
> > >     obj->key =3D KEY_INVALID;
> > >     free(obj);
> > > }
> > >
> > > consumer:
> > >     obj =3D lookup(collection, key);
> > >     if (!get_ref(obj, key)
> > >         return;
> > >     use(obj->value);
> > >
> > > producer:
> > >     remove(collection, old_obj->key);
> > >     put_ref(old_obj);
> > >     new_obj =3D malloc();
> > >     init(new_obj, new_key, new_value);
> > >     insert(collection, new_key, new_obj);
> > >
> > > With SLAB_TYPESAFE_BY_RCU old_obj in the producer can be reused and b=
e
> > > equal to new_obj.
> > >
> > >
> > > >
> > > > Will

