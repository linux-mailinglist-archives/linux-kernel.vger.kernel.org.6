Return-Path: <linux-kernel+bounces-235467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649991D573
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A337280E75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F481726;
	Mon,  1 Jul 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKulUFop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642115CD7F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792926; cv=none; b=UTSo49uVq/OTkNFVs6ZmzjUFshG8GTxvQY1fn4nTZg+Uxq4opof0JdA8iyl43tRWGHBRMbVe8Ijdn87YXDVB1fYHG7PqeYxlgD5YyO9a33f5+ISnaqmAhSGSGmFHw8wDZgvrGAhO7S89bFJ3zlYdJmmC2PzVufGomP31AQJ/QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792926; c=relaxed/simple;
	bh=0FS5iDfdIF15d3pUk3us0GGQ1UCBqx2uK0p4uMf+sOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhU3U2oo8P3gPAGJdnZHIESWYFN8Edjt5okJwUPjwUuphujlEJwEMlsjxyGbEGuaxLcjmFZHSAM6F2+oMVig6XkvKYJ+dxAy02CohXXH2sx9shnToRSfsUqapF5rz2VrEUXCCX8aJwYQh8HmY+KYgfV2e/sWLzeQP2571NW94Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKulUFop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FABC4AF0A;
	Mon,  1 Jul 2024 00:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792925;
	bh=0FS5iDfdIF15d3pUk3us0GGQ1UCBqx2uK0p4uMf+sOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OKulUFop4ZiIt4HyNK0JD6oAOC3VwMSvnRoXl5jur9iA736IfJe2yFA98gjTuzxdW
	 TmdmfBFQPUnXmG9OaXGgxAAQ0GAkLPOO9kTYiPi8Q1yTQCcHXgNyRFRrZzd3clQRLT
	 exARznRmAiwBBmqrRWlPH1P3gpnecUXo2tcYHBcLA0xgO0yEwUh1/PM6VrwpRW6vKj
	 JkO9w18Vw6rssnmeVX1488ENQ/AZmVwEGI7vOd/h1LiKYlyfxAafZBdms61ZEUFvX3
	 Mt+AiHXlfymwVMLPFkXo9gjRobiCWaUSaxrB6IyhsQcYfzeGC8jVQBq+YCXappQ7S9
	 oX6klBmBuxnhw==
Message-ID: <21e74654-566f-42ca-9d48-377555dba11c@kernel.org>
Date: Mon, 1 Jul 2024 09:15:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/53] scsi: libsas: Simplify the create*_workqueue()
 calls
To: Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-34-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240630222904.627462-34-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 07:26, Bart Van Assche wrote:
> Pass a format string to create*_workqueue2() instead of formatting the
> workqueue name before create*_workqueue() is called.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


