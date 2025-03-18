Return-Path: <linux-kernel+bounces-565261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B5A664CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A40189DB36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A562B9A4;
	Tue, 18 Mar 2025 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMdkQrR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA61F9FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260700; cv=none; b=JlUf33Cqbg3mBID6844aJ2Mxj3CYEtuX5U7afbTO/dKTmH2N0vIbTxZNVT1O2EGTIQu7SIQlfWKhvGfs/aNouqnqIKHD3SQJRzDtf40ds2BDuCFCBTV7DwtWuALLQ+RTjZh1SWgrJbosc86kD7cpaUTG0bImYVRMIcsMGfjbP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260700; c=relaxed/simple;
	bh=fMFPVorHOCpjg8ERi+zcOuznXgzdX23/BT/u3O+grH8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aZVXaoVOQmnzoLXc29NzPObA7sqL/LfZSzLE4DfP/k5gq96K1F6GpdoRAov/nNw2n+4MYmcSQR2C9TlZux0kXBLIlwHxtwNd0B/y1kMq23nz9msFkB5XlLuqmRtiNNcQAhpQS1rfz7wqQ7c+9xYo0y3Wc4AsuS5mumiWi608T24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMdkQrR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A5C4CEE3;
	Tue, 18 Mar 2025 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742260699;
	bh=fMFPVorHOCpjg8ERi+zcOuznXgzdX23/BT/u3O+grH8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OMdkQrR98Qcpvubm+QWe38fF8n7fs9ZDTIHcBVb9ta7m1xM+Lpue5wvUnuw5OshEf
	 Dhl8qeKhUkaPSAA2EjFgIL3XO+NOBlEZxLIv5wX1+IZ4pP9LwQ1Y3jeC6g3u+CmIlN
	 d2FoVgpnjdsjiFr4qtjbtyKfR1m4Ngyoj67Tgu02OMkTwGSpqWP5IS7E1EejEjuH0r
	 5KZbtRTiBcZQ++q5QPGnrj3ItAJbRMWkjkKVrfp3FkxhvLj4VmcB/bJoAUPNJADqIg
	 sE+eNf15l077oD0PV9GhSRDxzF+ZKCGURXfqQ71RLDy+VhourbkipyoLNY+dTYkMir
	 jHjTZ3RIEkRIg==
Message-ID: <5562d492-2ac3-4bd2-b61b-70fea4e1c330@kernel.org>
Date: Tue, 18 Mar 2025 09:18:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH v2] f2fs: optimize f2fs DIO overwrites
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250317133611.457-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250317133611.457-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 21:36, Yohan Joung wrote:
> this is unnecessary when we know we are overwriting already allocated
> blocks and the overhead of starting a transaction can be significant
> especially for multithreaded workloads doing small writes.
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

