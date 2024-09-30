Return-Path: <linux-kernel+bounces-344955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78D98B097
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BF0B22509
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D988188CA9;
	Mon, 30 Sep 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtrccJ8g"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B318754F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737206; cv=none; b=IVCbTPiwbXsfVEOr4WGwLkyBcG8WWAQLJ1BMIM3A+V5lKX04+U+trDZ7uVXg9Y9GremPZkYcqe0iwr+PNRhYmiHTkld6R3/txLjuUZI+f1nVruY+keVwBmayhYrZqAAOgMlHCCzMPcTos5qQu+mMFxDagS2YISWnLRWB+ei2XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737206; c=relaxed/simple;
	bh=dWCw161eoqkVuV7viOnfQRwVUca6IZkChfEd1pCOSUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9yRA563YqWg7C4xsUMowjlFID/G/F6+q7+KWAg1qFVPrylFtQ+RkP50NCA8d+I8x1w7sPyHyXjAHYnqxqXGN4xV1NSZhnvVNSnLUaQ0i1cXfYuNKGNwFeDhXnF3yshzoRPu4F/dTa60rZEueB+O5Oi6unNSyPXp4zcr3cD3Wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtrccJ8g; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso44790756d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727737203; x=1728342003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWCw161eoqkVuV7viOnfQRwVUca6IZkChfEd1pCOSUw=;
        b=EtrccJ8gv6fd1zXU60c1dsvMy2aL1NYleDqgwzSzYI/6c8OgsFECwhJzAVaDrqcNcb
         kvtTEyGF4n3PqR8ceNmLZBGZjfULjE7Zq/x878g1lR1FvnNze6UAzeSLNIrwj2OpHrPF
         ttHHZEjO8OEj9Ne1HCetDGdUPmSDqcUrQudjbMNUw2Pj8XQa3Uw5LD/Pa1M+DOwBomme
         A8H/fEvxpdA0xSqqAYI0aIVxkuLilY7cPAQjOULtSXcBAZFXYw7gkNZFJEthI0Huo5tg
         3CeY+AgjxMtUd32GWqetmrW5IUdT7/40J55Sqewp+KqbVmoQiPYHhilk1LCIpTsl4BPM
         cx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727737203; x=1728342003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWCw161eoqkVuV7viOnfQRwVUca6IZkChfEd1pCOSUw=;
        b=a3kWcjN7XqhWEsGwYUD0l+bZyZBhOi4XLesZ9gA4/J2SBZEmjOcPyq6t9Q2CoHJiiN
         2lYIBZuufSJHPXbfJq8F01Le1C4vbJLMLX8jiZ/3b8kMn5PaOwKKM+dqylQ7OA2jyJqv
         3hHNh+qGYIZNrn0XlDeIpXKRH19MOGQI/d7MVWbwczxrbfQOUlQJ4bdMCIAJiuQPj078
         Hy2+o/9fIrlDj2slq2XyXGICDQtto/LUtChIAtvWJ85ckQUUqq8CVQpTSH9FWJPT4WHT
         8B7+1G1uEFN16kK2fZGZ2tY+2ZJpbSCLZ2dVwAb2pqhEkc6Ch3ZWcJLtX1s3hTKnf1dd
         3d2w==
X-Gm-Message-State: AOJu0Yy4f79TWrn+eFoAfjfCwF2kvI+kk1DQjxB/yFwPoQ244aCrGQQk
	DzPO3gWU+XBbeUI/P3cVZXrYveP90+KCr83EfC/p9e78k/44EaQA1sti9mBz4vY1/Bpyj1YiVB5
	vI5rz7SlATIvpyLJnRFElNV4UvUo=
X-Google-Smtp-Source: AGHT+IFZ9twSP35b/wVX61vJ7nPQkTmPmsJWc6ptIYcbPtWl0SJecJMaYU5WnYGVEbOPOcoSRij5rrrpKgXHlufrqZk=
X-Received: by 2002:a05:6214:3b8a:b0:6cb:4e9f:13b1 with SMTP id
 6a1803df08f44-6cb4e9f153emr147643306d6.19.1727737203001; Mon, 30 Sep 2024
 16:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com> <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 30 Sep 2024 15:59:51 -0700
Message-ID: <CAKEwX=NUHrPob9oxTyJO6a-gL8rn4KHZ30KkeNnH=752KPJbgg@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] mm: Change count_objcg_event() to
 count_objcg_events() for batch event updates.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:12=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> With the introduction of zswap_store() swapping out large folios,
> we need to efficiently update the objcg's memcg events once per
> successfully stored folio. For instance, the 'ZSWPOUT' event needs
> to be incremented by folio_nr_pages().
>
> To facilitate this, the existing count_objcg_event() API is modified
> to be count_objcg_events() that additionally accepts a count parameter.
> The only existing calls to count_objcg_event() are in zswap.c - these
> have been modified to call count_objcg_events() with a count of 1.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

LGTM!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

