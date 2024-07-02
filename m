Return-Path: <linux-kernel+bounces-238115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792B9243C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BF21F27573
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869971BD505;
	Tue,  2 Jul 2024 16:43:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265B14293
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938618; cv=none; b=mbdxguAIOJOu9W0VjY5rXi9Yv0GYyWD5m/h+Emtg6z0mrXvDHgxtBMZDAF3GLhlf1PcRm2wSLbaOPP7O5MRg6lLVOKWc97prIstXXAflKISj6zoBFra2JK0jHhbirr1Yn95SKVhjD+KYKlZ/Eu6j1uABI7ioE65O8mYH7JovWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938618; c=relaxed/simple;
	bh=D2WDHa3LUyiIin8nvwodCh4g4oebVGPpsaxLUYR7ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwLYeJ/60Qd/h2+r0P7Zf0oudwt2TpXuHGHsTHMT2CsBTX512uCLSW62/Cl4NnmlvFWiJH/MlpE6ZMoFYNE8MTXvabP0wfh2QtXWHYn5/2v7vvVfNoS/F0Jzv54ALcc2Ek5XrOwEDDYz9Mr6uBn2k6/lLI9WMc06JvUADusTRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934B0C116B1;
	Tue,  2 Jul 2024 16:43:35 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:43:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <xu.xin16@zte.com.cn>
Cc: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <ietmar.eggemann@arm.com>,
 <ostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <bristot@redhat.com>, <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>,
 <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>, <liu.chun2@zte.com.cn>, <fan.yu9@zte.com.cn>,
 <linux-kernel@vger.kernel.org>
Subject: Re:  [PATCH linux-next RESEND] sched/core: Add WARN() to checks in
 migrate_disable()
Message-ID: <20240702124334.762dbd5a@rorschach.local.home>
In-Reply-To: <20240702193359997GhKH_KNYXYGLV7TlNVtkq@zte.com.cn>
References: <20240702193359997GhKH_KNYXYGLV7TlNVtkq@zte.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 19:33:59 +0800 (CST)
<xu.xin16@zte.com.cn> wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2259,6 +2259,8 @@ void migrate_disable(void)
>  	struct task_struct *p = current;
> 
>  	if (p->migration_disabled) {
> +		if (p->migration_disabled == USHRT_MAX)
> +			WARN(1, "migration_disabled has encountered an overflow.\n");

This is redundant, you want:

		WARN(p->migration_disabled == USHRT_MAX, "migration_disabled has encountered an overflow.");

I'm not sure the '\n' is needed, but it seems like 50% of WARN() has
them, and 50% do not.

-- Steve


>  		p->migration_disabled++;
>  		return;
>  	}

