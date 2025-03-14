Return-Path: <linux-kernel+bounces-561061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83011A60D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2573B302D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7C1DE4D6;
	Fri, 14 Mar 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBGuYlJ0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD01EDA17
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944122; cv=none; b=V1MttnYzpL06zH/lMeqcC2lCpm/hm5TWy+gSshmNQbAtWadGYrk5InBHmYj5f8U/yQ6JnOhumMB+a3EhpteI9GnEZ8q90S1UseuC8FsHgcySDn4RJ3toED/EoMCxPqrDtMDrs6q49ON2WIIO3Yq5bnO6n1HjnRV4C+HVvxVP7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944122; c=relaxed/simple;
	bh=WzAIVsamvsqiiRqt4lty9wTGIar3adKdVJo/UWq6ZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwhLXFpWna0TBRaJ2PY41K4DsEYEr8lKN0gFNCPD0B4L4NKSnsD9C4/xOogx8XI3uJfnt9xqhBYPuJT96yxfTmczNMbViRO9sea6G1KGY6q4VifMov6e3lbZlqBwahhQ+4dWmu7UB18qXwb52dU8sc0dkxLY1Gs/sW4XFih+Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBGuYlJ0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912baafc58so1634529f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741944119; x=1742548919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJrUGm+I0VeL1o2Iw4igeaLz8LtSBUgkIJ2qa7hBGGQ=;
        b=gBGuYlJ0EfCM9PahybbNye58pgBqOtls0E1P9Qo6NDpmhNiSOl5LmXdbGd34gM0QhH
         13w4WG2tEKlOp//LTRI0MePFeQ/qonZnE7zL1vuEJC6UffwBPbx1spRHQi8a5u94X0AV
         +CFahoWyNlOsQaA2wqDbKyQ6Gt+mLfWRgt8yzeDf5b/N+c+XixAcQtLkO6Nw/DNygv2K
         /XhSj97XZcXLe8/BGZKMtP+kSrLdZ/wc9DbeX6EW+STWKF5G1m28G1FATUWiU4+E9Mtu
         5xFcIuXO7G0BVdGNWEB3jNXRZreAphSAly1c97S4s92juI3+j6Et0zLBRxdYLeXIyoIo
         cu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944119; x=1742548919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJrUGm+I0VeL1o2Iw4igeaLz8LtSBUgkIJ2qa7hBGGQ=;
        b=byXz9yuzvsfQz4e34zk/3txxslSK1Vab66O2+mS9L3tdZFi9Zb6t4efNai9U3zL8ux
         XGVmnu/FHGYqW4sgL8s5J1IIE6sTnNMxgiM1qM80v991r+2VvOdWK/eGn8iuyaNM3RJm
         dUGMuQ5u6aDTI6Cwq6AmtRRSrULPUL+6VJ8s1NQRkUw0KTGsU4a9AZXX2PYcOhJPhSfo
         MTO5nRvq/SyRVrkP5UXOZ1m/XpUqMFSQ3YQpMOKS5LSCaLfFVqv2xPkkQbJVUywSIAZD
         K3nhLuL7DWv87EqFb4hX0RuwszcNl74zYNtbAL0rh//94bdnuaU+W45EK/9nXRwI+nx9
         HW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVVv8bZ7wREZgFFK5aJ2nY5apLW2+nB8BkWOEYRKVL9FjyqBIjt6w0xxxgiJJqbIaSJ/OmneNbXcTPiLl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObecGVOV8VFuWFZN7nfgdzhNU8ijTLfYAN2BMQpb1fggoTZnU
	2/4bchXIu+qwPPJUkZllO/bw1d2Z1UOLeaP2GPrMCRkJZRXPaf7zXsn6FsLo9MM=
X-Gm-Gg: ASbGnctlt4q+9KDpyv8OBdW092n8VmfxvniFTKnrjlnMs7weIutDCPzihMwIwg3rgDg
	4RHzWSjKY1P85VbHfH0EqXs/4GF0f+MlXG5EuJyzuWITRWTgIXEF7FuQxTQDz05PR9rcaiNqOLr
	dprgCf2M5nJTwpKdyNPo2q8XRzxHkZhX78mfIzybiUT0JJnFq0fE5UHe+NRTCMtcPT1Zti6+ZHK
	8qBA1EwyDKDBxBZI/erxSoepcDpFE7ayKQUAU3JnsIfr/VJwaVqrBCEsiUn9eSL1zvfvIcjQkCT
	A7ueSje1gMSDPaFn131doZGtqDODSGikhCQxK9+ZlPK7+eKK0A==
X-Google-Smtp-Source: AGHT+IFFPCKVtvQ6CGKlDDaxAhRZu9swSbTZM4Im7uWc3KAoJGx39LZyY5gIccrMjFgAH1WXoacnJA==
X-Received: by 2002:a5d:598c:0:b0:391:1473:336a with SMTP id ffacd0b85a97d-3971f4119f0mr1912619f8f.36.1741944118769;
        Fri, 14 Mar 2025 02:21:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb3189a0sm4996922f8f.67.2025.03.14.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:21:58 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:21:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: zfigura@codeweavers.com, shuah@kernel.org, wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in
 wake_all
Message-ID: <1111e313-18b5-42c3-9e53-ba46c3826fc6@stanley.mountain>
References: <20250314071454.201697-1-suhui@nfschina.com>
 <20250314071454.201697-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071454.201697-2-suhui@nfschina.com>

On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
> When  'manual=false' and  'signaled=true', then expected value when using
> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> index 3aad311574c4..bfb6fad653d0 100644
> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -968,7 +968,7 @@ TEST(wake_all)
>  	auto_event_args.manual = false;
>  	auto_event_args.signaled = true;
>  	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> -	EXPECT_EQ(0, objs[3]);
> +	EXPECT_LE(0, objs[3]);

It's kind of weird how these macros put the constant on the left.
It returns an "fd" on success.  So this look reasonable.  It probably
won't return the zero fd so we could probably check EXPECT_LT()?

regards,
dan carpenter


