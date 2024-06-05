Return-Path: <linux-kernel+bounces-201747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBD8FC2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EC628424A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829715C603;
	Wed,  5 Jun 2024 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez6IBs6M"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374852C95
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561727; cv=none; b=A1TT+fVaztgcSfkP2RKLP3ROyLizQKVa7Na6DZbHzv9ly5/ZEgZxqTZ/zbcD+aFUR1Mvl2lyAezPODHvHfLAF9AkwyUQnf6zA3XT0KAgagabfjzzVtS8Kq2cX6AW230gGpJOwI90Iv8F8Ih5WWEHquUEpzaxd5dEGUiFdO5srB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561727; c=relaxed/simple;
	bh=O3GEJtKtOPg6m1xawLvY0IBJ5ZINCMAPlcV9uv29TEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGMOzAjNzWShIBE9y7sadAHv8ZSCEbXmjsnUcuUgclDfhsykRl8E2ecaxxhTY9paMrDgqC5+J6jXHz1WTU6Hf3JA45McBvbiGDeUP49jPggumCfUdJvns7Oa0vco/ExppsLZ2ZgVpfAlPPQIj3xMarkOS2K8J5pB2HJ4fOh3MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez6IBs6M; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6af6c2bee7bso4369606d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717561725; x=1718166525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDTcjcU9MKKWpRko2f3j4zKs/GNT628iQNRsdFkihSo=;
        b=ez6IBs6MdeyaqgcEw5usec19KmwfkHaodOTWQr0+dbXkohiJKQe653JUR4kDgnYLQ5
         EEo/9g7JTHx7+5CWw1Y36NFPrGSh/fVxBBwAkymM9YRB+pcMdlNCmPuItsn5oKgW2Nnu
         Db32oElshEpwPHdfETTWwt6WhikKORe8Fa/nAOflGLOZGXVE6wjv/A2DPfHQlTDVgs5W
         rHBJrRgZ5ZHhwRv13o7/pdPg48DpGNuInfNAboYqK1rCYwRetSRLXretWvNTBtQqOTOC
         OEqSvpsepIHswOOYpYsPg6Lv8GivCPvadxmNJnjEJAo3rYcfVINcU15HkUe8WvZQ4iaP
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717561725; x=1718166525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDTcjcU9MKKWpRko2f3j4zKs/GNT628iQNRsdFkihSo=;
        b=FPiYElRvibUlf9Bc/pFDIT1Iwuv7wmou+BtgKDQD4yrwHdadsgEAlzuQunYxU+PCjd
         X9EDfKRJkuDrltg9MRO3/RZhP0skBa8gMhNhPX2Wjcnj+1QfksY4tqojP9e/8bDjdddE
         X/CE4ps7UyazFYwi4SBQIPggzVtH3FVeAji5wGlB4aVCua5H5cVi/cvgpMXI2SKXLLwm
         jUp8udkTHa0fLZ3cKyiTEfhAnK7t06csle/nizWTCH2uOR3NYik//XFCGix5beY083+p
         OQj7A6kDWxP+ezyMXU62jde0iJiK0zLXEZYGWpMkRqHbei0CBVzIHNeeJ39aDptO91pj
         fulw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2ijmf2OiKbZ5NO32UkxGC0+tco5K1WlHproKjRztAvMbWFjrSQMQKlH2r1XOHkpI3Lm2ESZ3iC0O6GQa99dX4IFF2AyP618qf+v8
X-Gm-Message-State: AOJu0YwqY6gUHuGFPFzgGh2slDrCKDKwl1uuA1II7ngop1ekRRsdMnaE
	Bq4YGKHCRsBTUJ4KdGCts04NaxSMEOPw7zSd3j+g/PERUHgwb6OR
X-Google-Smtp-Source: AGHT+IHTMOrJvMeH0+oC4MQKZVVYnLqSbXOaayur3J4twi/8Z4nilffTJ5y6IJKoaS01NhCGAE0uVQ==
X-Received: by 2002:a05:6214:2aa7:b0:6af:45d7:fc8 with SMTP id 6a1803df08f44-6aff72c1584mr75663436d6.17.1717561724986;
        Tue, 04 Jun 2024 21:28:44 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff2595290sm56200471cf.89.2024.06.04.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 21:28:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A963A1200043;
	Wed,  5 Jun 2024 00:28:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 00:28:43 -0400
X-ME-Sender: <xms:e-lfZu0q7KxnQgyvrHylLcr5oj0_G4xqJ1gRLl7jEsyNPhThWrLW7A>
    <xme:e-lfZhFRkS86VUYBeVtNtKbpS7sjoP1xGRXrEc6fPlq3IooDQf2u63P-bL4RZj_WI
    Q76lgne9yij6x7mag>
X-ME-Received: <xmr:e-lfZm4iwUBuLjA9sJM44xKdq0qFUvU46Zs9XFMlz_6hMl78tUVa4NfCbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:e-lfZv3odX2RNJcd5MhSWpM5TEcoMpKay3DdHUxDk6kihAnpHAqnKA>
    <xmx:e-lfZhFGB8afRk2UfOuJiDWYJBYLt8rmq4StHllC5161hEX3JnBj7Q>
    <xmx:e-lfZo-3nrDak5QqUmS-4noSzkYvNPX-Vq9BZcnX0hqqVNMuIwemFw>
    <xmx:e-lfZmkz8HgT2lfYBVIBIq9GT3ueOATH_vZmgun7AkocfbhzNRjJgg>
    <xmx:e-lfZpEG88dNf5HB5C8g3I_LkueDSfvEumWByAbsEjI9-jbbJXbEirDE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 00:28:42 -0400 (EDT)
Date: Tue, 4 Jun 2024 21:28:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: Re: [PATCHv2 3/4] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
Message-ID: <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>

On Tue, Jun 04, 2024 at 06:04:40PM +0200, Jonas Oberhauser wrote:
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

I couldn't help suggestting:

	([M] ; po ; [Mb & domain(rmw)]) |
	([Mb & range(rmw)] ; po ; [M]) |

, it's a bit more clear to me, but maybe the comment above is good
enough?

Regards,
Boqun

>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -- 
> 2.34.1
> 

