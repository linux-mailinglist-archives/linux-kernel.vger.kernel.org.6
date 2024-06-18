Return-Path: <linux-kernel+bounces-218631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934E90C2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B341C224EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEB13F457;
	Tue, 18 Jun 2024 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTZhNwLd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513501C01
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685431; cv=none; b=i9+h2cL7Db6OiLHHaxtvww77H7kKuWu4wkd0s0R5ebJynC6pBxppn9VEc0zS5TI8TRMcuG5uNKOe8EE153DAVkgvWKFWWKS73f892xpFCveVKm81fdkCnuK6nqatHrDf/9GE3H/dnts581HqoTiaEz+MmUj1IsO1AL6EjAeH2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685431; c=relaxed/simple;
	bh=MOZASWCbrjkS8VCqIVm+xGfojbhNX3KKEbZ1IKrgrVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPRm6LLWFHyvWkxeQywcUELuCJGhe5LZSFIICxG/EeDwMGYk/6zciVuLyJqqAKM5CyOChC6Co+6GPTpAp4aHMslXCKrbLaIr8uBABht4QgFqbOc+ReXD2CeruLCTlB4B4ZagYnnL7NnyHJjxGdgVqL+s/LOqDXcbFqVdoPQGtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTZhNwLd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f8395a530dso43343085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718685429; x=1719290229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLxn/FaS1NfZ76y2XTqVUqmdE7ncPRYcRbps9NHqKCg=;
        b=yTZhNwLd18KjXlZfYLqbHSYYg+xm9yYWAIuCumF0d+qwGcNDULqDIQ53EcfcSpAEG9
         G/hunRMVu4dJjT3UuKUd7vsWlgbEq+3CnWJ2mTJVcRxdnjSJkJkb7CW8pvpUkPMGYfYV
         g+ZpkU0FnR4QaVmusBXmo13tZDKeIgG7TExYEnvU9fZYj/UQ4M9+RJ7NHY1Yh0g3stIU
         zadc3/MKzcAbXDGMKWdNdF5AQl3TPR2UzuCOLybU7iljcnRbjv779aeMfhElUDI5dUUA
         8ILkN8eyZ9kROp5Cru1XFExQaIbVx9dqnj+UYC9utksjrG5V+un8eO3UbDQWSbwHqm99
         E69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718685429; x=1719290229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLxn/FaS1NfZ76y2XTqVUqmdE7ncPRYcRbps9NHqKCg=;
        b=UsaXfVZjNsW57w7B0Ak3jAW/7j69sYxQL2z+RksJ7q7HZa+LW7aC/EO3Hc/ZDsxLXh
         YW7sAnyqton5SdgLGifD4h2qtV4Opb7NQni5RqK2rj5grS2azfmNgRRm9mtJUYnh+C2c
         YjXwlzSp5Cc8sWvS5TsT7stN6oeLXZJ/x5DJGuYKAPjjerB/Uu1Q8pdxiLIac+LBmtkh
         1/2HNZUI+3yATzxx8gkzul1uonQNblvH8Frebh2vzvWwufnyzjr9Gt3TJ8qZaOvHpzzG
         rU+JoWc17YxR7lbv4ic1jX2RBEDrapWMwleB0Ox679o2+O36qBb2Xpe7xp/RkosELqRO
         ynAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHtBXBSiyahfl64h/pww+lcGb2qwPNHfsTPpsx9himJrCWXSDBirk+fkZssBOOcoh/aeZ941syoQ5XEwxv4SKg6H+flUSuUyRFg426
X-Gm-Message-State: AOJu0YwiouQ0faJAsocRHxjIM5U0+wHWI8sRdlN4Ny1LMJVijDJedyfp
	3qXL6KJXbmTJJ8P/ECLnHh579QcSKQLzouTmIwuCdFFBhArbSOX73iJEzRLwuQ==
X-Google-Smtp-Source: AGHT+IGKwqJt4Z+LyZ1OmorRgxysBJI4M6vh7JTnP6xd4SR7EQHoFD2PfSheqgOk910oFiT4DshMiA==
X-Received: by 2002:a17:902:f550:b0:1f9:9221:6c2d with SMTP id d9443c01a7336-1f992216ff8mr10367935ad.53.1718685429279;
        Mon, 17 Jun 2024 21:37:09 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f463f6sm87186515ad.281.2024.06.17.21.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 21:37:08 -0700 (PDT)
Date: Tue, 18 Jun 2024 04:37:05 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
Message-ID: <ZnEO8X-7pjeTFTur@google.com>
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com>
 <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
 <ZnCDvpFveS6X0a1g@google.com>
 <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>

On Tue, Jun 18, 2024 at 10:50:17AM +0800, Lei Liu wrote:
> 
> On 2024/6/18 2:43, Carlos Llamas wrote:
> > On Mon, Jun 17, 2024 at 12:01:26PM +0800, Lei Liu wrote:
> > > On 6/15/2024 at 2:38, Carlos Llamas wrote:
> > Yes, all this makes sense. What I don't understand is how "performance
> > of kvcalloc is better". This is not supposed to be.
> 
> Based on my current understanding:
> 1.kvmalloc may allocate memory faster than kmalloc in cases of memory
> fragmentation, which could potentially improve the performance of binder.

I think there is a misunderstanding of the allocations performed in this
benchmark test. Yes, in general when there is heavy memory pressure it
can be faster to use kvmalloc() and not try too hard to reclaim
contiguous memory.

In the case of binder though, this is the mmap() allocation. This call
is part of the "initial setup". In the test, there should only be two
calls to kvmalloc(), since the benchmark is done across two processes.
That's it.

So the time it takes to allocate this memory is irrelevant to the
performance results. Does this make sense?

> 2.Memory allocated by kvmalloc may not be contiguous, which could
> potentially degrade the data read and write speed of binder.

This _is_ what is being considered in the benchmark test instead. There
are repeated accesses to alloc->pages[n]. Your point is then the reason
why I was expecting "same performance at best".

> Hmm, this is really good news. From the current test results, it seems that
> kvmalloc does not degrade performance for binder.

Yeah, not in the "happy" case anyways. I'm not sure what the numbers
look like under some memory pressure.

> I will retest the data on our phone to see if we reach the same conclusion.
> If kvmalloc still proves to be better, we will provide you with the
> reproduction method.
> 
Ok, thanks. I would suggest you do an "adb shell stop" before running
these test. This might help with the noise.

Thanks,
Carlos Llamas

