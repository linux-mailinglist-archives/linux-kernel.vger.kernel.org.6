Return-Path: <linux-kernel+bounces-178175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029CA8C4A08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A194B1F21A07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8285631;
	Mon, 13 May 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iwklbf9+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864B85284
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642908; cv=none; b=uX8yVQ3C6u21ej1jpUHpYJxfkkrkdAT8g6cFRXD44aY63mY1s72Cn9o4UDWm0Aj0sWe1VBT9nGMwjYi7cQFYlZrGI82ncKJTjhn1d5oms7nc+g4P+jxei8xngtw+XyUzOxQTOamnx1liWu8ECNIuOXkA49hRzugDFVYd7oMn2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642908; c=relaxed/simple;
	bh=FK/pOlv8p257iH5M65SUDFW31ZwENP3sUAncbWrb2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv2RWZrwbvPjNimFNEpcJkBhyqVCP+78jPa5TQ1Af9T2e4r+iH3hT8/53vgvztpNPa1zulhfGOBVei6YdiQNv3D/mxp7WgMnavCbhUhCQrrn7ehdk10TI9tftENGwRDg/8n7cqx/SmJQoWAELGzS8a33HLqPSdf68MbV8w2C4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iwklbf9+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6333b2551ebso3330450a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642906; x=1716247706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=Iwklbf9+elmKMIJNZC5JlY5Dgm8Sqo6bOGVL2h+cjBGV0hwkHTOwKHWMQ7LrW92oh6
         tX2cKiKifvFY+PnDbBdRlieMj3r2qJvtX035ZGqUfppuwZBfw3dpexgQf0lpdxrOc2xi
         RXXuAOI6iSl+rSmIv//TvYamEErrIk2FtK+ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642906; x=1716247706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=r0WcwK/erTj7+9ESU34ndBkgmJh6epSIHfa9vz8bHmUuOzmpzEvVqLC/+7NEbdcI6t
         qmbsQOpCxe0AFwFkbOaWzu206evO646BQ+HvS1ZjTO8hJmMcSVtASU2troa56odOYoFQ
         lGoNPFCDB48xI2assmMZSk3c6PWjWq/v11I/wNcwnNmL9X/UpYwd/LDvYiW3ANdGuMsJ
         Y9Y3RR95eRThpsXUV4WAWnk1vKCHbA7EZOhZ/pXfcfGECOcmn72uqBIoCzsK4iCIjx1B
         Lxm6+lasMUgyoKEB7ocgVsSaCkFGOoTof2mQwdPespqtKskKZK3qaqZcbDO5wYtIi3EG
         Ku9A==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZXFUjkTRaE5yAVIF7HaegtB7v1iVT5Wk80sf/cbN+BfpTOVzXPzxV4Ij/4XLo19VE9gMr6RU0UDqHJ5iFjUHpoqSlbcjxH855aQm
X-Gm-Message-State: AOJu0YzW/DTPx2pXDpg62YDeQW5bcxDzM01qI4jdFNw87DDiWxVJwQ5p
	+jGHEsJWeKnIZZtWQaXy5e1kmG0e415HGtZnRPQcFEl4zE30A65D+ZdbKTHJTg==
X-Google-Smtp-Source: AGHT+IEFgmE7chs18iM9GrKNc3YSJsTec4uS+kF7AHYYIMLhQ7Or1D9QN4CNuHbEiHbakVLBZ9zUHA==
X-Received: by 2002:a17:90a:bf08:b0:2b2:7c65:f050 with SMTP id 98e67ed59e1d1-2b65effb9d4mr20481677a91.0.1715642906269;
        Mon, 13 May 2024 16:28:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863cd9dsm10304270a91.12.2024.05.13.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:28:25 -0700 (PDT)
Date: Mon, 13 May 2024 16:28:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
Message-ID: <202405131626.D61F8228@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <202405131136.73E766AA8@keescook>
 <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>

On Tue, May 14, 2024 at 07:39:31AM +0900, Masahiro Yamada wrote:
> On Tue, May 14, 2024 at 3:48 AM Kees Cook <keescook@chromium.org> wrote:
> > I am worried about the use of "guess" and "most", though. :) Before, we
> > had some clear opt-out situations, and now it's more of a side-effect. I
> > think this is okay, but I'd really like to know more about your testing.
> 
> - defconfig for arc, hexagon, loongarch, microblaze, sh, xtensa
> - allmodconfig for the other architectures
> 
> (IIRC, allmodconfig failed for the first case, for reasons unrelated
> to this patch set, so I used defconfig instead.
> I do not remember what errors I observed)
> 
> I checked the diff of .*.cmd files.

Ah-ha, perfect! Thanks. :)

> > Did you find any cases where you found that instrumentation was _removed_
> > where not expected?
> 
> See the commit log of 1/3.

Okay, thanks. I wasn't sure if that was the complete set or just part of
the "most" bit. :)

Thanks! I think this should all be fine. I'm not aware of anything
melting down yet from these changes being in -next, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

