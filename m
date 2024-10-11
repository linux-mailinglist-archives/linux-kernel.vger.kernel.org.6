Return-Path: <linux-kernel+bounces-361287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2F99A642
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B4FB24DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6E2194AF;
	Fri, 11 Oct 2024 14:25:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D5218D7C;
	Fri, 11 Oct 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656732; cv=none; b=JkO3hrOvBK0lVQ+HHRxD5uhDVa/FBdaDEAV0vtRbaY2m11cGqcIbZllIPAhLBGnYWmoi98u7B9Z+hB92GNHNkhnrks1Gy1sWPoxIF/xTJDK0GwXKwOKFIjAfddiyblG6LotQuOzNaQwjzu1BFz/hmNdoQHsd7QUZ/O84wGSNt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656732; c=relaxed/simple;
	bh=Kg5c6UvEtUhEc5DMSJea3v9/rsk6G1aNDbZ0lXvgIlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2WeV880f9JHxvbtIAoTE0T9e/xX1HaoXnUOk3y/LQske7/TVYj9EK3IQsxki2FXaRTxi3unJfKqZMcOShV/upjhbDYKjnOwFgijJoazEuXGyO2b1ZpeIfXFUvk9gQeeDjfoWTYdhW94D8tYHR7iB5BfFYJk2rjMPbVQwKj50Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1524ADA7;
	Fri, 11 Oct 2024 07:26:00 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6A83F5A1;
	Fri, 11 Oct 2024 07:25:28 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:25 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Su Hui <suhui@nfschina.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix the double free in
 scmi_debugfs_common_setup()
Message-ID: <Zwk1VUXi5BBeU9n9@pluto>
References: <20241011104001.1546476-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011104001.1546476-1-suhui@nfschina.com>

On Fri, Oct 11, 2024 at 06:40:02PM +0800, Su Hui wrote:
> Clang static checker(scan-build) warning：
> drivers/firmware/arm_scmi/driver.c:line 2915, column 2
> Attempt to free released memory.
> 
> When devm_add_action_or_reset() failed , scmi_debugfs_common_cleanup()
> will run twice which caused double free of 'dbg->name'.
> Remove the redundant scmi_debugfs_common_cleanup() to fix this problem.
> 

Oh Yes...my bad, Good Catch !

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

