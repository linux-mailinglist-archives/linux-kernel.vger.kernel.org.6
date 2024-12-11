Return-Path: <linux-kernel+bounces-441587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4309ED06C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CF81885FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE951D9A6F;
	Wed, 11 Dec 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3pTggp2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBA1D61BB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932153; cv=none; b=MEStkSYqAbE0fzpoBbkVxeEDw7B6q7KqIAL+vI069UCwELI2TNwx1uJhkMphzOejBQVFobll1T00GcggeRCa7xeIsDsvKmQMBsuaeImDheo7FRqn/0eTmlP4xrDBf+H3zusxT3DXRSxVvdWUZytnbjHli+3fV2XI2UzOCSjX44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932153; c=relaxed/simple;
	bh=J38ibBNH3Aw6lYafA9TGz9uhaMK3mS6IigwLX9amwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzZTiVEzhLZp8sZLY62Qx90RCk6lzWb/e2UkM6t4GU4xXPHy4PTFdZ9dwX1/ydBnDCv1UZKZrWZBwoj1UMykCTKFHTGhq15mLa9u4HIlfMW5hpiOrDU10dXBKBWgaecUFfy+80QaWSMp8o+wWs2NIUrWXB4vPEWtyhiQPCaTAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3pTggp2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso9188725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733932150; x=1734536950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfBv9YP8uyTkbd048cu0wiwdrnwl82wTzZ/vbZn1Plg=;
        b=c3pTggp2Xs/U+kezgNAyKUczbfPw0tUbAoVPukVmqBmTiWgfn4bh1grEGyBQB9DxKt
         fSrI3Tu+OlIpjOCmiREEZBwuL6yLfXAmVJju4J+dBKThpv/RoTwd9gkHEVYnPF5aratv
         KRynGqGnbqD02jhqhMR7DtwmUJOEtQe3V0lwUK3kjY88T9/7R7o6v+4tvgIWa97X69Yx
         d1+/eXGpnhWs8xWjXKNCbgVeI0LNJymIUhmlPVjZ78Jw+q3BZ0X42OfQXZsvSosESbsl
         HrOKSDo+/vrGrm+b3/8K8n63GRB/19vvZze0kqPwTtaJKQLjETYrCHKJ3ShPgl1ZTFJV
         k+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932150; x=1734536950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfBv9YP8uyTkbd048cu0wiwdrnwl82wTzZ/vbZn1Plg=;
        b=JbWaMrdLPgycGzAcJmQN/mYVOyqhvF2yqYB9YRhQc6XPFqjZF57AwIdTN50n9OKuAp
         Ws8Ttfrmd5xN/q4+lVdnmo/TmLdjISoz+RkJNphkOE/GiKtL6vjW1MZc+TtOpYchpNlu
         ghZ5BX7ciKl5duV76aA3YP6YSG1OeB9OGinNa4Gq2LJJiqootyz+kFbWK2+WIeD+ZCQt
         ELYpNQcuqj08XH9+MkOJC8hXCnB3YZiaRTYrzizQ53PxY6CT2QbrTnnuqJwC/0n95vxZ
         1/ujeL1QCt37/lYLx60L2xRHxYtBHt6K1pREBZqo5nigLfGh4jYpGoyQBYP4YWtW8qm5
         C7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWW18sJRIKKcRIlujQZtYAk6TQLU8jeN2XfOMI8egsOumt23q8bzMFtbpbFXlk3N01WKhMIFFva/DYnIW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxujGpH8+NxCHEfQWhRpgPG6SKubUkT00/VqFpMpceqsrXsot
	Tb+IaJLuGjsD2CmeNwvSA/VFCnFrxQhXRTIW0/rzHzSkNZ5EBEs9zi9P7ajacDs=
X-Gm-Gg: ASbGncuw3Zr4NOfy0ZJlxcE1REMeM8VrgoTeJK8u0JBRwQq+hVtEAjeiSId+KIiVcTo
	w9Qf+kj8sKMgAe8fuWjAW1sf+H9cCl7njok+/TiUgPGgaUPzqIvCjEPahTXM0jPA56j5CbkH+hn
	mXCPw5Ro7gUb40pbIQooDldtpFwHjSycGyY9ea4DoU3JsIs+NV34MLw/4ER1SE7nVN8A8KTaYDV
	F4u5o0weYrn2gYh1/+N8aPHlUFON1M3AqTZhQTqpwmcnrhK1F4j1VrvW6A=
X-Google-Smtp-Source: AGHT+IHgVguIQX7zRdkeSiogpetBA09LUoU9WaRTxjvY87GzH77emXIzHenGyofWFwiTSdXlRShTKQ==
X-Received: by 2002:a05:6000:401f:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-38787688392mr90463f8f.1.1733932150243;
        Wed, 11 Dec 2024 07:49:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ea3sm1550192f8f.28.2024.12.11.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:49:09 -0800 (PST)
Date: Wed, 11 Dec 2024 18:49:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
Message-ID: <6b363719-0250-48c1-9d89-0d4ae86accf8@stanley.mountain>
References: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
 <7e01a62a5cb4435198f13be27c19de26@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e01a62a5cb4435198f13be27c19de26@AcuMS.aculab.com>

On Wed, Dec 11, 2024 at 02:27:06PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 11 December 2024 13:17
> > 
> > We recently added some build time asserts to detect incorrect calls to
> > clamp and it detected this bug which breaks the build.  The variable
> > in this clamp is "max_avail" and it should be the first argument.  The
> > code currently is the equivalent to max = max(max_avail, max).
> 
> The fix is correct but the description above is wrong.

Aw yes, it's max = min(max_avail, max);  I'll resend.

regards,
dan carpenter


