Return-Path: <linux-kernel+bounces-440298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787379EBB70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3812E188A2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853EE22FAF0;
	Tue, 10 Dec 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="BmQFvdou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeINNwBM"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648E22FAE5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864580; cv=none; b=dyUveAmBusCc72GOmBygzfTgInnlV2kBrYkM9TwG9GQWkZHoPAC3Bn2baTcZjCWgMjkqSmDRjILu95/R0iedpoolV51yVC4XOcNyIU66JcIlZ7iZ7Zh4QofEQ+YIJPzJWiw5TBtw23AFrRJJyIWvM7Ns4KJ0fJlymZ9VhDAVKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864580; c=relaxed/simple;
	bh=sMA43z1pHtWfKgyNwAGg2bn1qboboGUSysxhn23q6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSISgMf6dFEXNy820YZq+GPH2FNMBzcHl2k/wXc8pW+r0CZf53WW9XYlRZieLlkKdAabtX4PXl+NOadyN+kKBZI/dHoRpek6fVhXO73RIobJ6XVtsSqps07dUKvoxrW/CguWzXG+WxzoSa34j3OZR/9XS5XY6es6m7eBqzoM8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=BmQFvdou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeINNwBM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8AFB1140189;
	Tue, 10 Dec 2024 16:02:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Dec 2024 16:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733864577;
	 x=1733950977; bh=cvIpCuby3ro0mmgyl04g1aBoFZDRap34/7T4STu0lRs=; b=
	BmQFvdouoRS+E2OcdTg92ESW77mqlZBvMdH45S8fpyTWl4NWYZ9guR4GXiHYRXfY
	UejPDNH4LEQ7aSQbhRqVnktq+RRuAwuIbosk2Ni/OEcNZawdIENSG/cudYPnlbCN
	BGnVjV3lGkOXQ64uV4DnmZpuQZipAZfFVXimr8u2RF4W7Qw/rJoRQ1KRv4BxPn1/
	2/fLV1Nb5Luk7mfqzOlKf08LJKv3Z1P1pngBMMHjrIc9W12rRQ0WmDNCP6cGoNCj
	iwgD/Xc8HAyrcUCq2t1N64PDCtI81U01qBZC/izVjZdH69hkHDEhNWUCwobmtlHp
	pjpefYkEzHZ9kPITpnJrxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733864577; x=1733950977; bh=cvIpCuby3ro0mmgyl04g1aBoFZDRap34/7T
	4STu0lRs=; b=jeINNwBMFoiml6QHGY11jNXVlRh1HLz0dMMtKu/Z/okTdVwcJSn
	+YW0cDRvDnhNioB9xdzCjjzzNajCq3aiGpMWN9vT+L0RmbQorXOBUrLRM6isagmg
	AgzoymzJKzYk3zmqmEhsCOdKHcQKgpqhXSNoMFFMjoqMbPjt3QB6PYnbPPYFNN3p
	Elzl7PJ0IgV+A6Asz25sB3mQmjA3OnXmQ/PeEm0pA9Mm5ALLquU4m5EIIgYs/sDo
	m4Tcs7EwMaVzvNJ4ebMgHT0bIrmwoftVv6qOFZoRUyvRj+fHP8jQIYJH45bhkLXS
	IyvDkbxwuIjHlE9rtj2Et9OA16ktGHZ0tvw==
X-ME-Sender: <xms:gaxYZ3PDbwT4t7P4iEyai5yAStUrqv6tnJrrjeGDMGjAWlLzSKrafg>
    <xme:gaxYZx-mKX1EXka84Gs3btlcApFhkRLRDNBjXU_Mywg9VqA1De5TO_PFKPeixDL5J
    Syx-xqzwVnXqAXBzVY>
X-ME-Received: <xmr:gaxYZ2Tt77Pk9ziIJq1v-5b4Y-myvFs7RiG4pD_hlEW6L_OxgFWoWZLo1PKubt1ef_bV1nwjzYdlO1fNAJkrRhvzIfcGsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplh
    gvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeef
    geeufefghfekgfelfeetteelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepthhglhig
    sehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgv
    rdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhphgrse
    iihihtohhrrdgtohhm
X-ME-Proxy: <xmx:gaxYZ7tXgwGa3p5YIs7QxrBNiqgt1KD-ONkUnT9DvALAoBNYLDH2Eg>
    <xmx:gaxYZ_cgZuzkZQPlz4EnEGRs4t-42VqVZAlBg4ejpPwK3YJcNYJsqA>
    <xmx:gaxYZ32PtH_-PychmseUqtyMod3w2ILczxDfgPi6ad_27O0MyHKxog>
    <xmx:gaxYZ7_3pLj5D8t0CnDNSoIugyAqL34Rmv54KpTmBBsk8F-t7u7kNg>
    <xmx:gaxYZ91lCrXz5UtejGvpSztUjGU-1f-Nebj1-1rtAVtp5suq9lZLvN8c>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 16:02:55 -0500 (EST)
Date: Tue, 10 Dec 2024 13:02:54 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 05/11] x86: add CONFIG_X86_64_NATIVE option
Message-ID: <Z1isfhgmZF6UxvkH@localhost>
References: <20241210144945.2325330-1-arnd@kernel.org>
 <20241210144945.2325330-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210144945.2325330-6-arnd@kernel.org>

On Tue, Dec 10, 2024 at 03:49:39PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As a replacement for the obsole MK8/MPSC/MCORE2 configuration options,
> allow building a specialized kernel for the local CPU, which is useful
> for users building their own kernels, and does not require maintaining
> a list of possible CPU options.
> 
> Between -march=native and -mtune=native, I pick the former in order
> to give the best performance through the use of extra instructions,
> but at the cost of not being able to run on older CPUs at all. This
> creates a small risk of running into illegal instruction faults when
> the resulting binary ends up being run on a machine other than the
> one it was built on.

Setting this option makes the kernel build non-reproducible (as it'll
build differently on different systems).

I personally think this is a little questionable, as opposed to having
well-defined optimization levels that are tested and supported and
selecting one of those with a `make nativeconfig`. But if this does get
added:

- Could you please document in
  Documentation/kbuild/reproducible-builds.rst that this option should
  not be set if you want reproducible builds?

- Could you add something similar to the config options LTO uses, to
  make `allyesconfig` and `allmodconfig` turn this back *off*?

