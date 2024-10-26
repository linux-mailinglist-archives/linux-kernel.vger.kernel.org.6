Return-Path: <linux-kernel+bounces-382916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A29B14E1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02E61F24E88
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D91632FF;
	Sat, 26 Oct 2024 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cokeri1/"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899B1531EA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917678; cv=none; b=UUwFXgKmDrFP0E7pSZJtXVrC6bsKGw/7mNwKo52h3XXMuaOFtERE077gXmVzJbcmnh/f+roZwpabxrCQlWoUaZfJ/wEf3Ut7Q9zIHRGK1xLq1nlrYCEGj3x17Ak1EDwHFffbvtjylHJIfhO/n3jov2TxqV8nCJ93oEDEYCqVP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917678; c=relaxed/simple;
	bh=bG1xePoLOSX0cH2rSdY/An1S7OlVrBf+VaZWUlNt/tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWwrX2734jxwrZaWzJPJky9woGjX1YO5skgOtYhDHsXHE2lTwmRv89pJXM2t0cL7jYqHtzhA5VDudaI5Upvt/C85co31pI51xr+BYtN3JdtikY39qOXQU/iAawKS6Dj1ckTAkkkv52Q0/T5wV4o4Ld5YWqrPuerA/eAk7LxdcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cokeri1/; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fc818f518so747170241.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729917675; x=1730522475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAnyCBK0PLNAMXssVAfQq7IBDs53bW+/DfNni1CHV8g=;
        b=cokeri1/sdhm8AmQFHIpEl5gjNsC/u749U00CaKyvbf1sJOw2xQUYXws4euR56nxZz
         Cu4tXuCnBzNJ9W200YGF2E5hgk6TrNwisqiW3qM7B61/9W1sO6yquWtZhEcGQOiuCvh9
         2k8CzNVHoKKPeqhnehMvauxg21uMID4KSBZG6no4xF+YsVixBTiTD5Gnl8eGrISDg2VX
         xoYTQtjtjQa9hIHwvZ8Jf7QW9AAC5G9SHTLGrT0CWup4tEt9bofOGI32sFi7b/ebKU+8
         adP2lr0F0lu9CISVwT1k3hy5WZYzcd2UdAMSaUo4fy9bretXEWjh9RvDcTfaQLc/hwuv
         pgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729917675; x=1730522475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAnyCBK0PLNAMXssVAfQq7IBDs53bW+/DfNni1CHV8g=;
        b=O2u7rM8dmcYbnibWxeZkHJ5VBsWmgZ0cJD3lMU1+aImLppDiUgdRWARzypDMBha6QR
         RLFpDCLgQf71NIi2Si96tYwfuVRhM8SmAptXEWPrH2gzRc2nNQOm/IUacWmvBKEaopDY
         5BveVwvDZvu2Ao5uIggrCIvTdV4nUsRBVaSsUh2N/3pJBuY+e/1ecpdMZFbQgij7qsPY
         figmqM23WTIEEYoBI3Zlg9VniBbYEvUdW2Kbg7D0Xjbgn6KDqHnPqpaF+dEYBPp3E/AK
         Szhx7cPealOQmPvcxaYvTPNurILMuays0y56mV7CKio+fahVnXfUQaaKstkPYqEcYFJG
         pwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKMxnVbqloPivzanT7RGUaW108ZCWIMlUZRkkWUa0ikRQug4MZ/Llr37ehT9yF24GWSukHncCy6v98n5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKzBUMJKvOhlzck8CVNVotE0KfuT9u4S9kL4D5NnfKRpk9qrn
	AVCcFY5dBJNZTQXX8jhSKkrjWK71KU7AlR3rXjcxjLkQNZlkhgmGrKqzMmA51csYQwu0GALDTuJ
	HzGA16Ms4gBPEVBXdX+A5NyqHgQeaOB1UXpQ6
X-Google-Smtp-Source: AGHT+IHDrltpxa49FTdDiFiElc9ogTcqJV3V7Tx5BxsICqvZOZUruHSZhcaiVelmarir/I643zlvzWmAkHkNynoGbdM=
X-Received: by 2002:a05:6102:510c:b0:4a3:cf4f:e19 with SMTP id
 ada2fe7eead31-4a8cfd56fcamr1279429137.24.1729917675022; Fri, 25 Oct 2024
 21:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <20241025212448.b1a9069d71df5b497e1b0190@linux-foundation.org>
In-Reply-To: <20241025212448.b1a9069d71df5b497e1b0190@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 25 Oct 2024 22:40:38 -0600
Message-ID: <CAOUHufbJs3GxZGsJQT6AHQzz2KAETVwWCaGjeybTTCH0K2Nu7Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Andrew Morton <akpm@linux-foundation.org>, Link Lin <linkl@google.com>
Cc: David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:24=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Oct 2024 21:36:25 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > OOM kills due to vastly overestimated free highatomic reserves were
> > observed:
> >
> >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE), or=
der=3D0 ...
> >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high=
:1068392kB reserved_highatomic:1073152KB ...
> >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME)=
 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*=
2048kB 0*4096kB =3D 1477408kB
>
> Under what circumstances?

Link wrote a repro, so he'd be the best person to answer this question.

Link, please help. Thanks.

> > The second line above shows that the OOM kill was due to the following
> > condition:
> >
> >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB < min=
 (410416kB)
> >
> > And the third line shows there were no free pages in any
> > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> > 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> > usable free memory by over 1GB, which resulted in the unnecessary OOM
> > kill above.
> >
> > The comments in __zone_watermark_unusable_free() warns about the
> > potential risk, i.e.,
> >
> >   If the caller does not have rights to reserves below the min
> >   watermark then subtract the high-atomic reserves. This will
> >   over-estimate the size of the atomic reserve but it avoids a search.
> >
> > However, it is possible to keep track of free pages in reserved
> > highatomic pageblocks with a new per-zone counter nr_free_highatomic
> > protected by the zone lock, to avoid a search when calculating the
> > usable free memory. And the cost would be minimal, i.e., simple
> > arithmetics in the highatomic alloc/free/move paths.
>
> Is a -stable backport needed?
>
> If so, is a Fixes: target identifiable?

The code has been there for many years, and we only recently noticed
the problem from Link's repro. So it doesn't look like a stable
material.

