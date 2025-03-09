Return-Path: <linux-kernel+bounces-552888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BFA5807F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 04:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BBA1891642
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597552F88;
	Sun,  9 Mar 2025 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgB7Esf4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462542F37;
	Sun,  9 Mar 2025 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741491769; cv=none; b=RGDKysNUVwmA6k4krEblGTy+q3C63ogtqPZySQPrGC08kWiVDJr0VLSOlD+jEkpMipIv5wFIxQiMT4YPyJGMcuChec4r5fHhyHnz87qiZ4p7E58JShTGEyM51Ulm8rU/VFYIvzrpxawaNqJDSdsckLOaa807KxOsYdm3C6JS12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741491769; c=relaxed/simple;
	bh=lx6NB+qDtz9P3ipI8WEAT2l+BpRs5XenWiRE/I9mXHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpFicCTqgKCJ8UjqyGQkaecboKZGuKNRqNrDGZUrd2XN+zpk96wA26cXi9KRPabE5+FpDqnAsfbnZzXzpSn2qzfFMu+myacn1YBXHG1AagaqDX0E8ThZHv1hJmq4lCkt8MQeP4Xz4z/gVt01TsHCCjd5ZZUC+iQybzahnRx4yno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgB7Esf4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47521c604efso51821151cf.0;
        Sat, 08 Mar 2025 19:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741491767; x=1742096567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yp0HF8hebKGm850Xmgb0c7EhESLBd+xQ9hWzxDmF5w=;
        b=RgB7Esf4o9OP3OF3q/z00AmoB/tsdh6aPADjAEPTB8np/2xZ9dOc5m9iNXSJR5LRuw
         Nxh0oPoj8HF77fURZuVeXwV3Qi0DMEoS5a7njgvexUEMOVJB5uFeK5EZgfEjZydBfqXK
         C9UolLtsmgh0VCqHSA5X9zHGHmaH2wfWrLfNp6isJFaYA6wjEo3e/fqwU62e3hQyBGp6
         N0H0AkEsi8oCSby8l4rNQyeFUVp80Wyc69GI9RvaEiS0ucPLGVtyiBFhbISWEsfpq2lk
         yUaf+1g+PXcTh72gdutD+/ev7VQBc055R+Qw2TSj9ZiTFS51I9fliBi6RDExucaEWgcB
         Ar9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741491767; x=1742096567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yp0HF8hebKGm850Xmgb0c7EhESLBd+xQ9hWzxDmF5w=;
        b=Ijioz47daAqEeNJ5sf/4JjDIz1I6p0W6BcSOfiIiKDv0YoCJnuI1i3KrIx5NwD+rZI
         MOR1SSEUvDL8nPp7r8+LL9XyaN0V4WLc2xDaKgyvLv21Pnmb8vL82sgJ97TBbjIJGHcn
         RGmgJiljEtDK9OIkkmmXswb7xhbeE5yz2Ey0imQAA5selt6m+4rylHy7DvF3GhB0IrH7
         Ei3JAhbcZ4jvhpwd7LKMpytht8EPyCWjLSEKhaUC2VaPfY732jVkKId4IW5BLRlwa/Fj
         V2pWmVDllBcG+CdbC8nSK8leeS/kCnMQ7zMIDipXesCC/F0I40NZy23veSpLfG8N90ks
         1iyg==
X-Forwarded-Encrypted: i=1; AJvYcCViXTER9AhheBeDOdBG2v5k2BXBEd/WImM7x0J2ov+bbHDPMq942YBCulmDTwYqBKKFOdJHt7G8egBfdy0=@vger.kernel.org, AJvYcCXv3ixGuI35jru7C5JmSXycBT/FEcYhw0ithoWcgEhHaxDzKykyZeQmB/Ka1Udc24sF06xJR7wVJnrJZJkrYis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJCQCnaF5/T9lj8GIr47FgIm1ZAjeJW79XWAcQWr7Se3ShOPj
	5M96mWScy9obuxsbI7IDODvdwc8trKSdsM+CkAv1OV3B+h4FlpWX
X-Gm-Gg: ASbGncteBklgfppoewUgEHU1R6PP7+wPO7exGES4ZA6FYtHQ4vPutINq3TX1fJFltly
	BHyMm1MkxB5N4TjWUvue1x5QJrBEI/xhbP0Rk8yHKXkvtfR0JiWHDJMpZiPRDQ1wjk5dSLE+6hc
	VRQ4UKehbcCKvjML4Dsb0GBwmvYmuxyh/wnPPPGPsjDDZ3s3Krlr2O1cf4K2eWbwTfdVMiiYQOn
	m8JLwyhq6yma1hg0dPoquhSkecVb+iNaNlVT8ZmuGvPYBRTMJzFW9d3vedyloo96camwZpukuUu
	enK1wafTgFHtNIp+P+v+mJJCqm6xOhoL7/bnuKxbRApemBjvBmroP2Dpx4rQ2HEkosg7xgQCNn6
	DTJXlXtLAKLU0blUugLQUv3swCbmzUkDxd+k=
X-Google-Smtp-Source: AGHT+IHyGX6at8VhNa8ZE2qK+ILoyuTNdjSx26AdZovpMYwfd74OOMttVlZ+pNy0Z6dl0JtuCEX7lA==
X-Received: by 2002:ac8:5a84:0:b0:474:fa6e:ff3a with SMTP id d75a77b69052e-47618af90c1mr125991401cf.49.1741491767057;
        Sat, 08 Mar 2025 19:42:47 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4766efce08asm9739451cf.15.2025.03.08.19.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 19:42:45 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 516811200068;
	Sat,  8 Mar 2025 22:42:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 08 Mar 2025 22:42:45 -0500
X-ME-Sender: <xms:NQ7NZ22bvaIdXGcxt9Xk2XrztDfpjDVIlyzywdWe0zxuTCgamVLt2Q>
    <xme:NQ7NZ5E30bo7JXsrsJgET7ze1QUuzSli5kVpA72stpIVhmWDCnC2q6rTJhrrLtyu1
    RlrXutiKrXbwKD2dg>
X-ME-Received: <xmr:NQ7NZ-5GDXJZUVGXzsb3416YPGDcArRyBhUsRXzWMsaA7CJG9EAIQUvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgih
    nhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghj
    ohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnoh
    drlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhg
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:NQ7NZ31zrImLUXfw8YrxaYYuMcmQJbNYNVdaAekA2ExwcowVDfBcZg>
    <xmx:NQ7NZ5E-r6fToaCMfAEskr_uYe8tQeaMSywbER4yiHlazoZX1E5vEg>
    <xmx:NQ7NZw-GZsSRSW-8fBnsG43KGPv7qpoCGiL7ZxIyjsfP5KOw4seWhw>
    <xmx:NQ7NZ-kfisaGKRm8bx5az3elPKC0dU1ruXLCtdJRG8HNiX3VVd5esA>
    <xmx:NQ7NZxG59yIYZYJu9vEdphcH7CMFUgc3uOTNFM7CW2GFw-FF1loFR14h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Mar 2025 22:42:44 -0500 (EST)
Date: Sat, 8 Mar 2025 19:42:43 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: rust: add tree field for RUST [ALLOC]
Message-ID: <Z80OM7vrg3ZrJGL1@Mac.home>
References: <20250308164258.811040-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308164258.811040-1-ojeda@kernel.org>

On Sat, Mar 08, 2025 at 05:42:58PM +0100, Miguel Ojeda wrote:
> In the Rust subsystem we are starting to add new subentries which will
> have their own trees. Those trees will be part of linux-next and will
> be sent as PRs to be merged into rust-next.
> 
> Thus do the same for the existing subentry we already have: RUST [ALLOC].
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

FWIW,

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..1ddc313abbdd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20732,6 +20732,7 @@ RUST [ALLOC]
>  M:	Danilo Krummrich <dakr@kernel.org>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Maintained
> +T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
>  F:	rust/kernel/alloc.rs
>  F:	rust/kernel/alloc/
>  
> 
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> -- 
> 2.48.1
> 

