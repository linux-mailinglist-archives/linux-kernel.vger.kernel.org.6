Return-Path: <linux-kernel+bounces-531841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E31A445C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D12863673
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6518DB16;
	Tue, 25 Feb 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xk8NaZSy"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE151898F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500060; cv=none; b=Tm9qLRfuDO6Gt7J7WABdnd/7l+IDlu8lxsoawKHdF3zljnBZzJxGX3sTOmRbnrT6G7UmkIYlAAFldV3h9PXWaTxz28o5+P8/E4iE3zZoV3aIHLZWz37dB2b19+4ZPY//N/QmHG2+qu3VLKjJJrYe+4dEQUeh/Pd4lAQefx9nhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500060; c=relaxed/simple;
	bh=XK+5lo3HBdUQbAUVlBZxC7V4AlAb8QMJsjpC+v4brkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffer/sT94IkOfLlg2KHDdXtDRCTah8VvFyY6DcuBWfjXmV1CSsYBuPYBw6yIDIxmj8r0TZcuF6u3HbAZt4JKFfgyIw85D6QC0qUrdQ0jN+mUYeTEYgEB0A/RHTkVRqtXu8s3b0cj5WxopzMkk5kO8PlqIeDNx44etTbvfRUhV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xk8NaZSy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so2196443f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740500057; x=1741104857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK+5lo3HBdUQbAUVlBZxC7V4AlAb8QMJsjpC+v4brkQ=;
        b=xk8NaZSySvzvLkIg2A1tdUlO/BC15aQVv7gi7jecJJTPJswvNo4y9+o7XMotzX7EH8
         953Oiolq/vmneRrCPa5bbidqncbMBOSTsem84NMtdsKpKZb+aekK1v9Zk/3saPGQne3d
         0QnUbyA5uaHYQ9ASlWlLY3SkIHvf1VhHUUwNlAx4lsVoa3LNSRIWDKSwvXJGovMkF0fH
         zg6XBsHRdhEnw8lxkPbCuoI5SeLtVPWCKhuigVMusRbvXE+yI+CAwr3A7LPs030ZUHoU
         3iggvq3Uvw3vY0P6tdIQ078tWpNq/QbhO+ZWb1C16f6oy7S2kRPlF6XDhDTI78cEqcbE
         +vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500057; x=1741104857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK+5lo3HBdUQbAUVlBZxC7V4AlAb8QMJsjpC+v4brkQ=;
        b=AFXCyDOWNHa6yC9YqXjzl6poOTkuEH7imSHVXHFcWj7hyzbgTynxukOOJt+Y/m8OxJ
         YnU407ZoW4j+CF/7Po/pEw4olE4w0ZP5pVgAeFM7zpGRLXed+nR+6NK6qQ1AZSfRvd+Z
         Bprnl2tH/+6S+jcXeW81bJoL6Gt5+8wwecG9JtSDs2WR6+lf876L2BLx6iwCYP8v8nTy
         UZVhOzCbNvRd3vPFENtMTK4meBLUa5ruqaNVmNKPzAFAScYKBvDqD9YQ0BolP08ZTNG8
         +42qkKhqz3KDrkfL7SF4499WdPsBadCr/imK5e7QAXDEbPpMN6DwLR4JzxeaFMWihYWe
         xjgw==
X-Forwarded-Encrypted: i=1; AJvYcCVIbsi/1AoQUENASiQw20nIfvnZ1qDzHillH8wpeCn+bvafdwxvOmfVK1kIPAXixUsFZMHsZ0fB8F42INg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoD0Cedo7qswgFjGgpgzMUsDPo4vDqiDb34U40Has7yuXKJwT
	ktFLvEpq/wcN903NX09Djn8Y9JS2jnZsZxlEu7FjgFLoQNObJMGo7xyN1+T4Q9KGfOfMHRDju7e
	di608mCa/nOA1xK2VgGHvavmwvIpfe5h3x/1l
X-Gm-Gg: ASbGncu1Nd2JH4KiNxiFvmGT/1q/qAoiZyBkOAengEHtB+yjdzYGY547fjoN/tpenM9
	yjS7//xu84wLO3CzZi+xJh4VV3MIvoPN1XA/BHSeEuEDIw9WWPMPDy2BjQDLM+5qVBDWR/OELrZ
	A5T/3awhDXoXRy7WulWwz+66L0gddse6faRAAIqA==
X-Google-Smtp-Source: AGHT+IFeOrnS2YilApBIdrzwq/ZX/O6MVfPF3KockjevL9jqE9VGA4rrlvEu3VXcwoVdvaUuGAyA9tFzp4UCo8Dc3v8=
X-Received: by 2002:a5d:5f52:0:b0:38f:277a:4ec0 with SMTP id
 ffacd0b85a97d-38f6e74f162mr15327640f8f.6.1740500056610; Tue, 25 Feb 2025
 08:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <20250213-vma-v14-3-b29c47ab21f5@google.com>
 <20250225160603.4d4a2893@eugeo>
In-Reply-To: <20250225160603.4d4a2893@eugeo>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 17:14:03 +0100
X-Gm-Features: AQ5f1JoGbOrMtDQMPf3ikgvl4jGB3lyR6mbHfF9fDJZgtAdACnHj8fwMViezsGo
Message-ID: <CAH5fLgirLZE4MWwQ5B1W=ri+fTiriWtjJRmD5SZbKTUBR+GzAw@mail.gmail.com>
Subject: Re: [PATCH v14 3/8] mm: rust: add vm_insert_page
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:06=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 13 Feb 2025 11:04:02 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> > flag, so we introduce a new type to keep track of such vmas.
> >
> > The approach used in this patch assumes that we will not need to encode
> > many flag combinations in the type. I don't think we need to encode mor=
e
> > than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> > becomes necessary, using generic parameters in a single type would scal=
e
> > better as the number of flags increases.
> >
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> LGTM, so:
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> BTW, any reason that this specialised type is called
> `VmaMixedMap` but the base type is called `VmaRef` rather than just
> `Vma`?

I used to have a VmaMut type, which motivated the VmaRef name. Then, I
removed VmaMut and later I added VmaMixedMap.

Alice

