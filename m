Return-Path: <linux-kernel+bounces-389442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 979AF9B6D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0337BB221E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060631D1741;
	Wed, 30 Oct 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz3hDPxz"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286381D1519;
	Wed, 30 Oct 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318095; cv=none; b=r8a7ltyuwZv8/8z+jGrrzqxEgg2iZ+cye8qI1EGuPV86BWQpbcuYZ0P2cT/dlTXrZtdZ5PC5NLRZqlWFkM2yBBytuYy7zQUBCPL2Sf2YQ9nTlgSiuYNK4N3YnXNXJP0kdjtpDvhN5b2nJaBSaeIdcP6Ttg86yTEp9uxHY9ax15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318095; c=relaxed/simple;
	bh=TX5jjEZYH/AHLu12p9cmZp92LePwDLAIj+7SZG6AfxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4iLupeLDrJiG3EGhJx9yFzDik/ZcQX/K0B0udZtc5N7zEXltR6umHhJRA9W9iROmBhj8Y2b2MCILKAErhAaCmX/0V/zca8nINLU9A2mqgZtEsTKvf31mK0aSTnyx9buC0PMiKvOztjGNLc7SwedEgfHPW0v1eaISZLv9BN9FX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz3hDPxz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5f533e1c2so180160b6e.3;
        Wed, 30 Oct 2024 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730318092; x=1730922892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZMROESuAZHyTT3TsJNnT5nv5SAHlB2CRWMUBAg3hOs=;
        b=fz3hDPxzvw0KHOk16XZmJKfxlX99hjq2794yUiwtIGZo9+sunDQAHefLmVHUY2mwI3
         JnwQiml5XsnjK33k07zqIr8Ve0xt+duIGf2wOahCWWf2GbOt0W9Ps2Ts/Fqkiix4VBMc
         xunmnMDVxVoywVH6vva6WsFxD6mMG88XDScbqNem4qmLSQDw86YyrjgEUxm1JSS5cFo0
         F3HqulU0PWwsOrvvL743axsm3sr5fWiPVQsDzeGzNiZuKLIIRu7RikBGd/scmvLJ0I9t
         0YfoenwOoZf78Hz8rn2PBmpkMYeF2CHvblMorndWu4l9WyP8H6O/NEmmMJtWuu2Oh22B
         qG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318092; x=1730922892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZMROESuAZHyTT3TsJNnT5nv5SAHlB2CRWMUBAg3hOs=;
        b=n0rpZFyZbzRIH4TaotcRr8jVvnldoGG4UzuNH/0hgdQ7HuGT+doblVi2Um0Apuf79f
         XxBGrMYG7le13CJutMVh937QWO8wAmFTb3c5HXa+bA2V3eX3FH2NSWQS0YDPWKGe8P2O
         AecxiqnpdkNOEPhcmBtrvHKjzb5R1JLm81/r+614oR7zmvxtaGU8DqSORdG3LUJSsJ2S
         61MbHb4UpyKKJbnmRtcWYEgzTFtrNxmeg4olME7Obfa7GmMadTuS+xzLSRZfPM3/dVCR
         xgktePRFDIp6MAXBx5A2QSQ8MHVpnzKTXKeDyNXU57PXxEsiOi3Ngz00f0kZMntKihrp
         KuVA==
X-Forwarded-Encrypted: i=1; AJvYcCUcf+AFvwaQlUzsIxG1UxcSZ/qMuyuQLx3XQekjj3tRSUcxu2b1vRhRuK4maihyOMBbQIzaxbcbw8B5JQg=@vger.kernel.org, AJvYcCUhO77Zj2iYxg2lRJ5AEc02yW4HTVqjRxhZ8bMi6VH5XVxsvCjd+nvjDojZAvBDXGYV25hmbn6Kgctr2svKfEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadLjJ6f72qoodjec2hKXAtrYGvjQLtjbOFHKbVtci/3gzlK76
	g0OC+7l/aGZWPPSnxaSCyzq4qX+xdAOCFbfJLhprP253rNnBP/Qf
X-Google-Smtp-Source: AGHT+IH3yrgdLR4Rxz56lJ3AYS9N0EOKfj9Y4cfnjZS3gzXqX62og5hZH1Hq0ncxkxz6h8epc48zvQ==
X-Received: by 2002:a05:6808:22a5:b0:3e6:769:b042 with SMTP id 5614622812f47-3e638482ea3mr15112723b6e.29.1730318092091;
        Wed, 30 Oct 2024 12:54:52 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2c7b2sm54791956d6.122.2024.10.30.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:54:51 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F3E741200043;
	Wed, 30 Oct 2024 15:54:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 15:54:51 -0400
X-ME-Sender: <xms:Co8iZ-AZ8iGN_1DA0lUVcoAP0wxw53AexJd_q0ki71unObEc3ShwbQ>
    <xme:Co8iZ4hgyll4CBWMSZ3dKRVxSwcCvzDHLyQCUscWtGhSZTSrjcxhsq_6yGevwg1FR
    CTFqtU2bTVnQkP92g>
X-ME-Received: <xmr:Co8iZxmipfIylBNMOzwwgNHSDa6TAgz5-pifzyaLsUJPJmrthi94wcEvGKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnheptddvveffgfduveduiedvheehvdegjeeukedv
    tdevieeljefhgeeftdetveduhfegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpud
    dvqdhrtgdvrddqlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggt
    lhgvrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvsggrsghkrgesshhushgvrd
    gtiidprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhmpdhrtghpthht
    oheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrkh
    hpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvghg
    khhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:Co8iZ8zmF4K83TRWZdmn7jg-lYsULGeLPsRDV_s_ASDUB4uvriWGtw>
    <xmx:Co8iZzRR3MW8rYqI9iBD23okDPJvYGRZO-CX5zTT3zavMMCKdm1-FQ>
    <xmx:Co8iZ3bnmaRNhMyUZ3bm0GnmIdgOdWsQsW5cFY4-T0FNyMl7hXYlbQ>
    <xmx:Co8iZ8Qi4YKIT0tv02ReVUhap_6SY_nQhT9aj72q17ZwdqtAqd1D2g>
    <xmx:Co8iZ1CyeAziDh9NSam_gOrb2L3Q-uQigE--w9Qn2tJr_1f8cSCLv93_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 15:54:50 -0400 (EDT)
Date: Wed, 30 Oct 2024 12:54:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 0/2] Rust support for mm_struct, vm_area_struct, and
 mmap for miscdevice
Message-ID: <ZyKPCesNWFNCLTmx@Boquns-Mac-mini.local>
References: <20241014-vma-v7-0-01e32f861195@google.com>
 <92da645a-3224-493a-a687-1738cae1ec07@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92da645a-3224-493a-a687-1738cae1ec07@lucifer.local>

Hi Lorenzo,

On Wed, Oct 30, 2024 at 06:52:34PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 14, 2024 at 09:29:50AM +0000, Alice Ryhl wrote:
> > The first patch introduces mm_struct and vm_area_struct abstractions,
> > and the second patch uses them for miscdevice.
> >
> > This updates the vm_area_struct support to use the approach we discussed
> > at LPC where there are three different types depending on the kind of
> > access you have to the vma. You either have read access, write access,
> > or you are initializing it. Each case allows a larger set of operations
> > on the vma.
> >
> > The first patch in this series depends on vfs.rust.file for
> > NotThreadSafe. The second patch in this series depends on char-misc-next
> > for the base miscdevice implementation.
> >
> 
> Hi Alice,
> 
> Just to be clear - I am very keen in seeing this land, and will take a look
> a this from a VMA and locking perspective.
> 

Thanks!

> I've been tied up with other work which has delayed me, but am
> simultaneously working on documenting VMA locking (with various tricky ins
> and outs around 'implicit' rules) which directly feeds into ensuring the
> rust abstraction correctly matches expectation on the locking side of
> things.
> 
> So I'd ideally like to get this doc update done first before reviewing, to
> ensure we have good clarity on locking, but I think perhaps a good way is
> for me to try to do both in conjunction with one another (will cc- you on
> docs series when I send it!)
> 

Please Cc me as well, thanks!

Regards,
Boqun

> In any case - I will absolutely give this my attention as soon as I am able
> to.
> 
> Relatedly - we've encountered issues recently in relation to locking
> subtleties so this is _highly_ pertinent and equally _highly_ motivating
> for having compiler help on this + a programmatic representation in rust.
> 
> I know Willy is in full support of this effort too, we are all keen to see
> things move forward.
> 
> Thank you for doing this! :)
> 
> Best, Lorenzo
> 
> > ---
> > Changes in v7:
> > - Make the mmap read/write lock guards respect strict owner semantics.
> > - Link to v6: https://lore.kernel.org/r/20241010-vma-v6-0-d89039b6f573@google.com
> >
> > Changes in v6:
> > - Introduce VmArea{Ref,Mut,New} distinction.
> > - Add a second patchset for miscdevice.
> > - Rebase on char-misc-next (currently on v6.12-rc2).
> > - Link to v5: https://lore.kernel.org/r/20240806-vma-v5-1-04018f05de2b@google.com
> >
> > Changes in v5:
> > - Rename VmArea::from_raw_vma to from_raw.
> > - Use Pin for mutable VmArea references.
> > - Go through `ARef::from` in `mmgrab_current`.
> > - Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@google.com
> >
> > Changes in v4:
> > - Pull out ARef::into_raw into a separate patch.
> > - Update invariants and struct documentation.
> > - Rename from_raw_mm to from_raw.
> > - Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com
> >
> > Changes in v3:
> > - Reorder entries in mm.rs.
> > - Use ARef for mmput_async helper.
> > - Clarify that VmArea requires you to hold the mmap read or write lock.
> > - Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com
> >
> > Changes in v2:
> > - mm.rs is redesigned from scratch making use of AsRef
> > - Add notes about whether destructors may sleep
> > - Rename Area to VmArea
> > - Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
> >
> > ---
> > Alice Ryhl (2):
> >       rust: mm: add abstractions for mm_struct and vm_area_struct
> >       rust: miscdevice: add mmap support
> >
> >  rust/helpers/helpers.c    |   1 +
> >  rust/helpers/mm.c         |  55 +++++++
> >  rust/kernel/lib.rs        |   1 +
> >  rust/kernel/miscdevice.rs |  24 ++++
> >  rust/kernel/mm.rs         | 357 ++++++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/mm/virt.rs    | 264 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 702 insertions(+)
> > ---
> > base-commit: 2d424646119f28780f3963811025c05ea848b85f
> > change-id: 20240723-vma-f80119f9fb35
> >
> > Best regards,
> > --
> > Alice Ryhl <aliceryhl@google.com>
> >

