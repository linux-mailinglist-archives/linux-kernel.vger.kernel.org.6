Return-Path: <linux-kernel+bounces-537790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F92A490DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A523B6B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C61A4F22;
	Fri, 28 Feb 2025 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM7TKk/6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C551BCA0C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720267; cv=none; b=H+6V66j/mHdHhkeehDkBbMZw2gvUz4zPp73BiPI4KOQJDSj31o/K61Rx7yo+ov4FphgDQCGKhEreVkt19JMrYEK83PQFZnGt7fy/lzOTmJHL1PTW1NsDdoe84Cbr55nvFo1DOP0xYkFTfKJwh2TBpJgBNp1QX6UUlzLdGohe2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720267; c=relaxed/simple;
	bh=x9cRC7ppLMjJrTR1Lidy22LGkBVHgDO8qtmxXgLJn4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdjIJtuJlleyaC2bDkKQm3ZXrBep83Ky9k1tkYj9zfnxk/JkKoKKVIpgDJzWhXTlVlgub5zO/1G4FeX+gZdDRA570Yu68da/rQUVKGedNuStCO/P2BueixwLrVESu+xyLlUO8UsS6QJiY1BRWqLcz4FOatoSswHdCDioc8UcOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dM7TKk/6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234e5347e2so35074355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740720265; x=1741325065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzpLqfQwDJ7jyiE79QfQ/fOYIxdjWxJGEJ/bicFu6Ck=;
        b=dM7TKk/6Id+qDj7FFPz4lMyCH1uIcIO8NC//1ed5QIN+xtSSPYVsbWWBxwZaL/DDgI
         evofiBMlwSn9Unr/XJgqQPysLdEBY+AUg/7dscjAe4Csy8albxh1ijzJ28OPdkzMSyy6
         aCMe5CEH8Ag7+H0wOZhX6imT70NwVK7qwIvV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740720265; x=1741325065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzpLqfQwDJ7jyiE79QfQ/fOYIxdjWxJGEJ/bicFu6Ck=;
        b=JGGA0NWCuHEXIotIDZxxwtKPwJi5kZwKeselnVTPdP0qSaoYek3Yq9hKk0ir9UE/v1
         D6ADM/yzX7aTjaj4pdebNoQ3w44iFDSMI7zVbBPYLcoQIVDgpQhiygpPd8k54lzx8231
         hHfBnti5jt5g+9WypD3TePx59ajzXafouQY+ew6aIObAwilU4tWTcr1kPnmTzv75zGc9
         +oIliRjWtL16aVGw+ncI9Co+jJo4AcsyWc/jWrDsjSIApvA7SK+LosCnPwMTJ1R9Ss/K
         WfK7ZDl5692GBg7321e5FXCGKqVmYlxs56cew5KVToOplkvOn/960ipE6y2w5OZss3I4
         at7g==
X-Forwarded-Encrypted: i=1; AJvYcCWBuSApddOvv5NXMreVHkZBxy/inyePY0EwLoHKeBu+z+LLZMftoWlLPGIhQwAkrShJcNrdPPM6e7SmOm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxje0tlrSqlY4KBwHZFbWK1bq0rvfHuM4ciYt99iE7gCZUfe9DE
	8K5Ph5u3ihpJaXfe6Stxp0lr19xHoE636jVFRRnR0hGmSvHdoSvLXbh0ZMMJQg==
X-Gm-Gg: ASbGncsvsMj4MbedDAkRTzVTcPncPghoPFxCo/IEhzt+f4WeA5fCicYW3k3hpFqb/9f
	ca6KD3c7a6dsEQxYMwC33vE+D5D4ybRVr+kquJvNliiAvR2s+B+4UYFFtCgiBHysF1PW8Ac7rQF
	GSj5XJ8GpG2foPTDE0Jty1gC6mmgqx116N5ax/oifNH+z+FHlMSKzWNt4bN0ll/T99XoyGnIDwo
	/apHoLW6Pj2oUQZ1KfALVXwofFJSyPX+4aG5FsJ0eGe4myEA/EvtldkM55KJufnanobNARsJOzH
	c+lgPUyDrjKT4Ixu2gmNtnhDxk9sEw==
X-Google-Smtp-Source: AGHT+IHXCM2oCqgzhkwLo+956UUpwtag8tM8m0CdPHYgDQClhrhMVkzcGgl7jqpntegvZ/SQHl9AeQ==
X-Received: by 2002:a17:902:ea0c:b0:223:54aa:6d15 with SMTP id d9443c01a7336-22368f7b08fmr34672055ad.12.1740720265138;
        Thu, 27 Feb 2025 21:24:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:cd50:81fd:f0a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2823sm25189645ad.15.2025.02.27.21.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:24:24 -0800 (PST)
Date: Fri, 28 Feb 2025 14:24:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Sterba <dsterba@suse.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Nitin Gupta <nitingupta910@gmail.com>, Richard Purdie <rpurdie@openedhand.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Markus F.X.J. Oberhumer" <markus@oberhumer.com>, 
	Dave Rodgman <dave.rodgman@arm.com>
Subject: Re: [PATCH] lib/lzo: Avoid output overruns when compressing
Message-ID: <qahmi4ozfatd4q5h4qiykinucdry6jcbee6eg4rzelyge2zmlg@norwskwechx6>
References: <Z7rGXJSX57gEfXPw@gondor.apana.org.au>
 <20250226130037.GS5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226130037.GS5777@twin.jikos.cz>

On (25/02/26 14:00), David Sterba wrote:
> What strikes me as alarming that you insert about 20 branches into a
> realtime compression algorithm, where everything is basically a hot
> path.  Branches that almost never happen, and never if the output buffer
> is big enough.
> 
> Please drop the patch.

David, just for educational purposes, there's only safe variant of lzo
decompression, which seems to be doing a lot of NEED_OP (HAVE_OP) adding
branches and so on, basically what Herbert is adding to the compression
path.  So my question is - why NEED_OP (if (!HAVE_OP(x)) goto output_overrun)
is a no go for compression, but appears to be fine for decompression?

