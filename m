Return-Path: <linux-kernel+bounces-308496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D29965DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B801C22F38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C717B50F;
	Fri, 30 Aug 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="k4m0ZwhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QtHPKusE"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A5137745;
	Fri, 30 Aug 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012080; cv=none; b=GO9FNRgXM911C/QI4YLmdCS7d5t4sTmNbOwb7wTYWOfWHyBky8RyuHbIIxCl5j1HbQ6Fh3lkZj/EKDd2YgNq1dhCq0J68LjaqXRSbEgZCxdV3TMiMcuu4IGTNWfNUKotZstkPxZyhkrey2r0rc1tfb0HW/ZKiKt67E0y/mjz4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012080; c=relaxed/simple;
	bh=u/fzcu4fvb/d01tBibQlnUdzbyR7Wm9CI7uLIMDeA58=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DLVjpcGGxCXqT8rd6nYbVwisGAceSF1OUtO7VBarwnN8fvyAtQCOgwgf8ANHdG73El6F75SOXIHSTvHJeg3DX6xVcJA5G3urLa6Jh9XlFHczinhtYa7i4FpZ0+t53hA5t3766RiNcYb+vE/N2oCBpNu6v8xWwoAcGMTvmu4DZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=k4m0ZwhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QtHPKusE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3B9DF114026A;
	Fri, 30 Aug 2024 06:01:16 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 30 Aug 2024 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725012076;
	 x=1725098476; bh=u/fzcu4fvb/d01tBibQlnUdzbyR7Wm9CI7uLIMDeA58=; b=
	k4m0ZwhRJIP6izsyuPmzdrGYlMeuwOjCI9A3S5kvnUD1Rfjv85pRcfAoNe3UEf0g
	7zw60XkxAj//7jRvnuqRrnfzB0KUioExcoeEcegknYB/AllpSOE16K1FPY7g8KIl
	3fHHx6eTsC9dP/Xa7A7cV6ZwKZeh0cD6J4lH2u4ObRvp32PMstCeU+9BsTO455l9
	5bf9SoxGmqC2iMQcyc/s1w1i6ebQf6CeTF6J1QYkwSuVxREVAD/Mepdcc5pmYzeQ
	lThO4ySw8FOW1Y39Lktio/iHRXfw+CZtGCAHPVef5xQbJ5dPaee6LdVXMwS0iYe4
	H2IaB2Zou84KXPMog2AnSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725012076; x=
	1725098476; bh=u/fzcu4fvb/d01tBibQlnUdzbyR7Wm9CI7uLIMDeA58=; b=Q
	tHPKusED/+74euepXXvmHX37hopzTymvrWQ/Lq0/604ZBPw5tsSIjycmeQu1vFJT
	2SBs687lGw7Ck5bgaDR2EXcV3lDAzQxVflVeHDZG5XwvaNTURIHVQ7xIU866wlaf
	19yg5Y6RAwCHigr8s/eiSJHlzmJF4AVyjx8lwNuXu/sVjI2rGVMDgE1pugOk/oMd
	NMPJRQeW2iJyd7YSQIRssyk/dylaPQTYXjn1NlAOFeEvL88XFHIS//ughCGWvraR
	WPbXdnCLwbrPBtj2Pds3v2S5cIWokIoNiKbofHmDWmf7iuGMwvm7qXs6ACIU9gTw
	bsE7uGOc7Eh9Fred6Sl7w==
X-ME-Sender: <xms:a5jRZqnx3XMqwNoR9LYnETviTdxzir79OuUn4WQyFHyR0fAbdOQT3A>
    <xme:a5jRZh3XX1pe8C5T8bVNMR1rNkAkUthpxaDhfbjbHT-ntRMxLklffK2L-TyixcRcK
    6bpJdM64nqZZYhF1Uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvg
    gruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepgfeftddvgefgtdejvdefvddu
    tefgvdeiuefgudffkeelhfekveegieehtddvueegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghu
    pdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hrvhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepmhgrtghosegrnhgurhhoihgu
    rdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnughrohhiugdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhgvgidrghgrhihn
    ohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghmlh
    hlrghmrghssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:a5jRZor9LgK3aGwJVG7mQ3J2JJQkKR6cceRMU_RNAvvmRda-uFjfDw>
    <xmx:a5jRZulb59GiORYEGYy4iVm1sVt2NnbTTj74Fo7ZlQVjX_ZIrsS_Vw>
    <xmx:a5jRZo08JUEuEIx1XkFsXRN41fh9Vwlcsr_ZYUBhWubwq_sJpvCZrA>
    <xmx:a5jRZlsSJMqkYsiy2j0tTD7HBZXedsGC5Hfsz4IMtpHh0g3o1QCA4w>
    <xmx:bJjRZmkUIlkyznh7uMdYoW7jUGeK8m5Io6Hm3UIiL9jg8J9VJlzsIhhn>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 118BA18A006B; Fri, 30 Aug 2024 06:01:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Aug 2024 12:00:53 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Matt Gilbride" <mattgilbride@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Christian Brauner" <brauner@kernel.org>, "Rob Landley" <rob@landley.net>,
 "Davidlohr Bueso" <dave@stgolabs.net>,
 "Michel Lespinasse" <michel@lespinasse.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <274ba6bb-8027-4972-9ae2-db46844d528f@app.fastmail.com>
In-Reply-To: 
 <CAH5fLgjXDOGbmtkhfiytAGVtT7njuiHQsqVcf0hMQtbyeUY-fg@mail.gmail.com>
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
 <5a7e828e-b003-4062-9469-53f090defc03@app.fastmail.com>
 <CAH5fLgjXDOGbmtkhfiytAGVtT7njuiHQsqVcf0hMQtbyeUY-fg@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Red-black tree abstraction needed by Rust Binder
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Aug 26, 2024, at 11:56 AM, Alice Ryhl wrote:
> On Mon, Aug 26, 2024 at 11:15=E2=80=AFAM David Rheinsberg <david@reada=
head.eu> wrote:
>> On Thu, Aug 22, 2024, at 6:37 PM, Matt Gilbride wrote:
>> > "This RFC uses the kernel's red-black tree for key/value mappings, =
but we
>> > are aware that the red-black tree is deprecated. We did this to mak=
e the
>> > performance comparison more fair, since C binder also uses rbtree f=
or
>> > this. We intend to replace these with XArrays instead. That said, we
>> > don't think that XArray is a good fit for the range allocator, and =
we
>> > propose to continue using the red-black tree for the range allocato=
r."
>>
>> (I might have missed this in previous versions of the patchset, so le=
t me know if this has been answered before.)
>>
>> 1) Have you had any chance to compare this (performance wise) to the =
intrusive version used by the C Binder implementation? I assume the allo=
cations are negligible, but tree-traversal should be significantly faste=
r with intrusive trees when keys are next to the rb-node (e.g., binder r=
ange allocator, or ref/node lookup based on u64). With the allocating st=
yle, you likely double the number of cache-lines you load during a trave=
rsal, don't you?
>> We have been trying hard to keep the intrusive style, but never reall=
y measured the performance. So in case you do have numbers / experience,=
 I would love to hear about it.
>
> The performance numbers are okay, see the linked RFC for numbers. But
> it's a known area of improvement.

The measurements in that RFC where about overall Binder performance, tha=
t's why I asked whether the abstractions where measured without the Bind=
er code. But fair enough, seems like it did not affect overall module pe=
rformance.

>> 2) Similar to 1), what is the reason to avoid the intrusive style? Is=
 this just to simplify the API and keep it close to what rust-std does? =
Is the intention of this RFC to move towards an allocating style, or is =
work on the intrusive abstraction still welcome? I guess for compatibili=
ty to C-code, we still need the intrusive helpers, and likely for a long=
 time.
>
> Ultimately, the reason is that the red/black tree is one of the very
> first abstractions that were written in the Rust for Linux project. We
> had not yet figured out how to correctly do intrusive structures at
> the time, and I have not taken the time to rewrite it with intrusive
> support. That said, we do know how to do it now: see the workqueue [1]
> and the linked list [2] for examples of how to do intrusive data
> structures.

Right, fair enough!

>> 3) I know that Matthew has spent significant time converting users to=
 xarray, yet I have not seen any real deprecation of rbtrees. Especially=
 when keys are user controlled or sparse, I do not see how xarray is a s=
uitable replacement. Did I miss some discussions there? Or are you just =
referring to the general recommendation to consider xarray?
>
> Ah yes, the xarray doesn't work for every case. But I believe we can
> replace the red/black tree with a hash table instead in those cases.
> There are cases where xarray is a good fit, e.g. when the key is a
> thread id. Also for the u32 ids of remote nodes, as their values are
> controlled by the kernel. But for locally owned nodes, we would want a
> hash table instead.
>
> There's only really one case where I don't see any replacement to the
> red/black tree, and that is the range allocator. In C Binder, it uses
> a complex data structure where the nodes are intertwined between two
> rb trees and a linked list. Rust Binder also uses red/black trees
> here.

We need an ordered structure with user-controlled keys, so yeah, hashmap=
s and xarray are out (at least without secondary structures to help), th=
at's why we always used rb-tree, and it worked fine.

Thanks for the answers!
David

