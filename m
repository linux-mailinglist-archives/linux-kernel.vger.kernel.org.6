Return-Path: <linux-kernel+bounces-444995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B049F0FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1418864A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACB1E6DCF;
	Fri, 13 Dec 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQxPJl4S"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F31E491B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101470; cv=none; b=oSccxbFChQn8FdMV/NfX5CoixrT0a+R6rPdhzHCqg3FP77qQApZ/K1DUdvpxCvfMkOfsNqSyYg5vndLeZguunSVEorzwgs0zWdQk07tZ48hT0L8iF1nzieo0OOG+yKTBmXwTzfYkGKNiJTOfOF5+hH1eIkSUog+MaUVqJyLiDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101470; c=relaxed/simple;
	bh=+PWrgyUqVhZ7V0cKCjdPuTyqC/Tg19Q+zKVwQeTvk08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX0IqbCJapNYK74hBoOd8HOrsOJNfSJJNXd5/i3+IXXgvbm+xeOuWdqD4GAz+EC8UVp+CXwkC87TJJttnTkpdIZRwqUfxsUjdmldXJRicXm2FamEluOsMGLcWY8Oyszl4zpqBtGlelrJfC4HpmysDiMBK6Iqbb4bA1/ibkne+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQxPJl4S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso291952166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101467; x=1734706267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTsIlIv9lJiwHsS898heGQfU2pNtvxuUdUV0LwVg4wg=;
        b=cQxPJl4SdNigSqs1LoI6NAZGyAyJcXtlVaVPommqlpOp2/NVU+wn+Gp/MZWtvtbSgp
         5j8w7B9dEQEfxWNS0EBVimjlJ/ihU72fCyjDa/QMQ7VJ3Fy5IPtQKLrV4MbhmHE/fEH9
         n9QfskWxPx1g3otr3m4tBtn4M65G3UEZNePB1mNGHNBErHlyJjhXmG7rZHhXZWQex1s8
         Mzp9qHzyhEUozti/Msb5CucGlBH3vniQYEhnBuyXTjjIM9voljscUsS38ULcgS1uAVxw
         huf4tbAI0i7sQkOEgAhF9N1+41U2F3M6gDNX9npQRNusqVKT4Hb5yevmF7w1ebXNW8dl
         MCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101467; x=1734706267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTsIlIv9lJiwHsS898heGQfU2pNtvxuUdUV0LwVg4wg=;
        b=ZzQwWl7TakDN9FERUPL/5Y5h/YkZ6+XnQsPYnpC+cAvmlXOOQOJFN6guW9I54baJBN
         3/OEcYaQpCNzpWaUbgLJJkSD/UJG/nOBqOaKq+mvoj2O88oXJtTvZDXQMlJi0UChrr2/
         hHHFRKQFtxQHDN79QliJn4WGaEbSqMN81wWfkPoL4487kNiZq/t9dT/S/8JDF3/F561+
         pi53v4CxHjo8gqVmbY20zOEKeei51zeZjt5zXwQM31Y3Ns1Dugra8fkbJ/0zzR737g9t
         SL1dsFSmv06yNWBArYEMWlOXgs3O5fvn1047rMdLAtJB4GQutgrkm6lIEriKW530OnXZ
         SDIw==
X-Forwarded-Encrypted: i=1; AJvYcCVFRUP8HeC7xWM4KKtmlWa4KgnAsB50fYM4VpVnweXm5ZIAzNcXbhkz3MBDEM4HciCBkbT0hqsOEJ+RRPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbB/lD2klS/A1j84yoHqB5WzXDpieyp51O7t6NJ8o0fARG8Le
	JFcsCPVMGdSdv9YMtRHz2xRou4wB5BJfpdHAyOMZ9s+ABZIhlgMwiyolXyrwE3g=
X-Gm-Gg: ASbGncu4gVRp3yXdQPx8qlXFhMD2HePB6dxBjJZk/6zJEicm3u0fhP1+62DqTU5Da/1
	4/O50eJ2Grw58diwEYjq3FigoiEekTtoW2fa/D49mWN5SemKmqATUflOeV2hZQxpA4+v5xmk9bE
	4/RNbZhqgou8V50K2DHiCdbyQqrdVYSSdwap1js/yytRRV5JOc/2XagEuZF26ItDOrWfZ4DpVLg
	Cmkq0te9RAg4hqmNdBeZfc0uDKCFW64sA659EVMWcNkJAXmLtXfGZkHb3yynw==
X-Google-Smtp-Source: AGHT+IHam3kvQR0KKK8cm4xRP5ic/rpiM5+cPOSriCMQTUL017DYrxeEP/LlAWJlAjP6PlmQ/rV+vw==
X-Received: by 2002:a17:906:2dd6:b0:aab:9263:e775 with SMTP id a640c23a62f3a-aab9263e7f4mr15689966b.32.1734101466647;
        Fri, 13 Dec 2024 06:51:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6b9a94c32sm309650066b.55.2024.12.13.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:51:06 -0800 (PST)
Date: Fri, 13 Dec 2024 17:51:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Chen Yu <yu.c.chen@intel.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] kthread: Fix a NULL vs IS_ERR() bug
Message-ID: <b05f0157-4229-4b4b-ac96-62c9703f145b@stanley.mountain>
References: <64c234af-5141-4062-9170-2122c3edf088@stanley.mountain>
 <Z1xIAezMPKXAj9MC@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1xIAezMPKXAj9MC@localhost.localdomain>

On Fri, Dec 13, 2024 at 03:43:13PM +0100, Frederic Weisbecker wrote:
> Le Fri, Dec 13, 2024 at 05:25:02PM +0300, Dan Carpenter a écrit :
> > The kthread_create_worker_on_node() function returns error pointers,
> > never NULL.  Fix the check to match.
> > 
> > Fixes: e9853c812f86 ("treewide: Introduce kthread_run_worker[_on_cpu]()")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  kernel/kthread.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 83bf73d2355c..922f15762ec3 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -1124,7 +1124,7 @@ kthread_create_worker_on_cpu(int cpu, unsigned int flags,
> >  	struct kthread_worker *worker;
> >  
> >  	worker = kthread_create_worker_on_node(flags, cpu_to_node(cpu), namefmt, cpu);
> > -	if (worker)
> > +	if (!IS_ERR(worker))
> >  		kthread_bind(worker->task, cpu);
> 
> Whoops!
> 
> Can I fold this to the offending patch? I can add your
> Co-developed-by: / Signed-off-by: ?

Sure.  Just add my Signed-off-by probably.  Co-developed-by seems too
much.

regards,
dan carpenter


