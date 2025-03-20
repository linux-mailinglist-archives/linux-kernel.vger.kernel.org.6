Return-Path: <linux-kernel+bounces-570042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37099A6AB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EAC483DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092321D3E2;
	Thu, 20 Mar 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIvhV0b5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB217591
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489074; cv=none; b=B/lTGSy1CIHW9Q+XpNEX/iIQZ8UNzVFsrIqz5XNeDqFfnsw8nfE7fzRdw5PCHS5RhwljqM9f4YztAnznlNp8dO9xewrpGv8CKb6uUZThkLy/JVlO8bXXuUmCeU+kdN9kpqXpONfPVbhE5PuDNjgc3AVBxKZq+yHia6PgoA5JBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489074; c=relaxed/simple;
	bh=Sl+Q3tAbqojV0VFuCPLFXyH+mpVFTX55Wv7F6O0y5c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrqiTyIJ2Seu/OsetrTyNAMu0Wep8vdou4y/zT9y55xDlx4rXCjvhpZFQlKFKfr7HqsCyAwQ9daLrSJ69SwFT5UOFsyUWmuhp7aOJvCSef9DqVRwzpyCAoO/8hKQvG6i1wsMT50e46F4Pk41uXLoovz/XYIVJrJDtKfbWd2N3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIvhV0b5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3996683dd7bso132782f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742489071; x=1743093871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl+Q3tAbqojV0VFuCPLFXyH+mpVFTX55Wv7F6O0y5c8=;
        b=nIvhV0b5pAk7RR4N7Y1Wj4rXFuc8lKj56FGfQXnZuSQc5d6wB3v5008/cg8k4MTQgC
         Saran7I4bza5cWVETP6yTnpy0dPdPjisM0QZQoH5bUU8SzjXcishCoy+0Mj3eXNyBmco
         ALvLxV7zKEQIc2iN3adfAkbRKBtvE61bChPIk/q1mvirs6Y6tlKdKGdwXPFtRno6JKxY
         a2R01738ru44JyvRPRKIoMXtFre24k1KMd3jXxO5fgHRUgNSmxNwpjo3GGn9OX9dsJVJ
         EkgAZjggB2JzE9rMkhTVfiD4X+rc81GmTmAP3xIRJ/e2pj0g/Me9BuiCeY57053BA74r
         maQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489071; x=1743093871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl+Q3tAbqojV0VFuCPLFXyH+mpVFTX55Wv7F6O0y5c8=;
        b=a6rJL1BV7zR7vTaNcAbZekJdEI6eEs9J8UZSEmFjSAuUYgmDnxd0FwM2mTrNWCBLcl
         nDmTNdTIvKkp3sLLrrLzQlHYqSk9Hv0+2d9LuGaGTevAHlOMlGjFm9t83zsQZcBs4Gs7
         5+uBOJuOLkOoiZICFENYqKsPg9OGUODTblh2Xpi0lEotUS08IY3iyMsnAxWgFfDnoQ0/
         s7ZMdC+pgEQ34fGk/x88G7jRO9ECk3wuIyeCUODTIxrtGBFIyd4NbEyijeEJYxbPRVsf
         cW9et4UKLo6kC9853zLhtIov2XSfYwF0uNh81GdZCULAcl+pDDnJ/pBPo4FatQtiCzlY
         wl5g==
X-Forwarded-Encrypted: i=1; AJvYcCWpgTFc+gsZ61SZjWdnZtk0o9dpbSxReknVtReZjRZJMVmtRTZ8IsoTB7bBSrkvkoQu0Pu4AFX+J1Dp9jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PLhX7SruDd0Eob78BcVtTWqzaxZwDW1afo3il0L0uK2YYd0k
	PgjXTVwsFXmJbpgnu/TBAueg/Vdtzl0nsNW3fuMSUk2f4T8q9ciA10DkfGN1BN8kidccfbpkyv1
	aQtYdrEZmh/febG7KJ214M1wcFUI=
X-Gm-Gg: ASbGnctC3cFEKZo2UP26bQHNhuc0npwlU/y23xuz1LAzLzbRQ2Z3mGHBsI/Y9EoUTSR
	e2yQ6H3U6OiTTumpwrN11EqQlK9EAFfO8qj3gjHYhlXX81sfDTcA9PkkLXDYg86tq8vl9aBkEBE
	ld74HIpVH0Gudc3I03SUVbrYAZXG/GoMWHUWyij/l1bbtjStUc1cNVc9SY2Lz9NN906+I=
X-Google-Smtp-Source: AGHT+IFZKHpYsKH5wHL76fHPVWZbMWOpx+QtGI6GB8lz4cUAk5M6cNdY7pR3ndrTN39JCHBJ7oIVLGdJhU6rQSsqLpU=
X-Received: by 2002:a5d:6da1:0:b0:38d:d371:e03d with SMTP id
 ffacd0b85a97d-3997f8ee224mr80691f8f.3.1742489070959; Thu, 20 Mar 2025
 09:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318015926.1629748-1-harry.yoo@oracle.com>
In-Reply-To: <20250318015926.1629748-1-harry.yoo@oracle.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Thu, 20 Mar 2025 17:44:06 +0100
X-Gm-Features: AQ5f1Jo9CZLQDM2kpJQ_9WPJBbin-yAHC_Ppwb9Qyz7cZjnJt1uQNfIhmTJ0Fcw
Message-ID: <CAPAsAGxdD04nOz35TERJi0aPs+9TBEytrqNVq8h4EA819PA9pg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/kasan: use SLAB_NO_MERGE flag instead of
 an empty constructor
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:59=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> Use SLAB_NO_MERGE flag to prevent merging instead of providing an
> empty constructor. Using an empty constructor in this manner is an abuse
> of slab interface.
>
> The SLAB_NO_MERGE flag should be used with caution, but in this case,
> it is acceptable as the cache is intended solely for debugging purposes.
>
> No functional changes intended.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

