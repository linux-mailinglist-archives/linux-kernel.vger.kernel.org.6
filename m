Return-Path: <linux-kernel+bounces-375850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02669A9BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F01B253AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415F158D7B;
	Tue, 22 Oct 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaeRW/5y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C587156871;
	Tue, 22 Oct 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583958; cv=none; b=qmNuxwYo46Dnp93i8b2aSXfpjt6n1EG4PWfMcla+zEyVc1yJCzfcAtUa22Y9/UdZsxwET7qIPPZ0V6mSHJW9+fJTFoRmIs1Nw7slbNYBx63q2OwEdiH/Toeh/ln4z+lXcoL0ZllSP0aDGxWkUpOgiezz1A6OLTXmYhbIvL9rc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583958; c=relaxed/simple;
	bh=xtYNyFIh5X3wQwu6tv1en3u9JEy7crw/qZFBmrVqjmE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ei1Sel4DOAAezIMsTHlABS2EcuUtfapBsMf7YEUPzlhkpTskbHM7MfDtgo47+Vu2rVcy1VT6odXq7vqchtibZSNWgkkHsHBl5LZY5ZVXnZTJiEXgV/edM16SwPbACRgMqZvytVmOPo4zMGSxSP3Nq+Sz51KLNvu0pNKZh6WqTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaeRW/5y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583957; x=1761119957;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xtYNyFIh5X3wQwu6tv1en3u9JEy7crw/qZFBmrVqjmE=;
  b=EaeRW/5y3cMKN/xDQCA4gthqVZ0SkzdUhtlLqVZWzJ7i+IxC32MJqN93
   SjNsQ+o7hXPe0szrnueEykBmVVYNKOgn1v9R2pR5kIPh7XQTayBrMkGTp
   ECYGqdlHy4KZAQW1OGvBoJ8YzRDJU4075RTE19GDaLha5gc+X/ynBMqgV
   b3BNdEcecugyITvp05DibLuMqbqAtRVbt5ahfWVBap+cJicn825+Z9QhN
   /NbbBOwpo5zsXpJAyTDZxH881yIS82hlNMHkBYSDTA0SmnYFVR3WNdVpZ
   13DBH0uula+NUiQfzigVDmGRYi5d/CmviCA12AEFGapj+hBQObM4saIvd
   Q==;
X-CSE-ConnectionGUID: JjiD/JDaQdWSAUbxBfYmVg==
X-CSE-MsgGUID: gUl4o5sPRge5IJsuTf3i/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39686017"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="39686017"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:59:15 -0700
X-CSE-ConnectionGUID: nuj6vTgsSkyyGy3VGIB5bA==
X-CSE-MsgGUID: Xe4vtpo5TqeWW9rPx21CZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="117207945"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:59:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Oct 2024 10:59:10 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] platform/x86: think-lmi: Allow empty admin
 password
In-Reply-To: <20241021193837.7641-3-mpearson-lenovo@squebb.ca>
Message-ID: <6ced79c1-4bff-f44c-c61c-56ae7d9758c3@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20241021193837.7641-1-mpearson-lenovo@squebb.ca> <20241021193837.7641-3-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Mark Pearson wrote:

> SVP = BIOS Supervisor/Admin password
> SMP = BIOS System password
> 
> If SMP ACL is enabled in the BIOS then the system allows you to set the
> SMP without a SVP password configured. Change code to allow this.
> BIOS will return permissions error if SVP is required.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/think-lmi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 46ab82fb2898..751e351dfc42 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -469,7 +469,12 @@ static ssize_t new_password_store(struct kobject *kobj,
>  		if (ret)
>  			goto out;
>  
> -		if (tlmi_priv.pwd_admin->pwd_enabled) {
> +		/*
> +		 * Note admin password not always required if SMPControl enabled in BIOS,

is not always required

> +		 * So only set if it's configured.
> +		 * Let BIOS figure it out - we'll get an error if operation not permitted

operation is not permitted.

Please reflow the comment to fit into 80 chars (this only relates to 
comments to keep their line lengths readable without large eye movement).

> +		 */
> +		if (tlmi_priv.pwd_admin->pwd_enabled && strlen(tlmi_priv.pwd_admin->password)) {
>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>  					tlmi_priv.pwd_admin->password);
>  			if (ret)
> 

-- 
 i.


