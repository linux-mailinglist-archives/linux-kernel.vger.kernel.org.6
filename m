Return-Path: <linux-kernel+bounces-526771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DB0A402F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32D33B7847
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398124CEC2;
	Fri, 21 Feb 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw4TqVeH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BB204C3A;
	Fri, 21 Feb 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177954; cv=none; b=CMBdj9VD9mtpPskpgxrEm2H9Dv6U+v1xdRFiztlS69YHtdFgI/Z67nY/71AfCp0KFvpM58apZFBzzvJHr/Dd7fAJn0sV41MeoPKuxgN+QeVnC1DnTW3vC00K8/IOvlSJxRPusS1GnaW83VgmoE9g3ukiOrSO8PiiijQ7iKtqr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177954; c=relaxed/simple;
	bh=v3s7cQEof/S4xqc58xa0Tr4LLEReDpX2QhUVhzSTYyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soEfqrBUw7vkjl+CTq3IkwX/XDXhgLHiRMPYw8CIHO9dli1LeFo0Bt0CsgsN/4va99ikE1366W6L7GqZnKrHntCxpc/WF+xaywDrNMptfZ9qKpVH1IBlk39+qmnipLWK7/IVdk6KbhoPz5eU6mSB/wNmnVpr84pHdAkM9aoUOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw4TqVeH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220cd9959f6so7291345ad.1;
        Fri, 21 Feb 2025 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740177951; x=1740782751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3s7cQEof/S4xqc58xa0Tr4LLEReDpX2QhUVhzSTYyI=;
        b=Dw4TqVeHBOYx6urmKM813p/nZtl71ys1xfNEy65ebL6bH2GuPqUDQmca4HU7Te1aIl
         Sf1zThT6WTVWQZWymU0L8DFwxca4EMRjDTCOG+2PyaAP6AmzZ9kI6b46K9fJqyQpawpl
         QlXySxPt1zVkOS6LJI6KMEmcUhrdP2mYuDgbSmD50azWWGBQdW+oPJYj/Ywy/+T+tMo/
         J/IVQv2VAXXdm0BYp9WCA9l6d6SaAFeN9INdHGP/d5b19XBgm5qDx98fuZMklLAlVOml
         aKypNEt2Z463ka/gb9u8fnu+oNX4/M7Fm4Z2KMI64fxg+3N26bclyM0xTo/MuD6d2gvR
         XoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177951; x=1740782751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3s7cQEof/S4xqc58xa0Tr4LLEReDpX2QhUVhzSTYyI=;
        b=eYT68nsScfEC0fJ/eT2NPDoZjM8tmYcxJKQipTdDQVsZASdznuwUOpKHqH7cWXxVdq
         Rv7uxiyoOswPoA0xVdw7I7fktnn/Ey3BHqLAqLSZWMN/cM+M4Ju1Of/mQ8SkuJdDeh1w
         mDYckkTmnSrTqcG5NzaZFT/t0mpduUPpghx67xd/lku6TzW/RXRY+eLoX9Xz4dEXovoV
         DRjO5eUFD8Pedh1uqznxXo818JeMdpzkR7gzt+FHQ1hVzejj8o/YmwH58mfmZxj0Jrbj
         2ObprDSio/uvAcGAjxVAsRmSmI7G7V1M+2yLjHK6ZENNkPcVEF3HhIbFoq7dgHwb+6Rt
         habA==
X-Forwarded-Encrypted: i=1; AJvYcCVSUuW9JQjrfQTGSZ2PkmSXS/UWMAFCfGJNtVuLAo/VyjDnV9kx7KHPihJ9R4gCnb8rjt+ztqQCHoaycvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8dXbi6dcg9t8OAoljp07O85z4gNrxzwNVrefNXEQSgd/b97x
	ievT32kbVIZXwGtVhlivyiyKSO7RNLlLzjsZqwpS1q9Rw1nqtda/1lX4EAc4RiJzWHp3rgDwB69
	EZjLPbvZ90451lsjuZKfUo+cqh6w=
X-Gm-Gg: ASbGnctpoEcj9W5nI1lTC907AAf0midh95qalEiqwus3rFjck2ItsrKWOrArbP57Awu
	rA0tjSN6bHBWXk82MiwOjITP6Y7S4ZVwgwpMi6Ti7O4NopjKhpPB/yH/PZYRVLoS2EJfufy0q8W
	NyicuviY4=
X-Google-Smtp-Source: AGHT+IFgQAtKf6tFrcHDQSMO7xde5/CyoZDdNju9ntaWqXTfpB3G343uvSXBy2pAVZdql6/56FqeekrDn0nrZs7NmXY=
X-Received: by 2002:a17:90b:3b8e:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2fce77a6618mr3050831a91.2.1740177951583; Fri, 21 Feb 2025
 14:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 23:45:38 +0100
X-Gm-Features: AWEUYZmId48eqefnr_fPLwenVwVidtPXePjdI5wv1Bf2D95oyTerGH5E2OY69Yk
Message-ID: <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Konstantin Andrikopoulos <kernel@mandragore.io>, Danilo Krummrich <dakr@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:36=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Cc'ing WORKQUEUE -- thanks!

Cheers,
Miguel

