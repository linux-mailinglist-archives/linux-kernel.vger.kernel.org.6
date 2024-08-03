Return-Path: <linux-kernel+bounces-273529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77C946A46
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD72817C0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DF1547C5;
	Sat,  3 Aug 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy4gNvRO"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F281ABEA7;
	Sat,  3 Aug 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697949; cv=none; b=FJ9LjDBoqQGA0PMTkxWDW3XY8h6imkj1h9vtQyfpRRGWIYuJVQ1SYlknz0AIbVAAA2IiGcChgBB/cDSYktI+4553ZWERluC2dVT7lkjd6mPJ26BuSgDVvvty7WpcdwUqbUnHg7lzcwX1/oP0xHsl1DGnZTED6TbEhZ7XDyyspuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697949; c=relaxed/simple;
	bh=k0Ci8gQKSIXl0KJR+PJ6hyf0P8lLZ/yjqOSUBLNg3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi9A1bV2a6jpzcph3jlWSinU8OZE0pVvhEYMKsum25iU+VQqtTXIcTnCCW2VCtvJDpzJTKg1ijC1YTjdE8VIEhOizwPtJwyjuKqfLodaitKLi9RCS3RTmZ67aLUXIug3U5kB0Y+ds30SKFd55V8EPaYKugliQRnq2mHUfWx4UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy4gNvRO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093b53f315so3345157a34.2;
        Sat, 03 Aug 2024 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722697947; x=1723302747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6p7LXKiFinUHQj2MlhaEhsGgPbhERUBFRsspksPS0U=;
        b=cy4gNvROfeMaQXfQR/OYZ6Nk2kvBfoIWIACmb/kAmQyJPkOHVlZH4a+AyazKn/sJVd
         pKwbJ2ZRWrQHT8ak/Qjb1WhFpmF519YuVn6jIVCyXilZah7AjJ0nuqB9DBGAWFOwzkrH
         O/eKcX2sLhEO7XUhFCsBxLRtYIK36/GH/CaGhxSJ+HqljUWsd/mqTYJ8V074CIQDiwhF
         RVl2h5OQbO3duQQ3bMPWYwot/55XcAVzT/Muy6/YfAOrg9nA/yLBB0Zy/SNhSkecyiM2
         SwpgvBSRIWsesCymWdAGb908bsfeiWMoWmaMQLk3j1EG8AqE+ZLuBmBoccrkq904RpRl
         lAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722697947; x=1723302747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6p7LXKiFinUHQj2MlhaEhsGgPbhERUBFRsspksPS0U=;
        b=Itw9AbVz7lW31XJue8pBrfDohhcgv4mTQQuv+0us/lzKp+TsJrVdw6U6gzQufNf5hl
         ZPXOOy2++tGrPuy9Zm0GB+uk09npa5mzct6cUF5rIhiavE6lQa+o4+MKQwHzZQ1mdd9l
         fJF0ChELDatguJGVwHMRoJvyo1j66mT8AZBuuw/L6r8WBdywBVTaU4d8yz0KuDMwhfa8
         yakQi1QT5mu5wGoDT66gGECeQ4roklzGCLokA/J0IoX0F23s4dBPz9CL8R63pVopYXLc
         l2/DLaZTBbKuQpVqNhyAa8t6Ilwbm+2HnYcjnd5rOf1EMkTL+eWi8kugd2m07DHuFmVk
         GW/A==
X-Forwarded-Encrypted: i=1; AJvYcCXcUEO6kEzf19EVH/dA8NYerUrXxRtsH+D+/pd/rVY0QjT/sayG/vJULWB4mURFZcV07TiThc0MuEKp8BJtefesd9PhOjJM6p5sU65mHzsmEuIKfzYthpOvZ+3D2GHgK2yg0VRIOfBFkWn2V50=
X-Gm-Message-State: AOJu0YzAnEBVPn1Ugy5pAK9hi73wMicAI9oHlu8ZOlyAXnpwHTr5LXqq
	AKDU1RgUQLFeaRh6RucZJ9uoFRqd1V2oOIa1wBOqZNxqhLZJ3Sda
X-Google-Smtp-Source: AGHT+IHYZM3SekC4cIOWuLRFCD2STSUE2X5WSJwIBB8KAxpWWpjwLs8neY95Fz47y270uyCaCZ0fEQ==
X-Received: by 2002:a05:6830:4981:b0:709:44dc:dde7 with SMTP id 46e09a7af769-709b32190c7mr10723220a34.9.1722697946716;
        Sat, 03 Aug 2024 08:12:26 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b7b2asm17377236d6.62.2024.08.03.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:12:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 91FC91200068;
	Sat,  3 Aug 2024 11:12:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 03 Aug 2024 11:12:25 -0400
X-ME-Sender: <xms:2UiuZhL0Wfl4cmimpm8sOZ39AmjYS-74Yplfsh4OjPUVcpY3gGHH6w>
    <xme:2UiuZtIzI-GYwvROpaQ5Sn3kd1erltOUD2iRMEKlZ-uAMFoI2PsB8V9m520wk4vsR
    xNd9L8PtF0l5gUmtQ>
X-ME-Received: <xmr:2UiuZpsUhFXGgCBjSXxwixBQCdEhtM9E56WO-5vr7kE2J8paWAwNn4O9JPyW8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedvgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:2UiuZiZ0h8E8VJnos5Vs4-d2CErqJntNxQ3Vhvu993YmsLLWlXDYlg>
    <xmx:2UiuZoZcUly8QmWpsavLoL418gR4R6SakbUVIdO23NdVAjcKZ2sNFQ>
    <xmx:2UiuZmBloE7QwiQ_2Fbyy14ty_7d5VUlLKRYfYf3AD2EfyeqTfS4Pg>
    <xmx:2UiuZmb7fLxR_xh-V8cUfheXOGqqRSawYLbINfbPQ0ZiZO9KgZJOhA>
    <xmx:2UiuZkp7zclIGa-2x1F6tpGX9_JeOzKUYQ-CIAZNbEA46nrnkZeZ1QMJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Aug 2024 11:12:25 -0400 (EDT)
Date: Sat, 3 Aug 2024 08:11:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <Zq5Io6tKgczUYcf3@boqun-archlinux>
References: <20240803141639.3237686-1-benno.lossin@proton.me>
 <241c994e-28fb-448c-aa4f-b96154988bf6@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241c994e-28fb-448c-aa4f-b96154988bf6@proton.me>

On Sat, Aug 03, 2024 at 02:23:42PM +0000, Benno Lossin wrote:
> On 03.08.24 16:16, Benno Lossin wrote:
> > @@ -53,4 +69,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
> >          // zero-sized types, we use `NonNull::dangling`.
> >          Ok(unsafe { Box::from_raw(ptr) })
> >      }
> > +
> > +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
> > +        let ptr = Box::into_raw(this);
> > +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> > +        unsafe { ptr::drop_in_place(ptr) };
> > +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> 
> I just noticed that I missed another comment from Boqun here. Got
> confused with the two mails. I would replace the comment above with
> 
>     // CAST: `T` and `MaybeUninit<T>` have the same layout.
>     let ptr = ptr.cast::<MaybeUninit<T>>();
>     // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
>     // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
> 
> Let me know if you want another version.

Looks good to me, please do send an updated version.

Although, I would expect the "CAST" comment already explains that if
`ptr` is a valid, then the casting result is also valid, i.e. we put
"CAST" comments on the casting that matters to safety. But that seems
not matching what you use CAST for?

Regards,
Boqun

> 
> ---
> Cheers,
> Benno
> 
> > +        unsafe { Box::from_raw(ptr.cast()) }
> > +    }
> >  }
> > --
> > 2.45.2
> > 
> > 
> > 
> 

