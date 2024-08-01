Return-Path: <linux-kernel+bounces-271849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD89453E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BFDB248BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900A14B07C;
	Thu,  1 Aug 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wT6S5MbJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AA4778E;
	Thu,  1 Aug 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545924; cv=none; b=fvx8YsMBLc7yEE1IvOY7qfVXUYpIjWCN/UVgtwPWVjjdDB7Q/uaVWL0diqK7ckybBdGS9khrymbHfUuel9RxxUbPpDmjAzW08nk+XC1WzYUknpw6+pAH+64ik3V7y/bADOiREELKfZa1cAGczvirYm25O0tGCnwbVCboEh2aW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545924; c=relaxed/simple;
	bh=FcAem7aUUBBy0WquVryjtx25L+UPGEpp4XWeQTHcp/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO+dEkX0vmSU3AvgcakAbTt74LIXkZFklstvm9Y7BcqgHZM2O+q5noZhiDYhFbTpUMDJZ2LEzdiZ0ZrArfJHSzbSobl2s1LI9DOI7PCIboBh0oU89bF7XX2PimBaaNV2p3JFGNtSR+o2l+Tlgx83+4cgIR9ygjS63uaHr/AS7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wT6S5MbJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FcAem7aUUBBy0WquVryjtx25L+UPGEpp4XWeQTHcp/U=; b=wT6S5MbJCHRyNGikCOce6ZNA1s
	zgjGK9jfKF6BeR+6YuUdvOspEqVC39dpHzmz2bH1nRuSFJ++1EW06K2xvAIFl+WowlNcnUW3uywSn
	UJGMJo9vj3Lg174qVAlxoRdsmMy0e8epCv4wek+kKc3NpuFtdG+YL4CCOL12GL/fwItkHwphxFjVM
	28qvT2/CnM8ZoPpQ/Uo+x2yUWL4pXgsYQMS1Ud25PM9tGi6nvI7yMnAr1d6t+JJzaxYGqqKd+foFQ
	wB9+SYLN48xfhVTvkLFGV9Ks1nULnXwoysr7KwC1rklUzYhwsNJbVNIPrffHGRIWVceFqM3DFepEq
	3Jn0wOeg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZcsh-00000000ILP-2PcX;
	Thu, 01 Aug 2024 20:58:39 +0000
Date: Thu, 1 Aug 2024 21:58:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] "nosnp" sev command line support
Message-ID: <Zqv2_wQbCLN_AOfy@casper.infradead.org>
References: <20240801205638.6603-1-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801205638.6603-1-papaluri@amd.com>

On Thu, Aug 01, 2024 at 03:56:36PM -0500, Pavan Kumar Paluri wrote:
> Provide "nosnp" boot option via "sev=nosnp" kernel command line to
> prevent SNP-capable host kernel from enabling SEV-SNP and initializing
> RMP table.

Congratulations on using three acronyms multiple times and defining none
of them.

