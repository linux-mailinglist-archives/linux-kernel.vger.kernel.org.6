Return-Path: <linux-kernel+bounces-402139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2E9C245A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0C1F27D65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3826D220D67;
	Fri,  8 Nov 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzgqKPHp"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321B21B458
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087972; cv=none; b=BLgku/pHLZFkEiylEqTGxbv8IAhpyv3ikutw+QcOhydUruf2fVBthv3TqfE0o6LKBfCg+wO10HZuCLAUjejIBfIGQV97lN/XP4k5Fi1YRWnidACIPikWBWbWrKx9c+ytJ6wWTMdHE4+zNbReCOMUsNsO6djX42dflGwGe0HNVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087972; c=relaxed/simple;
	bh=ZpJNOlGrmWO0f4xGsPJFXSgwDxFEoJF/0wZ709WIbP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6a/urbrjw43Ljlwa712sN0xH+48U78CrOGPaac++fxwFRZBGdX1FWb5ly+XQMUPcZamalVcJ+AutzV27ZnimZVS3DQdFbHxdMmecl0yqdEqTk9F8SQCIixnxfaHXnldrA9WTMXxC1KtmOsR0cnTSXrNETNLMpTKTbjqtxbpMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzgqKPHp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4613162181dso14617551cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731087970; x=1731692770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HigXSvE1YCLW2Udt6TV+7TWMr4D2/j3S3P0/mBJY7SM=;
        b=BzgqKPHphdz7A3pvpo3ftsV8x5H9fh1p3WkPpkZJhQM+mfHvSFjdQ9bn8ITVepB2xr
         PiI2PKJju8tbzf2i1VsZCTB78SHWsFlFeu7F5z+kiOiryBTf0hKCIgFGkx5fcM6eTtKK
         FEY8Uq5NIp2vFt96+Iami3jN/e1dWfOkN7iPRWL010CvQMXgC+nPjZJEkUw4xgpsZxQB
         djZaO3k3GoTUOxGL+dpbVSwQS16fsTOHMi0aV7YbVL/eemFmD3RDHXuufiJDJkx+7Au1
         64QQdllAKCZWPEkt45/rLSKhg84hY9JdKndqSTKHqOKeEw25aZ8GGZZ/xJuGjdZBH/6q
         jZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087970; x=1731692770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HigXSvE1YCLW2Udt6TV+7TWMr4D2/j3S3P0/mBJY7SM=;
        b=cWuQ9hjKyW3PW4i1EyJmSn3loh9cLSm61Dc0oOsM6nfMrPBkjSHiN0p+fTcLFF7/sj
         PkniClIk3PUpd9hTztNFmlsFBWH4NuWUjjAiM91VKEvZYs887r1Y4wgbybu6cdd2KWcu
         douyAQb8BWB1ycxZ4DGPcVLHX3kta6ppx8nd2DqGLxHTC7/dYR9CDCokjxPx1pRtsm2F
         iA/ZDAPEg1RtEquvqqtK5J27GziE0XOvJxRDRIDVQLG5uP2Ow7/A4ngaL+q0wpGRTbHo
         8Epmqr63hDWiMxDtID7yPz1FfXlOlXEhPWYQrvDxnF04YvZVbRnq6IKf7Jrh+Y1kKLtW
         HC5w==
X-Forwarded-Encrypted: i=1; AJvYcCW+OQUVh57vmz1FzSuVdYEdoFzt1zbhADvyN5PBVDYE+YOvNPhEkXfGClYHog0FKWZdcsJrhYUy3+jMI98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hBBgnDC3/QBshHJY3NU/ojV4s+WLcvup/mkuF35OnE7YLwYh
	/W9ZTlgEw3ZtGsU97ItJy0WSvR7yPJfxLEnccUg+WHUEb/yCLEjq
X-Google-Smtp-Source: AGHT+IFiBP7IMsW9bRbs55teJzmd+G0ctbT9JOfNQV45daiH2b6XIJeTIikI0hQpgjCCY2hjwuXK8w==
X-Received: by 2002:a05:6214:5885:b0:6d1:9724:80fa with SMTP id 6a1803df08f44-6d39e1a53a0mr49322616d6.32.1731087970039;
        Fri, 08 Nov 2024 09:46:10 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39620d14asm21687576d6.67.2024.11.08.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:46:09 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id E22AF1200043;
	Fri,  8 Nov 2024 12:46:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 08 Nov 2024 12:46:08 -0500
X-ME-Sender: <xms:YE4uZwNc1W3SnnSrNcWZbQdseIs2AX-hR0p8uSBWW19K2MsThKRoSQ>
    <xme:YE4uZ2_7PClqqKc0nE9nLg1dnFDyw2rT4YTsuQtXW__Q16I9YDwHMaKO608aPgBBm
    yjmz8vZKWRk5l2RRw>
X-ME-Received: <xmr:YE4uZ3QgkVw96NvpCansF0Tmq_bbtVV2xpWoSaAQpYOqHs6EyO2ZtX3nzEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtuden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevheetffdvffetkeeuudeuudektdfghedtudfg
    hedvgfdtgedufffhudduhfejueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtohepkhgrshgrnhdquggvvhesghhoohhglhgvghhrohhuphhsrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    ohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghlvhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:YE4uZ4t1xpS1LELuJjk1DgWaeJmtkgPguwfF0H2t2YqRYLp-vz81fA>
    <xmx:YE4uZ4eygsiljrFGmPU6K4BfQ5zfNsO1h5lpaMzBF5UfEyqEzHnk2Q>
    <xmx:YE4uZ83pZfMgXORtu-nCtTMqs1AUZExlYo4_tmduFCuZeYBa1qvtaw>
    <xmx:YE4uZ89LDPSBLdBtLdHWyLJ2B_ZnOQFRVED-36Gidcf6zTLq-lhNyw>
    <xmx:YE4uZ_8N3WLBj3haFsurfLARTigNsU7WTHuv_1Xd7Al6A5Xto9nweh0f>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 12:46:08 -0500 (EST)
Date: Fri, 8 Nov 2024 09:46:07 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/4] scftorture: Avoid kfree from IRQ context.
Message-ID: <Zy5OX5Wy0LsFPdjO@Boquns-Mac-mini.local>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241108104217.3759904-1-bigeasy@linutronix.de>

On Fri, Nov 08, 2024 at 11:39:30AM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> Paul reported kfree from IRQ context in scftorture which is noticed by
> lockdep since the recent PROVE_RAW_LOCK_NESTING switch.
> 
> The last patch in this series adresses the issues, the other things
> happened on the way.
> 
> v2...v3:
>   - The clean up on module exit must not be done with thread numbers.
>     Reported by Boqun Feng.
>   - Move the clean up on module exit prior to torture_cleanup_end().
>     Reported by Paul.
> 
> v1...v2:
>   - Remove kfree_bulk(). I get more invocations per report without it.
>   - Pass `cpu' to scf_cleanup_free_list in scftorture_invoker() instead
>     of scfp->cpu. The latter is the thread number which can be larger
>     than the number CPUs leading to a crash in such a case. Reported by
>     Boqun Feng.
>   - Clean up the per-CPU lists on module exit. Reported by Boqun Feng.
> 
> Sebastian
> 

For the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

