Return-Path: <linux-kernel+bounces-547380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68BDA50667
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110361889CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DE19E997;
	Wed,  5 Mar 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgNfQ5J"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A4A95C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195981; cv=none; b=kbylCMWjlzVH4nQqnhr5Ak6sV8p6Ecen/bn67CTEoOyMDNuBXQv8E8/xxmP0zKPeCNATY0qldlmQG7j7jMyjxAWddgiW9IOriQtPPkgfO89EINzG+ucKDh4AdmwIm59JYvLSU9tIIJh/kFQz8UN+zCNhL66o8qUo0Se6uyvEMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195981; c=relaxed/simple;
	bh=rTOzIrOuzFLbtmFxa6518U0vGpYlXYwbcGJ0txa6GSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkBtm5zNoZnncQsFmpK84/CYFK5o7VGHEHqtGGPFocgn1NbnbgIHas49jmNw6Fq3jOy8bcSLSIVn9iMCh+WPgUI0pNfv27FXOHqKOs+xcA+yfwTTPRan3mCQReQ7PmSSZkQ7/PeTxoIIzQsD7dXGeWv5tC87an6QWJK0bXMjhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDgNfQ5J; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so95273286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741195979; x=1741800779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTOzIrOuzFLbtmFxa6518U0vGpYlXYwbcGJ0txa6GSg=;
        b=IDgNfQ5J6rcvs9b+8dSbWjVzajSAmgycT84cCy47lVqyV3KDnxu1BbFhfQ7XpeQvYz
         QP89VgG+Cd5BbT7NoNqMpUZ4tZgHFm49w27DlH6rtIgwwDP5K2MkF/7ri8+ZGmKyJX+g
         p/6fyLq6kg5TV5yPge/SSzN6hYwI+zqeOAqQJ8en8eJReCk4EVzB1ZbCOCcEGiib4g5V
         Jje0WhHw+tdiy0LHwWlyjdPrsL+JsBZDRoCJRbUl1/pdPV+pcJmY/Q/UU1Z0/zXQO3wD
         z2dtNVYBpUxxNSWzrSWxP9AfezLgKghe6HrpfolXLArAdx4DMwvDN9pTDU9Mfyn5cFD4
         u0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195979; x=1741800779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTOzIrOuzFLbtmFxa6518U0vGpYlXYwbcGJ0txa6GSg=;
        b=ERwmya4GCJCxqFcZKa+5lLNhHXP3DgonnJ3W6/uruKep1e1RiQN/fUld3ODhtItNd1
         0+eqHuRkQ3TC6Z3xNu0eoOwsq2QkGzKKV2Nrh3Q3NDZBkW1sCZMPfYiiruzG0BZbJAj3
         VZtES2SrNd5Ed45JwAVsjzEMzyNEtr4tGcWAnBF9it/v46n6iESqh8FsnslG7RZr//HQ
         g1BNc5DSXgNIFddQmEMmJJc5NVwveJe60Wb9fyNsY7SkXKbPs4IFSuxgI1pZG6ZGlSYS
         ilt7h8vjimBy0Dh62FyhC9YsE6Wtz0L/SV4oWswXf0+MrYe2M6+V3Z3QBbyOb+MGD7fr
         QWUw==
X-Forwarded-Encrypted: i=1; AJvYcCUzy+DgVL03n7oaUOGLkCMXqu+7u29mg6V1LA3CQ32G8kpROt58crdpeiToEs3N2evlDsJiQDbbYbMYeoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDYqno5QcLdKew6moCmXTPSNfbOVCdwleXn9NU+s6xDCE2bH0
	zDMfALKvyl6BeRaaV+LXcNFo/KY8iy3N5XRptW2zg9v4chDIL/vyobr4ndV1nYKec10CxvFtH1M
	9j1rP2KcjAA8AxMzZCkHgNYivgjc=
X-Gm-Gg: ASbGncu7jXfXAZt+ez1q6OAv4cSjVA2TcZhMB10Mmofsp+WtxwxURZLjYTfxA89IJsM
	al8RRh4GFN9C5u1LPy+0/Ws71olk20A9zmPF4NdF0qvkhewYdQ6nouRpzwskde8HRGv0JQsr+wd
	careEjbWvi6RMMB5/MCTdcmK5CVxyFejNMbKokw9t//vSAWo4iOd31C11gGQ==
X-Google-Smtp-Source: AGHT+IEQFgZEf1pCMcfuzmsyEd8/uQHb1QmGvBrQaaa+6qwA+i1JFyA+YD9EFiEC8zKqqttjzfqD1tH1kXtD2ljWVao=
X-Received: by 2002:ad4:5bea:0:b0:6d8:8466:d205 with SMTP id
 6a1803df08f44-6e8e6cc3668mr47776586d6.6.1741195979089; Wed, 05 Mar 2025
 09:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev> <20250305061134.4105762-2-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-2-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Mar 2025 09:32:47 -0800
X-Gm-Features: AQ5f1JpyAzgKPLF4HzOFwfSyMdNt2ETwoRAsuormuD3-slmnxAZZcZaeL1VW3Xc
Message-ID: <CAKEwX=O4GAE3Rj389cTOGdaGxjhqz0y4icC=WjWv-vqvDDCw_Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/5] mm: zpool: Add interfaces for object
 read/write APIs
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
> Zsmalloc introduce new APIs to read/write objects besides mapping them.
> Add the necessary zpool interfaces.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>

