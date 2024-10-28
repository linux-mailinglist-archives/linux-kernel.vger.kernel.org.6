Return-Path: <linux-kernel+bounces-385967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548E9B3D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE201C21458
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF31EE023;
	Mon, 28 Oct 2024 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSvXUIFo"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC41EF0B2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153752; cv=none; b=bvguG1n3mAL9Da0q2Gx8CMMUOI4Q5AOIyzfz92nZR+PYaPOT+3zcLbPWNPCVaU2Wmhdl3RM1aau6zsA8H6y6DENHy2YLPqiZYLfcPmAIJ4mcfjWawCsy/0Q2rZswKhaGEzHmSWzoWhwhVCTrM2cpNgwO7v0qA+HN3uL4wnAyMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153752; c=relaxed/simple;
	bh=93x7XUoxtSEwy52pjeX3Yoy196QE5Gq9af5kCceZ+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itVGSbYpsktJS28TjopSb7/avQcOu46bSwjiMpFCz1xPE81+vLrhqBw9+kK1/wMvzxjXEKvsLVhQIpKVuKb9rTgfH3wLzQ55Fh6feYAxQifQRIweNNK5rIUx7elQKLTzEfNEz3Ns4bFbJZuE7BDkX+EW+kNzrncDD6Md/diSn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSvXUIFo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so26427856d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730153749; x=1730758549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1frDOT0Vc6s39lihRmJVEtRPGkM51unrOBiKXuDMNc=;
        b=JSvXUIFonEXmZzMXNrTThrTt34M/nHFtkpdHWP+uzMXGhKnQS/s6hzRCE9KZHBTkO4
         SFi/Of7Oi40prvBU81hKUtisEejpO8rUCuevnmFtAiqZQmiimWJ8vnoj0hFDgONGKdnI
         IFt4FXpD9lVt4g1P5bTJGloLBtU4nkrNIYpH6dxifiP1Yvo5PxzBdMXz6zr0uabXq0WR
         FM1lW/PIOVZjkPTqAez7IT67JyApGneGeFjUGPzqUHQ3IFZlbwZkQxov0Q8c1zwAJzyh
         rYnvggESe1wdVe0vY5buTBw9BZBdj8ILUeaHSrL4yqs7WqbcR5LvXyH1KCXsW2V2hFbA
         XxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153749; x=1730758549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1frDOT0Vc6s39lihRmJVEtRPGkM51unrOBiKXuDMNc=;
        b=AYN9wZ+2qUKu5wcX1uuJL88lgyXRD4J16jbEy7WrE1wPj6k7XpuMca3eFcOFh/awfT
         U81BSxDfdIPZZzR5fSFken4KWK0tpfWoNUArYfZxD8WjGuqgssSakMjXHx1l6EFtFmVC
         O4SCdD2vNaGJ2tD1GiPoG95Jztm94C2hucFl0UrJq7I0vHDvanbYip++v6kLW2X35lAP
         1WF17VdzOImjjjmsLkENpxA3aMPWX4+0iuEgAI7ByFNGHxBdWbSOQy1YCFQwDZLmQaK0
         apBLRdQp3Ym9OjLq+v/vv9lZed6cWMuXDWADmPVee2pegYoV8WtcThPjS/FGgEkojZxR
         Ksgg==
X-Forwarded-Encrypted: i=1; AJvYcCXs4ifc/6lP4v7tKSN7k7LSfr10KAPleooMYoWvL5jWqPd4cdzaUQzeLHHr/wO6cCz1weO484NGPF0Nd3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg4maZrorgOllVW5Vw8hfsnNNP4TOyqIWPVXLtn+Z8D4/zcnn
	fjpq01ER05t9UAOVwf8BIiBvM1tXn+NFxkZRFunVM8pjAbJH2Kp0
X-Google-Smtp-Source: AGHT+IFn0biwhHu0i83fiZHCcvEnbSEBFJyzpA6P21DkiCxruAQ/6aZvWKhlv93rxUhIvPfRWn6mug==
X-Received: by 2002:a05:6214:5248:b0:6cb:ef96:c79e with SMTP id 6a1803df08f44-6d185843521mr179869376d6.34.1730153749058;
        Mon, 28 Oct 2024 15:15:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f639sm36623586d6.7.2024.10.28.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:15:48 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 327A41200043;
	Mon, 28 Oct 2024 18:15:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 28 Oct 2024 18:15:48 -0400
X-ME-Sender: <xms:FA0gZ0wBFrHv6RyF3osZ2lrWCR1CPbOlBOBjYaPay75h2Un1Ic_epQ>
    <xme:FA0gZ4Txjo1XVtgKE51h2aVW88-HIxfIySoYPBU_46Nb2q47bHQF_Q1QWAo0oOkEl
    7gOVOX7M7sME_SWkw>
X-ME-Received: <xmr:FA0gZ2XF6cc8qeOvlrmHau0oiYNJRoTeoUKr44J7TqYhUBlt9AmtNkwYRgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrshdrohgsvghrhhgruhhsvghrse
    hhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrug
    drvgguuhdprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghi
    lhdrtghomhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepjhdrrghlghhlrghvvgesuhgtlhdrrggtrdhukh
X-ME-Proxy: <xmx:FA0gZyg24fnUdr7ImuMvJEQKSU93yLgnZbOYOa45uKQyBpy3qLSdkg>
    <xmx:FA0gZ2DDr5TbySgEGZpVYUTQY0IFA8fmrP6Kv2-PfmMapfZshfmVaw>
    <xmx:FA0gZzIMxRXzveHwZqBlfIgjqQqpcW4f-7Kt2blUqw6o0sH_QkcL0g>
    <xmx:FA0gZ9CukFoVcRGZu8_45IVJArl4ueeiEivEt0GkXkJpXkQru6ZXTw>
    <xmx:FA0gZ2wbGh26iSBlfTU2KNBIu3qxYL66nE8lhkFhW_8lP8W9hDr_HqdK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 18:15:47 -0400 (EDT)
Date: Mon, 28 Oct 2024 15:15:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com,
	Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: Re: [PATCH v4 3/5] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
Message-ID: <ZyANEod5yRL2qq9e@Boquns-Mac-mini.local>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-4-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930105710.383284-4-jonas.oberhauser@huaweicloud.com>

On Mon, Sep 30, 2024 at 12:57:08PM +0200, Jonas Oberhauser wrote:
> Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
> around them. We emulate this by considering imaginary po-edges before the
> RMW read and before the RMW write, and extending the smp_mb() ordering
> rule, which currently only applies to real po edges that would be found
> around a really inserted smp_mb(), also to cases of the only imagined po
> edges.
> 
> Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  tools/memory-model/linux-kernel.cat | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index adf3c4f41229..d7e7bf13c831 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
>  let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> +	(*
> +	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
> +	 * though there were enclosed by smp_mb().
> +	 * The effect of these virtual smp_mb() is formalized by adding
> +	 * Mb tags to the read and write of the operation, and providing
> +	 * the same ordering as though there were additional po edges
> +	 * between the Mb tag and the read resp. write.
> +	 *)
> +	([M] ; po ; [Mb & R]) |
> +	([Mb & W] ; po ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -- 
> 2.34.1
> 
> 

