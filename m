Return-Path: <linux-kernel+bounces-168889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAA8BBF4B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC98E281E9B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E63D8E;
	Sun,  5 May 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lQ0S6AeN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCA184D
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714885992; cv=none; b=pq1tU0aPKaz7P3/LmNFeBGdAGSUCk/iAd+xL9sNRNbVUifKz2tQ7RHijdNKHry9LDPlpIujlLXGSBgBzgU3/ThFcPYNRxrceal3w5TDjYSAvwoInle1So8qP9USAt0wlz06LDhxsVaqcA7Xqz1oeAhdRqBBcHUyKBL8R9fp49hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714885992; c=relaxed/simple;
	bh=lehZe/7AZUPc+TY69M7+JDOOMjWhzo3PGggFRdj3IxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueOIYktWdD436K+XIiVVHDfzWGktBQJ953XJKFub965y1a75KAsOk8KI/TbBknApTLyrbHCO0/i4KGsz9YwhAPLrs5l5ZAp8QnrysOHKWX1hTmZs85VsBwQYoUMKrMEN3stOY7EZm2tsHd6XFZn+aSoUdBD6siW0b+i1JoZ/liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lQ0S6AeN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso765129b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714885991; x=1715490791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsfIaMjECuvVC7Z9W0Sqg9Q69W+YCDdoNBcIXl2QIwk=;
        b=lQ0S6AeNmPbdX7bWqd7XTfvrp/l74zHlBTfz/rJwAsGHSd0i6sJQEshSHlEHNqxuxH
         pkjf4mgpmtag+PI7mPu0VFRNj4OGf/ZHINipTjIPSIMhtp1dQ2lhs5qpphTlq2dnTFHp
         swWICkzSZ2OKAPGhfHctiOlEsmHZN6wfbz0pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714885991; x=1715490791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsfIaMjECuvVC7Z9W0Sqg9Q69W+YCDdoNBcIXl2QIwk=;
        b=LTktZGltpLHsTi5pVWpwRfD012X9jKu6q3QzJqLi47HUUFor8hjcpiRVU6t2M7bS+i
         bsFFNy373PcxrbtaQeJ/f2O53izqxN/+eARjPWA+Hr+mHAs/SF9MIqHx1jSyp2i23xe2
         6QQztqLThkvImzihfBjzlyphCxxKM8RSSvxQoW2ffn8FKCRE1YlZI3g/aHy0DLbjtG/d
         oidVxwWD1e0SDeawt2QZuga05oeFZJyBhQfCt7CP+/VhoRC0oa1SYmyIRn8wrUg0t+ls
         xqqu3IEOISHeAJgdwku82m/DruXCFiBj7XdpJYsuFKBgjvkEDK3Dytk3mUmxxB7+CQ30
         ZA0g==
X-Forwarded-Encrypted: i=1; AJvYcCXE/XSmLpVs3aKMJFpr3BY0rzlqYYe9FLKNecKBACnWyYn1f2Y9nUiLuE7Q4Zl2J06uT0sH7Njsyt0ta116rIqo3pWYx0y37UsxrWs3
X-Gm-Message-State: AOJu0YzuEWOLKuJVNYgyW7k4CxrNxeZTa8r1qaTAPnYO14lDEpxyjNnl
	EAmg9UlUxxGBpjx1N8eor4Q892sxtDZHNshIomUN6pfDqCbrdu0TgWoGNmulpw==
X-Google-Smtp-Source: AGHT+IGx2K+j9TsopgjG/72ja+WbDJMY4Wn9iAnqvKY7ERj2M9PxcHA1IZC2lVKSrAM72Djm/H4zqw==
X-Received: by 2002:a05:6a21:3405:b0:1af:8fa8:3116 with SMTP id yn5-20020a056a21340500b001af8fa83116mr2671010pzb.42.1714885990672;
        Sat, 04 May 2024 22:13:10 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8263:3b89:bcee:2ed4])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001eab3ba8ccfsm5839237plb.285.2024.05.04.22.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 22:13:10 -0700 (PDT)
Date: Sun, 5 May 2024 14:13:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Minchan Kim <minchan@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240505051305.GB8623@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
 <20240504071416.GH14947@google.com>
 <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
 <20240505043957.GA8623@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505043957.GA8623@google.com>

On (24/05/05 13:39), Sergey Senozhatsky wrote:
[..]
> > I guess just pick one if none were selected.

How do I pick one if none were selected? Does Kconfig support
something like that?

> : config ZRAM
> :        tristate "Compressed RAM block device support"
> :        depends on BLOCK && SYSFS && MMU
> :        select ZSMALLOC
> :        depends on (LZO_COMPRESS && LZO_DECOMPRESS) || \
> :                (LZ4_COMPRESS && LZ4_DECOMPRESS) || \
> :                (LZ4HC_COMPRESS && LZ4_DECOMPRESS) || \
> :                (ZSTD_COMPRESS && ZSTD_DECOMPRESS) || \
> :                (ZLIB_DEFLATE && ZLIB_INFLATE)

The problem I'm having with this is that FOO_COMPRESS can be M while
zram needs Y.

