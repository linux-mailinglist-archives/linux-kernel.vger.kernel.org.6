Return-Path: <linux-kernel+bounces-428583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D39E10DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04925163EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BC42A8C;
	Tue,  3 Dec 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Co7pN6fp"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6D15E8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190165; cv=none; b=qSup/KpWK1qMIMif+cS2JlKByWbMjDf9LEqid5R5/5sY5YqG/odBOerzt3Iy2iiTvQd2oIHRXXi3RIzBHDHCuSguLOSiRO4FxCU7niAyvMdMXa53mvmdqKrh7tJ+HuD3jKZW6Kqnv0ACkAbq3bbZ2/Y0VoM+hnNc41Ph47goYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190165; c=relaxed/simple;
	bh=3OuQ64WNHteqMnT/yX5B8uaYCz8jii3Me8fy5dtoNuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5PwwZdSEabWVO6OVc5OO18x1Ucs6GGycCjPV0Ysmuo8GtFbJKRGxaxv7f/VlWpXCavuj8NPKdGzPXQUW8UWRC+cp4fK0LR3fZsO1MIe4qZKr2loxmzDfpP1Mk5jgzBRhnBmhXHoWGYd1dXqkBJmzJIIKSgsQb2aVTwBTbaakUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Co7pN6fp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733190155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uTUj5YMURf+KKG8f/1Sz+bcXu3/nl4aaFLZoInHn6Y8=;
	b=Co7pN6fpmzoWkq2XF1sFay41NTb1rQtyHdzz8qDGJPJg98beu9xX+E27mJREU9EQZMeAsGPDxnQ8aTXVq7A1rIlp5z7BU9dR7jPHcSjQlhHoPYIHXmtumcBplnNQ7T64fsU+e8CpDRA+boEd33J/1fqX6wlr0vYXJm9/LrwfDww=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKknLlN_1733190154 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 09:42:34 +0800
Message-ID: <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
Date: Tue, 3 Dec 2024 09:42:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Sandeep Dhavale <dhavale@google.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sandeep,

On 2024/12/3 05:52, Sandeep Dhavale wrote:
> Looks good,
> 
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks for the review!  Max Kellermann reported the similar
issue can still be reproduced with this patch although I'm
not sure if it's the same issue though.


Hi Max,
I think at least this patch resolves a recent regression,
I guess we'd better to address it first.

As for your reports, I think we might need more information
about this, since I don't find more clues from the EROFS
codebase itself.

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.


