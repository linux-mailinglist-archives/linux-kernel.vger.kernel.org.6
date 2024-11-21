Return-Path: <linux-kernel+bounces-417534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC789D5547
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368B7B21AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188621DDC25;
	Thu, 21 Nov 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFfteXDY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6E1D79A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227301; cv=none; b=D8pKV2VXFnOI8FQj56bKXSpXvEoKX5Kdgvc35jkPkkDmucTjbnRk0UdlwVhkpPp+fURgm+XcxIas/z47ri7rA0Hscpm3laEuVQotnO2lrGnwSblnObjYhD40aHt6ocDYPFjV9cfCa+RRzXK7ZKOlxQpjkHtTQCIte2Aie2hUkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227301; c=relaxed/simple;
	bh=MedtbcPE68w6A1t+0iluDLfV5ixEvAxDTp134mz3ta8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk0o5Bic7+O5y5SVQrY9cFX25RNzjmJPs3D4UIRyf1sRYBWNq8WTlmzvAAxek9602LThGq1ooQ1i4zzHjhNyS9QFCfWWU9NJWYaqGKJzatPiLRwHw25dO/XskvHtH+MoOLaZCR+xm9j56r6Nyz350Rf8VWYA6Kgbj4pzR+8S1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFfteXDY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so1581710e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227296; x=1732832096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hi/XevIo1cthNQyPWS6cIe1zGxlhuryhjSAJjzS6ibM=;
        b=bFfteXDY3fA8SWiKKI3+PJ8GBmeGfGdT9gMq0C+aVgXqG9va/5F9z+PUuDuq38sJh6
         CycVpHQPvwrWRXh5JMLHlQcSubmb/AiCbRFHfgigADhhMgzkqlB0zBFIFnqx/w87Hxdm
         2mAVN4cSAKgJMm+kmW9xcxV9EurOgUJGF8Ti89phdDiWa7Q+vVuy0ifDbNHNE8W8aCUS
         d8ibT/xys7ggjN3yq9hG1RSxVsVBVC7O2/SDxA0Zi0sSphMRPsiA0LaLcbDDEsYX6zxi
         WB6I4ncczb5gQ+2UWj7WObdct8lswQx748VQWcP2jT293C5UO5DcVrjDv1NupDEuKmR4
         kHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227296; x=1732832096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi/XevIo1cthNQyPWS6cIe1zGxlhuryhjSAJjzS6ibM=;
        b=CG3u5lhJpSQEvju1f8JjqiWSWK7msXGPGev8NMgfjogZH7afrAeZbVTThQvWWFQ0k7
         n2DAs0VRuXNxNCQwPJIlKMJgGuinOD7Zch/9+NBOf8EREINA10RTo9aEtHD7inhr7ljG
         elZdtjjW8uelWkRjh7DtU8c9JYmCrzQ1EzHqc/XJ6xWxgKroqOIoP3SK9LshZtXMDOz2
         xt0YKQjkzKWWnyRTfiOJ6l+G2CG6QPk/4zkRbBdU5JbNZOqCWticaegs9Cr0mby+lrP7
         kxQfMaOtIuzx1hoVVYZCVJpY+Mgn+w6KgHe9X2flnidIe9dfnt/kptbM6vlg/ADXd4mI
         wBmg==
X-Forwarded-Encrypted: i=1; AJvYcCWwWrrLXMeMNrbtxXnQTHIZOpuavACaI38L6OPnC4sUtNnFeSb6t76ZqHqFuCZix+aXKLw2glb9mbJY5bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChtkAcCAmbX2iPgl0uLnHYpwNablIS8YClBrPmIX5u9sqotzw
	qbUhb2O7g5LoWTNvxx37dtNw/QdoyMtBMYzl+HYgkDiVfNIo+qkXTVP0lPLj23Q=
X-Gm-Gg: ASbGncvc32jxzKOURE52CDURPRUf7z8GBOjTiQXcn6/szzrztDde096JLHBTvjpa7aa
	1vphBi2PhZvJAj+MeaGkjGMTuFrw172GCzl5Hher5xXLIKMmx9j6H0i8rcVpFUTmO7T/uFvLxUg
	9/BS3KLlqgy23teHDUxCCxhmhqwOl0clgpgi6Xel10w2rkXqiJspDw+mgXUleuEO0s+aKKMOrUr
	wY1UheSZIKKVmad2rjPqgyjm5HvpVOxS/lq2DuvYuII95zcic/ZlmrfTVXPY91rX2NsgeGzHR+W
	7GPJzuOxfZu9UZNt55wrUp5SvaC11g==
X-Google-Smtp-Source: AGHT+IGV/C1nBqdFgvJeMR65ubRSZVeKyIlihXhmqtyVdAP02zb8OqzD3cvC0frxkEgh3Df6nv5ppg==
X-Received: by 2002:a05:6512:304a:b0:53d:d0dd:8dae with SMTP id 2adb3069b0e04-53dd36a075fmr261668e87.17.1732227296249;
        Thu, 21 Nov 2024 14:14:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd248b42esm91463e87.206.2024.11.21.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:14:54 -0800 (PST)
Date: Fri, 22 Nov 2024 00:14:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
Message-ID: <u2jfxvmn6qazhpvmehrh7ifc3ei7qucuwbk5dq5jzpoqkxmdbk@tsx4di2fdj4h>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
 <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
 <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>

On Thu, Nov 21, 2024 at 11:33:04PM +0530, Raviteja Laggyshetty wrote:
> 
> 
> On 11/21/2024 5:28 PM, Krzysztof Kozlowski wrote:
> > On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
> >> Add Epoch Subsystem (EPSS) L3 interconnect provider on
> >> SA8775P SoCs with multiple device support.
> >>
> > 
> > 
> > ...
> > 
> >> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
> >> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
> >> +DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
> >> +DEFINE_QNODE(osm_l3_slave, 16);
> >>  
> >> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
> >> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
> >>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
> >>  	[SLAVE_OSM_L3] = &osm_l3_slave,
> >>  };
> >>  
> >> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
> >> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
> >> +DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
> >> +DEFINE_QNODE(epss_l3_slave, 32);
> >>  
> >> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
> >> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
> > 
> > 
> > I think dropping const makes the code worse, not better. Commit msg does
> > not explain all these changes and I could not figure out the intention
> > (except modifying but that's just obvious).
> 
> EPSS L3 on SA8775P has two instances and this requires creation of two device nodes in devicetree.
> As Interconnect framework requires a unique node id, each device node needs to have different compatible and data.
> To overcome the need of having two different compatibles and data, driver code has been modified to acquire unique node id from IDA 
> and the node name is made dynamic (nodename@address).
> Updating node id and node name is not possible with const.

Has this been described in the commit message? No. Have you had similar
questions since v1? Yes. What does that tell us?

Also, while we are at it. Please fix your email client settings to wrap
message body text on some sensible (72-75) width.

> > 
> > 
> > 
> >>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
> >>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
> >>  };
> >> @@ -123,6 +125,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
> >>  	.reg_perf_state = EPSS_REG_L3_VOTE,
> >>  };
> >>  
> >> +static u16 get_node_id_by_name(const char *node_name,
> >> +			       const struct qcom_osm_l3_desc *desc)
> >> +{
> >> +	struct qcom_osm_l3_node *const *nodes = desc->nodes;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < desc->num_nodes; i++) {
> >> +		if (!strcmp(nodes[i]->name, node_name))
> >> +			return nodes[i]->id;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >>  static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
> >>  {
> >>  	struct qcom_osm_l3_icc_provider *qp;
> >> @@ -164,10 +179,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>  	const struct qcom_osm_l3_desc *desc;
> >>  	struct icc_onecell_data *data;
> >>  	struct icc_provider *provider;
> >> -	const struct qcom_osm_l3_node * const *qnodes;
> >> +	struct qcom_osm_l3_node * const *qnodes;
> >>  	struct icc_node *node;
> >>  	size_t num_nodes;
> >>  	struct clk *clk;
> >> +	u64 addr;
> >>  	int ret;
> >>  
> >>  	clk = clk_get(&pdev->dev, "xo");
> >> @@ -188,6 +204,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>  	if (!qp)
> >>  		return -ENOMEM;
> >>  
> >> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
> >>  	if (IS_ERR(qp->base))
> >>  		return PTR_ERR(qp->base);
> >> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>  
> >>  	icc_provider_init(provider);
> >>  
> >> +	/* Allocate unique id for qnodes */
> >> +	for (i = 0; i < num_nodes; i++)
> >> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
> >> +
> >>  	for (i = 0; i < num_nodes; i++) {
> >> -		size_t j;
> >> +		char *node_name;
> >> +		size_t j, len;
> >>  
> >>  		node = icc_node_create(qnodes[i]->id);
> >>  		if (IS_ERR(node)) {
> >> @@ -251,13 +276,29 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>  			goto err;
> >>  		}
> >>  
> >> -		node->name = qnodes[i]->name;
> >> +		/* len = strlen(node->name) + @ + 8 (base-address) + NULL */
> >> +		len = strlen(qnodes[i]->name) + OSM_NODE_NAME_SUFFIX_SIZE;
> >> +		node_name = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> >> +		if (!node_name) {
> >> +			ret = -ENOMEM;
> >> +			goto err;
> >> +		}
> >> +
> >> +		snprintf(node_name, len, "%s@%08llx", qnodes[i]->name, addr);
> >> +		node->name = node_name;
> > 
> > 
> > Why the node name becomes dynamic?
> > 
> > Best regards,
> > Krzysztof
> 

-- 
With best wishes
Dmitry

