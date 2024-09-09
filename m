Return-Path: <linux-kernel+bounces-320978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CA9712EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546AD1F23399
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A01B29D7;
	Mon,  9 Sep 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9nIJuEM"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706B1B29BE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872737; cv=none; b=NjleSy38SbhJ3gcbSBljYmayKP9QwYkxEYaTul9ACrRQ5XBTE55l6wdkuumr4nx7/xzgN8FK2nYdP3BSlwAhU1hzHTQoUQYlNupeWrNJ97yn3QwDcDFAgQRWJjHkbv57Q6lTh0COYPUkcrpCi6eJBFD/7RL2uzMJFyZDgWhvb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872737; c=relaxed/simple;
	bh=BB3/H5ySqRyu6/77CobU02zoSYGnRaT8/VTpD8q1nkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ0w/nrufCn79pxNwkxb1bJWfMgEV9nIaBZSsngWn5MtbiwjOIBkS9QFViZBk5l+gqphJvQKHpYPzQ0PNi0Ey3SobRNjj8/vm9+aGzxFjiBXM4SQXMjrsfRi9CYRAtTLjQiCSRXXsQkBpNtJRsud5qIrVMy8XAnaWpb9AYbgH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9nIJuEM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b747f2e2b7so38049667b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725872734; x=1726477534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j2t8R4xfnSC9w9Cn08xrD7PLm+PTwWMORf6NFYOH81c=;
        b=S9nIJuEMT4dVh0P4tUIwaCATrYrzoRETQ4/HdZTDqoglVs+gMU8OSXQPwyLkbDZ8BJ
         DmTUaLUaLnqXeY5BeTOfLsgqymqUAKYot214KfI3u7Vluk8m8vdg4b2VY6IeiqmHS9vq
         7g6ZxYs83syCWeaCd4phgJ/Wz/fwLrA5qioLfMdTDaZazgvkTHmuHzOjI6KiAoFlCGmC
         wpl8zLxamWt00ctZCTSq1F2p3bNkf1NaRcU0zqfWXTGmNFh1ADHCk1vECGL0vBeL5x0c
         wZetgMZpeRPTFq0Vhzk7k5ubgKOKWXTILIM5SMaqCu82fO0Ui4zLfel95u4k1AmEL0y1
         SdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872734; x=1726477534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2t8R4xfnSC9w9Cn08xrD7PLm+PTwWMORf6NFYOH81c=;
        b=M5tz12Zi51C3ztLjatJPh0jkybZwnYdi9ELJVggJ2RsF42qH7hk4HC2oA/oRY7z8Wm
         ZGNLDpvW094ozWBOqhEXgG6Bfniz9/H5+z1Upq7dSUYYZoSb8QI5jAS0lMNs2reomWmV
         8Hv+jTJJRVN3ZjPmFWQ7/kQen3xxSC9tW2Ycdducjla5L8jLQuUhoKQoibgy6xC/yz2o
         tbtOQNCoMkiy1f0SEQbX0yAplpZkV7OnGHZ3oG1IJ7HlXq6FZov7zhJuEXOSSOpMywaA
         s7yE4fsS+kS+Ix5lcu8LHSOLqZpfOczwgHYJl7J1+cJS4LAiRQfFJpnoDB2Ds6liGR8I
         AyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2ii6XljS+J8EE+Afey6qvJ6MXEH65+xZjTz1Bvc9QEJUl8QdbgJDZEW5VSlBlb+R6g5v+idTnxJjqOsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzC81QsNTawryNSKUIPVVw3pxty4CmWdmxaeZhPkT+rnhmfp2
	txG2wt4z7aJONMMWwneN6IqwjG06Mti2cotwbvT5mB98jaK1KNWB6+GXe3ZhNd8A87eX0/hM2dC
	XB6QJgoptePAKXeL36+1k7wvKyGsRgYOICwOFCA==
X-Google-Smtp-Source: AGHT+IG0rmU+PJ1sUsI9xaYzlyO0fuHlZgEClWUHvIo++2qG8J7dLhkan6PH1kB/kHCDTDrPTR3yTt3ldtPN97UpiV0=
X-Received: by 2002:a05:690c:d1a:b0:6db:2753:cd9c with SMTP id
 00721157ae682-6db45273f36mr119317517b3.44.1725872734530; Mon, 09 Sep 2024
 02:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com>
 <CACMJSes4cnCNUHiZUr4CF-K2c8-1VYzuh=T8JDi_erqfShkuZA@mail.gmail.com>
 <1f889bba-0c89-45db-b360-b21d6bba7772@gmail.com> <68b0476f-dfa1-44cb-a01a-f4afbaaa98e5@gmail.com>
 <vtdrxh57zxpu6xktzehcpx7hkaqclg5kya5jojrbkmo76yswxx@libmc5evobkb>
In-Reply-To: <vtdrxh57zxpu6xktzehcpx7hkaqclg5kya5jojrbkmo76yswxx@libmc5evobkb>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 9 Sep 2024 11:05:23 +0200
Message-ID: <CACMJSeuONLsWy3rQnLsOxm-Qqgcmd67XNhCMPvTd=UtgYoPfzg@mail.gmail.com>
Subject: Re: [REGRESSION] firmware: qcom: scm: smc: switch to using the SCM allocator
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rudraksha Gupta <guptarud@gmail.com>, regressions@lists.linux.dev, brgl@bgdev.pl, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, 
	quic_gurus@quicinc.com, luzmaximilian@gmail.com, catalin.marinas@arm.com, 
	will@kernel.org, srinivas.kandagatla@linaro.org, arnd@arndb.de, 
	quic_eberman@quicinc.com, elder@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, ahalaney@redhat.com, 
	quic_djaggi@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Sept 2024 at 11:57, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, Sep 07, 2024 at 01:49:02AM GMT, Rudraksha Gupta wrote:
> > > Looks like qcom_scm_get_tzmem_pool() returns NULL. Not sure how this
> > > happens. Can you confirm that the QCom SCM driver probed correctly?
> >
> > Thanks for looking into this! Please let me know how I can help!
> >
> >
> > I've been building the driver into the kernel I believe. Here's the relevant
> > line in the config:
> >
> > $ rg -i "scm"
> > samsung/expressatt/linux.defconfig
> > 1615:# CONFIG_ARM_SCMI_PROTOCOL is not set
> > 1627:CONFIG_QCOM_SCM=y
> > 1628:# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
> >
> >
> > It seems like the scm driver is being probed:
> >
> > ~ # dmesg | grep scm
> > [    0.066438] qcom_scm: convention: smc legacy
> > [    0.362543] bus: 'platform': add driver qcom_scm
>
> The scm driver is added, but it is not probed as there is no SCM node in
> DT. I'll send and RFT patch to add it. However the issue still persists:
> the driver should not crash if there is no SCM device on a system.
> qcom_scm_*_alloc should fall back if there is no SCM.
>

Ugh, so some SCM calls seem to expect that they can get called without
the SCM driver. It's not very intuitive, I would expect that the
driver must be up for SCM to work at all.

I think we should fall back to using kzalloc() in such cases as
there's no struct device to use with the DMA alloc APIs. I'll prepare
a patch.

Bart

