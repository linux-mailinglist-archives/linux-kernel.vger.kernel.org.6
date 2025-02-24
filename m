Return-Path: <linux-kernel+bounces-529487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0ACA426E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91443AAF46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BD25B669;
	Mon, 24 Feb 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3VXofvz"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410825A635;
	Mon, 24 Feb 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411883; cv=none; b=V1YpzxgMKjmTRvkAGCGmk6Re+LWyrGr/fvt8Gz3mpute/t3WTNY8Ndoui/KzggNZ72roomw1h2zV16o9P/6X13dPpODtBahWUkNcP1tf20nKJ2V1/GEIYqvio/iXjyznQZPvRsOpvTixZqoe8+c+F0zvz+xcVMJUKyR7/YSm5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411883; c=relaxed/simple;
	bh=J+gl8zI+aOkzWMZcWBYieBoghSBOVNuSVtqd/1Ru9AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSTmAbFd5mv+j1H4pZEWt0fs15CLspamZ4cGh6QeN4z1ifb9pR/MaLs5XysHsMP/0CqEoMiDBKjfYFTOwDpwL9KVjVHbgUREZNBHxBOmiMvqEDpoYRA1SF9nSv1VtmVFpaVd9Hnfi2uJtTQdauiL8X+AZO95NW3oONJojcbCCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3VXofvz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e672a21b9dso46261216d6.1;
        Mon, 24 Feb 2025 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740411880; x=1741016680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHPZQvko/HffTgoOSPKfEHyGmWWc1I8vABPxbSEtw8s=;
        b=i3VXofvzc7dc8Km2ojzRFazHP+1ui5J9uy9pfLhPYKkgG/7fjsoYRTMgpB3cCTrg4I
         4m3Cg1tztrrSl3BN9MXoxdl50EMWxvMaOoEkzVF7egeOnO1RevC3D9hUds5e2L/eyWXD
         RrKGNjiF5rsUEOG0SnBxLLsR6MxDPOy9cFPmfotSOEYYuhb3Z/mZAkZfS6ml+p4X3U6p
         faaRozPE3kNvb7bxia8yzeAJMXDmUPER+GJwVywcHgNr10JEkMBB1VxQ7s9e+VnP3XnC
         w09Pm6gAc+JJwzX7IQZr9K4SfHdt06zf+cZ0KX8BP61Wgu2ZG+H1o+IFYWzKB3vwHnSW
         nEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411880; x=1741016680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHPZQvko/HffTgoOSPKfEHyGmWWc1I8vABPxbSEtw8s=;
        b=s4s2dhLVk1XIBu+2pXkQrItBTjJ+AhYYG7XPP0X/k8Nehyo7SxkBk9mdNRYXwX70i4
         LbxWFNE823OQn/7wvZYbfjyDi6rHMWLiaQUD0gODg9//FHb25+09wDTj/ysKK+BIsCCb
         jWuVCLbKYaj+XI0FKxZITbc5A92D7W/TjHTaNxvy8y9aOPgv5VQu9URFJ9djLJuICyQN
         WYhZkIrj8lQh4gVh0M3Rrf70ztp6lVkSGKIyQydGBo/lV/mY2HgdMTMQs5vEodYJ57SA
         t+rJcBySAZFi93i4IeitZIgoyRYDEEOPjSpb0wMIbICfnGcgF60+Vg/3yF73X9cAslmt
         srRg==
X-Forwarded-Encrypted: i=1; AJvYcCV5k1NZcSwZ0uBtf18M70SbBz4Ml6HkvB9gzYGOS750SZHqux/VlAdorhyVDzPa8bn9kx/Wx2/gSbAp95boaJc=@vger.kernel.org, AJvYcCWOhapKRyDrzqEM32r9G77NaPEVDkU3blLVz699mDrtNu1IULJ0Ngo2Y17Da9baGeWfJtAM4ZwvwsSh+0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7vtV2g/G5vSiAXY5cUmtvthJjSHRId1L18ayPF7eA2o4CNoq
	62NU9a1OfP6nSH5JnvKW44FQsDL4f4HIOKCxmSsMBqf2B1eA3arn
X-Gm-Gg: ASbGncvhvBKH+cZ2Zqj+y46KLlpJZZXeK3CIzB+LVMezaHmqEc43oBytVlQ8QYyt2Dm
	hdv58jg3vK9CaRpvQZGbMAHIgBVBnNNGrQ4ajOrk8I2siGDaX1mVmGhYP9WcK8nDE4PP1pwDUuV
	Iszee6oTSlTDZQdIzKa2JZyfAJwli1izhBNuCZD3V3O1+tgwXMyweZUiHDFHapnWTn2IMFPgENh
	642y81yabJTCIZaSuo5nrMhIsD0tpxWV4xmEWhvhpU/HvBzBZEhAkPcZPAQ5ygLEuHjtPOQZH8j
	UUKaZ+fXGGClOSZIi6BN0Q66EOsFqrLxmDES/w6zo7pF2kBDHmIy40ARbyBWgUhJdRXaEO3/jcG
	H43EF6G00UcuhlmEG
X-Google-Smtp-Source: AGHT+IH8t1y3bfSFEhxMCATproIIJBMxamHpMvdXNg9UJaxjYm4rH8D5pHTYcmAQFUC39/JTbfmjIA==
X-Received: by 2002:a05:6214:d0b:b0:6e6:68d6:3932 with SMTP id 6a1803df08f44-6e6ae9bf220mr177810886d6.40.1740411880220;
        Mon, 24 Feb 2025 07:44:40 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779400sm134505366d6.7.2025.02.24.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:44:39 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C5AC1200066;
	Mon, 24 Feb 2025 10:44:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 10:44:39 -0500
X-ME-Sender: <xms:55O8Z9ELV-I0YlEj3pqeYjUkTsgMeviHFeymAbk3eCRZwtK_4T3PdA>
    <xme:55O8ZyXqT_4m09g2oOP2oWeolhT_oOJddEfgxBAJA8ZyzdMJGvV8mNCuaayTrnJ-u
    37suDFaZXrJJHDVBA>
X-ME-Received: <xmr:55O8Z_JH4PtijRtauVF3n3SlA6AmIgumHvum4wY3UZXnRvYv3xjdY5ucMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjeetffeiheduffdvjedtudegfedvfedtkefg
    gedtuddttdekfeeliefhkeetfeeinecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinh
    hugidrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlih
    hnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhes
    phhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:55O8ZzF6HTO2igzUUaAxmnVvqgDv070-qpT9Z_r1URiUF-mxv3TUPA>
    <xmx:55O8ZzXRxJ4JdvixC6uZfLDdciqEd35XD3L8HEVTou6ns7PCoBUVAQ>
    <xmx:55O8Z-NNhcGuOmlPlEKLKVaOrwxKnr6X7qpx_0H8qx24MrRu4Nn_WA>
    <xmx:55O8Zy2tnUO4gnEeVd95YM7GZ3QB-NBrLBQL9aCa93P5PUi6jv2e2Q>
    <xmx:55O8ZwX35ScX_WIZJkyL_Iu9g8HjxDpPaMimO-prm2JYDed94-plSjwl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 10:44:38 -0500 (EST)
Date: Mon, 24 Feb 2025 07:44:37 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
Message-ID: <Z7yT5XU5gAm0ZCZD@Mac.home>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>

On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
> Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
> add Boqun Feng as reviewer.
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Frederic, since you've reviewed the series, and we certainly need your
expertise here, do you want to be an reviewer in this maintainer entry
(to watch how we are doing maybe ;-))?

Thanks!

Regards,
Boqun

> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..60fa77c41b3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10355,6 +10355,16 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> +HIGH-RESOLUTION TIMERS [RUST]
> +M:	Andreas Hindborg <a.hindborg@kernel.org>
> +R:	Boqun Feng <boqun.feng@gmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://rust-for-linux.com
> +B:	https://github.com/Rust-for-Linux/linux/issues
> +F:	rust/kernel/time/hrtimer.rs
> +F:	rust/kernel/time/hrtimer/
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org
>  S:	Orphan
> 
> -- 
> 2.47.0
> 
> 

