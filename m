Return-Path: <linux-kernel+bounces-416435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5319D44B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079221F23850
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB671C7B69;
	Wed, 20 Nov 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6LHhTRy"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD841AAE00;
	Wed, 20 Nov 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146839; cv=none; b=RwhYdqy6gSYPpVO5aSewrqpq7iPwKNMkophjgpNTr4gJxRN59lsckFCC0m19U0yXsBymWtOiDf0dvuOaJj5h9Zi7tAqMiVW4mfVjeEEvC/J4jo0pe8JakciHS60zOOAuLOKDx0QDtpfUPmHWSEKB7onlxhpiyZGbOWAoLdje35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146839; c=relaxed/simple;
	bh=SCmcvuIheMdrqxRBtfm8qhsnL2EvmxNhk2r6rErGX8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHwD8K+rVm+Rut6tLGT0GGs1xAGa4mZGRHRkkl9d0L1ppxsvZrIQIv/9iX2QBfX8GA7tzXJDWAcmOSLSNVTk6G6huLtNn91AmODFC+pkta40bfeYZDbNR8XyvSy9Lj0fKKwzgQZcS+njSXg0/DerCAOUXW8PixBrFBetxyfjqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6LHhTRy; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-514e4f09145so35025e0c.3;
        Wed, 20 Nov 2024 15:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732146836; x=1732751636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwR9U7++o+mwGKw/TgQh51JacKaxEXIG/HrcadPO/PU=;
        b=Z6LHhTRygdiZ3vs/L8TxIgTOhmHX/BHcGSk0eqQLgWJxlr7uUyKMVkgwmTj5TCcx26
         259Aty7486ChmT8AJ29lzMQOoNdNO7K8B2svMgqmihGYzp2MPsB1ZugVFc0YZ1Lb4S/Q
         NohEdqrCuW9ZpHIYRY8F4zaUqK89HdWjiI6B6FuDmizeP2/urNdGjHrZdl+wN+p6JjQT
         KnHt0t+LEhT56Ryi0r9NoDoEM/SUF6GF6Hgec3P9w63+a/lrSX/Sv5ZfjVXpBr1uqWEf
         yGmr122pNgamyjK8csiw74Ay+tE6hinPj+jZay3NDfbIuoFy1FShNnoMaNnc/O4BvvAA
         TOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732146836; x=1732751636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwR9U7++o+mwGKw/TgQh51JacKaxEXIG/HrcadPO/PU=;
        b=BLo8gEEmTs833ERfKw/ykHF8E2xB9Jw9SJCS1NuJs96pLE5QGdCNyuNtkm+puzk/ID
         BIJhJ+i602iFcUvTGurQFk3HywuVLRRLxjWMZwUjK4dNVY/J09VgrYxGWjP+BOuq66s7
         h69t7X6KewOsS6crWlH6OIlfjV+z/YSrPHZLtBXwCzQhP6nFLoMp2R3lFX5S/OF35JI0
         qFpQXhYAnYQE3CzNzJreaqKLBnRB1dShYpFrgxS92DNjwGiQN/2K08uM7vcBscptn/yA
         bndelyRGIe01EbNMjoB/qktjQfSShlP/5IaRALzG4crmZRNrAQ9Li4jR0zSzyBDale8q
         xI0g==
X-Forwarded-Encrypted: i=1; AJvYcCVHB2C0wSa/Y3Sjefq7sn5OLiaU3DgORYqEY5YPpW2b3MORolu9ZGf24ZrbKdgrKqjtxyx37hKNuRNT1jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeu3S5w+bUbSHANg47DQCSkkiaVFMVFroZ3w8OYAojIFIMSuY
	zs94i0IqHmbHeiZVSWS6pVtJ3/3jmJU+tz8hQk64WG1444LRK/6E
X-Google-Smtp-Source: AGHT+IGZ1+lggK4vm6e7kRaF2aXi4U4XPaXDudfx+O7uR+OgVOv1SrpR7JPPN2u4Rzr4dadzt7olRw==
X-Received: by 2002:a05:6102:3e1a:b0:4ad:6367:c7d8 with SMTP id ada2fe7eead31-4adaf5d480dmr5700216137.20.1732146836500;
        Wed, 20 Nov 2024 15:53:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380f39aasm16250566d6.66.2024.11.20.15.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 15:53:56 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1ACC51200043;
	Wed, 20 Nov 2024 18:53:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 18:53:55 -0500
X-ME-Sender: <xms:k3Y-Z18KCSNKos1WaMYLhar_eGC0ScqRrPVJFjSEIr-9qgSxQE2Zfw>
    <xme:k3Y-Z5vgtENpQDmVSX34iOICLoTpp76jjgSEQFKqxwkeLXxJdGFIF6-o78DSU1yuJ
    NqnSowx_ZE0_qh7DA>
X-ME-Received: <xmr:k3Y-ZzA8E8bmtnrvZeoxDDOd6SjPrEOPxvxeEVG8VSn2detQdomTWD5D6ZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnheptdehhfffhefguedvffegudegtddvhedtueetuefh
    gffhueeuudekgeevfeduteeinecuffhomhgrihhnpehgvghtrdhmrghpnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhn
    sggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhihuh
    guvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhig
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhord
    hlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrghes
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k3Y-Z5csZ__ynPowgA-bAgaFd_iyAYdnqWjfJJwd3fcnZpWgYTkyAg>
    <xmx:k3Y-Z6Nqdbq_McNtQkVZ1leqJYSuw8SIT2ZlS7pCjmbK4Ma1CKt9GQ>
    <xmx:k3Y-Z7l19wrjSFa6UBBc-dC8cSJzxXgAkr6CPvrk8vtlye3negcRdA>
    <xmx:k3Y-Z0vnSmaZyTN26xA5TbRQCCe_I42Zo7wzgiMeudcyC82aB0Co9g>
    <xmx:k3Y-Z8uphiWkymJfSjY92m4wBvDSpeQRzpmLj4-t467bVP70RtAqFXkb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:53:54 -0500 (EST)
Date: Wed, 20 Nov 2024 15:53:52 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	Filipe Xavier <felipe_life@live.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 1/3] rust: sync: Add Lock::is_locked()
Message-ID: <Zz52kNp4_jRxBv_G@tardis.local>
References: <20241120223442.2491136-1-lyude@redhat.com>
 <20241120223442.2491136-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120223442.2491136-2-lyude@redhat.com>

On Wed, Nov 20, 2024 at 05:30:41PM -0500, Lyude Paul wrote:
> Now that we've added a Lock::from_raw() function and exposed Guard::new(),
> it would be good to actually add the ability to assert the current state
> of a lock to ensure correctness for unsafe code using these functions.
> 
> To do so, let's add Lock::is_locked() which simply returns whether or not a
> Lock is acquired. We'll use this in the next few commits to add some debug
> assertions.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers/spinlock.c           |  5 +++++
>  rust/kernel/sync/lock.rs          | 18 ++++++++++++++++++
>  rust/kernel/sync/lock/mutex.rs    |  5 +++++
>  rust/kernel/sync/lock/spinlock.rs |  5 +++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index b7b0945e8b3cb..90216a69e3ea1 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -26,3 +26,8 @@ int rust_helper_spin_trylock(spinlock_t *lock)
>  {
>  	return spin_trylock(lock);
>  }
> +
> +bool rust_helper_spin_is_locked(spinlock_t *lock)
> +{
> +	return spin_is_locked(lock);
> +}
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 139f17f2ec86b..542f846ac02b2 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -85,6 +85,13 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
>          // SAFETY: The safety requirements ensure that the lock is initialised.
>          *guard_state = unsafe { Self::lock(ptr) };
>      }
> +
> +    /// Returns whether or not the lock is currently acquired.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is a valid initialised pointer to this lock type.
> +    unsafe fn is_locked(ptr: *mut Self::State) -> bool;
>  }
>  
>  /// A mutual exclusion primitive.
> @@ -170,6 +177,17 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
>          // that `init` was called.
>          unsafe { B::try_lock(self.state.get()).map(|state| Guard::new(self, state)) }
>      }
> +
> +    /// Return whether or not the lock is currently acquired.
> +    ///
> +    /// Keep in mind that this function is inherently racy: a lock could immediately be acquired or
> +    /// released after this function returns. As such, the return value from this function should be
> +    /// treated as a snapshot for debugging purposes.

Then why don't we use the function provided by lockdep? I.e.
lockdep_is_held() and its friends?

Regards,
Boqun

> +    pub fn is_locked(&self) -> bool {

> +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> +        // that `init` was called.
> +        unsafe { B::is_locked(self.state.get()) }
> +    }
>  }
>  
>  /// A lock guard.
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 0e946ebefce12..f21b1f14cbe1b 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -126,4 +126,9 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
>              None
>          }
>      }
> +
> +    unsafe fn is_locked(ptr: *mut Self::State) -> bool {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        unsafe { bindings::mutex_is_locked(ptr) }
> +    }
>  }
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 9f4d128bed983..cfccf5e900b80 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -125,4 +125,9 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
>              None
>          }
>      }
> +
> +    unsafe fn is_locked(ptr: *mut Self::State) -> bool {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        unsafe { bindings::spin_is_locked(ptr) }
> +    }
>  }
> -- 
> 2.47.0
> 

