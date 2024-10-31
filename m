Return-Path: <linux-kernel+bounces-391117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35D99B82DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C9A2830DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F31C9EC4;
	Thu, 31 Oct 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4Rqvyvx"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE74142E9F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400538; cv=none; b=HYvhDtpTI+JEdvTDoL1q21WQtN9AFoNwmZ/a0blX9b23Dnzq578aylJsuwPHv+uU3p/Dzzclk70nJ5D30d4I1mKxS2gJPrbUaonYkkLVIjMhNY6SJ8rICd4QPujAxQTC+7RwVa0+53ZOHR/SMCt+75aMQA6XLjFM1Th1+xwxg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400538; c=relaxed/simple;
	bh=StOX3VJgeeCcGydnHoV/ppcMTS/dD8CMc3Z15gN5Oj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9RuDKt3uP0uHF5G0+RzOaUAHa/Y+lillTaRJLtFQRzNGNX3YMRZ8Zu+upuNIOCjqaaJXWEoit3rywut/rwOG/mWEhWulc2rqzDD00rJi9Hl5+ezAC/+fMHIsIWAqbt/aqDZ3QOAYRGyRdPjGTbKLUsgwaHbhcKh1LtegccrGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4Rqvyvx; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1182751276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730400535; x=1731005335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjxTbYK0rVm6SzwGaJPD8zRt8ZyPc2ZbH6hoVthyGCw=;
        b=d4Rqvyvxay5R2gRXg6RdQ6Ml4zs1/HkVBQLW/NojLBRaRDR+bwWfCY7EV8NP4C5toi
         W/vtQSpZA4DN2nj3gyz6FrSsEdUnywT8LVMki7tw7Y7wmHBN6u7Pf+ZcFR6FUTZSLhEX
         +ifYolEMDLb8Xe0FpR4xQ0EOpP7fgVUIjQoDlzlbSguHTgrRMPxJ+QTWZy15F5kFktvO
         7QsnaxHJDNMzrUBWSuWtWKaEWHmgI4wiYR2Clfqi42tuj6lkiHfbHdVQuGPY2Xc5tQPw
         NeteMzxD06H4L9VkU16zVpHjDWWX5JOf27B1x8OnCd2qdwwNVYDjPcSKBfaoSOouBRUW
         OUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730400535; x=1731005335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjxTbYK0rVm6SzwGaJPD8zRt8ZyPc2ZbH6hoVthyGCw=;
        b=vbMWcYhYE5Nkwh+l5xuOjcs7JDtbfQW0Q8Vjcc+hnrc2f8gQcDKstUOJwVpWkhxXRD
         OHYZqraV5es909qmT1Lsm39xsXAuX9p0QuI+Ngzi5PtEj7TncRIE/rOi27b6shMZuklv
         h9lDnmQLdLJJfS09M+LXmzcYxYZ76kNLue1pqFwpG4KstV2iqv/SYej1Z0QA/hkqj1/4
         GVFA3F0sH6hxnuMnd2QO4lQfXduG07dkteO9f42nlEJPjWf9ufJDfiMxe8SKIzC7C4NJ
         Ok1+Xi395Nzw9e6IQWzeDFfAXaly8k6NhwZ5j3SjTtTkemdeQ+gBkzyFy6/wqG9jP8IK
         IKWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2h6i0Zwyf3bnBR+wnQQNPyNyE3hZNY7TS1ri4O7cXH6VGZo41Wi0kAY0o4ItNv5TAZCVYEwl6Ong9o/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWW3FLJuSYPOfxOuizlM939K9PrZf1G3uXoHTFfmeDHLXRiFk
	jvGRWseUXoq9KLAjmZMwPDQ7+epbUyEkh3hiHhg34q7PaU4yR74quVfXk5CdwKlOV9RkWO5DtQi
	q7F7UJ7/eqXG87+ycGS4MGWH51lm5GuKIbj6R
X-Google-Smtp-Source: AGHT+IFvoa808z3zzct+NFJ13//TLpJPqCF6MpauRdMB2NX4h5McifZkHrW3H7AFthX58R6c+y4oF0AERWAfPfAcGPw=
X-Received: by 2002:a05:6902:2501:b0:e24:cae9:4e39 with SMTP id
 3f1490d57ef6-e330269669amr898774276.51.1730400534880; Thu, 31 Oct 2024
 11:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031170633.1502783-1-seanjc@google.com> <20241031170633.1502783-2-seanjc@google.com>
In-Reply-To: <20241031170633.1502783-2-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 31 Oct 2024 11:48:18 -0700
Message-ID: <CADrL8HUwkxGmud5hVYPC6ibsA=ee8SePbzz23Vrqrex+AOtmTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Check yielded_gfn for forward progress
 iff resched is needed
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Swap the order of the checks in tdp_mmu_iter_cond_resched() so that KVM
> checks to see if a resched is needed _before_ checking to see if yielding
> must be disallowed to guarantee forward progress.  Iterating over TDP MMU
> SPTEs is a hot path, e.g. tearing down a root can touch millions of SPTEs=
,
> and not needing to reschedule is by far the common case.  On the other
> hand, disallowing yielding because forward progress has not been made is =
a
> very rare case.
>
> Returning early for the common case (no resched), effectively reduces the
> number of checks from 2 to 1 for the common case, and should make the cod=
e
> slightly more predictable for the CPU.
>
> To resolve a weird conundrum where the forward progress check currently
> returns false, but the need resched check subtly returns iter->yielded,
> which _should_ be false (enforced by a WARN), return false unconditionall=
y
> (which might also help make the sequence more predictable).  If KVM has a
> bug where iter->yielded is left danging, continuing to yield is neither
> right nor wrong, it was simply an artifact of how the original code was
> written.
>
> Unconditionally returning false when yielding is unnecessary or unwanted
> will also allow extracting the "should resched" logic to a separate helpe=
r
> in a future patch.
>
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

