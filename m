Return-Path: <linux-kernel+bounces-530117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67127A42F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CEA3AFE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F511DE3D1;
	Mon, 24 Feb 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7WUYRUA"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2919F48D;
	Mon, 24 Feb 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433229; cv=none; b=ikPLXdYdjiPzyXQtPvD6A3fqmkFwAjkQB4e8b8aIVpcP2Mqe4v68EA5zSjDsvg4wTqP3+/zzceSu5x53okXqwk3wmD3gwEIPyL10MJHDi0WumXofiIYpxVdzWbYy77OhUiilhRvu6sZAExhbsrLQsFHEEBfXffrjw7TADsY184I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433229; c=relaxed/simple;
	bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/LdsVe0X72siOLWHbZOscOhoDiy+XR2ZbfDVddmPLcDTe7ZdM9kG0170Tu2p8fujmsE24XUKA3WAYN+ldPUZ9VYMNR7UJYhM9+tGcSCNU/6a7yVq2Rr3JxkZOYAftiibrKAJF/doWZPynVtH2llnTizE3kgIkRd4lbIZU8GqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7WUYRUA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so1274124a91.0;
        Mon, 24 Feb 2025 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740433227; x=1741038027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
        b=h7WUYRUABnLY/DSFmypxbLTWjP29TRBDSL1Vt9Sc9nAjwASrWOJNNDT5wAzajUQ53N
         Nmp+C5GRJaXtsM8uh1O0yWnfdYrrOhd2jn4tjQrT8wR3UUolK6vN0TcXSlFgqej2g0hZ
         XcxhW4vAMmzOqSXyOngE3IKJyiCCGH4j8PuMRGr2p74w8izQN+NYqTQ5/mcNo+ICmT2h
         N6NAJMPgl1DxqtTBcwOXTYVvv2GlX3AhcDwgFNWJn2FLhA16BX2wKybvZIUG59cuQl0P
         p57iHtaEiDvl/TOjlzqJCYQ3nBBvzfzxBJplPc4ZWF91meXQq2PHwPIBzUj1JLtWr0Wp
         MDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433227; x=1741038027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4TJr5pgfQZCXoZ395gNyQ2FKYY1YCKyx0JpsbK9COw=;
        b=udHcj/SNRl+EEts6qetvj80mm268tJGpQmvvgr5hrnoXWmQ82Wmd1G8mmHgqVVVPOY
         s4CQpSySViO/DZ7nkV/9J9Z0IFZuoq5acSyrZX1bhar9NwAOttB7p18pTPktrJUyem3u
         IW/M3eFk1WUUH606j06EUS+cgi4rd6EnPzpb2uY59rKj7rieDMllqCXnTjMXlq4XVBHI
         N1ZWZE3c6RdntJw7syina41tnfxTri+UanJIoufb81Wc8Td7aXu0E3auJ5SSGt6Y9D1h
         bdVztOqiJHwwmMbxmpIWLh1timSsAR2WgmCXN61EQ+icsv09BrFtTMlTgH3j/yEeUaAH
         zDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvOQ3t5R5/MBFRB0VhLx4fQtbQe4QF/iRTiHMCZXIFlew16WtZvS7C0+3sS58HdG6wYXd0zLBcioRnROXx6W4=@vger.kernel.org, AJvYcCWZY5hDpaBBBlcXEOS84VS66y0hI5OISLdHjJUdmAntK8RXu6OAtJXohIFxKa58+1fQxYSUHdCGqmw57g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4vkcmUWXmjEDELs+JG1I5S2zv5+vzS5wFKHZkkcX2M+csGra
	0bEBEF0yzSVQNDVl2xn9x6/OzSaeqx0xAJbZtAJhQC0ELUFhlJe8T/SQvS8KM//4PJD3e4K2H1u
	C5oOqc0XQbPACPggPAus+WyXYhaw=
X-Gm-Gg: ASbGncs2NGT3S/M8Vy48kdLFFAzhOWvFJKiU1RRBRbQcMrqFE6vnjVJBZG0yCTA3aHC
	O0hhFARFIil2EC2ACLzJPJlnooPHpg/v3K0qgPfQx0JfnB66lHRCpgUv+dHo5jPzfccX6ldmCNV
	RHrrJ0cfQ=
X-Google-Smtp-Source: AGHT+IHKDKiWOu9mfM3EVB8u36Wl3Xtr59WcmIKE2AHgqhD/LAO8Qf2aJ9d3eAU1EfdN4ESJVQm8a1hvFMfytorfMdg=
X-Received: by 2002:a17:90b:3848:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2fce7aef973mr9796954a91.4.1740433226744; Mon, 24 Feb 2025
 13:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
In-Reply-To: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 22:40:14 +0100
X-Gm-Features: AWEUYZnNdDuBJ43hafoBhgYQAc3j-7xzFPpaDmZnJug_jBLZKCQgmTEDfn3yz6k
Message-ID: <CANiq72k07kN+x1MV=isMm-WUYrYd4O=6Zc3uACPp_r4JE63t8w@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com, dakr@kernel.org, 
	robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:07=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't think this is good documentation style. I think copy-pasting the
> first line and second paragraph is better.

Yeah, sometimes a bit of duplication is OK.

Now, even if we wanted to do something like this, then at the very
least intra-doc links should be used properly so that people can
actually jump to the right place in the generated ones.

Abdiel: in general, please use intra-doc links everywhere where they
may work -- the patch is missing almost all of them. It helps not just
readers, but also to keep docs in sync with each other, since you will
get diagnostics if `rustdoc` finds broken links.

Thanks!

Cheers,
Miguel

