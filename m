Return-Path: <linux-kernel+bounces-516409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89279A370E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F6A7A3712
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC71FC7FC;
	Sat, 15 Feb 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ix1kiSRe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46B170A37;
	Sat, 15 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739655690; cv=pass; b=J2FGKytuzb+euu1VqHHTax/5iETbl6sXoV9fzVYn+b4ifTVNn5TAZuy/FPgrZcd2YKsyqEbs/DJiTBN87n8+HwngsiFn8BUuAsqUgSGmCpP5mAq6UED6Gp6tjYQy+oUyeXcouekcv5EiIzEKdIeEiaSA85NzRfIL0GTGCvCqXP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739655690; c=relaxed/simple;
	bh=wNkunTcwZ7tTA1DeZin72+i0UjvFvWDXsnEPq5Terjg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V+ojkHcNnU6yVs3+oZ0Lq5eflZxaw6VzNgyEM3iP5l7f4DPhStyU0AsVfC0iPkUdQUahiLUS8H3Ls4seqKsOqFsWF8JUrFkLT5sC6ohLiK+Nn7NyDwqDPo63PP1x2N+vJB800WuKrtwwreS2vWnMWecTJoKjfvaHcRbXhtfY6+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ix1kiSRe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739655657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NbX1zk1lg5k6KUKx1JyEb2MC59KZDsQkxUBoxWqsKymk2rMqrc9HN3QeS89/nuKKPvOcawEa3zwXskPqK1VblRyG161w7e8C/3d0JR2A1Q8Pu7YKUOVwETAB0HYdooPeNffgNu/SRputb5Af2db0QBdi/LfOcFwcUdsVvKRznXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739655657; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wNkunTcwZ7tTA1DeZin72+i0UjvFvWDXsnEPq5Terjg=; 
	b=nePZuMOi0a0q7a70EOq9QWbMnnNGyjGsRLFkDZxERQYxS0e84YNxJcnULoV9K7dpFkesgBoWMBA/W4ZfsMe6CX+ELGRsmayZUNr/Sdj5OnPoFB4LBSobw00f1wZpFRoTvq7zWwCtLUEKIp3ek7TiQ6c6/hJKadfJxbUukP0AIbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739655657;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=wNkunTcwZ7tTA1DeZin72+i0UjvFvWDXsnEPq5Terjg=;
	b=Ix1kiSRebBSiPWqdHJJgvZ6BIc/Q0F6yUFY2Hk/fjFflsGiAgVBZjR17s0R8geOO
	zF5GMFV72somwG5rfOgROzHgSWKKWhYA3bMe6X8ZiXI6Qi+Ual8W+1FBUYImQsWEI4r
	2txR+/eMZBLdiEkTMebM/lIDDKimeK9kCZ+Uj7Mk=
Received: by mx.zohomail.com with SMTPS id 1739655655643285.80977869700473;
	Sat, 15 Feb 2025 13:40:55 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
Date: Sat, 15 Feb 2025 18:40:37 -0300
Cc: rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
 aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Abdiel

I noticed that there=E2=80=99s no API to call =
`dma_set_mask/dma_set_coherent_mask`.

This should probably be included, i.e.:

```
By default, the kernel assumes that your device can address 32-bits of =
DMA addressing.
For a 64-bit capable device, this needs to be increased, and for a =
device with limitations,
it needs to be decreased.
```

=E2=80=94 Daniel=

