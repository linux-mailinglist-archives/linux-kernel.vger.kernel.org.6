Return-Path: <linux-kernel+bounces-333474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C797C941
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A58B224EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8D19E7C8;
	Thu, 19 Sep 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULlr4A5u"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C848199FCD;
	Thu, 19 Sep 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749237; cv=none; b=nmEwDgEfjygF4bfytAcvVpK2M11k1XoCZNQiL0Pu60j7VvaKhziwGsDtDsYqTIJH1azAb5s4GurNKN24u25zZL4HqcWYJwhiGwvTSEW3qFUIgu+lsrzvJziMCSGziTyQwneo8w9uEcS9CkmKB5yG1fXtZyTMRa0TiCERG7cz9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749237; c=relaxed/simple;
	bh=V/jzswor5s1CzAW0ZUtaQ2xScydnXC/HzCHeyQzuX6s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=elHwsxy6PZ0hOhBDbD5qzdPKwiXxturAotjHOA4mLdmlCc555cCsCB0NfAKzSv6quMJ8uW3IcFoglXAxRQBESucoG4KQrmIaXiguNDVN70uejcY1kyBdqEPj8iuC/FbdyPyIVvTcTFJy7/Vqdkmlln1Gr8eTNRm7eM4vKH4SpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULlr4A5u; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710d8cab1c3so510060a34.0;
        Thu, 19 Sep 2024 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726749235; x=1727354035; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmKwDE+vQbJFZKx1pG1WdGf3eu6TWhTPyNHtYBECpZw=;
        b=ULlr4A5uPnQvv8zuJeMhQNsPS5XKbuj1Su36sJlvASYInu8BqSaDNossxb3iZTanFz
         6Q4nl+NJE49cELVxRjq9fe0n48nqMrKzclrwQuRtFg6WSgZOs3bIAMP0+crozSq2c5fb
         Uu0devGoK4hOQQbEp9C9GVWjoX+JP4gXfjQ1maHp3NtPhNyMK4/0fUUt+ckGqlFAMGwv
         8GAZ4SYXwkhz9KU16qHqlyEEY6X6GqrDysazm4P0C9Rj0UkyOYW0W15mhyK13Mj86HCT
         mPAgX4lJvJhsYCT95HpVIl4VFNzZKXDtJkFwhz2ZbZVjBO9/LU0NwR+p3D4aC0ou7w5s
         BXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749235; x=1727354035;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmKwDE+vQbJFZKx1pG1WdGf3eu6TWhTPyNHtYBECpZw=;
        b=xOTPz1qvffttZnvOf+m1d03bsheH9ot3qroUuRWWMi8ecDLTrysqrvdlHvZor6ZijM
         6pK7ZUJoB0BQxlBbC55iOwnwOT4aReqTTthQRHiJiI3uPC8DrLL/WRiFtfGMNN7Ks54K
         ENaDQf5QFxfrLaIBjDEn9fyXGoKWlghq4LRcfyNTgE013xlf9tUXZUpLhcXkys2bX1fG
         lhHIh/3/4lr0I2DLKAedq3bkTNMgbMtJ4Yq6REV6XX0oPaZ+mZYHaUxdNwBTEkqWYEVP
         OzyG7I+DLl3w+eyqOfpPAru7bw4VrLWjiCxKcZtxOPOCHWpNn5Czt8oakAnCNFrEgEgR
         dzjg==
X-Forwarded-Encrypted: i=1; AJvYcCV3tYiGEJhwP2YAUPbyYZ9UtCGWK1z1iWJhSMm8v4bwynArKsd1clhYKX3xf7BcZpH6dw7L@vger.kernel.org, AJvYcCV6TxCDRyVpKoVwvY94ULqEOj/ZNsvi37brjb4zaqzL5F5gliQ2u2see/9piO35luZBzsDChJW6g6uRDj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pWzkmVARbPJHGM5AMbN9gbJsmeRIl2DvR1/gpm6KwVKMYDSC
	A5nYgqyeuBEv5bHrm5nsT8C0LgDgmCmuPOdtCAftTFvvKp8vtvq/
X-Google-Smtp-Source: AGHT+IFYmsj/MGU6Jlxx2Ke3WulIat+zjVsJBv8UiM/Yd9cMtImuZ4YQ0EKuwcSVkOnsvQodCYParQ==
X-Received: by 2002:a05:6830:258e:b0:709:4556:fafc with SMTP id 46e09a7af769-71109464466mr16949079a34.2.1726749235048;
        Thu, 19 Sep 2024 05:33:55 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49924501sm9208146a12.53.2024.09.19.05.33.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:33:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ZuvOWM5c8tZotHFL@boqun-archlinux>
Date: Thu, 19 Sep 2024 20:33:27 +0800
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B551C0A-3E09-45E2-9A00-03DEDB1EFEA7@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>
 <ZuvOWM5c8tZotHFL@boqun-archlinux>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8819=E6=97=A5 15:10=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
> On Thu, Sep 19, 2024 at 02:39:13PM +0800, Lai Jiangshan wrote:
>> On Tue, Sep 17, 2024 at 10:34=E2=80=AFPM Boqun Feng =
<boqun.feng@gmail.com> wrote:
>>=20
>>> +static void hazptr_context_snap_readers_locked(struct =
hazptr_reader_tree *tree,
>>> +                                              struct hazptr_context =
*hzcp)
>>> +{
>>> +       lockdep_assert_held(hzcp->lock);
>>> +
>>> +       for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
>>> +               /*
>>> +                * Pairs with smp_store_release() in =
hazptr_{clear,free}().
>>> +                *
>>> +                * Ensure
>>> +                *
>>> +                * <reader>             <updater>
>>> +                *
>>> +                * [access protected pointers]
>>> +                * hazptr_clear();
>>> +                *   smp_store_release()
>>> +                *                      // in reader scan.
>>> +                *                      smp_load_acquire(); // is =
null or unused.
>>> +                *                      [run callbacks] // all =
accesses from
>>> +                *                                      // reader =
must be
>>> +                *                                      // observed.
>>> +                */
>>> +               hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
>>> +
>>> +               if (!is_null_or_unused(val)) {
>>> +                       struct hazptr_slot_snap *snap =3D =
&hzcp->snaps[i];
>>> +
>>> +                       // Already in the tree, need to remove =
first.
>>> +                       if (!is_null_or_unused(snap->slot)) {
>>> +                               reader_del(tree, snap);
>>> +                       }
>>> +                       snap->slot =3D val;
>>> +                       reader_add(tree, snap);
>>> +               }
>>> +       }
>>> +}
>>=20
>> Hello
>>=20
>> I'm curious about whether there are any possible memory leaks here.
>>=20
>> It seems that call_hazptr() never frees the memory until the slot is
>> set to another valid value.
>>=20
>> In the code here, the snap is not deleted when hzcp->snaps[i] is =
null/unused
>> and snap->slot is not which I think it should be.
>>=20
>> And it can cause unneeded deletion and addition of the snap if the =
slot
>> value is unchanged.
>>=20
>=20
> I think you're right. (Although the node will be eventually deleted at
> cleanup_hazptr_context(), however there could be a long-live
> hazptr_context). It should be:
>=20
> hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
> struct hazptr_slot_snap *snap =3D &hzcp->snaps[i];
>=20
> if (val !=3D snap->slot) { // val changed, need to update the tree =
node.
> // Already in the tree, need to remove first.
> if (!is_null_or_unused(snap->slot)) {
> reader_del(tree, snap);
> }
>=20
> // use the latest snapshot.
> snap->slot =3D val;
>=20
> // Add it into tree if there is a reader
> if (!is_null_or_unused(val))
> reader_add(tree, snap);
> }

With this changed, and force users call hazptr_clear() like =
rcu_read_unlock(), we could remove
the reader_del() in cleanup_hazptr_context(), then remove the =
tree->lock?

>=20
> Regards,
> Boqun
>=20
>> I'm not so sure...
>>=20
>> Thanks
>> Lai



