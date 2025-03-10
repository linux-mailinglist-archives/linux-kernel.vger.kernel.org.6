Return-Path: <linux-kernel+bounces-553830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57487A58F63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C102168E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134A224B09;
	Mon, 10 Mar 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mb9pilgW"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058482248A6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598634; cv=none; b=YVlEzPtNVyhbjMVI3VZBkqed4Yb4Ep9dnZ/FVh1jMIYTGgfRr68fphucF7lmetfz6ILucHxL4Jnq6zk1fwjeR69rsIneMERNayrdfOZhlvhFLh05Q5w5b16S7r3v0paFwxeAiTHLP5vD8QLCd7d/0tPYAH+xRIePzoVGuRLhk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598634; c=relaxed/simple;
	bh=NEZwdAcp8NlpW00clPwspaKYfG6ub3nrSf1XaFem7RY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LT+gTGlcdFCOS60SDfBVhQMPvKRcHsN/kk7Tw/ZqqtTlQDFVenMNVcStOSIf/kPGFonupceO5N3nwKzoeLUv90zL84p33mb8Uk+3BvCFJYVor+T+x+V/u3IJxGCUli4O/OP1JmqxUBsNgfUrjv01n8pdHhIT6/8xfReBaq66cTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mb9pilgW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so4142355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741598631; x=1742203431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Ey6YaeoGfhw7Uky6jLzAk41/zVhd3SqiNOIt/MFXw=;
        b=mb9pilgWs2SmHHSTcHGNpCYvg2a36DTtF8ICyOJWhOeAS9AAqE/URWawfKX4au8WLA
         9Knff1atYRGxZo6WbacAI5dqIKWwLGkbqrTgN5kibWSUM8Z/zb79dq3Uku5v1EDsBM1M
         YyPRy1++KHs2Sk+j/NJB9mQSeFqh/nX8PK6xBCOzgtxQqQqMRzutf7GsKll+Abzcbhaa
         rsnZim8fBd75RIsCpYxa2wm37tzAvqdRrgiX6ZSNLx9x/xtKdga60m5nSzBYTSZcmw3n
         lXHhQXiRa5DppCSjQR6m5g/YrF3x5wgtnUEGATkyIprpuNDTtHtXQZMnEeS5kQDyPW6q
         689Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598631; x=1742203431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Ey6YaeoGfhw7Uky6jLzAk41/zVhd3SqiNOIt/MFXw=;
        b=rh/yVB1WtxEmChanNk+SGtNKK2erVZu79qp+9u9+0U9Sw8rvAA4RujVvpnqQIMtbsG
         GPr+XJzKeTxWUYr8+mmAcQu/ECA4zgp+PrW4MmmhFz3fFYQ3RiYbDDG+PS8edSDAB/7Q
         0jCZJyh8iBF1n7PochWPF+BpIoZw5gGf6ZaawmN9T4emJ2RkRFyUqSUyP/weEdGYZvUM
         Uvst/PIf3F24Qp7TRsb5TOmILvS13oDszzNSwX5w+3sCZ2Ll0T+vpeUttb3KcfXuPEpf
         AnX2n35dHux/dK6u/C7pyVn6UJrryKWQBjN2obZXRCyHd6JJkO+TbTxDLNH+2XoFL2Z5
         rxJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJF+3WgPTmlR0nNbW+LD+P0winUNc2Xwcciip2IBZqoUzlxKrakO4ZjHkCkjVlVCZ1/z+W32UrPHoKnxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNaBfCSsRJd79sufupCRvY37zXM+Eg4AnuxXafgoxXbYPMDLS
	K4OCgNSq8ZY5nUeHFUOaG8YOwyP4nWHVHRlMwtUXzTwUW7Lyo+OBLjpOGgIoWLmjXCbV3mAX6UD
	zZgjEi7KmnKSnWA==
X-Google-Smtp-Source: AGHT+IFEp2UnHtcUmo45Bf247g24s/1cJE8+nXgglrMw+cHeJ5tpiviDxAGlDax67viBnDjPJP3vk0eAlr8/sB8=
X-Received: from wmbfm24.prod.google.com ([2002:a05:600c:c18:b0:43c:fae1:812a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43ce9f7da7emr48713545e9.13.1741598631433;
 Mon, 10 Mar 2025 02:23:51 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:23:49 +0000
In-Reply-To: <202503091916.QousmtcY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-5-5c641b31980a@google.com> <202503091916.QousmtcY-lkp@intel.com>
Message-ID: <Z86vpQBMYuonWsM_@google.com>
Subject: Re: [PATCH v15 5/9] mm: rust: add mmput_async support
From: Alice Ryhl <aliceryhl@google.com>
To: kernel test robot <lkp@intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Mar 09, 2025 at 07:37:54PM +0800, kernel test robot wrote:
> >> error[E0425]: cannot find function `mmput_async` in crate `bindings`
>    --> rust/kernel/mm.rs:143:28
>        |
>    143 |         unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
>        |                            ^^^^^^^^^^^ not found in `bindings`

It looks like the mmput_async function doesn't exist at all when
CONFIG_MMU is disabled?

I guess I can just make the MmWithUserAsync type not exist at all when
CONFIG_MMU is disabled to mirror that, but it seems a bit weird.

Alice

