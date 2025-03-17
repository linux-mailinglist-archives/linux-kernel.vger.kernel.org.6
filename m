Return-Path: <linux-kernel+bounces-563333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681BA63E67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436473AAB59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AB2080EE;
	Mon, 17 Mar 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlAaP4P1"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638C16F288;
	Mon, 17 Mar 2025 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186019; cv=none; b=A+bgka41X98cmvaYjI7ulTbe4ijJSvPhU/n+v0YJE3Zkv2IxTDH6I75qDUFUTHR0U0Qr6R7PySKc8v+8wHE+4+xGxAXMSkS98EzfRRi3chk3No1uUSw2XWQ82l2dpo7gvcuhW/bnDFrDQ+MFAX/7ud/NbZzkitEsoohO40F/7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186019; c=relaxed/simple;
	bh=faHYa8bSIk9tx9hF2EtAObzyRh+EkM8UCXGL7WFcQQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFvCcb7RbmHp5rF66ytfKmm7vKGqpfcvqWs8pQ6o5wCLkeW2aFQq0liITb4mKIsVRRcSOl5uulXDQVNroFhKO1xTgBQsjKxU5f2xwdqmXPjyEU7yQRnhSiuspHs9CMrIceBLt5/52HwpdzHZ/xhDN6R1eMhGU24MslbSPegdrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlAaP4P1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0e135e953so413302985a.2;
        Sun, 16 Mar 2025 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742186016; x=1742790816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIesaixgWl+BebpBLgwAvOeUDO9zCmXs1dgQy4btw4E=;
        b=HlAaP4P1FBPHiLvc0WYxxYSzAC3K1v0ybxOdw5koJtAgnqw+u7HwAofp+kQp6Ea7Ne
         OW/B9gqoYoYhe7iNBZct9PDkiFFE0TRrSN072J5KzVseLuBgpZyQzSImNSK1lUUEEYSZ
         nen98l8NWWbqAjBruW6Ug9IQgTKek84jUfqC2wiz2jxdc8+U3lxY2e9PoZM9jJxLeWXP
         wjkTeGO6dFGyY5QNyWlDu0Up/ql9gC66TQSwqs6dLYMdbJEBRFp/Wgya0wjthh0NajTP
         2PHqKFn648FOCZRdHgC9A/wHrDt/nO/gqlOgi2Npb8EiYhrTKWqApyqsk+WVooeiebnz
         I8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742186016; x=1742790816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIesaixgWl+BebpBLgwAvOeUDO9zCmXs1dgQy4btw4E=;
        b=BqnW47FrUEk5UJKM45eYF6cH9ZTeqI115GdszEi6KHWng6GmtMZYrBGl7V69e4np/z
         9dm9WExRGQimBmzt1TqIwHoi8QjJPuYSt5898qN9NnouZobyXFC+yfEmj+/mYVZX2m4U
         6c4rkXsetxJejZKL89gMNz9FTWsGgmr5zYWdnDrk1uvJMLInEJMAKGTn9HAjPCSyyB+Y
         JB4hWI66Nh/++ravlgneenE8P4F/puh2Y0ciKQ2x5HlgWmle/g4b9FSiCl6LkPp1G5tS
         D/55EJ9TAeLbPZ5xmn0AjtMaCjJcCwABnIxq6izkyLl1VZ9MG9mMx1qAnyUlLDn0U+TO
         BOCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2IUu0KKvs4rN+wAgCLObOMkdMQZnTiyLZhabm3j0BfMsC81z7f4o6Vn5LUl8fUBxCS3mdx8VtdD8O2AI=@vger.kernel.org, AJvYcCXAAD/5EURs5C+hIX/VVpS4POiu4+U2qd5NT8BGW3uR93LkKfUGiNG80V/FX3y5JdBkfCbvgpJuWyOrJywY+y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6yYrwK1h+OLPUVZNpCLtRB/xHGfGSPybqBkCwFZYdfVmiLmJa
	rXZ5G3C2i2xvZqOsc4TNSyX1i7UEdhba0/pjgxEDhZjCJFvFCxIT
X-Gm-Gg: ASbGncucCMQnpYj/lUAlbs1Q1MaPWFczY9kSbzSXvfk1aiUFmf2X+SOJUEHW3JQHk4x
	bcGBx/XB5R2Mkd4S5hpCDep5GV8asUyICEPXOdYEuX2Ozy2qh5R6A3daxdgE/JOlIvi9SMTXiXc
	6jtET2n8rYD2ULjiXC8f7gVt2VArVWzXx8Euw243WuPbmm/XBCoxVs4YyUBwv00Mdrl2vKtCYzb
	38LXioPKxnUPGg3lStPSrYFySps3KZe/Gjn5jfEvaXurW5OEXoaPfd0eqEqqrYgR2BttRGqNU9C
	JjBWDFLQJdR10HE4yUtMGHqmz6PZYq0zlb/Kf4hTNkiDRbhKi5MvNgLIM1cCYkYob6K+pFYPqao
	ifeZoOtbQe0ITSSPgbGAhGDtNCuPCLum02iw=
X-Google-Smtp-Source: AGHT+IG5I6Vi9DbI+6qSR2rvjXqCeeYhEV6rZ0NU36pswnlLcRj52Jdj3cCVnzjbIzSoPppWHGQ5GQ==
X-Received: by 2002:a05:620a:444d:b0:7c5:57b2:2cb9 with SMTP id af79cd13be357-7c57c7bae1cmr1324775185a.26.1742186016361;
        Sun, 16 Mar 2025 21:33:36 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm546397885a.49.2025.03.16.21.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 21:33:35 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 394621200069;
	Mon, 17 Mar 2025 00:33:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 00:33:35 -0400
X-ME-Sender: <xms:H6bXZ6BUlhRXy_7gQQ6YjKwyq9HwAmOmrMnSxM_NKjHyb1JN_YSBBQ>
    <xme:H6bXZ0jkf9_Q_ydxBddC4n7LhKBQ2lCgawfa0y80wZyh4J_XzbX49i1ZJihnqJxtU
    q5rqy3csgewKUrCGA>
X-ME-Received: <xmr:H6bXZ9k6TeofO0XMWkmk4GppPUK6n9LDwhLbWlRSiD1WQhadedxQvT-i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptghonhhtrggtthessgihthgvqdhfohhrghgvrdhiohdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghp
    thhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhi
    nhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:H6bXZ4xwsNjYn4L33eV2GYJ3HX3oFS1NmYoGwZqVBMrnKeIhVwLqZg>
    <xmx:H6bXZ_R3kS2JoL9Bdz07bYBFuuLYau8FqVg-UmPcCwZmXEcBdduzLA>
    <xmx:H6bXZzbni8YBWiqbS6xlP60DWjgAqVHlXr9Gg-IzF7mjKAz-Kjxfnw>
    <xmx:H6bXZ4SHsadNPyy6ma0Fib9Puk4yYisDz9imKpjK7PV3D0MYeVBwTg>
    <xmx:H6bXZxAYuFRdhRLM25WD9qAYgF0lF3zUicY7Frb0akY6dOy72h-y3Thi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:33:34 -0400 (EDT)
Date: Sun, 16 Mar 2025 21:33:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@byte-forge.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/16] rust: fs: file: refactor to use `&raw
 [const|mut]`
Message-ID: <Z9emHTRvgN_goPmQ@Mac.home>
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-15-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316061429.817126-15-contact@antoniohickey.com>

On Sun, Mar 16, 2025 at 02:14:23AM -0400, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
> 
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
> 
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/fs/file.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index ed57e0137cdb..7ee4830b67f3 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -331,7 +331,7 @@ pub fn flags(&self) -> u32 {
>          // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
>          //
>          // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> -        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
> +        unsafe { (&raw const (*self.as_ptr()).f_flags).read_volatile() }
>      }
>  }
>  
> -- 
> 2.48.1
> 

