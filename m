Return-Path: <linux-kernel+bounces-368488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E813D9A1062
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A26C1C21566
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD5210184;
	Wed, 16 Oct 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpjF2nMD"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C918660A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098746; cv=none; b=pA8ph2UvgcGXn+cqWfELoUajEqc/1yktunciutgX+VzGSdCFyLHZ9hlTBMCO4mijIYS/vlmtR8x1gygAkF+SVa5YrlLJkenoQV1EKlbiOVbHUXah3qMn6LDoVy+3Yv85BGQUNcOU19CVOvalnbR7ezH1ECvM017B+V3bYWRcrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098746; c=relaxed/simple;
	bh=8FCmOy+sNNm3ncKEkoMcHoJ1hBTsi41gpgKBsf12DzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUXMZEpcui63ZQSZtb4Wv8Z1KlmxxwHKbLHUjMskRh32mo402NYGSK3WuJK6PjodMMakqGQLfG0K2dJASCYsNjAJI0fCrQ+lQdwKiN6l37opcJWs5B4q/ahcMJUJwnrnsg5SWqrFAnk3BCtgGocy+9WaBaG4AwreywYnyd0jS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpjF2nMD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b117fab020so5703485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729098744; x=1729703544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDw5CET4Wn2irdms8nAGtAOJ9ALGwQBRH1hXBGlKz1Q=;
        b=fpjF2nMDEs5XfeWJ8k/OYBTC/NMK6rhmfd87WzsCzznvrlypvtT132s7LOk6w93uoh
         VAAKI1lserLJuBsWetVIkAQ70+2LdVLGgzMjnJ9lV8x29v/kx82g3onRxQrh9clD55GO
         0Xg4mgWF97L63yE+1OqpzOg1Utr9KcQLf8AWQMs3CX0M8QyxMo+yL1dofVktq43FwZOU
         P6sosRlcliMKhocduaf14MB54Qf94Qpllv0mbR+qkAnRxUJCPufgu/ejsuRuT7VqGPmF
         bwuRhXU3RlKUcQWSWpmztc+YkYpJB59wAHUsO9UqA47RD4xDh+aBydp7LoczGJG20erF
         yURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098744; x=1729703544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDw5CET4Wn2irdms8nAGtAOJ9ALGwQBRH1hXBGlKz1Q=;
        b=Z2+pLXIJ3NVjlmio5OVVXPj4oL1kLo61xMVNQjEn4opLxIZtrxXiAJFUEzE84EP8sy
         5QmacGsnh/o0wwcy/HxT1jqgZl5szC1Mw4xJcbzjWQ945zhxbdnsKbEccLX2oLaeKzzE
         mCnTN/RKByQ4HR37wGKy2B2Qq1isCL6neljZ60QgM8KJ+aw2jHX3B/9WkH6mufUBelXC
         TvqoVZP/Ax08tT0HR6U/0SgWOWMPH6gKfKbwvW6MDpVRfvgDnGYSG4h8QWODvrK3G2FH
         WGN3HWjrCK2+UMrE2VUqp1TsnjFqhF2pK2zFjCzbzYXIHAQhprO0xqdXh5DgW7CNEE8v
         dkvw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSkq9h//Yr0Yfd7prNOUl3Yl4utHqNFFsc92oKPhhtg2LPJdWb8wvrl3iMmodgzkukYbLY5p0u25CNNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyztNdayja5b0xcT0TFCjHeZmppJvYt/Fv7LjgtUmVlvXl4a81f
	yqzkRorSKSOj+3hEJXZiGVeqw22P2ed1DHhT/Hno8O33KXiQNACc
X-Google-Smtp-Source: AGHT+IFZ3MGkp6pu06I/SQifhf7IL5905+DLPEdIRaBkpNinqRAdXE/2uh9rFD27+PcdRFQ+MW/9jQ==
X-Received: by 2002:a05:620a:2684:b0:7af:c632:dac0 with SMTP id af79cd13be357-7b12100893emr3008154985a.50.1729098743561;
        Wed, 16 Oct 2024 10:12:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1361661fesm209276785a.11.2024.10.16.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:12:23 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 878EF1200070;
	Wed, 16 Oct 2024 13:12:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 13:12:22 -0400
X-ME-Sender: <xms:9vMPZ4diqAOMH0KL40T0lqQ6pbY2L89neeQfaE4U_Z_zLZeyHYpI-w>
    <xme:9vMPZ6NZoQVivAXT5KQf8zGfMwPPu3Y69Omsa7E8SS9QegIOAient2mCPRROeHn_U
    A59oE7nkgfjXYNDXQ>
X-ME-Received: <xmr:9vMPZ5j030-43YgXkSTNB1utINefPWWJNFlgYpk_IRoaqZnT0cNSKxBBP2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehinhhtvghlqdigvgeslhhi
    shhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehpvghtvghriiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonh
    hgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnheslhgrnhhk
    hhhorhhsthdrshgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmh
    gurdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggv
    shhkthhophdrohhrgh
X-ME-Proxy: <xmx:9vMPZ98gH8mHBf3SkD01Mzeya0JOYRAdHpKaVAK79pk5ActtZ7WZCQ>
    <xmx:9vMPZ0sdoYVujZ3fBf80WV7ZB3k7L-mB7f5j2ya7JZTdQGRfLmj3ew>
    <xmx:9vMPZ0F39TGltIGg2tumc9mJzaQ9IUg8IiRKfLZKRg_yiKFnPosfpg>
    <xmx:9vMPZzO-MY_hLaAgrCLYGUuxTenWmZxq4j4akzAKvVDA1S2gn05BdQ>
    <xmx:9vMPZ5OaxEKMCIb5pWgWeVHz4bTG0sHVFfWhyA4f0NEPrqtUKx2odSBH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 13:12:21 -0400 (EDT)
Date: Wed, 16 Oct 2024 10:12:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
Message-ID: <Zw_z9FaTiXV090-b@Boquns-Mac-mini.local>
References: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
 <Zw19sMtnKdyOVQoh@boqun-archlinux>
 <bf7632b74c075f2c430fdb98cefed486b4d9e74f.camel@linux.intel.com>
 <Zw6touohNwfqs3T0@boqun-archlinux>
 <ee955c4d3e63edd3d1e37b6467bf01c2c4efc827.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee955c4d3e63edd3d1e37b6467bf01c2c4efc827.camel@linux.intel.com>

On Wed, Oct 16, 2024 at 08:17:50AM +0200, Thomas Hellström wrote:
[...]
> > 
> > So even though first_lock_dep_map is a fake lock, it has to have the
> > same wait types as a real mutex.
> 
> Understood.
> > 
> > Does this make sense?
> 
> Yes it does. I'll update to a v3, and add a Tested-by: tag. Would you

I think you should send a v3 then after I test, I will send my
Tested-by.

> like a Co-developed-by: tag as well?

It's not a big change onto yours, but feel free to add it.

Regards,
Boqun

> 
> Thanks,
> Thomas
> 
> 
[...]

