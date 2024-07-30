Return-Path: <linux-kernel+bounces-268260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205994224D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B09C281B65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD618DF93;
	Tue, 30 Jul 2024 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLG1KEHR"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE3145FEF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375656; cv=none; b=c5rNcjaUDwftP6R1gH9/n4CoydwwzauW/MMJjy20vllY5m6uPVaBfT3bw0S5JhNrSo7Hg4tnCtJlMkNaVQtV05YHh5iZGW2FRrY0WNdU1Fz/z+x0tjW4XgtUoGWs6fRp+wCXTUjqj0DxQ6G8USi9WBaeVkTgWkUgII44wYnyqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375656; c=relaxed/simple;
	bh=RRsf9iVUiXBaCCfvaf+R01v1qnjGXdSF3m5w+LMjSCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uhdmeqhr2FC5It64poQl9BJj6/z26pqFdlvDkmakWU/0/7Hu2Ap6QXe176Fc0YBq5qIXolF0FEVFffd+MRbixiibkj9qZz6u/dagQSDKnW9/jszaTmE7zsa2xs91jkxHiyqdwlk5HfS7ESmvuL/WWw59+LOap8X5JOQmvouczs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLG1KEHR; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5c8c1006eso2877877eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722375654; x=1722980454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRsf9iVUiXBaCCfvaf+R01v1qnjGXdSF3m5w+LMjSCs=;
        b=eLG1KEHRHSXa5amHftTGFPxZhDmC7q7HKpdBdAn5KuTK+CzQ2kLYypXgQMU+lcjPps
         sjGzqcx8ThiTWXwNoxT/A5mZHyXlmA4wopB8h2DGum4Pu3p3U5UbzayvsS5ww3YC1h0l
         d5v79MVgeWpv4ypOOoyhvOTjy9mTUVbjyIN6aVx0u6lgCpmjat1nmNiHVyOTYZCSNx4u
         6H0knEn2tZkWQdEPhCaqh9IJF1H9oQIbIKMoTd/QJWc0WxkJO8YlZBkgpP1J/oRBrYxZ
         ReDe28eJ0d5CCzb5M0n7+pvWjGqfO5V3MoIatHZZE8nQn9ZiyHPbOpfxHG/1magtfqCS
         sk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722375654; x=1722980454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRsf9iVUiXBaCCfvaf+R01v1qnjGXdSF3m5w+LMjSCs=;
        b=JCl2CiwK6awUxjdcRGYkoNUipdqJ4hiXYIF5D69Y5MVm6b8PWKGvhyZLB5ylFWgTul
         20f8z4TxgJ16r7g/D3xG7UfVivNNHYg61cQK4FRd9AbiX5A5/2hy4W7Xmemmc5giWbYF
         lHjOYAmoBCmplM92ODk1tI7S11lI+NDiMrPXK7E7OfQBQ5vB5Q7QHvK0+4x5HKeDUT2R
         5pBUgFvk5zC5NrEx79nXNZFcSdufr3sInbddtUy7TURrxnBjt0Ouvitq5IPaygFuI6Rh
         DfcyrQFojhf/Sm3hsCgHX7r4xnYHK86RltgP6mzbPLsAhl/p64rHH4c/Rfs1eiWuCfgP
         Y1bg==
X-Forwarded-Encrypted: i=1; AJvYcCULv0fMm6KzB6qU8WT7dVDUAOdl7rpTH+2OU+HuKfp05RBfQLhAiItFrxq2VkxkmmPgGzyd4gLA3FhIq5+9/wzEs5gsI7dD2C+fm8FJ
X-Gm-Message-State: AOJu0YwS92J6+JjNiMkadGQznl8F5gtrIfvLFk2opXMT+FdqyHTwj6n3
	2fwIGtWKjJ581W2CaRNhwuccZfPETzUomKN6oBaZvFq2zDWcC54b61fo2HLLxtBkiPH/cLoYvvR
	CSh8pPuSqeXh01f3V+wWOefFVVKI=
X-Google-Smtp-Source: AGHT+IEeYXo30v/uUKaZSV4Ao9ZFszwL1iUhnFTkv6dJ2veewp9UyjVuTTzOuMAQusYtnQNdVXBq+TRUse1qHD8ldq4=
X-Received: by 2002:a05:6358:a096:b0:1ab:e07d:c93c with SMTP id
 e5c5f4694b2df-1adb242e352mr1488786355d.4.1722375653955; Tue, 30 Jul 2024
 14:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
 <20240730033929.GB2866591@cmpxchg.org> <CAJD7tka1tPA=qGFJcf4n1MM20A4WoL0cA28jDcyoc0y+48+0bw@mail.gmail.com>
In-Reply-To: <CAJD7tka1tPA=qGFJcf4n1MM20A4WoL0cA28jDcyoc0y+48+0bw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jul 2024 14:40:42 -0700
Message-ID: <CAKEwX=Mzzs0kU4Fmw-hiyMT_6m37N6i=xWaEgZoCN+RAx6McSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, shakeelb@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:46=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
>
> I still think the nr_deferred handling in the shrinker framework does
> not seem compatible with zswap. Entries could be double counted, and
> previously counted entries could go away during swapins. Unless I am
> missing something, it seems like the scanning can be arbitrary, and
> not truly proportional to the reclaim priority and zswap LRUs size.

We can do some investigation by the side. I did find the trace point
that collects deferred numbers, maybe that can illustrate the problem?

It'd be an orthogonal issue though. I don't think fixing the
nr_deferred part would be enough to handle the various cases Johannes
pointed out.

