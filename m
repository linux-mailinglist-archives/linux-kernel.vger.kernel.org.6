Return-Path: <linux-kernel+bounces-223457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5E91135A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9071C21BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8DB7346F;
	Thu, 20 Jun 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHhUB8yD"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1D7174F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915804; cv=none; b=GZXEuwdrtAXmsRpy3RzS4m5s1ATNBOG9yq71n6nyh5zLD8N5eeoHTOEUtTEbCxhDcy2Mf7KPEVIYkTti7jUQ0mUevOxRv4tWfX9TcmSs53OWnJV3R00MLwCtJpLnM/EhhmZCkf0w6/lC4kqn5DcqN6zp0DHty8rpEcwTfTGv6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915804; c=relaxed/simple;
	bh=yuUY40zktsQWEPNuWvbKdOCpoxs+x+2ljoemFo8me1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9gZAnzrpTxuZY9cIpCsIzFjRGZYY2OP3teRt43BPRCtrAg6dOVscACN6ARrz2LcXYyuYj/LrCVTuQ311mP3G6S918ETf0UGCyFNoX0GN/HGAnxSx9V1LffMD4OmnfXsOiL+w4HQsTH7r1vJ8i0FTdLk5Kab6tRo6d1Gfk94RQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHhUB8yD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec10324791so14609491fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915801; x=1719520601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BFUdB3wD/PTnHILQdaxRgybUkydZvzvqGH0TgkgaEEg=;
        b=uHhUB8yDJnpCwOrn8vWWZlTJ5K93notCMvTN8kv4NLLASrSzJCUuO59XH56S3jHjS4
         1uwBGfyP7wql0EFpa7nR+q071Ny5Jn3PSpcPU3/4SPLbEsmf9ACJclFZ3OhIJKq2itd/
         sLNLi8SjklqRPjG9kKaIymBzJfrSKJxmVZuXJrfQt05AF4V9pElPwIApjJ9NZdJnovIr
         lFwJzDZJ0yjxnUtZmj3HH/5RHGqGf9Bubrab5WL5Z0KyuA0bfndIJY13t0pQ7CjsOkv/
         CkPX5TCbmSqiRgg4mP891Dp7lG4Dfn7rJme6hpmmJ75jBjJHnusZDtAZB8QRxpdM4XpI
         IQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915801; x=1719520601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFUdB3wD/PTnHILQdaxRgybUkydZvzvqGH0TgkgaEEg=;
        b=BAg16yt7HTK0bpKnc1ZgXt6CKVwvhU/JYfngDL6OpXQ8SYcexzKifL3zB7+VXSqzyy
         m8W3x3NYXWT96pvkW8UO9I9Eu3ySg5865YAVimCW8hXpVAxQagpcvu5q3YTj1Y8FvXT7
         SNotzyRZH6FCFclTepqVbkNGDK2wN7JMnti0ArgsI1pAURVuvSk42WJTfB+t5lu8GQ1i
         IiK4xJdCzVv2jtLfXREK/CAMujqs+3w16p7tJ6kDW3dS50zqiT9rOgtphUJ0tR4fE4by
         0Y/hGpphdlKqku4FT+Ifihgy4o39Iz2n0eqDDqVRK7N40+8kbxp0Tvzl07IlH9Lza3N9
         we6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhy+2DAsixJOxi+WjEMRQDitYQfsFGF7ja8acp2EW4ZPwh7Eu1IXpbuX6caUQr25pr8mDYrI0bUcHLjnoMoHLod8D5kSRmmXesxzKC
X-Gm-Message-State: AOJu0YyayP8lJWSgbUVOcHcLRgVO+5L9ZxFKlEyh6kTHDWLf6ZVKvzjE
	AauMCC3KjhdiaSjfUQlPWAfKh8/s4p88b5XlD8fWUg8pnZw+ouOSWq8oAinaqzw=
X-Google-Smtp-Source: AGHT+IFWzsOxHlaPNRzn9tJMCDD9xvgFy72YrG+Cms9VKdfMJNuCJnVt6MBvj29PlPa2bSxfks0u9w==
X-Received: by 2002:a05:651c:22e:b0:2ec:1bf8:4650 with SMTP id 38308e7fff4ca-2ec3ceb73dcmr43063781fa.13.1718915801098;
        Thu, 20 Jun 2024 13:36:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d788590sm143581fa.137.2024.06.20.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:36:40 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:36:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Shivnandan Kumar <quic_kshivnan@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Add tracepoints in
 bwmon_intr_thread
Message-ID: <xigukwbvqld5snjykp6h7qwob3r55w4evacbrp7svnzkqrmau3@enk5xlu5bbqn>
References: <20240619135140.3581119-1-quic_kshivnan@quicinc.com>
 <a30fb728-d832-4309-8415-a28fed301e27@linaro.org>
 <461966ee-11ce-45e7-8ea8-abbb71431458@quicinc.com>
 <e84c3ab5-4064-425f-8c04-1d49f0425234@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e84c3ab5-4064-425f-8c04-1d49f0425234@linaro.org>

On Thu, Jun 20, 2024 at 12:48:04PM GMT, Konrad Dybcio wrote:
> 
> 
> On 6/20/24 10:55, Shivnandan Kumar wrote:
> > 
> > 
> > On 6/20/2024 12:46 AM, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 6/19/24 15:51, Shivnandan Kumar wrote:
> > > > Add tracepoint for tracing the measured traffic in kbps,
> > > > up_kbps and down_kbps in bwmon. This information is valuable
> > > > for understanding what bwmon hw measures at the system cache
> > > > level and at the DDR level which is helpful in debugging
> > > > bwmon behavior.
> > > > 
> > > > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > > > ---
> > > >   MAINTAINERS                        |  1 +
> > > >   drivers/soc/qcom/icc-bwmon.c       |  7 +++--
> > > >   drivers/soc/qcom/trace_icc-bwmon.h | 49 ++++++++++++++++++++++++++++++
> > > >   3 files changed, 55 insertions(+), 2 deletions(-)
> > > >   create mode 100644 drivers/soc/qcom/trace_icc-bwmon.h
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 242fc612fbc5..1b410c0183bb 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -18573,6 +18573,7 @@ M:    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >   L:    linux-arm-msm@vger.kernel.org
> > > >   S:    Maintained
> > > >   F: Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> > > > +F:    drivers/soc/qcom/trace_icc-bwmon.h
> > > >   F:    drivers/soc/qcom/icc-bwmon.c
> > > > 
> > > >   QUALCOMM IOMMU
> > > > diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> > > > index fb323b3364db..9b5ac1e62673 100644
> > > > --- a/drivers/soc/qcom/icc-bwmon.c
> > > > +++ b/drivers/soc/qcom/icc-bwmon.c
> > > > @@ -17,6 +17,8 @@
> > > >   #include <linux/pm_opp.h>
> > > >   #include <linux/regmap.h>
> > > >   #include <linux/sizes.h>
> > > > +#define CREATE_TRACE_POINTS
> > > > +#include "trace_icc-bwmon.h"
> > > > 
> > > >   /*
> > > >    * The BWMON samples data throughput within 'sample_ms' time. With three
> > > > @@ -645,9 +647,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
> > > >       struct icc_bwmon *bwmon = dev_id;
> > > >       unsigned int irq_enable = 0;
> > > >       struct dev_pm_opp *opp, *target_opp;
> > > > -    unsigned int bw_kbps, up_kbps, down_kbps;
> > > > +    unsigned int bw_kbps, up_kbps, down_kbps, meas_kbps;
> > > > 
> > > > -    bw_kbps = bwmon->target_kbps;
> > > > +    meas_kbps = bw_kbps = bwmon->target_kbps;
> > > > 
> > > >       target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);
> > > 
> > > This breaks bwmon, as dev_pm_opp_find_bw_ceil is now fed a random
> > > (uninitialized variable) value
> > > 
> > 
> > Thank you for reviewing the patch.
> > I didn't get it, still the variable "bw_kbps" is being initialized along with "meas_kbps". Which variable are you referring to as being fed to dev_pm_opp_find_bw_ceil  with an uninitialized value?
> 
> Oh this one's on me, I skipped over the middle assignment.. Sorry!

Still:

CHECK: multiple assignments should be avoided
#57: FILE: drivers/soc/qcom/icc-bwmon.c:652:
+	meas_kbps = bw_kbps = bwmon->target_kbps;

While we are at it:

CHECK: Alignment should match open parenthesis
#88: FILE: drivers/soc/qcom/trace_icc-bwmon.h:14:
+TRACE_EVENT(qcom_bwmon_update,
+

CHECK: Alignment should match open parenthesis
#109: FILE: drivers/soc/qcom/trace_icc-bwmon.h:35:
+	TP_printk("name=%s meas_kbps=%u up_kbps=%u down_kbps=%u",
+		__get_str(name),


-- 
With best wishes
Dmitry

