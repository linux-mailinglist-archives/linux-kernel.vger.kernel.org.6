Return-Path: <linux-kernel+bounces-547721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A833EA50C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E742B7A4DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47A2561C0;
	Wed,  5 Mar 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0gwJRZB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CD3253B5F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207022; cv=none; b=XlB/Dygg0G3l59cWCMsWvYOQaxZIFH41wWRYMhIedTU6QiuGqSzQp26scwmVtHPPaj/RtPrjOWyF48oRR8Wjh9LLcARKRybljnEKycuV/xDp0XRiuJrYB6e32vE9x2SBj8sntLi+w36mU0uxSAo71oSIHQYV1xfehSDJ0skgkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207022; c=relaxed/simple;
	bh=EgjrObn8AKM6zdsRxv93dmjznd4ZAhRcRowc3kWrAuA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OWKS97x/LqOhFJehXaFL+r+xyrr1FZwVOrdXWAzX+K0Xr7M3Prag81k7hyJDeVEDyS6LnRdlj24J8xFual/1qqZIjXLSUPCP+dZQMkym12+DJ73ev53VpytRo3AoNOwtyJc5Fv4DoN3AP5LjqiQ2rOBezD5zCP+ekRS1xTyn5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0gwJRZB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso23699515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741207019; x=1741811819; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsmX/OpLN1sMnCZRxg3yLh3oM0HIrvMLKk0gSzLVUKM=;
        b=m0gwJRZB6hAOiekmNWJGVztuuA3WmVvnMdmbyD8CaigizG8dyl/oXkVgMmm4zgyVIV
         XxSAatrKBjxVA9O/QurzzEOXscYp3obxlbruL/FpscQNo86bW4wyKhQvQUEf4IEGkUXl
         xrLEvla8FRHLmH3jJcV6Grm/YRNjY6bnCLD/j1MPalbWq9eeBfurg83b0HxXkEsDp4nQ
         vDyeG4t8NAXS4+dv0MzeJoLX16BCPBVWsUWvfBW4OpMx2XLYyh4MMHNNoPSwsWg77skx
         S3s2YBV5XVjtckW+fZNBa6jqvaoDTiW8h5pSsjtKQTng3k/0OYJ5nI7k553lH4Uaw7DE
         bKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207019; x=1741811819;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsmX/OpLN1sMnCZRxg3yLh3oM0HIrvMLKk0gSzLVUKM=;
        b=tZA0Uq1hqxolkIJHOgGP/VDhbttWQ/8LN6SN3nUo9M66+IUCLiZOUvfex+KffJc+K9
         mDr2+mYnOiccLIdlL7bGLT/fkM4Fu4NhjOj23l599LHG1+AfOJAR0mB7ToYBYzGnkQam
         5NWvXbc8fD2YLS+NjqB+7BD6d2bvDGYPkjm4iGBBE4SprS6gSJnnaJSdLzeXU+VXqqWH
         d7dE98EbtDN11C1dxCwTHOnhL4SBgclY1xoWBqn8LoVxHKdFNDKiymSRfeKVVy1jvxMI
         wnMkM8RCvSr52bwsAxKyQMpz5EMsYsZuplMM7s3SXvjeFhGuVrX7KtzI/xn89iUGRSss
         Di5A==
X-Forwarded-Encrypted: i=1; AJvYcCXsryE+Vh4q42AhMq9Uv2zjWR9k7OXzWqC5FUouY7WuLuufT14rA9DBQ/X9C644IWnIH2n1c4L0dY2PRMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GGj9fNg0raFk4+tJm/50ryoDEhenUJj/90lvsgdLqPkBwjBT
	ruWXVMNAzU0elL0isuEMdiE0BBqsnXXjfngK+hMe/YDwAscqwe9Y
X-Gm-Gg: ASbGncviu9SiKbAOJkCehys9LLgtC/1tmfQxoiGMcpnkPhofE84OIiKwGhofQdD2az8
	F4lPT5ygVvWb5amH0++6CNKw2RtV0favV8mIgfz0cqO6Gesgk0KdQyoQPN0OsUBf0lAUvSWVgtw
	Bg9JhwlhJv7mby1g6nUK7cAiikHa2K+0SpMnIV3Tvd/IK9eUAopcuCgV+SgEjxTCdmFov5vv9HQ
	+tzf8g6UQrRggrQY7Azwt45g7PeTTm56vNa83VrZzq4eVuAE+CvW5muyxNXwI6D5Yj4ota5mJZQ
	Cdq0ovk61MQuH7qETja0oSs1cgAlMgzr5CGPPjOD273xaAdv06xxMllcVw==
X-Google-Smtp-Source: AGHT+IF1yVfuC5cS7K4wj9YscnLWgyaGE58k0iUTo9bMqcQWJWNwvwLwpjIqgRC/S8h9Lcpu1anzEw==
X-Received: by 2002:a05:600c:1988:b0:43b:c590:173c with SMTP id 5b1f17b1804b1-43bd29c7904mr34660015e9.24.1741207019094;
        Wed, 05 Mar 2025 12:36:59 -0800 (PST)
Received: from smtpclient.apple ([5.29.8.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd431124asm27810065e9.38.2025.03.05.12.36.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 12:36:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED
 and MADV_FREE
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
Date: Wed, 5 Mar 2025 22:36:45 +0200
Cc: "Liam R. Howlett" <howlett@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>,
 kernel-team@meta.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BC81F7C-191F-451D-8FE5-5BB268F6B0A1@gmail.com>
References: <20250305181611.54484-1-sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> On 5 Mar 2025, at 20:15, SeongJae Park <sj@kernel.org> wrote:
>=20
> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> can happen for each vma of the given address ranges.  Because such tlb
> flushes are for address ranges of same process, doing those in a batch
> is more efficient while still being safe.  Modify madvise() and
> process_madvise() entry level code path to do such batched tlb =
flushes,
> while the internal unmap logics do only gathering of the tlb entries =
to
> flush.

I made some related (similar?) patches in the past. You can see if you
find something useful in the discussion there. I think your version =
avoids
some of the =E2=80=9Cmistakes=E2=80=9D I made.

[1] =
https://lore.kernel.org/all/20210926161259.238054-1-namit@vmware.com/T/#m2=
3ccd29bad04a963c4d8c64ec3581f7c301c7806=

