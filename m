Return-Path: <linux-kernel+bounces-283843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA294F96C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716531F230B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38591957E9;
	Mon, 12 Aug 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzgd/zIy"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E41514E4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500786; cv=none; b=Qw1R5Il63q0DWWU+5/C/8UEE94wzIUIRCZqWgrojxhcQgrwqUX4MyDvIK7rXLdtBu3ZP+vINL/WLYsmyaA+jXw+H7pczakvAIX2rWr/44CYZ9elvmyUcjXOfVsHTl6L9q9+V6W8Vh29Rly5+5Ryw86ZRdjngKlLWHLElzS7k+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500786; c=relaxed/simple;
	bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErDWgFsEafO7bf89Ve++F35UaTQrVM2OhIdNgxvPMx4KeTCMwQyx6Jni4JtgFqysyzGuzKK9KT57MwKY4CvEUwk+9BuXSSna8QT25AC1XJB6HagJX18PTHqWLjHWHViDdFyeR5Q7/RtdHIWAYQpBqqTzQwCBpzC1ytdwcc7V+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzgd/zIy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7b23793c1so28978126d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723500783; x=1724105583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
        b=vzgd/zIy/a8CtrKn+aMa6+W6QV9pflfnj1q3DWNiRj50Ln/3Yzj5mYSiu+5crxGChr
         vo2Gp/GbQFllVDbaaiJ3+TcGCjQ1c+vFPcPRod+9qK1vCM05C62H4PlPu9LpDggB1bkS
         qaPpBwf2N/nllYKnWJFUHKR+4DPb5Jz0EflzpxvzAKZSnOQ4bOPj01efO+VW8i0OIiQB
         7LpgID7pv/XnQxFrh5a2htHHAUcrom4dr4CrXjdwqiaGKOQipsdU303WLLe28ssigvrP
         MzDi4oCWXNLGYZOjYxGzYITusEh/9fplhLt4iHeAVp0GCrU3Snx6Nxp5Iew5UCWfaXel
         k8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500783; x=1724105583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
        b=UBcYYvstW/ucaBqdG7q973k0ww0lKHt4mY2xjsTLMesClGrBxyj22sydw/KPsQatyx
         bVLxUaSN1bs2zmbPFuZwB1fGHpxGlLymTyMlEf/fYoygN1AtQZhh9aIVhKLKI9paKKaC
         s9CSxfI1lUz6IMeGiwCdhYVQhinSJlo2a3UNQBhr7kTRA76p6MXXbRETZC34kI2QhsjR
         UzKHViHNbAaHF4+OlVYh3IzJlFKIm/nmFFg9+JLE+5KughRkztos+54Bno/w0ansQyaB
         odWK4jxic1mi/4FNvLrcTdg2g3OKJXudw1+YHws6CmZn8qQjlrpzTb0836auvmDUpy3q
         9xUg==
X-Forwarded-Encrypted: i=1; AJvYcCXXPI9IH13GXs+Y78/jlxQya+PY/oQVHujlsRMiri0iF7kLDzWstGc+WT3q7JdKARaZJokaUFHa03PwVyWAgDlaxW02JLIpdOlCJKzO
X-Gm-Message-State: AOJu0YxNQl8/a73ZdpCsmKexIy9XB5sFoCLw47D5NuH74KmvSgM7jvRz
	256TSqaRweSaXJva3AFCMVgs6ZVPeUQBdY2l1XlwBTgVHi78zM/2f6fgCDn2TdHifvNIeHJOT/5
	seyYhUyTjZ45q9vp1GeSsmQreDi7utrdpLAdx
X-Google-Smtp-Source: AGHT+IEoO+b9pY7C5DoqMaKmNrfWrx3T3pQDUYneGHRDOHmrDXK+WYRUv2ZXVfLXYFWMQ9tgg2yWFX1PctT326bWJv4=
X-Received: by 2002:a05:6214:3a03:b0:6b9:5cf1:65a3 with SMTP id
 6a1803df08f44-6bf4f84c149mr17036116d6.43.1723500782966; Mon, 12 Aug 2024
 15:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com> <20240809114854.3745464-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240809114854.3745464-2-kirill.shutemov@linux.intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 12 Aug 2024 15:12:50 -0700
Message-ID: <CAMGD6P0ckHzobW1j2GvqqZ3mNUHCBfP9xM-15s8B6yOfdv8MPg@mail.gmail.com>
Subject: Re: [PATCHv2 1/8] mm: Fix endless reclaim on machines with unaccepted memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:49=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
>
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.
>
> Make unaccepted memory free from watermark check point of view. This way
> unaccepted memory will never be the trigger of memory reclaim.
> Accept more memory in the get_page_from_freelist() if needed.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+

Tested-by: Jianxiong Gao <jxgao@google.com>
I have verified that the patch fixes the systemd issue reported.

