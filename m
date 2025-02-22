Return-Path: <linux-kernel+bounces-526949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C276A40583
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537A742493B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D61C3BEE;
	Sat, 22 Feb 2025 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzICuXMK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387CF4FA;
	Sat, 22 Feb 2025 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740199295; cv=none; b=F6dD4XQVjLHOrLusAMa1z5ir5LV/8PKMaaqL+3sH0YgOwHVZSts7sg+OSZK67s2bFhAkrdzNtwvhRcGEZN6bAujyUVoLd/v5INiv4Ce8YZM1rLgUi5LraR8V2mfTyJ7cB1PpExlHYZNFYYsjZvRlaHwsx2He87/4P8/nroiau9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740199295; c=relaxed/simple;
	bh=NqBooKhfP2Hs6LC1WJ9lErKGhiE75wgYJ8L+C3G6hE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS/NEamPqwLK0HT8DPnrWCKoyup2v1xlp60B7kccCiuWCKZrjXTPmJ9eD4S+wYRnN98/0p1C4PZpqZ9ddtKTFOEvQ1b8qE3t/0h7YQ6VfxoVpj+zUSbrWe9ZL9gIzS3q4cSJs/Dv+fkOimPs63O1TTPAl8WFbAkGE4h5szGGsvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzICuXMK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471f16f4b73so24577851cf.1;
        Fri, 21 Feb 2025 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740199292; x=1740804092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yn/9M5nLVSZrAybtybZFW9IIx9yHxqUlEFE/V/8EIhU=;
        b=EzICuXMKtQHJ4tQJ3owEJbF3ogQnMFfR6Akunl8SuOa2QXVfp93XSSf7x96m3DWHB4
         E4S9s6NAjQbiGaVT8WeI8YGXKKUV17FBAfpXtKKjsX3npdXB0GFizLoDr+u2MjvpufFH
         XLMwXIvG/W9Hf7kPpycfMHbfnLX+7L0Y1922tNQJoS3KnJXie3OfXhe8aFLtPh3pe2ut
         P7RKGNwio/Tglergmi9aAdFVLDFB6bXG7tlby6SrdxPR73BD2tn0kEJXNJdx9Ng6atlg
         89+rq170gP+QQZILrnzJmOQaN8dAnYKK85EUtltaETKwlDQnPMUB3ekvbQ7P9tYylIYt
         wUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740199292; x=1740804092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn/9M5nLVSZrAybtybZFW9IIx9yHxqUlEFE/V/8EIhU=;
        b=fJPuLvFYP9FVCq8eEPXiIcBQBM5ZuW7d3zxO/o1IiXmScboktiGbX/lrv/Lk0gP0D7
         bi3lodl1u4PJ4FQPoMQwuZNW35xY5LQNrO8qHC7Vj6hlE4peDd8/spf2Az5wJSU4q+NU
         5sdJRZa7xq637AKyPbZ/JT0yCVFsF9EWrCIuaLviEJ4UbagWDvU6VKnBxV9XSWlP4KX8
         wCctpAhdtUAAwW7zgIPxj0fUn37+49tvmuZSJEuNMjknIgOJVDK53+PRDvyExYgQlPUR
         0iuK4fcMgckBhKf7tGRH9/kWP5bDBqg0itLW7vz9gsRk5MvUWrsbFDbyWMT96dV4HlX+
         7cMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZmJMVRJL3Q6XNmVGrrEvfiQzRx4geMaX63IHcx0wUf7DKC13tBPgYzGhijp65Q+cag00UP0xYnJy+RTk=@vger.kernel.org, AJvYcCVx3nbxi5gvgVqaMqQ3uzXNKf0IxvnIqth3/kyJuhp2p0ZDujphsexxAVQrRmzZ5xG5r/FSbTJfPLQGpvn4/6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KHm5ycrfpr78IyoNCnCVPm8bNxYtFXXzjtMi3IQv09XV3PQI
	+a66cmTjU8XceLS+u7T91kE+0ZgZyM3gA44/G6KvyUbSbsXMzHVU
X-Gm-Gg: ASbGnctMr2GLs4rcnLbtenvqd+7xeq02DByhEci3i4SAGoHM8oxx4cI6lqoV39MDRk/
	qhJ+3YGkWKcqjq2LzV20kvZkEJB52CwZ0HD4C5tRyG1tjg37cxUZ7FfOjsC1/Ogoxtjehm+zNUv
	Df4pe74UOxRq0/QeidoTLhk+yJFm48NwbaX+OpUzP19SPSAoYMW0GcwVDbyY/hqLlZgSXa2usGt
	z+bHkj6KvoQeRIqlzhUEdc4IMx2DcY2WQArewCNowAdqN3MlUTY3dy5fOiiQEPtAMiGrEgtShUJ
	bqm0mqys8PgpCTCo7o3foT5gZHBIXYRQ4G4jHO7Lfeureuu3PXwS5/O7VsLAWYtn9VtkEZBxgEr
	XQkRLtWlBNFsAUYX5
X-Google-Smtp-Source: AGHT+IFsCjt1ZL3nmaOyl/ZTBUCtWP4t2JQN39H1dl6/L2+NmxzzU5P5QGuTsPRg8Ckk0AzyR6nqog==
X-Received: by 2002:ac8:7d92:0:b0:471:cd16:8c73 with SMTP id d75a77b69052e-472228d3d68mr70775081cf.22.1740199292583;
        Fri, 21 Feb 2025 20:41:32 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0eba93dsm66327411cf.80.2025.02.21.20.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 20:41:32 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6795F1200043;
	Fri, 21 Feb 2025 23:41:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Fri, 21 Feb 2025 23:41:31 -0500
X-ME-Sender: <xms:e1W5Z9JoGqUmP348ONgtjlMY239EEFdUkqsPr6ZXLJcWrUJ1LaM4ug>
    <xme:e1W5Z5Jp-Qu3FeSWZcsYLXwzm4Da31LtBMUiCibGNdz1UNgl-qZX2XgjoiTLSIROP
    UjZWiStTQlTZm5nnw>
X-ME-Received: <xmr:e1W5Z1t3AxRZrVR29Vcm564gu0WvcpL8NpgZ1rHHm-11rKuOQU3kUqOqBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghmiigrmhgrhhhfohhoiieslhhinhhugidrmhhitg
    hrohhsohhfthdrtghomhdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhirghnghhshhgrnhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    hushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnh
    horhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    th
X-ME-Proxy: <xmx:e1W5Z-b_fNnq7UKjfMfoWCJrLFQknChYvh54JTY4mhlHIFyVIYvFCg>
    <xmx:e1W5Z0ZdbYCEYNFR0Yk_JYE6R4wvnzpUAn7nU-3hZnZBY9Xd64gwQw>
    <xmx:e1W5ZyA3zCFOy4qvgADW8xMv48Z0et1FEUSX7Yah9jITfycnizYZeA>
    <xmx:e1W5ZybKl-EbiQ5squ4Szs0MOMdSnggcqVHydddFkvXzMzv6pO1Gsw>
    <xmx:e1W5ZwoD-MT8SOrGGYLZSNL9LcLcK1UQNziklNiEZbxTF8u6zuW35OCy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 23:41:30 -0500 (EST)
Date: Fri, 21 Feb 2025 20:41:29 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
Message-ID: <Z7lVeWFX-8uQJaJC@Mac.home>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
 <Z7lP5VA374-TuNZz@kernel.org>
 <Z7lUcq3PycSSHiXx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7lUcq3PycSSHiXx@kernel.org>

On Sat, Feb 22, 2025 at 06:37:06AM +0200, Jarkko Sakkinen wrote:
> On Sat, Feb 22, 2025 at 06:17:41AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 21, 2025 at 11:45:38PM +0100, Miguel Ojeda wrote:
> > > On Fri, Feb 21, 2025 at 11:36 PM Hamza Mahfooz
> > > <hamzamahfooz@linux.microsoft.com> wrote:
> > > >
> > > > We provide these methods because it lets us access these queues from
> > > > Rust without using unsafe code.
> > > >
> > > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > 
> > > Cc'ing WORKQUEUE -- thanks!
> > 
> > Not meaning to complain but it by practical has no commit message.
> 
> oops, sorry, "... but by practical means it ..."
> 
> Anyway I hope my message was received ;-) Leaves me wonder tho why
> this was queued because it apparently is not even part of a patch

What do you mean by "queued"? IIUC, Miguel was just copying workqueue
maintainers, since they should be in the review process.

Thanks for your review in another email anyway!

Regards,
Boqun

> set. "zero callers" should never be merged to mainline...
> 
> If however such patch is merged, the commit message should probably
> address this exceptional condition.
> 
> R, Jarkko

