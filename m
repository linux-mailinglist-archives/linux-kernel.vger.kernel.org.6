Return-Path: <linux-kernel+bounces-409174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19099C884F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9221B1F22900
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307401F9AB6;
	Thu, 14 Nov 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="sGu/artx"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A41F943D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582118; cv=none; b=ShqVEsG7wFZUVv8M/inHWiIZcngFsUIs4dQRRCYyrkR5MXpRldRZxsgPZHwvlAGJ0oCPW9gZejFHaNDrEFG7EVHZzGRSiVNsOpEQLnc3Ufmfl0ArBNCSGeyQclStqOUCSpGwNTPPeiPQjgM+fOoYuE65PoQHZxdnwAFt1EN/x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582118; c=relaxed/simple;
	bh=qPAWrOr3vWkhHjcu1uXtnkQY76pnDl93bawx4pmiu0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS28aIn1TD/7nYprdewEXPkmEPcRWbLcZ5WaPEQBygXlC0qStwnV/vBGXmqLdIkWjMF1YU1cOtSnnjk1ZWjfZSqwuKTp9+TB3EcwoSJRiy0s7t+lCtr+JOS6x/tO4XYRpEMpm4W6HiImsVA6HT4NBOmckfeOnqik/4v549qafQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=sGu/artx; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso4083011fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731582114; x=1732186914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CdykCz3hdWH3Ou+T064c0ieZUNSSG/qvO70CTuEaX8=;
        b=sGu/artx82Uc4HbQrRIWH41EGrewjPjLkRtfjFY8/Zs/Ii5pVNIVxivucgWD0vWzgW
         TW0FKzOBM/LtUZeezlLYCkcqUrMTxfhna7ufN3QvRNp4Ur/oVzFpSig3jU838t1A8Lso
         KIitRq5q89QkARZdNjohM8XKXA3bbeUx5Bf9fA+xuZw4+NNYL1HfZp234iI0VFDhXdc9
         UVyyumMdSPQdTVpWdtKw5AM9IS8F5BiUz3PCebFVu4ITvyMmxRJpzD6Ubhm/xXPKseZF
         zJzf66Ord6J/1gX+7HLDsgEsAKbHCOEEF4C7D3yhtczJF5Wli1GjrQ66Yo1eZN6WMzq/
         OXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582114; x=1732186914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdykCz3hdWH3Ou+T064c0ieZUNSSG/qvO70CTuEaX8=;
        b=KhXfyv2xZF+3n3BIQQbz31kM4tCPVgmvFkr6MV2/MjTF8SHvAfjE4zrRCJtRK9kulD
         v8RbnGSZYrxL5Oex2vffLBoCaa6bNHox5FnZH0AzTU0bYwRpSb1xo17qpJLuT6XNaUWg
         O7q5K61jHId1ot61V2/7bQa0JARO4R3dUarY7m7dgAWt7AgfTo9rsEvrBq9KGTRdJGSR
         JgakEHNDNZxs2769K2qskgH/uNGjALh+eE6S/psxzRtFeFnLJrJtPjnvtMGQpAOqC3JA
         l9FMFCmA9L5VQHNNwErtasZrp6Xadtf7WqcaiUgo6aQJfSFxnTgjKeCJRP6wK8ZKH3HD
         Fh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNDJoh4iOzkH1TBtn2+v8CTnwhS0IGu6Yu9uB4IVyNnq2argfaBhmSMl78O1jGxxP0Gia/5ufMmiRjqCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGRiodtBcw94vPfV4rlr9vplh8Iakz+GU8lPSRHcV9ryqno6h
	CgGUxs1ThRCWaQBpXPdzsI1SIDNSpWUlQQbA5RRu7FRWqgGmInVgHsp8gr3J0zW84opSD/fJUhU
	ZTmDSD16w+E3e0Rk63k5g+VkyMfxiwpBjttY6eg==
X-Google-Smtp-Source: AGHT+IGbi3VDPOzkHrrfqdZNWFsbgtu7/DdTzRf299ddEfxUAeB7GKsHAUYjFDrm8Gxf3Em1QMcHxhiQGuJ9zjk/uJo=
X-Received: by 2002:a05:651c:1589:b0:2fc:a347:6d87 with SMTP id
 38308e7fff4ca-2ff20162111mr119380801fa.13.1731582114230; Thu, 14 Nov 2024
 03:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
In-Reply-To: <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 14 Nov 2024 12:01:42 +0100
Message-ID: <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:40=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Thu, Nov 14, 2024 at 11:14:02AM +0100, Philipp Reisner wrote:
> > compiler.h defines __must_be_array() and __must_be_cstr() and both
> > expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> > So far compiler.h lacks to include build_bug.h.
> >
> > Fix compiler.h by including build_bug.h. With that compiler.h and
> > build_bug.h depend on each other.
> >
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > ---
>
> Fixes: ec0bbef66f86 ("Compiler Attributes: homogenize __must_be_array")
>
> What actually breaks?  This commit is six years old.  It's weird that we'=
re only
> seeing build breakage now.  Or did you just notice this while reviewing t=
he
> code?
>

I am working on a compilation unit that includes linux/string.h.
Compiling it breaks when using strscp(). That is since commit
commit 559048d156ff3391c4b793779a824c9193e20442
Author: Kees Cook <kees@kernel.org>
Date:   Mon Aug 5 14:43:44 2024 -0700

Of course, my trivial workaround is including build_bug.h in my
source; it is just not the proper way to fix this.

best regards,
 Phil

