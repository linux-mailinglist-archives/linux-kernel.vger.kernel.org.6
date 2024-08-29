Return-Path: <linux-kernel+bounces-307831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B077C965375
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF71F22CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3618EFD4;
	Thu, 29 Aug 2024 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K29sJxWh"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2B18A937
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974417; cv=none; b=kDX6UkRjb1Ne7ccnu+m0WCPHd9boe+scMzeLXSpfd2mAwXI1jLWm/wJnJEGjcq6crCxmQrtp/rTT5F8GcUy+f8we+piGvk8j2ODG4N9xhMKRDq2tuYmzHKvxVUU2LfOLabBg4hlGvjGwGKez/rHpvqbiHJJMZE9rdcy1IDiY08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974417; c=relaxed/simple;
	bh=zLp88o8MGxnEEJ3hNktdBtR8nJSvNWUdVerO58Odqpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp9PstkqsB2Ic5rQP4sUbam7OYhV0B1MW+Qh7i7ZTqFQ2nOBthhe2DYa/CYWWohlosbBErfiRe44DA/PPnLnDbS4AGKhNzpMVIqN51hRn4WuYpQDeBiLuZtP5jvLBoELMpMmTYVt0bPWPRTJZCsjGi1eZUj8fcyJyKRwckiKVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K29sJxWh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e179c28d5e8so1319621276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724974415; x=1725579215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLp88o8MGxnEEJ3hNktdBtR8nJSvNWUdVerO58Odqpc=;
        b=K29sJxWhOBdDQYiU0f63Usj5qO1+0q3MokekD3jPT9L0lY8GHDyonRmwlszETlIx2Y
         J4ydGHMUEu5oROUvjp0B4BEtvfQKEVZJoKDwqwE3tMGTovQSpKOf8D5/IaKD5DM5W3Yk
         5H26YWC5m8h00xURNLPL8rk0rLbS36S2QPH1hpGFuoRpLHNUGVZjXX2+CW32HkEdMe56
         xM6wMr658UC9n1fyx86LhFTF3sGRlWJwr4TLNn7Ir/YbBDIXKbpkqdC9kV5x0DD6Cr+8
         7Su361ReTEaf51GEXJ8ebuHKmymKCa4BhItGmPQMLBvpDrE+7vrQG/FGTRi9SKfBW1uc
         ZxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974415; x=1725579215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLp88o8MGxnEEJ3hNktdBtR8nJSvNWUdVerO58Odqpc=;
        b=C8a1KEn7yEe5xDMFxbo/AV2apmrbFig9QNtgcFUDTGkE2vLrYe/kUXJZv8n17TO0Dz
         a4lepiKavHRXhByO+kOlrSgyA2KRuDNYFA7iRPKFglLhNWFRGblducfVpBv2kRRUsYFO
         Vla++bjehwN4PaDrt4VWlfWh1zkR2Hklw5a/ROYi1VUYd5FVMU9/tEP96XwWHBsPG1o6
         U2qxXt91vp5uLhL4WYoER5f4MC0kIMis5yQVXj0KwCy0hYgJDDdt/EX92ODkaLAMMom7
         aAu3hGnjE8thS9eEUMOaL/ILHyZxjkzomk/Asu6h9auwSQBWj+D3YsOpI3LMAZ+MnhI0
         UUIA==
X-Forwarded-Encrypted: i=1; AJvYcCXB/5ltm387DtBiqToiXQDQk87DrYshiUBYjL4QyQD6c4ojA1fAE42vrR6cUQiuwP6GAyMQAWYXYVsp7NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxbghWoyTgVEMSmoLHRGL2wiEGmBV4B4EWGv6Kd5HhOh7aQwD
	dEMChDt3f6dFahgCEm63DIefNbpjOIwUruBvU7wdjjqGMKgmQTOr0ezO+tmad9pxrj7tNqayj9u
	yKKe6OAcpkNuwAl3hb6/8sRemv5YmkA==
X-Google-Smtp-Source: AGHT+IEFXPFP2jxLqdHYzjcqufUTeKieu48rK+aXcJkFu2d9BozamOQQQ9i6F7bksjvow1s4to3wb/Z97ExpGsCRTu8=
X-Received: by 2002:a05:6902:18d5:b0:e16:26e0:fbb5 with SMTP id
 3f1490d57ef6-e1a7a1a1712mr706983276.44.1724974415040; Thu, 29 Aug 2024
 16:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com> <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com>
In-Reply-To: <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 16:33:24 -0700
Message-ID: <CAKEwX=O8CfyBHZD6Xm_0DW5EuTY7g7FhKHiKj4xzZ4ozxdgQFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Aug 28, 2024 at 2:35=E2=80=AFAM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> Are you saying that in the "Before" data we end up skipping zswap
> completely because of using mTHPs?
>
> Does it make more sense to turn CONFIG_THP_SWAP in the "Before" data
> to force the mTHPs to be split and for the data to be stored in zswap?
> This would be a more fair Before/After comparison where the memory
> goes to zswap in both cases, but "Before" has to be split because of
> zswap's lack of support for mTHP. I assume most setups relying on
> zswap will be turning CONFIG_THP_SWAP off today anyway, but maybe not.
> Nhat, is this something you can share?

I think we're enabling it, but we're a zswap heavy shop + THP
allocation is not suuuper reliable until recently with Johannes'
latest (and upcoming) work, so I don't have much data to share :)

