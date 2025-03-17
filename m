Return-Path: <linux-kernel+bounces-565153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC9A661E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BBB3AEF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E204C35;
	Mon, 17 Mar 2025 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiPXfD/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201E1F63F0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251352; cv=none; b=IkjGVSo7hzzP29jBxdsmbSbWt4Mnl3Q+hyGSktF/u0JSpvGmVr6h9WmVlatzlhReUtF7RLtCFlHYkjj18WSoPi43EXtzZ0aBAqT2n7cDvKvC6Afq3pSee7HwBscVAd1WpxWFW66P38mjMTX8QaF6rh6HL0mEkoyScoF3ih/co+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251352; c=relaxed/simple;
	bh=KIR6WzkuC+F2gl1MZ2wS9f/efB9PS9V+aePXtyI9MO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzWHpjC8fPVVOSj96xr5jG1eOWuAuRi1cWkOG7qhxukWKctiOxAySTpHl/HsaioV5nVYpC7iFGqhCKGy37CwkVurojQ9eu8axfRI2PDQczhewSiTy1eXx/irMhLofAMWpFCV+I8gUQDEeT45ptijAEm7LqAb3iz6Umb4QWo6qaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiPXfD/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA546C4CEE3;
	Mon, 17 Mar 2025 22:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742251352;
	bh=KIR6WzkuC+F2gl1MZ2wS9f/efB9PS9V+aePXtyI9MO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiPXfD/q7WpBInAQQFUU7Ka8j+AVyhgVL4NR8DMuBHNfzTfazcD9P9a+WZ2rwtZyE
	 67Lnm5qJtFvDL2pam4VLOFZmb2Y4Lx5q4UPNQnBlMbnGpVoj/mGffihgPG1mKPddnZ
	 fQW9t9giKSEzHj7U/wvlqGuFtj1P0j+KSC9O2QAFRlvs0UDDmNWk8wcd5iDSSXHE/T
	 2uoCanEZG0G8NfLlOr7WDxjfdtTekNAs4eVcisgcXrS+apZcCS46WzVJ68AKjlqoVe
	 jJc+kuJ4VmAZ9s+SUClAV3tH4vNJsxtXdpMvcKrmEcdUaPDEhH8KIJvulp2ULMXPKS
	 Q076DdUkXBkWA==
Date: Mon, 17 Mar 2025 23:42:26 +0100
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
Message-ID: <Z9ilUiy8IFt719kz@gmail.com>
References: <20250317104257.3496611-1-mingo@kernel.org>
 <CAADWXX_Fce0AFDS67OzNQaH0TtqEi=6-MsMO346wXzGSRcdiWQ@mail.gmail.com>
 <Z9ihNmJ0nGOPFmFV@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ihNmJ0nGOPFmFV@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Ingo, please fix your mail setup..
> > 
> > These were all in my spam-box, because you used
> > 
> >     From: Ingo Molnar <mingo@kernel.org>
> > 
> > but sent it using gmail, so the DKIM signature looks like
> > 
> >     DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
> >         d=gmail.com; [...]
> > 
> > and then that results in
> > 
> >        dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
> > header.from=kernel.org;
> > 
> > because the DKIM signature - while a valid signature for gmail - does
> > not match the kernel.org signature.
> > 
> > So you need to use 'mail.kernel.org' to send the email to get the
> > right signature, as documented in
> > 
> >     https://korg.docs.kernel.org/mail.html
> > 
> > otherwise any sane setup will mark all those things as spam.
> 
> Sorry about that!
> 
> (And I just sent out another series with the same flawed script ...)
> 
> I thought I have fixed that all up, but apparently only for my main 
> Mutt setup, not for some of my older Git-patchbomb scripts that used 
> .gitconfig's [sendemail]. :-/

BTW., the reason I didn't notice this sooner is because I read lkml via 
a local maildir representation of the Lore Git archive (all hail Konstantin),
where these mails showed up just fine.

Thanks,

	Ingo

