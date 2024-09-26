Return-Path: <linux-kernel+bounces-340457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052399873AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830A81F272A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3411CA81;
	Thu, 26 Sep 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+MZZeDh"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E36179A7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354090; cv=none; b=ELyblGIswjRV9EGRPD6phym1nBau2DkvwkMyQUewK9jLpggz/eaRbvlJe+YPW94GzcsbxGqYkUUu35AV8ylNEaB1j8M6SaQPM4xNWjZsQotT+GHker6jXuxF+nWrHTXT8uH/xs8L2ePhi2qdAv9LSC2jVHqTEw5x3bXEZ4tH14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354090; c=relaxed/simple;
	bh=R+AVNuX7PeYNeVcTYh9MlS+PE88iVKNLvuUPNyPnYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db9e2GivOfM3HXb2100YDsWPbNm0Gn52K5q/aOO9lMksHF225zNyL5Fv/w4YiTM2NP65Lb6JLqv13BvXdrlM9eFcHOhQsrPqZeJEdw3BadUzFVCJIhMJpcdmfVfMuQ6PXtVsxUG1IZsXSJaTA+vKQrEklBYH5qLhhLEVJ625pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+MZZeDh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4585e250f9dso4348701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727354087; x=1727958887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mK6odaXRz60I1rRxbik+9gCy6tGx5/Tz5tdyicGSfdU=;
        b=l+MZZeDhvIryr3RwksMJiBZjAFOk/og9yooMbKMLMITv/5JddqgSrj1ERtkuR1dIuA
         5pXtLDtDI7DZ6e3cDz/1NqyGTGoTBbBscRjAZNTLCzGYAHgvDT/ehxq1DIJ75tgSADaT
         tcDI/GY/lyN+xU4wtzqZ5gOcQJgRBt2l8K/C5VQ4alKkroVMLHWy5XDOocQi00OrFSqB
         GBGaWbw4f4i2PkbMs/+H+CjAEFWK/Q7E7t1q3h5LUeEkk+RImJtLcNCOjFQBILUhq58w
         /ZlSmpw/MR45GwQSBcDLS/d319l+Z9yPigh2mfx4YDFpMYBJmcjMIB3fTqSFLSLITxJC
         OMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354087; x=1727958887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mK6odaXRz60I1rRxbik+9gCy6tGx5/Tz5tdyicGSfdU=;
        b=l3FsGILaMGO0g8a/jraQMvIWH+rRbyxIJrzDqmmpX9yId4jhPZ6m8nlGFh+zaUWKqE
         l08wfmEzArtkQuMosma1GuzenwNiF2NRABxWt+4JconGP70Q09O20MrdcMjcWpl1PHXj
         v4AW6/qEwMuW8+xF1ojIzwk025hAfiUncD81UROXotUlcIYBCBX4Nq6+l7xNEQpRe/OZ
         s2CPQdSOK1gs9O7UcA9+B9C1vTUM9QHATmBcFBtdEhJzk69dx6NNI0lkCnp7h/AIw1Sm
         1otd3MZfUuzdIDQsn3K7lkb3/4b7neexFuP1dhCONRKZuCKG8rgtVhwGs+B/T+KlRb0t
         mlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCEwnU2awwVTvubY+1JtPO6O19eDCskN0uACof6CWCj9r6iz5Vkw4rLn5pB/Pdqr8ErZ4hVGlb7rAtRV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvR+fPlTcmQoQZ4cIeNmr9PKR+whBWHaZu/IUmbk3nLDHzpUpw
	BjUgYmkMWWn2X5pvbEuxJtCjuoaMJtgSRQO9JHMjnBUex/zcxiEz
X-Google-Smtp-Source: AGHT+IHBeMmmMU5b0xGui2qfhKVafApU5IL3Kx5FZ6xy1eEWuyfdR/Nk4Mdu6yUyWNAB0ySzb+QgOQ==
X-Received: by 2002:ac8:5895:0:b0:456:7e2e:45ef with SMTP id d75a77b69052e-45b5dedf228mr75060441cf.16.1727354087341;
        Thu, 26 Sep 2024 05:34:47 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b525b517bsm25410541cf.51.2024.09.26.05.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:34:46 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9BC971200043;
	Thu, 26 Sep 2024 08:34:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 08:34:46 -0400
X-ME-Sender: <xms:5lT1Zt28D7d-1GjcFe8XokEywROzK3hj23ABmuVZDALaSW3cOqEyfA>
    <xme:5lT1ZkEUFB82EXax-K8heyjCUG7X2NRX75tzZquKJvrmpZLjnYdYAAfd6YHmW4BZs
    T6HnhtKIi68xTU17w>
X-ME-Received: <xmr:5lT1Zt5dC0ekNa_2A91HaS_qa4cJNzzMf4ctejpbiGZUlpwO4pNc85TU1FxaiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnheptdegheelveffudejffegvdelgffhhfelkeei
    ieefgeevteejvdegveeuffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufihmfidvsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhr
    ohhsshesshhushgvrdgtohhmpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmh
    gv
X-ME-Proxy: <xmx:5lT1Zq3Xt8d3bns30PriRuRHw2WrpYxVDdKKy0wbIfzKgLFlL8umCw>
    <xmx:5lT1ZgEHzEqKBDYKuMrswjX8LyqJeudKN_Ub7A-jrHZHcUkxoRwWdA>
    <xmx:5lT1Zr99_PopXNFSgkUrmmReyIZydkTGZQE4oXV-D0hYFMH_XgOblg>
    <xmx:5lT1Ztm1LLcKYQRxOOT0EHm4x0okpuqwTxskZEUE5E50u8IlhTGCTg>
    <xmx:5lT1ZkEwJwSxXnBwRKhYfoRJLc3aA8WcpOjNrdgOJNxXPfiTYOZWaUlD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 08:34:46 -0400 (EDT)
Date: Thu, 26 Sep 2024 05:34:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <ZvVUuOq7dLd6_f09@boqun-archlinux>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
 <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
 <2b8c36376fa01fa6a1bac9570eb7d41e7e232a29.camel@infradead.org>
 <1da59ef5df8e8a2bebd31535fa13264113a316ff.camel@infradead.org>
 <ZvVO3F7BJW7OwbEg@boqun-archlinux>
 <ec2ec6b7682b33f0ddf06c3d3c2e23c9c5971b67.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec2ec6b7682b33f0ddf06c3d3c2e23c9c5971b67.camel@infradead.org>

On Thu, Sep 26, 2024 at 01:16:32PM +0100, David Woodhouse wrote:
> On Thu, 2024-09-26 at 05:09 -0700, Boqun Feng wrote:
> > 
> > 
> > I think this is already fixed by:
> > 
> >         9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()")
> > 
> > , no?
> 
> That patch fixed the bug.
> 
> *This* patch fixes the fact that lockdep didn't *tell* us about the bug.

But I thought along with the above commit, Peter also made it possible
that objtool can detect leaving noinstr section in the offline path? Do
you have a case where you can alter hardirqs_enabled flag in offline
path but don't hit the objtool warning?

Anyway, the commit log needs a rework.

Regards,
Boqun

