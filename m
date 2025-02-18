Return-Path: <linux-kernel+bounces-518645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4EA39285
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5B27A3333
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8981B0434;
	Tue, 18 Feb 2025 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N8ORQG2V"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DF140E30
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856032; cv=none; b=owNiQngZJvNGp0ARZIBdFJmGH+lHWVaYav9Lw07fHYDeL1El8VVNqJpU5qs9UxwxVGYT/g6gcRS52UYsEJAkzEKLqsW23hIMpA87pKokq34DOauYWH4ophVOlFd17BRDxebs3MJ4nXYDXQUkFB90HYVYzdTvHYdcx7iPFmpqz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856032; c=relaxed/simple;
	bh=k0sFj2Bsq3MDcbBjwQ92wz0V2yBxHV7Q1q+yhc+8RPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak26yyzkspv8fAByygJbqmHl4BRwDbMqM1xUKetalgttKlibN85PEPHsZyU/A0hyoyRYnwnxgtGGZ4ZN+4MNu0c9sWJJhxIlW7OGCf2f7vZbnfsOOdyKNzPkfxAzgVqaDyhC2JipWZbYjCpIGcFvDGWfr8kmYgk6dVeoKiH9Op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N8ORQG2V; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739856024; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uVwkBCxygA1RvgrDgXMy6FPGDAFxHfk0QHJm5ttHkG8=;
	b=N8ORQG2VNm1t9bCGo6rBP/fA1sDjfqs5+OvBXJeIT0OjOAlN0h9mlyV297VV1akJL0oVvMEDXKkNs3NM9mRpgwJL9DciB7ket4gaCeFWgfgBSSD0Nge5sevbsyoczFNaDp9gJblwcXq42DmdmY4ruED5+pe8tqMUlYLhXNXFaNI=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPkWgU._1739856022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 13:20:24 +0800
Date: Tue, 18 Feb 2025 13:20:21 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Jing Zhang <renyu.zj@linux.alibaba.com>,
	ilkka@os.amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Zhuo Song <zhuo.song@linux.alibaba.com>,
	jie.li.linux@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: Fix and refactor device mapping resource
Message-ID: <Z7QYlUP6nfBNMXsv@U-V2QX163P-2032.local>
References: <1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20230327140536.GB31752@willie-the-truck>
 <b90d3b99-a4d2-86f5-be9a-803b33d787b6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b90d3b99-a4d2-86f5-be9a-803b33d787b6@arm.com>

Hi Robin,

On Mon, Mar 27, 2023 at 03:27:39PM +0100, Robin Murphy wrote:
> On 2023-03-27 15:05, Will Deacon wrote:
> > [+Robin and Ilkka, as they contribute most to this driver]
> > 
> > On Thu, Feb 16, 2023 at 04:17:50PM +0800, Jing Zhang wrote:
> > > The devm_platform_ioremap_resource() won't let the platform device
> > > claim resource when the ACPI companion device has already claimed it.
> > > If CMN-ANY except CMN600 is ACPI companion device, it will return
> > > -EBUSY in devm_platform_ioremap_resource(), and the driver cannot be
> > > successfully installed.
> > > 
> > > So let ACPI companion device call arm_cmn_acpi_probe and not claim
> > > resource again. In addition, the arm_cmn_acpi_probe() and
> > > arm_cmn_of_probe() functions are refactored to make them compatible
> > > with both CMN600 and CMN-ANY.
> 
> No, the whole point of CMN-600 probing being a special case is that the ACPI
> and DT bindings for CMN-600 are special cases. In ACPI, only ARMHC600 has
> the two nested memory resources; all the other models should only have one
> memory resource because one is all that is meaningful. See table 16 the
> document[1] in where the description of ROOTNODEBASE says "This field is
> specific to the CMN-600 device object."
> 
> Similarly in DT, "arm,root-node" is only required for "arm,cmn-600" - it
> didn't seem worth overcomplicating the schema to actively disallow it for
> other models, but that is supposed to be implied by its description as "not
> relevant for newer CMN/CI products".
> 
> If you're hitting this because you've written your ACPI DSDT incorrectly,
> it's a sign that you should fix your DSDT.
> 
What about following change? Thanks.

-static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
+static int arm_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
 {
-       struct resource *cfg, *root;
+       struct resource *cfg, *root = NULL;

        cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        if (!cfg)
                return -EINVAL;

-       root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-       if (!root)
-               return -EINVAL;
+       if (cmn->part == PART_CMN600) {
+               /* Per "ACPI for Arm Components" Table 16, CMN600 has
+                * nested root node memory range.
+                */
+               root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+               if (!root)
+                       return -EINVAL;
+
+               if (!resource_contains(cfg, root))
+                       swap(cfg, root);
+       }

-       if (!resource_contains(cfg, root))
-               swap(cfg, root);
        /*
         * Note that devm_ioremap_resource() is dumb and won't let the platform
         * device claim cfg when the ACPI companion device has already claimed
@@ -2534,7 +2540,7 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
        if (!cmn->base)
                return -ENOMEM;

-       return root->start - cfg->start;
+       return root ? (root->start - cfg->start) : 0;
 }


Regards
Yin, Fengwei

