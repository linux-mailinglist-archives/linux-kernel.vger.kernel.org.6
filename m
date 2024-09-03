Return-Path: <linux-kernel+bounces-312106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590896925E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D731C23C38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5E1CDFAA;
	Tue,  3 Sep 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMYR+kMk"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EB19F117
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334566; cv=none; b=oV7sPxSMhcyqDu/7wcHuPdqCC46cCGELPZ5j/fDAiMhLKpOkgRTs6LOvCm3ZccFyUpT+nn7cBBu/e0DP3ctnXdpX8lf4ghdGeujLMmCsMmNjWhcMUY5nS2nENU8207lh366cP5Qt14qPCIldln6BrOQlqIbNBnmzpkUly9xTlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334566; c=relaxed/simple;
	bh=NiMtLlFnkdfLxPBx7JS2haAmDgO+zdyW+0/G81NPoJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kiqat14/6hDIpSr7t0uz487rq5y9+i+cKSQL2AubSIs2Pb4E3wOZI57klqYIbUy1G7N9hbUeiATXIWKz31UTfXuK26LwfJskZZFpLHdogiCKLMchVMjyRVvMhRAFe8msUKHq7TFhIPxgb/tB7QdXa3lC6Lu5d+ty49sTA3EjhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eMYR+kMk; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70f6e65d605so1845976a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725334564; x=1725939364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Klasp/Czx5gKvCLsN/XwjCayc6V+YjKtJvEKsuKTZUA=;
        b=eMYR+kMk8jmHxllOkIBbQAoRqwlCdxeN2+fGiBD+0YZ6SlY60M3ixqfgZs+HKJKNFm
         d733eejUnx07Ga0FQ9aVG/0APUZn9U3nwzZZkN0DKiX+VXpR61khIgLJFr0nwvmjGzud
         G791qH08L2tcJVqkEqbEBFT8CbOJsiPM32awE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725334564; x=1725939364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Klasp/Czx5gKvCLsN/XwjCayc6V+YjKtJvEKsuKTZUA=;
        b=SyrDhehwiAK9VxE8lqSmhFd6g5cZEdgYqBfE9kmdxagX3FWPMwaMGKgrrACo6t+ZLl
         HqaHU/kuKsSv1M8L5s7M84/DoMsKUb/lSucx+dckHRDDwwcfnyiiKmaXuXhEHm4gPwrC
         SYk5+11ksEW68eXOVfuHuxY/mmAF5QnUnr7myhpFZQhw8L3eHK6P9LDSCQ0sW+RkvOkE
         v2Nmjj/6UikS3PM4wpamUByalKfFPKiNSbQWos429nF4Kv10+r0KptTfd+uX9zVLA/bO
         lxvjZ8D+E+FQiyg5YNqg2gGm/I0cSdPiH0PWTUC9deRcQoNvrp0R1XrNt6Ec0Y773lAS
         8mnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52nG/ZswXvtV0OwoX/6REYcCa3Isr2QCsMZz+DCv8aEffEl+3AhDNEbJ4mndRvSKSosqOSq5ETiDnSfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb50TqS9e1CFRbUDbTlR0mAbfIsVa/ho4Q69ACDHKNJPhx02eT
	KrA2vE34GID0NFxv3eTg8LY2uASEficxzZxIXppJpUQEHlhjpn3p9CrPvxC5Ug==
X-Google-Smtp-Source: AGHT+IFjRxHk7r+spqGR7hy3xIQRgf7Svjbf7lCDDkoX9gzy/soMn2SzNycNOfOVBKuUD5oxaEPydA==
X-Received: by 2002:a05:6830:7193:b0:709:44dc:dde7 with SMTP id 46e09a7af769-70f5c3ba541mr17684052a34.9.1725334564354;
        Mon, 02 Sep 2024 20:36:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569dccesm7525006b3a.136.2024.09.02.20.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 20:36:04 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:35:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240903033558.GC9738@google.com>
References: <20240902072136.578720-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>

On (24/09/02 15:21), alexs@kernel.org wrote:
> The descriptor still overlays the struct page; nothing has changed
> in that regard.
> [..]
> This patachset does not increase the descriptor size nor introduce any
> functional changes, and could save about 122Kbytes zsmalloc.o size.

Is this number accurate?  Where does such a large saving come from?

