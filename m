Return-Path: <linux-kernel+bounces-529491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E5A426F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85B14416EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AFE260A3C;
	Mon, 24 Feb 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr3T8tsY"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96125C6E2;
	Mon, 24 Feb 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411985; cv=none; b=b7WuHmEC9DyJ0SuQlFaJexhhfc446/KIp6ul+aSQlsOadJummbSN8zx9UKeX8sDkDtEPZRa30QEXZ0Tll3RKZjpjmIOdwEoEuR9e5odyDj2nozzhIoKZB2C5+zZ3hJ1DQSeKTNR+PwITgMFeo8P++oHSMsEs4hSK9JM0qD4+axE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411985; c=relaxed/simple;
	bh=D2SyEauQIWC2cBnJHv/f0DzMZSyM6lUrH4ui0HBeLg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAMBYBPLm1i6y6d2qAKaMqnL50ROI+9Rj7ALMPCF3qzLl4svmvL6WiZ6mygnk5gNPNvjn0K67AS561ocqFV/kg7QseIvRUeyyKPNGcPiG+j+3AP2UX6Ll/SkUwUZ22OY7NuTaEedDxThh4eBTMxsfz+Sc44Hxsj6/I9yBOYzs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr3T8tsY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e6698667c7so56308546d6.2;
        Mon, 24 Feb 2025 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740411983; x=1741016783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tWvPhrBhKw/DaS27gZAj9dzZvPGFERVllyec4Rq/h4=;
        b=lr3T8tsYMGxKBmrjTB8pg3qJxt8NXNjvf00U9PNyaF/fQNeH/ruMSsVLY/GqU0ewpB
         Vm45vTym77arMPP4hhVrf5HWNAdv5TGnTmuWgnGWtUBNy8KY/WrXiuxKq5kJT8uOmYNi
         0BXqHo5WQBLpWChSIdkN6Yza1s6oNzVmAtVATCynQx/zYGM1xj/TTwQk25q5QZrye1Ix
         PZr15OOLlqu+SqW9nKCKYGsgXvyoIZMYnIuv8NBasWzeoRm7oRPKlQ9bp3/6mM8amL9+
         a8rfItPFGsWwhLQETX7URHzECB6io/kv5eMi47rwZoB9DipYBIPClxiszq6fJbPQrCQU
         Z18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411983; x=1741016783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tWvPhrBhKw/DaS27gZAj9dzZvPGFERVllyec4Rq/h4=;
        b=Vb5bM4mo7bBYXDbh/RCYp4DeAn0Rwsi9Z3Y3siN+5QKpjhzudzJTwgnXy5OtZMEIgv
         u8zCX06cYMwCkf+YRz9bAk5nm2ofZ0V2Li0mLOu+9Vkwn7jkEH7OTGBGaOrJcke/HiEB
         3WCJbkv2+IQf0A3a/rHe26b0G1/Pe76IjU7cOVxrn90UXK6HAY/eBR6TbTV8phl61tLq
         clM73YZT2Y+0JTYeHvvy6jJaWxGbovFk6d/p6K2nJ0wgMttyChmDijYg0+THmvcnonl4
         yGYaVZp0zpztYDEuebTlMeLNCrKLNqovSVtCdpmCTUzFyhWW3YUKpLwnDWJY/P37GO1b
         hSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5h6Zcng7tQp0bC/xOGL9zY097WyW/epe1IW+esTWxSvzwrERRy41T4SXzqpi3g6HR6lEXPCJ97SvDCao=@vger.kernel.org, AJvYcCWmhORl8U7CqsW/RHymWlpVRAha01H8lv4YD5QZ8twOvclm0y0BWeY7Zl38jWc+GQIS8v376JtK/UCWlYn8bFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjvFqyDf8sdiQ7zyeofh2jlU/JoyYgUe0bklbox0qgjwhX7+W
	Dyk1fG5216Yi0CEj0JhOaa0GsZmNiTTGWU0wtisFlBB5knurnZ15
X-Gm-Gg: ASbGncsMlqh0OkU8ZPwHy4RqsCrMyzrhlZFhWk/m7WIa0aMkeqSex4egImNHmKz6OLi
	Ed9nvY0D0qF1sWjXSrQTNlPuGpSPjjDTl2N0n+QD0/77R4E57GXNaVpVnHXafYTbsrwY6i+w+Qj
	PcRvDWMheDDVZcUk1CKdpfhjNtGRHqUwYyi3HhC8ciowgk3ZFAU42+KvLas33emZW2dKKHocMIB
	nctQcBe6IGVBSgHPRHoAyw7A8yuwTMmlcmKr8x2t9zqRzVAksnLmxs2Z4nX+17Ra5E+qoOPOg23
	Buvxk1wr2M+1dyKTp04cvdJhuQ2tJcXM+qWqTB7tPJJvGv0Y6atqDpQjDyLavEf95FB7xkGLFSW
	awd1y8TFOBccs08uY
X-Google-Smtp-Source: AGHT+IGgUzfCdkBcr3DhUQ3jxEZz7g9RCqd3k3RyjwHSnrRfEae3F1L5KUNyGwJHf8ZiIcP9/aVLiQ==
X-Received: by 2002:a05:6214:4009:b0:6dd:d24:3072 with SMTP id 6a1803df08f44-6e6ae7c6b74mr192682996d6.3.1740411982890;
        Mon, 24 Feb 2025 07:46:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a43b9sm134832186d6.66.2025.02.24.07.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:46:22 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15F861200043;
	Mon, 24 Feb 2025 10:46:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 10:46:22 -0500
X-ME-Sender: <xms:TZS8Zzsc31RNJRu0fIEH1nhjWGvMXBVZdlgHLlgfEzYiuWwcDBj0_A>
    <xme:TZS8Z0cjtg4gKS3Oql-2e21DJkq142ZU41cBQBAmgl4uQ_jJgq23TuxnbaJy9ueTc
    ll84hydylo6Y4erOw>
X-ME-Received: <xmr:TZS8Z2wnE_Z1b4_94fJ1D_xVISIRx-B484JVtRRzAJbJEn0moSoaGlZFKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrkhhrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghj
    ohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnoh
    drlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:TZS8ZyM9BkDt_5wwlLflndJfUbryxd7aVr5uJ-27MQ_eIBPsYWujLQ>
    <xmx:TpS8Zz8-HdAHHBlzKCggyjhDlkRZ_WAHc8acn7I2fdIV9tGkQHkVfw>
    <xmx:TpS8ZyW3WmfVKvDmC4SVFZo6wukxjB8WOBdQA3zgtPNxkwN-plZIzw>
    <xmx:TpS8Z0fK5ODlIt72zom3sv-fl4x2KTwr2DuC1emvzw_EFrpr0eMSew>
    <xmx:TpS8Zxe3SmMxIFUtWiS2F2XlPwEGynvuj9KoRWIja2ToAdU5lpb37fpf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 10:46:21 -0500 (EST)
Date: Mon, 24 Feb 2025 07:46:20 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
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
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
Message-ID: <Z7yUTNEg6gMW0G7b@Mac.home>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j0j1nv2.fsf@kernel.org>

Hi Andreas,

On Mon, Feb 24, 2025 at 02:19:45PM +0100, Andreas Hindborg wrote:
> Hi Frederic,
> 
> "Andreas Hindborg" <a.hindborg@kernel.org> writes:
> 
> > This patch adds support for intrusive use of the hrtimer system. For now,
> > only one timer can be embedded in a Rust struct.
> >
> > The hrtimer Rust API is based on the intrusive style pattern introduced by
> > the Rust workqueue API.
> >
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> 
> I dropped your ack because I added the kconfig. Re-ack if you are still
> happy :)
> 

Why do we need this new kconfig?

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

