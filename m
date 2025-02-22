Return-Path: <linux-kernel+bounces-526863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A2A4048F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AB19C77A9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412E15853B;
	Sat, 22 Feb 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjXXWjHH"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8715689A;
	Sat, 22 Feb 2025 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186529; cv=none; b=lmC4JdPxxn0XQSZwQH5dzLL3iotgsIswJRxMr1DIcZ0+x+EB7TNDIJPS1VOpDVdNGAGy+1J7HX9mtlbke3gYhzbpVa9s3MrBwEQfoV+uIRjrboJBNSd18T3d5KKy29d3/pEZXpNjIwTJmz7+lg2WYjML6mG6DskZTWJrN2h2DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186529; c=relaxed/simple;
	bh=eiHBFZB1AnxJ5TW8PWamnA9CJNOTzYW1KKiijjiBiyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJT6UfYd0EU8qc7LBEVGJh+8o3JDgCIXUFlBE6Ri3ruVhnVS1Jbnb5sFVZSk2oK0DddQphTPi9j9bc6pcdayo2Av2rgzoCwnGYrqXNpOh2SGSX4iZ3bXqMnn5TSRxGGSzLYEUuSc+L1vow0x3gm0Z3timRbC1Zn0mW08TrHxUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjXXWjHH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so26926241fa.0;
        Fri, 21 Feb 2025 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740186526; x=1740791326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twRF1Yb6ks2c0NMt8l+unYYtXyEB7vp++pfmVfAVAp8=;
        b=KjXXWjHHlfmBGCpHtnWgKIxRSvC/wHBCmv9c+/y7RIWzTiBvTzFcameUVDgkrbJfts
         d+fioEtQpliz6SZLTjG8d26LBOiAuzctMCmxNdq3fdOCMOB+Dril2/MxYMqMcgXQBR7y
         vGgHXmHNHv0pBuMbckjh/araaVA7qT80QjImqT8sqKSUkX3Ee9fbNO49CEaQIBg7sM3n
         bCrEfL4whmaSgo+B0swmCa8ENXc3c+F3cDzAcHYIsCx1q4WgBwRojjC13Ock+dcQlOSH
         zk+xOKv+vNXpgkGQf0DUsWVIVfAd+W1BoLwmoVel3ZrqxzDAwJJ1bngc1MLp/iH87rBh
         Cy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186526; x=1740791326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twRF1Yb6ks2c0NMt8l+unYYtXyEB7vp++pfmVfAVAp8=;
        b=wPRpIdU5PC2oK9dCZ53ant/KT8HLG5VSHxZNHB651jXeE2lNwbcLs5GGdEubfNxz6d
         01/Oq0o5nmk79Rr+CjkDSc9q2EbFPx08Z70mGDyfnCnFIy3urb5kyW5AcyZYP6jEpvwi
         kJsACALERi2mSz5mjsW/udxbWMt7D6BGkAvCBeylYozVGp/m65qaVAa0RP6drXHlUiKY
         XTBeTyU9CLT0ZKmc2sxWjFfEpCganxc8FmsofzlRWLRj9roPSwxEivh37C6pqHfoYwDR
         4bqg3W5vW1nB7SihaEIBk9a99v34P+1GsF7dg0ypW8U8m5NcCOJKw/ClqX4NoYUtD/VI
         bmKA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pndUUHfWJr80hCQmvYj0bIkIu35so/a8Mxwb4GELiMvQxtzFsJAVmCGdY6YIdN22kjz4DFQtCRM3lweDRCI=@vger.kernel.org, AJvYcCXLTGyby24JZLhdLmBdhzTUpod2EaSoEn6Mh+9vUP9Neu1jvexTfpwiXFS07IVS9ayOXUyoO8r9IaUAekE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrdDMe0rLtMs0ZrbS+p8N0BD7OA1/T7pa31+PCOe59fdusLrN
	JiWrOnyXoF7c31t2XnfZcx2pa6+6VLRMa2r4Db2uxjDht59GrfuXDU2CujfJkWwK5aR8uXxd0MX
	PaWfo9X7jBgtp3QTCPcy3SGNpsIM=
X-Gm-Gg: ASbGnctYCghuXhE3o4VRUiKCZLW4TAbyFulSkVpBcNO9i0sNGgAUBEGShhxjVhzLvNn
	zWbuCRp/tmJ6szNoVaXkcnWWhbLwte6cGeljh1ccyCvGl6e/eVINUtUpBsAvaA9i7dIPzTvQoAf
	Tz06qvCZBGyPN/6rzfyyznJwQgysUwK7ze1QYGF+M/
X-Google-Smtp-Source: AGHT+IHO1sZPKCJvottV4Oy0wP642BVTLV/j/atejjvfTSUHbXM2AUyqEmPuO8umXoX9wKXNQHt8aLWsAnIpzRZi/eY=
X-Received: by 2002:a2e:9b95:0:b0:308:fa1d:d833 with SMTP id
 38308e7fff4ca-30a5b21dc43mr18394241fa.37.1740186525867; Fri, 21 Feb 2025
 17:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org> <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
 <Z7iZevQkYVGDoeTa@Mac.home> <CAJ-ks9=f45WJKFwB4J0_a4j_Urf=yR_wukmfhRwRqtczDXfSPg@mail.gmail.com>
 <Z7kAD_8OQdVLSO4l@Mac.home>
In-Reply-To: <Z7kAD_8OQdVLSO4l@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 20:08:09 -0500
X-Gm-Features: AWEUYZn5XFGNVQ2jVLz76ezUbnTDK6U0yAEQAOa-09EYxSSxCjDrSrw3bf3u4Go
Message-ID: <CAJ-ks9=B34qy7HSXg1V9hY_=KpF24A0gr-u+pwk1_mYrUydN5w@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:37=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Feb 21, 2025 at 02:46:07PM -0500, Tamir Duberstein wrote:
> > On Fri, Feb 21, 2025 at 10:19=E2=80=AFAM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> > > > On Fri, Feb 21, 2025 at 9:40=E2=80=AFAM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > Hmm... if you mean:
> > > > >
> > > > > trait HasHrTimer {
> > > > >     unsafe fn start(&self, expires: Ktime) {
> > > > >         ...
> > > > >     }
> > > > > }
> > > > >
> > > > > Then it'll be problematic because the pointer derived from `&self=
`
> > > > > doesn't have write provenance, therefore in a timer callback, the
> > > > > pointer cannot be used for write, which means for example you can=
not
> > > > > convert the pointer back into a `Pin<Box<HasTimer>>`.
> > > > >
> > > > > To answer Tamir's question, pointers are heavily used here becaus=
e we
> > > > > need to preserve the provenance.
> > > >
> > > > Wouldn't the natural implication be that &mut self is needed? Maybe
> > >
> > > For an `Arc<HasTimer>`, you cannot get `&mut self`.
> > >
> > > > you can help me understand why pointers can express a contract that
> > > > references can't?
> > >
> > > I assume you already know what a pointer provenance is?
> > >
> > >         http://doc.rust-lang.org/std/ptr/index.html#provenance
> > >
> > > Passing a pointer (including offset operation on it) preserves the
> > > provenance (determined as derive time), however, deriving a pointer f=
rom
> > > a reference gives the pointer a provenance based on the reference typ=
e.
> > > For example, let's say we have an `Arc<i32>` and a clone:
> > >
> > >         let arc =3D Arc::new(42);
> > >         let clone =3D arc.clone();
> > >
> > > you can obviously do a into_raw() + from_raw() pair:
> > >
> > >         let ptr =3D Arc::into_raw(arc);
> > >         let arc =3D unsafe { Arc::from_raw(arc) };
> > >
> > > however, if you create a reference based on `Arc::into_raw()`, and th=
en
> > > derive a pointer from that, you change the provenance, therefore the
> > > below code would generate UB:
> > >
> > >         // cannot mutably borrow because of clone.
> > >         let ptr =3D unsafe { &*Arc::into_raw(arc) } as *const i32;
> > >
> > >         let arc =3D unsafe { Arc::from_raw(ptr) };
> > >
> > >
> > > (playground code snippet for this example)
> > >
> > >         https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edi=
tion=3D2021&gist=3D15e051db46c3886b29ed02e579562278
> > >
> > > As you already know, the whole thing about pointers/references here i=
s
> > > passing the value to the callback and the callback can "reconstruct" =
the
> > > data, in such a case, reborrowing in the middle of the chain into a
> > > reference is not necessary, and as the above shows, it can be
> > > problematic.
> > >
> > > Hope this could be helpful.
> > >
> > > Regards,
> > > Boqun
> >
> > Thanks for the explanation. I think where I'm still confused is that
> > provenance is to pointers as the type system is to references. In
> > other words, it's not clear to me how using pointers solves the
> > problem of wanting to write through an Arc. Is the idea that the
> > pointer inside the Arc has write provenance, and that by doing pointer
> > offsets instead of going through references we get to break rules
> > about mutability?
>
> Sort of, but we don't actually break any rule here, because pointer are
> supposed to be unsafe to dereference ;-)
>
> Regards,
> Boqun

Doesn't this mean that any holder of Arc<HasHrTimer> can obtain a
pointer to the timer, and interact with it concurrently with other
holders? Isn't this a problem?

