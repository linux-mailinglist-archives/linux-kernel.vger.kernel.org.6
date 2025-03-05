Return-Path: <linux-kernel+bounces-547329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DFA505EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5C1653F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C471A841A;
	Wed,  5 Mar 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os87h56v"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BB19C542
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194314; cv=none; b=UlcKBX2eMfmsQb3zH4JpopZQCT+cpGemK402+q/HjzhEHzM37gPjih0/FejiIt7zOcmGDPdWCYFc1By/OjyIe3Uwvy0uP/Wfz+GW7uaFhdsmBnqwYDXrelsj4+HrVq4G5WvPaGYxQmJmcrx9CME3ky0mmFrRRdiAmA5wIJY5naU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194314; c=relaxed/simple;
	bh=B/jQh5Knfwdn05WGTf329PGip2QghcVSlAu1iFJK+II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfiXA+IOvRsq7CM5+IqrgBt1QwekBoJ4xVCJr/SmTTZjo72Khkyid3DuLQzCtU0Vyjra8hASXm7/LtPbZVYmHZyP99CqM/WFC+CP1E/OP5FLEWdrixwjANUBHnCJx6lLZnb0mtUoj8Xqy0BJBOOPFssSpmJBWonG5LlvIC7n3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os87h56v; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8c3a0d468so27522436d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741194312; x=1741799112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/jQh5Knfwdn05WGTf329PGip2QghcVSlAu1iFJK+II=;
        b=Os87h56vnIXkgQEE9Ji0vDAJ2ctNP8G0xvuvJ4wc/ejxx8tDLU9K/qZwnWOUS2F3d8
         4CSuBVJUSq6a4LJ88VjWo5ob7/wWjpn9aEPeT2R/kDZ+W/HpXMijLGtdo6xmZSyHJt3v
         TuqI/0cYCfkVjNshPtWC1G72OdABWyqbX85YcBOUsq1idjFgjWl4tB/HFIaLnDLqavId
         YKXpFBFfqLzXSg4mjrft7irkMUvscKT51K4QUyIVANqKWb90SulkdTbIlEbwpqQCRLiO
         DmbOX7DOAuI6D+2N+zTY4a4EvtdJSbjaM33VmJUSaeP0lC9vyR1KyScQL0nMGLgQaXK2
         6ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194312; x=1741799112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/jQh5Knfwdn05WGTf329PGip2QghcVSlAu1iFJK+II=;
        b=cVPDeY3Qj1YjV1jU0LNEL7xIMSU3MqKNLSJl6YcXm1lCESi+a3IG5bElVioEErADkl
         yK74/G3uzEuRKpGCvdtCNIQG4MOzd+I4A0UGyhEW2GY8FAMFIhvN9xeO/Bydo2gKo/m+
         SSWyFtzJQyYJLrBMNDVoa6U7IwIZDIf1OZ40V8/11CtPq/CbM0Umj5/QI4nEdN/YxbYD
         y7McEC7cUgkjvwkFQ+fPc2tHUO/VqkEbeCsge14YVGggcr7A/tK2RftVsRAYBHEW89I7
         dQ3p7O8K/TEQVMbCsDGewRQTQKqqaKD6zBFiO1K9Rh92JMC5hSkn3rB0v6Hq9uMG/CC1
         Pc8A==
X-Forwarded-Encrypted: i=1; AJvYcCWGIlRXFH7xn/Ijo9ZAwjWT6WMI57BeYTIFcla3jDm8u70cF3HCp8wPviR/h9RPskQOMtmzFMhnmasD1rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbDNDe3kUOcu5Qwzw6KNWkXEs033ko50cfYzbshyh3ptCFD+P
	XqFaI4FFCoGWhOIX0/FneXnWNyaGs204dLOIAmWIoWvAyyMl2d67g5yXsz9bBUq2wS9jB2fEvvy
	uT+ydQtyrz4ixRfxOf42GbhvFspY=
X-Gm-Gg: ASbGncsaigdjIlHZQOZNcpoJDTIBTZQYenDRXEnnYlX766v/kMpxY0xaajR9zMcif5s
	Gk9yuG7+obOC4vdfFA4ZJkfI9CkCL2/fI9xYfm2+S8Cd1p/lnPV/jMK8IeT2vIxgPB46J1/5wMd
	UHrEnhiDBV5yCMhwrBc+3jDTw+MoFkcPWSe/bkL9D/JWPk3P6+jynJ0HeCFQ==
X-Google-Smtp-Source: AGHT+IFdjHDgSy5lKt1hKZCKPHDhr88g1xHOk2mlfN7Z6seMV4BqQBaj639LP1URBewpq7u6q13yUaphQ1vFz47SpCI=
X-Received: by 2002:a05:6214:c45:b0:6e4:4011:9dff with SMTP id
 6a1803df08f44-6e8e6cbfc92mr48267966d6.1.1741194311624; Wed, 05 Mar 2025
 09:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev> <20250305061134.4105762-6-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-6-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Mar 2025 09:05:00 -0800
X-Gm-Features: AQ5f1JpLh86gyMowFNdcmuvC3GQ6XiUrcVobrLa4ZOQWYrpH3v9KLiMm9rVU_p8
Message-ID: <CAKEwX=NM=A7uXmZAtfw-MDOmL3BhQx1C=OywPADpJWr6FrE+jw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 5/5] mm: zpool: Remove zpool_malloc_support_movable()
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:12=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> zpool_malloc_support_movable() always returns true for zsmalloc, the
> only remaining zpool driver. Remove it and set the gfp flags in
> zswap_compress() accordingly. Opportunistically use GFP_NOWAIT instead
> of __GFP_NOWARN | __GFP_KSWAPD_RECLAIM for conciseness as they are
> equivalent.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>

