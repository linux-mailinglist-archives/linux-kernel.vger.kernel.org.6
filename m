Return-Path: <linux-kernel+bounces-558037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1EFA5E0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B453A5DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790D254846;
	Wed, 12 Mar 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hqJU6uT4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217518DB0B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794230; cv=none; b=Kn9g9ko7O3hT1Btm6B2SFO88Aq5VYaWqPXGLcRROXez0TVzQzi+ESnn7dNhrNykJtNfRq8VoFGuBBBFhbD8W53QAv9FY6QP1gDWxQ5ZPbpRxDv5mqrpUfItEYr8BIjvbLHPIUmOFHkL5ngo3UbP+xxaHZUtHMBxpXINVAhs9534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794230; c=relaxed/simple;
	bh=F9DKOVMq2swRSUrdwejEWWecXErHBg928DWkynt2bOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpo70zpcZ+VPmSvTSFw5kO2in8KDL+tFI9qNJFvb48JJlSXuYsA1B69bPrjVbdPTpyA6vr30/OG7PY7uajUpiHMqTDLFBBJ1ddl8UbOpwTVZVgaB3ZxmXaedoBT0oWvz6XrkCEG/2sqRyaOdHBsWbrcLY67z1mH01YU+fzDaCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=hqJU6uT4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 98D58455FD;
	Wed, 12 Mar 2025 16:43:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741794227;
	bh=F9DKOVMq2swRSUrdwejEWWecXErHBg928DWkynt2bOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqJU6uT4X7Sh9DhDDqUIcgg0RQdEjVy6ZMJo5zor4OBFYr9wbaM7gUC6lvq8toIG0
	 CR7wj1m49YQgx0g8aIABk5kFlZqD74E8fiUAJCq1MHD3ddQFO8iQVu5ams0uvajKgH
	 hXJFQ7bITxg0Jp/gLkUue2omnOgzdXCHq2mZh1Fc1qOW/s697lAtjdznk49GYaPT8n
	 4dLfbMej3MnMl5SUt5feit/a7txset11jAD2bahZSeMBmoSaQKoGFrIkErkZxzzO0I
	 cwlIq3QV0srAGt3ljMsWtfFwCjtATFoK/j5oAbtcNXobm8YHrwFIekINIqibgoLOIi
	 tS+7JFz1P1p2w==
Date: Wed, 12 Mar 2025 16:43:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/2] x86/coco/sev: Move SEV SYSFS group to
 /sys/hypervisor/
Message-ID: <Z9GrsoIP_NWjPPC-@8bytes.org>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-2-joro@8bytes.org>
 <e6046eff-0b16-4ae7-a8f5-0f765a7e2836@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6046eff-0b16-4ae7-a8f5-0f765a7e2836@oracle.com>

On Wed, Mar 12, 2025 at 03:32:04PM +0000, Liam Merwick wrote:
> one suggestion below but either way,
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks!

> > +	sev_kobj = kobject_create_and_add("sev", hypervisor_kobj);
> 
> Given hypervisor_kobj is created elsewhere, and the caller of
> hypervisor_init() doesn't check for ENOMEM, would it be worth
> adding a check here that it exists before using it?

Hmm, dunno, I guess it would make things slightly more robust. On the
other side all existing users of this object already assume a successful
initialization.

Regards,

	Joerg

