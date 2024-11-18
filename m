Return-Path: <linux-kernel+bounces-413533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3E9D1AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFEB1F22C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAA1E5734;
	Mon, 18 Nov 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arPwm1sD"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C814D71A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965976; cv=none; b=YfePE43OeHFv0c3z3C9Kh48I4gHPc1lQGypACLJ/FLNcnsF+3qFRPcHZTUM8q1KtnWnqd+kv0AaDYDy9+edr7kJyN0S/WtrDzmLPWB3GYSd1OkDOn2d8yOVKiz7BKhm/q379qRg0vOX8uyt3SEfsefZ3FFwkNij1VqA+rGtx5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965976; c=relaxed/simple;
	bh=VozJIrDceJq4zgppU8iRDiha9kXDC6EVUdlJkNnNnBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4BHtred7ZO0ODRBL7mUVzsBg5mwJcCmtacNaLVnQQRnJsW0yoIhPzxD9+aM8iOAR8Yd1lF8QT1Zl/YiKGNexo4pnxoCp50LVs+7EWdSuQ5NRPZNSqgS2tY0RnuAiuavrK7qaOUrh2ucwndPVxllVAFhi+adrSnjyN3ROQFxD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arPwm1sD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba7c39cb-18ab-4c51-a4cb-89769ea09e6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731965971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfkamGQY47DZR9G8xLHyPYfbW34L0/79y4mIancRHDQ=;
	b=arPwm1sDNXI47rNpmsXiVNGRTa3+wVnwbKvsMavZG7g4bMP8cGjGQnTk+ixlpFpn6fMf+9
	KQ2zGVdaJ3AQS9O4j5EDrpzfBKnqZh16YfwGW4Wc9DH6Zat3sBnCtnXE/YhMGS//TAzZdD
	+vEDPgyltTw1AldiRoeUmVcow5N0D+g=
Date: Mon, 18 Nov 2024 13:39:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 0/2] bpf: fix recursive lock and add test
To: Jiayuan Chen <mrpre@163.com>, Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, daniel@iogearbox.net, mykolal@fb.com, ast@kernel.org,
 kpsingh@kernel.org, jolsa@kernel.org, eddyz87@gmail.com, shuah@kernel.org,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org, haoluo@google.com,
 song@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co,
 yonghong.song@linux.dev
References: <20241118030910.36230-1-mrpre@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241118030910.36230-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/17/24 7:09 PM, Jiayuan Chen wrote:
> 1. fix recursive lock when ebpf prog return SK_PASS.
> 2. add selftest to reproduce recursive lock.
> 
> Note that the test code can reproduce the 'dead-lock' and if just
> the selftest merged without first patch, the test case will
> definitely fail, because the issue of deadlock is inevitable.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, please help to land it to the net tree. Thanks!


