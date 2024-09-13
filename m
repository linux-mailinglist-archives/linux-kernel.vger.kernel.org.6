Return-Path: <linux-kernel+bounces-327842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3CA977BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ABB1C243FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6843B1D6C6E;
	Fri, 13 Sep 2024 09:07:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374E1BFE12
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218432; cv=none; b=kMYynvE9ciC/J80Vx18ipS4rmA2QMU5sw+HhtAvks7vrQJtBO2A4nLFucrRCX7ZdgWx6JgyLS3vfYrh8sYd1FpRR9ycE0re6zf9gL2cAeJj1AYO7Hyw+rre+RD8AYbWcqfXI0xYIlZjesQmS3N+aS9AHx45iwBV6A4dQfaMCF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218432; c=relaxed/simple;
	bh=yMAqwmG5frmeLIPoJVB0wSrRZDCnI+JlbZhT3Up936A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAPVeGWnt4MPybFCIiGUBBmbQCvO2gxx2aD97JXxkmTj+l7t8cDVRSawTIrqzEkkNLa4lu6VbwSpRXZjfybu+4b6mXekEXSTknUzdwfkMgfXwXfIDuou5sABHdwodLCR5UJ5cbLfFF91ZFrz/+NyccpuwldsHVauk/uhv00Mr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4140B13D5;
	Fri, 13 Sep 2024 02:07:38 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9100A3F73B;
	Fri, 13 Sep 2024 02:07:07 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:07:05 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com, jeremy.linton@arm.com,
	sunilvl@ventanamicro.com, linux-riscv@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
Message-ID: <ZuQAufXBEp-87mrv@bogus>
References: <20240913080053.36636-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913080053.36636-1-mikisabate@gmail.com>

On Fri, Sep 13, 2024 at 10:00:52AM +0200, Miquel Sabaté Solà wrote:
> When populating cache leaves we previously fetched the CPU device node
> at the very beginning. But when ACPI is enabled we go through a
> specific branch which returns early and does not call 'of_node_put' for
> the node that was acquired.
> 
> Since we are not using a CPU device node for the ACPI code anyways, we
> can simply move the initialization of it just passed the ACPI block, and
> we are guaranteed to have an 'of_node_put' call for the acquired node.
> This prevents a bad reference count of the CPU device node.
> 
> Moreover, the previous function did not check for errors when acquiring
> the device node, so a return -ENOENT has been added for that case.
>

LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
> I was wondering if this should also be sent to stable, but  I have not seen
> a report on it, and this is not responsible for an oops or anything like that.
> So in the end I decided not to, but maybe you consider otherwise.
> 

Right, it is not a fix per say and hence not a stable material as ACPI
is not accessing the node pointer.

-- 
Regards,
Sudeep

