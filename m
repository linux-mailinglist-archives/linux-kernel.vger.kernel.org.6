Return-Path: <linux-kernel+bounces-299948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1D95DCC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6378D1C218C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D1154C07;
	Sat, 24 Aug 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5e2rFMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0333062;
	Sat, 24 Aug 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486168; cv=none; b=uS/hXtA51QWklboJMwj/9wz5M5hLNbc7l/o1o5BVOC8aBA4cl/Jt3K+Kzl79/YF32XWxWCyF2zc54DB9H8MQ+qou3FM6C9TvEWP+BdCbWqgo5PxwLe2GH1PBCShZdAZSLLn8ICr6AHdDk3BOy4uG+yD2np+0vRGLVsol3+oRUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486168; c=relaxed/simple;
	bh=bV9OEO6chy7K/WMqIASROgCq4ojSKouRshMyUDHdfRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8sLbfh0pfJhvC5GND5Qxwni0BMkRehkVHgmxaxPmSpmAMHtNUlHv5S07ARKD11jJXx3o89zhGG1qegzozv9j1+y41CkLfeubqVuhJDs98oaqo/VNygjzzej+wHTANbyW1kvK0jwFvpD7rxFI63udrqmF63ezGF/XZAi0o76PZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5e2rFMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D41FC32781;
	Sat, 24 Aug 2024 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724486167;
	bh=bV9OEO6chy7K/WMqIASROgCq4ojSKouRshMyUDHdfRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5e2rFMNQc/640x4rHg/pi28Jabg/QZl0BEyjixq1tXMmA40I0bzLBa6PEoQmGy4Z
	 EvE6C8KzkHfQDAeA5l+rDUHOwpGkiCabXzsZbMrkbECeNDzXRX0+b8MLsyBUs9PPnK
	 ZGqiCL2bYuIuwwfnOKBF855uRWlIIJXhC/c4CK4hZAYfIChyJ+F6TqkltmCR9EncDK
	 2v+/+3Z6FcLPdE9+/AWB93QfY3mXOGebzwRcehATVGLPF1KTJJ89zV0h1EHQfoZvXC
	 3Wbq44kOMQ5UOTYTOpiuBzNVTlxGQC5Z7Rm+EsPl4YCDmp67jI5Y/zaFlFCQCWyARG
	 yeqFZztE5redA==
Date: Sat, 24 Aug 2024 09:56:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] of/platform: Simplify with scoped for each OF child
Message-ID: <q6oqvxc4hdmnfcjlrmrbhd4d6cvt3vvi7rxmwslazadrpadlbk@4mdmxsqoijwk>
References: <20240822073417.3582286-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822073417.3582286-1-ruanjinjie@huawei.com>

On Thu, Aug 22, 2024 at 03:34:17PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/of/platform.c | 14 ++++----------

There are like 3 or 4 patches for OF from you. Send them as ONE
PATCHSET, not one after another.

Best regards,
Krzysztof


