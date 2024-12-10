Return-Path: <linux-kernel+bounces-439024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17849EA9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74EC166BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406322F390;
	Tue, 10 Dec 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRqnfbs6"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E922F3AA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815737; cv=none; b=WoaUv9e3tJXmeHDLCQf42wHuhVYFVIWmgvpWDDqhXdJ0fv+V+atHrkHyR5L0UBPJPj+oVj6Sk4AVzyJdJpmYTSaguwO39CTnb+J6w2mNAHDf6fT0wtjOJ2O8VroF/Y8froedmNXfpi1FWsAimOSwTXuiR7nZATCBPlwQqSzruC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815737; c=relaxed/simple;
	bh=jcBjzE6y4SuGYTvQrZw6rDbaF2EAFAUFjnWErKsWp2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS9SKGUt0+sAWp5no1aRHaVNZGX85ATR08XEySrHt8/7mxE8hMheezQnx+YSuek3B7iTnJT8GkaM/SPCoipOm73VyWWiUv6AMLEleK63b8SrgQUj/Hdy0O+54TYkvMKJfG3gI0T5M+CEzR0n3uDVg39p1hsBWWr6TfFPj2gY0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRqnfbs6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e8aa84f7so26343685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733815734; x=1734420534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4JB1lq6UZAc6HCGowqpxl9Kk5HX97ITZ41Bl06+0/o=;
        b=BRqnfbs6f9fz4YDCWL/qdpQePZtiy1oneA/ThGh2qeM3juk2nG/Qx4K64zu4tGlpQH
         DahNaTbPggMfSMsbmET+i9fbehOzo7pZuel2BTuIcYt5HcHftkqwmd5G4ebrjWi6kttb
         ypNhBudiyhYK0X0NvuDLgvLMngwOY4xvcWb48e+HbiLGAq85ApkvtdYl8HLDuFRD5phn
         L5UTWFUxsikZByqf6gzwrr0HwAnEMC4gvIzyWJ+A6B2wUI6XogP8AO3SeSJv4GdDNcVH
         S02I6njBSS8uSNfQPct2UZpKbNKVC1jBLWsFBLw0oj/UGhv9IXpgkxS/BaXFfNPvBaOd
         MGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815734; x=1734420534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4JB1lq6UZAc6HCGowqpxl9Kk5HX97ITZ41Bl06+0/o=;
        b=ZHghlkZm10k7BiEKkQ4PpC8IPN3EuO8zC57SxI3YFZIXSSzR+1KLYh8cssr6vVo7wG
         40HtFsSGV6P2mqG5bEt0OgAAmuWx5Kh/yvLJ1aPC4y3ZYbLlUSNTRvjxYEBayNpMurD7
         DhSe8fWdUKFdLkmKXQIqz95Xw0AyW3/sl4XBRkM6D8ZvmyzoDLYj7wZhi7pBoleaxdL6
         TCygxqVs17tylgQqBxg4HeoWYy1cQ4/8IPAOezCv/69xiq0Q/7fcTY5SgKMNs11/oxbo
         H8z3WOjT+A+UKGcms67GoMyD5G0+e21ASPa/MSun4CAAisw05qLEw3dobkD9mBjbjKPv
         +9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWtgh7FbNAN1WKaGsBo2p/QHXs4jyFXO+GyM15Wtc4rjM06vPVsq+VvsYiKNYLGWJ707aBrG2xYP/NTOJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3Mn/XYFraraFzdqKxDWE/dSNW4VeotTjZgWK440UjlF4YE+c
	qCJ45W3LDYUiG7VLfCniz2iPXBP/dRGiB6KKEJ0zOI66yM5XB8UzTtD1zyR69pI=
X-Gm-Gg: ASbGnct3flUzWDzhYQ+iaCzaLRJyRJ7Myxy7jhmUG1nsEHhkgoHrAvVmkwUyiBFRq92
	83Xnujr9zx+UpRMsjucqU0GH7NKifmV0DZtdmDy7XSTtyBIsOzn8EY6O8ouOX5DMB7i/BzgInLV
	y3vzaDPZ4LLDNNS7t8/qptcP+zKAmf7kqO5wd2NTqJinhGV0lwCpaG42yQh/5Oo4ZU3GbIgPXeW
	ibdf9FSEAOPFkRm48VexIu4syXBSpHG/aIuB60ky7RU7ASsTVGdVDGCOXM=
X-Google-Smtp-Source: AGHT+IErBp3nB27t8Idia9cetAVpCVdYB5xJ411doFQHPuwsK44xALnFKbTnOl7EG470VnVrE5IKHQ==
X-Received: by 2002:a05:600c:4f02:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-434fff3d8f5mr29019345e9.14.1733815734174;
        Mon, 09 Dec 2024 23:28:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd42sm216710555e9.38.2024.12.09.23.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:28:53 -0800 (PST)
Date: Tue, 10 Dec 2024 10:28:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8723bs: remove code depending on cflag
Message-ID: <21d2d3f7-c94a-454b-92b4-2eb6a4be6ce9@stanley.mountain>
References: <42d24db0-b403-4c4b-8607-38f3cd55cf63@stanley.mountain>
 <20241209213528.5917-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209213528.5917-1-rodrigo.gobbi.7@gmail.com>

On Mon, Dec 09, 2024 at 06:33:36PM -0300, Rodrigo Gobbi wrote:
> > The commit message should answer any kind of reasonable questions
> > a review is probably going to ask but it doesn't give any information on
> > this.
> 
> I'll try to improve this for future patches, tks for pointing that out.
> 
> > This commit would easier to review if it were broken up in a different
> > way.
> 
> Ok, in that way, a patch series is the best approach here, right?

I'm not your boss, right?  And I can't tell you what to do and what I'm
suggesting is more work.  If you just want to send patch 1 from the
series instead of all three patches, that's fine.  No one is going to
be annoyed by that.

In patch 1, you would only delete code which is obviously surrounded
by #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA so the case statement would
look like:

	case HAL_DEF_DBG_RX_INFO_DUMP:
		break;

It's basically the same as what you wrote but slightly smaller and
easier to review.  But yeah, we're not going to merge this as-is.

> Despite the changes in the series being dependent on each other in this case.

Yep.  Patchsets are generally dependent on each other.  The rule is that
each patch has to make sense on its own.  You can't break the build.  But
they work on top of each other and they're applied in order.

regards,
dan carpenter

