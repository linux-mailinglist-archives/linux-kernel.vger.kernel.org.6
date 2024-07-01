Return-Path: <linux-kernel+bounces-236945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83491E8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6631F231A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65C16FF3B;
	Mon,  1 Jul 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p8L1csTW"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484216F0C2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863638; cv=none; b=qrbWMa6WSpBoS+vGpKLPjxA+AbMI5wJh4M4n/VXb7upZ606orTCITJeh2OclwbKuhacaNTKT8MfiOyQCm+JDUb0NPOEdaG/PsPRgc7PVxTfeTmjLJZt+myTCttKjs+ipbtnWa6dVfOkjDa96O+EuxezV3PduXsSQbZf/EEocKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863638; c=relaxed/simple;
	bh=wq9bhqS3zCbu9gJD3O0EoBVvdzJE9spKvwDbUBPvqwE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZZEmgGTEWuRgdp5jdg6EMgv2vckwuYreWXIcspLXCkNZbZoyRUckJKKkhpZPMHv2K3DWC+TgqHAdPe4D6lNhyZcX4DZ+Z5q/3rxOw78IID4PqzSwYkOJC8UzZsUJa77DG5ilJl2BTiTyf2vWTAtfR4Kbre2etcZlDwpZVsa2fKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p8L1csTW; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WCcDh0CSvz6Cp2tZ;
	Mon,  1 Jul 2024 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719863632; x=1722455633; bh=2RedW0+tdVWSl88RavhXHAEH
	rSw/trVcgxslWfPVWLM=; b=p8L1csTWtBqrC01fYg07g1F1oZmCFAE7fdieicTj
	gFNT8j6pj7Lu4nOWBXL0JC/KZ+JYTOSrN9Xot4kZAreFxwUaxEMJVNS+0tSMCFdM
	drYhkm1wMITXO1xFfih3gzq5u7Y1qcgvQyAoXGTcvcbTb9i7M1qoC9W2hB+JR704
	MGlnpSyKcEeeATEJ00bZkZldEIa9/f7VXvIXMqaPTOB8AD3KZnrspPUe+ttHg9Rj
	PqKpxK9ivsWMTq4bKIkjnLbqerb8nmLLMEGgH10F5nLliGD6PezGYX0QhZuktYID
	8n1M6WNgvePPVkYN4kAicYEEVrRSBW2lqSZBe76BlIFFJw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EBgrLXBx4vtf; Mon,  1 Jul 2024 19:53:52 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WCcDY3FQQz6Cnk90;
	Mon,  1 Jul 2024 19:53:49 +0000 (UTC)
Message-ID: <3d8f288a-bfe8-4d25-967c-1be688bc1667@acm.org>
Date: Mon, 1 Jul 2024 12:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 23/53] pds_core: Simplify a create*_workqueue() call
To: Brett Creeley <bcreeley@amd.com>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-24-bvanassche@acm.org>
 <fe0ecf26-e098-473d-a78b-58938a237bac@amd.com>
Content-Language: en-US
In-Reply-To: <fe0ecf26-e098-473d-a78b-58938a237bac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 11:49 AM, Brett Creeley wrote:
> LGTM. Thanks.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> 
> BTW, I don't actually see patch 53/53 that renames *workqueue2() ->
> *workqueue(). Am I missing something here? It's mentioned in the
> cover letter, but I don't see it on the series thread.
Hi Brett,

I don't see patch 53/53 either on Lore. Maybe I hit an outgoing mail
limit when I sent out this patch series.

Note: as one can see from Tejun's reply to the cover letter I will have
to rework this patch series so I'm not sure whether it's useful that I
make patch 53/53 available now.

Thanks,

Bart.


