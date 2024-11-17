Return-Path: <linux-kernel+bounces-412006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5F9D0240
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 07:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2159FB24B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5B74421;
	Sun, 17 Nov 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPdLBZA+"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CC2A8E5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731825143; cv=none; b=Ks7ohHKIpY9Xrs/GIwOnEwvpksVDfXWC3cUssONX7N2rZFXDcWI2XN6Hy2h4OI8tSllDoCoBU1Nv6UIx/3Pa3Y6wUjfziceGWDqQktS1zV3gB208YEz4Hg+8I9CWP9RKrKCuSXO1B/c8ZbmYnHlRXYA7xgNFejHkA5fIr4WMods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731825143; c=relaxed/simple;
	bh=js5ER6/mUai+uomy9jo/Q+NnireaZP5PHNtj0eg7FsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6XTgswyyRfr871wMDuoSdfuwZwPFT88SPosULE7QfWNQNxeFZ4gjgAUQFj6QFsi7I4gkGOquu3OOQ1LT/LM+R23Jg4pEjNKBGa2HPq0yrsQOzJ4eWzjrgiMFfVoLF4zbRHRYBjM7Q3Nc52dHhhmwV8DdLR9m5RPIPHzhPyCoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPdLBZA+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50da1fceeacso894679e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 22:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731825140; x=1732429940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qSc1fVHmPer1xJUptlyE/yxio3bMTRubjYEAtyecg=;
        b=QPdLBZA+3gO9DF5mDLfaCplY9+U1Wgo0jCtFAYv0D/59FIbe8ZCTOagQkIbofwT35h
         WWwVU3AL/ZNYzUV3Js2bG7dggN5bf+h+e0hPH16rHP7ko2my9Ibzw/cQuuTVNE5Cszc3
         Xr2YNIZmFz9Gb9w8OsnkJTiVn6uOqSxf/9QzC9jp56GNBTMOdL60s8juoxEJRsZRliJR
         0NaIsRagm7qAHBJDA0lZGHwhWNgTaBC1AATISUlEjZBf2VWaJQGX4kLRuffuXiDQBtI5
         jCywYg0LvdH8g/I8qHamEvaX08wdM6Wa3OeL9qm9S7Sv7U8YfsL4cBtFlBoVv22bukbA
         xq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731825140; x=1732429940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7qSc1fVHmPer1xJUptlyE/yxio3bMTRubjYEAtyecg=;
        b=CAIfpsJuagTIAuU+TAnXoG9C2Ss1d7V5SSEJTa4jdvNmU6edOE9hLPmAWbjBQJtQev
         78a3HiQLhNcmQCNYiR7kbwIgewjNIypUN4nxmymyxDVWnjm0j6fw90J2zJsl5pS9k7N+
         4Ph900fSlvgHD37oZu5A7PwVplhaVGb58hl0Pe1PkWd9mTlhu2YxkqBnQHhnIZalLy2h
         kZEFUrQ+KpC2itwI1Vhhh2+ZQAWlkPV2OdX+mc798rDWhQyi4t+sP0WlbUJodnx+Rcds
         2ywP8DaLPiRjpIpTxSTKKoDZNsGqxK20JhNPXqBv2gvNw5keSSL56N/X2HFenOasIyF/
         Qw0Q==
X-Gm-Message-State: AOJu0YyBv28rEMfvUmszJzky2ltQ6IlGd9obKiXJIs7MysaqUz5s8A1W
	lIZ+MDVOtVZBm/Ql3zTcrDtwxX7WypAH9nnWMYFZifSSBu1S6gLnq1GHVhBT3W9sfqdcMIiM9cp
	A2xKqmEAy8Qo1iaQt16ksgHd1kVO+0i4DOxLV0zYDF+AGSd+If0k=
X-Google-Smtp-Source: AGHT+IGRh8YruUGu07jFRPzp370nbfvg/Y5tJl8pnw3Rt1hrLahShOnGJFL+33z9fqviT6zuUFmq+IrxpExykzDX1MM=
X-Received: by 2002:a05:6102:e08:b0:4ad:5beb:4048 with SMTP id
 ada2fe7eead31-4ad62d5a317mr7754717137.24.1731825140429; Sat, 16 Nov 2024
 22:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs9R7DwZVkA_MRaqWwrfuuvZ-3wMcYuk3oHA0prN3bKRA@mail.gmail.com>
In-Reply-To: <CA+G9fYs9R7DwZVkA_MRaqWwrfuuvZ-3wMcYuk3oHA0prN3bKRA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 17 Nov 2024 12:02:07 +0530
Message-ID: <CA+G9fYtTgghGirzqYmRFtxjgr_38Tt4oLvcyjEinqh41UVRqnA@mail.gmail.com>
Subject: Re: arm64: __kmem_cache_create_args(ext4_groupinfo_4k) failed with
 error -22 - Boot failed
To: open list <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Nov 2024 at 22:51, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The qemu-arm64, qemu-armv7 and qemu-riscv boot failed on Sasha Linus-next tree
> due to ext4 crash. Please find more details below
>
> First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
> Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
> Bad:  d11b462aa01e0ffd5f8cc81bd5d2cfe4e48c8fbd
>
> qemu-arm64:
>  * boot/gcc-13-lkftconfig
>  * boot/clang-nightly-lkftconfig
>  * boot/gcc-13-lkftconfig-perf
>
> qemu-armv7:
>  * boot/gcc-13-lkftconfig
>  * boot/clang-19-lkftconfig
>
> qemu-riscv64:
>  * boot/clang-19-lkftconfig
>  * boot/gcc-13-lkftconfig

The reported regressions have been fixed in latest commits on the
sashal/linus-next.git tree.

- Naresh

