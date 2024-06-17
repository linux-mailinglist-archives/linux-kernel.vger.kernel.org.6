Return-Path: <linux-kernel+bounces-216711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB25290A397
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03051C21533
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCEC18412B;
	Mon, 17 Jun 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3/QdkqU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D14178363
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604125; cv=none; b=A8uo0PKEStw2Lp4kNhYpsVZaa4tladu9E8P7prdj/71xLmSuIuz3GgKx72oI3cHkqFOKuRZMXVNbs9LvgkJN7gXYwXlc/rHCLxATFIqMPTjErh7rGdcconSDx4OatAMDFfbOJTgoDl2IbJgvsfluvbRivJNh7rczGitHxdV8WPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604125; c=relaxed/simple;
	bh=s+7UGFQ0JV3m0qWZbaij6Fo8iD4Q2iD0A/tBObqqvvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGBslP1Ihhx8JQqo4QWl16CabyWjOf//ifSrXwnYz1+g/0BS5sIaVNPJ/CVAt1sM3aUj0XBfQWy2+tHqGACiNH7nBHAJAs4F3KCh9DOA8+udt1WZCbv8r+6rm18Ix0VrMlsDTPBDIkr/AU4v1YH4dg8p8ThzNJciUa5ocOVT5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3/QdkqU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1bc63981so3008479f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718604122; x=1719208922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVI8DZr1IghSHyA17IzjoVbK6JkzXWtBKos+ZRMKv48=;
        b=D3/QdkqUtQke42x6HMCJw0/Lz/mThq2c96BY7Ks09VkJ4aMCvJlZhKMNdEziSUwnSk
         jfvjXl229IuoUkxwQ57166pqmiuA7pNXirsjY7XuQVUSrGIcgwVJE/BQLeQrdmTXMRKW
         +S6iMEhOq/YXJgzxeYS1PWzfbBJooZC4H5BbcVVvWvtpercFhAfnxLEmAl1gS5aBK8NC
         NN1uk6cNaoOaemGDOokK7sI887r4SQMiWVRyuiRWlwIXIfN+FiP/Vk7Omdh94u2Wfof6
         oVYN03JCHmEjbtw4eOIoDfHDQuIwVNoEAlI8VrUZnGERD5qiGTYpiQqCZIWDSPv8hSk7
         03nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718604122; x=1719208922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVI8DZr1IghSHyA17IzjoVbK6JkzXWtBKos+ZRMKv48=;
        b=UCDbbLg7rsLnlPcfCoU5+wtHVnZFlFg7RBqy/gDPhcvXSzBogHJZZkht6btm3EHBVU
         CvjbOctVNhG3y2POeLNfonkKxaBd8+Edy9uu2JfleaR1mBq77mBD4+1aG7/5M0oAc2d3
         4yhkKiUHeOgcA9kOJb/70Ux5EbGcZw1CR2c2RUw7RHKhgqGZHQVNWBsFUbz1MBAxvjh6
         3lLu2mt/CsuVoAHY5reYhF0lhUgFJyvnXBOOL5+smREepHnDFKUM2WwqaoBka87GbXvs
         SP1B9fZ4bNPF8WC1JJ9uFvyWRD9onwXqFznv0XCOo1QaAQlE3iEa/x68F5aNH6W2D+BB
         vPRg==
X-Forwarded-Encrypted: i=1; AJvYcCWAl6qkMRK8SNCMcVGWC2WMMMc9CtSCgSU7VhOus0+1lg053Ro848jC3sGjtxLEtAjCy2rd7GLCMZ+sQbHCzf01DYt6fOoneSV1NmRM
X-Gm-Message-State: AOJu0YzFXlZKMKDj6lXhdSW0UCUOjUsAyq21eHp8yvMYOegfTdmVDwkY
	qdNDCEViLi7n3wOBTxj5LqBSpGu51u1xxLlR0DeEm9OAiRehRjtAT1aC7V3ToMM=
X-Google-Smtp-Source: AGHT+IH73yuTyO9WfONVPawEbQeSwUkd+19ybcdtJKKoYQ2afIFQHfbWrObvVDJ9QDr5gwEzzqpUVw==
X-Received: by 2002:a5d:550c:0:b0:35e:60e6:c8a6 with SMTP id ffacd0b85a97d-360718c9d80mr11684582f8f.6.1718604121492;
        Sun, 16 Jun 2024 23:02:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c9ccsm11145502f8f.45.2024.06.16.23.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:02:01 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:01:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <591ae05a-7ad4-4ff7-943d-d8ecc17c91ca@moroto.mountain>
References: <d094ecbe-8b14-45cc-8cd8-f70fdeca55d8@moroto.mountain>
 <3946b327-5e89-43d3-9dc3-10dd10bd41bc@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3946b327-5e89-43d3-9dc3-10dd10bd41bc@wanadoo.fr>

On Sat, Jun 15, 2024 at 09:05:56AM +0200, Christophe JAILLET wrote:
> Le 14/06/2024 à 19:31, Dan Carpenter a écrit :
> > On 32bit systems, the "4 * max" multiply can overflow.  Use size_mul()
> > to fix this.
> > 
> > Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/ptp/ptp_sysfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> > index a15460aaa03b..bc1562fcd6c9 100644
> > --- a/drivers/ptp/ptp_sysfs.c
> > +++ b/drivers/ptp/ptp_sysfs.c
> > @@ -296,7 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
> >   	if (max < ptp->n_vclocks)
> >   		goto out;
> > -	size = sizeof(int) * max;
> > +	size = size_mul(sizeof(int), max);
> >   	vclock_index = kzalloc(size, GFP_KERNEL);
> 
> kcalloc() maybe?
> 

Fair enough.  I'll resend.

> >   	if (!vclock_index) {
> >   		err = -ENOMEM;
> 
> 
> Unrelated but, a few lines above, should the:
> 	if (max == ptp->max_vclocks)
> 		return count;
> 
> be after:
> 	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
> 		return -ERESTARTSYS;
> 
> as done in n_vclocks_store()?

The code is probably better as is.  This is a short cut path.  We
sometimes see this pattern on fast paths where we test to see if we can
skip everything, then we test again underlock if the test is really
essential.  Here if max == ptp->max_vclocks then the whole function is
very complicated no-op so it's not necessary to retest under the lock.

Meanwhile the essential "if (max < ptp->n_vclocks)" check is done under
lock.  So it works and it feels like someone put some thought into it.

regards,
dan carpenter

