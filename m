Return-Path: <linux-kernel+bounces-512857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDEA33E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F9D3A5A62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAE21D3D6;
	Thu, 13 Feb 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNj5Dadh"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B39211A06
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447649; cv=none; b=UzCGGOpdrmMQD8SJzt2wmZH6jp21b1osWeUaUIqJbXo0WyoF9Pz6c+lYZ9NCbE4+x13Fjk9PQdeYkqpJuZbuipdg1iz3SmDdvMd5CfNwrMdX0SCvqoGZ0zuZ1j/ZDAo52fdlLQvI8GOs3JRqli2wUhcSswkAn0CpVrjKRahbIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447649; c=relaxed/simple;
	bh=qdkW8qVhkXrO1qQ34NhKHK7+tmQMaR4sdKcyxB0QKpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDjWy20C7A0liYJqlsLT9GOpv01eWZmhnnHEYXdjuwsLfXe9yRVkpXM5wcdDNayZ47qZlp686Y7CnFKdyzMiLyLw3ceuOhUugnEvaCDUqJ+uEvCrZ8oUStyiVdMduf7T69/hG4bGSJseLIZI/m5Qw3yRlzHa22cwdvbDjBhdmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNj5Dadh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38ddfee3ba9so608374f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739447646; x=1740052446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBrYoGQXFZ0WeFWAVcXCIsjpFEawdA5CdRolKv8MZAk=;
        b=RNj5DadhQ+ume+LMXaSIFpGNnIaNmU6oJjsCYwrpBAii/FwRnTiPlZvlk8mIOrY51b
         e8/nTy1d51AM20h3nc6uRsByPzimH8LTCHfhWcXD4WL3rBkpjHP72CN79XfbvzBCRRFI
         YYiZiVVOmQvcRSUEDDIKIy+iegLLY9tZqNOWdRJCE0f4UFZsK+w+Gv5daPZjo66g+u9+
         mJw0mPFrBnVQF+2yjUrqw55grQH1KcqCVeg2DziprVbAs2gLsSn6M0jC2lEA4yAC0IPO
         ZvJrjjphzU22ofdRuTj1/Y7lCR473N6ZS5B1dUAA5u+7vauVlUQ8rVzQstA5AgQqgInn
         l+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447646; x=1740052446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBrYoGQXFZ0WeFWAVcXCIsjpFEawdA5CdRolKv8MZAk=;
        b=B1LS2UZQnTrWv2otHUSpODEvWcmdaNmLutwJyntFpFTSl/FFVelsgyGnU6GhGYMXLz
         WgJPrC7ZshNJmcSuBQy05QxbjWXZSsaqi9UqtzKVhj4ue2+8V3nfFL7//QVJ2srTL30l
         CDxL1yfjCV1ilrHovNrhcopcgztY9jbDDETb9zvmEaEx3NXiee3kVHSLOg8HrkHjpDJR
         AvWPxDLsfeK9nsjLgOyV3VSwjByATDDmMSu5fsI7DnZx8nUWHRaTJJZPPb/YImvVSgHd
         tEi1g8A+2Lpj+Spa66TXle0Blxr/0I1HUvTBJRXuU0MQ9wQeI/XifeFKRXfsyQ2F+N1J
         LavA==
X-Forwarded-Encrypted: i=1; AJvYcCXwqmacg8v1nhgOKjgPzzSkpHTg7yf1II+jL7hMWkNc9oKYON40mpjxrTnRPDU8d4PqbxoYCoNc4KxF+qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06J5JjGIKx+fh0EvtB01y3j7inye+aet4xA3KHt2MCouu7RL8
	W5u/XrWVzCdVJ5qcXAGURVWTbEs06Es8flntdWq566TWMJ+kJts6WcyFzyQEkKBbaOOk6Wk+696
	hPMsmQjWY/kcCw7HPPyAIALkY4vXzTEVq36qs
X-Gm-Gg: ASbGnct0gaeix8WsPySsnAOlH7lxEu2dfPLI6MCY9s235ahujbXNFx7XdJY8Q0U43QH
	Ey8K8uO8v6JFW+H7QJ4mtGIQho0PiTbPe79oPrdeRF/2Kh8KnsxV+ScwRWWwqXiI3mvAmkQ==
X-Google-Smtp-Source: AGHT+IEe6v6MtacDeSEL/xLecSNxTwstqznSfHAOfDBwLvpFYDx3oaHfufee2aQ6e0ic/Zi9JnZINLqGhsXjmZIHMlM=
X-Received: by 2002:a5d:5188:0:b0:385:fd07:85f4 with SMTP id
 ffacd0b85a97d-38dea290941mr5344862f8f.31.1739447644908; Thu, 13 Feb 2025
 03:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com> <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
In-Reply-To: <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 13 Feb 2025 12:53:51 +0100
X-Gm-Features: AWEUYZlcKhn2J09IfN1Ume_UmXDcGf-Su7T6SzVglnPGleBem6pGdl5tq8gfdG4
Message-ID: <CAH5fLgipyRs+0qMkMN4EZDewtEy_8FvcJgvB+gd=58RgaddN1Q@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Feb 13, 2025 at 12:32:27PM +0100, Miguel Ojeda wrote:
> > On Thu, Feb 13, 2025 at 12:14=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > the maintainers for the subsystem generally take series (though of co=
urse,
> > > it is entirely maintained and managed by rust people).
> >
> > Just in case: I am not sure what "rust people" means here, but if you
> > meant the Rust subsystem, then it is not the case. Maintenance depends
> > on what the subsystem wants to do (including how to handle patches,
> > but also the actual maintenance), who steps up to maintain it, whether
> > the subsystem wants new co-maintainers or sub-maintainers, etc.
> >
> >     https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduce=
d-in-a-subsystem
> >     https://rust-for-linux.com/rust-kernel-policy#who-maintains-rust-co=
de-in-the-kernel
> >
> > That is why the cover letter asks about the `MAINTAINERS` file.
>
> Right, I don't mean the rust subsystem, I mean designated rust
> maintainers. The point being that this won't add workload to Andrew, nor
> require him nor other mm C people to understand rust.
>
> As stated, I agree we need to add an entry to MAINTAINERS for this, which
> is why I explicitly chased this up.

I am happy to be listed as a maintainer of this code.

Alice

