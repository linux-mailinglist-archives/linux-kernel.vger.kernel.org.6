Return-Path: <linux-kernel+bounces-364710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AF99D83C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80527B216E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2521D0159;
	Mon, 14 Oct 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9KBvgN"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BD14C5AE;
	Mon, 14 Oct 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937923; cv=none; b=IC4M65Tg1SnykZOfY1wHntxq6WlH3GO3/1FlbN8SFGBAQnrvikwbSgzg1tgZ4Oqpv6bbvl7WaYnMOpnK0Yn0BpU37rJgQRUxDsUHry/rfOJNhzKMMRkjjNCRh9BFE49XQnsz21RfzYS94KtQ4V99oGEY+dpkBfe1tZT9pijX4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937923; c=relaxed/simple;
	bh=bhR5t5x7Fnavf2KleGyp10kq02yLrZd3LAiiksnqv0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7UGx07xfNpbvIq+VtGWaYaHguA+7v7+R41C7RiQJBTibsWaw3M+3tDavzSRKUU4syN1Cgmq2+ROlgevgv27Wfo6N2RhKxH6pf5MVJBspvDOCl0gukWTwBLDRT7pxmEqAjZeeMy6Jz7WzG2oZRofsmbd7mYb4Wy3eYWaPCgspKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9KBvgN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460464090d5so45034351cf.2;
        Mon, 14 Oct 2024 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728937920; x=1729542720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b9xtcbdhY6vteeBu9BqMv3SiOt0wwUdJK1zW4bEExcg=;
        b=RR9KBvgNtzJcVyO6DBMMXDGqhTCrs5FPq88LIWjqmpFkGW8+BKWcY09PiQX81wkSV5
         swUCDO5lyj4q9eGuFsPx61iCc4lR8hT/Odqt3CH6Z/v4PzNEXRU8ee5HRZHXnoML4PyN
         RtuQ1b2elAViQBXiB1vodE6wg5WTkF4PgbjcS5PJazAvDr+RLH+kFQxo77l+6lkBlDBu
         UPi24Psls6GArC1jsFYbr9kKjfHltREz+2gHDV9kZPvcBS1T5m79H4i94DswGgroW5CK
         n6n64Ar107rDEKnhBxe1LbJAT8lFPa1tCrAjTVF3JvKVS9R6G33dw1hDREWdtEbdn6L8
         q8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937920; x=1729542720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9xtcbdhY6vteeBu9BqMv3SiOt0wwUdJK1zW4bEExcg=;
        b=E47aYplr0tm6XpLF7y96Qo1n+16dDoM+6zcEVhjbBNhkg7HqfKV9uIv+Dos522rW4L
         /8TJ419Ff65jBi4gQ94dwxFPnF88RXrhhz/tnSiSUIsQ2B1LA9oPqDZoE9mR77Q+rPad
         0R3H5ETvwRqrj3WJmlUXUSnhcnqxu7qtTNbZm1qwDx+wxl4ws5Y6gTn0W0RPKmVaojvE
         TGYz/DwvfLmFxMEZId7fzENNbgS+QX9vws53dJ4ONkKH0CjQKtNFSqx2GsmoMKvkhnA1
         HiDBfqdHAyvOvWmrtMrkniqkTQ2tSnp8vgguGlHN6ORMEpcLpvOcQZ0Wng2NAtWijgQY
         mgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF7TkoAeJ2buMQUcvUJr/I9AOlgrjeG1D0VDDa9ONZbmJRVkr8p1/2YGyylktc7xIr3mLsPMrY16Q079U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVhfLZFVYFI4YLeDF+AxvYKv7t0V9ZpZwgtRV2EhKJbKa0WFy
	O1JX4R/iiFNuDcpkPN3WqBT2ISUgQwAVwtJcCazppaGb+BKnPJ4z
X-Google-Smtp-Source: AGHT+IEj4fosW8APqQgRiwx5w91WMb3dc7F2oa3YHZzBUyMBQrLMO/KfMp6kToNuI9e6uHyq9DhQ3A==
X-Received: by 2002:a05:622a:2c5:b0:458:4a68:7d15 with SMTP id d75a77b69052e-4604bc45d49mr223145601cf.44.1728937920488;
        Mon, 14 Oct 2024 13:32:00 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427db5d6sm49045131cf.30.2024.10.14.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:32:00 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5D0D1200043;
	Mon, 14 Oct 2024 16:31:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 14 Oct 2024 16:31:59 -0400
X-ME-Sender: <xms:v38NZ5SpAw6G-riieNUQqZt6UIZphQuy1UlJGmcPmG3W084CBmSGfw>
    <xme:v38NZyxIUDYaBO2k15ymZNcj5lje-BFR-huulRMiZdBrpUy0_v6tUdhLudphZoGtQ
    plLw2P4lr3mXV6kww>
X-ME-Received: <xmr:v38NZ-2a9uhSgP_3DwGJ9tEEbmlUCOL2aD-dvSF3mCkykjd--kFgBT7UMGfJXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegviihulhhirghnsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeifihhllhhirghmshesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrd
    hgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhu
    ohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:v38NZxBRkF15-dIAgbn0gpciURz96rp1xkrxp1mWlxPmrSiFT-Q_5Q>
    <xmx:v38NZyioSlZ15Sp_Sc8GdoHrE7gCIVvPRAoIPhAsWC4VXuI9ngQGPg>
    <xmx:v38NZ1olpAb0aCqM7AjhE7GLkYhp227G6S4rirUloFSsil-7UDS2Nw>
    <xmx:v38NZ9hUCDvuS0PjdGEahBx5rWfX9hHwmf7EI4Xqjvgtvrfm0-gpqg>
    <xmx:v38NZ9T8li4oSTywH_cc1WPaylGg4H3bI2uOWGZ7oVTbLu6Hs_LkMiuQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:31:59 -0400 (EDT)
Date: Mon, 14 Oct 2024 13:31:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Eder Zulian <ezulian@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: Fix build error
Message-ID: <Zw1_rXUyjTBOh0QH@boqun-archlinux>
References: <20241014195253.1704625-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014195253.1704625-1-ezulian@redhat.com>

Hi Eder,

Thanks for the patch!

On Mon, Oct 14, 2024 at 09:52:53PM +0200, Eder Zulian wrote:
> When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
> error occurs:
> 
>     In file included from rust/helpers/helpers.c:22:
>     rust/helpers/spinlock.c: In function ‘rust_helper___spin_lock_init’:
>     rust/helpers/spinlock.c:10:30: error: implicit declaration of function ‘spinlock_check’; did you mean ‘spin_lock_bh’? [-Wimplicit-function-declaration]
>        10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
>           |                              ^~~~~~~~~~~~~~
>           |                              spin_lock_bh
>     rust/helpers/spinlock.c:10:30: error: passing argument 1 of ‘__raw_spin_lock_init’ makes pointer from integer without a cast [-Wint-conversion]
>        10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
>           |                              ^~~~~~~~~~~~~~~~~~~~
>           |                              |
>           |                              int
>     In file included from ./include/linux/wait.h:9,
>                      from ./include/linux/wait_bit.h:8,
>                      from ./include/linux/fs.h:6,
>                      from ./include/linux/highmem.h:5,
>                      from ./include/linux/bvec.h:10,
>                      from ./include/linux/blk_types.h:10,
>                      from ./include/linux/blkdev.h:9,
>                      from ./include/linux/blk-mq.h:5,
>                      from rust/helpers/blk.c:3,
>                      from rust/helpers/helpers.c:10:
>     ./include/linux/spinlock.h:101:52: note: expected ‘raw_spinlock_t *’ {aka ‘struct raw_spinlock *’} but argument is of type ‘int’
>       101 |   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
>           |                                    ~~~~~~~~~~~~~~~~^~~~
>     make[2]: *** [scripts/Makefile.build:229: rust/helpers/helpers.o] Error 1
> 
> Error observed while building a rt-debug kernel for aarch64.
> 
> On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
> avoid the raw_spinlock_init call for RT.
> 

This is true, but to keep lockdep working I think we need to open code
the PREEMPT_RT version of spin_lock_init(), please see below

> Suggested-by: Clark Williams <williams@redhat.com>
> 

^ unnecessary emtpy line here.

> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  rust/helpers/spinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index acc1376b833c..924c1a380448 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -6,7 +6,7 @@
>  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
>  				  struct lock_class_key *key)
>  {
> -#ifdef CONFIG_DEBUG_SPINLOCK
> +#if defined(CONFIG_DEBUG_SPINLOCK) && !defined(CONFIG_PREEMPT_RT)
>  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
>  #else
>  	spin_lock_init(lock);

This should be:

void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 				  struct lock_class_key *key)
{
#ifdef CONFIG_DEBUG_SPINLOCK
# if defined(CONFIG_PREEMPT_RT)
	rt_mutex_base_init(&(lock)->lock);
	__rt_spin_lock_init(lock, name, key, false);
# else /* !CONFIG_PREEMPT_RT */
  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
# endif /* CONFIG_PREEMPT_RT */
#else
	spin_lock_init(lock);
#endif
}

Regards,
Boqun

> -- 
> 2.46.2
> 
> 

