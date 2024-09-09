Return-Path: <linux-kernel+bounces-321465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEC971AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2972B24D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E329E1B9835;
	Mon,  9 Sep 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttVmTxbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A61B3F22;
	Mon,  9 Sep 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888086; cv=none; b=B+NZWJA3VAYHRaWY22QptSThs2ugE6W0TVdHTyHAPQ8E/cvNZGp0nBX+JL7In9ch89EV+CDGOfQITj18jjmVFUBs2rXbK1fKs3DiqP1/l6RYGLZmD8aLzYHjuSEsoGTEl2Gmp2SeOCFgvtpHEWNjmHYXFOQMcCl8UT/K/5P4oIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888086; c=relaxed/simple;
	bh=wyRQUb/q9eHTl1vxYfPdfQ2cFjjyM6SHPgtqXugDeJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViU8NupyESBBdwUY6bCdK13N0ciIhG1aPY7ilIrNUdSh+mx/MX+JuPyBdNTxDCaYwKlgBcprJyYU1tjd4bmEVw13oBehszQcuztsa/hIzRXu8XLU/vhyiR3VgNINPTDkxw/HAM2uVLo+j8n2aTWotDBBBnnZo4X9Nw5RMR6Av9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttVmTxbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C5C4CEC5;
	Mon,  9 Sep 2024 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725888084;
	bh=wyRQUb/q9eHTl1vxYfPdfQ2cFjjyM6SHPgtqXugDeJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ttVmTxbb17rJ1kewLBBOB6qodut56iuWvmUS3MBB7qJeHa8S7gQsXz+wx++t9IAJg
	 N01aQtcbRzAtJFfg3tPizEzPbc3hGT881Xk1Oq7FHoL0LK3ZJQKrIquYaxMuYZV/y2
	 TqWsxf2HBlA3EUFiLf2KQCwUVdlHCWtL1gUvqLTxbDzw9NHALfBZ10P881DUTGx1al
	 WGtIxRgeZazBUa6eCQqqC33rkPpW0UunH3rK57rCoke33vqqAVF+hjTSxvxrQVBbdT
	 iDMoxaQd8FqtDbF+dVrrGdOJ/atk7LOqZFs4KMbEw52cppHXn3EigXh6qTPMXVqJjP
	 faX3a2KLxnw5g==
Message-ID: <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
Date: Mon, 9 Sep 2024 22:21:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
To: yangxingui <yangxingui@huawei.com>, axboe@kernel.dk,
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 damien.lemoal@opensource.wdc.com
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/24 22:10, yangxingui wrote:
> Hello axboe & John,
> 
> After the driver exposes all HW queues to the block layer, non-NCQ 
> commands will never be executed while fio is continuously running, such 
> as a smartctl command.
> 
> The cause of the problem is that other hctx used by the NCQ command is 
> still active and can continue to issue NCQ commands to the sata disk.
> And the pio command keeps retrying in its corresponding hctx because 
> qc_defer() always returns true.
> 
> hctx0: ncq, pio, ncq
> hctx1：ncq, ncq, ...
> ...
> hctxn: ncq, ncq, ...
> 
> Is there any good solution for this?

SATA devices are single queue so how can you have multiple queues ?
What adapter are you using ?

-- 
Damien Le Moal
Western Digital Research


