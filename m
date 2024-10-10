Return-Path: <linux-kernel+bounces-359576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4129998DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D8BB2DC12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF1194C6A;
	Thu, 10 Oct 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI38lFKf"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81426AFC;
	Thu, 10 Oct 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578025; cv=none; b=CpGWhkXczLodmPWWRJYqo6mtSEg+cMMO3pBiPAmcO/FgtGnuZWvg4wHT5c0VL7PjWhvObgBZHoX9yA2Kf14EnH6Lt0O5ezdIRORjXshSBK+DJ5Jgtnw1Gv7gi2y8IQDKQaTYvYtHMfin//SWoTKEM9Qcmxwl8trl8rauo/Bl6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578025; c=relaxed/simple;
	bh=nQxQuCyNLvM7c8C5YHV8IYnaTTpl54QLwHyCbE5wCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMqtlROZHqWR8J4bKoUQPI1QPsIKPMpWY142ToMFM2BfepWvXaR0aWbscvAqhy8/eq1W0U0xwk91COFVjwf76q8zh0Lg5ALW5qE0guFJtwCYBSTCVr0pnHJbRu0Fl4ZU3bcF78mSXjtWw9DSfOS3OZCCDJuBEEhqEJJbO7VIWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI38lFKf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46040dadedfso9918421cf.1;
        Thu, 10 Oct 2024 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728578022; x=1729182822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ap/DDc8kuqz77lnzLfL98iJe2JYokiaTh5ptYL7t4o=;
        b=RI38lFKfjSUMJZ3W3FXdoQ+ybjfjKkuWSo/OtS1nv9VYA/aw4S4tXJd+1f2EmQv8bk
         /xbo7GxOlA4p625KllLxeithmd7V4L9jDGQjM1M/N9L8zqv3/ypN0JQkpMuAvYLl3k6v
         1a8K8PnBpPvhgSuwJDZe8TFNAT8Mf6toSiF2pAw78v8KvNlerojvVy4SRvp/epywNtbG
         NnWYOZ/xYT3nYRaSxLsRIRtgXxsiAyEk6aoHBYkdWi0RCxqqU6EOKdEV3HSkTOYjqk7h
         w13j5VH+B7mbAlZPXT8fnjaM/siLJSarAE5uV46Eaw9Rto4YpPrUYOP3JyWs36A5QAMl
         9A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578022; x=1729182822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ap/DDc8kuqz77lnzLfL98iJe2JYokiaTh5ptYL7t4o=;
        b=khsFmWGilBUG8eANxTkqrNLk2sZJBT7D+baiNk46aFAeRRYZOMEPqFFFqeVhMB2J/7
         1jcXwv60dCdMASbq5L2kp8F23lafe7g94MM0GK6ATo5Fm52kVHnn90c9zHt0SAV8CKFP
         nzmWqdxFIJBHah2JhhWxVR5alXwtHwt3B079WmYdyZWO2KfC/DATmE0BpOzqwlLI52W3
         guIAbtWuidWo+uZiuxkajWYDdPgLo5fpqQDKz1iEO51DlZ3YIQQpEBYqfTo9Z54fUcQN
         NbkDI70zHWPpPj9tfTImMyjlIfaTnH1KxisxaUH9FphZOYHFUVMRCJCkrsrM0fzc1BQt
         vTEA==
X-Forwarded-Encrypted: i=1; AJvYcCVCjpYHJadRGuncGwI5wJD0r17oIaPEabHa920BnBxwi1wf/Bawi7u6zRWBdwYLxIOXXyPNfsL8cFai2y86biM=@vger.kernel.org, AJvYcCVShAyiebR5uQzYcqREc92h34JHtj6BgYSLBVWi4YRVKWlFO0Gaz1dzlLN/Zm2KJE/r39bMV2g0XZ1m8F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ykDwInnp9RdL3U6UVytdnsNdcUN/xKCvTtFbnSBDZvvJp8oz
	WCP3oJ2ztOlY9Br1orp4wy+oGma1ojgqQQjZYfO6+jlKPgK4W4X0
X-Google-Smtp-Source: AGHT+IH0HDczu7r6Iahu/AR9mbinNIOw7dhj0wuxq+J43R8fWllG6WZbx9AKHCFSy1+ZV1CC5EVfjQ==
X-Received: by 2002:a05:6214:3912:b0:6cb:d1a7:aa1c with SMTP id 6a1803df08f44-6cbd1a7af0amr69865686d6.40.1728578022335;
        Thu, 10 Oct 2024 09:33:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608dfesm6774776d6.88.2024.10.10.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:33:41 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71807120007A;
	Thu, 10 Oct 2024 12:33:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 10 Oct 2024 12:33:41 -0400
X-ME-Sender: <xms:5QEIZ0issXTuQ0wPdnlKrHmz20ncx7ngrF-aDFXU9ewtIlMKocoxMw>
    <xme:5QEIZ9Amxdp1Mae5YBau0ZIq_3DDdU3wa9tXNYnadMwWj5a1Ml4IHMBlkVMvLR4S6
    anT-TmxAW_NQs1SkQ>
X-ME-Received: <xmr:5QEIZ8G-8GWvpn_Zwv9Ny_JyU8L2wcHEMbCJ0SvcWYRxsfa62nQZFUNJdbEMfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:5QEIZ1QKsi-LRPCXnKFTM3jrRo2k-5TBtqX7riQKaSAiB7RTUzkMeA>
    <xmx:5QEIZxyiyd1XLsLp-q3s7jyfVmVLElsyFXpYuhtvDr9iYStuSJhuhA>
    <xmx:5QEIZz7KNdEe4MQFFKC_dCJezKi5JQhWZZ2XGBSp75xhOEfgxVBezw>
    <xmx:5QEIZ-xhYA_53iKhg89cZSrqpkBGDvhlBSc6I7AvXguYCKA5VcXioQ>
    <xmx:5QEIZ1iGRBoNWMb2v1q7c50rHiiCAkBzbs_cURHt4-x8DRUPgCVv2f60>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 12:33:40 -0400 (EDT)
Date: Thu, 10 Oct 2024 09:33:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <ZwgB39dXLdFWQkHz@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
 <Zwfcwg23tfrKIyrq@boqun-archlinux>
 <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>
 <ZwfkzKz5mz6UvZfK@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwfkzKz5mz6UvZfK@boqun-archlinux>

On Thu, Oct 10, 2024 at 07:29:32AM -0700, Boqun Feng wrote:
> On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
> > On Thu, Oct 10, 2024 at 3:55 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
> > > [...]
> > > > > > +#[macro_export]
> > > > > > +macro_rules! global_lock {
> > > > > > +    {
> > > > > > +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> > > > > > +        value: $value:expr;
> > > > >
> > > > > I would find it more natural to use `=` instead of `:` here, since then
> > > > > it would read as a normal statement with the semicolon at the end.
> > > > > Another alternative would be to use `,` instead of `;`, but that doesn't
> > > > > work nicely with the static keyword above (although you could make the
> > > > > user write it in another {}, but that also isn't ideal...).
> > > > >
> > > > > Using `=` instead of `:` makes my editor put the correct amount of
> > > > > indentation there, `:` adds a lot of extra spaces.
> > > >
> > > > That seems sensible.
> > > >
> > >
> > > While we are at it, how about we make the syntax:
> > >
> > >         global_lock!{
> > >             static MY_LOCK: Mutex<u32> = unsafe { 0 };
> > >         }
> > >
> > > or
> > >
> > >         global_lock!{
> > >             static MY_LOCK: Mutex<u32> = unsafe { uninit { 0 } };
> > >         }
> > >
> > > ?
> > >
> > > i.e. instead of a "value" field, we put it in the "initialization
> > > expression". To me, this make it more clear that "value" is the
> > > initialized value protected by the lock. Thoughts?
> > 
> > `uninit { 0 }` looks pretty terrible IMO. Can we come up with something better?
> > 
> 

how about:

        global_lock!{
            static MY_LOCK: Mutex<u32> = unsafe { data: 0 };
        }

?

"data: " will make it clear that the value is not for the lock state.
"uninit" is dropped because the "unsafe" already requires the global
variable to be initialised first. Or "unsafe { uninit, data: 0 }" if you
want to keep the "uninit" part?

Regards,
Boqun

[...]

