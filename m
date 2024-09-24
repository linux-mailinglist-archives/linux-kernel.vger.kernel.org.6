Return-Path: <linux-kernel+bounces-337423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E989849F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302EC1F22593
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3521ABEB1;
	Tue, 24 Sep 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVOI/Eb2"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209D1DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196354; cv=none; b=ND0ozeFEXwssOnc712xTdKsMeb/M82rK+FxwOsdd6hpgVyq+L6RYdDd6f/ipTSvgS0VzmupW+LoMzzpeN/A6YEaSziUEld+Um3NzcQfUqBK7Su2iBI7mJshsOaxDGxSmLeorcObgHTnj7b6vymRLuglA0Rf7Ltw/fP0RyH2jr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196354; c=relaxed/simple;
	bh=+SzV7fFq7O7PDf0VqdSERZDfwYvvBdko7lAtcX60RHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1xDlVKfjPnVTaEhWXs3GvKq9YL7Yp9ZvPikVnTesPvTCAldbF4urLvfqqAQwW56OwolAeuV4kKVlL+vUF7QCrENkNZUWo1AXCs8GCH+SN2ue8V+QA63hMEequRxRu9F7q0FpCfSbL3hACnb9Lp9jXymgCcp8CCoSt743SPtfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVOI/Eb2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso39282726d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727196351; x=1727801151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SzV7fFq7O7PDf0VqdSERZDfwYvvBdko7lAtcX60RHs=;
        b=PVOI/Eb2fLKIFQFw71cGmqp0DgTop2s7k7MUuU9O/XRx6ZE0sYqPxstIgAxlQmTC77
         kvqnI4wIdVa0dN7Du4PVZBrMF79ETcWXJlRnZ/G9lpKMl8lTpecmbrwBpr+IG1EOIWM5
         G0w3oUQN+ypvh599ZJoz5DnF+3PC2Jt4TCdqSPauvjQwpYsPlAuNd+XN6aEkPF+Nu67c
         YUN4DPihEjCJ4YMzMe1EFvP20Z+Vm+gd6PBLJE2sPSJn/dZqVdmpYOgmOGPnv7liLBNQ
         9BQCXAux5ye3h13chi1tHGuG7RUtFUADyGQEim42mnvUH+j/kpUMJ9viKP2b71IuE0Dq
         nuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196351; x=1727801151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SzV7fFq7O7PDf0VqdSERZDfwYvvBdko7lAtcX60RHs=;
        b=ZWGxjkeNu96kjUfRcgYTZ67po2MhFyfdssQZLkbYcYwIAVlUA1ELOQ/zdFWwe3rnVU
         l3mQLpZ97Qm9Z0L7INyFHgC0TnXZD7UlhiQUhnB2mlEoCgY7wRcQjoGaOIU9hd0+TS1x
         qW89X9gXF92HZH0wbRdK70PuOhcFK7Ii1od0PWLdCmpuvcFcvUg26ctXMull8LRRutRd
         T0auU04W1zazxpgFXiXtVBe4Fab19su8bOrV++2Wb5fALWqr/8vNV1HLt2y6kJdRr/eO
         hexpxOrcjc9/TikAHfMzPT68vhP7hWk/G6kdFSiVI1CXkpoGyL4xlqsFEdLK5Ryw/D0Y
         NRUQ==
X-Gm-Message-State: AOJu0YyPEVdBL80THs2jwCcU8iFK/1C7qHBLf0IymQCeDv5cFRS+16IO
	sBZeUjgwpEUR0RjH5AMkc/IsiwGdcY5gTDj7zxKdk5lPjqaJ4si3rbeVeArGMKBqABeSk17t+uk
	CvQLfmOBr3BL7wkmgq2M4rkCIcQ0=
X-Google-Smtp-Source: AGHT+IFpvovKHW/6gr2HZxe+Tzx29jAKRIxAmoJ9xLg2JGW+0UXJqoy7RHqw7ZzLGg0PrHy0WcStMMY30tbz5G3auSY=
X-Received: by 2002:a05:6214:2f8f:b0:6c7:c650:962b with SMTP id
 6a1803df08f44-6c7c650966dmr205276556d6.51.1727196351322; Tue, 24 Sep 2024
 09:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-2-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-2-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 09:45:40 -0700
Message-ID: <CAKEwX=Ou7k2ySbycrXrst4bK7Dj+2F1PMMCP3Y5QUmFu7BjHFA@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This resolves an issue with obj_cgroup_get() not being defined if
> CONFIG_MEMCG is not defined.
>
> Before this patch, we would see build errors if obj_cgroup_get() is
> called from code that is agnostic of CONFIG_MEMCG.
>
> The zswap_store() changes for mTHP in subsequent commits will require
> the use of obj_cgroup_get() in zswap code that falls into this category.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---

LGTM.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

