Return-Path: <linux-kernel+bounces-399038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E79BFA10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BABB1F22A95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFC820D515;
	Wed,  6 Nov 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwsJZkbx"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F11DE2CD;
	Wed,  6 Nov 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935575; cv=none; b=l9uVRKnkVwjX1/dnDbl7QrbHByRNQ90D75WMeQOfwx17DLLEWOzfiIyOLfm+s8VBIXmUTMCAZ16MvhKuFMh5c1u6ad5hfHF6zlMqTetaAjz1uAk+yGmKpqgP3OwuEqCAi7qNL2+h4zaoiwyfLAyiNiDE7pGGBTUUXOhdp50ZW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935575; c=relaxed/simple;
	bh=g46WnnIOGjqkQwYrb3HR+XA03ou4N5YVNpSTV5E8hmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxZsSTwSzD8Rbs0WSqgZnWR8yd/TE5QNKrmqA2rKsuQBkQe4NsqnRlhhalQ/BuJ553Jas9UmyCYz7D9tO1BsBgb6uEJnjViVfSXYKz5m+5j/w0Iw4AejIyBlC6BsX8YOrY+aA06DB6ojm0aEIzP/DGLeJw30wTxVxFSfpBFHyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwsJZkbx; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e30d0d84d23so319294276.3;
        Wed, 06 Nov 2024 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730935573; x=1731540373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFLEBmby1hjS/I/DUU6gTf3FMTsFKIjPYBp1gPAcVfA=;
        b=BwsJZkbx0C4GK8EB+iJ+clgUtX5xEOR8h/swAQbync33Qkbpi4JXvkfPY/3nUtwWN/
         i+XZ3KUn43bzOqtteDedqwHkSlA6pvo2G6v1DbKHRa9ig7/NIOyyP/m0rKoLx+EbVI61
         bU3tCzcDyxHxVNAD1OoGf62bp4HG1BJL/9rRE2VJlwYUfFC/eQowIvzKG5o99PZ5xI4h
         QlIZDuFtqticGYm1mGGz2R5/R0itjWA+huuETsKKGuVg2pQYXTGvFeGM1a6sigvfwqjB
         SbrKg6KtFT6MHPXuK5yWO0LfVyw7ylredVUVhionyCgqukc79P3ccYSPbBa+WZKX6Tk/
         DwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935573; x=1731540373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFLEBmby1hjS/I/DUU6gTf3FMTsFKIjPYBp1gPAcVfA=;
        b=JaB/WqFTqYPhsJg5OyPyAelhShl0HpPvkWmIv7AjzqzdeWrnq1pdQakR4cV6KzrdkE
         Z0FY57m7v1n7FIk61sLOLMrlfWsx3R677ySbBNYOpieCndiJjRDgQ0dqzRJYSsGd07Kj
         4dPWdCSjUsJBGCbB/lXIYomVKkBRAppU76j8jJmWEgdohaaAqtJtx+m3Jf/P1Seb1qqF
         XGIlyg4aF8LZjj5f/LMG/ARSctLFl6qJeeq0z9sT25v+dALrX+ML6lKuotwstg+iMP8o
         6Rw6mzBEjnnTup9o2oPacaaHpNKQRamgFDT2/rzGEzB7LWvbXEZPLNdMY370oLi4Yyfr
         rLAA==
X-Forwarded-Encrypted: i=1; AJvYcCXVrkjzS+htFXWHhKPlkZJ9EQUlngYpSVu/8B55Jtsj5uiekHweU61jBp54NceSFY/or4BnUO3AgZl2kF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrpz0fg7EeAWuc3eSP2WS1KxARfDDCdkTVjTCpZEZVcdMNw/H
	zsb9GVOIpPNwwAkXw7lEYh9moRxSFM62CkCPr+9IlzE9FG2I1X2rJjENpA==
X-Google-Smtp-Source: AGHT+IE3EXX48EsTM/zAfGkWMEq0ZNtl+JtINjLVNJpiZ6tSxqgGB43crkvstXz3ZtTs9BbcuIZRkA==
X-Received: by 2002:a05:690c:102:b0:6e7:e5d6:64cc with SMTP id 00721157ae682-6e9d8a22ae2mr23112897b3.20.1730935572502;
        Wed, 06 Nov 2024 15:26:12 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396643135sm566856d6.130.2024.11.06.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:26:11 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4DBFA120006A;
	Wed,  6 Nov 2024 18:26:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 18:26:11 -0500
X-ME-Sender: <xms:E_srZ4XZDhsUvOR71WY-SZ1i4hA1sjR3cxl74CxSBLm-Xao5YH52EA>
    <xme:E_srZ8k3UgGs5UuPjqsk8ZSk3itc1TbJHcRI4n520IH617n-IT8MkfC4I_mw-4H5F
    RM0aIZwmByY48kCTw>
X-ME-Received: <xmr:E_srZ8auzCDGZmHSFJH15mYE_gnZIC5t9_13he1NNIBnKdWns8ivMNnQrLK1ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdethedu
    udejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gviihulhhirghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdq
    lhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhguhgv
    lhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepth
    hglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfihilhhlihgrmhhssehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:E_srZ3W6l_PYwxbb_C1hLNxQcaSxt0ldMgsnXS05CuJuRQZ8phQpyw>
    <xmx:E_srZylGP58UZEYJwjfueRdkqlik4aZTjvZJaSI4ixWb--bbnRjIjQ>
    <xmx:E_srZ8dRrGOGIUwU-vrvrhizn6cqjYCSqmKnx2LRF6bTc-KN3uu3BA>
    <xmx:E_srZ0Et6akzSmgFKsNYkjLUjxwy-KfMNWJ5Ki20ZhKrvcH0-z5wYw>
    <xmx:E_srZ4l3jfUaSOHePb9nJx0MPJw797ra-2_DqN0BW2k_r-VCWOo9E9wz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:26:10 -0500 (EST)
Date: Wed, 6 Nov 2024 15:24:42 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Eder Zulian <ezulian@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jlelli@redhat.com
Subject: Re: [PATCH v2] rust: Fix build error
Message-ID: <Zyv6unk_tRyv_v7m@boqun-archlinux>
References: <20241106211215.2005909-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106211215.2005909-1-ezulian@redhat.com>

Hi Eder,

Seems I forgot to reply you on your reply to v1, sorry about that.

For the commit title, I think it better be:

	rust: helpers: Avoid raw_spin_lock initialization for PREEMPT_RT

, because in general, title of the commit should be as specific as
possible (otherwise, half year later there could be 10 commits titled
"rust: Fix build error").

On Wed, Nov 06, 2024 at 10:12:15PM +0100, Eder Zulian wrote:
> On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
> avoid the raw_spinlock_init call for RT.
> 
> When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
> error occurs:
> 
> https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> 

Since you already use the "Closes" tag to refer the bug report, let's
avoid links showing twice, how rephrase the above three paragraphs as:

"""
When PREEMPT_RT=y, spin locks are mapped to rt_mutex types, so using
spinlock_check() + __raw_spin_lock_init() to initialize spin locks is
incorrect, and would cause build errors.

Introduce __spin_lock_init() to initialize a spin lock with lockdep
rquired information for PREEMPT_RT builds, and use it in the Rust
helper.
"""

Thoughts?

> Fixes: 876346536c1b ("rust: kbuild: split up helpers.c")

I'm not sure this is the correct "Fixes" tag, that commit is a code
move, so it's unlikely introducing issue itself. Moreover, we really
need PREEMPT_RT being able to trigger the issue, so I think the correct
"Fixes" tag is:

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

(yes, I know PREEMPT_RT is a long existing project, but it was until
that commit, you can build a kernel with PREEMPT_RT=y IIUC)

This will help stable maintainers for backport decisions.


The rest of patch looks good to me (we could maybe provide a
__spin_lock_init() for !RT build as well, but that's more of a
cleanup)

Regards,
Boqun

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
> V1 -> V2: Cleaned up style and addressed review comments
>  include/linux/spinlock_rt.h | 15 +++++++--------
>  rust/helpers/spinlock.c     |  8 ++++++--
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> index f9f14e135be7..f6499c37157d 100644
> --- a/include/linux/spinlock_rt.h
> +++ b/include/linux/spinlock_rt.h
> @@ -16,22 +16,21 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
>  }
>  #endif
>  
> -#define spin_lock_init(slock)					\
> +#define __spin_lock_init(slock, name, key, percpu)		\
>  do {								\
> -	static struct lock_class_key __key;			\
> -								\
>  	rt_mutex_base_init(&(slock)->lock);			\
> -	__rt_spin_lock_init(slock, #slock, &__key, false);	\
> +	__rt_spin_lock_init(slock, name, key, percpu);		\
>  } while (0)
>  
> -#define local_spin_lock_init(slock)				\
> +#define _spin_lock_init(slock, percpu)				\
>  do {								\
>  	static struct lock_class_key __key;			\
> -								\
> -	rt_mutex_base_init(&(slock)->lock);			\
> -	__rt_spin_lock_init(slock, #slock, &__key, true);	\
> +	__spin_lock_init(slock, #slock, &__key, percpu);	\
>  } while (0)
>  
> +#define spin_lock_init(slock)		_spin_lock_init(slock, false)
> +#define local_spin_lock_init(slock)	_spin_lock_init(slock, true)
> +
>  extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
>  extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
>  extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index b7b0945e8b3c..5971fdf6f755 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -6,10 +6,14 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
>  				  struct lock_class_key *key)
>  {
>  #ifdef CONFIG_DEBUG_SPINLOCK
> +# if defined(CONFIG_PREEMPT_RT)
> +	__spin_lock_init(lock, name, key, false);
> +# else /*!CONFIG_PREEMPT_RT */
>  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> -#else
> +# endif /* CONFIG_PREEMPT_RT */
> +#else /* !CONFIG_DEBUG_SPINLOCK */
>  	spin_lock_init(lock);
> -#endif
> +#endif /* CONFIG_DEBUG_SPINLOCK */
>  }
>  
>  void rust_helper_spin_lock(spinlock_t *lock)
> -- 
> 2.47.0
> 
> 

