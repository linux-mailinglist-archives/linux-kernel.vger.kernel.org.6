Return-Path: <linux-kernel+bounces-179344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7C8C5F07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F9D1F21F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1F79C8;
	Wed, 15 May 2024 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klRP/KZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D91109
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715738310; cv=none; b=otb3nl44F1ObQFkgfaxhoxcQEIWJJiTlizj3pDKsrT3pJGC085oS3i1s9euxmfPc6T8dY//fyCqUJUbDA0+p/kW/OjBrtAT6FdO3tLaoAiD1RQhARpNmaFVT/W2E6rv5ntxSxnxLIMhIL3QvEWwBd9gbu6nBKGoWbUWO+X69W1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715738310; c=relaxed/simple;
	bh=eAMbTEJdG+oSP4Dopd7Go4TxUCJqOn9CQQtm4InVAXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpYHriA38PV7Msgp9nWVlb89+czb7TmobUfbwOZ8/LED3XC1MsdWKVAW7zYWBJSHLNxltPdqCFGmfsTomxElf/cn7xzgFt7SkAEQrdSgoQ0O529DSJ+02Rrd0GCMNy27fTaxjZh/av3doHH5+lbdXLAENIFPPMJ63vE9aFuosE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klRP/KZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C09C2BD10;
	Wed, 15 May 2024 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715738309;
	bh=eAMbTEJdG+oSP4Dopd7Go4TxUCJqOn9CQQtm4InVAXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=klRP/KZZhpdHfFbVBNSMoJrqwTgROgjCzQI9rSP4T3RgPUZ6u6OCe0mTA2OaBEkrB
	 D+/gwTkvuNJuMT9Xs/Mi2L3N9RFCnNlpAMSzMm707OOc3mDEyiNOqn8QSiSJHlvH5F
	 c8s0RmowFf+94Pp9CVSffiLQhfqlcZIe4XtooubSPgnoUr9rxU19dmt4CZcUfK+gTZ
	 ugAFVhQ0iwSKXzQFHxOqsIBnyVk43/ghZx4Lsxrngzcv+eRdOz6vMnzRpfagoXr/MU
	 4XHxwRk4eK2s1hvQ/VUA2qFRHNLTz8OMouxyoJrgeWNd+ZgW24dR9QWUURO85nNk4H
	 g9Tp9tbkJER4A==
Message-ID: <c56a8728-6207-44c7-9ac7-649dcc8f4c97@kernel.org>
Date: Wed, 15 May 2024 09:58:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: initialize last_block_in_bio variable
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240514113529.1498545-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240514113529.1498545-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/14 19:35, Wu Bo wrote:
> Initialize last_block_in_bio of struct f2fs_bio_info and clean up code.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

