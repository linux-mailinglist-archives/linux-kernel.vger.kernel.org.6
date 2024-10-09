Return-Path: <linux-kernel+bounces-357975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8C9978AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71711F22E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8226185949;
	Wed,  9 Oct 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtyX76uu"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F428183CC1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513938; cv=none; b=tZ0NxgEruD3neCe9/kxs9HliC6zQXYWUpDSsbN6ZCJ9H68/3V//tQfxWmdYZzo79hCUlgFPHzrn4Q04jT5rDNLrtiFy8w91hX4aC19kBupLf/vsJHMwMzy0bmpdpdUxkVeO1/xkYnT9bOlBiexjNSdJ+IDE5cNGX/X0K0kbNZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513938; c=relaxed/simple;
	bh=xacQ5Ctui1OC45Fe22Mx9xXIcwl2CE1317+ZIfAIGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beJ1lkozsfeDQ/kr8BGkOsBX+40Q4L09tmLACe/B+mdcdAHshDNMq1+dbKCJ47JtjT2G6mFv26iJ5tHAOwUh7zSyzb/wDg2Tnp3WE8p73fKpx4el8RfU+1TTNAuvAVNHM9Iva/qFSH1SSzd8l1jPoOs9UTe1M11zd/VkA8lj6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtyX76uu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so3135556d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728513935; x=1729118735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W01HWUBKag29Kxfml/wjsEdB0LHh66u3WJJRcMnu60=;
        b=BtyX76uuhq1idRcuLUalcxH/AFlpBEUe3X5rthe37PTXdolYu+6FTlzg+IkuPNkU0O
         p7IJACJxyHWi3zD0e3E/QZkGcrAH1s9kPX8CVtQLjFh0p6FhvC6jIx4CEtQ92k4TfPsu
         M+O5kw0kha5VURtReVDQvm+25/zFm/9fE7hP6GdrUarYgRwkl1REgtjzX19adaEqtVyR
         CDm34fI80d54VCvYXvtUW83+TcmOKa7Va8Gmz4ZQcoBURLrlfF7bXgpOLztisKE1aLPI
         WFmUnYYqDb1VDx79qLGVCq9l4ju6kVB4kF82amMlrHS5UKYAF+4vktSaOANuRrVbVvXb
         pzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513935; x=1729118735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W01HWUBKag29Kxfml/wjsEdB0LHh66u3WJJRcMnu60=;
        b=gZn2tjAvzGtxhSNOF6jldzSSQ5zBsK88xCf4Fkj7/L8tq60QRtY8FoMzvLgjIWOv95
         kDHq08vn1Kjq4H55gzcUMsr3hY/pgWCbvQunKbKeKTAeI2shG0atnAiyO6p5UkZqG6F5
         zDKLRyo73UnWQRouRYdb5srK0JEhS68kKAPKDgCWqVxF/ejsbPpMKM3DMzHAzhhzo2Yu
         Jl5h6RG63yf3zn3T1WWs+GVfpUPnrIMk/cR/I9Yacyug5NxmDCPIGCcQ+gkr4q/LHtri
         8ZPga1hJxcpeumvNW1v/jZ+xeh9aOBnR49PBYRkcMFjRRqLDqrokjGstvBn3N5RI5wPs
         3RAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgKG8jz5SQQ7WUaAdvW2ddMbNpGvImbbyP+P3M1dWzIAdyI+CVrzS3zrIKmP9HpVd1ZpJHlgaZCrhrd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0E2pqDvjSjqYD1QpIQ/bkWuZRsV8ytZYRtTpvAiLj4gVr/kAK
	Tcmzy4X777KHBfQ//HvOObpguEUUXOWw+eh/OAdPd/h/e+RhAbwa
X-Google-Smtp-Source: AGHT+IFh2f+q7srL8qK50CE201+EvUTJkoy8m4VzuraVKFkMsvCOdHLjHmty1y8kZMP7cOFdCHuxCA==
X-Received: by 2002:a05:6214:1c47:b0:6cb:d54a:11ef with SMTP id 6a1803df08f44-6cbe52557b2mr22960256d6.13.1728513935149;
        Wed, 09 Oct 2024 15:45:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46e03adsm49737136d6.57.2024.10.09.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:45:34 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E46E11200069;
	Wed,  9 Oct 2024 18:45:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 18:45:33 -0400
X-ME-Sender: <xms:jQcHZ7dVVuX_MSR7rhuCZPvgc5jsShi7S56Yn8L1RiHXg9ApAySXXQ>
    <xme:jQcHZxMFbzUsBNS_DVte7d5iS-g6tJ3TzMUjI8NUR9OTmRjkPWnSxdbmT-fZjp7Q9
    zyviqY8O7Grhc3y4g>
X-ME-Received: <xmr:jQcHZ0iTuJ2C2Ilsw2coj3KXzip5VhZxegvG2ip1lW5JkJ-ahiuajz0JP_SPQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jQcHZ8_RLHf52iWpbcQchx1K9RWckZ0DhZENUZinJC3Phfw175z6gA>
    <xmx:jQcHZ3sTrSsHcr26OavMDaGGG_yH-ldtIPpb8vNNooUMRi2DHg90QQ>
    <xmx:jQcHZ7FpfDjVoJXqPf3tKM07Rq_mGv1O9TDNmCgLkj8wHfmDgwkDrg>
    <xmx:jQcHZ-OXtzNoXyl8UEJYUB1s5QaN9WydLNaEi67ozaN4n_9TSefiVQ>
    <xmx:jQcHZ4Nqlt980UO_G8oqq1d5lnEGVWTH9ALMJlhB4OCcbP8I_MLPB_LZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 18:45:33 -0400 (EDT)
Date: Wed, 9 Oct 2024 15:45:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, mingo@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Use info level for lockdep initial info messages
Message-ID: <ZwcHitGNM0cDG5M5@boqun-archlinux>
References: <20241007065457.20128-1-jirislaby@kernel.org>
 <8d2becc9-a8cd-4352-a338-7fadf9460793@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2becc9-a8cd-4352-a338-7fadf9460793@redhat.com>

On Mon, Oct 07, 2024 at 09:05:25AM -0400, Waiman Long wrote:
> On 10/7/24 2:54 AM, Jiri Slaby (SUSE) wrote:
> > All those:
> >   Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> >   ... MAX_LOCKDEP_SUBCLASSES:  8
> >   ... MAX_LOCK_DEPTH:          48
> >   ... MAX_LOCKDEP_KEYS:        8192
> > and so on are dumped with the KERN_WARNING level. It is due to missing
> > KERN_* annotation.
> > 
> > Use pr_info() instead of bare print() to dump the info with the info
> > level.
> > 
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >   kernel/locking/lockdep.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 536bd471557f..ae8750157099 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6576,17 +6576,17 @@ EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> >   void __init lockdep_init(void)
> >   {
> > -	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
> > +	pr_info("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
> > -	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
> > -	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
> > -	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
> > -	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
> > -	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
> > -	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
> > -	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
> > +	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
> > +	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
> > +	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
> > +	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
> > +	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
> > +	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
> > +	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
> > -	printk(" memory used by lock dependency info: %zu kB\n",
> > +	pr_info(" memory used by lock dependency info: %zu kB\n",
> >   	       (sizeof(lock_classes) +
> >   		sizeof(lock_classes_in_use) +
> >   		sizeof(classhash_table) +
> > @@ -6604,12 +6604,12 @@ void __init lockdep_init(void)
> >   		);
> >   #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
> > -	printk(" memory used for stack traces: %zu kB\n",
> > +	pr_info(" memory used for stack traces: %zu kB\n",
> >   	       (sizeof(stack_trace) + sizeof(stack_trace_hash)) / 1024
> >   	       );
> >   #endif
> > -	printk(" per task-struct memory footprint: %zu bytes\n",
> > +	pr_info(" per task-struct memory footprint: %zu bytes\n",
> >   	       sizeof(((struct task_struct *)NULL)->held_locks));
> >   }
> 
> Make sense!
> 
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks!

Queued in lockdep tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip

will send a PR to tip between -rc3 and -rc4.

Regards,
Boqun

