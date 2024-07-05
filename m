Return-Path: <linux-kernel+bounces-242220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E567928520
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA7284198
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B7145B39;
	Fri,  5 Jul 2024 09:31:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC213665A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171917; cv=none; b=Je6oLGT9j9zWJ/PcFGJk7y5TNQYM9Puaz6fCW8ZTg/7JZ+vIiO/FdQ1LDw9Qh7e+N0YvInWtueFTzmh6/VI28vZ1rpzBKGHZTOVEp4J1+wJnUiO8myRquv8FOUPpVSQnSEeNhjdeB/lJL8pKk6XRZgfBLbIouDWZsdhIw3/Ufkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171917; c=relaxed/simple;
	bh=FvpOwEDkhL+RxX/D+6AeC1nrb4dMxJn7uqYvZ/MIRwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAefX/ffT3tXkDwat6/MItDv8tpEqvLk6wcqLZDDOdDw0iTQUNgYq98dHmoP09fiUXVMeDetExEbH33AMXZZloyTHbawT4hegJHdBF2p8h38cNghPsA86Edx/IwytRb/4jY5qILjgbH8azWjtXp25Z3ulzslXBJJpXCyHG/rVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3BD367;
	Fri,  5 Jul 2024 02:32:19 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BAAD3F762;
	Fri,  5 Jul 2024 02:31:52 -0700 (PDT)
Message-ID: <59e27c5c-aa6d-47b7-ae41-c03b272cc126@arm.com>
Date: Fri, 5 Jul 2024 10:31:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, chrisl@kernel.org, linux-mm@kvack.org,
 david@redhat.com, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com
References: <20240622071231.576056-1-21cnbao@gmail.com>
 <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
 <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
 <76876c5f-f769-43f1-ad53-a4af288af467@arm.com>
 <CAGsJ_4zpn5dMNNNcVcMngT-mJpWV-bzUV+RfQaLLjxMC73xfig@mail.gmail.com>
 <f9fde05b-0340-49fc-92f9-7fa091580444@arm.com>
 <CAGsJ_4xf_s57g5NmxbzFSZqyU05n4CoF5PFTZO73CE4CmB9fEw@mail.gmail.com>
 <fba6439c-9710-4b0a-873c-334058166c03@arm.com>
 <20240704161026.1e10805b184d7c7f07158622@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240704161026.1e10805b184d7c7f07158622@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 00:10, Andrew Morton wrote:
> This all seems to have gone way off track.

Yes sorry about that; my fault.

> 
> acks or nacks on the patch, please?

I've replied to the actual patch with R-b and T-b.


