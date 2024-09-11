Return-Path: <linux-kernel+bounces-324121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12397481D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A02287B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E12CCAA;
	Wed, 11 Sep 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIWKHLZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16D2B9BB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020777; cv=none; b=a4owbqfzzjyyqgqXz3ii1c7GBJ9L9NOZD1fMPvWIIYrZ4lqK0PPhBvO0iROElmO6lYN4P40UpPMrkbRhQ1J5q8ellhCDAoO+lphdznA/6bdcaO6JqVc4/L3ehO2LPHKHuZsKqO1mTxCEoRvO7KUmcLu2MKTX7Q8+GMfhhGHuNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020777; c=relaxed/simple;
	bh=KGBFpE2v0O25fTbjwWCmCkxo26mXNN2U619DgMaGE8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ExBoDNzb87dVafI6C8DAguygLK3g4l/HhEfV0YoUkyy3leoUhNGm7qBzHtwh/SJ1UdQgBqJGcJLDUEa1zMzc4w56/g2MvcSLYn66Z+zuqxJYNNO9xjP/X1JS8bUI8Hq5SSVJovfeAugwGbvk/HM4/dlsfDCaXcHsPNHtJLYWeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIWKHLZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B7DC4CEC3;
	Wed, 11 Sep 2024 02:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020776;
	bh=KGBFpE2v0O25fTbjwWCmCkxo26mXNN2U619DgMaGE8k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eIWKHLZFbEjyYWJeBcGx1dtSf4mi3v/HAr+dJxW6cKg6U5GlkfXTtnaO9aiMZGPAq
	 fdJU4t92nMOAjhTyY76uoTZLzqpP88aKxmorD8SJB3sqnJGYx2+vXSYEo4Sm4IAkak
	 Fq2f0JaZsv3+jkbQ3tu83JQIcOzp+zzzCYH2RwXJX87YM0gogL6YcvKc+5FiqHRv/F
	 sdxwILEclQr7HCEuv1NL0BdVf/EkHQqbboAi4IXuUck7k3km7EzIK7EdvRxei0uIe9
	 LoYDVTdxxiCpaxlrxeQXhSx3E1ALqh3LpfekIVU77j29ieN/lWq6+bnFYjNi46qnM2
	 dq6hYixoASLJw==
Message-ID: <4fa5e9e5-172c-4d2d-8954-9ec653b04a3a@kernel.org>
Date: Wed, 11 Sep 2024 10:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 6/7] f2fs: create gc_no_zoned_gc_percent and
 gc_boost_zoned_gc_percent
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-6-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-6-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added control knobs for gc_no_zoned_gc_percent and
> gc_boost_zoned_gc_percent.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

