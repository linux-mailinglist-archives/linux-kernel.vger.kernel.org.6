Return-Path: <linux-kernel+bounces-355116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DE994789
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590B61F22D22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E971D362B;
	Tue,  8 Oct 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5rZzCog"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9B1D2F58
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387839; cv=none; b=BCzpzocAhhiSPIlv7xe7NxrCBKT+CW3RZwOT3OEnsSa5SINYsO2ZLKNOrbeltk8+Q+7PqdZ2HA1jCRkK6pgQMH7SKmmhIoTFI7POv4r7Ab1EhSuFsBH6g79WSagyT3jGX9hnh27+q6iFhWdXyOVDWeRTq/U7rE5su8RffilAUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387839; c=relaxed/simple;
	bh=zBXQMo+hM07ISY9mj7NP1MH4OBDtnawZVDrwzKCnAzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO/JGkDUT/mX1m+BwNzX4lvcCZWV0I7kxQ+ClCNVM7XsYUasL5arNQQGp+Pl4tUjLoFrkVgYfVADFGzx/RNXkQFEpjhyKDF6kYvWAWtN2rTJe2+fCmwgSBy7kQb9JKdJNHz3YLCH6HNyQyLSRF+kn9tL+pBXnzFEkY5MM/peGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5rZzCog; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so6321612e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728387836; x=1728992636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZEbLtJwY4BWNq5AUUgxIr2eH5iz7eEs893mPnqpT/g=;
        b=H5rZzCoglvsytILw/YD/s3urTa2QSNm+qaIx16pbEbVSERup97JooTcYVGOpGBpoab
         47PPHREj7QhaF7OFfbLCRuzpuDgH4iPfcn+ox29GS8ot1tD6JhdwBwPTyofvIj4F/B2P
         ScgVh0MKjELuk7SC08ooZlIkBRJHmXeFohyexPbbbfkWIkrLKbUwsfLSLnW9h+f76W4z
         igw3IVlj2s1D9f0C0xLLGVZJImbRTa38HPOUZtnIDCsmGLEHEb60ihZ8uE4fqe2bwyca
         tejrAvBe1UdEJ2QPMR970JO2x/V81JTC8QMW05/Hpa8pmTS6fgisWrfUX3hIDN6KLXdm
         V9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387836; x=1728992636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZEbLtJwY4BWNq5AUUgxIr2eH5iz7eEs893mPnqpT/g=;
        b=BZsTvhbZpCbcYLbECqlwQwv5nc2UM9pJK6R783et00/HH6zr+XYax6lm0spr/d91k0
         e4rlV0gogWXlLkwg9DKWU7dM+uDimV/4MJ9C+/GnpES0cgqzd68FytI3KMq631TvnXna
         mJQ51VmmdBqlKKQNH+wqQxIHb2Pcgs9xtLWhky8fiMt/b/gO3Vd1hQxV+tEgBfb+7YWi
         WG3fsIjeE2mGmTH4EYGYLUOOl1JxA4GBWWD7uva3ImxqHk9PfL6M+uWegPfHdkxPoWrN
         ORWxiynoOa2smyYw9+rLpZl1BVcgE+nCa9YnCnMdP1MmqVa3tgEqNBRPlp3kJQEvQfAJ
         7cAw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7qVPqsjeGCmIehZqvtY+VkiHeWwNFbyQAeaiePUD16bzPMSUEnmTb8iPqtNEiO4EEGwhWbn0hVzIRPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8O+p0Oacr31Es26OekUK7N2/FQDOMPUR4PAHIbNBT9Nkrww+
	7jBKsRvY/EKFDRmDYZtpMMd82bmKHrvMJkPM316Uq2YSoRQ8UrkYekLMetaWekM=
X-Google-Smtp-Source: AGHT+IFRmk8nWaWReszOVxOJdsqYxPAYN9CRreBKrrphj5YabLesxtoOk1jlIBv6qgKrPV3VYMhaNQ==
X-Received: by 2002:a05:6512:4026:b0:539:9f52:9e4 with SMTP id 2adb3069b0e04-539ab9e40eemr7285600e87.48.1728387836010;
        Tue, 08 Oct 2024 04:43:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d168sm1178132e87.142.2024.10.08.04.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:43:55 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:43:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware: qcom: scm: Add check for NULL-pointer
 dereference
Message-ID: <4j7qx24xwxo4l4bfagjob2pb2taadqlc22gxeiwjttfwrtqua7@eheozhig65gm>
References: <20240920181317.391918-1-quic_wasimn@quicinc.com>
 <zxzjrnmoun6fm2tzrx6eaxbvy5kddvld7hezknt7k7mvfcqw5a@u3fgfo5yqw4q>
 <ZwTvsyUv+ajI5suH@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwTvsyUv+ajI5suH@hu-wasimn-hyd.qualcomm.com>

On Tue, Oct 08, 2024 at 02:09:15PM GMT, Wasim Nazir wrote:
> On Sat, Oct 05, 2024 at 09:46:26PM -0500, Bjorn Andersson wrote:
> > On Fri, Sep 20, 2024 at 11:43:17PM GMT, Wasim Nazir wrote:
> > > Avoid NULL pointer dereference while using any qcom SCM calls.
> > > Add macro to easy the check at each SCM calls.
> > > 
> > 
> > We already have a way to deal with this in the general case. Client
> > drivers should call qcom_scm_is_available() before calling the scm
> > interface.
> My intention is to check all corner cases and provide proper error logs
> wherever the check fails.
> 
> There is no active case/example where it is failing but irrespective of
> client (using qcom_scm_is_available()) or driver using any SCM calls,
> want to add this check so that we don't need to fall into case
> where we need debugging of NULL check and error logs are enough
> to detect the problem.
> > 
> > Unfortunately your commit message makes it impossible to know if you're
> > referring to a case where this wasn't done, or isn't possible, or if
> > you've hit a bug.
> > 
> > > Changes in v2:
> > > - Cleanup in commit-message
> > 
> > This goes below the '---', by the diffstat. I don't know why you don't
> > have a diffstat, please figure out how to make your patches looks like
> > everyone else's.
> 
> Will make this correction in next patch.
> > 
> > > 
> > > Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> > > 
> > > diff --git a/drivers/firmware/qcom/qcom_scm-legacy.c b/drivers/firmware/qcom/qcom_scm-legacy.c
> > > index 029e6d117cb8..3247145a6583 100644
> > > --- a/drivers/firmware/qcom/qcom_scm-legacy.c
> > > +++ b/drivers/firmware/qcom/qcom_scm-legacy.c
> > > @@ -148,6 +148,9 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
> > >  	__le32 *arg_buf;
> > >  	const __le32 *res_buf;
> > > 
> > > +	if (!dev)
> > > +		return -EPROBE_DEFER;
> > 
> > -EPROBE_DEFER only makes sense to the caller during probe. In all other
> > cases this is an invalid error value.
> 
> I am returning EPROBE_DEFER so that any probe can use the return value
> to retry while at non-probe place it can be treated as normal failure
> (-ve value return).
> Please let me know if anything better can be used at this place.

Just drop it. This adds no benefits. If SCM has probed, then __scm->dev
is set. If it was not probed, then the code already oopsed by
dereferencing NULL __scm call.

> > 
> > > +
> > >  	cmd = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
> > >  	if (!cmd)
> > >  		return -ENOMEM;
> > [..]
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > [..]
> > > @@ -387,7 +397,7 @@ static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
> > >  	desc.args[0] = flags;
> > >  	desc.args[1] = virt_to_phys(entry);
> > > 
> > > -	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
> > > +	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
> > 
> > I don't think you understand why this is written the way it is.
> Here I am removing this check as before reaching here __scm variable is
> already checked for validity.

No, it wasn't (or somebody removed too much of the context)

> > 
> > >  }
> > > 
> > [..]
> > > @@ -1986,6 +2113,13 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > >  	/* Let all above stores be available after this */
> > >  	smp_store_release(&__scm, scm);
> > > 
> > > +	__scm->reset.ops = &qcom_scm_pas_reset_ops;
> > > +	__scm->reset.nr_resets = 1;
> > > +	__scm->reset.of_node = pdev->dev.of_node;
> > > +	ret = devm_reset_controller_register(&pdev->dev, &__scm->reset);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > 
> > Why did this move?
> &qcom_scm_pas_reset_ops is the first ops which might use __scm, so moving its
> registration below smp_store_release(&__scm, scm) so that __scm is set
> before utilizing in reset-ops.

So scm->reset should have been prepared before smp_store_release() and
only devm_reset_controller_register() should be moved after
smp_store_release().

> > 
> > Regards,
> > Bjorn
> > 
> > >  	irq = platform_get_irq_optional(pdev, 0);
> > >  	if (irq < 0) {
> > >  		if (irq != -ENXIO)
> > > --
> > > 2.46.1
> > >
> 
> Regards,
> Wasim

-- 
With best wishes
Dmitry

