Return-Path: <linux-kernel+bounces-385960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A29B3D86
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1621C212E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97671E1325;
	Mon, 28 Oct 2024 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbdF+cCo"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D917D355
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153480; cv=none; b=jCJTUDripXn+yMN00Ee5AgWdZqzLh5WGzTgHVZe3pXUsfRSmW8shJ5PTdeSCh2rH+1gY6hxYYE2fz5ig84NwFfA+2Y8JNNrh/5MLfswqAndtE1vtYYH7wNgF9MsXMIRHRJzKEQp35XFIYx3ZaZ6Zfiv1ZnEd6xQH4htds30ysf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153480; c=relaxed/simple;
	bh=YNv414Bw4PuqolanvpKCxf7xgq4otF3vXoKVWfQ0Zk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnJ/p8pPK3HlLnOBV1WSd1IdrhLgKhrMM128fHD5z1iIjTgBtcD2VIAC0LORlWvFDE0ZPQmxXg7Dq//PA6JV7Sqc275KUk/IuM564q85wNxv9O8S5JipeccsJ+EMxa0LteK9yzWWNtSKb8bVtcFiFwyCT/XoRyZG2DL3tfx1E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbdF+cCo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso30784886d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730153477; x=1730758277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyhLwh2+OKpbMkdci4HatF+1nSS8uoK4ET9ojs2OKAk=;
        b=EbdF+cCoiBfgnLGhEGaIxkly+ZSpBJK9frDpv8EZLlzhhAXpulobJR094qQUf1rf3J
         3i5V/cWgosUygROZT7LpVsJ77Ut0Y48+ufXuvjoDKDo3R5YhhJH8PqzRhHg/RZm7eckG
         JrSBs9x2Cm7RwuLprL+/EySur9lmVsGkD6XoH4IHFNB44IJdCNUqOaig8WA8Fg7a1ABN
         DQzmdhaSTAxn3e9PDGTXVirYR8S+5HUQsLSBpJJMt5Mbs8O+AZEt4BOqUcu4YgF5vuPV
         NJ6z7ZylR9QdUl1r172+DZjoBABJnbD1pfphxTr1d0J1LBb8HkWrwznMjk9zkgWrYOXU
         Vbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153477; x=1730758277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyhLwh2+OKpbMkdci4HatF+1nSS8uoK4ET9ojs2OKAk=;
        b=PWRZXGsEZ/4mdezQkW/ey517sQTJyc5uh8bXeg/dK8HwBplwVnBBGRI4YgveA7AhdH
         SD4B7ELLLip7stnoA9hHzpDnYOnMGsECYgf+8vtgq/OCNCuDXbRtgxf72l93jsZuZe8q
         xKEsC8Bi6lGeAB7CsBEbai+Hz9p9RT3AnIE7K6kYXsnfjgQHPM+ggGmp+QBOiAxQwwAd
         b/62l+OjkSt4yyGzz3QORLi2MEF2BInj6+HuVOgsiEVdsKozxUFLRH5c0rRe/NjX0uip
         Oj7WVH2lUXEouKrZLsDkz4dl+oChLZjVe0m0WtmB9SEW5ooAmiT42whQqI+VAOnNCpyS
         6QbA==
X-Forwarded-Encrypted: i=1; AJvYcCUSDD+Yj8gRJPNx87Bkg2K5wLvipErjobbDH391gCeFbpopt4zeE7xadUjUXJt2fuuJnTQNTrdohg+jE5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblisXd2NH5fzbxrlA3CSxRhpAfgIkwa7eZRtARQshx9+WDDlU
	3+HlSRyDlWEV1x3HUX4vLYMwE6LqCjBP41rXRt+Jmc7g8ryzjfFO
X-Google-Smtp-Source: AGHT+IGfnQNVeOY1T4zM0c/j+51jYKfoUhVlwgWCHYMu06THo68d5vh5WR6USv/4L8KyfR5evMnvhw==
X-Received: by 2002:a05:6214:4589:b0:6cb:4b70:8ead with SMTP id 6a1803df08f44-6d18584a41emr165401776d6.37.1730153477273;
        Mon, 28 Oct 2024 15:11:17 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2d637sm36601046d6.124.2024.10.28.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:11:16 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3685C1200069;
	Mon, 28 Oct 2024 18:11:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Oct 2024 18:11:16 -0400
X-ME-Sender: <xms:BAwgZyr7N4smtMibuOuQLVTZKxxMKFvSM64-09wvCi2VOUT09e6oNA>
    <xme:BAwgZwrJK9EPwi3GMAPvFN6SW7C3dbhjJo6Y6nXWA9myavRCs3YadE9qXM1WyjRT7
    FogzMQZiCp40yDbww>
X-ME-Received: <xmr:BAwgZ3Pt216srplrgN-kayRtr7gLtr-bo3k3mDt3mVyecvnSuwvle6nEgyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrshdrohgsvghrhhgruhhsvghrse
    hhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrug
    drvgguuhdprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghi
    lhdrtghomhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepjhdrrghlghhlrghvvgesuhgtlhdrrggtrdhukh
X-ME-Proxy: <xmx:BAwgZx7Y4N9950UGTI3sX5FysspVKvUksBbVXlqh__YebL2_qmLECA>
    <xmx:BAwgZx690tDiaZ0C3o9lx1AkS2cK48_-jzthp1KCWt8WdzQsQ1UUEw>
    <xmx:BAwgZxgWMhxvoOZ66cn4YUSb9NJ5E3g9pVDq7kJrBbHHZw-i-M1IrA>
    <xmx:BAwgZ76J6qGEBq203FELvNMwi50Rulu2t0M3rCqlTbftc8cRpFAMBQ>
    <xmx:BAwgZ8ImdnAGXR-VxzUdxNqTitEVcSQ1kJ97I9CTYHLu6zZW-NEXGcrq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 18:11:15 -0400 (EDT)
Date: Mon, 28 Oct 2024 15:11:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 1/5] tools/memory-model: Legitimize current use of
 tags in LKMM macros
Message-ID: <ZyAMAoqykP-EkdMS@Boquns-Mac-mini.local>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-2-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930105710.383284-2-jonas.oberhauser@huaweicloud.com>

On Mon, Sep 30, 2024 at 12:57:06PM +0200, Jonas Oberhauser wrote:
> The current macros in linux-kernel.def reference instructions such as
> __xchg{mb} or __cmpxchg{acquire}, which are invalid combinations of tags
> and instructions according to the declarations in linux-kernel.bell.
> This works with current herd7 because herd7 removes these tags anyways
> and does not actually enforce validity of combinations at all.
> 
> If a future herd7 version no longer applies these hardcoded
> transformations, then all currently invalid combinations will actually
> appear on some instruction.
> 
> We therefore adjust the declarations to make the resulting combinations
> valid, by adding the 'mb tag to the set of Accesses and allowing all
> Accesses to appear on all read, write, and RMW instructions.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  tools/memory-model/linux-kernel.bell | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index ce068700939c..dba6b5b6dee0 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -16,10 +16,11 @@
>  enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
>  		'release (*smp_store_release*) ||
>  		'acquire (*smp_load_acquire*) ||
> -		'noreturn (* R of non-return RMW *)
> -instructions R[{'once,'acquire,'noreturn}]
> -instructions W[{'once,'release}]
> -instructions RMW[{'once,'acquire,'release}]
> +		'noreturn (* R of non-return RMW *) ||
> +		'mb (*xchg(),cmpxchg(),...*)
> +instructions R[Accesses]
> +instructions W[Accesses]
> +instructions RMW[Accesses]
>  
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
> -- 
> 2.34.1
> 
> 

