Return-Path: <linux-kernel+bounces-311728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BC968CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7561F226B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606661C62A6;
	Mon,  2 Sep 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0BULlK6"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD35183CBB;
	Mon,  2 Sep 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298478; cv=none; b=kmBBO8R0CpKxtuH4Z9Sv/LRdKLYoYK79Sz4MxtgRjoOHSmb9ry/gsH1EP9nvGf1ZBh+m/1TIPPKdiADoUdnon4eR9Er36o7hDvUj0l+g6zJ8elTW9TbnCyuoL6RjZffVMOxWicz1EPgyYXNgUv3YRT6uVdGaNg8kn3hJ3CcSEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298478; c=relaxed/simple;
	bh=/aE3rUCzqfivHDz57aoxxrwJGJedyEBIS0a4jyGmy44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFS+2hwHxBJ+JnOF00cCQTB28eNVL/AdBFGnz74uGrtF/vCMKDxFRR3OoHI/PKeCjdnd5lDwe3BkoB9W8GpaBGncE1IHMx/0BLkL8NtX49DkeNiGI4y/wM8taRuwhu1uiwKr0XGrtFlvbFxp5npGwkIvSfZaSqcMkdE/R5KyXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0BULlK6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a7fd79ff63so288182685a.3;
        Mon, 02 Sep 2024 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298476; x=1725903276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ni7L3kM/YoD7zuQ5cZlonrzVbpTj6RV3XlMJIwdlsA=;
        b=d0BULlK6okf7A3v0Ym8VIgurwK4Hj7mSSR/KZDA9RrtG+RzXjmr6CQAhM2nDCJSv2w
         jQR+UZQ6eba6hgwVRa4/oTSltsPtr2uYP588QRJJeB5BnkZMcTVcrVF30nBEHEvs6V7Y
         PS6rNCJKhIRjeCvteGMQ+U+Vzth44ilrK8fTxQdWLbm3Ebfj+kJ+OsICU2ofLYoqt6g5
         rxQ8bhLbgGQ753KA44hAsllAWl2qwKJG3HLYTyLloU7/YbwZAynkaJm7Y5A/0sHuzmd8
         sK9D+8lu3q68VvR/lOV8PoGTfNXIm5d1m4sRULDSVkF3LA1MxDMXXjhVA019vFDT/aKV
         YGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298476; x=1725903276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ni7L3kM/YoD7zuQ5cZlonrzVbpTj6RV3XlMJIwdlsA=;
        b=kpeFAWBDttovJc/anZxnmhpZ7xh2S9FdpRMGtV8/bB7/2JCz5AcRKu6ZAcpCmSzlxk
         28zU8xqiyB/3wSwJV9z8RbXRGu6OVVXQIYYFUUJ2W9VRvJaz6UxKZQ+PkrYeRDn/cFNz
         GFDnOQaKmmFStyOjtRNihDWUaWRMW4QphoSn+Z1baiympd8pZGqZlprMD9nWj+4u1pJb
         zDIvA4HHxFcGIenEcU/732EoxVsQ3iqv+G3g39KgaNlbSs0IbFnaVJ3CLYe8W7UpvLWs
         9tIU4XaCKjPFvQ2WjTPg+BerHTeIpuG4geFyKLXpBqfb4pi7CBNGgRbdkhXkO1JAiMIB
         8djw==
X-Forwarded-Encrypted: i=1; AJvYcCUi3+L3soUMbodtrNIPKcdwHHbaoeYdMdqRJy3xkmhayg/b1RXY/e2FKb6Q1wMvVWCq/VGpXc8/MmPJlC4=@vger.kernel.org, AJvYcCW49mhlUGa1OawT2Pxj+5FpD+4uJJd7dwjrhRCfa7Iu9igUUTTB/QIHigQdY5ZnPmGy495MI2AcIycokSfI71s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRPdzeXvT44YfVzsTqu/wBnzaAlm5bTZH/DR9We0hxpo1XWWC
	j6cuhQZ+9bWkQJ6AhN1CA9ek9++nO6gx8NUhiZi4YCoar8dasfF3
X-Google-Smtp-Source: AGHT+IHiqz8Kr6eDFRMESPZRCkOtuyf9LYRm/wTO6K1vU5/lqNBz3/ZIn1q1o0JaJpbDVVwK1S5qUg==
X-Received: by 2002:a05:620a:1724:b0:79f:1098:a949 with SMTP id af79cd13be357-7a89322eccemr1059275785a.4.1725298476009;
        Mon, 02 Sep 2024 10:34:36 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d5dcc8sm436460285a.105.2024.09.02.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:34:35 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 13A6B1200069;
	Mon,  2 Sep 2024 13:34:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 02 Sep 2024 13:34:35 -0400
X-ME-Sender: <xms:KvfVZujk7PTwfBQXigWE0s9cBWxyWO0R1thJjSpxvdiKcQFbARwSjg>
    <xme:KvfVZvACXJzvqCl5xlzI4HXU1Ar2bbqlrEVX0VtVnERNfsW3wgolkQ0B57V1ms2yL
    o4m8ipMZ4g7R5zWsA>
X-ME-Received: <xmr:KvfVZmE4cQpxnM8isT2ncUlhbOFDGHbr9HuxgH3ujnIDVFUKUUHxs8v6zfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfehgfdvffejtdekvedtkeetteffuefh
    kedvueeitefgveeggeetvdeuuedujeenucffohhmrghinheprhhushhtqdhfohhrqdhlih
    hnuhigrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvd
    eghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtgho
    mhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegrlhgvgidrghgrhihnoh
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsg
    hjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhn
    ohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorh
    hgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhg
    lhgvrdgtohhm
X-ME-Proxy: <xmx:K_fVZnSTK4fG6Ns38ua0W0WBJMrJCWwy-1-TPhyou876x_98vL07PQ>
    <xmx:K_fVZrzEO3c5HzTxD83gAWxGWMwl8JjYnplIGxQvVotOeqoukrQJ-A>
    <xmx:K_fVZl5Ial1Rr9Ioax2Tg9OhZYdY4KL1CFDU-_IXvMYrcM1fJxqLxQ>
    <xmx:K_fVZozVivCExCPvGXoL_O8gBhRFFwlQoY0omRsU0NuyXdtqlutsJA>
    <xmx:K_fVZniBuXQkFGdC3ySyBy3KoAjVFo6Y6ElV-Y9ZxLmMXxOuw3U8Z4Xb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 13:34:34 -0400 (EDT)
Date: Mon, 2 Sep 2024 10:34:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add Trevor Gross as Rust reviewer
Message-ID: <ZtX3Kf8LPkwjdq5S@Boquns-Mac-mini.local>
References: <20240902173255.1105340-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902173255.1105340-1-ojeda@kernel.org>

On Mon, Sep 02, 2024 at 07:32:54PM +0200, Miguel Ojeda wrote:
> Trevor has been involved with the Rust for Linux project for more than
> a year now. He has been active reviewing Rust code in the mailing list,
> and he already is a formal reviewer of the Rust PHY library and the two
> PHY drivers.
> 
> In addition, he is also part of several upstream Rust teams:
> libs-contributors (contributors to the Rust standard library on a regular
> basis), crate-maintainers (maintainers of official Rust crates), the
> binary size working group and the Rust for Linux ping group.
> 
> His expertise with the language will be very useful to have around in
> the future if Rust keeps growing within the kernel, thus add him to the
> `RUST` entry as a reviewer.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..77b395476a80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19914,6 +19914,7 @@ R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
>  R:	Benno Lossin <benno.lossin@proton.me>
>  R:	Andreas Hindborg <a.hindborg@samsung.com>
>  R:	Alice Ryhl <aliceryhl@google.com>
> +R:	Trevor Gross <tmgross@umich.edu>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://rust-for-linux.com
> 
> base-commit: a335e95914046c6bed45c0d17cabcd483682cf5e
> -- 
> 2.46.0
> 

