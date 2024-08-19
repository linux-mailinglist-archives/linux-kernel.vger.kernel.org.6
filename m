Return-Path: <linux-kernel+bounces-291295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CC95608D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD16281ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145C179BC;
	Mon, 19 Aug 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp6ZKcYE"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0D125BA;
	Mon, 19 Aug 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027347; cv=none; b=R7i39zUWxVYTsYtOpii+OjxAxxg3k7oFMgAR2pStt3f8pHMiWYORUmvODPzQw9nj/j1S4VXMCzqpjRrIBHE/HUhn5KqBzsxCFyXZyGBtxCHM0pRHfTZb7+tcF8n+i7TUi/q6J4b6uH2Xmn7La0VzimnGJbpsAtoNiHciSe1Xeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027347; c=relaxed/simple;
	bh=Oi+NhraI2VmJmeKPZf8UBPFcjWlmlFYhCcnKuzVljZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwsQwdSQ1t49KNQ/uQyhyyktyFkEg5tB3IiNxe4iuIenWqpr0ft7QSe0YsA0AOLFKicCxuhlJCDSBUrKg5ONddElZv++eUWAgr2AVjjMCjgxRBudsQzcnzmqtHn1UxazBS//aT1JDVqJR06FFCZ4nrtBpeuJstFAyQ38UWpX0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp6ZKcYE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1df0a9281so262304985a.1;
        Sun, 18 Aug 2024 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724027345; x=1724632145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C5AzRw4Ng5DlmqxlU3RfYDaBWap+7V+NPvtomq7FwMQ=;
        b=gp6ZKcYEKxRNM5nlI+mvbiJo6jEaT96xe1tcYzKzLj60dVTtn2RQI25rNmF8xnKV13
         dFmfDcY92tlJjRdqBhthjOaVtpc0E0FJwExLVNg8pZA2Rq7QU4JZbhSiGgYVBlJet83i
         2uYA14vMv0b7My8sdwwIfhXiRvR+r+Qx+MEe319Z7QbzisI+lDazYoeyzY7/7DWfjICm
         PiwUnmJnf7HBlsD7CwHVOUrL4ppHxK9THJENjY2mpeX859DXB3z2ML4G8StdQhTNaiR/
         juE/lqAa+qbVZRChL5NZlcU++Cl8AAcxP5HXNYqRe9Y8lHAGoIBOSSgtD/fMcWOqruIK
         P0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724027345; x=1724632145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5AzRw4Ng5DlmqxlU3RfYDaBWap+7V+NPvtomq7FwMQ=;
        b=TSVaVPkKo4ukufMgMtTJ2xnEKqz1RsoNd82HL7AGyd5f4la0McLC4X1xBE66Otd0zQ
         HYsg96Z//g3nch6yjM9dySR/1v5rysptK9kV76F/agi4tcoUK96PZ2H9iL9tR1st1Cme
         vSmuI7jpGVenHgCt64PeN9MKiRMo+QCgGGbaWni0nHlpqxqv/2hL5MS6Xra1MG0mSdSx
         74a6ho3jfFEh10MuBh3YM07HmyyaCPBcIac66/9xcl+zO4bcAH4LEhMA5fTcHFzB48xL
         H+J8IZLaZauAYBi1XC632L/4bJ6U5KBKaXQsvRvgEhKsYwTjk/cylWA7PMlUucrr21gq
         TMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWj16F7ZcCGDMPmNgFOba1nubdl5ypS62JKYrrEhzsBNKRaMOTAkjyblyN9X7diqNGsaXoj1vee95q5S0mSnfQzEXmYUiMlsS2Gocw3OSux5MFPgrOnq7U4XLtLSTS1RUEqbHQVpsdTVsfsQX8=
X-Gm-Message-State: AOJu0YxyBOBaX7ZtiYsKeBa5OIp0XJNdHGiYHjrCdBmEyVIRm7sN5eMk
	F69YQk38Z2D9enToqtscLZQz/mqWNQ/VAtKMjhLsLlUgW7Vyo2b4
X-Google-Smtp-Source: AGHT+IHyg3d0sd7EOkoXZNh7PYyheSgaE/cf9pEAgw6nG1HNq1wcYHflrlmiHCm3ngWESSZjYZFp1Q==
X-Received: by 2002:a05:620a:2903:b0:79f:104a:ba4e with SMTP id af79cd13be357-7a506901bafmr1353451885a.13.1724027344585;
        Sun, 18 Aug 2024 17:29:04 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff051b84sm387503185a.35.2024.08.18.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 17:29:04 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C0F141200068;
	Sun, 18 Aug 2024 20:29:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 18 Aug 2024 20:29:03 -0400
X-ME-Sender: <xms:z5HCZt4x7y6dp95AenBSAeGTrAOM0ay2kMnaVVH0du6GvCRgKffIlg>
    <xme:z5HCZq7LQ6dwcpbcR-xV_-4mHD1geVH45urLu07jTfXscFOfMZ2_QLhXfWsZXQ87W
    -riBEossfSpeI2Y2Q>
X-ME-Received: <xmr:z5HCZkdlpMDaOKwxECwm4GUOnxRRUIMV1O6sMxijzaOWQChBEEQwveJeRkyVxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnug
    honhhishesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhn
    rghfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothho
    nhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehsrghmshhunhhgrdgtohhmpd
    hrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:z5HCZmJVVO2p3fxktUEVE8iAnVa74nMUEEe81hfFayt50GuZ1AEkZA>
    <xmx:z5HCZhIrOsCTnsS6pJCnF13ur28IlUpKUd-Hn6OvAmQGB89SVjHO1Q>
    <xmx:z5HCZvwe9ewDibH2lYKodf7wj_acCRcKc6ZoYgXGms1b2pVnD2L3sA>
    <xmx:z5HCZtIqIqmMItP9i-_CECVWpu7c58Vm6EVg1Y6q7Xv4ilb9mP_OpA>
    <xmx:z5HCZka0TVTs4bM1WoJpoqYlBY0ZOh9rMtFEd6iZ4oQvN3c7tBqV3k9t>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Aug 2024 20:29:03 -0400 (EDT)
Date: Sun, 18 Aug 2024 17:27:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
Message-ID: <ZsKRax0h-Fes3mpU@boqun-archlinux>
References: <20240817165302.3852499-1-gary@garyguo.net>
 <ZsFEpjvE9osKDb3b@boqun-archlinux>
 <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>
 <20240819005637.47e7045f.gary@garyguo.net>
 <CANiq72kGyuhthMQA7bLaVduUS08AuVf-805_e0w9_vwBp0JcGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kGyuhthMQA7bLaVduUS08AuVf-805_e0w9_vwBp0JcGA@mail.gmail.com>

On Mon, Aug 19, 2024 at 02:17:08AM +0200, Miguel Ojeda wrote:
> On Mon, Aug 19, 2024 at 1:56 AM Gary Guo <gary@garyguo.net> wrote:
> >
> > It's the mistake on my patch. I noticed the exact issue while I was
> > trying to rebase my helper-lto patch :)
> >
> > I believe that reason that it builds fine for me previously and for
> > Boqun was that we didn't delete the helpers.o generated prior to
> > applying the helper split patch, and we know that kbuild is not
> > hermetic.
> 

Oh yes, that's the case, I have a .kunit/rust/helpers.o created at Aug 7
:-(

> Yeah, probably it was that -- as you say, it would require a stale
> `rust/helpers.o` from a build before Andreas' patch (and not just
> before this patch).
> 
> > Your rebase and the fix is identical to the one I got locally, and I
> > can confirm that it compiles fine for a clean build.
> 
> Thanks a lot for taking a look!
> 

Let me rerun your fixed version.

Regards,
Boqun

> Cheers,
> Miguel

