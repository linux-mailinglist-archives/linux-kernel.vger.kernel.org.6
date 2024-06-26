Return-Path: <linux-kernel+bounces-230448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1272917CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22251F22089
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A49176AD3;
	Wed, 26 Jun 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM3sUncr"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A816CD1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395449; cv=none; b=t1/d+/EPvf1LtZNaow78wg9m4kzdiOEl+jNL2tlU3PhVGQ2ceLMDHKxcD65bE9kZZVwSn9tJh94EwIl+MbqHZGnKi4k5uObJ5QWNz0nqGBDH679o3uXwspquLmLjmQKiu0TxTamHoVM+z76SrenOopw0/ojr6chdiQZFxnsaNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395449; c=relaxed/simple;
	bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYjH3ypuLw97fqUDVDXS76nnp/Z4czZbQkSbR5KYoB9FvlRxR5t0sgjmUpz5Ae2ep2I/NeY7xR5+Ihcsl9kV6/vxcebRwZN8YAt/+LNXV/Z2HuCH8hk8CCjHfytMSuuiM5L63bG4Zmom76y2rbq+rMShGQCoBosdaxjysWS4HNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM3sUncr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cd80e55efso8544553e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395445; x=1720000245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
        b=UM3sUncrWN6zhe36o3vEJ8ZFcJtCBJHXNPzWKNx3PUGfSw7V/Od8UOK1OMQUbe7Wg9
         ssEEA+cP+Adjz9O5fTGUcn0CaGYVV/NC8suICwgGQdfgbTpZuW6Juw7VzLuQQ6TcqWfd
         EYcfjHFs7c1P1BV9CtTy6FtWwOExlVUSR/sLTWme32MWq+6MsZBhieavMNmMV4IUKEGk
         3IfjT796ajjL+W1xxOm7d3vr0+vTGz5TpxR7Z736KjeAFqGCmCNKezmCbpb6OG7KaHet
         vNTc2xrqygHMhPWnrcI2Kc6pIChdnHXSlrwZRkqCgWgJtu2LWEUjKA1BJMU/EbJoZIkN
         DtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395445; x=1720000245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
        b=ekApBGiCr1lQA4sIOfP8rhYLAR8ISsIF8czwMkGd/EXE4F5TMJXQcipZPSavWQVGQ6
         aXJTQ8qhRseJYgTDHKC66u/xWWB0Jp8LHbPRnBinAMYGjsG2QHTIB+x8ndn+SjeX2zif
         mZURhj6q2Rt+Oq6h9hhFPxI8VHEetvX6fozIzV26R8ED6MTgQF9ZItVjDIgbSq54YTz0
         ByPB4awA2Z6yMLpYQv2vI0kz4vo0xzwsTZVErF9X0/Vjz7+kt3pSQ8OeIyojpPlVwE5H
         Lk5oIrJ1+XO7QFek0AGHraboiVv/KG+uWHX70oU0nFNDCeEBYJHOiy+J3/kLIyr4J+Ql
         4DCw==
X-Forwarded-Encrypted: i=1; AJvYcCWYIXAUgOdak0svCzV4eDjwNSIi7arh7lnMrrsg8/9yM/4GoC7GpzlbQozGLvPwHlrO8xNMFd1f4ae2xP5vPn+MgxyXwI+W1nlFKuoh
X-Gm-Message-State: AOJu0YyE8m+6C3RDTi+jxIFHzYpwYAz5uBPT6PWp5dsu089/Uj2EqTPg
	ljd9/hNt4ZofGOI+sLVYboL+sbWJPomBxMePZGyrgz3nfIB2Z9NKlO5vpBaVgZVM5gYGwr32dxc
	byz0qAfMTeORjr4QeSISJcJ5zepYQz9yIQ0rvyw==
X-Google-Smtp-Source: AGHT+IGSObvqboJ4ZZ6yoQ1c/G7L7JssRKsKX/b79P3e90H6Lvbk2DOvVW3Js3s99JnAusteMlXmpMMT3T35ygpYy94=
X-Received: by 2002:a05:6512:3449:b0:52c:dbf9:7e54 with SMTP id
 2adb3069b0e04-52ce1836330mr6750930e87.41.1719395445554; Wed, 26 Jun 2024
 02:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618032620.2445395-1-ruanjinjie@huawei.com> <20240618032620.2445395-2-ruanjinjie@huawei.com>
In-Reply-To: <20240618032620.2445395-2-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 11:50:33 +0200
Message-ID: <CACRpkdYAjKMSGmR4pc+LEfZ4NQArvgCEwy=ujzjOQus0K9j40w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: 9258/1: Fix callchain_trace() return value
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, will@kernel.org, mark.rutland@arm.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk, 
	eric.devolder@oracle.com, robh@kernel.org, ardb@kernel.org, 
	broonie@kernel.org, lihuafei1@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:23=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> perf_callchain_store() return 0 on success, -1 otherwise, fix
> callchain_trace() to return correct bool value. So walk_stackframe() can
> have a chance to stop walking the stack ahead.
>
> Fixes: 70ccc7c0667b ("ARM: 9258/1: stacktrace: Make stack walk callback c=
onsistent with generic code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij

