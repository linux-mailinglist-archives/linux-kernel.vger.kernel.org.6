Return-Path: <linux-kernel+bounces-296133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0B95A612
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C4284775
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBA016F27E;
	Wed, 21 Aug 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjUh/ajP"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AC1531C2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273299; cv=none; b=qkOEvL8HLxvM/XJBawp3HJa3Crlrc/3UTRokZkYaWJi99hzlpRxuJ5QLFhR5/2P3UcsIuTQKlwEeuvjcG845fVuPd8ttRXVsrfyGgvBM3/HRxpCfR6s55m7ntVOSfJA9L9+/Mlu+0uRWK6oUVpN3+XXShadbhewX9HGDRQvFl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273299; c=relaxed/simple;
	bh=8Cd8Eq24zD79Bs7TXy5VRrr3jrO8t8jGfkM8L8eKnpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfRnK7dOBN6v3NKkJBUbrNULZVMgpiW6BZJv6Ef3QxOIbBJi1zpACeVo9iLKsZK4Ult1D7eJmJJbTbQ074k3PnsBP/8LRCXCR0RXiumTotOwNEBDrActo4B0msBeffegRVeTR6NYvwK7hUgveWmqK2R6lDkpjX+S/aJyInj8Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjUh/ajP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a3acf3b-d486-4d6b-80c8-8975fce66883@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724273295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Cd8Eq24zD79Bs7TXy5VRrr3jrO8t8jGfkM8L8eKnpY=;
	b=NjUh/ajPQa/hLdXEcBeJwz72SAwQoJ3YtNLCqx+yrom6XBiGotHZDHzk7RXTw0n/cM5ATQ
	Jpsh7MSDKVC/ZcjHSqwpKIE+83B13vN7zAr2Wuoq3Fsk9DfSUeQV1lPNQWVL1iuEY8fF4r
	xKHCeOrhHqpQvJPWVb6QGflUhA5RO7M=
Date: Wed, 21 Aug 2024 13:48:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] samples/bpf:Fix the wrong format specifier
Content-Language: en-GB
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, martin.lau@linux.dev
Cc: eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 linux-kernel@vger.kernel.org
References: <20240820081046.5267-1-zhujun2@cmss.chinamobile.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240820081046.5267-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/20/24 1:10 AM, Zhu Jun wrote:
> The format specifier of "int" in printf() should be "%d", not
> "%u"
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


