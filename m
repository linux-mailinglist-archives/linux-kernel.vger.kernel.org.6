Return-Path: <linux-kernel+bounces-395675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6356E9BC183
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAA2B2184D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705631FE0E5;
	Mon,  4 Nov 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oa0wm5Jx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCA1E5723
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763322; cv=none; b=U250orA4tTNF3mfO+IBhJgPUJaJNindr7PWs84YkBvS606ClxrTu8ZNjUBbsGLLUpKn3BJXcDv0ZNwHoAxmjCNoU6iDwgZIJsSePnnjXRP8CQUlrQZvRJrqxSnu0h28brppOaYGR/NFADILHsdtgn6fot5NZS5iGjavC0euBjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763322; c=relaxed/simple;
	bh=g12YJMdjzc4EaRnpMnl81wcVbqzgZX9A6uefhMb5jAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAPp/8dVo8FGsOSwZT+ZIcnpHrUg9PdP6Fk6gQnjTOEuFPdUXFLTgiGpimAZmdxPX13iLDDaI0WEkGvhinGiv3AMnksilPlgS6RtIHNgPsl2kbz5yPnOwK8fSxdjDXN08klj09lPzGoKdaR0oPYTLKmhzTBAYUdS1ZOfKFcDPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oa0wm5Jx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cceb8d8b4so30927875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763321; x=1731368121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=oa0wm5JxwZwci18yD/EmRq5Fag/WtQ3B3zpIBVmgCBF+dQOMyfiZOJ75FoL31UTuSq
         67QR5A+icRih96pHufUChzTw6GJEjKWtpFPSjLH3zOTA8OaoU6nFhWpKXfmCdcR/f5Xy
         H1zYpBGzd5pudrrJ4qiF+bu7NbHIuT1vz17gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763321; x=1731368121;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=tTdi4NWwREhKGmXHf1f010xUE4XYBeQcSYC8k6WPthaBSVtulcMcXNUM+cJm0yhy1D
         xEps+2QcU/bzbvqByo9TJEJ3xER3AlOrtaY2c7eq8H2RtQt44YtDj9O6DvJYTu20+29B
         Jv9LIQFKWHb2piRzXiqQdtCcmTrmFz+YfKqfloEt39MrEJwkBJH700P1CoPUzhXgvdGb
         r+B2lgP6bbLpHRtCmvgoIlPY43NMRFwjhZ4XpAwua6XOwqaCV9sm8sZl4Et9w+u+i/Uj
         /VdnXFWV0jUc1UPuPxteOCQlNATKDlhyVu43AjPyhwgHeFdp8pYdRmpC24yTwA01Q1r0
         wmkg==
X-Forwarded-Encrypted: i=1; AJvYcCUcBPp+e1/hlekN9xrFUn8xEzfRGs2DDg+X8T/AnXYblbTYqCkQhSfY28eAdiNxKMfhcJnAHR/Nv8tJhi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9NUweviMkFG2By9OujsVjytnZxLA702EccBnR/DAYlgkl5OW
	RhzLp8xB4EKHlgovmTNl96yK2HsZz14VzwFGFkmJsXMaNo3dWYRyp+ga7ygV8ns=
X-Google-Smtp-Source: AGHT+IF75w+Ptq7bsaSssIf5M48gQfiKPC9x4jCAu+t9iSu+zcEnnB0a2FVmbeW4YMy00MxPy3Pi5A==
X-Received: by 2002:a17:902:e5c4:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-21105716ef4mr243171585ad.17.1730763320701;
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2bf7sm66763055ad.173.2024.11.04.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Date: Mon, 4 Nov 2024 15:35:17 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 01/12] selftests: ncdevmem: Redirect all
 non-payload output to stderr
Message-ID: <ZylaNahW4yhA0uC4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-2-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:19AM -0800, Stanislav Fomichev wrote:
> That should make it possible to do expected payload validation on
> the caller side.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

