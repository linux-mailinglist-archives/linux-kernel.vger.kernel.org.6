Return-Path: <linux-kernel+bounces-565132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD92A66186
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66433A6B30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45305204F80;
	Mon, 17 Mar 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqOIBZ3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEC1FA14B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250300; cv=none; b=O2mC762IkoknMLm7jTmQC7nlHvwv2G2wE4rC71pInTY+lP11BKMMcBtRCP4QoirgRJgRQ3Kx5dV9qitF8QtbciBCrOev3eQuYcM+ohPl3AYCMVxMgWURdGagTXdiB0aU5Wcf0kws83nHUJlae3ZbHeQlFSBPH7tdNxbVQqBf2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250300; c=relaxed/simple;
	bh=5K3yZOXZx/Xyf25LYgN7D4kSfCDLFOH3vhWsRsEXNt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avh2K/ujrE6GTM3dU4Rp97UF7PW2QnzlN18z51/xSNvIrpNh2L8ulxUoS93qdqm74q0oIgeGrijVKBb8xXpGXG4h+jU5pA/IaC+EVj4+bNFAXys15l+Fz9FnCriXw+dTXgnWi+3Ng8hatKqFrUiS8obAzwdWSkb8rmHslcmPz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqOIBZ3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B206CC4CEE9;
	Mon, 17 Mar 2025 22:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250300;
	bh=5K3yZOXZx/Xyf25LYgN7D4kSfCDLFOH3vhWsRsEXNt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqOIBZ3BdQ54U26W/tILEBOSN3I5665tMGDRAnHoPyfNG95rfD+QtOLoiE0ExrQlQ
	 MNezRnLFrXfCQP1kt/VLtEci5WEwCFlVHR+3a+giWwo9W2FRTtx5oYSumy9iCPPwI0
	 IaHwyMsP3C3dmP7xctrP13FCUUFwtGhwovLqZ2O4ce+b6x2x/Rk94EQDj9AZ/Bjs7q
	 FnAfPKPFRbixQw7apV7YZoFp2Z+YePr76oSjDSK1HTbZjE4tzog16G4+igHrvHQzUw
	 2nIdl7r0vCy7JDZY/fIrN65u8kCSh4IBBHqtXh2uLAjkUtDrPjLzIfM5lD6f1iuigG
	 FtZjCCG1RdrUg==
Date: Mon, 17 Mar 2025 23:24:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
Message-ID: <Z9ihNmJ0nGOPFmFV@gmail.com>
References: <20250317104257.3496611-1-mingo@kernel.org>
 <CAADWXX_Fce0AFDS67OzNQaH0TtqEi=6-MsMO346wXzGSRcdiWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX_Fce0AFDS67OzNQaH0TtqEi=6-MsMO346wXzGSRcdiWQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Ingo, please fix your mail setup..
> 
> These were all in my spam-box, because you used
> 
>     From: Ingo Molnar <mingo@kernel.org>
> 
> but sent it using gmail, so the DKIM signature looks like
> 
>     DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=gmail.com; [...]
> 
> and then that results in
> 
>        dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
> header.from=kernel.org;
> 
> because the DKIM signature - while a valid signature for gmail - does
> not match the kernel.org signature.
> 
> So you need to use 'mail.kernel.org' to send the email to get the
> right signature, as documented in
> 
>     https://korg.docs.kernel.org/mail.html
> 
> otherwise any sane setup will mark all those things as spam.

Sorry about that!

(And I just sent out another series with the same flawed script ...)

I thought I have fixed that all up, but apparently only for my main 
Mutt setup, not for some of my older Git-patchbomb scripts that used 
.gitconfig's [sendemail]. :-/

Thanks,

	Ingo

