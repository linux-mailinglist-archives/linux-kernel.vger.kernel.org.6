Return-Path: <linux-kernel+bounces-179446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AF8C6008
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D831C22162
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280CF3987D;
	Wed, 15 May 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="beNLgZt/"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393823B293
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749632; cv=none; b=XbLkmOgHp0zsXykFnd5KO+3cl4fseNS6X5ldMI38ExE+SNLi+hYUQT8gImgxso9SRBVCfFLfZ4vrcvPSZ424ygF4M+Z688kjw5fw1Fu0RUY48dmwUgMbDtVyYtZvn99nJoj5Ldho8JXymB5Vm/hZCACE9MVLO0Vcw8l8daGtEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749632; c=relaxed/simple;
	bh=r22Ecb1HjRi1JsHgO9EEQEtHjCyx+qtUYvZ4+U2lkZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJREEpOyYzGL8Hfo/N+hm+TviaxloswSuZhbrGLfaI144IT49fZ5K1xw42HSG8iW+FrR0wO+Feuvcx6NOD6Bd/xaU5nN54UMI46ML2z7ogsRDD5wZni3w3hLkYnpX5P4nuO+rHauWZgUg04Gjot6C9SGMobzXaQnnTXjqSrxHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=beNLgZt/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f43ee95078so6191581b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715749630; x=1716354430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzRi7BBK8Kzi4+jUS/kWK3iSCsA+f0xRAjzzQIW1Bf8=;
        b=beNLgZt/Z4YnbdF1hqonNpAqwnD/RlOg1o8yS5D+erHXlqrlTjrxaPgRiEtX8y+Mue
         kxU7pW/9S5k6sIO67Z5nNUoXc8HNpCHKxbL7ryucaocWTan8jdcjhV860KJVAQrbkT+x
         iM1KbRwPFc9xwubKYxTgjuhN1ilP4m3qQXNuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715749630; x=1716354430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzRi7BBK8Kzi4+jUS/kWK3iSCsA+f0xRAjzzQIW1Bf8=;
        b=EvvL3/SrwwtfJ26HH07sDKROeOsUUo9FUf83+AjROftBjfCvJgDs2qIQv9ADkrkQdU
         zEiwEaifH1SyLUd4wF28TxzLrmY3Ogz1+8SeLPTBTRHKrFwBNrN991Te4bpy3ke8NhYj
         hHw5Jb0FTuZBC7ezWVEPTQZVxo0jK1i4akOyuXuq7jlOt2fDNCNgyxJ4lwaMhM63xfzv
         joQ5m6Y+H/C2Qc04DIZq4b/RIBOcQPT4nL1iuid2ad8HjBA3kAKJ7hG4QrhO8KbRtKXH
         rhcUicQQ5hXHCxkYnHzE3fwT26ih7ih3GF+kpd8npE7tfFpj/t5THj/Z3wEVquAcIn2N
         omfw==
X-Forwarded-Encrypted: i=1; AJvYcCWDSTC/vf0AJcGa0Iwz4rX5qkczbS8m0AYOf76CNQmgCpAHdPLiJOV346IXH8XRWklHY6DWfJB764S48XJB4BNbWCUCFaKnmPH4Di1X
X-Gm-Message-State: AOJu0Ywm9/RAd9RG6E74Z89uo2QpHSpVnDAXTUhuJG+OWQ+Sw0HXVvVe
	j53u7CeRAegOKAOz3+aUTUuzl3mgG6oLdhO16sfS9MJ4HIul5VoA51Rx5Ne5aw==
X-Google-Smtp-Source: AGHT+IFzghujq4lUG5F8pX/TiqRbgCGgm0mozqz8fwsdeFoDVeXza7aCH/TT4k7CROrcXZWoBRaIoA==
X-Received: by 2002:a05:6a00:4f86:b0:6f3:e6ac:1a3f with SMTP id d2e1a72fcca58-6f4e02ad970mr17673879b3a.11.1715749630446;
        Tue, 14 May 2024 22:07:10 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a663aesm10092200b3a.33.2024.05.14.22.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 22:07:09 -0700 (PDT)
Date: Wed, 15 May 2024 14:07:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org,
	"linux-block@vger.kernel.org Nick Terrell" <terrelln@fb.com>
Subject: Re: [PATCHv3 02/19] zram: add lzo and lzorle compression backends
 support
Message-ID: <20240515050705.GF950946@google.com>
References: <20240508074223.652784-3-senozhatsky@chromium.org>
 <202405091921.320BxOyE-lkp@intel.com>
 <20240510053333.GJ8623@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510053333.GJ8623@google.com>

On (24/05/10 14:33), Sergey Senozhatsky wrote:
> On (24/05/09 19:23), kernel test robot wrote:
> > config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240509/202405091921.320BxOyE-lkp@intel.com/config)
> [..]
> > >> ERROR: modpost: "backend_lzorle" [drivers/block/zram/zram.ko] undefined!
> > >> ERROR: modpost: "backend_lzo" [drivers/block/zram/zram.ko] undefined!
> 
> ... and that's how learned that my .config has ZRAM=y

This has revealed several problems. First, lz4hc misses one symbol
export, an easy fix. Second, zstd misses pretty much all of the
advanced c/d dict, c/d ctx API that we need in order to use dicts
in a module. I have fixes for both in v4 on this series (I'll Cc
Nick on lz4/zstd patches). I think I'll just send out v4 today, simply
because there are patches there that we can re-use even if we scratch
zram backends and continue using crypto API.

