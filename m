Return-Path: <linux-kernel+bounces-374951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F949A725B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0861B243FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36021F9AB1;
	Mon, 21 Oct 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C35GRF7i"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DA1F8EF1;
	Mon, 21 Oct 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535414; cv=none; b=LJSzV+SSg18/VzuatzRlEq+QVozjJdHxTO0f07Oy1yQUAVlwBq92mpRJxK6XD6WOO+WdycI7orrp+jHDWZz8mR2FJt3tUECT//G+E2rbQRT0ro1EcKCf85Wm80LxfseM2zsrbT+DyWLLU4H6M8OqXxoxq02dfHL5iDbhsECtYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535414; c=relaxed/simple;
	bh=Y7QgImNJNcYfB3rYSjeOL/xhaA8wzAFDqO2mO7u4oNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfeWozYDrUAXS7Gj2VvlkZLg009MUKhSbkUl0ED5/LcpAgo7uEr7qaTGkyQhdN7BgXZpVlwSLps5TGq3uMErzd5meRTTEMZKZbIi/OIWA0NKI2vJRacE70a0YCyPVmp7SFp+RJs1R08/hR+R9sWXYoOd1E04DKyea/4X/17tSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C35GRF7i; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e5b1aaad96so303799a91.0;
        Mon, 21 Oct 2024 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729535412; x=1730140212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7QgImNJNcYfB3rYSjeOL/xhaA8wzAFDqO2mO7u4oNo=;
        b=C35GRF7iX86oqk5TvsQ+Zkn3hfgjpSAG8FfWFwB4NrZvffQKfxvrBovMTtvCgmfPjc
         EY57sjuz5ZUaI6naid0sKYmh6oobp1j0P19vGWBSG58bzZPe3Qp4kRpxvvsNVVmtz4X6
         1A4I0i0o1FTEiqPP9E8vFX1CxJGmQ4SPW2DP6/2m9MXBajivZI9oftWO/Tn1ppBCY/Bx
         KE5g86KxL4xJmPfwjwLP5l0GjvrGJCjShG0zHjw1REBwCpBVLOtYSEH44l1i6TinC7+Y
         pRw1Zlt6yvScg7V7N0lp8gnQ8NSDyEHTMEQsqDrggA//tI1hIGB6ZZNZ9JKMu6xlKQbH
         Y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535412; x=1730140212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7QgImNJNcYfB3rYSjeOL/xhaA8wzAFDqO2mO7u4oNo=;
        b=FJq8md/FxawKtGKCoKSviFd7+IoCh4fWRXSf3j9+MVBmuPDqGNJHh9kLxFMjU1STRP
         r/UaD0CG7U1iim4d2A6QT1Sa/KBeUSvSnJhl5MghpjJTF4Ju5jx1Jy3+TeaqbofSQuI9
         OA/cfgeYCNBh7/e6/sKvZxZOR2EI/qAlhCi3BtPSphozY4i1lA2QYPYTHDUYXGN7IUHI
         diGOLVVoTCosPBOylTa/VXzAdpkglzIXY4AdvKf6YK+6/BXh/8iVrJJ5pK4Hvq59iKhI
         C2TNm/Mn8Z275tKUautel2bFGn893j2UBIYgq/DjNzsDEGANQSAPRxGWApfN7fnfb8Sw
         eYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUtMiSlho/Io5qu9Fcb4mbdSbMBcAQUvR4sV61OfrdofwKCl1YlEM2B4BC9Fao5dFBXb2m6sUvGd/06N2BC9Xk=@vger.kernel.org, AJvYcCV8THLsf9Af20w4aVFznscgBOcWlv5/y5TscZ1roadCDADxpcZvuq762/sRQTSTqC5SkeHbgBeSjO4Wvhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gF9l0F1hxjITCPJ7u16FR0UfCybpyA9117dbhquFplgfkG5i
	hRETAhdPVXcPuyOVDO9O2UKXXXJwdRspr/CA74xh1Xq9E3YN/fjfGQdKFOQ8Lx2IMOH7PNJ87UP
	YOZwgDflsYSdu+8/D4R4zKZ55uW8=
X-Google-Smtp-Source: AGHT+IG6ynQ1F+T2JgDFrhch9ZtqaD4wp5yKg3BxlCsyVMIcS0APZZO3TStoCrk/4J7lTEDUscxdUgUXMT1LpK1FXGY=
X-Received: by 2002:a17:90b:1c0d:b0:2e2:c3c7:bce8 with SMTP id
 98e67ed59e1d1-2e56172b2a0mr6225453a91.7.1729535411854; Mon, 21 Oct 2024
 11:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com> <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
In-Reply-To: <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:29:59 +0200
Message-ID: <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:20=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Silly nit, but I did start looking for brackets that aren't there, so:
>
> s/Brackets/parentheses/

I noticed that too, but I checked it and brackets is the BE spelling.
So I left it as it is...

Cheers,
Miguel

