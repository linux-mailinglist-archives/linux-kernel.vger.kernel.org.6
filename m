Return-Path: <linux-kernel+bounces-526764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C19A402C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606C57A5B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359720766D;
	Fri, 21 Feb 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR/pe0DD"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADDA944;
	Fri, 21 Feb 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177428; cv=none; b=Tzr7sngQ1tkZBXOY7xAeLvu257IiwhXgzzPLtnIrxgeA8ZF5YkNaLcTj89syJ/lgiLiesovFS7twNTvlckPbYSJi/AeJLtQIEUmdhngMZ6L2/GvwGne2m/9kKeQ7CZGEq978J3yB0E88zXn+noTJDEUVNMICpzamIkNQOaU18pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177428; c=relaxed/simple;
	bh=YNyaI8ga7sXUWI7KkKk9c5nOabe5qQpBRbMEh7NZPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQCAHiZ3raI42gePwsPB/xLMbHjptY8JjdWKA/MhGN2bCeLTmpAIAAuwefUZEpSx0DTyetRstagdoAWDaLyyqkpYX4cpMGhda7Ajkg1tid/3JT+u9n/BfNKz/lY8cjFVrR8AccBZNybbLuAro/twCoRnAFjR5QxpXK6+WSC47DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR/pe0DD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471eb0e3536so30539691cf.3;
        Fri, 21 Feb 2025 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740177426; x=1740782226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c8W9f+UL0WIeYi0GmSGNSniskpnZbaRNi+ygozy1zME=;
        b=iR/pe0DDz9CMVwZQqPWF7rqw3lFCwogzMUYMFHNNoOUogVmWguqDSGYMFtMiivt5NC
         Q87C2qfBdbqOWZeT2ewRw21YD0xVPFPT6TT88gLi+tawUiLW4d+Z88J2Q4w5myqNPIhv
         7QpvSeUIFsfdFHc5HdRqBuW9jgmQuIiksaRkf4cx3ABY6AwIrqqBddhsQLEbtrmMWKe+
         PpuAan+8/oMrZk1pXbeTeIEpNu5YrBqHYCy6JRYhXfCkjZFdA/qom79ljfoDt0DKoENE
         0SMAeO6oLm5J37pCIHkdmcTviYHRImc4VLCFNa+qWMTvuRfBxpJGKkPhwwX5z+AkplJp
         E8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177426; x=1740782226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8W9f+UL0WIeYi0GmSGNSniskpnZbaRNi+ygozy1zME=;
        b=VoXMlKJivXqKSJJrbbeywlCYgfaahd6qK4zqSB4CLoGuRE8rx/H3nHXo2auoBsFMxy
         BWtUdrBZOohcBcfr9DPA8b1M9s+K4jP+UYwEU+ShqSWM94DZj3/0fvvZV5x/VcYDP3w/
         cfsfPAz792az1C1fzVvOII0YuOMlHY72d0Di8Yt7965BDqqI7eCvVdud2OrDhs2WHnQE
         gPVKqKKkaz8w3d3nJRtvefp5p26NC4PniJnV0gd6PZIzDzPztJc7IkzW9IM7TQd4JH+Q
         laH/KVbj1hzJgOlZLwt58xHsxDO7rBBc8/GnaZv5goqnn2B4ZppH6S//pSAtr9Ey+0WH
         /4hA==
X-Forwarded-Encrypted: i=1; AJvYcCVt0k2cgYupOKb1wBHdunTIHQG8ahsl2ToOEk9TdV3mNfyMVIqgP0/S6lvu2e/IRsS+lGdRknfLcW+V2JB1bMY=@vger.kernel.org, AJvYcCWu2SXAxyKkHTHIZuTnmA76ZlwnfIlX/Tv7xP79C6uWo8zqECAKmdos1xSnCVlN4R5GymMjs74NQJckFQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaUWkv0LtSqGcXowfdC/kgsPkqvfJjaYgnOpchHFvhi8Art66
	aW+d83+psH4DfYH2qZ9/lPgs/meIjlk1AytWjml33tdGsGQLeLva
X-Gm-Gg: ASbGncteKkSS+ixX8p0lABjMcU9xG17W8aed6nl69HTX5Nu8zSxsum9SymB2STW3QbQ
	+TdT8mCMY4EDSfuShaIoMmPEkhrt7AcRetYmSVtWc3MR028iSmUSZ5c4bqiu/AeKGAlyPKNKnrK
	bZ7z2uSjyLXUbMgAkGdqimCMgAvFOjV2FaO1oybpSzgXLKxftXS+0u7zaKNJovaypHw/EE8UTlu
	YNbpITXHbLhX9sSmfKQYvG3CPzFnKWShfj8ULSWpb+f5cvgG7vbm8naTUT4ZEF8XJPOzQWgqZc5
	IUcWRF8QC31zUUmNPJbHHirj+M9UgeyoiBW9QTVCDeToFj/ktQJsypzfbvQLjCPuEKTTLyZeowi
	D7SF6yh1VVnAB5KlE
X-Google-Smtp-Source: AGHT+IEJES7wDhNfgYYkK7IW3nv0P+IdnXMUK1HAp00M840YXuohOIPpxChr0R/trFkzOA+A6B8W8A==
X-Received: by 2002:a05:622a:1301:b0:472:1275:6967 with SMTP id d75a77b69052e-472228cf1bamr63146961cf.21.1740177425905;
        Fri, 21 Feb 2025 14:37:05 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f5d00e54sm57491921cf.21.2025.02.21.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:37:05 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E15781200043;
	Fri, 21 Feb 2025 17:37:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Feb 2025 17:37:04 -0500
X-ME-Sender: <xms:EAC5Z72J34of_tYrs_EW-2zgXa3n0mKzTUWfXuY4DoCo0ogk8HNRmg>
    <xme:EAC5Z6GPHx9D6H8EuTXhNsZIGgc6BgOOkmExFlTXs1vsaA3G-D6o6MR4KFfShIuOW
    lbRNiSuyj_XGL6N1g>
X-ME-Received: <xmr:EAC5Z74lR5mk8wu8BZ5D5heoveXiw1h0RerQwN4mLfNvzUnJSdP2WV_3rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejuddvgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:EAC5Zw0yPwPCsStCGXSEkClgLVZC4dEdHYzdyT0pSxEm1NUlKJOk1A>
    <xmx:EAC5Z-HBH8-tw_-JTd-PtmRZCbnmWUnx2u3UC3PWAgWsTjIWm17UuA>
    <xmx:EAC5Zx9PCBM15bP-Jq2_M0442xAMKIa_y28vaCgab6Vig-MYvh1RDQ>
    <xmx:EAC5Z7kb0dY1x25ucWi9kx_eF30n8FTpwWUtzBXeb1Oky89YRZ9jug>
    <xmx:EAC5Z6HQLVve1cEbb8vA17p76Qc5uw0Rie9JbWjhND6qOfVCzSMoj1OM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 17:37:04 -0500 (EST)
Date: Fri, 21 Feb 2025 14:37:03 -0800
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
Message-ID: <Z7kAD_8OQdVLSO4l@Mac.home>
References: <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org>
 <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org>
 <87cyfbe89x.fsf@kernel.org>
 <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
 <Z7iZevQkYVGDoeTa@Mac.home>
 <CAJ-ks9=f45WJKFwB4J0_a4j_Urf=yR_wukmfhRwRqtczDXfSPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=f45WJKFwB4J0_a4j_Urf=yR_wukmfhRwRqtczDXfSPg@mail.gmail.com>

On Fri, Feb 21, 2025 at 02:46:07PM -0500, Tamir Duberstein wrote:
> On Fri, Feb 21, 2025 at 10:19 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> > > On Fri, Feb 21, 2025 at 9:40 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > Hmm... if you mean:
> > > >
> > > > trait HasHrTimer {
> > > >     unsafe fn start(&self, expires: Ktime) {
> > > >         ...
> > > >     }
> > > > }
> > > >
> > > > Then it'll be problematic because the pointer derived from `&self`
> > > > doesn't have write provenance, therefore in a timer callback, the
> > > > pointer cannot be used for write, which means for example you cannot
> > > > convert the pointer back into a `Pin<Box<HasTimer>>`.
> > > >
> > > > To answer Tamir's question, pointers are heavily used here because we
> > > > need to preserve the provenance.
> > >
> > > Wouldn't the natural implication be that &mut self is needed? Maybe
> >
> > For an `Arc<HasTimer>`, you cannot get `&mut self`.
> >
> > > you can help me understand why pointers can express a contract that
> > > references can't?
> >
> > I assume you already know what a pointer provenance is?
> >
> >         http://doc.rust-lang.org/std/ptr/index.html#provenance
> >
> > Passing a pointer (including offset operation on it) preserves the
> > provenance (determined as derive time), however, deriving a pointer from
> > a reference gives the pointer a provenance based on the reference type.
> > For example, let's say we have an `Arc<i32>` and a clone:
> >
> >         let arc = Arc::new(42);
> >         let clone = arc.clone();
> >
> > you can obviously do a into_raw() + from_raw() pair:
> >
> >         let ptr = Arc::into_raw(arc);
> >         let arc = unsafe { Arc::from_raw(arc) };
> >
> > however, if you create a reference based on `Arc::into_raw()`, and then
> > derive a pointer from that, you change the provenance, therefore the
> > below code would generate UB:
> >
> >         // cannot mutably borrow because of clone.
> >         let ptr = unsafe { &*Arc::into_raw(arc) } as *const i32;
> >
> >         let arc = unsafe { Arc::from_raw(ptr) };
> >
> >
> > (playground code snippet for this example)
> >
> >         https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=15e051db46c3886b29ed02e579562278
> >
> > As you already know, the whole thing about pointers/references here is
> > passing the value to the callback and the callback can "reconstruct" the
> > data, in such a case, reborrowing in the middle of the chain into a
> > reference is not necessary, and as the above shows, it can be
> > problematic.
> >
> > Hope this could be helpful.
> >
> > Regards,
> > Boqun
> 
> Thanks for the explanation. I think where I'm still confused is that
> provenance is to pointers as the type system is to references. In
> other words, it's not clear to me how using pointers solves the
> problem of wanting to write through an Arc. Is the idea that the
> pointer inside the Arc has write provenance, and that by doing pointer
> offsets instead of going through references we get to break rules
> about mutability?

Sort of, but we don't actually break any rule here, because pointer are
supposed to be unsafe to dereference ;-)

Regards,
Boqun

