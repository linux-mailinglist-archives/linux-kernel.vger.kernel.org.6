Return-Path: <linux-kernel+bounces-272643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC9945F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD896B2144C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7DD200101;
	Fri,  2 Aug 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvh14qT5"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4891E675E;
	Fri,  2 Aug 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608459; cv=none; b=pSxp8ud3rVMwK2RQO+exXh9ZXYamyKPrzFMFXZVSQf7eDlEgy1jCDHN6WxtBMGzYnFQGL4KVgO5h6gEf8fVAl9O2Vmc54K4dNQXlZqvkwzlHHeKA7tKHtfwzzPiy/K0wfQCzimi2+JTSTZysYh3YzrZ1mmsTncyIqLIBCHzh6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608459; c=relaxed/simple;
	bh=2Kymamk11WOD8rnOrRmPds0W4hbW7wudYniLHvRIzSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk6H+Pib8oEFSMUNfF9NgLsjgvnIh0ZEH1yuDd8fZQuYaYFGywj+JZWIz5YHuXOMdP32iDrnrVNV8t687Jdfi2FYbiUn7O+nnN+7ejuQhtsn00u/MWbrveGKlNCTm3ovCcHk0iEGEdvjfFZ0tfqafc6WXCYkjU74LrmvMg+dFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvh14qT5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fe188d25cso29208231cf.3;
        Fri, 02 Aug 2024 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722608457; x=1723213257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Aj+cOhj6fWjHbOXBRNHu2NV1As7NWdRG5jmqjIx7c=;
        b=Qvh14qT5zDx906Ty3FLE+aZ5oaV++NZUUCL+cBLF5JvftvtBpNm5YZKzqqVT+cfxLM
         BN8Hpm6wOF9jFoVYdr7G7VZnZ7rL+UYIcuLVs6edfQr5eerf8HBH7c8SBf4B7FujFeId
         QvSAR1DWQ49Q+CVrENKK9g7fxZCVwhQ2MzBgY998IKOF9jtJf5PLf+7bHS15N7T8yj/q
         g4cXFRHpH68HjzmEiQOu7M35qjtLqqhddLk2jmEtDMuMJm387uVTL+10wX3Eqje+7uxQ
         IvYTXQdKhRnanWWabsHVkdyH4lIXo8Ro9c+tLicpaNHbHM9wM99LqNZHiFDN0hq1enOu
         XZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722608457; x=1723213257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/Aj+cOhj6fWjHbOXBRNHu2NV1As7NWdRG5jmqjIx7c=;
        b=CYUdYvDzFgpwi5FNVNv4Sf+OaD7k4Rf/pJecRMWzthRkIyZNVO/0X2YjH2H0r0uHPV
         sEyjQxT24veMVGi2mIi01KwyT3akYbiixuazqRlJNowBAzMHr1xV1yI2+LCA+1J8uv+w
         bdZ6csuE57Dt6m0MxuB64gwTDNzGx8I8lxc07NXX0EjVoTlW2gqVmJIQCA5y9x3yDaJP
         VMWc74+Q1CKx6OYVzQj0o7ZPMPkEsmZhbA3RNjn6iO+h961CY2GbDCBA9yiIaPDFycmP
         pPHfQ/UciXKprmjIoXWmQJXvPKfhz4X4JrIyYp8xfIgmxXsHezx3pLwNHBU59QlEjv4r
         zNHA==
X-Forwarded-Encrypted: i=1; AJvYcCV90MOBjhqi4gwMgVYLjcbQnBbqAETtNcw4u9yzp/G1ZeECtrsvHUAAUWNlm0O9npyW4685TaxG92RyP4X1lSdp8cvWtU06CZ1W3pKU+hxwU59y5GnzUfhIIKOSGpuPo9AuXW5OXV9478S4gTU=
X-Gm-Message-State: AOJu0YxGvK9ijadTj/YjCuANyDbK1qRovtOQYU6TS5JoT4Izo51M5pJ5
	sYR6MyAunbatxMnE+WzR9TS7MhPm9WyV5/OQ11Z5Rw7P1ZpN2ibh
X-Google-Smtp-Source: AGHT+IGYsdNpvcww/DdGLjPvpxF/cJtWqthxbgg6K7qnEWRHjA26hsZ4u2Xysg8+gRDe8ELpQb2ZOA==
X-Received: by 2002:a05:622a:5794:b0:44f:fb77:74ce with SMTP id d75a77b69052e-4518928df7fmr41673291cf.47.1722608457010;
        Fri, 02 Aug 2024 07:20:57 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6c5080sm7544581cf.27.2024.08.02.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:20:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E89421200066;
	Fri,  2 Aug 2024 10:20:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Aug 2024 10:20:55 -0400
X-ME-Sender: <xms:R-usZuv88RDC2Ollm6Ip8E5F1nzNPS0uTLVPBruW-916_Ay5tU-owA>
    <xme:R-usZjfu3dpzI-9I9Hl58hoptbM6MZZPvsSHtMm3nnCh1ygJM19SuFNciILdKaiqq
    EZsGt5uGnd-UtLXOw>
X-ME-Received: <xmr:R-usZpwvmNi8Z3MwnaFO1dInqtVYlXoe7dHMWOQIxQIyXPbxlkBAyCl5ISgyQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeeh
    vdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedt
X-ME-Proxy: <xmx:R-usZpPZRWTKwFrqBdyMMyjIIzz_1qGM48ks3mf2r2P1QXevQftSDA>
    <xmx:R-usZu95_7wh7iJmjIIbVFnuf6OIv5kdzbmJTeUxtEq2HObqdDe3RA>
    <xmx:R-usZhVBjiuEur7rjyfyL_ABoazn678EQYlGN6FNVyyVvRB2Balr2g>
    <xmx:R-usZnclBAJKTbMI3x0XHnnqPt75XNyKS27GjZUsARrsgKYQ9vpbBQ>
    <xmx:R-usZoeq0VkgecjcFoux6xdD2OOWPzK2pzWWf4hJRGJDBntIt-6I7kVb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 10:20:55 -0400 (EDT)
Date: Fri, 2 Aug 2024 07:20:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add `ARef::into_raw`
Message-ID: <ZqzrFEbBAbHmil-j@boqun-archlinux>
References: <20240801-aref-into-raw-v1-1-33401e2fbac8@google.com>
 <CAH5fLgiHc7azNtwTKNoLP93-APMqkK6vGFKYSEPepWoyNgNjrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiHc7azNtwTKNoLP93-APMqkK6vGFKYSEPepWoyNgNjrA@mail.gmail.com>

On Thu, Aug 01, 2024 at 04:45:02PM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 4:17 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Add a method for `ARef` that is analogous to `Arc::into_raw`. It is the
> > inverse operation of `ARef::from_raw`, and allows you to convert the
> > `ARef` back into a raw pointer while retaining ownership of the
> > refcount.
> >
> > This new function will be used by [1] for converting the type in an
> > `ARef` using `ARef::from_raw(ARef::into_raw(me).cast())`. The author has
> > also needed the same function for other use-cases in the past, but [1]
> > is the first to go upstream.
> >
> > Link: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Actually I just realized that there's already another use on the list in
> https://lore.kernel.org/all/20240725-alice-file-v8-0-55a2e80deaa8@google.com/

Yes, I was about to point this out ;-)

I picked this up in rust-dev and rebased file patches onto it for
testing purpose.

In the meanwhile,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

