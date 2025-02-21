Return-Path: <linux-kernel+bounces-525193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC568A3EC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34424421324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671B1FBE88;
	Fri, 21 Feb 2025 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd7ahN2Y"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21641DF754;
	Fri, 21 Feb 2025 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116196; cv=none; b=HmOoqlnAz4hA0fGBEvkiEGLi3Qw8tGH2WRDg9umUiaf3y2AlA6fcFOT24C0N6shIa8rIekv/1xDCwhtPqEgo7fipvSTND+6W2YKheKTse3VCvuMoBxWwgktCtrRQ1ly4BvD59tuvd1Hos+RY6YDVx3hagR6v/4PvsrGNwuECjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116196; c=relaxed/simple;
	bh=oStcB3/2j22PjgCV1nSTPBHoQ6TNLZQZ/mIYOxpSPjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBiHE0q7s1LQQQvGjno5nW5a47NUhDyUbz32NynM6o94HbQmA1G7yD3ZlG2+e7q+xZj+AHteDZ4wMXSM43716TRBVMGs/VoXYPAVqu4ltAGVyrSPNWH0INQfonOWDrlMP48g7WOL8y1dTDRro9MIqB8YxEWbxBq0Zecf950ArnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd7ahN2Y; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6df83fd01cbso8441296d6.2;
        Thu, 20 Feb 2025 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740116193; x=1740720993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wkdd+8aLdRlmuPLS96GTxJJrr9x2D3DwB8vMZjyfWeY=;
        b=Bd7ahN2Y0OO/3xxWclNTw5uITwsmjXM/qpAQOlpheA/FHFtYIcZiojG6/d6WNO91rB
         txyuYs5CjOJbVMv2frucyZTt8J89QBd1uz6dXDBiNfNfBlT1OUlBDuz/gax/lnmdAWeY
         4hVCQG6qTCIbGn575alc4BaFoeDPDLq6DG0UZEc/DoC3hez+7eeC77B59tfYhIsVPAUi
         WUjwYYm5PJa9pE4uyTYf2b8IVCSGFQxLlwqLzp3J9gps0ct3aAMvOvNcaxyGKwR3eTJW
         EhEOgxlPauxnkIVe9AmGBiBvdpxvgbVBO3XxQbqjn1/VmPdUuujukKG6684Zqony3+Vg
         Mcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116193; x=1740720993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wkdd+8aLdRlmuPLS96GTxJJrr9x2D3DwB8vMZjyfWeY=;
        b=Jt7zX/L2T05891tdZeFNzDkKswsk3WbREfDtT+VLRe9HMkzDtdYvGhtGNrVi/737rJ
         +iK7OZqI59233I47/Q+O+otqnNUo2di3Z0p4dOcusYZ0xTMm3VDgtqT7eXNZPIbTok6X
         G24eFt0E84t3ZTCXzqCdNRggveEZnj/KaFP5AgsP2HwPt3o2M8H6XMH716RbgCGAOppQ
         ByQ96MDIKt+DIEiY7db+cjAGg0EX28VABvQQe4gLoI89idXiKm09Ox2yB0SFY2a1tinE
         vwQpvS0RgzH/LVhL/SzDcqHXxdQn5tqZPjp3aIYy6ZCmKdF5WWvu7J5RFWwU3aA5rq1J
         aixQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Emp1X/J0pkKKPnmGdKBEwtwOO8cKkzxSHUWCilhUt/QUwfkmxPaLNY/2UZD4ecdx+PrnIQKBfSFO0FYCUQM=@vger.kernel.org, AJvYcCW6uPylZ6hiOryKSpGabLnsytJRi64aXj0MK6Ci6WiDdBCse2ZFOIQ8iqelY7qVaLrn29Y3N8VbTTzVGcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywao0r1BdOjlMUZ2xaF6XnhiVe8BHEuuf80NqQigMFbfveWVGEN
	Cv8D3k+eAyoMCBn3q+vekyMtypr0ikr7fuhBoR/Ydqvt70ojn8IK
X-Gm-Gg: ASbGnctX58aU4/tGZfEeqwHFehlczVtuavEmsTfqoKdWVMZSmWrwaguPpDYCcLWrktw
	La0yrzVs5NpRtVNyrrF4+VJ1tR3KH6ClLqkHKZe1wOgq9/kIF1jhNOhHSwgVKhd8TlCun8vhTfC
	0TNlhDgNm66mtZnf7IkKLazWcXdhDhG94/oF/6KPLU5W5fGT9dGADquW1sRTpsgn9SB+CXrAXiK
	snYPptU7+ypY2N5tg7oPh4cuhBoW2rZjAT0ZwXoo5rjIlZBz+T4dbar9eIQTma2rvh83xzpzDMa
	HCcU9ST72uWrk8fFKqQMKAVB7lsCVFjuhTPjSvL6jx2A0mu4TXGLK3JRAKXA1PTLJiqPKIN/YeN
	i80+eoe8xUFOPLxQv
X-Google-Smtp-Source: AGHT+IHsjhWGvoxLr79IKlUcyjrNloUqyJ4Y4mutrZNXf5334jKuRlB5nCk+VYIrOVwK3T6drm7M3Q==
X-Received: by 2002:a05:6214:29e8:b0:6d4:b1e:5418 with SMTP id 6a1803df08f44-6e6ae995a51mr28365326d6.33.1740116193283;
        Thu, 20 Feb 2025 21:36:33 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ae1032a4sm397488285a.49.2025.02.20.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:36:32 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42B9C120006A;
	Fri, 21 Feb 2025 00:36:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 21 Feb 2025 00:36:32 -0500
X-ME-Sender: <xms:4BC4Z9xWdVU85h0MvzFjcNG6Z6KfPlSBzHblOly0KrU8AekJ9sEeMQ>
    <xme:4BC4Z9S_xfFq1k6HZXHYlw8kt0N60XUurxRCgPArB389WtSFUQGlL24nIK-N10CLq
    PL7GN4CeCKbmYuKyg>
X-ME-Received: <xmr:4BC4Z3V9W0K0MiGIY082IXqVwND9KVWRqT4askGgq4d8tOKals59NqbsDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepveeiueejgfdtteevveeivedugeevhfdvvdek
    ieevhffgjeegtdegvdfhkeevueefnecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinh
    hugidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehfvghlihhpvgdrtghonhhtrhgvrhgrshesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgt
    hhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtoh
    hmpdhrtghpthhtohepkhhsuhhmmhhitheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:4BC4Z_j0atbqBRNWQlReDWVcIbRe0p5pPFRliISEDulZVZGllGpyKQ>
    <xmx:4BC4Z_DhhIS-iZSpZ8hipPL6c9wStIbIy6N6NuCldgXXeO7LZC0ZnQ>
    <xmx:4BC4Z4JvuLkVXRgjv_gnmghacYQC72MK2YHayxdj7AySaGVAB7qE0w>
    <xmx:4BC4Z-DXK8LfdP2INCgpox41AT589HsJLA3w6niUakEeIPh2_jt2qQ>
    <xmx:4BC4Zzz3zluis7UlXGLm9A5R7_6-VwDMM7WDFPXZu6-sNLRdIq85SeJg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 00:36:31 -0500 (EST)
Date: Thu, 20 Feb 2025 21:36:30 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: gregkh@linuxfoundation.org, airlied@gmail.com, hch@infradead.org,
	hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Rust kernel policy
Message-ID: <Z7gQ3kSeCf7gY1i9@Mac.home>
References: <2025021954-flaccid-pucker-f7d9@gregkh>
 <20250221051909.37478-1-felipe.contreras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221051909.37478-1-felipe.contreras@gmail.com>

On Thu, Feb 20, 2025 at 11:19:09PM -0600, Felipe Contreras wrote:
> Greg KH wrote:
> > But for new code / drivers, writing them in rust where these types of
> > bugs just can't happen (or happen much much less) is a win for all of
> > us, why wouldn't we do this?
> 
> *If* they can be written in Rust in the first place. You are skipping that
> very important precondition.
> 

Hmm.. there are multiple old/new drivers (not a complete list) already
in Rust:

* NVME: https://rust-for-linux.com/nvme-driver
* binder: https://rust-for-linux.com/android-binder-driver
* Puzzlefs: https://rust-for-linux.com/puzzlefs-filesystem-driver
* Apple AGX GPU driver: https://rust-for-linux.com/apple-agx-gpu-driver

, so is there still a question that drivers can be written in Rust?

Regards,
Boqun

> > Rust isn't a "silver bullet" that will solve all of our problems, but it
> > sure will help in a huge number of places, so for new stuff going
> > forward, why wouldn't we want that?
> 
[...]

