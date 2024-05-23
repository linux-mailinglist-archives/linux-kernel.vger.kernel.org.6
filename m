Return-Path: <linux-kernel+bounces-188121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B938CDDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23881B2260F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4D1292C2;
	Thu, 23 May 2024 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYAIR9C8"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D203BB21
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507150; cv=none; b=thGqr6RprOrNG4kDz1M+Lq2ydivRK9dLbZqUACyAXMI7yDF35oz47wKOmCtNLaNUsEHRof6pNHSjCwx9oamogw0XX5ntPwl/vaQ0/aRw0+G/DLv4+vJ+AagjLmfCU23fC6h9QmA9QIAZGFIuyNdvxGmvtWhb4+3YCzTHi8YsnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507150; c=relaxed/simple;
	bh=Rl78iHC2xR4eTLgM9pFhtSrNG+eYrSYtgxu8L4wWsfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZi4WkwfbkrWhHc5+q91VHp0lDeF9iWZSS5FcDr1PXfFfcty84NoN9CzORJSnckZ6Hjfb2weMQSgOBCBiuBftK6wCxFdmuuw9+sspRqHl/loKJZfUiLR+/g92Vq7ZWq1ln6ANtG9VvA54hig9pBtKgpX53STUOZROYjHKTzEsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DYAIR9C8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so151918a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716507148; x=1717111948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=DYAIR9C8W8spsie8Pc8vutCp2t+Jd2cRx0RdrITfImvTQVPr6GxPEYOGVED3WFHFNi
         ZMOROiAYQuReyR0EoAisvfbR2PESQXw/F5sye1MV6wcwJ793FpbG389fU8wEL6oBE9xP
         DmUvIGd3QQtMbsPTbBRe0VhVt2GFPRAlkstrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716507148; x=1717111948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=QZgUJWFI5NQkkelI9CFSnjV0G3HsnRWFT3EzjoRQkOslVM39DqNyyDQUedhhM4a6yF
         sxYgL26r522wortwz7m2pQ9Be4xLM4AB4THsdpntJ7//egH2P1CteXfLluqA14eJ8yN6
         f/vvnBQV7Hxoj4tr/Cqu8gO1K7/hbOAzZpsvCJXvNwsn4eTcLKK2mKClA1PfLWb+FyIz
         h/yB+s2k5N5aXHUAgi8vOg06aKzB3I6FiXslR3odhrVYcmr7JeLolNKw5eItd29Ip74c
         jYgsheTIrHPE4+yR+nD7Bi7ywMEfFBbCKeGsQzu3HAzLkeCKsUfxYfgucZDO+KEy8vNN
         o3GA==
X-Forwarded-Encrypted: i=1; AJvYcCWhcRQA4IlCFD3dvkwd1GuNq7sFvLPOlpPy14fgt4oH5BL+1BtIthXRcdmdQTobQTWB5Vpe0es1h8THMAiW2JiSoCH4nfUfl+3w6DYJ
X-Gm-Message-State: AOJu0YwAP5dWOaikiuRkizjIsMPMxmg8tsI5as+NJRl400C/6ezSFBPH
	H15U9ec5Xql3lJS713MptgylplI86jQA7Y6vwR4nwuRJPVoZGsYIsun4b9ohgQ==
X-Google-Smtp-Source: AGHT+IFOfvlBfPaN91h6KUnDd+S4/iEFS4mMZGfINsKu6kdcMCF6+DYoaaEjtaJjxvPHQzQQjzLQfw==
X-Received: by 2002:a17:90b:ec1:b0:2bd:d898:8732 with SMTP id 98e67ed59e1d1-2bddce8fa91mr5008761a91.13.1716507147992;
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f615b9fsm247043a91.34.2024.05.23.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Date: Thu, 23 May 2024 16:32:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <202405231628.BBBB9787F@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405141251.8E9580E@keescook>

On Tue, May 14, 2024 at 12:52:13PM -0700, Kees Cook wrote:
> On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> > 
> > > This patchset proposes a new mseal() syscall for the Linux kernel.
> > 
> > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > of the total lack of Reviewed-by:s and Acked-by:s.
> 
> Oh, I thought I had already reviewed it. FWIW, please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > The code appears to be stable enough for a merge.
> 
> Agreed.
> 
> > It's awkward that we're in conference this week, but I ask people to
> > give consideration to the desirability of moving mseal() into mainline
> > sometime over the next week, please.
> 
> Yes please. :)

Is the plan still to land this for 6.10? With the testing it's had in
-next and Liam's review, I think we're good to go?

Thanks!

-Kees

-- 
Kees Cook

