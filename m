Return-Path: <linux-kernel+bounces-192637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C0B8D2006
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9C91C231C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3C17166F;
	Tue, 28 May 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv2GZYRR"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99F17166A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909230; cv=none; b=nPcQxP9Yg1lKs1odxGBOtRFZEVscMDake0fMyrQzIMf5AwZn74lJyTVFXkDPrjM8gcNnFf1+aNTkmbdiLdXHE/kRJ+CWy/a8ZiC1BmGWYoAtxq9e3r5eqEBisrW+PK7jODbP1mWGjm58jyzWhxvrgYYIUtPYpaA2o+T/zbw/4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909230; c=relaxed/simple;
	bh=e6N91zsLIkCffcVoj9IwNk6WCrnFz/oKvE1DmIr4i3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auOJZeWae8K9CGj3XgS12B0Od74PzpK4g5izrLL303p7E7yiDR5NeWzcLtTyth35pS3sSJetVHyUATrq3uwPEPaj4HTIFw8QCBcruFbgVT57KeG4oS5snklfsDWgu0lWZeltqsfghekQdisZqa82ByyRaWwyKlPr/4R4QC4VloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv2GZYRR; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8d0a1e500so705686a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909228; x=1717514028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6N91zsLIkCffcVoj9IwNk6WCrnFz/oKvE1DmIr4i3I=;
        b=Wv2GZYRRi9qg/7ni5w4z9e4BU+wPffxlUjsMuZT+duzXNxo8/l2JB3fo04d4Tep/YM
         lGFAG3ucBdHKIcTG4EHGj1xAy2lP5npFI5f12iaQasHGmyINBtbqi/p6gCby37go6dzQ
         5lBiDySQQiNKXLHKUqgFeaL85oNzUM7sKaEOKdhmxsMY0cdMZG2CDjf8T2qNttrTzBMD
         w24GvUCrXeDo1VCpnaZh5FkydQKjNf9oujqHUF3IdrcnyOIa/HFJd28la41Me05aaT/l
         qkv04qh5PKTVHSobFlzGCGYbq5jh/2ppsMsOwrJ/qmge4/56kKX3yrJnnewZuVYW9f4v
         NCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909228; x=1717514028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6N91zsLIkCffcVoj9IwNk6WCrnFz/oKvE1DmIr4i3I=;
        b=D/hjhxpFSamcL5vXwj5xeTqU9ykvfWUCeSKEFH0/Pun8DBFQIeIVoIkRv1V7hZLXRT
         /ZSZHrf7lTC2nFwezAZgBcUniRMHV/8ftCo6yu1Sv63Vc/zpb0arfcW4UpF7Hhpye0X/
         Yp3U1G5m0ti32HaW18UaXle18W227g7H2T9hS1s9OLkUEBmkxtkJEanWm5LAf2yiwrij
         uni/ZMv86qh9df5kOGAki5jp1PuDuDPWGZ9qGoXgmu2NftZgEeCjFPyQ7Oq17AQsYJwe
         8oVPY/T7XRH8YYvTUVmUd+Dv6x7vaZZZXcnl++g8S3aVh3+iK3HYgAenenQ2Ru/nfUwx
         31WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpzy0Lrvvobqh9DEpkbKpanOiJrk76QxKi4cn6406xTNxao+ilszo1S7ImGw4b4UrjlqbtaQ4bydeyfX0DrBJlGf4s0FWGeCblldzd
X-Gm-Message-State: AOJu0YzOyyqwsQNa9+9QZvGKDZViwTD+TilCKwtdu9rKSzDBsZyVcvw5
	jtadP7CZAlQqWS8YtSMqY23uuJQmwETb1WsrMzYI64yYM2W45y4I9Rq+W9Q5sg/Z5zurXsBwgH6
	5aZA+p7jWcqQK0AwbIouBSCRbj41nIw==
X-Google-Smtp-Source: AGHT+IGz3r4U+on+uB/aGr+GRepszIiD2ZLz8sbZ0xk1P0EJC+xvzvqhCXeqaCQ9OjPYEXDavg3veacofQZQEKFMVeY=
X-Received: by 2002:a05:6870:171e:b0:24c:a547:7b5a with SMTP id
 586e51a60fabf-24ca5478ebbmr14054365fac.14.1716909228407; Tue, 28 May 2024
 08:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com> <20240524033819.1953587-2-yosryahmed@google.com>
In-Reply-To: <20240524033819.1953587-2-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 08:13:36 -0700
Message-ID: <CAKEwX=PG183P_BxRHD7gHV=MrmOhuyn+=FTDpOcu_GSBQg-ZAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: zswap: use sg_set_folio() in zswap_{compress/decompress}()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> sg_set_folio() is equivalent to sg_set_page() for order-0 folios, which
> are the only ones supported by zswap. Now zswap_decompress() can take in
> a folio directly.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

