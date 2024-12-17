Return-Path: <linux-kernel+bounces-448343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8099F3ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9101888346
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC331C687;
	Tue, 17 Dec 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8Q/ZoSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2B1AAC4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395834; cv=none; b=Qp0Bx1UfR7hBi2mO2DbMt15JwhZH1lbhuHCocYecQfZkOdyLSBmfLwZXJh3I+8k8RNumKWYtaZip8JwDZBnuwW2D7P5xJKJHByORhxFsVxhOAdXYkMwJUjDUqK1x07QBO1FMr4MOuTXDi+RvdMqpfIR0JHieB36O1eu30ZdFfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395834; c=relaxed/simple;
	bh=or8aQNIWjE5aJMIhxK+Pj7nvl0ViZp1i2WmmoRDdtGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5mNhZ7daMWZKwo/PoYkyFXyUze3giXselWkLmoGrC+vzMzFYArLJK7YBDEb7QbQ/TjE9ZHWkr7Y4F1Op9jzE4Uv1V9WyQHtJHp8TpDduieVJbjN/r022kdlN9QCCpCBj2CdOYXmiFnKzJxydnEhrrMgMgLc4cSjLXQKDXnV6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8Q/ZoSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95118C4CED0;
	Tue, 17 Dec 2024 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734395834;
	bh=or8aQNIWjE5aJMIhxK+Pj7nvl0ViZp1i2WmmoRDdtGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8Q/ZoSrjQRMbSGJuLqD6cTvkLxCHGG6OmtqdQwk5VZxXskERhVeHm5RA4RQscp6C
	 fF2MBM7M9vCvNmr2bPVlP54teiPJR18Od55+I9zkW9fe1lGzI+EQ5KazqxoTjnXzyF
	 We8ZglQsjel9DBapTDjNqx8+f047gPdjoWt5p7vdpqh8cnot0fAdKLGaA1cDSNYqaL
	 UyMnlR4yPd1/fSVGZ2FKXECZ7vZ2AZWUQae2gEOCLIEPwpkrrRE7m+ftPj7KKfbHRO
	 3MeQO2TokiG+b3NMrGBuD1v+LT8/3AFFhar7iztTeBOMyJnknVrk7/wfMdB/s5acr5
	 VeRTePp1pAFQQ==
Message-ID: <e5e6f061-5440-4b11-9ff2-ec824347b651@kernel.org>
Date: Mon, 16 Dec 2024 18:37:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] firmware: stratix10-svc: Use kthread_run_on_cpu()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20241211154035.75565-1-frederic@kernel.org>
 <20241211154035.75565-3-frederic@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241211154035.75565-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 09:40, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   drivers/firmware/stratix10-svc.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 

Applied!

Thanks,
Dinh


