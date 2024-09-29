Return-Path: <linux-kernel+bounces-342927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606239894E7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2051C21AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915815F41B;
	Sun, 29 Sep 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fL9p5kzu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Av+XuoK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062C13C918
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607160; cv=none; b=QO+3DWLf2oza4EdLDk1LlkWjSmCwRaTtnELCHbrOqNlNTBPl8GxsxeeM6F2wVMbje6r50+tTPdjAsBNaQFWxVfuKDQuOvsuQdrZ5sfHtjSxB5CahWeaxejjR4g095afrfj9A2PdvdSvczXPm11N9hTaklo40zvXTUBbJ1UPqhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607160; c=relaxed/simple;
	bh=Iq77x4MLEGgojJ8AajHtBHQUxibrdfvijC+nEkxrpyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rr7bfd/tVbT+V+HVVG4QQrTm6E5m4Jm62EKUJ8qassMM6KIdph2EUeSqnDcT+aH3+E8ePutrmmIf+ZkV+wvVDLARS6vQd29oobrNhJVTr1M4AkphE9SLq/HR/5diDR0oF8Tp/cCM091U6ZLMypwGzAWaGd0vL9oVtHBylaZgbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fL9p5kzu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Av+XuoK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727607151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neHGIRG6ObTmuPNtZ+HaQ6fkZuReAPwqce8LCfhesuk=;
	b=fL9p5kzuRIt6VGDA4RqBBmjkjWurYlThgac0kd3CKMhoj/UAzRy8EfTLixAGXmF/yelOQJ
	/eiOL+6S3laniMoL/L4Wc1EQ+hMLivw54S+rklsqNSdDTcv9sT8RpQyK+4Fb8bO86y4Ihb
	MJvurKXcoy9Y0+pFVJAUvDImGKATgC5iBwE/KsCaRTT9sPU1Zk9LWuY29I1YX/iEHVbEQY
	SmOkoMNB5MfFxEyyeag4g5fj7exXam+/DuSpkX194RRFhPk8+8b8eg3u6dWl+WB9xo+1FF
	iJleTPP7WDPjcvJnEoLYb742dyUtMVUHAOUSbUJtsS9fF+GlBPNu7c8EEMCHfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727607151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neHGIRG6ObTmuPNtZ+HaQ6fkZuReAPwqce8LCfhesuk=;
	b=7Av+XuoK9qEYV+knfSqJxYR6azNXDFlqEPeW7nwvoZqQ3MsruyCQ8xtluUgrJvW5lpZYLP
	u9fNoXOowK3D1ZCw==
To: Remington Brasga <rbrasga@uci.edu>, Christian Heusel
 <christian@heusel.eu>, Shuah Khan <skhan@linuxfoundation.org>, "Ahmed S .
 Darwish" <darwi@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Remington Brasga
 <rbrasga@uci.edu>
Subject: Re: [PATCH] kcpuid: Fix potential dereferencing of null pointers
In-Reply-To: <20240926223557.2048-1-rbrasga@uci.edu>
References: <20240926223557.2048-1-rbrasga@uci.edu>
Date: Sun, 29 Sep 2024 12:52:30 +0200
Message-ID: <87v7ye20lt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 26 2024 at 22:35, Remington Brasga wrote:
>  	if (!func->leafs) {
>  		func->leafs = malloc(sizeof(struct subleaf));
> -		if (!func->leafs)
> +		if (!func->leafs) {
>  			perror("malloc func leaf");
> +			return false; // On malloc failure

Please get rid of these horrible and pointless tail comments.

Returning false here does not make sense. This simply should terminate
the program.

> +		}
>  
>  		func->nr = 1;
>  	} else {
>  		s = func->nr;
>  		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
> -		if (!func->leafs)
> +		if (!func->leafs) {
>  			perror("realloc f->leafs");
> +			return false; // On realloc failure
> +		}
>  
>  		func->nr++;
>  	}
>  
> +	// Check for valid index
> +	if (s >= func->nr) {

What's the point of this? s is guaranteed to be < func->nr, no?

Thanks,

        tglx

