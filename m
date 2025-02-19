Return-Path: <linux-kernel+bounces-522068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737DA3C56F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5824B167D62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA9212FA8;
	Wed, 19 Feb 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2LPc7GF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329531DE4C6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983763; cv=none; b=HMUoDR5gRaYEKmB/d2HgjpVvpGMJAvTLLeJlWpsQ6ldWwpecUtlV+L6U2+fCX4jNDpjyY98pH5j7WtYe7H7EIEHPZt13sdjPNXUw1hgKaI6oIFTZGDAZWJ2WSondVbDPv5Wiwr5rtiwQ62XflGyjgHK4aJIcggMBrANO3X640mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983763; c=relaxed/simple;
	bh=7rc1d/SjX6ZUEsz5GUvOB9z1e+pX4PsmcEMEOYv2A0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwviAByzjcfJocWL2wT8I4Ye4yBoecM72v7uuCswewKgEmSstxVLmXsEEZujuSKnLEuW3tMzQkdFAx/1FNOoVJvquqFwHCNiJmsptaaPH3uFUzVMyqKyF5hIadw4EPm3Qx4JQLt/NrUR5APuktDH/+TagAfMkUTCmda8sjwXtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L2LPc7GF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zhIvxo9ed3SAUc9WUeA/MwYtzmAfVb1ZUH/2B34fAcM=; b=L2LPc7GFXLnXI83aLkusVmg3ns
	TWoiCoKihDLl3UIoJWoEmdkdmI0XlDRDun1IlDPUcLcTK3SzTou7XJ53fhN3eSNmeZkxEU5GTAC/B
	Ju6n7cE1nIG1bXyB9pSRULzSYA5xZh5orY01ql7NWjCVAbpdDoEdsgzjV25fuh/52ektkvIoYWs20
	T8+uBIbTAz1crSdqDSu2D2MvpocrRGg7234jqMZv6DTNfIUACmMs/0wmLb6Mn1Xi0Iyu2tZSVgBtl
	jeNMn+OHAk3VQVbvijc7ZZDD9fM1lXyDQxEUNwKmxvpYw0m/att1ZP+aSYVObM5oAz9mOs3dv199W
	HGDAIEkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tknG8-00000002HOS-1UJQ;
	Wed, 19 Feb 2025 16:49:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E95ED300783; Wed, 19 Feb 2025 17:49:15 +0100 (CET)
Date: Wed, 19 Feb 2025 17:49:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	jpoimboe@kernel.org, jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v3 03/10] x86/traps: Decode 0xEA #UD
Message-ID: <20250219164915.GH34567@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.581527735@infradead.org>
 <101d4be1-9090-4d3f-8f21-d1ab6ecb79cd@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101d4be1-9090-4d3f-8f21-d1ab6ecb79cd@citrix.com>

On Wed, Feb 19, 2025 at 04:47:10PM +0000, Andrew Cooper wrote:
> On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> > FineIBT will start using 0xEA as #UD
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> FINEIBT probably ought to gain a "depends on X86_64" too, or this is
> going to go wrong in a very fun way.

It already is:

config X86_KERNEL_IBT
        depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL


Nobody wants to touch i386 if they don't have to :-)

