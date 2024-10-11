Return-Path: <linux-kernel+bounces-360443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6381999B04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35314B2281E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C2EBE;
	Fri, 11 Oct 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrJL1zP0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173D1F4FA0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616330; cv=none; b=rl15AnTPVXpaydtAyLmMuw8IS6IkkiWpuIWAZ2jrWyyi6Yt9syXyiMzbTCufILm450Zn+juj6KgNYiwYfBAmi4+1gCPf8lE01N96JpCx1CMnWwDXM5K638pvp02pg15tEjQZ9q3GSsfznVpO7zcGzE4mnaTd4wF+qKOfOiVH354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616330; c=relaxed/simple;
	bh=ES9TOK7eJS1nx2Q3UXzWLwz7JYFWeDakG2nX1hzty00=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k4aOyrXtz8YLbecxNbUw0O5XisEKGBo2eicQoNwnmoDgGIG/tdsGBV6kVnklejHe1cFXRLHqsnNxDgk5UEjSQJNtpC7rxwL1No0pXq10TvQTKyV6evyJkzlmagCpLXSUZzAaYE4mY3RUeWTX+ItCmJaTM4IQzAxi41rDYe8pO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrJL1zP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD2C4CEC5;
	Fri, 11 Oct 2024 03:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616329;
	bh=ES9TOK7eJS1nx2Q3UXzWLwz7JYFWeDakG2nX1hzty00=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rrJL1zP0JmkuA7xQA+fTj/43kqEf5OVPK2chcJL8g+hFtZa0c3b4EE32VrG1B2NhL
	 huIaj3WeYxbgB6YGyehUJVRoH+StXBNidAxHkPrEhi5Hgsd6KRTzv/OTgRIWWQkbHH
	 ub71sQTBrdjWVjRrW9u1/f7ukESgiN3Vke1iyeyaCtKPHhdGhrwbD8zLTWl6Q9kvQe
	 qb9mddzNuVIvoD2h5CPrj8waKRKhtsoU3G2O+FW8FQmPQvuZJmawZvH1FCxZFWbqq1
	 MSmeLobOxLGRBjcn9yq01z4vYNHxKQD4zpRv+RRx5waYcY/pUGKwNKyEnsZ+QM1wC7
	 Tu70JwVSbSAqA==
Message-ID: <76644f60-d310-490e-8924-aebff9ae6250@kernel.org>
Date: Fri, 11 Oct 2024 11:12:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] erofs: get rid of z_erofs_try_to_claim_pcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/10 17:04, Gao Xiang wrote:
> Just fold it into the caller for simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

