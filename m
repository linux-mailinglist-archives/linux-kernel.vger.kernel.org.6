Return-Path: <linux-kernel+bounces-520975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A6FA3B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD411896E81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FC1C07F6;
	Wed, 19 Feb 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpffJIWR"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD891BEF95;
	Wed, 19 Feb 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948722; cv=none; b=LD8sI4INayA+SIag9YiSZwEwdWVTZssEf+obslDiiotuDeBTcgNAqmrpK5CXL7hPMHGZgionvZ9+uYafAeMnpS2O65fWCW8goE3UjR0vNLFB/7hPwfUAAuSXeVdCM4ZSbljR18mUZG5xoUIVu9aoVmDcuTHbycX5TK3m05hUThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948722; c=relaxed/simple;
	bh=FEqzqA1JniSzrQgsbCgTp05lnoy3SxHbt9/3jeLjZDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0SuqaYomzmJK1EBbmL8kJKoXy3kyVzo5AIzgc96FkmGFdcovDtlILUDaEkFHhidfspOcuX2qbzlJ7agDoO/xiQEiOl7T1IsLLQuGiOJwY4XXW2eSKzN/c2Abc6jOW4GwQpalMBKg/iZ2se7CcDqZS89sO8XtA6pSvhx9gpzr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpffJIWR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-472087177a5so8847321cf.2;
        Tue, 18 Feb 2025 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739948720; x=1740553520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dpgoJ1SsdygRr/FpJ1lhm0fZp9b2UMRqLfRvgPfCdM=;
        b=QpffJIWRcXlKaF7ODV2gaPW6ZAW9RD3/lFy05yvGfV9OPPVHzJS4BhM9QvW6tfJLV7
         iIn3n/b8MLedInQyfyq7v454w/kDN5o6bSfuIgd6C85uL5S3ZYr3l3hUwTykYH105amu
         /3bbdj+KgMHvetztR6tstyxuEKXHS3EQqcJ6QU0ydBDCq1xQk1jbEGX28kF/iUp2EPw6
         Ej2HjokhjLg85x6Nx8cOebQt+xOSufYj5IaDGADI7S1sxwyyjaoNoqKYyx0mbmxL7ghO
         Zy9JgmWe5Q0CVEC0DfLpmb0or/djSSXBN+eWy2M8NuXHj13OBM9ipbR61yM6qngHHufO
         Z+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948720; x=1740553520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dpgoJ1SsdygRr/FpJ1lhm0fZp9b2UMRqLfRvgPfCdM=;
        b=JOaiRF+9IjKj4px+aw1w0D0Yp3iUzYs6PzBMixgUgbwMqPlz+i0yfxyonJ/1JYvCeP
         Lw7bfFYJs1D8WKJZNuczpUll/KA1pv12QER7Gf8Qg3fQ8Plk1lW8kq/SozOuyA/Rp2TS
         a23/2mIw/A4kwdUu1PlsXvSVhsoKbQqAiUGFd1HE2+HM4y6uxQMBz9zoty/qUVDTwkll
         rYQ3UkwGHkZI5RktH8/XpkIUAHm0InbYjIdXOVBXT5dXHGgv8BSHecC9eOWBz3nc6B+C
         tqbMXL2j1LRgbG+06Jfj6Y3XWV4PGd/kwYM1aPg/RThM+RHReFwhgIWxC/GjoR8R0tnZ
         gC5g==
X-Forwarded-Encrypted: i=1; AJvYcCUic0ltR/uloN00adK7O07r7ss9mIeFxB84QN83fDgrExAT9EwpBqInaMtXFaWM48OyGGqq60Jrw9qaI4g=@vger.kernel.org, AJvYcCWbY10AiG+rUydZ/vXWmkD/VwHW5FLHeU/CzRfXCKRv+H8tq/2z1LdCkxqdqKx0fsAKFvW5OkddcdNajKv7lnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqyWmaH9TaSYWX+iTHZy8xQ2sKi6RU5Hp2hsEIy3UkdRCt5Rl
	jYsx9+S0rpkf7Z9HmWWu1OiYyOZ6Bf41qxuOraJNh4S36D75pL/0z1pe7A==
X-Gm-Gg: ASbGncs74Wp9efYLkah+sQe4HmX+AvBRuxRdmdmTsErbPIetgagQ1JBWUZjhPAg2he/
	v48/jXzbAc88f4jl7mu/Ytfl5LA3gFixy3FfhqkIrx5DMZQX1U4LyFGWbod2ruDdDEhuBOrh55o
	5FSt9MwV/qyV4H7RFNz31Khf96aY/K26150pOFP9nnhQ+a3XdCMsmnbIQbWJo2S6UaAMRsy26MP
	d6cLqVPepsglC5TrIlcRHcqRDu8McRn46OJ+o4FbhXEg2Z7QgWtRGp6C5Lsa6p5g3vooqeD7HSA
	4ehFUzKYnpraE6ugPxGxgVkewp/gAdwr2GsQDvR/UIfk2yOKyv+m+7MXBf9mv3zK2UKw0v35Q9G
	lvPwKHw==
X-Google-Smtp-Source: AGHT+IEu/xVTjGPkhCSiQcN/p/y1POCQeyzFKs71dvKS8dTXpXC+2tdA2RpTNjwOMD7M3vkWDPzXYw==
X-Received: by 2002:a05:622a:59c6:b0:471:f5d8:5f56 with SMTP id d75a77b69052e-471f5d86142mr147882231cf.1.1739948719777;
        Tue, 18 Feb 2025 23:05:19 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47205063be2sm11789801cf.73.2025.02.18.23.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:05:19 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7F721200043;
	Wed, 19 Feb 2025 02:05:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 02:05:18 -0500
X-ME-Sender: <xms:roK1Z8C0MIONmz0qBttWukADNeAEySf-9pcOtCSX3dXvH1dPVJzs_Q>
    <xme:roK1Z-iRFwd_Lhs9bO_HZwEJv3e1tn1EYDJPo_eAnoeJRa31R_NYsXxlH49m0200A
    q46dpMn6N04L2JkZw>
X-ME-Received: <xmr:roK1Z_nnX9thhFC3mDhRfsV1wlx5d31kfjTK4a5Ll4IeTf-HNEFNVhFYkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthhesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguoh
    hnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhig
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhsuhhmmhhitheslhhishhtshdrlhhinhhugi
    druggvvh
X-ME-Proxy: <xmx:roK1Zyznrp4YrHTsb1XJFSyCEBnb0tTjE98T9y19GmWTgqr6quSvlw>
    <xmx:roK1ZxS6_TRKxgL5Mx_quixPNmAp04jUCz1_nQJQgJXOh05yogRXEw>
    <xmx:roK1Z9bOjOjTi97cg5Rc-u7_R77JX6UXsCVGloiMzbArvGUuzmIzFw>
    <xmx:roK1Z6TmrTnJWkiOnMfCosImrWJsuwozsmoKWYqu5sJ9nfiWUMWawA>
    <xmx:roK1Z7BYI6yyWzxSVYPoBmW_ZFVzv33uOCqHftUERnNAA3cD5okeEk43>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 02:05:18 -0500 (EST)
Date: Tue, 18 Feb 2025 23:05:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7WCrA_bbWR6PQQG@Mac.home>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
 <Z7T5_WGX_VXBby9k@boqun-archlinux>
 <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>

On Wed, Feb 19, 2025 at 08:20:31AM +0200, Jarkko Sakkinen wrote:
> On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> > FWIW, usually Rust code has doc tests allowing you to run it with
> > kunit,
> > see:
> > 
> > 	https://docs.kernel.org/rust/testing.html	
> 
> I know this document and this was what I used to compile DMA patches.
> Then I ended up into "no test, no go" state :-)
> 

Good to know, thanks for giving it a try!

> I put this is way. If that is enough, or perhaps combined with
> submitting-patches.rst, why this email thread exists?
> 
> > 
> > , I took a look at the DMA patches, there is one doc test, but
> > unfortunately it's only a function definition, i.e. it won't run
> > these
> > DMA bindings.
> > 
> > I agree that test payload should be provided, there must be something
> > mentioning this in Documentation/process/submitting-patches.rst
> > already?
> 
> Partly yes. This what was exactly what I was wondering when I read
> through the thread, i.e. why no one is speaking about tests :-)
> 

In my opinion, about testing, code style check, commit log, etc. Rust
patches should be the same as C patches, at least during my reviews, I
treat both the same. Therefore I wasn't clear about why you want
additional information about Rust patch only, or what you exactly
proposed to add into kernel documentation for Rust patch.

The policy documentation in this email clarifies some higher level
stuffs than patch submission and development, such as "How is Rust
introduced in a subsystem", this is for developers' information maybe
even before development work. And I agree with Miguel, if we want this
information in-tree, we can certainly do that.

Hope this can answer your question?

> > 
> > Regards,
> > Boqun
> 
> Thanks for responding, definitely not picking a fight here. I

Oh, I didn't think it was picking a fight, just not sure what you
exactly proposed, hence I had to ask.

> actually just wanted to help, and doing kernel QA is the best
> possible way to take the first baby steps on a new subsystem,

Agreed! Appreciate the help.

Regards,
Boqun

> and sort of area where I'm professional already as a kernel
> maintainer.
> 
> BR, Jarkko

