Return-Path: <linux-kernel+bounces-378644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9629AD399
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172461C2278B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DB1D04BB;
	Wed, 23 Oct 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nASM56O/"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E61ABEB7;
	Wed, 23 Oct 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706835; cv=none; b=oDM5F0VVrl027keNZHdra69WElNjqrzI5zn/4bp7q0bwut54SaEMWdbLXdz2HKlaUziKFrplPAlMQMLPqce77CK7KSSR32vBqdm5r0GHf7eDJi+RFyh/MWWBFvH905bNnmTRCcJUVDDrYipoQ5Ho5pOKUg+RRzQumzhpzTJuTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706835; c=relaxed/simple;
	bh=tqmojDpKvljjbhg2zjwLCjuHUGdPGlAsse9W9QlPFb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd4ijznPSxqi8KgYDMwQOlV2wlHA8zxAp8J7JGRfqL2swgfWdlcRl/akItNwTs1Vr7SqYthUHOIeGk2WQ+rOeN4DTCyVshx4QTLbfifcVRwV6fBCTxyfgvEd9CjeSEdEa8LF9ymISruvbiKFnikrEp5N4xOTf3Ej1W3dw82odeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nASM56O/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso735776d6.1;
        Wed, 23 Oct 2024 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729706832; x=1730311632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiBjXGH4g1k1OSDOsy8qY2INBvd/rJ7dZoNyBo84T4w=;
        b=nASM56O/loarUlIhoIryDZhe2qb1zBLDHGlOqGUb5Eo4wdsZOKs9/ltTJfLaJxWhtK
         U/Ffbru+YEK0Zu/iYT2Qb8HIjlkgBXpXovSFinDs2djr0RNQ5SFBoWov8YhLBdjcF6/U
         ZG/hotCr51oac1c9VKRpHX+NMbG/1//dwRSDQzSErgVlX9A8FnsO/z/SQAsdjhdbIpei
         cRKGsO1NUf4c+bhEjboBmXmfp5jZrabNZogQUKU0fGB7PMLtBbbjTDppw3vSkqAn0Ujc
         xf7bffI0uCUIJ94OxtBLg8fan8BQc5LV6FYbm/uB+jzbiBiFF2eEF4mLagEiWIHOD/Nh
         QVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706832; x=1730311632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiBjXGH4g1k1OSDOsy8qY2INBvd/rJ7dZoNyBo84T4w=;
        b=ItgbshYbSUY1OZicdEyKSYepBwbp24szwjA+UFqCUrEgjlToVMQZUDdsQBgfVXnoUU
         zRnIPn9rLVEMKQSCTT5qnkeMU8Q+/4nt8xF1SjCjmmWNFaxRj3kxYBDoLreykDgwvXs0
         iyi0AWmTN24VCsmz5C/ufOp8xoZeDhSz/h2pYemVr4OaLjuV2UHMTaER9htUxFhaD8vU
         XuYsW/QITou6c0/A8LPTa38nM76Yrcg9CjtsFFljUqEEQ1RIFglyKvFv20PXMKfF6yZd
         lWPg7pv6TiDn2+J1cHKHjTzWURlvI/pn8RwSNIcVcSmj/oAfyEaaN2fpmDL2eGtjZs3I
         nwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWirQlJHcyHGdJVtUPtp3OfiNRZ1BMBHXUikkGQwjCpmFeLJTGFe9bPIuJp0bbq5LGR//6P5P7eceM73uE=@vger.kernel.org, AJvYcCXb78fUrreiv+LxYuzjJhd14IeYXq8MyLcpYCBd4sTCQZzEsCbTmNI+pQ7kUtlbS7rfY7VkPWXA9E/LlfidZIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM45CEXm0ltsn+gWsFafkIzMgpFi6h0tucvOV6KMKqcX7KFguH
	LAVOrfdN6rAAZcX42vRU6vYbm072F8HNf03pFYcKG3W5PonpSjSk
X-Google-Smtp-Source: AGHT+IHmoIk6I77uz+NXLrEtq3qVVCTmMpLFLgc4eh0diQ+EpRPIcklAmHhZKI/TUkRE+qr/2E+AhQ==
X-Received: by 2002:a05:6214:2b82:b0:6cb:f345:8bcf with SMTP id 6a1803df08f44-6ce34271b85mr49210536d6.46.1729706832511;
        Wed, 23 Oct 2024 11:07:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099cff4sm41177566d6.100.2024.10.23.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:07:11 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5584F1200043;
	Wed, 23 Oct 2024 14:07:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Oct 2024 14:07:11 -0400
X-ME-Sender: <xms:TzsZZxEoVVOgruSGO39DWGIrEVuv995AfaF5qm0UEVXKR61KVcYi_Q>
    <xme:TzsZZ2Vx4_KTam4e3lhq1tBbRD3i_3UdITCECMfh4Virbfu9Sw24yLuhg5yQCPAgi
    Bf5g1_RJ6n8OTOqNA>
X-ME-Received: <xmr:TzsZZzJeNNkDeyiXzf_0-6b6l9zKPh5CJbjii8Gbz9J_YNkkkCeGtaE4qgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grihhrlhhivggusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhguhgvlhdrohhj
    vggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunh
    esfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TzsZZ3Fz6P5YvsULJfNBmjnmuu0cu6ul5o4ee2z9YKRD756qsOig-w>
    <xmx:TzsZZ3VxIAcZX4wjOSLyHBBrJXXANFt3ekgFRJR88k0xcgxxBQo2Ng>
    <xmx:TzsZZyMJgr2xHeNOorPhnY-sRckUZ1iKv1N8LjBu2MgBuiSkSmmOqQ>
    <xmx:TzsZZ23ndL1HK1X7DEZtJJ-cTn9LkTlIA7-2epCz81FTSGRgswRJqw>
    <xmx:TzsZZ0VE35mysHYUiHvxhiu75iWctFJ_6PAMDQy4jrWspAceBt-byknc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 14:07:10 -0400 (EDT)
Date: Wed, 23 Oct 2024 11:07:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
Message-ID: <Zxk7Tf-jhSse51AS@Boquns-Mac-mini.local>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
 <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com>
 <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
 <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com>

On Wed, Oct 23, 2024 at 07:52:23PM +0200, Alice Ryhl wrote:
[...]
> > > > > +impl<T: Ownable> Owned<T> {
> > > > > +    /// Creates a new smart pointer that owns `T`.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    /// `ptr` needs to be a valid pointer, and it should be the unique owner to the object,
> > > > > +    /// in other words, no other entity should free the underlying data.
> > > > > +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> > > >
> > > > Please rename this function to from_raw to match the name used by
> > > > other similar functions.
> > > >
> > > > Also, I don't love this wording. We don't really want to guarantee
> > > > that it is unique. For example, pages have one primary owner, but
> > > > there can be others who also have refcounts to the page, so it's not
> > > > really unique. I think you just want to say that `ptr` must point at a
> >
> > But then when `Owned<Page>` dropped, it will call __free_pages() which
> > invalidate any other existing users. Do you assume that the users will
> > use pointers anyway, so it's their unsafe responsiblity to guarantee
> > that they don't use an invalid pointer?
> >
> > Also I assume you mean the others have refcounts to the page *before* an
> > `Owned<Page>` is created, right? Because if we really have a use case
> > where we want to have multiple users of a page after `Owned<Page>`
> > created, we should better provide a `Owned<Page>` to `ARef<Page>`
> > function.
> 
> The __free_pages function just decrements a refcount. If there are
> other references to it, it's not actually freed.
> 

Then why don't we use page_put() there? ;-) And instead of
`Owned<Page>`, we can wrap the kernel::page as `ARef<Page>`, no?

Regards,
Boqun

> Alice

