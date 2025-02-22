Return-Path: <linux-kernel+bounces-526876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35514A404BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6562E7AACE9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475215689A;
	Sat, 22 Feb 2025 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldKK5Q+W"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57342F37;
	Sat, 22 Feb 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740188289; cv=none; b=Fc1IojGY/OeCYsr4ScRRWugIAZ/UnVUkbO2uzH5PFyRgpWf9464l6wxvDh5SABhZG49Glxnf1iWHCUVnUDOWgEZT7SnhzERwtLwpPSGhe4fmXkJlSjOjZ05Uu91uUywv8Is677FXmezrqXbx1br6wfJTdWlqHQ8de0p37UONV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740188289; c=relaxed/simple;
	bh=hmui1yxRQ6W6n1JB7PN/LQ8/Rx/sfXWbunp03dUpnQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+Sfc0uzrUHvOle/gb9tKzmhUtEtzE51TxrxiigSjrurx0zmnC/gc3TOtuCnxrzhlzTUhux0SDyCPEhK2vkySZ+eddtTdM3vcmgeUiw8zzC8uuR1YI8obW0+nSeDnKbRz3QGlmmjyOn9O21j4oqQGcOt2QhUcyHzMor8/XBblQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldKK5Q+W; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e65baef2edso22803426d6.2;
        Fri, 21 Feb 2025 17:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740188286; x=1740793086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ik/0QwaV8gl053hrL/fAZIJgXQlhrOxQuBEmwEbsqA=;
        b=ldKK5Q+WSGq5i9z/r7WYX1h5fqYqRqelx1U3TRpfXOsnGWOJN+ojj9OiSFuo96J9eC
         agTAFaGaFnBR49wbJr74MS3weGFH8yos3hf4+lKDePerkSV0rbT41yBRXuPLK27CPXuf
         7fPWKu9jD1tfavMYtv8lKgqBUhBTJ/cjf7AfCWyDsKh2Zw6HrRE71tsWMPjQ8JMgAjAo
         mOi+NeYNwE3se/hQ/kwaiS/XhbQZNHmJkeKAB/d/hGq5IGZWlLcCKlX1seO/pHRmLqYw
         pzTBL1Gfwqp8y1CU2MqaKtBmDJUQ70WWxqyXd9ol6ibidg6o5Kr1bFzMjR3mIU5MR5BQ
         13wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740188287; x=1740793087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ik/0QwaV8gl053hrL/fAZIJgXQlhrOxQuBEmwEbsqA=;
        b=wH83t/qxy5tQdXkOI8jB0CBO9vyUht83y47MIR7jozqi005B+odQlMFOiCNXbyQwuW
         29Dz8EXbN1NWJs4vHS+iiS93yu3SZfwkTAa6qjBZ3IfGaui78ldTZvVxYd8FKtswx6p0
         XVu7Q21D60we1R/AZd+DKvE1r9SkHKKX2CgQrXMtMJv/Pea0H8KjoQjsC13l5F3k7UF4
         TqWF4pFRKcxaLlo4+caD7mhTDlynqN5FebMjd9ULFiq15LaJ0tE1qF0LFkd0Au6hkbyC
         1lCgSGUbvkaBWSI345L2lyurnQfkmtNTMvVQ/DqHMU1QUsJxW3lF+nwvkD9J/VsG6Ghf
         r9jg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSfzT0VqrcNclDFJ3cKb6KwK3kLXFJxsLCjCErN2SIc+RNjfq7ANR4A6ZGEbcPsUgdBgaDtz9b2C6/KtdHgs=@vger.kernel.org, AJvYcCWMDReG9ZzbXy1l1Kzxt3DLIy8F1GxngUzwl6Nx4hbx9WAHOJe/jwOpnPEYtEPtFo3Pu0ct2CAz78SWIpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgF2r1DUIsVs9tVcYDGBypXn/RXqhhQMQrpY7UUCIBYofXCie
	cp/pa4Wdu7uSqyHSn1BjJhmA4WxyAbe26pWQbQG46Y/TCg3MjhK0
X-Gm-Gg: ASbGncsdxqLLZ75Yh94cg5WQ4pbPUEExAnHR4hxNP2L0hmv+w5J5k6T0OOFq1AJ0hzJ
	9Ah+AqFb52XPBUAygmTW+DzYlD8eXwZ4lCNsAcnDjDyZibTdL0aFn9Hm126Z2nRRZEvG2kKJH1L
	sLpctsOv9BQMYETtJShb1cx6kPiIN4q4Wyr4dilDdwbpmFuAVRoC1WOXppxMDJOgqNjfLYln6v4
	kNHx9KnG8lgxUEegMl7u2ZVH9psqL/WhcUuRKvTe+LpnBq0E4JnaCVhwzyMhRNr5yECY6YVLBUV
	4rdNzQo/lmcqbF4e1ZnmNV/akGeNlSnesFYA9Jjj4ARMRxBNZpk1uwDTSX9IPIl8tzYOp/n+RoS
	L4dXajfhzgC3ekYT1
X-Google-Smtp-Source: AGHT+IGuST9qWY6Kjfa8w3cnJ9DTkZFa+UE1mCXbzPpwXMuuDcoNmDwb5f6tuAMQc2tKJ3RZhKWeZQ==
X-Received: by 2002:ad4:5aed:0:b0:6d4:1f86:b1e6 with SMTP id 6a1803df08f44-6e6ae82e503mr71971036d6.22.1740188286588;
        Fri, 21 Feb 2025 17:38:06 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31fdsm104697466d6.69.2025.02.21.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 17:38:06 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71C0D1200068;
	Fri, 21 Feb 2025 20:38:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 21 Feb 2025 20:38:05 -0500
X-ME-Sender: <xms:fSq5Z0_mlPNKwrN5stbQSbuMjeOOguTeJZMXYyyTroazk5Yh55jyKw>
    <xme:fSq5Z8slG5goeeXQ3DMM13YiOCGHeqqdESrbVe0Zcz77OyBC4EdKI3eriRnApExmi
    Zg48CIhjKvPGVxNZA>
X-ME-Received: <xmr:fSq5Z6DRBwC3JvOkYan04IWr2x_4eeDr8Rx6xMTE4hiIhSP_8-fKxgra3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeiheefkefgvdefteejjedukefhieevleef
    feevheehfeffhfekhfetveffvefhgfenucffohhmrghinheprhhushhtqdhlrghnghdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghkrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:fSq5Z0dtDU6ouXxiBN_SORW7w_6bZXjvf8NNogBgwdIZsYUYAS6zaQ>
    <xmx:fSq5Z5MVndfJzpb907eYB7hJA2fRMuZb82ywRce2rPSfDgfG23-RCg>
    <xmx:fSq5Z-ndrs1Z9RvRYqEFx2PF4asYJdTmh-QtHguQq0GP40ZaPvrJjw>
    <xmx:fSq5Z7tjPcJkWLx-qZN5nFYJf-ejsTVYbKxL9wIVEGO5HUIRIgv9PQ>
    <xmx:fSq5Z3tF0v5h20qD8mTwQ9tTAm2Uwl2kBlhbaMo9pL7TNhp6ZJhxdrj->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 20:38:04 -0500 (EST)
Date: Fri, 21 Feb 2025 17:38:03 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <Z7kqe-poip_qjTok@Mac.home>
References: <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org>
 <87cyfbe89x.fsf@kernel.org>
 <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
 <Z7iZevQkYVGDoeTa@Mac.home>
 <CAJ-ks9=f45WJKFwB4J0_a4j_Urf=yR_wukmfhRwRqtczDXfSPg@mail.gmail.com>
 <Z7kAD_8OQdVLSO4l@Mac.home>
 <CAJ-ks9=B34qy7HSXg1V9hY_=KpF24A0gr-u+pwk1_mYrUydN5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=B34qy7HSXg1V9hY_=KpF24A0gr-u+pwk1_mYrUydN5w@mail.gmail.com>

On Fri, Feb 21, 2025 at 08:08:09PM -0500, Tamir Duberstein wrote:
> On Fri, Feb 21, 2025 at 5:37 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 02:46:07PM -0500, Tamir Duberstein wrote:
> > > On Fri, Feb 21, 2025 at 10:19 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> > > > > On Fri, Feb 21, 2025 at 9:40 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > >
> > > > > > Hmm... if you mean:
> > > > > >
> > > > > > trait HasHrTimer {
> > > > > >     unsafe fn start(&self, expires: Ktime) {
> > > > > >         ...
> > > > > >     }
> > > > > > }
> > > > > >
> > > > > > Then it'll be problematic because the pointer derived from `&self`
> > > > > > doesn't have write provenance, therefore in a timer callback, the
> > > > > > pointer cannot be used for write, which means for example you cannot
> > > > > > convert the pointer back into a `Pin<Box<HasTimer>>`.
> > > > > >
> > > > > > To answer Tamir's question, pointers are heavily used here because we
> > > > > > need to preserve the provenance.
> > > > >
> > > > > Wouldn't the natural implication be that &mut self is needed? Maybe
> > > >
> > > > For an `Arc<HasTimer>`, you cannot get `&mut self`.
> > > >
> > > > > you can help me understand why pointers can express a contract that
> > > > > references can't?
> > > >
> > > > I assume you already know what a pointer provenance is?
> > > >
> > > >         http://doc.rust-lang.org/std/ptr/index.html#provenance
> > > >
> > > > Passing a pointer (including offset operation on it) preserves the
> > > > provenance (determined as derive time), however, deriving a pointer from
> > > > a reference gives the pointer a provenance based on the reference type.
> > > > For example, let's say we have an `Arc<i32>` and a clone:
> > > >
> > > >         let arc = Arc::new(42);
> > > >         let clone = arc.clone();
> > > >
> > > > you can obviously do a into_raw() + from_raw() pair:
> > > >
> > > >         let ptr = Arc::into_raw(arc);
> > > >         let arc = unsafe { Arc::from_raw(arc) };
> > > >
> > > > however, if you create a reference based on `Arc::into_raw()`, and then
> > > > derive a pointer from that, you change the provenance, therefore the
> > > > below code would generate UB:
> > > >
> > > >         // cannot mutably borrow because of clone.
> > > >         let ptr = unsafe { &*Arc::into_raw(arc) } as *const i32;
> > > >
> > > >         let arc = unsafe { Arc::from_raw(ptr) };
> > > >
> > > >
> > > > (playground code snippet for this example)
> > > >
> > > >         https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=15e051db46c3886b29ed02e579562278
> > > >
> > > > As you already know, the whole thing about pointers/references here is
> > > > passing the value to the callback and the callback can "reconstruct" the
> > > > data, in such a case, reborrowing in the middle of the chain into a
> > > > reference is not necessary, and as the above shows, it can be
> > > > problematic.
> > > >
> > > > Hope this could be helpful.
> > > >
> > > > Regards,
> > > > Boqun
> > >
> > > Thanks for the explanation. I think where I'm still confused is that
> > > provenance is to pointers as the type system is to references. In
> > > other words, it's not clear to me how using pointers solves the
> > > problem of wanting to write through an Arc. Is the idea that the
> > > pointer inside the Arc has write provenance, and that by doing pointer
> > > offsets instead of going through references we get to break rules
> > > about mutability?
> >
> > Sort of, but we don't actually break any rule here, because pointer are
> > supposed to be unsafe to dereference ;-)
> >
> > Regards,
> > Boqun
> 
> Doesn't this mean that any holder of Arc<HasHrTimer> can obtain a
> pointer to the timer, and interact with it concurrently with other
> holders? Isn't this a problem?

If so, do you have a case in mind? I.e. could you show two concurrent
user of `Arc<HasHrTimer>` end up racing with each other? Note that
hrtimer function on C side usually provides some locking mechanism
therefore concurrently calling won't cause a problem.

Regards,
Boqun

