Return-Path: <linux-kernel+bounces-325947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392097601C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1A5B2247F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BB1885AD;
	Thu, 12 Sep 2024 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S4xAefH2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC8A47
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116196; cv=none; b=IcokpLGljL66wPBqfN0nPXecmgIS+aY9psoX5LxwSFc2/9XLumWAUfekyl0P6KKsdEkGhjCrTJBnDx0AbMZAJwH8shJMcZ9+18tMg8PFN/BqzU3gP5mtmB8j3NwJ3bre1jtcJWaE85a+z9mNntcwAFP6BmEssXSBdkOqZJQWXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116196; c=relaxed/simple;
	bh=6Ydd8hYQ1veO1ghv2CSyamJtHmIaLU6XmKYs6l1JDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2h9IstK41k6/phqQnxTFFTN37KlZ4btA82R7NqMZDvrCOGwLI2XF5Exi6pnTnMF3fI4f8PMYW90H47q9wLCfx9YWuKnqsfhqnQ9nn84bUm5elR0jOz+skrNbHRLGCtyp29JTD3YL/FBNVRdJICbjZm7wOsBnQnqcSbdSW9zuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S4xAefH2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Y7fdCnqs5b3VnAoZWKrjPkiMNl58Ftcb2DcpAcXLHeg=;
	b=S4xAefH2NIYAnnWpjrb0LnyqxL1lWGgoZWhkdXVOP2w5DynW7pvJLKkddWGJFK
	Jqt3oo+vv9GikwnTQmTDetqwTUK3aDEmukjkcCxSXfUsyYYW92wp57EnDhtACk44
	K1YCihvAWUnx6oFImuZVA0okHLYD5ETBYvBFC3tO8dSCg=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wCHLfhAceJmmrkbAA--.2293S2;
	Thu, 12 Sep 2024 12:42:41 +0800 (CST)
Date: Thu, 12 Sep 2024 12:42:40 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: suravee.suthikulpanit@amd.com, will@kernel.org
Cc: vasant.hegde@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Should the return value of the rlookup_amd_iommu be checked?
Message-ID: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wCHLfhAceJmmrkbAA--.2293S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw17JF1kGr4UXrW7XFyUAwb_yoWfGFX_ur
	ySvFy8Ww4rAw4UArWjqFn3Xr95Gw18ZFZY934rKF95Gw1Sqa1UuFWDXr42vrZ7GwnrJFn5
	Jrn5J3ZxGF9xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUepMKtUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwVYamVOGR9W6QAAsK

Hi,

I reviewed the following code:

1592 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
1593 {
1594 	struct iommu_dev_data *dev_data;
1595 
1596 	list_for_each_entry(dev_data, &domain->dev_list, list) {
1597 		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev); <-
1598 
1599 		set_dte_entry(iommu, dev_data); <-
1600 		clone_aliases(iommu, dev_data->dev);
1601 	}
1602 
1603 	list_for_each_entry(dev_data, &domain->dev_list, list)
1604 		device_flush_dte(dev_data);
1605 
1606 	domain_flush_complete(domain);
1607 }

The "rlookup_amd_iommu" function may return NULL, and the "set_dte_entry" function
will call "get_dev_table" which will dereference the NULL pointer.

Is this an issue that may cause panic? Or will "rlookup_amd_iommu" function never
return NULL?

-- 
Best,
Qianqiang Liu


