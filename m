Return-Path: <linux-kernel+bounces-550463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599CA55FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD4D3B2F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C418F2D8;
	Fri,  7 Mar 2025 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FI3pqg92"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D538DEC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741324770; cv=none; b=K/CNc/EMzNMyCYPML0t3V6ECZqQNwW16kv8GzErhr+DhYPJyKKlf2a0a3lNxWsGxJHN/0fSGFnHzvMHYOgzjOxZGO1Il7o8f9Fu8b0KKQbQwCJ84KQlivadodMREnE/hMX4q0eGmyqEJOCbmx34tX7JXsxiteA6/RzKNeT7od+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741324770; c=relaxed/simple;
	bh=+yfUInVGZhvSftAgEE0MPjjNDi5oktc9c3EwQqGlVYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3Lkl0+r3r9d+nvPBgfheF4hmvvnpl9XIaBIjfHiARE4mB7NMo2OSbuuSGKlm81ebVw1XRFIS47hvNBr20eSM1+YISEunEnOTNmRXHzTZwOocYBkjITU1Gujv+XY3q4uywKNV7TvJamy921aKJHr5HF3Yz67kn8FcdzbgWGBIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FI3pqg92; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349dc31bcso26242805ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 21:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741324769; x=1741929569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I41lBq1Kk3lA1enOkQsq9Bf6kp48L0kLMkvHsbpE3h8=;
        b=FI3pqg92lvWvwP31U4c8v2obbeCz4w5rn47Ne4f5KXCsuqW/QauTptoIPhvnjGZyct
         eeTJk7ncLb1mnj1jlI6c6WEsKjeK843Z76mHztVaMFqkn1ykCLu87S+k4sNAzAto6H7T
         Rx3K5lV23SkymjtnS4F3fWMz3XiRK/EQisyZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741324769; x=1741929569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I41lBq1Kk3lA1enOkQsq9Bf6kp48L0kLMkvHsbpE3h8=;
        b=GSjV5MQu1J/9KVQ6dZXDb7QLkAaUCN3y1qP3Sq3QQanaJempIerjv9YSQvoopFkMg8
         uSUsdHwCgEp/CTpRGXeRIBLP4abysN4OZiiRpyOVsUCk4/5YhNYmPj/zSfyBE35Ge+rQ
         Z3DLtj00kG/XiMJybO0GRd484Hy6H+KHWHIj1UazfqAqk0iH1/0W30+CilU6l5IQ7PD3
         VlsxwIMjrPlykejsdfc9cgIPb05e1H280HrED/nHLMNSniuE4FVczp89I78kBZLijsMY
         j+SOV+zlQ5uANUQr78ny6p72WvaNIsM70eQcGE6BIkbyUhGnPkvKMD+epV8li1nsiLPh
         4XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxDwRNq0iSK3jb7qF/SahzAcf0KSv+DlpdDkvG5Pe3sh3mQfcLjlAn2p1hMLMiCrA8qeQxOBn9p/qlwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIxpQkKNtJ8czWh9GZMnN8e3PWwOAn81uM/CCTq8obzV7r6wY
	c0x6ofojcyMr+EaUchM35vECE24B9pVEoaPHg/bCpSDacS3yqCLNF/1IjWqiDQ==
X-Gm-Gg: ASbGncstSEu8qDmykaVIiOwYoHikOA+4nSuw0dO6ERTVujL2SoBChVHPJWKbVRk2tvk
	9/9XCg33zWfJwQyWyBGsWxyo30/WVKVXMpCMBsQXfLaPiNnD7UnCySDt3Tr28wdXl2zHefSjHrN
	dtLYDlAkIal+FiZv06dY7dfS8EuuDV1v9xT2qa2shQiPO8uSt5AVgqZl9JaerrmELMX/r3tbagG
	tTM0d38TvcmgzYI3UsEUGwxK9bqB6UlsFvm2eLmdJ+nO5/gi+tvqrb8a2oFZhxDmlFs3WvoJtnr
	3jxp1XFvRzl/sBqHwASP1r9BYuLSuiPtHkJbZPFCjky8hao=
X-Google-Smtp-Source: AGHT+IF16s9ouPXqgk3zQFipS55nSpIxZDxUa+HP2BQJAI1twAJk6NEzN/hQ637L6tb+s8Xpn5Z/vA==
X-Received: by 2002:a17:902:f68a:b0:224:78e:4ebe with SMTP id d9443c01a7336-22428ac90b1mr26083455ad.33.1741324768746;
        Thu, 06 Mar 2025 21:19:28 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:47b5:912a:f34:d434])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91bd2sm21291115ad.193.2025.03.06.21.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:19:28 -0800 (PST)
Date: Fri, 7 Mar 2025 14:19:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <6nuc6oijrfn3aejkzr74vuzipijuyodgqc56y526sv6d75kiwk@mmxi65rmj3yn>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
 <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
 <Z8kiRym1hS9fB2mE@gondor.apana.org.au>
 <Z8nTa1yut6I0RS0a@google.com>
 <Z8pcQdB4HA9ulyE9@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pcQdB4HA9ulyE9@gondor.apana.org.au>

On (25/03/07 10:38), Herbert Xu wrote:
> On Thu, Mar 06, 2025 at 04:55:07PM +0000, Yosry Ahmed wrote:
> >
> > The zswap and zsmalloc look good and the code is simpler. I am fine with
> > this approach if Sergey is fine with it, although I wonder if we should
> > update Sergey's patches in mm-unstable do this directly. Currently we
> > are switching from mapping APIs to read/write APIs, and then quickly to
> > the pinning APIs. The history will be confusing.
> > 
> > Sergey, do you prefer if we keep things as-is, or if you update your
> > series to incorporate Herbert's changes for zsmalloc/zram, then I can
> > update my series to incorporate the changes in zswap?
> > 
> > We can also combine the series into a single updated one with
> > zsmalloc/zram/zswap changes.
> > 
> > Let me know what you prefer.
> 
> This patch is only illustrating what zswap would look like once we
> move to an SG-based interface.  So I'm not actually submitting it
> for inclusion at this time.

Ah, OK, that's good to know, I was also a bit puzzled.
Perhaps next time we can label such patches as "POC" or
something.

> Sergey has volunteed to add parameter support to acomp.  Let's
> wait for that before making these changes to zsmalloc/zswap.

Yup, I'll keep you posted (once I have something.)

