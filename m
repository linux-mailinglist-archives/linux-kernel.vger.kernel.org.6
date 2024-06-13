Return-Path: <linux-kernel+bounces-213530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B0907677
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D01C21EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728C149C6A;
	Thu, 13 Jun 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcb0NWMf"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979D13CF85;
	Thu, 13 Jun 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292163; cv=none; b=XCeSp5iYFO66TtLMavRLCLofjxT6muwkNMuqplLZdnuKT6Ms69EoFPMSVF7kZi1lcf44SA8jTRpF5fSVuWjQ1S/98FeDoUtPbSiiKNdoqiSGAHNlEhtc6LUHYcxwnQT+qyqcytVvRd+cnnjoMtmqJzjJ9UIN3tD8c7atag6GcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292163; c=relaxed/simple;
	bh=CEBQAjiRo/TKvvFGnyTMJIOZsXYkblZxmpcpwTGBhXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlt9yOQfEXGmp+c2K0FB8pifT118HeNp0X+uxXO53A3u89mqC98QJi0gvOVxMEQGzyWWsJ0PchMJlXm2Ze33o9uY2Wq1v4KY3dpGhzaXZfzn8KE/EP53ZHMAFTyKwa0jeRi/TmgMpg0eLthKBfQgeFwmh93+RlG5MZY4AFBbaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcb0NWMf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b0645351ebso4898806d6.2;
        Thu, 13 Jun 2024 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292160; x=1718896960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEBQAjiRo/TKvvFGnyTMJIOZsXYkblZxmpcpwTGBhXA=;
        b=Rcb0NWMfKEuufQrZOebllzYFwbQi1mq4rnb2Xf5Jpo73QYhXxolFXkVmHLAqyadCAv
         JrQ6Wo1QY/6/Gm2dCJ8NzLkdc2a80cklrESC9LXv3xgXZLEMOS+I/FjUvvHeBp78iZ8n
         AWBOJZ+4GhF3hltUR05aCY16FP9awAoBAU1KeE7XKWUVWHbu+mWwkF5rGDTAPmq0dUV8
         eh4X5oRYqZribmXDf27sBZ+bxiKkmnjqt2XfugSL0nNBFPfnR8KzhSnqC5JTi3bkHe26
         S3tZpnY/rdcStyW//IdIufQQ+6ueti22M7FnSgeSUOdns2sMMlyCNfpehvcAkyDsI8Q9
         kLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292160; x=1718896960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEBQAjiRo/TKvvFGnyTMJIOZsXYkblZxmpcpwTGBhXA=;
        b=dGPmLpjERlrabz5qVjWwi6aoZg5Gw7izWOk00KBcX8HygR3iy+pejgteJjt14pGRHj
         EaGdh3jNUEW6qG0a9ynbGOUMeuK2gYlXlBtiPWY62A39pFuAB4iWmF9HW6jMQOEjvJf0
         XDgLrx4nvD0Ihzsvv5antzcGbC50hQxXdBTaLL52D9qkgB48zPmaWF+pnfdABDBiygyx
         B+mG4s8ZwhzDykwaiwxruyh3zx44Yg4X5KCaui7solhr0TI8bcHl8KGwRxTjH7aLLsVT
         +eYqH+v9Q7gchG0tFBRQDhi68cA7nCgnZ2go7xStI7zIAz/EQ+mSpVNYMV878pN+uG1g
         H81Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBZR8/IGSHHJvcMGM7iquy0T71+WDQ5bsUc/juu2i+7TNfdORNCTc42LFznfcRBWpfPqPOU0WUIdKeEr38UzxTHUwq+gW+ese5Kd5xZAbNGTvAVI44uRrg2OrTA/fM0mXStPY7w2j9
X-Gm-Message-State: AOJu0YyKQqQWjilKxwX8ZTHYjk3Luh2Z2qkgTkuDBlu5CcrFIGcGd2V0
	7r39KQEe9oGkf4+eGYRlFmAtRWpeytg58EIKfE2NKkTaLjzc2oPUY8TZqGOEMgD4t7SCw0Wq85i
	YVm6VwEdOlriWnLG9JVWE/PSyvsc=
X-Google-Smtp-Source: AGHT+IE/ygyf7skvdyjkp6u4fVTWMS18X5hrk9EBnRVC2RpU6E2VcfVM8UNh2Vt8DEvottgUjiUNHsyu6mKzeEDUlsM=
X-Received: by 2002:a05:6214:320f:b0:6b0:82cc:5e7a with SMTP id
 6a1803df08f44-6b192028b71mr52266956d6.21.1718292160516; Thu, 13 Jun 2024
 08:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-1-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 13 Jun 2024 08:22:29 -0700
Message-ID: <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This series addresses two issues and introduces a minor improvement in
> zswap global shrinker:
>
> 1. Fix the memcg iteration logic that breaks iteration on offline memcgs.
> 2. Fix the error path that aborts on expected error codes.
> 3. Add proactive shrinking at 91% full, for 90% accept threshold.
>

Taking a step back from the correctness conversation, could you
include in the changelog of the patches and cover letter a realistic
scenario, along with user space-visible metrics that show (ideally all
4, but at least some of the following):

1. A user problem (that affects performance, or usability, etc.) is happeni=
ng.

2. The root cause is what we are trying to fix (for e.g in patch 1, we
are skipping over memcgs unnecessarily in the global shrinker loop).

3. The fix alleviates the root cause in b)

4. The userspace-visible problem goes away or is less serious.

I have already hinted in a previous response, but global shrinker is
rarely triggered in production. There are lots of factors that would
prevent this from triggering:

1. Max zswap pool size 20% of memory by default, which is a lot.

2. Swapfile size also limits the size of the amount of data storable
in the zswap pool.

3. Other cgroup constraints (memory.max, memory.zswap.max,
memory.swap.max) also limit a cgroup's zswap usage.

I do agree that patch 1 at least is fixing a problem, and probably
patch 2 too but please justify why we are investing in the extra
complexity to fix this problem in the first place.

