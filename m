Return-Path: <linux-kernel+bounces-396893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD1D9BD3C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226CF1F237E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162F1E571A;
	Tue,  5 Nov 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o3jY++jt"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6B184523
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829100; cv=none; b=pm4OMNqZ1Zr3tIqycbLE7xEJoqNq35DqTIP25YpAzpzxHwckIP/K2gjxcUZGJIXYEGlOdUvF3fvVArxiKptz/707H8oDtbax2wh2LDhVveEIaYvldhdDYE1z+1hztvbRjcutdvtVusS2K+i+C3ISFo1U6Qo5F5JOK0bqxjaM/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829100; c=relaxed/simple;
	bh=7lmSXDRKJMQdY1Z4f2o/KhF3n98hCCcnTqWt6A9sbCQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j5zjpJSOw864uLpLGRk4bz16ptcKTv0XR8GM8zlAfI9O8vhIiQbkqkh67WGh7d3JRf4h+sOrI5rPYhFdm23oN5c6RqfWhBnLzzeJSk/xQS6Pl9j6nnG9+etvGMc4fvVCg1j3UdE8I+vxPiR2ODsrXqQ+Qzr8OujeZEYlA6AJUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o3jY++jt; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730829096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5ayEpY8lK9Ig40T1/Knqdv6m4Esh+bt7IqsSYjFeR0=;
	b=o3jY++jt7fdW/8sUbPUqF/aq8pbmYptQJ43sAhz78uW+5AiANsVl6LAdvfhwRNnfhutV6O
	wGH5dtQS2SAIECP6/iDcQIv58cUW06D1QFYmijQm6pxsTUp43HKN+SvzboYKZ+kU/8B6TX
	EvNAm48wN8Gz75KgfW2ON5l1zr26hao=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] MIPS: kernel: proc: Use str_yes_no() helper function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20241105173837.37756-2-thorsten.blum@linux.dev>
Date: Tue, 5 Nov 2024 18:51:23 +0100
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AB524950-2672-406F-9141-28CE0A074181@linux.dev>
References: <20241105173837.37756-2-thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Migadu-Flow: FLOW_OUT

On 5. Nov 2024, at 18:38, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Forgot the link to v1:

https://lore.kernel.org/r/20241102220437.22480-2-thorsten.blum@linux.dev/

And I just noticed the use of seq_printf(m,) vs. seq_puts(m,) and I'm
not sure this is still correct. Have to check this again later.

Sorry for the noise.

