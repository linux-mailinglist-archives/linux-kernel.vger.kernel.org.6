Return-Path: <linux-kernel+bounces-538939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDAA49EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDC0164380
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1827560E;
	Fri, 28 Feb 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHOywo9E"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58437272924
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760644; cv=none; b=AbqBy5vt7xHQRUXYNo9E54tH7In0z2gE+C3qbZte5D3HsXPqxCBNWq8AfesS3bbpIPsxSyK2V9jPFhfIdzjt2+pGT6w4L26qIoqSX2BtHiaUudLC/Ef1Ofsfji+RgQfc1I548AnmTj+Rp37nad9fV6EkW1os1roy+a/jgY4q/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760644; c=relaxed/simple;
	bh=bgjg/hEmlBXv67fTl4fRy81b4dDXu1T6gmhB1dO3WdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ0XSHimMZ8OUvsfibwHJBy0xTk4fpwMtYmR8lJn+K/8SDDSShLUz7iShmStpTipdkkYcR0VRAfHS0UKsqSk+BzUzGhW8FUOdPDxehnru0ebN+MZkjJ8JNYr2gx5fa22bjEHPHoKs5EIyuf3DQqOSur1NjtRYta/I9DrbX/fa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHOywo9E; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64a6131a-79d8-4250-9215-5e565a598424@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740760635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVrsBw3fKJbseyJjn+B6nGAkxIf2sXzvqUGFkrakjmA=;
	b=fHOywo9ErC6m0P2jZEnXQ7vgcWmHdqXDSEWMuHjpx8US8oTSv8SFvwhhQGwmXILoZ1sSHW
	2L+PDHrt4ebf5xGK0aUX26AV+QieJTdRzSQStv0zR8QJU1A4/yiUM9rFfZs2y+VadKZXIp
	bcKMq1xV57NluZrX5IoESMTwIhEOJ6s=
Date: Fri, 28 Feb 2025 16:37:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, przemyslaw.kitszel@intel.com
Cc: arkadiusz.kubalewski@intel.com, davem@davemloft.net, jan.glaza@intel.com,
 jiri@resnulli.us, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/02/2025 15:02, Jiasheng Jiang wrote:
> Since the driver is broken in the case that src->freq_supported is not
> NULL but src->freq_supported_num is 0, add an assertion for it.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

