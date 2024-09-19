Return-Path: <linux-kernel+bounces-333030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8697C26E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D911C211B7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C06A171A1;
	Thu, 19 Sep 2024 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnWJWiWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCEDF58
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709086; cv=none; b=iLCbQqekXRFOafN5+sYwZi79pq9zXVHN2VsxP575w2EPswEtmDstZlMpFvcsF3Qgq2QVDMw6Cgw9NwXlyZGb7Ro0UgwzYO8FtDnESHRvJAyGCuZ21ZCoNmrl4gkmygHDDh3Abpd0ZpdvwH3dUPakR86I7kM9SGNjUJ8ZpWeOtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709086; c=relaxed/simple;
	bh=+u6voD1/zzFOcPueubtBcbM02XGUDB5Pj38L4q1H3pM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tB6kTnB87+Hcs6A11VekcSxwfOPthSTrRy6FdutR9k9O09wVeugtwqXMtUVq16YTB3CpjkHPnxnR3FYZ6hEZ895A86uIU9yjBiCco9wf7yPIAnCfFpz2lYXW/XuJW3DLDtLfRuTzz/RUuCPKNcrm3nTeqBPo2wDQkG165ib67aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnWJWiWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D4FC4CEC2;
	Thu, 19 Sep 2024 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726709086;
	bh=+u6voD1/zzFOcPueubtBcbM02XGUDB5Pj38L4q1H3pM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dnWJWiWm9wjBi5YsJ386WEri2g5NIsmEpMM33f4GxHbwlU/7ljRLDciS5l6fFRZiy
	 RHWmwQlGlczsHzUb1DHAke0oPJQL2o20ZyytSZIuN0FxVS2AUowlOvBAIjmAM/tPYM
	 8dfbhpVDia4RDc1k1O1YwX3h76vvU+Qvq0YpOLV20+EwrGCH7TsWs7+vTZzIEwVOUo
	 Fo8KE3+VUXUAPp1f9sirQ2HEf+4z8euJZFpKzoIqv27a31sY6l48k1qrm6X6liFSOS
	 Ze+iPtsd4BjeQ4XlbXepzb/GRfYRfp9aCQ9PjaBoHCCUCGk29hQe4i+dewRHpbU7N5
	 spAVwqoCkvV9g==
Message-ID: <a7ffb7d2-28e9-4cba-95ee-6a34acff973e@kernel.org>
Date: Thu, 19 Sep 2024 09:24:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240915032251.2300459-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240915032251.2300459-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/15 11:22, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch allows f2fs to submit bios of in-place writes on pinned file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

