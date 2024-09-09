Return-Path: <linux-kernel+bounces-320595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135F970C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE461F21365
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDB172BD0;
	Mon,  9 Sep 2024 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqaRAVe9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D155BA42
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853386; cv=none; b=lg+6MrUSpkuEpy6q/znUpi3JGB3fHCYbphxlnt1lKnffOzv5EaOTM+QM9rHPp3V7zIsM0LyDpuDPBWll5sv684W3sTUyKvhSuC9FbAlX1IXOZaUG3wjuz9g7m4Qdzdib5qRJM+LildRoXSychn9dZ5U7wtPxqZiZ6ddSn3ZHYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853386; c=relaxed/simple;
	bh=XNyhXsq9g54lheOKab8l6FLqKbP79ACZqC8Y6P3P1Gg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RPnEwfH6Rha73ko5O9bKxizorbDRjLzqSQxOS2spSqCE0Lo1g4r8vVcjEhGQOp4ZDCSk6T+6UyEKxCQKgMrgTRpIfyI+Wqu/PipEEQ9wkye3pdbfvo7J79Yb/QvH0GblD5lWIqibyylHuy0AsAumygCPFZZs5b6T1j6VOzxsGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqaRAVe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5758EC4CEC3;
	Mon,  9 Sep 2024 03:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853385;
	bh=XNyhXsq9g54lheOKab8l6FLqKbP79ACZqC8Y6P3P1Gg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IqaRAVe9IBUtbV8BCo8oT7PjTEK7RGN/mxwgQXf4QWeEOtW7mkDjI0CUrdpcwhRRR
	 NIQ7VtSCBdtA0qm2jkMO4liL+aOv5REsNjsQK5EXUjRk6o87nYDQPfK1HKcynkIs73
	 UrRvGjlkOmBvQ7QozK28R04f7A+BKgePBRBH09+5UVgITFb6zGdHSLZoNvGmJkO2cL
	 WA6x2UIrbHL68e1JKwuAQuL88RLsMAJ6Zm5Fx4oMco5kvnuqYdNkeNlxco+zHHI7MU
	 HS2rjJcYCOxoudgniEZ9cl+bEsfgTfHLIVgu0GbgrKrLJUhXUf5fo1o0LZHi6Xaure
	 ERav2hiHRurMA==
Message-ID: <87992941-33af-4bde-8ed7-3b24b66e7b1c@kernel.org>
Date: Mon, 9 Sep 2024 11:43:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 11:03, Hongzhen Luo wrote:
> Get rid of redundant variables (nblocks, offset) and a dead branch
> (!tailendpacking).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

