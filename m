Return-Path: <linux-kernel+bounces-346374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90898C409
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB15E1F21A44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873831CB520;
	Tue,  1 Oct 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+mzSEP7"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E491C8FC1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801879; cv=none; b=oZbAgUtankuj0zVtEX34G5o2769rZ/34OiDDsW3l9bN2Kb10fM/oxsO3Lv665pKGZRZdYtxA1U2ws1O7LxFw8+F6vCqMJuuA631gRhNTjGbH4bJUZ9HFR3Ac8RsTwThyg9NPoPv2mbZg1LZOZn2BON9saR0HGNEfNAISru7lm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801879; c=relaxed/simple;
	bh=w1Uu27Hac6IoIox8EvHV1hPgH2K0mL14yTN2LdNgkYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO+QLLK9jBXKVfGqp3g9JT85FTayRgt74JLNH/VkCEn+2HMYq0x7bATdhxZq/PIMWIm/Kc14vZDDC8fQLfL6c1E6/RUTrG3LoMT71fbqIgxg8TmtXjSLQuAUnA3kwoHHh5WWNXbgwwlyUBAcGyfrf/zj59XPy9/GxCWH5rBDCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+mzSEP7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb3d2ce75eso129726d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801876; x=1728406676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45yUF+50GT22EogIC3/iwraZsREEDBmHPCJtFCR8mXQ=;
        b=j+mzSEP7iDeqo7uE8KBktMK6M3QuaqpJ8UlP1Ypk02x1MFlloN723owwGerAw+BcS1
         u2HDzsM54d4UjMOoeEIPQ6CQApZ+aNW1ZWkI1wNa0E+QMAg9nkLTApTlcSUrMhMRu0j5
         bN+9vvm47/iqjmCL/azAOsIplQpx6ud9hmtYc/j/NpSsIrxFOvlyA16mHXq4hRNwVzNU
         gBTo3nrbdbzx8e8KddJESK4guJAcxJB47xYmvfl1oF/HyhBhgpN+wK6FANbgfsktPn5c
         wh313sr/SiBR9SRZJoWQnd6oRv0SA6+l0zkDWcUXRR+Hhg3G39kOCnZ9cKjCB9nkzmEF
         u9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801876; x=1728406676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45yUF+50GT22EogIC3/iwraZsREEDBmHPCJtFCR8mXQ=;
        b=mfZqgALz/wAb2Wnbg9rCZ3TVoWkbZFudHB4GUpmwnE1qzFgwwTXh7rfF/mw0lFlWb7
         7PwNtV6aDI5Xqfq/cxck4BcwZqyiumX+Oog6VsTtHU51LERM2s0bbimAWFRKaO5mSMfz
         JNLdCdFkkOGFbbQK9kdUNKjlU7NPhZXWrJsTJnbdVeuJhBZRj9bV0RawPrQdiIyL2CGY
         TJidYVgOKirEyxFGKQSxlWbvgnZ9NozivtLfqfCNP1Fzn8wiaOjnF9VwZZm9lCbkjR0B
         rgD0gliw1UjZmZwtxGgzFd2/OmlpztODOqyuOVw7t7gaF53Qed2dtm9QZWVPolcMOzZI
         qNbQ==
X-Gm-Message-State: AOJu0YxXoD9Y4k/qrCf6bYTnKpwijIYnSDGVtmItaj/tAF5YJIHqxYHi
	NdZGZ8rSeISm/3lNOkmXij+P6aqXzSAWPxyXAZe3J3TLH5zj9n0PsUFMUZcc0UWmVNxvggj7Jrt
	PIT/REMaUeNr8adKAVGn24crspZ0=
X-Google-Smtp-Source: AGHT+IFzyHnVYSdoUF3wjsiyUK4NHNf84vM7NGP6HBryVwfge5Tnlci4e2ymj47N1NhyxTHjAKZbwO8GtEaUvRTDoys=
X-Received: by 2002:a05:6214:4697:b0:6cb:584f:ec22 with SMTP id
 6a1803df08f44-6cb816de99emr3853506d6.21.1727801876442; Tue, 01 Oct 2024
 09:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com> <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 1 Oct 2024 09:57:45 -0700
Message-ID: <CAKEwX=MKzX6qE42nQVVrr+Y=ZtHLjJ9w5mQ+k+oiFhfjcacWVA@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:37=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> zswap_store() will store large folios by compressing them page by page.
>
> This patch provides a sequential implementation of storing a large folio
> in zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>
> zswap_store() calls the newly added zswap_store_page() function for each
> page in the folio. zswap_store_page() handles compressing and storing eac=
h
> page.
>
> We check the global and per-cgroup limits once at the beginning of
> zswap_store(), and only check that the limit is not reached yet. This is
> racy and inaccurate, but it should be sufficient for now. We also obtain
> initial references to the relevant objcg and pool to guarantee that
> subsequent references can be acquired by zswap_store_page(). A new functi=
on
> zswap_pool_get() is added to facilitate this.
>
> If these one-time checks pass, we compress the pages of the folio, while
> maintaining a running count of compressed bytes for all the folio's pages=
.
> If all pages are successfully compressed and stored, we do the cgroup
> zswap charging with the total compressed bytes, and batch update the
> zswap_stored_pages atomic/zswpout event stats with folio_nr_pages() once,
> before returning from zswap_store().
>
> If an error is encountered during the store of any page in the folio,
> all pages in that folio currently stored in zswap will be invalidated.
> Thus, a folio is either entirely stored in zswap, or entirely not stored
> in zswap.
>
> The most important value provided by this patch is it enables swapping ou=
t
> large folios to zswap without splitting them. Furthermore, it batches som=
e
> operations while doing so (cgroup charging, stats updates).
>
> This patch also forms the basis for building compress batching of pages i=
n
> a large folio in zswap_store() by compressing up to say, 8 pages of the
> folio in parallel in hardware using the Intel In-Memory Analytics
> Accelerator (Intel IAA).
>
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
>
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.robe=
rts@arm.com/T/#u
>
> Co-developed-by: Ryan Roberts
> Signed-off-by:
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

