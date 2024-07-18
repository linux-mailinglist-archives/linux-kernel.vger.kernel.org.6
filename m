Return-Path: <linux-kernel+bounces-255972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D3934742
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F661F226AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B940848;
	Thu, 18 Jul 2024 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rz5PMYiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDfepS6T"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8D1B86CC;
	Thu, 18 Jul 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277931; cv=none; b=s6DHb4i5t1r4TWs0TjEu3NuLIKXyStttUmxx/EcM/a3i/06YlV65xSyMzP9ZyJi8BIOf+dOmjAtM+Ngf0RNqy9zdFwTM02oTHxwNyoZlXFE2Jgn/ciGBysDFu93nhI7Y51cB6g+Y8hulyrO6a24bvWmjF3dXpmHRwnWyHxuQnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277931; c=relaxed/simple;
	bh=BRy2bM2IKgR8xgKYEPIAFK1X2XFkO/8SAl9n4X17KO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdYK6QO4x53KFhlwNE6uoX1N0A3ji5Ic9kn0BFaymTI/J6u9W+63hoAcCWY682ZmbJe+pbbVcbKbx04R/iyCszz/Rq5ZZxhlTHio8j8vDRMQMUWSc8vV4Lc2TutK0MmMdhz52DvuCzvuKseFQ4JtJZfqaPD+lJcivYfrAlINgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rz5PMYiA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDfepS6T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2487C13801DB;
	Thu, 18 Jul 2024 00:45:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Jul 2024 00:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721277928; x=1721364328; bh=q31G4O/MNO
	/gOgnqYp7t4bFpYnaYCryDFvme9kOpRlQ=; b=rz5PMYiAx9gdb5JmmrWiMasRKm
	RXWQl7ofwbxlQkKC9lQVd6jwNynJQaPbGIazP2IEbqSJU+ZgkaHThX+uO2kZXPjL
	DV8pvhQOVy20F8cKgJpYWvgQl0rzUq68G7wOKBucUY0J3HHv93ltCUpij2ngdzy1
	09n1xch3pw+y0EOP3VSyB/dunj3GKLzVkC9zH4Faq8E/AZtre4Qac2jym19jRKH8
	pOo4n67KXyHDhjRF7Ksx/CDrpQg8JcvqvMe0UYQ2T1ZsoYSZOr5muBDO7HhGM+0/
	P6akGMP+uzCFeCMrYUkmfHgueSJSrWcoo6qRnMKKdThxPJ3hTlpTLpTBEXUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721277928; x=1721364328; bh=q31G4O/MNO/gOgnqYp7t4bFpYnaY
	CryDFvme9kOpRlQ=; b=GDfepS6T5SU3Eg2qItsMD6uvuVs29UEk/Sw7vxXW44DW
	57KD9U/Gep2PyApBioxNs7ZNhvLelJe7grRr9tYpTa7x4dA1aRZYbzUoxQGj91am
	ODE/mfHgyii4tjLjrPww2Pi8wEPycF2hXvO39/ysQDvVb304qaRGyJNg6NeRoBao
	MISoHxY5u4mzACW5xhmM3jUph6VNwwR4EesNpDBlM0CSFu/UHy/9bTL5DnIG1s+g
	0ZHq983SLYmqgo7rIROwV9hMDtEa9pMtUaaKngGQAUqZFwJTjioahyL0Y8lAggIT
	F+tq7fCsFWr8bhzu1mnu9JYbnUmq1F7vtiLAscV1IQ==
X-ME-Sender: <xms:5p2YZsGGLTtRbUfcYLdlfNtjtr_Ftr8FMFIFVyfVV8aogdtdaFriSA>
    <xme:5p2YZlXiVfnHz9OEu_GK8HzGfcJ-FXk2E3Ly9wE5TEGIGZudDfgxPqMhrcWfHG0Gp
    rcC7sdt-rO_bA>
X-ME-Received: <xmr:5p2YZmIUpqZRbM9LA_n0gcXd3B1gXv4CYmOxR7G-vkdyVtMuzX2uJ4igWkg01sigW8Dod13z-DjVcbI0MPVxezzMZbEFJ2K4SVRXxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:5p2YZuElQjbhjKsZ4ISAkFU9vqrMNlYPtfsRJ_-q6TMo_CISxxqbQg>
    <xmx:5p2YZiUL4s22Z8m3VLoc-5A9GnN3UyTurBc3qO-sK_opm59LIph9wQ>
    <xmx:5p2YZhOZRJwiQUHqprmcuyLaSojz4A6OvVIbIl0-r4VBhXDmuWWa3A>
    <xmx:5p2YZp3Q3TRUZ9_IyQlYuNxg2wfWQZE0OTgsqXdgtQ5YJeBhyaz0cg>
    <xmx:6J2YZlrldnw_5lQB5_Fe1cLzKDcEtgM6XPNJidTpWW3g6W6mKv9AGukV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jul 2024 00:45:25 -0400 (EDT)
Date: Thu, 18 Jul 2024 06:45:24 +0200
From: Greg KH <greg@kroah.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <2024071845-neuron-figure-2e26@gregkh>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717221133.459589-2-benno.lossin@proton.me>

On Wed, Jul 17, 2024 at 10:12:29PM +0000, Benno Lossin wrote:
> +Because unsoundness issues have the potential for allowing safe code to experience UB, they are
> +treated similarly to actual bugs with UB. Their fixes should also be included in the  stable tree.

Odd extra space before "stable".

Also, link to the stable kernel rules here when you reference "stable
tree"?  That will explain what you mean here.

thanks,

greg k-h

