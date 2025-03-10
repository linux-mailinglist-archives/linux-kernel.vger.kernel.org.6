Return-Path: <linux-kernel+bounces-554462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4BA59803
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC1216708D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183E22069A;
	Mon, 10 Mar 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpEp7Axu"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8428185935;
	Mon, 10 Mar 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617918; cv=none; b=JvzUtdfTAgDKLH84r6fY4ZpBZwqG44pSwykUkkB0GBxi8VeCa1gkSf++5pWFQHy+WVzmwj0fAWZxcTuVvy/GFORW/9zqdRJEo4+vX0Y+3tXJcPAA9fVQqyVkBVmAK84whhhiHVTZue2jOBlkpTVydDUKXFyhhrVoZAqKyTLkInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617918; c=relaxed/simple;
	bh=gW8z6VuVGnqPIy1b10ZKo6rOVlMZz58aYMYu5AfNd/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhoc9SG314fYKbJSwpTmYqQ+7WTbx74qPL/TpefkZHHAiIXeiqD+/peCN3E8WKutHpSNakTdbBrOrnmt4g93fYoqhTZAXRNg7O33BDDv6ynHpfsY4nxNlKeZIhBdA8tcJt/Yeu84HTJQAdiaP7bx6iBSsc2M8iR0keFPn4VDTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpEp7Axu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so1240576a91.2;
        Mon, 10 Mar 2025 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617915; x=1742222715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW8z6VuVGnqPIy1b10ZKo6rOVlMZz58aYMYu5AfNd/A=;
        b=LpEp7AxuII4GWA5bcdxHTttq3t5ZZpTxtNMQOFwbGRCLMzbyt8AfZH8p4OQk33GkPQ
         quVuh5HPrjP0fwbW9CDU2oq5gsw6OkOIxnAPp5/6PZCj6lrF9RGJIFoNtNDawV8eRRAM
         jMsBK5oZfkPA9XGBGl5vNF66RdN3L0I6iM54mTOFpKf1x+Wmtepc1phJBMPDjyYuGKFx
         D6r8H70Mh3jmMhq7rMpsFWuDRCPjYv93S73DGcwYSlMxSHhV8PeY11wblEQw8AKQP+A6
         GcpNgXVeoJAvJ3aA5m13NPVyAdncfjZBaXjOWqQAgPHD0I6ZBbxGGBvG9UU9LITr11yi
         pPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617915; x=1742222715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW8z6VuVGnqPIy1b10ZKo6rOVlMZz58aYMYu5AfNd/A=;
        b=Z2W3ZxRyZ+nRUITI1rUY62qfYsXhEQBulNh4WmO4BT1qrqSr2l5VUJKbaSXAFOt96f
         0npSmW6pOwq8ImmTO91OLmSPAGy3xXI5cY97bUM3JgJEiw5UivUIgngsLQBvWBa0wri3
         glv1Q+gkvDyYsiOWFQjbbJdYEa/qENjrix3mLw9Ovp+ZTSVCuKtnOUwlVsPiCdHeb29/
         UUSb2gTvixmPNIVJv8hNgEqwnCu4dKfu1fJJcx5pzjdFy2lmYYd6KQsi1Q0nCIE/QkXq
         OHmaPpBdOPOCZ41NCxpJn6gBdrkrs6VxS+I/LdWr7vBwHmvbo/65YdG+2d4YoBDGoV3B
         PSSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxSDW0BqW2DxZj64gbXsO2M+iY44QcOKaOVJZbj4tquFwcH/T9fIUGVjq0afT8s7+HRdOsrjY00iPK5uQ=@vger.kernel.org, AJvYcCWSAOvbL3ddRw4CU/afqTLL9Tizv2jhzbP7JjFHScButJZPYAYlKYNTqp+YuGBNwQ4l0ytuyawFjkOJdyeEE5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nrlsBF5+aaQ6KPIlLhlYGtQDlrJwXZAIVlxBDPQ+l/9N7pEl
	Y4sQy+sjBpZpKvKQFHNOOSkTJBEB6VKbLbTEi6NYk7hbs6ZPN3B+4fMIeDYGj0tRpTqy3MbV1yk
	ObkqNz2WvmlMIEO1E09yynk8z5vE=
X-Gm-Gg: ASbGncuQVbYANp7/ZmgBh6w3JA97pfQFb4pNn8c26MrpRU7OPBZqguwcJljyuksQ8ZS
	DpU2an6wGfILJuB750JZn9bDmZPN5HvLDtYbn7P38AiPFmM+A7viKEwVxiiIlNttdEIOmavMQIY
	PUOmaMypujDX/5UsbixIUxXZ32BPB1G6Pee7rV
X-Google-Smtp-Source: AGHT+IGFBrCXa0nfH6q3KU/d6EVjPEAYQctUGGrFOQVO/LubB0zYyYAGq4Qv4EuO5b6mIZ2fYbTZgO5CinWJRcgvDxE=
X-Received: by 2002:a17:90b:388b:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-300ff94ba4fmr18872a91.8.1741617914779; Mon, 10 Mar 2025
 07:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-vma-v15-5-5c641b31980a@google.com> <202503091916.QousmtcY-lkp@intel.com>
 <Z86vpQBMYuonWsM_@google.com> <f8da228a-fbc9-413c-8fbe-cfbf074a3053@lucifer.local>
In-Reply-To: <f8da228a-fbc9-413c-8fbe-cfbf074a3053@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 15:45:01 +0100
X-Gm-Features: AQ5f1Jo-KFcVKueX0g67j4CnRVm7aFG8zzgraUS9Fb3LDQnYzo1Ea90XXPPdoKc
Message-ID: <CANiq72kAY8hfN_RW-=h-gmFQbq=0DDSQ=ZQr+M3KhJgnsW6n5Q@mail.gmail.com>
Subject: Re: [PATCH v15 5/9] mm: rust: add mmput_async support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>, kernel test robot <lkp@intel.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:20=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Yeah, !CONFIG_MMU is a constant source of headaches and pain :/ is there =
a
> way to just require CONFIG_MMU for the rust bits? As far as I'm concerned
> !CONFIG_MMU is a relic... (not everybody agrees of course :>)

I guess you could simply limit `CONFIG_RUST` to it, but yeah, I guess
it depends on how many people you estimate would like to mix both, and
the bandwidth/patience available to support it.

Cheers,
Miguel

