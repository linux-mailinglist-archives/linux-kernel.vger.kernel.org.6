Return-Path: <linux-kernel+bounces-417386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D1C9D534E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C63EB23B19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E01BDAA5;
	Thu, 21 Nov 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHUg7rcB"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284C15665E;
	Thu, 21 Nov 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216356; cv=none; b=dLDxyYG7w+O+0fbHWR7+4gCDhqmgMn+3hv1GOAvXXJV0uDZtqxBVqiqDrFk628o3UNMQCw3ieu5mUWAtl9ygw5j2u+KhTj1C7S3Z6A1TvLRbJssNm+vZs0ypp/a6a6XsH6Sd/FqJ/azSssdvJ+jrxaw24RM9YZHe6aC4KZUNJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216356; c=relaxed/simple;
	bh=Y7Bn+9pJo7nO7PQtMMLwgiHvrZ0871a3sU2c8cWm71U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9eP/fdvUaEZLJIdvqWe9Jln3cZ0+g2TBrg7mpEzyeUBOY3j07Nq4oz7Po7EXrRD8MAjo+1JVIGqGFauFAlwkGULz5IOrgi0R16O/38iBtflHESKgEypysZ6r06WCDMPTOsMuWQEgSOLfAI2I3YzmCIhJGvqjw45cBbtcSvDrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHUg7rcB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4635760725cso22644511cf.1;
        Thu, 21 Nov 2024 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732216353; x=1732821153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l+Cnz3oOSITA9Sni+tfmSuPMOvtijlXLQ9PbqOF+pk=;
        b=MHUg7rcBaQON0npoFWVQVtGcCTGmhMGgGtfulzlA71otOh45ExWOdU4Shz03z4aygB
         S9SlZNaV32PelbWwzaAGQn/X2N0Fm7gbW9TFoNAwAN4tlLlz1LUJnFTEVa/eX8HjueAE
         H+vFPTTk3tLifYb6iKo/7wmJuRjlKoopS0frQr83IikqTWWSHc7I1lEQ37i2b4ECAR9T
         VTHN7FplTyVSiBl12BAV0I3muyEHq3PVJNfCMgScTu6CISmzKWSNjJfhVK4cMH7eOgjn
         pe4N2lVJ7GuTdlUla2Kqc0yBxmvDhUYC+80gCT+WjNIJlbgPZgUD7Vxk4S3DTRRJe6Ng
         RTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732216353; x=1732821153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l+Cnz3oOSITA9Sni+tfmSuPMOvtijlXLQ9PbqOF+pk=;
        b=ChzDnvENa3vn4g+nTQNg4Vgpcx8Gb/JpttCWMwMSwcLqQk17YHVl1gYWvLTehCh8XI
         fucNLnwGL5ruSPFBHKUUgYznYJ+MMZ8cGG79pLKAhk1awdr2+878YcOA6bcW71B/Nz1f
         1Zb8qDvOx2fKfM/sFaCITeVckemOvh5eRWKKwtMUAKBKvDv8HZnHHj30ObAIYrgtibW8
         tbmhU9GqeUl6MJr/PoWQ9/dPZIigKQDh0t34CLH99Mra1SPGH8pB9e+6tUUOKFmc1z5r
         99akirf+xxlSRVAOKOEguyytLhlOz449pz+GbRr7kZBqs7vyS7qIeUrkwp8Il5ZWQwTr
         3+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBwz6IYdQyim0ECFlnuPBq3U8DA8xVy4EJhShye3Gel1aJtuuar90pgllsxjsn80efwsIZYmQouqThD2pQWyw=@vger.kernel.org, AJvYcCXoZgsVa234QGJYyVQnR2HpybGI9wznswc1X89rGxEN9NSZWrTXG8wGiJlsuQviIVvbJLcphwmCZ1WDPik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbOxfY8ZLW7fOZOk+OWd/jvrvyg72iF1IkHogWq6CFQoal08Y
	PmBpp+OOP6fboY7n9WnC5zNGUWysi7wMNqoZtxEgFU5rocxXHO9W
X-Gm-Gg: ASbGncvzMV+gpzRSJhqcZouRLdenC3Hh0x11z1efXRMVgAFV3Mu6VXjexGv23CEX1Zd
	8MASflmtQKhxgDg8GiunbIwynpv+gK3eoRMKqtowehwEXdnKIGh7ly0KRhuaXUmlW4mR2WBK3h2
	MCsKoFps4uGIXs45d3e+X3N4lyq+IO6TE+oCnMuzF+wt2RG05W5fDHmNIbw2pGKJIxeQuTSr7RQ
	OJtH93I2ufwjOhtDuak/3khEaNi8DHN1tTz1VvwQrKLgFX2TVGEZT6xKerBw4NhKV9nkEgP3Kro
	Gwf801/MvNleRAC2Pk2zDkWuOZhGYaMJQedN7wfR
X-Google-Smtp-Source: AGHT+IH32n1uDGPzo8idMNiROjH+9JYUnYBsUU9edzhv7RQpAuUmS3rb30OFpTzBk5owI83bpmzA5g==
X-Received: by 2002:a05:622a:107:b0:465:2fba:71b5 with SMTP id d75a77b69052e-4653cbbbf0emr5704111cf.13.1732216353323;
        Thu, 21 Nov 2024 11:12:33 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c40e789sm2148911cf.42.2024.11.21.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 11:12:32 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03EA01200043;
	Thu, 21 Nov 2024 14:12:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 21 Nov 2024 14:12:32 -0500
X-ME-Sender: <xms:H4Y_Z5DSeKEMQuZnaK5XuEAun1KC0PgHf0RRikES9KJEq8pP2RsHhA>
    <xme:H4Y_Z3gjVZLlmZrTgFh-atNeMIrBJ6ncx57mG8pT0tHOjsi22TsauYKp1IFv0yuxw
    Xv5ChaQuixU3oVaXg>
X-ME-Received: <xmr:H4Y_Z0lCHoYBtpE77uaV6JO_n7bu5NlsS_6Vu0GB_bEksEWo-6g-aqlyCCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:H4Y_Zzw7n_gS8rrWQ4PD-qlKeUNVrGQKO2peAi547ay-qIse1qcnDQ>
    <xmx:H4Y_Z-Tkl8o86HcGuuj_UwgTsEVXXnDwCfraQ_Mu_UztrF4cW6SBlg>
    <xmx:H4Y_Z2bpZ_VLH9QLao5ZOAm58vPkbyuCk26d5DopKnAbdDPY8EEqcg>
    <xmx:H4Y_Z_SVlenI-jrKlHURNSKOmAEh07spPpPsXbm4VDWrgri530GHGQ>
    <xmx:H4Y_Z8DdCrcpEMrJx9jcxgxgGJT9VxhwmAjqwpslsP2aCAs-t0Ji_yYy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 14:12:31 -0500 (EST)
Date: Thu, 21 Nov 2024 11:12:30 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz-GHlkhrz35w2YN@tardis.local>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
 <Zz-FtcjNm0TVH5v9@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz-FtcjNm0TVH5v9@tardis.local>

On Thu, Nov 21, 2024 at 11:10:45AM -0800, Boqun Feng wrote:
> [Cc Kairui in case he's interested]
> 

(forgot to cc...)

> On Thu, Nov 21, 2024 at 11:30:13AM +0200, Abdiel Janulgue wrote:
> > Hi Boqun, Matthew:
> > 
> > On 21/11/2024 02:24, Boqun Feng wrote:
> > > > > So if I understand correctly, what Abdiel needs here is a way to convert
> > > > > a virtual address to the corresponding page, would it make sense to just
> > > > > use folio in this case? Abdiel, what's the operation you are going to
> > > > > call on the page you get?
> > > > 
> > > > Yes that's basically it. The goal here is represent those existing struct
> > > > page within this rust Page abstraction but at the same time to avoid taking
> > > > over its ownership.
> > > > 
> > > > Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
> > > > 
> > > 
> > > Could you use folio in your case? If so, we can provide a simple binding
> > > for folio which should be `AlwaysRefcounted`, and re-investigate how
> > > page should be wrapped.
> > > 
> > 
> > I'm not sure. Is there a way to get the struct folio from a vmalloc'd
> > address, e.g vmalloc_to_folio()?
> > 
> 
> I think you can use page_folio(vmalloc_to_page(..)) to get the folio,
> but one thing to notice is that folio is guaranteed to be a non-tail
> page, so if you want to do something later for the particular page (if
> it's a tail page), you will need to know the offset of the that page in
> folio. You can do something like below:
> 
>     pub fn page_slice_to_folio<'a>(page: &PageSlice) -> Result<(&'a Folio, usize)> {
>         ...
> 	let page = vmalloc_to_page(ptr);
> 
> 	let folio = page_folio(page);
> 	let offset = folio_page_idx(folio, page);
> 
> 	Ok((folio, offset))
>     }	
> 
> And you have a folio -> page function like:
> 
>     pub struct Folio(Opaque<bindings::folio>);
> 
>     impl Folio {
>         pub fn nth_page(&self, n: usize) -> &Page {
> 	    &*(nth_page(self.0.get(), n))
> 	}
>     }
> 
> Of course, this is me acting as I know MM ;-) but I feel this is the way
> to go. And if binder can use folio as well (I don't see a reason why
> not, but it's extra work, so defer to Alice), then we would only need
> the `pub struct Page { inner: Opaque<bindings::page> }` part in your
> patch #1, and can avoid doing `Ownable` or `AlwaysRefcounted` for
> `Page`.
> 
> Thoughts?
> 
> Regards,
> Boqun
> 
> > Regards,
> > Abdiel

