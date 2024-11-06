Return-Path: <linux-kernel+bounces-399017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C79BF97F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16171C21201
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1820CCED;
	Wed,  6 Nov 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOLifT3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E61645;
	Wed,  6 Nov 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933587; cv=none; b=qrVeIaCi/WURy8CegVnUIsQl0IZarNRRB/vZhxEzmJDhE7AjsirXWpEPK4UauAvePR3FUZmtxIJY3TKhY/rfupMVttonzidlifmGt10hlYa50pHKV1lNm5VZI+dKzFIOGAOqVARDGTspMNThKy9LtPvHgaRpyOuqbxaEAOh8C7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933587; c=relaxed/simple;
	bh=2rG0V8XGr+zNT9gx3HFi1etRMN45S04G2ksfE2rB3jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knfEa5Ke0crmOtgdKrtX55WaiAIjb9YkP1Fr7QpUop0Jyji4seIAV9LfTVAi7+iLu6G2SJMovxeFvkYSevPUXgDMGE75jPHu9HuN3Tt9BjBxIzy2XPk1BLiQiBRJsyHhPIsXSdLWo61sGLbZlKvR8huJDb9p8yp3pa0V+ojprTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOLifT3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF89C4CED0;
	Wed,  6 Nov 2024 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730933586;
	bh=2rG0V8XGr+zNT9gx3HFi1etRMN45S04G2ksfE2rB3jY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LOLifT3YKXRXzrX5ofcXb0Y3OpIX1R369xEpkdqk068QHjZGE3jTRIH4INnAzVMHU
	 SoMtuAd9i8OPF9I7+Okhs0NbO9nO3I0OLR7glx4gkbEBPoHU1dPF9sidB8GDYCV/tx
	 WiRfkU0udw3IKG4qtZTZhYpaZVdsQ57CwcdXM950l15sdbdOVb+JKgMg3XMfmcLtCc
	 u7UQ4g2tEwQ3RqQkN4C3oeaGx44d8ot4BKjiV+CRtSalivZgZlFpZLgqM4Be2kNo+d
	 QtbdMcEqbOlTydvGGZ2VCmTZ8n2QR37JpQwRR+vamw9q5naVV8ATKLg/Pea9ls65Qu
	 ZdL3RoTj7w9ZA==
Message-ID: <fd494e1c-9d77-424c-b397-af7059ee1fe7@kernel.org>
Date: Thu, 7 Nov 2024 07:53:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test
 variation before object free at line 583.
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <202411050650.ilIZa8S7-lkp@intel.com>
 <20241105153422.GA7132@lst.de>
 <e86904d7-bf42-4b38-889e-3978e89358f2@kernel.dk>
 <20241105153733.GA7219@lst.de>
 <5b55417d-6b27-4186-bcfa-d6952624e99f@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5b55417d-6b27-4186-bcfa-d6952624e99f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 00:56, Jens Axboe wrote:
> On 11/5/24 8:37 AM, Christoph Hellwig wrote:
>> On Tue, Nov 05, 2024 at 08:36:33AM -0700, Jens Axboe wrote:
>>> On 11/5/24 8:34 AM, Christoph Hellwig wrote:
>>>> On Tue, Nov 05, 2024 at 06:52:25AM +0800, kernel test robot wrote:
>>>>>>> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.
>>>>
>>>> Does anyone know what this warning is supposed to mean?
>>>
>>> It's supposed to mean "use refcount_t for things like this".
>>
>> Have we finally resolved the performance problems with refcount_t for
>> fast path operations?
> 
> I mean it's closer, but it's still slower. Will always be so. Does it
> matter for zoned devices? Probably not.
> 
> I don't think it matters for this case. It's not like the ref itself is
> something that is user controllable in terms of being able to get
> anywhere near an overflow.

OK. Will work on a patch to switch to refcount.


-- 
Damien Le Moal
Western Digital Research

