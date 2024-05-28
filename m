Return-Path: <linux-kernel+bounces-192647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47F8D2022
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157AA28574C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9A172BA9;
	Tue, 28 May 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MugFbCbO"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C74172BA4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909375; cv=none; b=fADj0sfexqFKzKAQU1NZ1PyHYbCArWLpMTlK3FWv9MA2ZkHwVyMM64kDdamYHRNJRjkC9riTKqIOY++mL95xx+2Dg4RTARc/To9s3E6o7TCjnz08zBN/Pb/j0Wcz+n8qsW9jQA637u4G9xyDuyF1w99V0nC6nD2RdYgjmHCjkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909375; c=relaxed/simple;
	bh=gZzvMlMlStk4tJYmgSNUIq9MUYm5QUeau2d+GQ9gHiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5jhOOohley+9WohQASjujvfGPiIlokTln/RutDLoThixsdLtt4FXvTG1q80cR4tvBUsTpXr6Mv/Q7PYrzyNg5sM7JIYKnEbPUUgR79kMzmGt7mslz6i379lIZhz8MKuoTfShiEf/H/7bIx5yWH1gRnkiJjZKCUi3bKeJMIMKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MugFbCbO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d1d11cb556so329901b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909373; x=1717514173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZzvMlMlStk4tJYmgSNUIq9MUYm5QUeau2d+GQ9gHiY=;
        b=MugFbCbOI/mGgbrwGbBEjAdAnlnOUo+HRqQOiLrmlGzeRFZ+RyaUiUNE0ElvxsUuga
         mO1oEtcPNZCFfCVGRXRGi0DaRTlZC/pcRk/IPCR8aZ8+29s5/tNiSvaRzsCyK7e8Ic50
         gR0H93UD5zoyd0svC+2HVbHbJa5FF+QeH6X/sh+u2QgI5/bRRQluQaAu6lBR5yTlL6Bt
         1Qr9228bzgOdpPzN9S/oxMq54SiCcKyMMY7l/6frjeRbckUl6ThRocITmqWi17/66RoN
         /NN/f40TZEqsYSUV1DSd2SXTn9cR2dUcyuzvvfd0aMP1O4dCwJ5rLCx7lmqr26JfykgY
         mJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909373; x=1717514173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZzvMlMlStk4tJYmgSNUIq9MUYm5QUeau2d+GQ9gHiY=;
        b=Ui6aA5Ee1tR0j02RjJS1dNy7ZFDSxCnLYVYINJEOyojZmn8bTuZCXOLOwtePXHj24n
         WjqbFlyhWFa8EY5E+tprtkpzuSai8EmNfm32nFClqZmH3xG6cBgDrxqptCGFKRgPJ5av
         37wITeDkzrhhNzV5hEwcVA8AEDuti5GPCkWWjIJDDHH/32h6IFSYzsxwOtgptX5YxMVr
         BbFnjDN0Q9Rt5uRje0OCCJa2k4JAkjwJIyPgYUg4zsWdVooiZVZN7x59Y7Du+dSh7EJO
         PTRf46I0i4N4uSJwzPbWbbBIH6uT1oEa7fDsEWUuvQ2s3tBqiTpZcAHYeSJyKEQBJ92D
         5Osg==
X-Forwarded-Encrypted: i=1; AJvYcCWiXtKwChDQp6b2xlYAoxjeqUaSY99YjpOFxfiFpn6HRWgwpi4is7CRu3Nj5Qz9cKeFOqjaL2aSsZxvj3BWbzJaEhnjvaiuacQ6IL0w
X-Gm-Message-State: AOJu0Yx3Z39u933pTBb+U9jsjvFGszN/PHqsn5Hcw92wpHfEaukHy3ms
	2LpZuN01MguFbdgtP36Y+vW0z55unCVnnNNT3kj8ch3td0YsPhwU/NnzrYzSTjUTOJtS+3zKcma
	u9eZCt8qQ3ziX5JFmCJmikozmvEA=
X-Google-Smtp-Source: AGHT+IFRhVQXPzSTWpVBv4uMD/4d9a1KjuAUM4NuaU7GcaPtuARbOIDALUaGUkIOcSOqRdBVLfl2wwjLoOc68ajwug8=
X-Received: by 2002:a05:6808:1489:b0:3c9:7057:e8b2 with SMTP id
 5614622812f47-3d1a726a326mr14964193b6e.44.1716909372690; Tue, 28 May 2024
 08:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com> <20240524033819.1953587-3-yosryahmed@google.com>
In-Reply-To: <20240524033819.1953587-3-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 08:16:01 -0700
Message-ID: <CAKEwX=M9R3hUWfCPd-WpPBu31TgkRXjSFALgFjLkQsgxv8HWKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm :zswap: use kmap_local_folio() in zswap_load()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Eliminate the last explicit 'struct page' reference in mm/zswap.c.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

