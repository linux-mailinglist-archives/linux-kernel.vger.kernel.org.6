Return-Path: <linux-kernel+bounces-222344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D690FFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB613283DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E219B3D7;
	Thu, 20 Jun 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAulTAXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57314176221
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874671; cv=none; b=dBT9d98wkC8SjFtosBogcfcS9iT97VinRBh5ihuaCdGANwZuYd2PmGPS6+VFg7n67Dxx9+FswoqvZguVR5WHsy4O/uLOZzyF0n7IMDOpwiUC3Dml+BsNIPwHqAMi6rz2M58QniGFiwqciDtIHA5xsWImUxwvrmLWkQxWI99S5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874671; c=relaxed/simple;
	bh=nI6vVmCQCUV9nmH5qrdtrj3nCPP66duGeUNv0JQhqTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QVyIYP4y9Oet6fGSCOVdcpPyNNq9GN97EuIVVOrU8uK0MbqpOWOfKus0hrQOUKjGKbo8/P38509xsDmPDR2BZsqv6R2usT9AQJjykjKtmA/dtBdu/aEUayXAYErGIJlrnL2awgyTmLlogo4cvfXwQdzLMzsFQdLOjkVHWKPNDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAulTAXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E43C2BD10;
	Thu, 20 Jun 2024 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718874670;
	bh=nI6vVmCQCUV9nmH5qrdtrj3nCPP66duGeUNv0JQhqTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RAulTAXhAmABBJGBXBkt8NC4Z0iHzvoURINKTms5ROxvFWE/me9fp1JyisnnFzX6D
	 uxklzt6Djb184FNRTtmhdLXp34P527uyjlrFdxQ+wmnhnmPHUQalKc4SyJjIsdbWvq
	 fCmQD9sfxcDzNVrERoh+VvNww0iWLgdprTlCrCJ/Fpcs5waNcJSQ1NcIKa1zZ3dNz0
	 zOkzkTXev8znVXOGBHtMFFm/x0UFETD0L7CkPa12qoW+YegYPC/WkLksdKPGBrxCmX
	 ZiZH/qatqhJ0YAawzZ6JailQJQQWnzl7Cdxn3qMjl9DqD9FPpl532V4aWGt3B1MDL5
	 LmttovGCRewkQ==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>
In-Reply-To: <20240605191458.2536819-1-andriy.shevchenko@linux.intel.com>
References: <20240605191458.2536819-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 1/1] mfd: lm3533: Move to new GPIO
 descriptor-based APIs
Message-Id: <171887467001.1103402.6310552205242614660.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 10:11:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 05 Jun 2024 22:14:16 +0300, Andy Shevchenko wrote:
> Legacy GPIO APIs are subject to remove. Convert the driver to new APIs.
> 
> 

Applied, thanks!

[1/1] mfd: lm3533: Move to new GPIO descriptor-based APIs
      commit: 8dc7c29f608649f3d9eca826e9d4fe4b8a32c472

--
Lee Jones [李琼斯]


