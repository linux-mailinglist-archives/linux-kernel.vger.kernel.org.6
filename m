Return-Path: <linux-kernel+bounces-199526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA88D8822
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43FB1F21B05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F743137925;
	Mon,  3 Jun 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcATzdGS"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B3135A6F;
	Mon,  3 Jun 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436563; cv=none; b=apXD1M23RVEWF94N77fxsnk9fMbMi+Do1G+pAYnB5qxMysTs1CODJ1KSd17rgy/n3k/D99+5AXue1zY+RpBqdFlR9EKT7+R8QV/JEfuc6Fj7/LR5N6vOn5wr6XpyXJBX5oMFnw9lyN2PJ6ynfIwNyN0h6xbQ+4+Gusv/rFV4ICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436563; c=relaxed/simple;
	bh=epvhLo1mWE99TSJ4TRY/EC7cNxGbjrIEgwOICO3Bt3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVf/lAxI/UFs4s8DoaNwhh0+zn8DcoFLABp/qjvnbHUb2dx9td8VIOBvAaHJ/9p2t3/lck1lfl+VrHSgEN93OhTeb5jdVFzz/4lR7KG+FOy421R3jTy8mdK9Tazh8HOLcy0q7pUETAJo/hn6bAyAhLIL04Hzb1oDfXR5x3BDZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcATzdGS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794ab0ae817so265299685a.2;
        Mon, 03 Jun 2024 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717436561; x=1718041361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqo8/N2WL4gT1OcLo3qtSeNxyML4fela4YEeG8cnJxQ=;
        b=lcATzdGSJn1yZ9xfDVR6N6R4EueZpZapx8iH0pgOKSvAtC9RxkEsvoUs9cvKw92upk
         QDldr6/a+UGs5cjW0FNdytMnobzrtF0AuKQFPeCGmZWyBE3IUiamqJt+46nRYPy5o6nz
         lz4Qi3PfJwkyC71SIiy8jI4kWorux0JIEoJT4tc08c8/3/x+fPpkaiBG7adZuUpVusOG
         270o9nqUkxCcsf4LgwrybRYDNGKRK2VlaVgi3JkJoH3qVzyitZ3vKOQWyhow+q7VZWyd
         A+3+ZmcrdHjSd73ks/k7NZhPmL7rnTKbKLqlg073tVvpupd5tYFashWF9SP5X0VoRYSN
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717436561; x=1718041361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqo8/N2WL4gT1OcLo3qtSeNxyML4fela4YEeG8cnJxQ=;
        b=NfNGqc6MFQv55FCDbribHj3auNATqWduNQjoazwlR5AJ/JqlOeQLUxp6LfV5XTzZ8U
         tRVR9O/WSsh+JXsc4KbarS4uT9XzJaeN8UeJeYDBkl0A0PXzs+AMKMjX9onmoA4chSvm
         kAzweIW+/in3wQgSexyMrNwN6GKjEP+PqkdusY9IgJNLZYQBYdwKyGwVGxFQARqgXwBd
         jzxm76yLL1AdYCtA3LDMy7b3LvUnj/A58mUWJrV/2ppa94edSOjW6fscPcCRFaG141vb
         h8gAQJQFWMLY21l0ZDzJABw+NhmtGmyZ3KnOna9KDuGzAIw5WW9YZJiBYXPvnnbOrla+
         YTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGB9T/g2rh+gsLSgHrQJwIcpOPsXAWyr24LHBS4X8PLJlu2XED1QK6MS2hiEHSxq+voQbOjAoMaGqKSVcnqXaiguaM6A186mY61DJWn0iyZmjRWLbPQqIt+MifhTttuCpy2j16xMuXnInrd0=
X-Gm-Message-State: AOJu0YyPF2nzA1no6uN2GIy1FRqZ8h1LoHq3i6MsgKYrzIXHEQwNcmET
	t7NOGaE3r9vFGVMIcZtKU+1xvYheMurqaDqos1SKTdYKlX3/7bS7
X-Google-Smtp-Source: AGHT+IEmh2P7iFc4eHQR6V8pIF45N/E5P3S8BMMDUYIxJmX1LvdjLvcw/Fv4sfFtQsIF/XDScyoEpA==
X-Received: by 2002:a05:620a:4720:b0:790:ef5d:25ae with SMTP id af79cd13be357-794f5ebf4f1mr1306054385a.56.1717436560788;
        Mon, 03 Jun 2024 10:42:40 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f328fcc9sm298141885a.129.2024.06.03.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:42:40 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 76B861200032;
	Mon,  3 Jun 2024 13:42:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 13:42:39 -0400
X-ME-Sender: <xms:jwBeZvliBAJQ0jP-BL4p-l7CeLV7KYQdICONxbrU2Ewc_G8L3GIXew>
    <xme:jwBeZi32S0DdEk9I-SzRsdREWh6B1uDORSNy10puQGJ8_dQ0kNkPkKmDqOGfDDZKK
    UG-R8JnzAMdr5jD7A>
X-ME-Received: <xmr:jwBeZlqXYI4edETMm1XtM9OTjx3cp09au2r8qClcbPBjNod4N4Y6bZcG_4D9PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepkeekledtgeffgeduvefgffelieetgfeuudevudefleeugeekkedutdeg
    heejveelnecuffhomhgrihhnpehnvgigthdrmhgrphenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jwBeZnm59j4LA_c1AdI-Aa8Txi-EcRsYRibQmayXtKiTUm7BWI4X3w>
    <xmx:jwBeZt1yf5-CSsgvJT8RpzyqV3qUmvhFh2vrUsTx821XdpgjL8cv8g>
    <xmx:jwBeZmsSGXVyLnSFdKtMZw0B3ova98VK2txeU52tz4ETF_uxM60fHA>
    <xmx:jwBeZhWLepnyZdiN8bnxj5y1fCMpRjHaTfp9KeedynaRJy8nLGafcw>
    <xmx:jwBeZs3iLugazPjHs1ztSUEElg-VohepnO5UAEcHAFoj3aPjL0n3yKGT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 13:42:38 -0400 (EDT)
Date: Mon, 3 Jun 2024 10:41:41 -0700
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
Subject: Re: [PATCH v4 4/6] rust: rbtree: add mutable iterator
Message-ID: <Zl4AVUqq8Hd-a230@boqun-archlinux>
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
 <20240603-b4-rbtree-v4-4-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-b4-rbtree-v4-4-308e43d6abfc@google.com>

On Mon, Jun 03, 2024 at 04:05:19PM +0000, Matt Gilbride wrote:
[...]
> +/// A mutable iterator over the nodes of a [`RBTree`].
> +///
> +/// Instances are created by calling [`RBTree::iter_mut`].
> +pub struct IterMut<'a, K, V> {
> +    _tree: PhantomData<&'a mut RBTree<K, V>>,
> +    iter_raw: IterRaw<K, V>,
> +}
> +
> +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same

s/RBTreeIterator/IterMut ?

Also `IterMut` doesn't give out mutable references to K, which makes
me think...

> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}
> +

we can lose the constrains to `K: Sync`, right?

Regards,
Boqun

> +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for IterMut<'a, K, V> {}
> +
> +impl<'a, K, V> Iterator for IterMut<'a, K, V> {
> +    type Item = (&'a K, &'a mut V);
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.iter_raw.next().map(|(k, v)|
> +            // SAFETY: Due to `&mut self`, we have exclusive access to `k` and `v`, for the lifetime of `'a`.
> +            unsafe { (&*k, &mut *v) })
> +    }
> +}
> +
[...]

