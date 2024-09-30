Return-Path: <linux-kernel+bounces-344972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD298B0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD70E1C2121F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8F188CCF;
	Mon, 30 Sep 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpgOP26"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF35339F;
	Mon, 30 Sep 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738599; cv=none; b=CV9zSg2ZHZUhXarxJ6dp/ycY4ceMg2qTZWS0E96xG3+m2bqIbqUkwJl3T/3vYacsYz7NIcT1TQ0PsdLGxaDahvWyJeqWCIYb8kN9Dobt64yBg/5Ai4iYZL/yZr8U4uK5GlUlyLW3EUU4yDU0+wbuq0lBViLNRtd/81MQUktRTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738599; c=relaxed/simple;
	bh=Vr89rIgJwhdKHBCHavWBPOdILEWOov+Fgj6ueA64TzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdiUanUo6IDrlIhBdadJfU/9lPUKPzfT1YxBfnpmOZVt4+1rzCBfbzDMh52jPymVsv5bsetZ9Ko3khFmR4+zh8BlT74IRD3CEWeET+akIEH9if+tfpjDAvyhYc5BcjG2UttHWfixD328sXaYUoAmy9oBSo1+hbhAKdHysHYRk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATpgOP26; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582fb3822eso37031491cf.1;
        Mon, 30 Sep 2024 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727738596; x=1728343396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UVGSWITSIR95/PDO4OF2+68R+Stktvi6UpDwVl2BVg=;
        b=ATpgOP26+UGCwnyLdeQKP8agBpc5IPv48Mhyg7Ihw6uIM/s8Tm4DurasQeGX2gePNN
         B/jVwU7U2gYkb4Wp53oY/2Wa1AbQeZDK4heZCSfekx8f9+icJqrIfzQDjVfI8+rx67KP
         hvRjYFB0i+1GaDMJpDHVI0P6iB2/eIBwSLI64V6GylDwulaiPhheR8YGJi6m65Amq0rc
         Ztxy97+Ter0TsxaDiCXNZRF0so1FcYKpFOSvNjIFmMn7CMGGnd6hN5r3sS6KzhT1OyoE
         fv/9PVsdmN5OReIKX7xpQBeCKCodvw6eYzmkTd9yFToyZ3J0ZTGVJ32QznUKbCZuuqHs
         6afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738596; x=1728343396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UVGSWITSIR95/PDO4OF2+68R+Stktvi6UpDwVl2BVg=;
        b=ESFDqOQcW/L30DctHETMo8Q+WpXknok9mntF8qoiEAA6SN5p8GuaQUbwLce77z0vCR
         dt9qyfYxRegrzGNoXA7odPzNKE1uoXECf/sZMoiAUZFM211j8LZYsykZAOl9O1ga6j5H
         kDLgI2mbhH9Jll/eDrmbqWedFU3hNtq1ZlHu/rMMMjN6I2v2G4UkVUP5sl/IAzW7MyrJ
         +Ts5YBYHXtrm/xt3aYmpSkW9zQ5oZ1OBB8Rdm7Xyz/hEq/VNnbJ/qnFlLQpIw7nzuH35
         LAsgloC/Q10/DQLLyeLXdrgaeJHw831ZfykxOnOmuQAUq90nnqa9t6de+LUDvESHyBZo
         rIKg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0mVBXpSVtNvwEDOfwzjPEnYIK3+ppyyT7UqnCLTMi/oZPtMc5SY02BBs/3psU+2G9FsQDmhOgcI/r+A=@vger.kernel.org, AJvYcCX5qVGTIK2kPbU53glF/amviy+HMDa8OW3+gWL9NK4mA4XMiMy9j7NHNQ4WtjswBUEYUDvS9Pztjur1TsO8u9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj21Rc+1dAY91tQmKyt+yaxqsdwnAvS3LumCDFdn62bNNpQA/f
	mGLbvJSVFlshL/Jw34RmTedqhbkzXChazGG2NzF34bjI705mz+J/
X-Google-Smtp-Source: AGHT+IHLk9u/prpDcCx7RCUfwqcUYKVvZtDiVF2GMtDDfKQKb7imRlJ5dbjw38FVItxhO0xmmnnElQ==
X-Received: by 2002:a05:622a:199a:b0:458:25ac:cf57 with SMTP id d75a77b69052e-45c9f245076mr196983981cf.33.1727738596150;
        Mon, 30 Sep 2024 16:23:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f6e2asm40242521cf.58.2024.09.30.16.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:23:15 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E63FE1200043;
	Mon, 30 Sep 2024 19:23:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 19:23:14 -0400
X-ME-Sender: <xms:4jL7ZgilE5IRyq8QulXO85wJoEFob8Ozk_TRswCaRBRwl4p6gbt8Pw>
    <xme:4jL7ZpCQ-DNrDS1_b12rVLU9148q1iXp15r6N2KSgXCFswGpjrSdWEENEsmSG--17
    RajHnIS9hk7GRMqmA>
X-ME-Received: <xmr:4jL7ZoFF145MdMbDiZsnWrtpPtHfiAbMRgnli8rUhETD9l1Q0Qbex5JFc6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepjeetff
    dtgfeuhefghfektddttdegtedvueekteeugefghfehffefueeludeifeevnecuffhomhgr
    ihhnpeiiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhrihhnthgrvghoihhtohhgtgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:4jL7ZhTq6W9Ja2mXgGHImV5N2Vx1VeoAYQwwCId3ffTrN1m19EUW5Q>
    <xmx:4jL7Ztxmmi2-6V2cKJB4uK6WnpOY81LQt6D2QnkntOMAveiyRPWA_Q>
    <xmx:4jL7Zv4P3j5dLv7B5gxISeTKgIpIcfreEAWREzKRFww8FKm26CfZsg>
    <xmx:4jL7ZqyUsLtuDoYyYTzv5Py7ZFmAlsq8Eo1sDzdIKMyIbF-ulS1gyg>
    <xmx:4jL7ZhiiAs-bHJvBoZzeHTrVJUvd4D8WxAb-QxcG_1YoXTOW5u9Cl93q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 19:23:14 -0400 (EDT)
Date: Mon, 30 Sep 2024 16:22:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: device: change the from_raw() function
Message-ID: <Zvsypwsxi4hMAfOT@boqun-archlinux>
References: <20240930194637.98260-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930194637.98260-1-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 04:46:34PM -0300, Guilherme Giacomo Simoes wrote:
> The function Device::from_raw() increments a refcount by a call to
> bindings::get_device(ptr). This can be confused because usually
> from_raw() functions don't increment a refcount.
> Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> semantics.
> 
> The new name of function should be "get_device" to be consistent with
> the function get_device() already exist in .c files.
> 
> This function body also changed, because the `into()` will convert the
> `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> `AlwaysRefCounted` trait implemented for Device.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

This looks really good right now, thanks!

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> ---

^^^ note that this is the '---' that Alice mentioned, next time you
could put information that is helpful but you don't want to include in
the commit log here.

Regards,
Boqun

>  rust/kernel/device.rs   | 15 +++------------
>  rust/kernel/firmware.rs |  2 +-
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 851018eef885..c8199ee079ef 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -51,18 +51,9 @@ impl Device {
>      ///
>      /// It must also be ensured that `bindings::device::release` can be called from any thread.
>      /// While not officially documented, this should be the case for any `struct device`.
> -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> -        // SAFETY: By the safety requirements, ptr is valid.
> -        // Initially increase the reference count by one to compensate for the final decrement once
> -        // this newly created `ARef<Device>` instance is dropped.
> -        unsafe { bindings::get_device(ptr) };
> -
> -        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> -        let ptr = ptr.cast::<Self>();
> -
> -        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
> -        // `bindings::get_device` we also own a reference to the underlying `struct device`.
> -        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> +        // SAFETY: By the safety requirements ptr is valid
> +        unsafe { Self::as_ref(ptr) }.into()
>      }
>  
>      /// Obtain the raw `struct device *`.
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index dee5b4b18aec..13a374a5cdb7 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
>  ///
>  /// # fn no_run() -> Result<(), Error> {
>  /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> -/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
>  ///
>  /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
>  /// let blob = fw.data();
> -- 
> 
> The motivation from this change was will discussion in:
> https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E
> 
> I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
> <dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
> patch.
> 
> 2.46.2
> 

