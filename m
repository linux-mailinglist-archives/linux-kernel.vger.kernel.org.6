Return-Path: <linux-kernel+bounces-268267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4475942263
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2028551D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EFA18E769;
	Tue, 30 Jul 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeB44vP3"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38B1AA3EF;
	Tue, 30 Jul 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376525; cv=none; b=JENSdqPB7PhzSdObW6hwzx1o7HvjjTvpA/mQahcuNI3mEYvYD+vASQzENcwvkHdLW8SGs6oYXd5VpPIV/P8GxFMItd30us7kdUQEmQZ9U4F7zoCW2vTddE0T1UgbyHe6fF6Sa3BuJsD+OqXR1YqEypWg2Nkf57PXWOKm1VglyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376525; c=relaxed/simple;
	bh=Ankki9c5Nlra5Z3QRBiC2olumoXZIRU8bFDSLITPQAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXATpANezQXwtTF073mfR07SFMR4375+1jbYU27gGDJnRn0fJoz+VH+q/Erm3lSx3m18gB5pvfsvYfb4V6o5u1b4AiFrXnI/w4jyWLyGvdinlGxLly7RiqYyeQC5HCC5dJdmdarjcF2+WZ/ok0vh2std3ErnUmDDJwdypRB8Rp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeB44vP3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d984ed52so290442985a.0;
        Tue, 30 Jul 2024 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722376522; x=1722981322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57yoPOGG3zQRJF2US/SjGCckh/jSh9bDasAjmkC87kU=;
        b=ZeB44vP3yuLYODTog8hUmi47cMk3NmL3gKs19sBKFG7bbrVC25+3nio5y0OeJT0rbk
         dem99hrO8JLA5B1rm4EjIBNBhhxdd5308d/BIIhW5dYgIka098fCOTwbYNTOuFnbxTF0
         uUARPzASOAD1rokNcky1e06KZXCOOG1btM6JbJhsnVI4kQXAIgFD9f+KTNZR2yx9S0kY
         1OuZiAp4aTnKK8sQfBBiG0USFGi1XpxKmGReRO3xpZ84RKtdU66Po5pNE3aPTsWQ9piK
         yVF1oh0oo/DbP4/2ozfeUW4c+HGdO6bzNHzQDKk0hmIjuqaSWju75nF8e0km5QrR4MtO
         cHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376522; x=1722981322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57yoPOGG3zQRJF2US/SjGCckh/jSh9bDasAjmkC87kU=;
        b=tNABRjC1sr1YYh6xc7cg64gkM+qrebrBIm2ooLUlkQvw8lBrmKK6B+xWs4+h+xQ7Yb
         mYyHo66tXBsDlwK4W3YaVASF/vlgYbNeSg+/KlhdFZ8uZLB7Ycxb+y2kC+brdHhvowdz
         0MwJEOu4WYAYToT8dR60tg0FxkZxzspQPDnp1E6sYNQX+F9qfuuwtQtvcFQ4O8r5mH5q
         /08fx/6aYMjBgB1buoVFR6Maksf/mFWNSdyM7++5dK01EHSg9dW3PqpQs9gMNNu8vBRk
         ZjhMqns2r8yLJl0qfTpO1/B7vYvoHrEZHMU28aV+XXU30U4Uig0tbDljIjLHD2wF0qTE
         uvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxatS0j3xVxqcigldqKNoQaUQGJ2sWR0ONvCwGmHXNksIknMED23xeno5xnh1zAN6Vgq2bJoA7g2NNPi+GCug=@vger.kernel.org, AJvYcCX7o5enNBHW2+O3il2c9DR/U45Lm732GBbMCcWNbTh1uWe7AwFLRyf4WujsqP7hgX+FaWcbBsEd1KtyuHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhB8uIJAVu/wIQI0V/84d6LZ0EWzvH0I/MIO6SH96eNzNBWxA6
	cUU/o4IUYRrlW9OBO7PQ8qcm/BgY91AgbF1l6M6DNTuNbsm7ph02
X-Google-Smtp-Source: AGHT+IGQn1Bn0sLDlLyLtjs5GZpbNKODLyk6ukLIhagXWDmYsvu0xpevCUuRnXun51mNo5nS8EuYVg==
X-Received: by 2002:a05:620a:460d:b0:79f:e9a:5ae5 with SMTP id af79cd13be357-7a1e52ff4fbmr1382272685a.60.1722376522366;
        Tue, 30 Jul 2024 14:55:22 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b6153sm684020485a.49.2024.07.30.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:55:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 545AA1200066;
	Tue, 30 Jul 2024 17:55:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 17:55:20 -0400
X-ME-Sender: <xms:SGGpZj_0-Ygse_5BbrVZPa4ROjQ5rZ78sv-7cn-X8m0HzIxkicTJqQ>
    <xme:SGGpZvu05_dEqzwclTDz32WOHaVdoEB4yUnaH6DjRblROVXSOZgiMkvvcduUdU1Y2
    xGwGHCljiUd0NUTxw>
X-ME-Received: <xmr:SGGpZhDpBTOA3XPimdmd476sv9nFGVvGxTHTqMFCKw31dS-sE-2egeTzQLnOtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:SGGpZvcHjAiOlm0sExpljiqrde8OXYRdVUnW2ThTOyWjBIx80ATFTw>
    <xmx:SGGpZoMSvzibtVtYBL8agzaeHrf1kn404Jr2bPtcxg7wQ2SlN2M6Jw>
    <xmx:SGGpZhkwp_9sVnFDwWtlr_r7QRsUIh--aABVvhKoNye1o5GuYFtuLQ>
    <xmx:SGGpZiuCD4dAahf9UyRD70arN8UnuH0weAYo7p_Pw5rm46FUZDqH9g>
    <xmx:SGGpZivb4cILb8cLkQfk-rPmNT-iQXFjyUUMvtI8qJawPB8g3egWyXdt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 17:55:19 -0400 (EDT)
Date: Tue, 30 Jul 2024 14:54:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Michel Lespinasse <michel@lespinasse.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] rust: rbtree: add red-black tree implementation
 backed by the C version
Message-ID: <ZqlhHD_Qvei0zamr@boqun-archlinux>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
 <20240727-b4-rbtree-v8-2-951600ada434@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727-b4-rbtree-v8-2-951600ada434@google.com>

On Sat, Jul 27, 2024 at 08:30:47PM +0000, Matt Gilbride wrote:
[...]
> +/// A memory reservation for a red-black tree node.
> +///
> +///
> +/// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
> +/// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
> +pub struct RBTreeNodeReservation<K, V> {
> +    node: Box<MaybeUninit<Node<K, V>>>,
> +}
> +
> +impl<K, V> RBTreeNodeReservation<K, V> {
> +    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
> +    /// call to [`RBTree::insert`].
> +    pub fn new(flags: Flags) -> Result<RBTreeNodeReservation<K, V>> {
> +        Ok(RBTreeNodeReservation {
> +            node: Box::new_uninit(flags)?,

This will cause a rusttest error, although I'm not sure whether we want
to keep doing <Box<_> as BoxExt<_>>::new_uninit() to shutdown this kind
of errors since we are going to have our own alloc mod.

Regards,
Boqun

> +        })
> +    }
> +}
> +
[...]

