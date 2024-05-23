Return-Path: <linux-kernel+bounces-187272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016168CCF56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EBB1F21A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1513D260;
	Thu, 23 May 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRsgBB/q"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C17446AE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456740; cv=none; b=poaL0n+rAyL7gMUSx5WZf/HaOOgESfRVs6VTSDsgzBMKRZuO3UCVISjCfkoKfa52J3IBFHA6VSwxRo6LxlsQBhulJ9gjA0e5lWKSn8oIowVwLDjuDHzBFwor4RZYXwTp1hiS4egczxJCQ5h8E/iuHngh0ua9ZPrjcPmnhs2M79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456740; c=relaxed/simple;
	bh=Lj98U6JsOomLPuUxYnAamRHx6i8QFetonnyK1CfOu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBMdRpGjqu3wAyUoyKQAPPeREmlMTVmnZBB/uN9MAm9rEFCrH+XkuK/AFZOB5M68g1roOsmFsMTVCgAY1eYDwarBZcqeNqbpjVNeRxNYChP1NavlbtZZFti7t6LQBhDYWo4/P4u7pILo2ngLE1qi/y9K5G1CAOwpYHkZaT5U4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRsgBB/q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52848dcebe7so339022e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716456737; x=1717061537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mQDu8PodgpyJeYqrI53Wq+jk69QtdU/8gr3jtIgfVw=;
        b=oRsgBB/qYGMLA5lBkUSEco8P+2cF/JERyGB8CjU1O1jDwraU/RYjPON/xRns70qqSt
         ThVhFGW3baEKZCNFPe1a563yGL3zKZFZq6V8RaXRGFKBsxsqyQvlcD1VPG/kQEZj16zv
         wbW/I1vrmRZAi48ALara9bJSYpfJelByUj8EA0/VNHUg09L2HGzOguZC3kTEV+6WtiWB
         wxZuSLc01ET7wn3QnUJSG/vPuvkSX3jkQVot4A34pJVB90DGw3TVlxf+K9f8OKysPneV
         EQko0a4kIIDmMTi1dYo0mi9dPjYteOU9f+2UlKmilZxRcfWAxyBQaIXBQJ5TpUSIvaSU
         9XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456737; x=1717061537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mQDu8PodgpyJeYqrI53Wq+jk69QtdU/8gr3jtIgfVw=;
        b=X772efN0jie8e10lNkRiccwojXAM2ztGmjEF5u6kxoxx5hgWfTFnW6i+nvXFFZNGRA
         r7UZhSWSY2IPpUwXR1gsjuEK+bzO6S8TuF5vr2Ui6cMb3AZqgP3igfQP8Kt6k/2yYliF
         H7a0B4w3gi73t4daefwgr2tAFDWtmAupHEVnSssNPeCq7RaxnndivY8P/+P9OZ1ZqNJC
         3xfCXbp+lCX9FTpewh/b9nnK++gA/LDfY2AHzmzdix2ivPb21PUPFtBr62VlzmHMHLqI
         Y0KqtdZFYDwfUVb69wwYNQpoU9A3xyxEsk4YE0jIOjD926bS0mfNDfLKwD4MYdtQjL1d
         k3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JBGZmBrP15FzDUUzsXITQ2CdmT4TrGy+yChWu3OMHBTJej2NcLnc152nl7jjwDx5aOQpzV+QfHG7pSzYD2D9K9HemxEbMon/jDkg
X-Gm-Message-State: AOJu0YxKkiLxe9W6h+5F49hgcAQD5GBpt9pB7LwLrZtaeE/LsewsVd37
	rZz4uFjD2sH5iu+YWoNhvI51dTEo/fS1DLa9a99YYA2LbSiUH/+ChL8o3ycrCg==
X-Google-Smtp-Source: AGHT+IEk9OvR9KACg8HHVRm631KJZ77bnL1wnmhw4pprthIUd9aI9YxgnMHNvd3Rv4SBsaB2zLbhiQ==
X-Received: by 2002:a05:6512:3b11:b0:516:be0a:58b with SMTP id 2adb3069b0e04-527eed419ffmr775222e87.6.1716456736468;
        Thu, 23 May 2024 02:32:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:4571:1ce:5c15:9ee])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6f5cada08sm22900441fa.140.2024.05.23.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:32:16 -0700 (PDT)
Date: Thu, 23 May 2024 11:32:11 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk8NG10oHcQ0T6EQ@google.com>
References: <20240520083048.322863-1-sesse@google.com>
 <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
 <Zk5Mi7SliDOd8uO4@google.com>
 <CAM9d7cjjH63CC8r-z33P4SCWw3x4NMxuSC1CovVHqpp-zXSf6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjjH63CC8r-z33P4SCWw3x4NMxuSC1CovVHqpp-zXSf6g@mail.gmail.com>

On Wed, May 22, 2024 at 01:46:35PM -0700, Namhyung Kim wrote:
> Great!  Personally I found libbfd is hard to read (and use).  Hope
> that libllvm is better in that pov.  I'm not sure if we all want to
> remove the libbfd dependency but at least we can select one of
> them at build time.  Maybe the same for libelf and libdw(fl) too.

I've never used either before, but I found libllvm pretty
straightforward. The C/C++ interop is a bit painful, though.
(The disassembler has a C interface, but addr2line does not,
from what I could see.)

> Having symbol enumeration and demangling with LLVM would
> be nice but not required to merge this work.  I'll take a deeper
> look next week.  Please post v5.

Posted.

/* Steinar */

