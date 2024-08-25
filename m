Return-Path: <linux-kernel+bounces-300310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E456595E23B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B9E1C213E5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27DD374F6;
	Sun, 25 Aug 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjOHj++t"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB02B9A5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724567917; cv=none; b=rt6HOPwBLuP1RQDvYb0WUsnEnbRU+ctHarQSBaBWW53bDwnu2Uh0CsoyiefqBx37w06kUUAbczeo7C8L9OyJ7oeLKWYwKdKOeC35an2n1gqW4uokTshWuzubFfstZ43I8yBXIxoteczB5f/Ru+JrhB06Lz+4SzhDT0U/VjZK2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724567917; c=relaxed/simple;
	bh=L0K0COdIw9y4JHfFG4e6bM1X22MMmS3p4nJ+jNEHcTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abHQ7BNw6XndECtATvhvxb5pW8uocG4pGjMSR3ATXVWXRuOnkN96/H4C7OWOSs3hBIxATuaDt5EngOX7c2YZ+5h6psiNctMWsES/mb4JkHPNgUeuB/2TLDchq89FqYCjSELZ6TRlzC1tZALTdlNY28a0DxdiBemNdZsGsqlvHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjOHj++t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso2365821a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724567915; x=1725172715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnWipGSGRNUpxTH706hRTY90cJiU4b+kfr2jSKM5g/s=;
        b=NjOHj++tE/p69z1GD3STsdJ69KWlE1u0IW6KcMqJcDHuXkim+T5uEQVPNXtpOzo2x/
         7K7f7EFKe9ZzAkILBqMk1WbVAzCv4MOmbcXFHdbxKlCss3xgwGCMxJ4Pqmzo3Y6CEPCj
         beKSgjZuRRk7pv8ipx7/Or0PJa3uv6YC2pZL9bqsy6c4y3phm0fJICtC4qGBJCDDF/S+
         /NkqPu8Vbl7tYKyps3rD5yitwgpwbFBHxVUoYJM6TPoLX6MSDEe97kSE/7wjMuC5PzGi
         kf6fDpMnUhybE8NepobdGU0zlxvsMT7sUewCh0qGlbUQiXXYNNj2E9OxEkorTSjAalAo
         fy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724567915; x=1725172715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnWipGSGRNUpxTH706hRTY90cJiU4b+kfr2jSKM5g/s=;
        b=KA9tGXnivWK68OhzGguhNtUj25nIgjAmtfHeFZ6xKqG9pA9tkIT11XIgZXC+m9de9j
         ChcjSq36kbT9c6F4XpqIzKjiS5R+7k0Ac0GoIBhBOA7qLFztvEXP9qY2sgNK4mSNN/VF
         PZYKhTm6pRkDfAlUh2H573u+kzeAEenqSVfhRnLy+ZM84k/ECkELqdHnmsZ+F5F6KP3v
         Rw+sPsG7HK2S+KujV63TSAnHwdnqWpxaNcJSvII2pkqKXIeqsiv+SOX0K29aBNmkbYVn
         Ob8ut0OqbnjLVI2Puc7Fm+iuWnzDMfyTndJCCztybDaMuvwnK+OXEKLsP1FLJZl6QgE5
         cYqw==
X-Forwarded-Encrypted: i=1; AJvYcCUTjDg9P6kxaIm0r2vK+6x/EWtd8PTvYk5qdUpf1GAIOTenwc5vnx7Yd9F59FH6DOQJeSGnebnbhjDDaBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5Ol+uzLI/9WGS6Fzy34DkJhHICwYLxg5weRQz0/Bcd4Web3U
	kQhh0QvSzDniAgdxpgdWSKSSn1ABFLVZdTasPmJl9TGojQU007le
X-Google-Smtp-Source: AGHT+IETSpALFu2+A7eFzubBAgBvk/KzvFDhLlTmDgXtMQ3q7/INDCIeOJBXA4FjqYO6SRjgZntLJw==
X-Received: by 2002:a05:6a20:c793:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1cc89d80195mr7497177637.28.1724567914814;
        Sat, 24 Aug 2024 23:38:34 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560e3e8sm49676505ad.219.2024.08.24.23.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 23:38:34 -0700 (PDT)
Date: Sun, 25 Aug 2024 12:08:28 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] soc: ti: pruss: factor out memories setup
Message-ID: <ZsrRZLqgtegrbwO7@five231003>
References: <20240707055341.3656-1-five231003@gmail.com>
 <20240707055341.3656-2-five231003@gmail.com>
 <20240824184950.gzsgdawt2ujjt6ky@subgroup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824184950.gzsgdawt2ujjt6ky@subgroup>

On Sat, Aug 24, 2024 at 01:49:50PM -0500, Nishanth Menon wrote:
> On 10:44-20240707, Kousik Sanagavarapu wrote:
> > Factor out memories setup code from probe() into a new function
> > pruss_of_setup_memories().  This sets the stage for introducing auto
> > cleanup of the device node (done in the subsequent patch), since the
> > clean up depends on the scope of the pointer and factoring out
> > code into a seperate function obviously limits the scope of the various
> typo s/seperate/separate - use --codespell with checkpatch to catch :)
> 
> A follow on patch has the same problem as well.

Oh, yes should've used --codespell, my bad.  Thanks for spotting.

> > variables used in that function.

[...]

> > -	of_node_put(child);
> > +	ret = pruss_of_setup_memories(dev, pruss);
> > +	if (ret < 0)
> > +		goto rpm_put;
> 
> Why? We have not called pm_runtime_enable at this point.

Didn't catch this too, will change.

Thanks

