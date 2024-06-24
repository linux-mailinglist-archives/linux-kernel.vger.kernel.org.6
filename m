Return-Path: <linux-kernel+bounces-227427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C54915111
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39201C24449
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0A19CCF8;
	Mon, 24 Jun 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="voDlwbo0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5C13D2BC;
	Mon, 24 Jun 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240789; cv=none; b=fnnNY8AXx5q5RUz6F0bcbykHLUPtkAV5LyUY6+dlwn6wbnpA6EZSYJ8B31jNczTG2lFxUF5oq+2O5LPyvrrpetNMGHDML6B2GZwgTh5YX/xu3GmCL4nvfwj3DIDS1a3X28bA9KaR6abP/MVGeByVzjc7AL48Whv+BaE1jDLGess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240789; c=relaxed/simple;
	bh=s0q0af3gE1JvSIq5I70dBZCqSI9BuF5ovM6No/hd+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP+b+31cZk3/IgqVUWmSw71jA79L8dnWF9hL9IxA8U+fiaWEZdjuuAiREBQAOG9BNBZkCNWRm7PEhQO66MaBtlXAWKVdeVK3njCJ2AkPdIs5GZCMYgKxs46ICmUWPFAN0ru0Hy2/Rxo8Z+uAVLrjNNFBa1GxXseaT8NZ4BcsL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=voDlwbo0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5rHWYHCAm83DOWUjTKARuD+awbDx8mZtltx+LBbgsnE=; b=voDlwbo07otYRFA64WcfZDadIZ
	I/JqOvUSpR8kd5pxmTQ/I0kNte/4waxDZzigmgHdQI5p0FQZRhH+OnuiO+yzSH+lCQW+Ivoo0PQNG
	4T6qRtCffKbCPaAVke7gGf/qeLjyepEnl6eNfRSnfnIkf/oGEvFStRntNJ8lvyiQpXBOr1VAXRHGK
	nMd8WsdVA9GcC0E7TteVV1VSKKEi3bUZ3xan+HrXMdzwi8e7keddajUFVMAy1cjXmp/4WmKVP1tTD
	tBRTLfC00nQr9g0i6LqgUOgqH3xKL4AhwXMTI/AOEnToy78pzlIi+4xN/MuBQEwI+bndT1ykCKSvT
	YVGIIAkw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLl44-0000000HBJ0-2YAZ;
	Mon, 24 Jun 2024 14:53:04 +0000
Message-ID: <d9170236-3266-4be9-a513-d58104ef1d2c@infradead.org>
Date: Mon, 24 Jun 2024 07:53:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, bilbao@vt.edu
References: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
 <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/24 12:47 PM, Carlos Bilbao wrote:
> From: Carlos Bilbao <bilbao@vt.edu>
> 
> Extend the Index of Further Kernel Documentation by adding entries for the
> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
> on the second edition of Billimoria's kernel programming book. Also,
> perform some refactoring: format the text to 75 characters per line and
> sort per-section content in chronological order of publication.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>  1 file changed, 44 insertions(+), 24 deletions(-)
> 

-- 
~Randy

