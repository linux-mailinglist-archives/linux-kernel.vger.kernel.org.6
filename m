Return-Path: <linux-kernel+bounces-210219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B19040F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D982D1C23FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DE3CF6A;
	Tue, 11 Jun 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0YXyceM"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4C3A1DB;
	Tue, 11 Jun 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122406; cv=none; b=OU+gJ/WpmpA7R1PEAxEtmXAkJp83yQweFCFcHinxG2kpzziXDtVBI9xfLVLo1LrxOyentJU/1F9HgXB1yxpza2wBsAhlr3BdIhIhwHS9jGI1OOueG/C7LceG7SknmWeGUa5PK0t7jTPkAnW7JXBm4ecMnY3lRY6o3pDNXt82RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122406; c=relaxed/simple;
	bh=F6ZD0XFreojkJRIifp45Aag+6kPp9Gpgrodi6PHSTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdsPN1G/xRwEOouUc0eurIn1ZXVOuYZk8c9Pni8tZBS2Jxga7CpXaMZtslDnNvq8atgyL3/XjcWe1upCSbzcPACPvuNFKc6vaZSMBwAmpGoUo+7sHCO72GBAb6JHVPww2GcPtfKixhJCbpK20xf19Tp9YDtsgNzo7R+9zO2ZfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0YXyceM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7955e1bf5f8so152060885a.0;
        Tue, 11 Jun 2024 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718122404; x=1718727204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3qkehPhiEg5p5Wsrjh0SlVJ72RTKHPiKpUZCPq0j9I=;
        b=e0YXyceMdUpHdebQWghzJ6t3zpW7zu6S6hut5iwNFoAzo9z2iWvFuH0ur02D6BW60b
         M1dcyYbO79YQDlPE3W4UPtdyuGpzYbEXxLHIxFjkG4OnlsCidobBU2fYPy5wE0K55Q8n
         T/UFFO8HlWgdkc6CLyWhu8SnWghf2LLjWxL3c0oqGiVAd3d64aX3f0dkao+ekU0Biycj
         W/JHlejdVPlYm63lbfsYN6AT86T3XrZdRPoznp+XLjluTJbZp5GYTbnCcqnJho5hWdqU
         K8PLbQEYerj/vKUNUcehVj816XWviNRDr5D0AJNUSA3xugHpSQks+FnedQgFxSmVITtv
         hTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122404; x=1718727204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3qkehPhiEg5p5Wsrjh0SlVJ72RTKHPiKpUZCPq0j9I=;
        b=V6wVmCcE2jQKgnfEXtwgHov0n6FXgIx9ayvPbctmH36fho0fBR+bruC8kJLo1LNYlW
         89UOQjw8UpuO9G7As3YMmUfnn7f8oScogjNOpTiFG0dFoWDazW6fXduZJZlRXSVVJDKS
         PZpacguDBIta+iSl2UnlyG3nX8C4oY9u2c71sgickJ6gLhlgutqBoIRk19Am2Ed3zr9t
         hxGpi7qE+AV9hPMS1qKmt9pCzKA6zxaZQuBx6O44v+aPqkbMHyA3ZrDvJP+SXFhqdjjI
         G8jFcHlLBa024tWXSVPiieIFlq7YVTBMEhNa1Tgkqo2xIx4ERG70eeEpKFMGYoh5raQr
         ZwIw==
X-Forwarded-Encrypted: i=1; AJvYcCWt/6kujvmeZc8bXQaF2AECcN6jOhek1HMiwX+WQb16eEcFAPQujQ2UC31grex0GoI8V8GidioV3W6AHdDZ+nvmdzL/Hxx6Uk/qWjWcPMWiRGIWkydoITZe57SDMD1poLwiywdOsCSiNU5YzzE=
X-Gm-Message-State: AOJu0YwjEJgtf5XNyDOxolLjmKPU7WolnzeLh/EumCHO3t2baoGtiuYx
	YtReTkX68SfHoq/RuzngVM9d6SSaq36tfQUJ1VTn7tvEAZQuqWX2
X-Google-Smtp-Source: AGHT+IHuMnB/9CF0x1BTKPGYThx2Q2dZ6rtKgAawF98s7Wp7i/7IZNsMGas991xqX5HKOEmsIN02Vg==
X-Received: by 2002:a05:620a:1929:b0:795:4e64:dbbe with SMTP id af79cd13be357-7954e64dcd5mr1422885385a.0.1718122403850;
        Tue, 11 Jun 2024 09:13:23 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795758dfe3asm230193485a.105.2024.06.11.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:13:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A61561200068;
	Tue, 11 Jun 2024 12:13:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 12:13:22 -0400
X-ME-Sender: <xms:ondoZqKEt0cp8gXpwBJGpQmzTvQlV5dE_8Q1qanXEdtJWBLKoSl4qg>
    <xme:ondoZiIhm3M3nS0FuqjAR5VQ-ac_nSYeR5UDmtSWPiGkuLbeiLdmzCcmrTeUHU8wW
    G_X2Rk9DRa-ukMR-A>
X-ME-Received: <xmr:ondoZqv_iZdTAh06QYdDT5pnECD57x5fFltEVN_RpGirwPmqZ8vNQma2NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevieeujefgtdetveevieevudegvefhvddvkeeivefhgfejgedtgedvhfek
    veeufeenucffohhmrghinheprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ondoZvbp_MEHFEZAazs5QcsTClApVBaDj8O5q7PmVMsfZMeL-rtqJg>
    <xmx:ondoZhZm7hFVdZqgy1KN9jOwHFbIyg7AvaPpOa2FsZozITpIQ-Do-w>
    <xmx:ondoZrDXZ4MJ6QImEXwUZypYwPP5dcBVTwnbdwLwbCtanKdtJLNYrQ>
    <xmx:ondoZnaH3CcP3Jo4EhNej9tTpeZveqPmAxZsG5c8B2q3fDjy3ZgDeA>
    <xmx:ondoZhp-EliidevCcbciZULB1TjI_OJLaX4LiWIVST7DAljUNjzWaWaK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 12:13:21 -0400 (EDT)
Date: Tue, 11 Jun 2024 09:13:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org,
	mcgrof@kernel.org, russell.h.weight@intel.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061136-unbridle-confirm-c653@gregkh>

On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > that `->release` must be callable  from any thread.
> > 
> > However, this is just theory, do we actually have cases where `device::release`

@Danilo, right, it's only theorical, but it's good to call it out since
it's the requirement for a safe Rust abstraction.

> > is not allowed to be called from any thread? If so, this would be very confusing
> > for a reference counted type from a design point of view...
> 
> What do you mean exactly "by any thread"?  Maybe not from interrupt

The `Send` trait here doesn't really differ between interrupt contexts
and process contexts, so "by any thread", it includes all the contexts.
However, we rely on klint[1] to detect context mismatch in compile time
(it's still a WIP though). For this case, we would need to mark the
`Device::dec_ref` function as might sleep.

Regards,
Boqun

[1]: https://rust-for-linux.com/klint

> context, but any other normal thread (i.e. that you can sleep in), it
> should be fine to call release() in.
> 
> thanks,
> 
> greg k-h

