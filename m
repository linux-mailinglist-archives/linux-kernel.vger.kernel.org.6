Return-Path: <linux-kernel+bounces-525989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF7A3F843
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73B2170BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45285210F6D;
	Fri, 21 Feb 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e77GwtQa"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51420E02D;
	Fri, 21 Feb 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151168; cv=none; b=bQlUyJwcuNZEtlo5x6Ag+0sgAjtuIwxxIKejNxAOvApd2gCR2nAkPkMsqFHZtg1WMEkBxReJPTJqHkSmUXJV8o6vx967Qmgs60ZRRBsJHf031hJJLbqfTnC2o5lR4qTjVQxZabOQ/1zeFW03HkG5qqo5CecdWurcqbOGr2L56kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151168; c=relaxed/simple;
	bh=BwWNh/IecNX9JFyVGN2psCZ+7JadvarkvSm40AfuIxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9jT9zPolHiwLhu64reRa9ohI/venR84vT+D7DlBLWBQFDaC8Si54WiW1qOIJxpHYtiirCNqsyhGpTZyJS/hYI/r5P7u008dXC0g90VpOQnwzlzqwGGvymRISDr7O3dFuEWsplSBNz3Va/XaOIfwIy97TzJLxgopNGMpXvwvvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e77GwtQa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fd4bf03cbso32778641cf.0;
        Fri, 21 Feb 2025 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740151166; x=1740755966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AoKDxtX2qotsoWCNkR7SNDxUxZjLqJ7D2owgBuwny4c=;
        b=e77GwtQaIZwHWgGEgLlLcDKWKR/ZGxZ+kqcE4WOf2Td2yUDhgWeUnpnE8NfT1Um2qg
         67/5c7hvY2t+mB3xHS2JVf54A0Jqds0BimhMdo07YBllq77aHmuJQDFBFNZXLh9F0Cel
         jvRVchPBbHHhDaklDAh7lrBCr/NWOPIuYzo1SMTq8R0iw19eVGix1EBxqjzhYCz9xODY
         2rma2EiHEjNL0DIryyEHn/rO4gg+b+WlCTbPh4WV5Ai7uXkMkPO0MirTqZqoH7H/kcDb
         bTOkqdYDnDPDt/H1nkB0/F7iA3ngOQfummROe5IBeqgVa/MtSmbBaJWwRYpkuftHkL4M
         v5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151166; x=1740755966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoKDxtX2qotsoWCNkR7SNDxUxZjLqJ7D2owgBuwny4c=;
        b=olwjtmBJHzC+JFLK32G8ga2nKWxQkPXl3rMne0KhmEVB4yl/7HomdLLHxloww18qOS
         QkDGha9JcRl113925i+KRcNoyxc5TQovzR81wykAmVHPs4SdSfhZtLF/3/Y9N+3xN7rq
         kQim1PZuzP2y+5+yq5xAdkA08ObNNweSfhOEWRXRpuOcTh7dALGjXfLdMzzPbkjoY9RH
         il6qvokfcKSO5Orb+bxSIvKgzccPKqKyLzGbLHH0oSqHRehFpqYtSUkvAaIRfyiv8p8m
         j19hISQeSJBJlvi/y+DpQA1SsJUUP/VaTPwC9D4NUlZAsFSKThf4+6dQmp8Q6acrIUVr
         kC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2AJuk6XHc7AWpIoqnAr2ovsKq7IxF0Nt2uhZpPFNhJGxlke9+QkaIaH/vXw0JMDY9/+etn/DCzwcdssc=@vger.kernel.org, AJvYcCXARnmzR7ACPqjjBCNgbfkzAxrLciQ4wZn+oruHh3ulW9/qAYMcgVEwPv/8ekBcAMPBkLk2tf2EjBEOXy199cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFH47Wr9iCuvqrzh5eDtPxmKjA9e7wfTgNJOCYFjNOi2HaAUI
	ZAUMU6xZ34vid0upa7wyhbwKahSg994v5I0PYkKX1qvqWRaDTHat
X-Gm-Gg: ASbGncvcZyvfvtFTAByWOYN8+3Zx80Lhpg0LHAE/garPDf2prQ5A6Ni/vGsPb0KAfJK
	r1ORzOvpYtYQhgcRlxyjvKU/e17KkpjMOubtFb172nIboxG07stSE22pzU40HzNxpYJEQUcnIUH
	2mGOEYCisI24crWJEV5C1wBe2+54C6c6WdpMwhVs16+3oddfxBysUFnFfyTxRxE49YymWc+N8kN
	aM1x3eBmg6uyuXE7qB4z3Id5hcRHmURwWRvZEI2TluWYijESkhNksAWbBsFIo1IUhwz4J2gQmgJ
	zT97/69e19mON1bWvs+nZPwWZ38vNlNoIl0NJxuOT34oprYxTnO+wvVORLO4vX/o2iNl8rdZWj8
	RVyR7JYGW358kPxgL
X-Google-Smtp-Source: AGHT+IEZNN3PhT07b7NTUPOkcvFDy43Xfh1+Lp1XINHGo7qQ3IJVDBdNknaSE0Ul35nWb4wLcWlYaQ==
X-Received: by 2002:a05:622a:13c7:b0:471:f3f2:62eb with SMTP id d75a77b69052e-472228ce17amr50474561cf.19.1740151165703;
        Fri, 21 Feb 2025 07:19:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f3df2698sm55149991cf.23.2025.02.21.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:19:25 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB06E1200043;
	Fri, 21 Feb 2025 10:19:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 21 Feb 2025 10:19:24 -0500
X-ME-Sender: <xms:fJm4Zw87Xppn9wag1Tz5ur3isqq1MfuLL5EKi16tDU_pg6gMY0Td8Q>
    <xme:fJm4Z4u7-B6IvmwsX-V1VR_NYFc5fignltwob2B7k1-OybwJsSINI65NYJ-cVpoFv
    ilKxpPZ2PWftuSuXg>
X-ME-Received: <xmr:fJm4Z2AU6w3zE07LKMWNcrzS6eykAilQRVodbg414f4JLQkrbwTyYYEXPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdefhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fJm4ZwdZyW5HgRWYymn0Wgl_sAPIX-MyidrgrjHEXEq4IlQDdkKnVg>
    <xmx:fJm4Z1P2bnKQRWY45F-_BFBPMQaqFog5WMYqngTxkT7rECqSoLqGfQ>
    <xmx:fJm4Z6kP-PlFo5nUY6obF8RQSwXldRBC92GcwavSX1IH75mRx-NFrQ>
    <xmx:fJm4Z3sSGr06gDwRqGcDD418tphivroJoxCAw6KoBkZSI-V9ozZY-A>
    <xmx:fJm4ZzstyaxU6MpxiMfmRKmibR5XWA_9K38GjtqY1dUruXcUy0LTau5U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 10:19:23 -0500 (EST)
Date: Fri, 21 Feb 2025 07:19:22 -0800
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
Message-ID: <Z7iZevQkYVGDoeTa@Mac.home>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org>
 <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org>
 <87cyfbe89x.fsf@kernel.org>
 <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>

On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> On Fri, Feb 21, 2025 at 9:40 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hmm... if you mean:
> >
> > trait HasHrTimer {
> >     unsafe fn start(&self, expires: Ktime) {
> >         ...
> >     }
> > }
> >
> > Then it'll be problematic because the pointer derived from `&self`
> > doesn't have write provenance, therefore in a timer callback, the
> > pointer cannot be used for write, which means for example you cannot
> > convert the pointer back into a `Pin<Box<HasTimer>>`.
> >
> > To answer Tamir's question, pointers are heavily used here because we
> > need to preserve the provenance.
> 
> Wouldn't the natural implication be that &mut self is needed? Maybe

For an `Arc<HasTimer>`, you cannot get `&mut self`.

> you can help me understand why pointers can express a contract that
> references can't?

I assume you already know what a pointer provenance is?

	http://doc.rust-lang.org/std/ptr/index.html#provenance

Passing a pointer (including offset operation on it) preserves the
provenance (determined as derive time), however, deriving a pointer from
a reference gives the pointer a provenance based on the reference type.
For example, let's say we have an `Arc<i32>` and a clone:

	let arc = Arc::new(42);
	let clone = arc.clone();

you can obviously do a into_raw() + from_raw() pair:

	let ptr = Arc::into_raw(arc);
	let arc = unsafe { Arc::from_raw(arc) };

however, if you create a reference based on `Arc::into_raw()`, and then
derive a pointer from that, you change the provenance, therefore the
below code would generate UB:

	// cannot mutably borrow because of clone.
	let ptr = unsafe { &*Arc::into_raw(arc) } as *const i32;
    
	let arc = unsafe { Arc::from_raw(ptr) };


(playground code snippet for this example)

	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=15e051db46c3886b29ed02e579562278

As you already know, the whole thing about pointers/references here is
passing the value to the callback and the callback can "reconstruct" the
data, in such a case, reborrowing in the middle of the chain into a
reference is not necessary, and as the above shows, it can be
problematic.

Hope this could be helpful.

Regards,
Boqun

