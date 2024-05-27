Return-Path: <linux-kernel+bounces-190199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD398CFB16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07778281884
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA33FB9F;
	Mon, 27 May 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/2UJLHD"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128D3BBE1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797664; cv=none; b=N0P10PyLqEKLP87GFPSe0nAtLmQtqC3iMryBWY/b4ytcGlxLUsIORdGQgRSUEXlsb/WtvGN/+MNnYqLHAZedenCAg6CT172P2Yy7MbH8zPFZ4YazYZWR3oGxuLBhRcI4P4X6U5yY4CInL+GzQfpTJIu9aJoCtnxnjRfwLj/cZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797664; c=relaxed/simple;
	bh=nwYaraCxggBDKnVnYzLQQW0XR3XO/+s4UMrvkMG2ZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB9vERkcud0xwkCs7tyD/3cga2+TNA70D+JuiIpFt2+SHhQBQ8yyf3RB3Wh42UOBmq9Eh6U8qWGpvOoz4TWN2IIAHZC2SapfUis+nyxH3SXh/GE/NdXJDIior6RJHiNqZAascbF+TDNXhb8rcFncJeAxwl3LUWsQEqSABoszTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/2UJLHD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5366so1709299a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797661; x=1717402461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gOfFJLDZFM1NLZoeu2fRwYilxYpWgEWWcHQQR/WPKs=;
        b=K/2UJLHDKW68eL9idw8EEEp8naRe7lSMEvpaCj6OZwGtuC561mk3rm0O5xGycLE+8Y
         GCFq9BSSZ9mN5sjpL/wSz+4aPufi02V5CzFs2Hkh5dHcWKBcdljP+gOW0kLpF11HcE5Z
         /xgaj11Nqsex5mL36G578m9+HwsrPs78Ejd33tp/H3jwMqtH2D0T0QApD4NqEX1QQHNI
         z1V+ovtNmJq6yQ8/+O5VOqlGLTUXqUsvmCwfZfxD35Ft+qP3j0LacJR2Qc2AkEW/l0Qc
         u2WxnpAb+T+izEzRRtB9i2//Y76sXce/+mlcVMxN13BbuSMj4EQCm4Y7jD0HNufmtctp
         7QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797661; x=1717402461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gOfFJLDZFM1NLZoeu2fRwYilxYpWgEWWcHQQR/WPKs=;
        b=Ozo+4ZJTMV0rRKC3kNmf6R84SgVNxgeeh+CC/Up/113pA3UNs6shs75vKVZgpJVk4j
         AOB2W+hy9GvHoopxfvxpqPCZ+AA7/HruYFCKyuUYEopilYMx2amWe9nmPpirKAtCJHSe
         Q3oe0ihjh8MMqNVGvgDE3gkmb0gPg7zbvWl+22zlGK5mUae33rthRCG/OPAidP7aIetP
         UbTDuiKdkjGKq2+yQtX+VM5GGqkdbrAgpDJpe/kWE6IKQk85ZGJ9Wd6LlkP+SXF2mPT4
         MXwAgGT5IrQM+NHtlxE6VPZbJuFvmLoouAWqX1t5MX2AclCb/Co0F9Sn35hGoZ2i2OZF
         qZSA==
X-Forwarded-Encrypted: i=1; AJvYcCXGj/7FlrKCSeEEeMaMxULyfpetPn843EiNEQB1Yy9IlgnuZBLyXjVVYac2mqPbk2mUqzR9QPSX48YV9bthxX5hR6UwUQi9sxfF0a3i
X-Gm-Message-State: AOJu0YxG5ySkRk2QshvGxQSJ/IYm9bq9+J+O7q8YvkJPOfR3mc0K4GZd
	V7RHvFHhQF4L74IP0G/u+FljxdC8L58YwIurUDrJUhkyl8K56T8mpSJZRZ50HvI=
X-Google-Smtp-Source: AGHT+IHYnL+hf/PaVRs5w2cBRVnHz4XxYlxeikqwWQlJyhXrjPG34g7ILif/Bx2s4uuxLU41DeUKtQ==
X-Received: by 2002:a17:906:7f15:b0:a62:e9c:f621 with SMTP id a640c23a62f3a-a6265148c46mr601649666b.58.1716797660675;
        Mon, 27 May 2024 01:14:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcbdsm472629966b.175.2024.05.27.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:14:20 -0700 (PDT)
Date: Mon, 27 May 2024 11:14:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	lars@metafoo.de, swboyd@chromium.org, nuno.a@analog.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <6f479ca6-cd6d-4a28-8afe-8b74c4d171d4@moroto.mountain>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
 <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>

On Sat, May 25, 2024 at 05:00:59PM +0300, Andy Shevchenko wrote:
> On Thu, May 23, 2024 at 3:42 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> 
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_data_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1112       char buf[BUF_SIZE] = {0};
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1113       char *p = buf;
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1114       int ii = 0;
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1115
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1116       hx9031as_sample();
> > 5e5a419c9407f6 Yasin Lee 2024-05-10  1117       for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
> > 5e5a419c9407f6 Yasin Lee 2024-05-10 @1118               p += snprintf(p, PAGE_SIZE, "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
> >                                                                          ^^^^^^^^^
> 
> 
> > Also use scnprintf() instead of snprintf() unless you need to check the
> > results.
> 
> This is incorrect advice. You should recommend sysfs_emit() /
> sysfs_emit_at() in this kind of case.

No, this is not sysfs code.  It's debugfs.  The API is completely
different.

regards,
dan carpenter

