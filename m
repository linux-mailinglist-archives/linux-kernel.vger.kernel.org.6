Return-Path: <linux-kernel+bounces-178844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA08C5890
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C9282F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7E517EB8B;
	Tue, 14 May 2024 15:17:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F436D1A7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699857; cv=none; b=kdvAlP329dhCwwVbZEqeL1JozF/L9RavcNTTdNHerj9abhNYoHt0ODbE+0acsN/bKSEeGyGXeIx+D1NlAXZs3lQ6YHZUADk9eSAKD3atfU6+nYX3rZIy3EqQBi2QIK8fmvm4O4wgxih9gUaZw3mDThKxVuSNfyFEIFIVVQY4FF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699857; c=relaxed/simple;
	bh=KnsAs9/lv327qs9VzboT0D+iuFfRuAfwdFLVnlhisPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs7hjPydi2oXRupLncBdGP9U+kepwh0/n+Inh8FSCGpuN+01DOZkMG8KR7+4WkeucMVRPjHq70/ExDFK+5qb85hoG0BjzB3c4rcfI29lDRGK1wE3IYFXFAXLNYWDxpI5R5Ou+MyZ4p8yFVxcT20xUg/nVL/sC8BP/zU/QRbGo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BCD1007;
	Tue, 14 May 2024 08:17:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29B03F7A6;
	Tue, 14 May 2024 08:17:30 -0700 (PDT)
Date: Tue, 14 May 2024 16:17:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZkOAhH6tm1NXpre2@e133380.arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>

Hi Reinette,

On Wed, May 08, 2024 at 08:41:37AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/26/2024 8:05 AM, Dave Martin wrote:
> > This is a respin of the resctrl refactoring series described below,
> > addressing review feedback.  Many thanks to those to responded with
> > feedback on the v1 series [2].
> > 
> > See Notes and FYIs in the individual patches for details on the changes
> > and outstanding issues.
> 
> What are your expectations regarding this series while considering [1] and [2]?
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/ZiE8%2foXyjBef2qTy@e133380.arm.com/
> [2] https://lore.kernel.org/lkml/acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com/
> 

I plan to propose a reworked version of the fflags and string parser
stuff, and take a look at the other more minor outstanding issues.

The series does need rebasing, but otherwise I don't anticipate much
change to the code from the Arm side unless there are further review
comments.

Do you have a preference on how this series should proceed?

Cheers
---Dave

