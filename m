Return-Path: <linux-kernel+bounces-429836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B89E2BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971B8B2C02B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936061F8AE0;
	Tue,  3 Dec 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ahu4dCmj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887531F893D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243177; cv=none; b=ruqwJrbiF/wkpPV6cnrpKaFyzHbJw8view+0ndJFn9f7Mk7LFKmEfkZn+UaECsvuhT+bxTqIygNREsaQ0k7o+n6D6H01NXe93LsnFmJzR97ujs6wnFnP/2QE7tw66rpaaEIe7ieZlW4gHWxTnqLyOL3YYyOsoDOU/m8GBsknJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243177; c=relaxed/simple;
	bh=iKSwEj1QUd4Z6seRbKb5DsDKmOf5JRe9IWTGuEMsE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5TVRv33RQe0yKYujo8uTUtfP3ktFJCZm1Gqxq8yr0uAE6yGvszP0jIH9IbuQJ6MDkI+obCWBEcyc+QjNmN1BPsrsl+BoIU+qtnBmQhgt+RVnz11PH7G16EH6O0XRFkC8vUMH416wDjiSAdz65gcAReoBnxtoPO0r59gU+cGUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ahu4dCmj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215b0582aaeso13520505ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733243175; x=1733847975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=ahu4dCmjkZTiR4ojorbUJBdR+FTcaT24z/zcQ7esS0rdl8zGd/IKd7emi5GUZ5rm9M
         Pv7LMHSGqj26NLS6rJyR+u9tJDbvh6vuiD/SqCL0isUYFhtYY28Pt9AgzekZjIHX/Gf1
         rKfEV3EWt4jGXtaCwUTsl+ZPS8DnuJndnNynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243175; x=1733847975;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=FO68/7+teFzUNMzgQC7GLY16KUZ4z9/9t7n5WzpZ7rE6tCLGoh23f3GXUNuzC5RpbS
         1DGLcra4iUaY/TrisCd2axfwAMRvEs0gIMnJ+/FtswwYXBwh6K1AewSKbOYuSf8IcsEw
         N5BJuwWZsLToz5ZIKJwxhDiDCFYmUR8SSszamV8Yi3YJu9TWhr3266gqgNhzGY5YgI4B
         uzDBvhUASsDxOGUqsJ7tuvAy6KRD1vJMBUJD6bAvLkEcUV21N4l/V8pVvXjCsF/2KrAt
         FiQrRGk0hSPuC8jfrNuyqu0/2aqQ9ZYvVONK/3Z/ua38Kw7uHKHs/gSkUJ/6wDjyvzCZ
         KolA==
X-Forwarded-Encrypted: i=1; AJvYcCXeASCK+NaqPBVYelQnRd9Oc1jZEWoaV6cuONd9meFGX+xnBzYsBMfc4JRB/KEKTysm2Y9uSD3hbxCjukw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w5g/Hx8JvLiSFu/Ha8dVH4GlfwwYadrV+pIUdLTewuPnyIGE
	hAkZSFml3Uxd86aFcZFe4vBCmxtCtn+NRcK23Gqr5ClIDtJnsLbMtmJfyvqemg2Jen2HFUWA0o5
	K
X-Gm-Gg: ASbGncsCYnMich19M5DloAy16rKgcbevkvGUcnV9eaZEYcmrDS7diuHCWgbW85xvivS
	LHQUdL0MoSr7huoNmsDvqFgnnq8PXdGc3M7UiolFO/Fx5pK0I6kFghwkC/rOjxS09GQl0fcK5HD
	c/fYmUwHQsy93b5g5+efYp+0Yd8PhsiGsmn1KOZfBmwYqkI3o0W2SucEQuDfOZ0FLFpCpktFwvf
	HVvgh0gXrSrADaJLjzgZbd9Q6xjiUxtaXJ09EeKxIOwMYHi6vKGHQcou9OJA3DRnvf0+frgOgbf
	xVvwZz0Vcw43hkFo
X-Google-Smtp-Source: AGHT+IHbJxCIE7dNvn0u2Dahnh6gAzNdniqSXv5Pmp3C2Lyxfg+sQF/aKgavRzPI6bN7e0mY9bjTHQ==
X-Received: by 2002:a17:902:f686:b0:215:931c:8fa2 with SMTP id d9443c01a7336-215bd104617mr41724185ad.33.1733243174771;
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f479asm96731665ad.41.2024.12.03.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Date: Tue, 3 Dec 2024 08:26:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <Z08xIyc7OcRoEE-C@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241203012838.182522-1-jdamato@fastly.com>
 <Z06T0uZ6422arNue@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z06T0uZ6422arNue@mini-arch>

On Mon, Dec 02, 2024 at 09:14:58PM -0800, Stanislav Fomichev wrote:
> On 12/03, Joe Damato wrote:
> > Fix various integer type conversions by using strtoull and a temporary
> > variable which is bounds checked before being casted into the
> > appropriate cfg_* variable for use by the test program.
> > 
> > While here, free the strdup'd cfg string for overall hygenie.
> 
> Thank you for fixing this! I also saw them this morning after a net-next
> pull and was about to post... I also see the following (LLVM=1):
> 
> busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>   237 |         if (napi_list->obj._present.id)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:243:38: note: uninitialized use occurs here
>   243 |         netdev_napi_set_req_set_id(set_req, napi_id);
>       |                                             ^~~~~~~
> busy_poller.c:237:2: note: remove the 'if' if its condition is always true
>   237 |         if (napi_list->obj._present.id)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   238 |                 napi_id = napi_list->obj.id;
>       |                                            ~
>   239 |         else
>       |         ~~~~
>   240 |                 error(1, 0, "napi ID not present?");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
>   226 |         uint32_t napi_id;
>       |                         ^
>       |                          = 0
> 1 warning generated.
> 
> Presumably the compiler can't connect that fact that (!preset.id) ->
> error. So maybe initialize napi_id to 0 to suppress it as well?

Thanks for the report! Can I ask what compiler and version you are
using so that I can test before reposting?

