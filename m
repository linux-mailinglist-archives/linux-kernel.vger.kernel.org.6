Return-Path: <linux-kernel+bounces-558600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3CA5E86E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4523ACA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ECD1F3BB5;
	Wed, 12 Mar 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d31cMpTX"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD91F3BA3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822204; cv=none; b=QPsT+8eecBK0vR8YQH4VBNqJfFsiND2WQ9N2nIlpBynCJnLlyxHFEsdtkcDOnnUXku0j8wHhXb5sdJ+EEcz/yeOljMSWC5VmvqJfo2IIecL24dwLbqr6copbAFm9Px/IHrvD2+YmYY7TNB22pO0FV8Zl7zlWCStdNing1wR5fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822204; c=relaxed/simple;
	bh=xtGCELKG2VSoTGpGJxxtVIorL1o3aUsplhMbETRvi8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8ERty/02sixC4jW2I4+TF35fZZMc+EPoQAXHekus2K7OQfdZDZksIcI2mHDqv2Zi3ynt7n5PuseED16FJhyVsHLWenUNygNOSjsC2jacwTA8oNFecDZO/UQCnLoTzH10m+3I7hR9+XloTG8MXLj97vJ7Qtozd8u4I61aRA0GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d31cMpTX; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b9143f4c8so44508a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741822202; x=1742427002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2epRF2yIZ4WoKvdTuk66kXn9icmipQ0jsgIlyAwLUYE=;
        b=d31cMpTXmhEvFlbozeNsKyjJUuGDyC+FV3WYUrtqhI/uojKmitQzSLGiN5QdYbqdfP
         UrBk8QxkovK/5iEZSxoxi+PIv8seZ+5hAbEg39+uO7awlyPAyjDAusWf5uRhXiEFEkPd
         AJWFrnJ7wa/6jnOZ8fyG3bVjpmEesaMrMkKzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741822202; x=1742427002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2epRF2yIZ4WoKvdTuk66kXn9icmipQ0jsgIlyAwLUYE=;
        b=oXanj136qlBCvmbAM/YavxW9S6InOm4DV0cbhotpKvbUPYxfJts6oXcbb8N46w6cbe
         l3sTWA2wSGHue6v9lS4gDyJK8Yb3ggzKxh+qQ8hPXD6VH+GJHp5WAi8XRGlg3+nrHGIW
         xni8zU51h4dLdlmFkj6QRALT6orO0WctzbbK+ZEqp80qhW4lT6p0/KADVHjq3I7Y5j8q
         dpdlUSvcWXCW+6fojKlJftjKFoOtJN5w4mKS8Jw4OJj0069O6rHjh0pxugJYtOW6Nnum
         jWlnzNz9wCGSRtqOjkno9HZCnbhUFV7hB1kQFerLI3nPhtEdH8qPeFSXZFkOW02W4c+j
         I+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOUaHIg3VYHuZN94rDRMCZGeyHKKLj27dt1A0Rqf8MdCtzuIRRfV8mxjHdhq3xq3ZylZBhbb3/5kPxLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywur0gk6Sf6UPvmVkQset3ywVF2I3wgTC6dMev+cXV4tHB4dzMw
	R78LdlZCS4XZvslvSoPsKB8y2ajytxRNtmlyLbyGstB4gAk9zvpF2vAmlk9OGaNYrDiiPdqj0+G
	KK0F5d3e7XW8EJM9vgW/NAOhIyECuKceRLGQO
X-Gm-Gg: ASbGncuuA+o64n5+b77yQRdQ/KJGdUZxUbVoC46PJxwaqLtp6neZl9nCQsci94oxVHD
	oI1arDVn+qo4uzQlFgsBfqyFeOBQDLqJaSJm3qWOOEeLCMF/UHyiZMl7y7RcaxvMoKNHQ61yut7
	dPnOwASwYvTlZxqQTMmEBZjdos
X-Google-Smtp-Source: AGHT+IF3KK2zPAe3DQbz1LO5JCsOn/xBbba1NwUWwZbYJy3s2T7qPHVL8YcMfh75jIyOKbZ08RS1xlD+8DXPHeL6Fb8=
X-Received: by 2002:a4a:db95:0:b0:600:24f9:21fc with SMTP id
 006d021491bc7-601c24cff19mr1200447eaf.2.1741822201807; Wed, 12 Mar 2025
 16:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312002117.2556240-1-jeffxu@google.com> <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local> <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
 <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local> <202503120931.3BD7A36445@keescook>
In-Reply-To: <202503120931.3BD7A36445@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 12 Mar 2025 16:29:50 -0700
X-Gm-Features: AQ5f1JqOVPfwUnKOxqrdAsJKAmIgChV5YiCTfryTQdRd23HMgTcMUTwhsepcUGA
Message-ID: <CABi2SkUs3bXB2jw+1CUQPtWfZ6-kZDunQweOSSw6j_8JALUfAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, broonie@kernel.org, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:45=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Mar 12, 2025 at 03:50:40PM +0000, Lorenzo Stoakes wrote:
> > What about madvise() with MADV_DONTNEED on a r/o VMA that's not faulted=
 in?
> > That's a no-op right? But it's not permitted.
>
Madvise's semantics are about behavior, while mprotect is about
attributes. To me:  madvise is like "make this VMA do that" while
mprotect is about "update this VMA's attributes to a new value".

It is more difficult to determine if a behavior is no-op, so I don't
intend to apply the same no-op concept to madvise().

> Hmm, yes, that's a good example. Thank you!
>
> > So now we have an inconsistency between the two calls.
>
> Yeah, I see your concern now.
>
> > I don't know what you mean by 'ergonomic'?
>
> I was thinking about idempotent-ness. Like, some library setting up a
> memory region, it can't call its setup routine twice if the second time
> through (where no changes are made) it gets rejected. But I think this
> is likely just a userspace problem: check for the VMAs before blindly
> trying to do it again. (This is strictly an imagined situation.)
>
Yes.

 We also don't have a system call to query the "mprotect" attributes,
so it is understandable that userspace can rely on idempotents of the
mprotect.

> > My reply seemed to get truncated at the end here :) So let me ask again=
 -
> > do you have a practical case in mind for this?
>
I noticed there were idempotent mprotects last year while working on
applying mseal on stack in Android. I assume this might not be the
only instance since mprotect gets called a lot in general.

Blocking this won't improve security, it could actually hinder the
adoption of mseal, i.e. force apps to make code change.

-Jeff

> Sorry, I didn't have any reply to that part, so I left it off. If Jeff
> has a specific case in mind, I'll let him answer that part. :)
>
> -Kees
>
> --
> Kees Cook

