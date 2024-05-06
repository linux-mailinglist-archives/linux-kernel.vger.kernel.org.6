Return-Path: <linux-kernel+bounces-169371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589708BC7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E71C2110F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA0C45948;
	Mon,  6 May 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RflGFmp+"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB94CB36
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977822; cv=none; b=n0Unl8egD1aLW8DIA9wuTGig99OEe1mUz92IOLegHIpE7NJjzteT98bLPND/ZLPrtNBquXf66+P/VboYDMdW+EVakKJa4gFYEyeeiz6a9bt265obxe3qAlJhz5/lvnqoIOCVyGjtX38+6AfJqpGqKD3bbZrmDewMYv7walkyNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977822; c=relaxed/simple;
	bh=TTtQyHcx8HkIEEBoI/wvFIf+0GYqPB/yGd00nQkF9Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlsV2ranDcKwYX0ALR74IPHIHsOy33fOZvCT1TWu1b6tRN2X+2vCnUyB+BgaX0El0unI1HIf4jCTz92Nahfkxk+8AqUZktvSQ8Ke9LxbsC+u92vXX6MNufbKDzpze5Y95d8zjAGGoFc3sXXBzyVJNHMy04XGA3CfrZeMGBrUPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RflGFmp+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b3c1ea9a68so948624a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714977821; x=1715582621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awh0YX9sFOZlmXGVWv7TrQyTmY6KwzUZh2FsqtFN28s=;
        b=RflGFmp+l+BXhk012uKZ6aGuTeT6YcCrQtXctXqH+GYKCsoFUkUu+ncgwY+ZsVSEPf
         Optz1qPMVDD6ozHGvn9LX7Vbec04BflDCvLwMgIJnuOo6N7bOWYZBSyKR8z6jaTMREwx
         jbKOWzJ+JqoF4pLVdtWNcOTcBDLi2H9zqMAT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714977821; x=1715582621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awh0YX9sFOZlmXGVWv7TrQyTmY6KwzUZh2FsqtFN28s=;
        b=lnKWEqSIO2AxT/oSZBT15op5KkkqZmJgDwczboYZVs9awyUjrfTRWlMxOm7EKHo/uV
         Kpy9eVA3FcgAMPRmHNAbMee6HeqRgp4woB4IKfJgBfqbGC6lacD3q/ICClqnf+hNXXxi
         RwiXsnMlbTzIbuD0/VpJkPnRjfDUiKG9ww+PUNfW+3RBcIYq7u/IC29mIh3R2wgmtrIk
         l5IVcPqsAGBff/uJaS84jg85RutDjFumYtHrj3lwC6W5zV63SxHASk8lig5zbcS9A+2g
         E3THiXvGwUfENLVU3zKGL6Pl3nANIoXFq5LkOtFlRDNKs3AgKpGWJSwFm49z6ad96/i9
         2Gsw==
X-Forwarded-Encrypted: i=1; AJvYcCWb56qMnZiKZuK+QISCnO6F7yx7zM14ubvvceJ4vjYV8KEoP+1l/y7/PaKIhJv4uYKynt9QpC87E3CanXt4fZryj4IMJ3OKs96UuNOO
X-Gm-Message-State: AOJu0YwkTWSu1UFAk61SX8vWC4MkeMxZogahNRUNTaMBvKtEcGoO+pQY
	H7hrrnl8G4BhM2zmii70bkp8Q/5eWoJO1Dsl1D/jp5MMONh0LxfVUo6QrVp84A==
X-Google-Smtp-Source: AGHT+IH9/hiNrPAZgMq5yCe0qsmK1lm2LH0SwY8LB+Tn+zX2oS8PqcHxJee+fl5rH8OfTgRdDd1VYA==
X-Received: by 2002:a17:90b:124b:b0:2b0:763b:370e with SMTP id gx11-20020a17090b124b00b002b0763b370emr18238105pjb.18.1714977820818;
        Sun, 05 May 2024 23:43:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id rr3-20020a17090b2b4300b002b113ad5f10sm9316590pjb.12.2024.05.05.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 23:43:40 -0700 (PDT)
Date: Mon, 6 May 2024 15:43:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240506064335.GE8623@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
 <20240504071416.GH14947@google.com>
 <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
 <20240505043957.GA8623@google.com>
 <20240505051305.GB8623@google.com>
 <20240505064832.GC8623@google.com>
 <20240506032207.GD8623@google.com>
 <CAK7LNARUBuR3gDtX6GfB7Zv6dydt1+qzBB_XT58wOg3WeCTVvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARUBuR3gDtX6GfB7Zv6dydt1+qzBB_XT58wOg3WeCTVvA@mail.gmail.com>

On (24/05/06 14:20), Masahiro Yamada wrote:
> config ZRAM_BACKEND_FORCE_LZO
>         def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
>                  !ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE
> 
> config ZRAM_BACKEND_LZO
>         bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
>         depends on ZRAM
>         default ZRAM_BACKEND_FORCE_LZO
>         select LZO_COMPRESS
>         select LZO_DECOMPRESS

I'll take this one. Thank you.

> BTW, "default n" you are adding are redundant.

OK.

