Return-Path: <linux-kernel+bounces-395650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602B9BC10A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAAD1F22BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1101FDF90;
	Mon,  4 Nov 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNlWATDH"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19951FC3;
	Mon,  4 Nov 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760129; cv=none; b=qZkdb1CKTfCr/MNCZ5mrhb9vMsYPw29gDsFvKk/zlxKM8BxTWFPmh7wedNlzo2QxtBkVfTk1sf4fO6HoxD6aPOule0Wp5rPyfHlE+tQMN8SFNvw9akc+i6/JwSOdq4JQ4rsYa6YsxX90G8u6nBtxujuTc7ORYaCH820P113GyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760129; c=relaxed/simple;
	bh=UIMQBl83V2Bns8yGAXTRumgr/92RHa2mv7Anyp60yE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWk6Ul0FHpsLIfzSW0FOVzP9sRiXqJc/aApVmYaWjKgx6X+ms0v5IZfzuuKNANnfmQGGGj0mtpqziF5qZLdf6kJGCHRxkcEkovcFMnz4W924t85h4zGwg1CXOWMO/YSr24awtG4unByokF/I+USwu8fWTCUbMUARJPu9WH+ec3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNlWATDH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b158542592so352020685a.2;
        Mon, 04 Nov 2024 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730760127; x=1731364927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyv50UDAwS0ps1lDbxLMzi7cs8LVSE1+F2Y15Lj+yls=;
        b=eNlWATDH0+UOBivqeV088jqnHe5epIjDLTGNyLeyhBzdBi8FalIMb+5c3WHUO96hwA
         FkQgRlsjiiq2FG5ju19xU8FSiZ8UJab07Qf07S3s1GUhQbSdI3CkT+IgHmpChMEcjzIL
         PygsHuEjNao5IQRS2oo4MHKrtmwihwpcco+KfFhCO2KNJJzE5naE6QWMCLZx5grDq5FM
         TeAWDH2B3SK8Sawg+s5UWjtn1AdcBaoTjH1oTZhAlmWscpaYMNd0ivxqx/ngQLPwRKJ0
         HtMt0FPUrI/Jk5g+wlyILTbqSEsZhF/nBVlQPr0exe49Y19bSGB9Cn2ReKm8bN2XVV5D
         7m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760127; x=1731364927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyv50UDAwS0ps1lDbxLMzi7cs8LVSE1+F2Y15Lj+yls=;
        b=c5Xx8sQh6q5cfJnsvCtvYpHpaKIBZ2Ji6oufeJRfjJhyLayxiusEw2Ro2JCHaKxxZI
         awK3g6cnCkJ2AghOE5Fbsgn+iOYVMxsrUEH5GS8VWYWTOahrwPHpm/HuF6rlC1Hjn/dl
         S2r4dOxtIlU59R9eGLAq2z7dDPL6ZuFM+F3I/wGyAX6Bh/PpmiFs7n+GBbk/MHk7X+Mp
         GuyeUFvHRI783hNqyQuDPAStbUP8bukOAwK4JHew5+F88ML1yj4LW6btbIyrVDL6CeNv
         wFqCGh1YwTw/Y8pm4M5krw5jF6wYZOzxG6L9pGavd8nEizSjbOXZh/KXN7SFqBNtJ86y
         mt1A==
X-Forwarded-Encrypted: i=1; AJvYcCV1pcu42QWWSDT8WJVlRGSX+aj27lut6E3ey6MAqGbDCY8a6nktAa7LeF5OgBXbQdd+m7IvPGUyIiwP4RaFyrM=@vger.kernel.org, AJvYcCW4OTeyhamg/ZYpUcl8e/IfTeU1sVGztNSKaLn6wOywsJFdUygjwX1CRTPO0gv3KRn4XlDWAuO22A+Tnto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBbROxIRXpx2bmbc6MKjA6WdEi0NDPzEc+K/7vwEjmHegl3+E
	70GXCkVf0uTsOCJ5MQ7WySqgQKrIDjr/jbL7mXhJF2it8PX15BGs
X-Google-Smtp-Source: AGHT+IGGVNb3beS/nECB8mb5RSvaOeo3Beb5QajMsPATQi1S9AA2nRRTgVJ0GvRp4Gl2KYW/undv+Q==
X-Received: by 2002:a05:620a:4711:b0:7b1:7f5f:4988 with SMTP id af79cd13be357-7b2fb982c4amr2357263285a.36.1730760126453;
        Mon, 04 Nov 2024 14:42:06 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e9a6fsm464593785a.18.2024.11.04.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:42:06 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8CA091200043;
	Mon,  4 Nov 2024 17:42:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 04 Nov 2024 17:42:05 -0500
X-ME-Sender: <xms:vU0pZz-mSIaZDjSe2OllzWZ5jlwrI45WjCS5U_yECRSLs1uDuWUe3w>
    <xme:vU0pZ_t-VZ4wqLk88_B1-J_YKOCHd2Voh9TxVaHtoj5WpJxDY0NqxHX4UqrdFSeGp
    pWmeisCyBw4xS1B7g>
X-ME-Received: <xmr:vU0pZxDrQOvkPzTppdxls5LlTswUCPYPKSOvrIPacNx-2xmqToN4SYbe9jM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedv
    veevleevhfekhefftdekieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    hnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusgho
    rhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:vU0pZ_fhd1XMxLIRIJGVBKoI9COMjtFzRx-wDSUmRZKD8cE4ZV0Ysg>
    <xmx:vU0pZ4PkBtcmh2ZaDlPqtHTI65qOBlc7OkyTCMvOlhagU503bxaBow>
    <xmx:vU0pZxma54JTEkui6ey9oyZ_unEwakVXzYi44Fe-b3FDfA4DPnXPOA>
    <xmx:vU0pZyukuADDJKUwStNeT0fXWj27a7Kz2ofx8mGuo3rxFxIQ_0gQmQ>
    <xmx:vU0pZytVcdwPdlcrQ-vZ9pI3p2Xal6o_EzoULdh9QYEoDsh71dAkooqO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 17:42:05 -0500 (EST)
Date: Mon, 4 Nov 2024 14:42:04 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
Message-ID: <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local>
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>

Hi Tamir,

On Mon, Nov 04, 2024 at 05:23:44PM -0400, Tamir Duberstein wrote:
> There's no need for this. The type had the same form when it was first

I believe we need this `PhantomData` to inform drop chec [1] that the
drop of `Arc` may result into the drop of an `ArcInner<T>`. Rust std
`Arc` has the similar definition [2], you can find more information
about PhantomData usage on drop checking at [3].

[1]: https://doc.rust-lang.org/nightly/std/ops/trait.Drop.html#drop-check
[2]: https://doc.rust-lang.org/src/alloc/sync.rs.html#245
[3]: https://doc.rust-lang.org/nightly/std/marker/struct.PhantomData.html#ownership-and-the-drop-check

Regards,
Boqun

> introduced, so it seems this was never necessary.
> 
> Fixed: 9dc043655003 ("rust: sync: add `Arc` for ref-counted allocations")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/sync/arc.rs | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index db9da352d588f65348aa7a5204abbb165b70197f..7e54d31538273d410f80fd65b2070e75e4f69428 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -127,7 +127,6 @@
>  /// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
> -    _p: PhantomData<ArcInner<T>>,
>  }
>  
>  #[pin_data]
> @@ -219,7 +218,6 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
>          // INVARIANT: By the safety requirements, the invariants hold.
>          Arc {
>              ptr: inner,
> -            _p: PhantomData,
>          }
>      }
>  
> 
> ---
> base-commit: ae7851c29747fa3765ecb722fe722117a346f988
> change-id: 20241104-simplify-arc-70c3574b5fac
> 
> Best regards,
> -- 
> Tamir Duberstein <tamird@gmail.com>
> 

