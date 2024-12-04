Return-Path: <linux-kernel+bounces-432095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB909E4504
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE86283997
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D21C3C1A;
	Wed,  4 Dec 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrNIfDaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CC2391AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341715; cv=none; b=raOfhTakOX/L0l9v0bD7mmuTXLu49vb8yXVbz7Yj84ZmjRQ92NS3IH9cXaFXTNqSwMAe4+WpJ/b+HGXibBG5EmJIeaVHYSdl4b8hHbwKRbs/WD8188LjBtUO9uc1GiqmLBr9EF9CUKSRk7hTXmiBpDQ1/OpVS7qx9NwVWj8mOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341715; c=relaxed/simple;
	bh=Tu3AtdPA0xRyIkFD8TdiElPINbnlI0LbR2FlXh9pxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKhiggr5RLCvplP+z1sfPNu2eK7ipWaGjtYP5YJP9sr2ShR+hDUcOXCIjw2M4ahWuTVwxHAmwx3x09TMfZLyoArghMxYeBnB2oaGei9vR1nHPHnYlRGqtFHo1tbuwMJ0jK/rLoGWLbAr0rzXonOjH1QskHFHLFwj3IPz6FsBZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrNIfDaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95306C4CECD;
	Wed,  4 Dec 2024 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733341714;
	bh=Tu3AtdPA0xRyIkFD8TdiElPINbnlI0LbR2FlXh9pxBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrNIfDaRBp4fFWqAN3VGRVuAnGWT0DpkN/+ttfClwpCiiOCBjUR+vdG5H4pFfu86y
	 pTLsy98HO3d8AHV7UgdDOeZSTLbNVHT7zHtJ4DXmOPBY0HJjzzIoNYE8LZP2fkl2os
	 btGAu2oOMVbrDJMWvX53lqUsHDRiTdqIUgpycyIVqWy35OS6OF5PiAMZj9JsvdQ5Pn
	 uJpXRl1URennpnt96a3Zwvz8v3jgrqGlK7pA66aCSXV9PXeI7gATm1CKZDBd6dQsh8
	 98lIpdc1b/Cpst0fVeNd7wYoIKOcZqovNoGGVkmxjIcksGvYENwJJjp6b89YP1UKip
	 6EFEbpTNx7LNw==
Date: Wed, 4 Dec 2024 09:48:33 -1000
From: Tejun Heo <tj@kernel.org>
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: void@manifault.com, joshdon@google.com, haoluo@google.com,
	brho@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: fix application of sizeof to pointer
Message-ID: <Z1CyESv2U1NqidQl@slm.duckdns.org>
References: <20241117025129.159014-1-guanjing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117025129.159014-1-guanjing@cmss.chinamobile.com>

On Sun, Nov 17, 2024 at 10:51:29AM +0800, guanjing wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> The proper fix in this particular case is to code sizeof(*cpuset)
> instead of sizeof(cpuset).
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

