Return-Path: <linux-kernel+bounces-346524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E97998C58B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F223284145
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027591CB30F;
	Tue,  1 Oct 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="aQETQKNw"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6931EB46
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808340; cv=none; b=aPSJmH8YgWHR8L49srpSnEZZeyqlbtQ22XASDNpWYoRa8d/vNq8H8Yd3OvGID2ggXTIwm5vjeCNZyTAGilYu7FPcTrAjzUrlAfrwNt4POlbTxS3tcm2QHg+G5nrxJMKXSi7D+Q7yTznJPa4sZOGPGP1viSMZUXSG85aA2MopxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808340; c=relaxed/simple;
	bh=hzk7ed047btaG7zO2OKAi993f6RPec/nCfmPNCCo2nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7MiU5cUrSbkqbKPpMNBqqRF7Ew7w+SYENMI2o9F81JLfb7SIiCc4JxN0TOENjFRc+fGsGBSIe5FdDKFMhz3YmZhE/2vkG7N4jXgCL18MGCENs1IsZj81ioFYXrXKJUyVy4UXiozUawfzPuWKDmCcHbRlRIW4AFsBYIqrIf8cFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=aQETQKNw; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491I3GBf026958;
	Tue, 1 Oct 2024 18:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=rvuAxIHhdhjicvZq90iAPD4
	g05JZxBgXTxrlCytcU0M=; b=aQETQKNwBYrX0tluDiblUQBOblwROvxp9A+pfG4
	O6FQ6a0BFlzLH3ilMW+NDGYhwj96Cb0qSzpuxu2xVzfXeY3GPRQoWSG7zf7vAv91
	ORHznx9myqZjm0tH4kMwoLQKxMONf5hnMBhy6cmyPpa1jcCSXXq1RMwYkl8FJEcN
	cghLAxsrDpa9XZMJ4zbMDd3HY6F0FNpRAwphM180EAgsTAMXdJBCtk06fylh0R+v
	Zl52Cd/Kxy71wOyAcBBtn5DUaT9LGxh43nk+sTNuFZUudo0mwNpQpykmBxtZ7PgM
	0h7It7yvYpv7MJbBBbfWcfLU6/UirvVxFtE2Fvrql/3m9vA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 420hpqb3u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:45:30 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 55CDA1374E;
	Tue,  1 Oct 2024 18:45:29 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 83EBA805637;
	Tue,  1 Oct 2024 18:45:28 +0000 (UTC)
Date: Tue, 1 Oct 2024 13:45:27 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] RAS/CEC: Should cec_notifier() set MCE_HANDLED_CEC after a
 soft-offline?
Message-ID: <ZvxDRzW6_5dn2_X6@hpe.com>
References: <Zvw5SJQwBB-xo82K@hpe.com>
 <SJ1PR11MB60833BFA53B5E617C526828EFC772@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60833BFA53B5E617C526828EFC772@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: QRXe2zWKbKAYg0UX6ToMYB9j2Hc6e-mn
X-Proofpoint-GUID: QRXe2zWKbKAYg0UX6ToMYB9j2Hc6e-mn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010122

On Tue, Oct 01, 2024 at 06:24:19PM +0000, Luck, Tony wrote:
> > I noticed CEC should indicate whether it took action to log or handle an error
> > by setting MCE_HANDLED_CEC (commit 1de08dc) and that EDAC and dev-mcelog should
> > skip errors that have been processed by CEC (commit 23ba710).
> >
> > cec_notifier() does not set MCE_HANDLED_CEC when the offlining threshold
> > is reached in cec_add_elem() because the return code is not zero. Is that
> > intentional?
> 
> Kyle,
> 
> It seems a bit murky. You are right that cec_add_elem() appears to expect three
> different actions from its caller based on the return value being <0, 0, >0. But
> cec_notifier() only has two actions (0 and !0).
> 
> But I think this may be OK. The main purpose of CEC is to avoid over-reacting
> to simple corrected memory errors. Many (most?) are due to particle bit flips and
> no action is needed. So setting MCE_HANDLED_CEC for the case where CEC
> counted the error, but took no action feels like the right thing to do.
> 
> Conversely, if action was taken (because this was an error that repeated
> enough to hit the threshold) the we do want mcelog/EDAC to give additional
> reporting.

That makes sense. Thank you for the explanation.

Thanks,
Kyle Meyer

