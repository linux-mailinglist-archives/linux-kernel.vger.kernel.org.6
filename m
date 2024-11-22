Return-Path: <linux-kernel+bounces-418704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BD9D6484
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04328161145
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBE1DF985;
	Fri, 22 Nov 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdJb8nn3"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF364A8F;
	Fri, 22 Nov 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303041; cv=none; b=G5rbYtOMPS2W0NsQStYSoPzjPQZ5nWtmfxp0y9bQi/VVMju4iiudz2NNN4Ed0yg5kgALUwVKQrJ2nRRk33vPlelUJsi/43x6ECve21DEPsYzRygpsTVec0uuaDV5Jk2+yIcDvR379KbkJ4gkE8MmSlApwe/DbYxarzKPY3RlG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303041; c=relaxed/simple;
	bh=QNhcd5PqohHJAkYGy+7DoXt8NxXZD0nmlHPGy43myHY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYoWthhHCCYXad7Ce75UODkeKWwv9RDthlt+jkz+x6an3sdUYR/Pm+7HqgbG8TR1TB1rbq6dS4c09CTHh/Y8KBz2HWGp1cl29eO1jFInuiJBiNPlUsaw/70IEM93QpnBQgyRA3pKZdOGiJSKII8C7uujeyaVTCtHmxEfztE/PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdJb8nn3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d4241457b7so14102796d6.2;
        Fri, 22 Nov 2024 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303039; x=1732907839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Epssg2UejcAoGOvobTdJvf0gOa9HRphNulF2J5a7SI=;
        b=ZdJb8nn3e6yswMw/x8K/LhUAeJdu/+aDYEcu2Z8snEVymeuSjj1TE7yq/4RF62iNNK
         nsU2LsI/MhCzu3ygRjbhNm89GFwU9Wfltxger9m/jfmE716fA7W9hBr+GFgrz5SN4F6K
         qlnUd08w2JlbT0coOQGLqVHGyrb+It2FT9Mo+wiFYpSKUyQBwHRKFLidPJDJdXYMNnYz
         uVvhxEsFKq0ZkPv2XGEZ1ZNfnGyx63QS8J+tpFhalSQJianHVb9TymSfk58WcZYERzNU
         lgadlxKtaqJ//w7szQKOYqLfe3xX9NJu0qgg2y23bvZPxGIZ2hSeI6gkUD1kId7KsP1t
         6L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303039; x=1732907839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Epssg2UejcAoGOvobTdJvf0gOa9HRphNulF2J5a7SI=;
        b=ALhXP2wzFtTeVfrkmXQ98k0r1C+b+q5rBik6FASgjhKVrt7v6QkWeKMNYWGAADpumL
         f83tfok/o0m6F2xpemxN+Ao5j5FZiFG6xxYYzFrh7mwoGPMnoq5jYGz679/Sz6sxcApu
         7qfLc/TLhlEobHipxIqIrqSYSmzNSo+n+8k8FnDtYXIZpt0J5f2hykz00ECWbephpOz/
         YVWezpUqhER4N1h3hIoMgL5SMMF+haRRNd/mnCD+VhueuVhL1YAyubIhDTUtbGiA42Uj
         v68Ak+2/K78sshVJgWk6RMZkByHXeSWsDH+h3Qruae5TKmuRQ05cnyPDh1xFWd0iXOoa
         fH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUeNX/3nnM5cY5/smNtfZi5JxHwqxDhco4386ypfoUkKUnpDaquy+yuQYdv29iiW/gGWiaIoUcGM9El8cs=@vger.kernel.org, AJvYcCVuXYT3WjnGTu905rjE9mldSqJL8IrEWgPqLNu2zbRdIptB1TEXm5gmTrT+wUWfvHuY+6sT1E+FrHuOdU9lnOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRN1ZfdTv0WE8wMLpqtD261DX4AQEU8RyaXELKHrLDdStV9+y
	/esosj+W2y4P/bn+i5FhHgPNJFSn6snu3ZnDzSrUVvdGxBrS2cPI
X-Gm-Gg: ASbGncsXuRtaSOrSpuyP71ETZXXkhZGYnYpGPudBnokH/8ard2l7lI/DH8h3sJsGQA3
	pmKBN5xpwlqNDXwM3fkhmhJ3nu1ksB51fXASG60zNiwx6aKq7TEmxB+RAyFnKf0xFedya3Xf0WG
	zqDs7wxUWDqBZToh15zb2IYYS07jJ43RhQSGciFF+RmRlULacP0oVqcw4EPmjJzYoFTIx1gGhRN
	oiCL0RifgvnP630bygi4wIcRwc5fBVX75O1wyYg3FHPnx48RI7scfLMhzyeZnjqcp4ULZBPnQYg
	HK8ph2ryKpLML4vvdzuCqWLhE1+MM1O63KmjcvYK
X-Google-Smtp-Source: AGHT+IEXXmkmiV/IARZzBCM/RUYMbge0XmQ5IKPMwVUZ/euEELlOMiYB0fF0xQSOST8Tf1/a8m2nxg==
X-Received: by 2002:ad4:5aa7:0:b0:6d4:f14:eb99 with SMTP id 6a1803df08f44-6d45137933fmr56465506d6.45.1732303039166;
        Fri, 22 Nov 2024 11:17:19 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b61c88sm13228766d6.121.2024.11.22.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:17:18 -0800 (PST)
Message-ID: <6740d8be.050a0220.30b282.4f2e@mx.google.com>
X-Google-Original-Message-ID: <Z0DYuxG8H6aO4eWM@winterfell.>
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0B142120006D;
	Fri, 22 Nov 2024 14:17:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 22 Nov 2024 14:17:18 -0500
X-ME-Sender: <xms:vdhAZ9mc3Apla49gtI_eyLcQMK65b0sVzr72rGshiJu8w8qBfYpinA>
    <xme:vdhAZ43a2-J7zbnDRKUefWViKX-0rNTwcnGR0vAysgbb961TE4CXnevrGOLsXDkER
    _V08IxwDGK8uUeclA>
X-ME-Received: <xmr:vdhAZzoUU9XyG1hhlNCZsFdXj8SzLlJsFtoQIpGIxKe1XgjJFlbBpNUdBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevueeuteeifeekhedtveelgfevheeuhfduffej
    jeffudeihfevffefleeuffefgeenucffohhmrghinhepmhhmihhfmhhmrdhishenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtohepjhhhuhgssg
    grrhgusehnvhhiughirgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
    ihhonhdrohhrgh
X-ME-Proxy: <xmx:vdhAZ9kk56507uZ5_ZPH0i5iAFPFcoiEMOblPKctoPLB6Y5EvuYmng>
    <xmx:vdhAZ71q1YW_CI1AtZKWiByTUxla-Y6LNk06goZLrRFgoDqtThI57w>
    <xmx:vdhAZ8vc5oYBtt_QTDUk4Ivhss9mxp8YZf2tAV5huXbrgp6sr8qE9g>
    <xmx:vdhAZ_X1a-LEOW_qYPoU--9PNsMTt6s0oT1lKIpkCBI67gXZuHI2xw>
    <xmx:vthAZy2kfqMui_znVSe5nQPDHIpgIp4Tqdw5UqQWAFA6cR1_3q5Sil-J>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 14:17:17 -0500 (EST)
Date: Fri, 22 Nov 2024 11:17:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com>
 <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>

On Fri, Nov 22, 2024 at 07:48:16PM +0100, Alice Ryhl wrote:
> On Fri, Nov 22, 2024 at 7:03 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Nov 22, 2024 at 03:40:33PM +0000, Alice Ryhl wrote:
> > > +/// Represents a [`Task`] obtained from the `current` global.
> > > +///
> > > +/// This type exists to provide more efficient operations that are only valid on the current task.
> > > +/// For example, to retrieve the pid-namespace of a task, you must use rcu protection unless it is
> > > +/// the current task.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// Must be equal to `current` of some thread that is currently running somewhere.
> > > +pub struct CurrentTask(Task);
> > > +
> >
> > I think you need to make `CurrentTask` `!Sync`, right? Otherwise, other
> > threads can access the shared reference of a `CurrentTask` and the ->mm
> > field. I'm thinking if we have a scoped thread/workqueue support in the
> > future:
> >
> >         let task = current!();
> >         Workqueue::scoped(|s| {
> >             s.spawn(|| {
> >                 let mm = task.mm();
> >                 // do something with the mm
> >             });
> >         });
> 
> I don't think this is a problem? As long as a thread exists somewhere
> with `current` being equal to the task, we should be fine?
> 

I think I had a misunderstanding on what you meant by "operations
that are only valid on the current task", you mean these operations can
be run by other threads, but it has to be *on* a task_struct that's
"currently running", right? BTW, you probably want to reword a bit,
because the "current" task may be blocked, so technically it's not
"running".

Basically, the operations that `CurrentTask` have are the methods that
are safe to call (even on a different thread) for the "current" task, as
long as it exists (not dead or exited). In that definition, not being
`Sync` is fine.

But I have to admit I'm a bit worried that people may be confused, and
add new methods that can be only run by the current thread in the
future.

> > > +impl CurrentTask {
> > > +    /// Access the address space of this task.
> > > +    ///
> > > +    /// To increment the refcount of the referenced `mm`, you can use `ARef::from`.
> > > +    #[inline]
> > > +    pub fn mm(&self) -> Option<&MmWithUser> {
> >
> > Hmm... similar issue, `MmWithUser` is `Sync`.
> 
> What is the problem with that?
> 

It should be no problem under your definition of `CurrentTask`.

Regards,
Boqun

> > > +        let mm = unsafe { (*self.as_ptr()).mm };
> > > +
> > > +        if mm.is_null() {
> > > +            None
> > > +        } else {
> > > +            // SAFETY: If `current->mm` is non-null, then it references a valid mm with a non-zero
> > > +            // value of `mm_users`. The returned `&MmWithUser` borrows from `CurrentTask`, so the
> > > +            // `&MmWithUser` cannot escape the current task, meaning `mm_users` can't reach zero
> > > +            // while the reference is still live.
> >
> > Regards,
> > Boqun
> >
> > > +            Some(unsafe { MmWithUser::from_raw(mm) })
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
> > >  unsafe impl crate::types::AlwaysRefCounted for Task {
> > >      fn inc_ref(&self) {
> > >
> > > --
> > > 2.47.0.371.ga323438b13-goog
> > >

