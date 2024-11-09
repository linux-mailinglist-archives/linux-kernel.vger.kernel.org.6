Return-Path: <linux-kernel+bounces-402597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747669C2983
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0E6B22CEC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9A3C463;
	Sat,  9 Nov 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CKndKwaz"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902036124
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119593; cv=none; b=mwuLheO33uyVoDSuwV5lrvsA1+L9SOJm5fphIZeiNwNlgIgdWNHFlWYZ7TLrD/1+vI+9CiWZpuQUwUAvoKUN1RY+XFDOXFOzzvrfHrMLtydOH7EWkvozRIxjj2h6dF8hj8jb0oJLWVxp0v3xxPZVqB++0yeWPgHPDLNR/Le4EMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119593; c=relaxed/simple;
	bh=MuTjgw/tFrwSzh2UN9OLE9YWVGaUnzxAosS0124d5KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N20LSs5BcXqEFGATAhIqVQpF2gZztimxMCkNwyQoFgRpAJvxfC+8zoGO4UWkixRRtApiTSIqfr/oBGgvecptOIaQwLVvYvrqXfc0/hobS6NqqE7a8ejbNDPVoH6SwTHg52pZLpLxXBPUKpmohGPfkWLPBVE3WAbKqAK4LYi491Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CKndKwaz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MuTjgw/tFrwSzh2UN9OLE9YWVGaUnzxAosS0124d5KA=; b=CKndKwazAssKA9Hg7AnOWiiBED
	xbzkzSG5ERNYZJHR2IFpXEDzTlPArXrkBlvlm0y1HQh2Us4bQ+BmOAasKZz59oo/A2iCGM/dg7Z1P
	RJHQmBigtyiPCW16RZH5u17BtOQKaDch0ttVTy4uck1o57ymRoizLmXyut6QzIZNnA6WeK3avfKVC
	ekNEHrYUqzP3nlvGwTk/Y7V30phE2vkYS41qOzB7VL8VlHJJ7w7zpJ1Jg9xRiXz0NgZH3UQpfN8z/
	rYAkJeUkU8thHGR937XEpSVKX9beAxYUdkSihGYQEz4SGkpTgHCmw0F8dptDfnv1RGwiz3ZPpCUwa
	XcMpbwYg==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t9bHS-004HUC-4N; Sat, 09 Nov 2024 03:32:54 +0100
Message-ID: <224d4751-469f-4fec-89b4-dff57a419eab@igalia.com>
Date: Sat, 9 Nov 2024 11:32:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: add a missing rcu_read_lock/unlock pair at
 scx_select_cpu_dfl()
To: tj@kernel.org
Cc: arighi@nvidia.com, void@manifault.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, changwoo@vt.edu
References: <20241109015420.170729-1-changwoo@igalia.com>
 <Zy7DWssEuFN6Zehi@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Zy7DWssEuFN6Zehi@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 9. 11:05, Tejun Heo wrote:
> Shouldn't RCU critical section cover the places where llc_cpus is deref'd?

You're right. The RCU critical section should be extended to
cover the almost entire scx_select_cpu_dfl() function. I will
prepare the 2nd version.

Thanks!
Changwoo

