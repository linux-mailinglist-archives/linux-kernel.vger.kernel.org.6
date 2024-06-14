Return-Path: <linux-kernel+bounces-215409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A892909262
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A75B222D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A51A0AF2;
	Fri, 14 Jun 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0EaGZPXw"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017381A01D0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390212; cv=none; b=QIGH68c7o8e1NeVrtFacwqePeA17N5DcAeXfQo82CvMDocnAAaDM2zBFvRDtHCYMaco0EEGsA8mjCPIsTP3z+KJlwp05DcxF6TwhfsGCgeWLAqwFvnT1KtsZZC+cY5JWnqDUhZSka2p+sSAuGM16V5O/y/OqHl5bgTH3NOpib8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390212; c=relaxed/simple;
	bh=0DLFLtMijtzgRZaPRYcbk5r1aMcTS975pg2NsCcO1mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDjdq/CM9TLwdXkQJDBOyyl/XfBwrJobbFhfH0dUwna+03RxH0A9KXE4m6lD6/nj/YLXv0KKaWFH3MtrwaKEwJf+s8Vz7TVEtdeLJ4kunVQjejDSWzH6Nez4gmL5U3E6pVBzd4NE36Aqn32vJRl40FLhWHrlTj9DC/50L7ImBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0EaGZPXw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso345474466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718390209; x=1718995009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DLFLtMijtzgRZaPRYcbk5r1aMcTS975pg2NsCcO1mM=;
        b=0EaGZPXw0jKzuHimxWx5/Z/w7Wqjh+qmIH2ynXbVhRlDkEYwD1600axJSUdbX4Q/hl
         gIyrknV4E86gLpApV1xRZsRwmFWeKHHzVce8GzUybFwwaKsdjCqfwcgoERUkGXxm7ZXX
         PaHHWm/1x2ZGwHagfYqvj84CXtGXDb44F+jLwUcpFkh7OByIpecABnahJsRBzCZJGMEv
         yuj1pqzcsQgf0R4dpJ4eN2NSmB23EAsGj/IZXmcC5fGJfcaMJ9sYWof8VtD20HNZ9LvL
         /gcIb0GX2lqnRanmKvTVKrGJBE/ZXkRPd6f/17PBkftPY1MtkWrGlBXFiu8E/EfJ1SAJ
         ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718390209; x=1718995009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DLFLtMijtzgRZaPRYcbk5r1aMcTS975pg2NsCcO1mM=;
        b=qKkWgoeqHXfjR73CTbzl4USj9ELDAUhP+CKW56lkyu3GiPa8Bdzp/T8WcIVE9Qv1Fy
         FY/dMuShnuTcu7Zr7YNs8A1MWE6jz9dr2gwGcb4WaPlgPEzg014e4vG40DL57judr8qs
         FIxrc+sBK5dtH0hIC4N5JpUCbe088Lvft29RsZmReht0N9nFpv2iEz0QUUTqIuq7xSmo
         HBcm8f9lmXqlpnkF7yyv5FBwVSI9DTctP0Pt9oE4zVn5COJeqvxk9jOCLv09bds+ClO3
         xprucbL/+T1ag+NfS6tuTqmJtcalpUKL+O7KoV+4q0jxBxhYH2ZEISOwf6CWiIfOOdLb
         oWqA==
X-Forwarded-Encrypted: i=1; AJvYcCUcsQagwX7kX19FSie78nwc57RG2krHkqFBaLfFTACyrvhliUtYPAqxoBoICdLvsFWZDI68i0J3JvQBqb7SgBk4eRldCUWi76Wx1y+v
X-Gm-Message-State: AOJu0Yz1b3zmccy5lT8hqgjAlzGLcUCOSp76SljzFRN0J/XJRSUMZPp3
	gViCwN1jKRfaaXhN/cP7Tg70E34Y4/kY9APCzNapN9PneClcRabx/XoBqy69lcUngMpXvQoxQKC
	NOHlIKpTb0j9lghzbhzf8IhP225v6bL1ayObm
X-Google-Smtp-Source: AGHT+IETZ3/A8rNMpBHZSN5/gQjb1KLyPWz5MWsjxPtei0fSV1e1qKRmzovDJ8P1h2ChNiAPWQS7lhB3DJs2cOJXHCE=
X-Received: by 2002:a17:907:9495:b0:a6f:51d0:d226 with SMTP id
 a640c23a62f3a-a6f60de277cmr318290366b.66.1718390208962; Fri, 14 Jun 2024
 11:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100902.3469724-1-usamaarif642@gmail.com> <20240614100902.3469724-2-usamaarif642@gmail.com>
In-Reply-To: <20240614100902.3469724-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 14 Jun 2024 11:36:10 -0700
Message-ID: <CAJD7tkatLV61SaZzHOw7r9+XjYsOhGn4yw78QOW-6foFiap8_g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
>
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03=
d1344dde9fce0@epcms5p1/
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

