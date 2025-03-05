Return-Path: <linux-kernel+bounces-547384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F2A5066D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D767A45EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA231C8629;
	Wed,  5 Mar 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFJon8we"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0517B401
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196132; cv=none; b=mvrF4skoK+oHCSf42lNV1k4xN/kdRqIT/oLgD3Un3WVpJjfSKWdrq91HWpYz6xADK1uPtRkE1T+kOz3tZRw8BeEslHUhDBWmB4pDkEtXo9BFl87le6N5O5qDzEX2s1rl/23TFRvmoHscZ/wCK7VTqlOIqXHb588PmyjSjtFFCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196132; c=relaxed/simple;
	bh=dCSKp6S7TqGAaoFAyXZ/KmSzLuHl1Ms0KkMOq+yQ+1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtpZoAgbDILKAwxnRwkvMH2nNQs04yA/9qVQjKSe8lZDcF063lzqRzQ79w2BLFpUoVAZK70Fx5YxFsIE7LIYvi3r7BAd0YmKIG89J52AMBp28NDRlBW1rw+OSqXhjT5JxXJ2DURI8CW9wgIpl2ubzCNSbfEr643Wj5TK7cDIQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFJon8we; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e41e17645dso68659226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196130; x=1741800930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YU5arGVoyN98aQkzfZ8DYAD7OwxEWSSdhhvoB0BPEQ=;
        b=lFJon8weH+5ymZ1Xbz/FXc4Mx1B4mL0NXKiJxQgHniAzk50gYGq6MRoInNNSdrb95O
         R0EBf0cx+7WnadbR2WSSNGtAqi7z3Uw3dP2IyXW17Y2geKLgnVWrmir0t4PafIl3fUHe
         5URdU94186LD1M5M3obiUwC4E4On2rLLoBuNceEeItChJ2lzxKQ3AXXWXxrd5MKCOjYK
         tR3FlvnaAHXXUUaa0rgOmFkbhEd7+js7cbI75itpsNlkmd1YBsKLud7IHDfH7JUNqiAo
         lAQ8lCLw6FmighkvFlWulVRKrOeGOAZ6TYVBkVZm5FrGOtPKIPQrXoDJ3ex2ir3uZt5q
         tX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196130; x=1741800930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YU5arGVoyN98aQkzfZ8DYAD7OwxEWSSdhhvoB0BPEQ=;
        b=fsMBUwPjIXJD+zAoNLx76hg9DlXa9oq3E5Y2Qc93fkEOuRTRQA2+bGvjB5FM517Bj2
         GVFt7apm4o+o0mZ6cSWurcFNasrfpVPFKVLgIgXOPX2fPy+/dUpL3j8IiRlKq8biqB4b
         Ud1Ch9yWU/dmHi5eZBy5+K4lDhqPH3lJjWKs2VIO5mtvPL3JGeW+1PiAv8AAD0Gx+YbY
         OW/YjVZesd0/z2ulfcLnUQCG05RpceaQX+wT1HRnXI2RN3LsAQTHX5+RqrBX3ew0f2Ur
         BYWRbOLNV8U3TghcDlO1At1EQzg4lStRHi6mCMrUigUGMNf55kMsFasIz1Zs0HhFHhD3
         xtww==
X-Forwarded-Encrypted: i=1; AJvYcCUw7phn9N7CK6s91PjaTSaQAP9hTEQzeFgnyo+r3sxKzmvEb8LW2bR32Qi/dRPn07L9OvYWj14c8O/Deto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Qnktp3FpvXavYmfbQAErCcLeUqsB9ZF7ct1cfNRsduycpMQl
	MbK4ugJB0sFLRWYShRzAq8/Pnw9TJHlafiFlrL1L9gkgQR+FPh0heAeLj9tCuATA4dc4I0DeBOk
	SHNu6Nu8nGnQR7LLZxK2u16ZBANk=
X-Gm-Gg: ASbGncvmxKrnc6O1V03FypXzUy1z1iGmUix7MSByPBXTHwG0GREsrduHtgyPlWiv08d
	a1saYl1jm30Z8qJP+O1RsH2u3P2ORSlp03Udwru6FETHkVMQl62B1q/BW29FXTAUWYfh1q6mdWw
	Tl7V2EcZFksOM63p8uBpz1DU6Tge5Ffc3NeYlklcdEQm061Gpsz4INI3fGHw==
X-Google-Smtp-Source: AGHT+IGoyou1UM/EKvVtwG182FyP3LABmO+os1y10h5Qy06r4wnpS4vsxyQGfMRg16b84vLVME+ZCaLKofqMxgYTaUo=
X-Received: by 2002:a05:6214:d0c:b0:6e6:5bda:a47b with SMTP id
 6a1803df08f44-6e8e6d13e78mr59009566d6.9.1741196128398; Wed, 05 Mar 2025
 09:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev> <20250305061134.4105762-3-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-3-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Mar 2025 09:35:16 -0800
X-Gm-Features: AQ5f1JpJccBQEJKHl-pNq80vDOB2AlzXXuelleyPiCpry_Pqmg7lz0mFztWrqeM
Message-ID: <CAKEwX=OSKa34Kg2ukzCMpUWiRGgonTHn3pON4LdfJvtexNgu=A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/5] mm: zswap: Use object read/write APIs
 instead of object mapping APIs
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:11=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> Use the new object read/write APIs instead of mapping APIs.
>
> On compress side, zpool_obj_write() is more concise and provides exactly
> what zswap needs to write the compressed object to the zpool, instead of
> map->copy->unmap.
>
> On the decompress side, zpool_obj_read_begin() is sleepable, which
> allows avoiding the memcpy() for zsmalloc and slightly simplifying the
> code by:
> - Avoiding checking if the zpool driver is sleepable, reducing special
>   cases and shrinking the huge comment.
> - Having a single zpool_obj_read_end() call rather than multiple
>   conditional zpool_unmap_handle() calls.
>
> The !virt_addr_valid() case can be removed in the future if the crypto
> API supports kmap addresses or by using kmap_to_page(), completely
> eliminating the memcpy() path in zswap_decompress(). This a step toward
> that. In that spirit, opportunistically make the comment more specific
> about the kmap case instead of generic non-linear addresses. This is the
> only case that needs to be handled in practice, and the generic comment
> makes it seem like a bigger problem that it actually is.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>

