Return-Path: <linux-kernel+bounces-416438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F349D44BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE8B1F226EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C011C4A3F;
	Wed, 20 Nov 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsfVnhpQ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9627447;
	Wed, 20 Nov 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147193; cv=none; b=ley3F+M7a2CTsxOv/YqIoem2RfB03DZKLCn1r7PB1RkZxSCPL78zscz53+mTb8L93iyQewBxo36+gIfX7SEkLJ7eDsMsx902IO/KwxAccDKm67kii52OFK1FetCKNy1JyuFP+vuRfJaYS8gba616NG6TFJ+jLpD00Ka6W9H97o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147193; c=relaxed/simple;
	bh=q2ocIH2ula1OWdc0zmaBfNWPMeIEANSIqkA8myM+gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQOK9SFtC6bBJBy22hn4Ev9wnkpafoJE7+5gqSR3Fj0EAWGc+uUGcXVO0ZaeFPMUKOmOppOH4vcpdUd6TrBXpgTcT02tcn6gSrorvq66ZpSh66No7nG3BZK+mOOM78606cuOuNUbgb7K/uKjWSQ4yrM5d3bbPXT6TBkcmsgwJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsfVnhpQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b35b1ca0c2so156646485a.0;
        Wed, 20 Nov 2024 15:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732147190; x=1732751990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiDKYv75GgV/NsxkesfcH4JoxEJ3+bc5qnzdoPtFQC0=;
        b=fsfVnhpQ+ECSO/3sjrGygOxS8sK+02/JZHxycChuHdfWb4wsQZNk+zbAN3aSoA7ej0
         mpWiqxMmg7WuRvpidz+J2uKyHoK2Sv0qcnkLBjXY3tOwICjAMgqW67miXU/oD0TCCBtI
         fjmVKIu4hPJZZjB8n9TB5WcotGvMrInp34+B2f5V2wZ2S1cRKLPS4uG4KRUaC3kMWqt/
         VIPULggK7S1PaYM6VOXgCPS0dMvDUg3h2fUTOIpvqmFGl7vMtrEf3H8VFCVRv/eUtIkB
         WDpZO1zxNZiNQE7f3TPlejO9Bla72Nl5HtlXJU8GLfbn3LB7rf+cJTsR5M9azDlN9j3L
         8afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147190; x=1732751990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiDKYv75GgV/NsxkesfcH4JoxEJ3+bc5qnzdoPtFQC0=;
        b=Y22rLW7naQGIaYGp6W/eo5ZY1ViQLlMoIZlMMuYsNG3uuURhQh6TUs03+kNmwImghT
         PA6iZl4BnNiLpxAXsC/JoA6yTJMZgqtOlJ6wej+wme+Eth4AS9WvMwTUObTDDWLgTdDz
         E0MFgVNHtUdWx4UAdgKn1xEHUnQhWCkBp67eC8CjbwMDZozMOn5c3/BuksJ69CvhltCs
         wrYJpnBl+pv9W9y6Yf29VRtTRV60Z4P6YnMrQM4tapoGC1EOLOPB0B7vWb9Tt+L4fEDO
         8259/rrS3c/WVL8mgX6+tbiSxfOIoTKa8zyHsk3U/ROBtpfXD/i/izH3wSIKBk1MSX6g
         i8MA==
X-Forwarded-Encrypted: i=1; AJvYcCV5w+M0GFAIZGjJUQHBlmgG/HsobXkCDerEh4NaHb6uL8LcJBwaMOxJv0JHF8/FIRndAOXAo2ZMaV2woz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcKjm/0yphPQqOzkbbe3CiiCSpFh7AGk5eggOWDv0io5y6j2Y
	7PFQM3k0Lftd8EdGZ3g5i1XrsTXxLMAXHbVHneKCGCkkA72ixARj
X-Google-Smtp-Source: AGHT+IFwFBHPNAKhsZINjwPWb3KUDRyyCblHk5G5jgvR7nmgKyOKsTrTo8fE8bxViP7nQSMZSlfV5A==
X-Received: by 2002:a05:6214:5183:b0:6d4:1613:be3e with SMTP id 6a1803df08f44-6d442479230mr22725326d6.22.1732147190387;
        Wed, 20 Nov 2024 15:59:50 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812af82sm16238126d6.90.2024.11.20.15.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 15:59:49 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70274120006E;
	Wed, 20 Nov 2024 18:59:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 18:59:49 -0500
X-ME-Sender: <xms:9Xc-Z7RyqdmsPtUWMDLIb7-iyk3xBIC6d6g873EAkuO6x9UkMabmYQ>
    <xme:9Xc-Z8yqGQiIDYIx1YCpTbBDjAKwzZtS_xe4zmAfp7QE9TI5MWExTv6lwhhlhUWGn
    c0YZeRbxfB9_YXHnA>
X-ME-Received: <xmr:9Xc-Zw1Z0dX91m7A7Dr8ddJK_f9IAKa3KG7vJYHiHMF1rXWYg63_OOJADmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgfevueeguedvvdehkeefteffveehvdfhueekveeh
    vdehjeduheduleevhfffleevnecuffhomhgrihhnpegrtghquhhirhgvugdrshgrfhgvth
    ihnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhf
    ohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
    phhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtth
    hopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9Xc-Z7AEBMMvvo4pj66qwhX8_QJQL8czx79x1p3r9IGYZaVsyCDPgA>
    <xmx:9Xc-Z0jjb9PWjJtXBmvDphKSC5ssCdDROIxaR0p3QNITRJouorYd8w>
    <xmx:9Xc-Z_oRHQRsI0Di831t7iRCssVN5pPr_DPPd5W8rqIWPev7TdhEGQ>
    <xmx:9Xc-Z_jUnK_4BDJPV0XxjNSBJvvEl2s84ntkTJjH6epsFIee_asq-w>
    <xmx:9Xc-Z3RKbhqJ4prfK-rdn1Gdz1ePYcv_6VL4hkIYSJQCzmar7JeIHmEL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:59:48 -0500 (EST)
Date: Wed, 20 Nov 2024 15:59:47 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>
Subject: Re: [PATCH 2/3] rust: sync: Assert Lock::is_locked in Guard::new for
 debug builds
Message-ID: <Zz5384uaZdsL306c@tardis.local>
References: <20241120223442.2491136-1-lyude@redhat.com>
 <20241120223442.2491136-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120223442.2491136-3-lyude@redhat.com>

On Wed, Nov 20, 2024 at 05:30:42PM -0500, Lyude Paul wrote:
> Since we're allowing code to unsafely claim that it's acquired a lock
> let's use the new Lock::is_locked() function so that when debug assertions
> are enabled, we can verify that the lock has actually been acquired.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 542f846ac02b2..0a7f2ed767423 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -244,10 +244,17 @@ fn drop(&mut self) {
>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      /// Constructs a new immutable lock guard.
>      ///
> +    /// # Panics
> +    ///
> +    /// This function will panic if debug assertions are enabled and `lock` is not actually
> +    /// acquired.
> +    ///
>      /// # Safety
>      ///
>      /// The caller must ensure that it owns the lock.
>      pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
> +        debug_assert!(lock.is_locked());

You should just use lockdep_assert_held() here, and there's no need for
new_unchecked().

Regards,
Boqun

> +
>          Self {
>              lock,
>              state,
> -- 
> 2.47.0
> 

