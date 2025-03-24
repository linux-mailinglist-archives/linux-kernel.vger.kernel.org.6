Return-Path: <linux-kernel+bounces-574067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F75A6E02E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2163B21A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA078263F4D;
	Mon, 24 Mar 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3w6GWDs"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD46263F37;
	Mon, 24 Mar 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834977; cv=none; b=UBy81Geq3tJnfZFo2a4mOND/bNL0P5Jv+zfpqox41oYoBMqM2q4xE0i7zltciDqseWUTFCSW8Uh2b9ASbsmCA3kWxHS8e9dNC8etRg4UfREkpnUGh12SYQuslqJZvEWwvsXmgCrqqWcDMbZ8IYTDo3SuLQxrWJOO8RZIidR/JDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834977; c=relaxed/simple;
	bh=1cW3XXPLhenC0aPM0QTbraRgM3ezYhhg4cN/zcLWDKc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgHalYWeCkup/L3jaB2TIH5K+yehaVDqJzT0XrWzihiz9jmX2FI13WOkfIMa4uqVM2sWEZlmN0R7LNvHB20p/IWVVRbHn11C34hwxQ5Ak0GovGKoWoBleI/vh8eUCHtBBwX8yAC1mcD0/GKW5A7a9mKYIONFy7OEG0o/B7rPToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3w6GWDs; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8ffa00555so38294336d6.0;
        Mon, 24 Mar 2025 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742834974; x=1743439774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf2kh6G05pGLPdSuj7dYJ6UhpBm6ycRh7eYTtN26Igs=;
        b=M3w6GWDsa6uBbIYHuR7jKiTEBiTllhdsmO8rTaBo+q6sz3xuYjRLd4twMeyehgXaWm
         A+7sZCMNr1o65gLOWPE79dy/9KfT20X60hitsyOVd24GnxqyUVUPLjgpB7zqOdqg+UqU
         ToN2dSPRLe80Qo3ErLyfQW4WNSAUSZALVdobLsp9ISj9Q+3JCRVs0haMponXNGlLkbYm
         nh5VssGfmqDTtUCZQu3A3g0riUR+WUKQRPzKi8pVw2oFeXUCZuJ8aDwyDcvVyJsJ+8mY
         BOLGHdHg339lukeGBTlYLIRjJee2QC6YWruG+kDUdmLQF9DwqgAyJ5I/RL8xy9ilAt2z
         A3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834974; x=1743439774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf2kh6G05pGLPdSuj7dYJ6UhpBm6ycRh7eYTtN26Igs=;
        b=V3ZV3WxwKjL0llUnEtCmA4AVF824LGrakkzeOAXe8zAKiMnYmKLLUH6k97mOloZENB
         tNukCXihFgE1YZs7jJ2UR1Y+80tX07qysOuhnXxk+pU3lHDpdVLS4p0xfHOI3DfDAz/3
         7Q3pn86lHFgiwrO++//DtTPJ96gvyedk3oU3M5Ok+Zm7vqrffvcNR7Qsc8DA+dA5rzBr
         3A0IR/anZj7bq2LOj54CnFFFuaIU7s2sM0SU7twlShPNXlRVTK1IGAbJZrKc+kjNHF8f
         vrEGbLe8+Fkyej0dDq05HHv6uIpg8dq1EZpT3DgKMTqo2xMqQe2CnGTqg/95zxtun8RV
         ei1A==
X-Forwarded-Encrypted: i=1; AJvYcCWnjg+1UW6UQX35Fv+yiJWTQ2Zl/C/2cGv4pPxpV6canVDe8BWBlWt02c+u/zPj7gl6n/1dI+gNcqPwOEBQQvU=@vger.kernel.org, AJvYcCWxBumoUadlScVDOhNhXRY9FdHAMkZzTC2MP+vKMNe+VBimwUSigpBXOdtKgBjwHDibfI/BrJCbDtZLfr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwfd8hompdcPLQRCKoKwPJIkAR3kEXukLx617mKPzpj1P+zd9
	kkyEf44j8wP+eD8HZiTg/5hetdrLaUAUpcrQFRcyYYkKxsKnvOqD
X-Gm-Gg: ASbGncugc7inQOZsrOONDeR8cynIajMujwsZJQkdL1NCcn2LQJGzYZz8QMK79efcYkO
	CmryplU6G0qNfme1/h20TgXkGs7EHSJkEJ+oG4bWyTQMnio1owStSCh2YKDHu2PLA3jGjFhWP+L
	vmeo7/e+MsKfdCQSrHEq0BFYBPX6sFf6cnCZE2kJm/l3wyW20ZvDvi9ar6WLiI7ky4rau0xoUvI
	tRKJLhZkUqB9YF1SOdPziqgppOq6X9Smq+fuJfBXJ3zhNLlyygcdxfHYaVYwz/hGnEvhg4LqyW0
	IPs4B4goEUIcxA6hzNB0I8VHzquyKaptYkBR/v1p+8CacGZmmvm5Sl89SSnIKB+JUGebWlhiLjI
	JG6dmiRMshVGyVrTJ3F69uNSs4N4QAVixy4s=
X-Google-Smtp-Source: AGHT+IF7uIUBThvsY+ZL5DCMtDH932EJZ9y8lXz+Nizlpbf5Qr1xvu8w9feQIVuqiS66Bs6YbhNFdw==
X-Received: by 2002:a05:6214:2407:b0:6e8:c713:321f with SMTP id 6a1803df08f44-6eb3f339e06mr247763406d6.35.1742834974211;
        Mon, 24 Mar 2025 09:49:34 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0eceesm46989946d6.22.2025.03.24.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:49:33 -0700 (PDT)
Message-ID: <67e18d1d.d40a0220.1a1e10.296f@mx.google.com>
X-Google-Original-Message-ID: <Z-GNGwN8Kv29ybB0@winterfell.>
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E6C1A120007C;
	Mon, 24 Mar 2025 12:49:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 12:49:32 -0400
X-ME-Sender: <xms:HI3hZ6Ieop_8G7-9NdMDSsHUixqR7Neaupd93Om_wcFdI_TT4TZTag>
    <xme:HI3hZyKz2qDOJcjciBZaqvu34CogmjdRZEyXiEwFrbasfPlgUbXiarXuV6hje97oQ
    kcjY7fwniTGgLIAWA>
X-ME-Received: <xmr:HI3hZ6spx5AvU5WKhvGcLile6HxgGoZ_T1lq7pfv6CuuuoHkMrvbBo2d6mU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgeekgeettdelffekfedtveelueeiudev
    jeegieekvdegkedufeetfeeiiedvueelnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhunhifuhdrtghhrghnsehlihhnuhigrdguvghvpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhho
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhope
    grrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghr
    hihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:HI3hZ_bLw4zxWGG2Z5E7mtt8nF3OXydAO1yPsOuhiQRMU_tOhNnTgQ>
    <xmx:HI3hZxagqG_VmqT0vVzHga_RR_X4t0cLBZLPNhS-39Ahfebw9eDfpA>
    <xmx:HI3hZ7CJzjMNIEmsX36lbsoHgtONPJLr-0ZoCNyPLmQrNKdCSW_3KQ>
    <xmx:HI3hZ3ZRgp8DbZEpbTfKe7EZ03CXWqIwHuNAYRitvdkKeuK2xj3goQ>
    <xmx:HI3hZxqAJXWJJFCR17qdW8iyOKgUk6UvcvDUWa2mJMOofWma99U260aZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 12:49:32 -0400 (EDT)
Date: Mon, 24 Mar 2025 09:49:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH v2] rust: sync: optimize rust symbol generation for
 CondVar
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
 <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>

On Mon, Mar 24, 2025 at 10:37:38AM +0100, Miguel Ojeda wrote:
> On Mon, Mar 24, 2025 at 7:19 AM Kunwu Chan <kunwu.chan@linux.dev> wrote:
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> 
> Nit: I typically use Link after Suggested-by, to mimic what the docs
> require about Reported-by with Link. (No need to resend a new version
> just for this :)
> 
> > - Remove '#[inline]' for notify()
> 
> It is good that the commit matches the log now, though I wonder if in
> the future we may want the `#[inline]` for `notify` anyway, even if
> LLVM does that one on its own today.
> 

IMO, inlining should be mostly decided by compilers instead of
programmers, so if we don't have evidences that compilers need some
guidance, we shouldn't introduce the `#[inline]` attribute.

Maybe Kunwu has an example saying otherwise?

Regards,
Boqun

> Cheers,
> Miguel

