Return-Path: <linux-kernel+bounces-444837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED99F0D36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01044188A882
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A631E009E;
	Fri, 13 Dec 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx0JSC7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F221DFE39
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096106; cv=none; b=KhvKoSKXsoYrJyCuEAMQvU2HUMsGvcKTznYzsGUkfmApl6tZ7zfLlXzMN0liIrBQOSgtlTvM4uHT2rI0xuR9WpnqRnon/vAPvknYLFauTI05Nfe1goZgTEz9WXUZSbDMFrf2zdAq/36c2c+LpEYjFLmm12evD8P3BpP5gWGldSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096106; c=relaxed/simple;
	bh=VHEAr5KYFvo5hIggiVMSNmkx+Ww1/5VcddrGY3bKj34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6N9+84s3+yOArDsSEHn3c8l9iaAHODVOBWndX/9VtW75jlxXreDwmK2H6jtq/96gDxXInVOpufcU3igPsYEys1FEmaRpyklUj7QJ6s/iRiS84V5dsj+tbimsIIu3nfJMrT+HyemOuWeLCy8nA/to0SV2jKVv1pD+v+iy6aGvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx0JSC7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F13C4CED0;
	Fri, 13 Dec 2024 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734096105;
	bh=VHEAr5KYFvo5hIggiVMSNmkx+Ww1/5VcddrGY3bKj34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gx0JSC7TA1WgdL+zEjJI4/2C/BE/wP0f6ORk7/1YxFiGrCFeJMSUnSESelFT9XJ0u
	 55WHGS4Qi4FKGt/k25pELZK9HBSSkYEW8yRu42aPqvipoiJbDDL8wIYn7pNei39Coj
	 0nxyNr1judqA0uD+bj3F89kOt9yzc0KEdzZnvNeM/ZxZsvvXKc1yeDiOYimk6GxQjn
	 IzqUwDYB8BkJUFC7bFhqSrmBcUuxFbY9o3u6Zq6bToSDr5DcqiiFWPhw0g1ed9Yhik
	 E9Uc/br72AQ3qmk58xiVAoB3QOrswnUiWXA+LsYvkObOIBabmsc8tWa5kr2M/4FKJ/
	 iZ1mvICDCfxyg==
Date: Fri, 13 Dec 2024 14:21:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 3/7] sched: update __cond_resched comment about RCU
 quiescent states
Message-ID: <Z1w05hCkmHT5JIf2@localhost.localdomain>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
 <20241213040658.2282640-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213040658.2282640-4-ankur.a.arora@oracle.com>

Le Thu, Dec 12, 2024 at 08:06:54PM -0800, Ankur Arora a écrit :
> Update comment in __cond_resched() clarifying how urgently needed
> quiescent state are provided.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

