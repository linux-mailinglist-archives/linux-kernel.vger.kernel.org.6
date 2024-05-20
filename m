Return-Path: <linux-kernel+bounces-183318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A498C97A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDE11F2167D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AF4C92;
	Mon, 20 May 2024 01:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3EhMF77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430F367
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168108; cv=none; b=CV02evrNeR7nvH1ZRB39u7ktceWk7vajXbQRrniAdZk2YOZd0uLmLq4HO+hUlXYZkCzqqZuL61Y78/Xxiu+H5xEat4wQOftnvHESPJrywMaE0HLc1ZH1ZPFgmrrDEQ1lyMjJoi6OU1IHq8h48bEm1g7e3cLCgjgHBTW6eVxu+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168108; c=relaxed/simple;
	bh=1T2Z5x0zGe9uatHo8ji3TKpgEnpy3/9ThyAAjOQIqRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ro1BB7mjQEJyGwgGvS57Qmx/7cBOmIZvzCHeQ2jhtJY8W1PCWiiX5aDGWj9AW9R0Y0s9YkYCmE+LNhxO1AXixC1dtiIaniqhpDNn9W7mQ2kRYDNrLQlcOgn/EkqlfLrKYfi6QgkRa6WhcKGCSz07ovVLBx1eP8C9R2+R+330n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3EhMF77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043CC32781;
	Mon, 20 May 2024 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716168108;
	bh=1T2Z5x0zGe9uatHo8ji3TKpgEnpy3/9ThyAAjOQIqRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s3EhMF77m4lsm1zrpEnIdk+10Pd2krVjCcRMmwjk6G/sYxM8KYR9J4rsy1UzB1pxL
	 EiwkgFMxsBzdX2c0FLKDGT0XyQDe6xxZtGEUZurPo5HPMged1Ka24M+6F/pC9TU2b6
	 OzgEwbFbCEHB4Q9ZbM3o/s51iZrpGwFLkLkl+yh+1uGqtR3cTLlXhq419HoTcS9ov9
	 V5AGUNzYf9JZUuEvM6EC6Oe52YLuJCE/wd9cjeekeuQXIveHAYPbvmQI2eZFUOVqwO
	 9+ahZQ7lroAyVULGoJ11520NfajW7EDGQPNenagClmOanr8ulqfJWLZgsV2EpZjF4X
	 aHOjdGhdqQrKQ==
Message-ID: <64a56504-a778-43d3-90a6-82f85be15b28@kernel.org>
Date: Mon, 20 May 2024 09:21:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to check return value of
 f2fs_allocate_new_section
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/17 19:26, Zhiguo Niu wrote:
> commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_curseg()")
> missed this allocated path, fix it.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

