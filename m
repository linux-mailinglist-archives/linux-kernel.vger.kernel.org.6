Return-Path: <linux-kernel+bounces-388917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C89B661D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981821F21A78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EDE1F7091;
	Wed, 30 Oct 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILNkEIk3"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639211EF0AA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298891; cv=none; b=edpSFN+BglcdOHHjNtucxyVeN1TXoXlMtxfRv90yY7yhoYHniCiCKeeGJpwXO+1vwrSN/P7zMYVnprbLiZILQj4aBDRFkbSO7DJTn7+h6cJ8AO5FeaHkEh6bFrxq4Fdo5EjXygHTUQEyuZ27yVcrIFycJKD2WpPPTrQvTsbqfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298891; c=relaxed/simple;
	bh=Eki/8PUymi3DlYn8iy09FHeO7F5hi7LYw3hNSmdcLP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utkmuUakGWcTU6hrh7TkH3bqQiOFdIHbtyI9b9GQ2EqREWQ4NgChwK0rpQZ6d75eqJrHlFlloV75qr+acyRnI4cRGtFT9hEX53VtyJrVIV88ZDrRnZ8w14q/q4EPfwqaBlm51WS7j225SWVUVVXNgVEp8vLY9/SK55jUk9Ii3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILNkEIk3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1488fde46so511815985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298888; x=1730903688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tFvvK4S+XscR7M4udOgSSj/lik4hiG6acvCg0+VWJI=;
        b=ILNkEIk3jmoCYRlpn057kQX+J09Rwm3EKG8j1gTz6ucczpgRTE4m4uw01xm1ww490m
         d36c82DOXMSQ7iwgkjCOdIQNRDVx8auc6SSkA3KEyhwMeVJ3eNEnokpbHdKabUroIqGt
         5Axw4K5A6ePEPnkJe8vDq84G3slYpVXu/AQeg/AfRnJlqtzlVrBW2uhVnlHy7HFnfaub
         dNcsEnjrgn7tvBTCgi6Hw7LIv9CCGAml/L/Ry7bhsMBBabHoeC64NCU0sanDM+WAYkHD
         CK01cbNmqHdKCOUUxBha1TiO3uoaN2rq5wULB9YsG/jTFAyJ4kChPVd6vo3cjE35FZYL
         Gneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298888; x=1730903688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tFvvK4S+XscR7M4udOgSSj/lik4hiG6acvCg0+VWJI=;
        b=Ht7GsGAjj8qaHUsBbNzmZU9TdLOK3656hZ0x/dBf7jWvgTH7KwyZg4oe/kbkkLDzbj
         V1mQhSM2nEs4pt/7OJn8T6OUm1g4bZwFJctN/5+ntbY95nhK9Mnlz5WENyGU9+vxhy+W
         SEO0gbUSTJ1PrkCzgcD7gh4YIXmeJpm0dLjZUyBhiiZ+Q2Bzm2/oRxbIrbsMaJT6meZm
         0W8rzQkea+MYbNy9RebgmIiVSufgOF1N1BzQxrfKeJvLJWBlcsg39XKVTpxMMbFjSi3X
         bXLISaLITj5Mv/lQSg31A8R0RpFuxTtScM5gqiUgHuj36XUIRQI8M708qzwUE1zc/R/f
         2iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIvCogDSbPtiL4J5qYuoUuICLVHi5lj79I2gA5+sZXzkwsWNWgLA4iKhkBhOdSUEbPAT1xVYwThKm1CFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypM+iOI/7nawFW3ykxQgbcJLPFR7aj2hcaOvsZuvQ1QwUkA/Ws
	EuLLa0rDeM3m8Leylp1ifnEDKKidLoiEsDxebxN1s2syKh2ciTqF
X-Google-Smtp-Source: AGHT+IG0Ti+K1kKXrP3qgmIck8+gSErpC9BXLgDSa6X9NIGc6jzs3PudVoJcoOs7EWCFRYro1j5onQ==
X-Received: by 2002:a05:620a:2482:b0:7b1:64fa:3696 with SMTP id af79cd13be357-7b193f4da53mr2158067585a.51.1730298888056;
        Wed, 30 Oct 2024 07:34:48 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d345a9fsm512998285a.103.2024.10.30.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:34:47 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 10F441200068;
	Wed, 30 Oct 2024 10:34:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 30 Oct 2024 10:34:47 -0400
X-ME-Sender: <xms:BkQiZ53SLYzteVh5JLuUEcFgxNqaUr5ucU-XxkiQLB8Wx7NmdyTY_A>
    <xme:BkQiZwHXbXHwNFEYFrbwPxgPFpBFl_oFruEnILwZLo4QEsXBxWJBtqgQ37EZurnMJ
    0qTKKH1KVAnUozQZg>
X-ME-Received: <xmr:BkQiZ57JOwWUdxZpBbmBTvOgn7wm0Cs2-cvO7-2C2zm3vcXTa3JT9tD6nlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghsrdhosggvrhhhrghushgvrheshh
    hurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurd
    gvughupdhrtghpthhtohepphgrrhhrihdrrghnughrvggrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrii
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtph
    htthhopehjrdgrlhhglhgrvhgvsehutghlrdgrtgdruhhk
X-ME-Proxy: <xmx:BkQiZ204JBjXgjffr6FvULrOwE84rA9bptikS63c5W1bYoKH2V-S8A>
    <xmx:BkQiZ8G43Zi4wdhl6G1mB9XKzvaJmk8tAeitF3M2ukUcyndIJ8_5iA>
    <xmx:BkQiZ3-sN3tuQLBhUgtaPyPkWGIH_mNqFx_QtZBSGZSR4YkbgbuS0g>
    <xmx:BkQiZ5kdYBVr1D6kfkyRMNzOsq_uKzZhjbNVvpt05RSRf77Zi_spfw>
    <xmx:B0QiZwHdQHRH6NbsqxCDRtYQ8Eri98fYpoGe5cFw9kGA_gl8L52nCWXz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 10:34:46 -0400 (EDT)
Date: Wed, 30 Oct 2024 07:34:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
 <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
 <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
 <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>

On Wed, Oct 30, 2024 at 12:38:26PM +0100, Jonas Oberhauser wrote:
> 
> 
> Am 10/30/2024 um 12:41 AM schrieb Paul E. McKenney:
> > On Mon, Oct 28, 2024 at 05:15:46PM -0700, Boqun Feng wrote:
> > > On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
> > > > Not all tags that are always there syntactically also provide semantic
> > > > membership in the corresponding set. For example, an 'acquire tag on a
> > > 
> > > Maybe:
> > > 
> > > Not all annotated accesses provide the same semantic as their syntactic
> > > tags...
> > > 
> > > ?
> > 
> > Jonas, are you OK with this change?  If so, I can apply it on my next
> > rebase.
> > 
> 
> I'm ok with an extra s after semantics and a minor rephrase:
> 
> Not all annotated accesses provide the semantics their syntactic
> tags would imply
> 
> 
> What do you think @Boqun ?
> 

Yes, of course! This looks good to me.

Regards,
Boqun

> 
>   jonas
> 

