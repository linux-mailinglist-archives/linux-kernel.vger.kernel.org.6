Return-Path: <linux-kernel+bounces-400420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDC9C0D53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC171F235C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11113215F58;
	Thu,  7 Nov 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="VFjmvLPv"
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49A192B88
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001979; cv=none; b=W830IV0uA0FjiKHtMntzuHn8dvog2FdTLjDBKnnaDh8Y/QBh5jti8qnQbT7l7gRmzkjJr0Rki1aPzD22x5OO+UoSeq/WF2aBEtIqlDoYZmD/durDvJ2WvsDa1Xb3hKIOVamCrm0mp4J4++jG2vlppQi3PM7vooHYsbv2uq0taAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001979; c=relaxed/simple;
	bh=B9WY8pOBlx7C+40DYzCL2YvHLteD18iSzwQkWNkaz6E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=gVt6X4OjO6PnRnZoonzFangr/QCIEDS4gJC5vdEiNrKnAL1fboyplGfNOvnWg1GnijtmV3u7jEdZTMPERZaDwsFBpGqN7QHRalKHbjCDDV3bfxebdp7aWAmgJJFfCjPbuP47dwD4qizNubeYOSH9hDHHpRITMk0OcWT+aZzrVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=VFjmvLPv; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Type:MIME-Version:Message-ID:Date:In-Reply-To:
	Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References;
	bh=thPhgEcNDpwIj4aeaAJhbiklbKHn88EvS02T+GGfNXg=; b=VFjmvLPvPTm2lOWFwLf3Jni88e
	jLMpfcMG/D+us1YM1K/CJSJVrv0qJX2nmRq+EMAZf40YL5sXgw51VSUlN0ljivgQz6BTQLLzBazCv
	iu24ZDwm0yN0lYxjhE7h6VKbczegE8oygzpWmxGI2PclG31SFmtME9usdscIlkjItcQtT0jfw5dUk
	tzH1aI1GAPdVrSao+PlrdzQxv8gJAjtNvD0dBYkqWHo+SVe57nBOp0mQIqnKuCE5C/9kFAEPH+gIs
	7SEBehd08t1evksDjSafGQMHbAk4Km9NKYsZkf9FOdNCoXaD+zAPvY6KkQ6lKcW2BOOiXPLS/ZP2y
	Pn3nfxUA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1t96C9-0007he-0W;
	Thu, 07 Nov 2024 18:21:21 +0100
Received: from [94.31.73.225] (helo=DESKTOP-DQBDJ0U)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1t96C8-000Cco-1c;
	Thu, 07 Nov 2024 18:21:20 +0100
From: Thomas Meyer <thomas@m3y3r.de>
To: Mike Galbraith <efault@gmx.de>
Cc: peterz@infradead.org, bigeasy@linutronix.de, 
	tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 ankur.a.arora@oracle.com
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <9df22ebbc2e6d426099bf380477a0ed885068896.camel@gmx.de>
 (message from Mike Galbraith on Thu, 17 Oct 2024 14:36:52 +0200)
Date: Thu, 07 Nov 2024 18:21:32 +0100
Message-ID: <87v7wzklib.fsf@DESKTOP-DQBDJ0U.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27451/Thu Nov  7 10:32:19 2024)


Mike Galbraith <efault@gmx.de> writes:
> Full per run summaries attached, high speed scroll version below.
>
> desktop util 18.1% static voluntary - virgin source
> desktop util 18.3% static voluntary - +lazy patches
> desktop util 17.5% lazy             - ditto...
> desktop util 17.0% lazy
> desktop util 16.8% lazy
> desktop util 17.8% full
> desktop util 17.8% full
> desktop util 17.8% full

Can you please elaborate a bit more were those values, e.g. 18,1%, come from?
How to get those? I couldn't find a connection to your raw data.

Sorry for asking this probably stupid question,

mfg
thomas

