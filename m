Return-Path: <linux-kernel+bounces-385540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFC9B3859
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3E1F22640
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83F1DF72C;
	Mon, 28 Oct 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAq1g8gG"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7521106
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138228; cv=none; b=dYJwNkhBhSSGCFEkK8PI/SxamWshIABmIvMbDuxo0G72A9JMn4wtO6iA17VPMkGHo+gc16o4Is+ihX+of2jGI50K0IuqJ5pYkYMJd18zI4Gj+KGzVNXbMpXvTWe+WZjLKR0SRG2YJ0Wt3nFETzewmX8PFqmdLRKW3V6sPoYH5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138228; c=relaxed/simple;
	bh=g3zxeUg/wZDevd68ih3Hkdpq/NibJAE2rKxauOR7fqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIu9ebnrNV7itBJ4ZO4EJS8rqt2n717dv+Nvs6Oq+DOG2/M0sT81GCUx0DU1CNFs//K6JYXUiMs6aAlgPNg/71gWcebUf7K47VUTOefxioJSQ/ZGtJxjNbHCXTG7zLUpm5EbFJ7ScBE6q4vOoiDw0ZmcT1W/+Kif9tZWfX7eHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAq1g8gG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b295b9eeso21241cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730138225; x=1730743025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/nsSFIy+qJ7o4UcFYDIPicrJic8x+BDC5h1izOxqQU=;
        b=VAq1g8gGtgX61wQL+iKY2jp9BgJe140oWIShYCXEOQ0rLQTu/TPSL8nzalXafFzFSa
         cwKm0XBMxzqvtlG3LPcLXEt7Y9j2nMu3uhtF3iox2lZf3NgRN8Jvn0QJDxuZ+t76Eh23
         o4/7pKt/fz9MsZgzWRk+5AyEJkYudO+9p+XNA6tFEViD8VfdsiPi6ni52/CqxIOSfDf3
         Ga5OZY04hecmEnMue+KByCpiOn2lqr1vGp1xOwhS4HR4+0VXGm4O1Ln3BnHpf2XLh1t8
         lIHz86tdRjDx9TOWWU5qGupOhBfbZL2LGU/P72gdU78AY15F/RHqNmOnXMnUIHpodzKx
         jEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138225; x=1730743025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/nsSFIy+qJ7o4UcFYDIPicrJic8x+BDC5h1izOxqQU=;
        b=PpNzd0PFl1RsJn4Ag+FQO4Te7+uGHaGK0bMhVwPP89tpRUud4fm2UqBBINxEbDWVyH
         cwfaoXGfCbhRjvvwP5f1WJ9WCRAXHjeOG6BM5sR5xhm+5Z1HCmOH6sguWThRhtcfpcmn
         gWW1jGxZt1GIAXo23m6aKFpnIP2hpiZ7e4VVKand7/V/csiA51aDtZ0ocaQXJu1oJf51
         C3ItKa4ksLmO39YXp9JrRX/USHqR2OAOUliDB1lH7XnJ12y09kV56AfhQOAaHM6TmyTb
         /tpO85wzgUSfPR8iIc9Si9IVPLHzARI39j0zKW4dZpkUuT/+wVn062A3Qlboy6MbqA6i
         w2YA==
X-Forwarded-Encrypted: i=1; AJvYcCVTfVnAQta01fbSWiiCyfCY+YtQjqYQbTVVDZg73whOcOR4+YbcJ/P+eduvNLOg1dZJNNu+3PP1sTkRVBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIvJYkeTTvW0BQPmCcPz94kXKS3R7wQUEvoowTtHM8tj9nMND
	IlzSzL6rPpsjLhq9Q7AMp4OyUzFYQ7igD/NsJMV2gzz/Eb1LWa3AJbQMdqclOw==
X-Google-Smtp-Source: AGHT+IFHlJ3fxEgJQ8QNnM9KAQ9ORqdakOxYXgNIh7L7mbuosHipOtj6Wny2mRuq1uyzkC1rqKw2gA==
X-Received: by 2002:ac8:7d04:0:b0:45f:997:4e5a with SMTP id d75a77b69052e-46165141734mr64771cf.11.1730138225091;
        Mon, 28 Oct 2024 10:57:05 -0700 (PDT)
Received: from google.com (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991ba83sm34213266d6.62.2024.10.28.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:57:04 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:57:02 -0400
From: Brian Geffon <bgeffon@google.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] zram: clear IDLE flag in mark_idle()
Message-ID: <Zx_QblcMMLznXd4P@google.com>
References: <20241028153629.1479791-1-senozhatsky@chromium.org>
 <20241028153629.1479791-3-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028153629.1479791-3-senozhatsky@chromium.org>

On Tue, Oct 29, 2024 at 12:36:15AM +0900, Sergey Senozhatsky wrote:
> If entry does not fulfill current mark_idle() parameters, e.g.
> cutoff time, then we should clear its ZRAM_IDLE from previous
> mark_idle() invocations.
> 
> Consider the following case:
> - mark_idle() cutoff time 8h
> - mark_idle() cutoff time 4h
> - writeback() idle - will writeback entries with cutoff time 8h,
>   while it should only pick entries with cutoff time 4h
> 
> The bug was reported by Shin Kawamura.
Reported-by: Shin Kawamura <kawasin@google.com>

> 
> Fixes: 755804d16965 ("zram: introduce an aged idle interface")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a16dbffcdca3..cee49bb0126d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
>  #endif
>  		if (is_idle)
>  			zram_set_flag(zram, index, ZRAM_IDLE);
> +		else
> +			zram_clear_flag(zram, index, ZRAM_IDLE);
>  		zram_slot_unlock(zram, index);
>  	}
>  }
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

