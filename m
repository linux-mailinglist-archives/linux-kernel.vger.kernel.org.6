Return-Path: <linux-kernel+bounces-402260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9F9C258C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AD71C22C58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FE1AA1E2;
	Fri,  8 Nov 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ED0EU0Mm"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196E233D6B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094161; cv=none; b=Dl9ILh/ntHwXz4OqeR/57vv/9nGu7upNIiTwIequRwDlLA/DdHu+ox6AIpK+ye9D6Zmdv97DaBmJ9u/NEVRgfjPgpxXmMA/cAkGGTUJHdsXWx6UigPDWiTfphsNio5koLUFz2NduVS5ZkVqDMIuK0ZIORA0+5oN6KvWPbEd0E4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094161; c=relaxed/simple;
	bh=EtRuuaWJP2fFK7jgl2zOWZpe/+b0yhTJHKDU8kdNXNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCp/7F+SDoe0ShvYbfiAfoYHoCe1tMAey760uOEoXUXcO5WUWiYufRxuAbr2UfBZ4n4FN93LMDbAZPr6Kx1VsggQ/AwJYKCYBn+KB2R/Zvi6OK1dd3rQDo3KDLZxoGP8pxSyg6lxNye8GBOSFpCjFhwo/COZHw76ak1ncNmSFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ED0EU0Mm; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea4d87c5-ce13-43e3-8cec-b068055b0f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731094157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtRuuaWJP2fFK7jgl2zOWZpe/+b0yhTJHKDU8kdNXNU=;
	b=ED0EU0Mm2Ud6CX5BBMKugOxqt1lA76Z8CaFmKdfEm6nhmtixIbGkeZJpxZa12eyATXiUt3
	QLBMK7w/sRGpyDQ/R9dWH6kngRe144grQPdaLVsywNYDUdFm/372OGc85Fd3gM8X1hyu8h
	5bOO3joXWZaHISHUuLSOWDOwTkCP2cE=
Date: Fri, 8 Nov 2024 11:29:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Fix mismatched RCU unlock flavour in
 bpf_out_neigh_v6
Content-Language: en-GB
To: Jiawei Ye <jiawei.ye@foxmail.com>, martin.lau@linux.dev,
 daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 12:18 AM, Jiawei Ye wrote:
> In the bpf_out_neigh_v6 function, rcu_read_lock() is used to begin an RCU
> read-side critical section. However, when unlocking, one branch
> incorrectly uses a different RCU unlock flavour rcu_read_unlock_bh()
> instead of rcu_read_unlock(). This mismatch in RCU locking flavours can
> lead to unexpected behavior and potential concurrency issues.
>
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
>
> This patch corrects the mismatched unlock flavour by replacing the
> incorrect rcu_read_unlock_bh() with the appropriate rcu_read_unlock(),
> ensuring that the RCU critical section is properly exited. This change
> prevents potential synchronization issues and aligns with proper RCU
> usage patterns.
>
> Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


