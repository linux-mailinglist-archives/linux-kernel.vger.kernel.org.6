Return-Path: <linux-kernel+bounces-348503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834998E862
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D71281781
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57017BA5;
	Thu,  3 Oct 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWbdlHfc"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699912E7E;
	Thu,  3 Oct 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921905; cv=none; b=dhRSS7oXLUJdyhYIE+kBttyZHdCfkxNOoKENCWytRtTYT9S7/6BxifgG2aeallGyZOtpcziGJ7SRc06fsaEezHcCB9id82aUMgjQsKHzvoDBz2Pv7UumureRN7bufAe0vXbSP3nl0B8/lHf/BKgbPH9mPW6Jfq8Aq3La3NSzCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921905; c=relaxed/simple;
	bh=CUK9atPBZ9SD/8MLestVcLucWN7g0l+IbLbgyxPWUA8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SkJSd3Kx4b7HhNSeKzZZEPk4QIdkqTnRH9y1QxCmIZLWMdOZx2lr7NygwwMdBaeMSHyiuDCuTI+7ssZ3R/HbsYaImSfDisg+4DkwTZx798ngfB6I2EPHTnEXCScnrluhz7UuFxZiLnzrpcVxf6ftc24doEa4NuOA97/ZMfsXQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWbdlHfc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a23fc16fso46462085a.2;
        Wed, 02 Oct 2024 19:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921903; x=1728526703; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n09nVZcwQ+PNnoJoopGc4HivfewvYeFL/thHnE/F+co=;
        b=HWbdlHfc/mdnTmT5EQY4cKWxcO7CBktdXerGrnMJxQW6pLfjVhcv9ZSxASgD2rY7M/
         8d2Z/DbfuHiOThyvvIzbGwEqsllMs5WQfKn3n5AKJB1rCmryL458/EWt3nSK63ZufQjP
         dEFylF0ugp/dd/0bT3Nz4yeFH23K3vZwYjt1ZHw7LfedQiYSqk829M1awUxj7rozHUU2
         QarDOC2JWSwpl3KVurXMomnVtJbozONZALfzWY572liScPIgFgPAGoJ6jDkRlZhZrvTe
         cdJC1wxY5JSh4hSuzn6frgrMr4P9+kgKMqghlGeHyum8Pg7q7boSBt4cvC6Y9o93kRlQ
         ahyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921903; x=1728526703;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n09nVZcwQ+PNnoJoopGc4HivfewvYeFL/thHnE/F+co=;
        b=NMAk6rITBnvkvQqM/2q13+zz2CqZv63yJOIiJ8TxnOe6ejcU5zBd/Z7mUyBzHDJiXW
         8CCXghK5j/7PSFNsruKwkQa1UP/oLj3djnoikn/bI8nCjhcyJWPfB5U/e+G3UcpFYTKi
         HFdIwbvVtk6wp+hdKxnrHbbD2zITVOrmaWgbJLG7pxl3ZBPsnINGCWxto/DbTbWKK3DW
         LmYm6SUwi7XUcvDuChEFameP6a5i42Z7NYzYhpPeli1qv3OnqM6mb5Jml0g1WjMWXz6Q
         dM178NXZtmuVRLYfysofl6zS6ibXOiXymr2KxM8IwfMiYJrBgwkwwp4euDOws759stjr
         tSzw==
X-Forwarded-Encrypted: i=1; AJvYcCVL957WXg5CPtvGq3L+2kDWOtD8PteFbemEKAW8DWL1iOcEDDdwu8HY8eBqNL7BphNS+TbwHUQSFQ7lcdw=@vger.kernel.org, AJvYcCVef8vIRtdjE9vysH0hYUkyp8wGsZJ9q/BRphTxhMjcR4eWY/ArLzu+woH4BH2X7VBO7jLk5vMJLeb8ufTmULI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLuHVS/10Gp7JK3f+W6JP+o1eAjyk9h1lxgACwgyuzvwma7QJX
	TXk3rjdcoKGREamkkotsSx0yAwrdXJ66Jc6G7ZoWPOp1PQv1Xsir
X-Google-Smtp-Source: AGHT+IFIrVOyYrPVZtxspAKkThpCJGrGlD58si/368nUuJ+EiR902vTNTwFoadriVZbNgqFKS6jsWQ==
X-Received: by 2002:a05:620a:28c5:b0:7a9:b913:2b0b with SMTP id af79cd13be357-7ae626da8aemr664764685a.29.1727921903237;
        Wed, 02 Oct 2024 19:18:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92f0262asm507981cf.80.2024.10.02.19.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:18:22 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1029A120006E;
	Wed,  2 Oct 2024 22:18:22 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-12.internal (MEProxy); Wed, 02 Oct 2024 22:18:22 -0400
X-ME-Sender: <xms:7f79Zn2Xup6yUGZ_Fl1RQkEc7MzdnAw9mVJPYaTgzd6YwlFRQVY2Fg>
    <xme:7f79ZmHqvo6SZxcsVDgJho0ihPQLbN3aZqONxqJVZEGFue8HrsP_94ute8mSnGpzc
    8XmitjK2CcXCt6Zzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfuehoqhhunhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgeekgefggeeulefgudeftefflefhfefh
    hffhgfduhefgueduuddtueejgfejhfdunecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhgvgidrghgr
    hihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhrihhnthgrvghoihhtohhgtg
    esghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmtghgrhhofhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7f79Zn5JqXTYK5-3FdVxNXuV48BMG_6yJTS4lCxdrSdpOgyPumR00w>
    <xmx:7f79Zs3qJg0kyy8r-wmkvWrtUjjUvgG2lkIzjjd_aMixQOvtnOGNUA>
    <xmx:7f79ZqHrxQfnVtzbflqUiWDr1yDacZXVQdyaP_iUkxjftbJsPUYSew>
    <xmx:7f79Zt-VSnjjt0lj4vbuX70rWkidFB6tpVvwwFZ84FV6QNfWMaMbAQ>
    <xmx:7v79Znm7mTiZTA-w0umuImnGuyMpwDhCkDI3dFsfBTVHLdlp9JVQyOkP>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6287B0006F; Wed,  2 Oct 2024 22:18:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Oct 2024 10:18:01 +0800
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>, rafael@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, "Gary Guo" <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com,
 mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com,
 a.hindborg@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <bb2f6786-b99e-424d-b54e-c56d9c7f1f81@app.fastmail.com>
In-Reply-To: <2024100240-wrangle-condiment-3f0c@gregkh>
References: <20241001205603.106278-1-trintaeoitogc@gmail.com>
 <Zv1RhZpQGkVBlLCU@pollux> <2024100240-wrangle-condiment-3f0c@gregkh>
Subject: Re: [PATCH v3] rust: device: change the from_raw() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 3, 2024, at 12:07 AM, Greg KH wrote:
> On Wed, Oct 02, 2024 at 03:58:29PM +0200, Danilo Krummrich wrote:
>> On Tue, Oct 01, 2024 at 05:56:03PM -0300, Guilherme Giacomo Simoes wrote:
>> > The function Device::from_raw() increments a refcount by a call to
>> > bindings::get_device(ptr). This can be confused because usually
>> > from_raw() functions don't increment a refcount.
>> > Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
>> > semantics.
>> > 
>> > The new name of function should be "get_device" to be consistent with
>> > the function get_device() already exist in .c files.
>> > 
>> > This function body also changed, because the `into()` will convert the
>> > `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
>> > `AlwaysRefCounted` trait implemented for Device.
>> > 

This work is because we have an issue, so this should really have a:

Closes: https://github.com/Rust-for-Linux/linux/issues/1088

tag.

Greg, could you add this when you queue this?

Guilherme, please add such a tag next time, so we can have things
tracked. Thanks!

Regards,
Boqun

>> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
>> 
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> Thanks for the review, and Guilherme, for all of the revisions.  I'll
> queue this up for this release soon so we don't get any code building on
> the old api.
>
> thanks,
>
> greg k-h

