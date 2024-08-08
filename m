Return-Path: <linux-kernel+bounces-280227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1F94C769
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E2285EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED6161319;
	Thu,  8 Aug 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrpuUbkY"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E055769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160318; cv=none; b=ZCgJZZ2KTdNzllGga4GaK/ma+1H6M/69HBDj6/8I9n6yGEuCEnobJe7uoA49OYtaoq5TDUeB0zJHjLfvOdDTTIq+0iSDWVHiseVa0/TeQDe2erpxtfT/51IKl9T0YICDH//w6h2NBwxZqPP5q6KuKkoemgqxyc4KnOwKzj5BK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160318; c=relaxed/simple;
	bh=MYU0SWdIRPgs36q+m0dUnq+szMZHfxqV5QbCgpeKwag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roJVhf9yaQEufmCCehmmfpP+YdYTnZisqyCJ0hBTowJfVvSGiDBkpmUMJpnARDdTtzgHef4wutCLB2AUmHd/WFzTiu/v0TS5KzIZTrz4TVB+11KNJszQmoxqBPAxgB9orzayAPkI5l4v857rjnONBoPkSeBHsHSJB28koCBSs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrpuUbkY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf11b91813so1205926a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723160316; x=1723765116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ7jv4RhI7SABFvCFqFeJd8kC90euBslE65wDW83z7M=;
        b=LrpuUbkYl9L/cjRMH9xJwvTDq9seqheT6HvzoB2DNEapoM41W1GL0cDPDxocu3fhIN
         LVyzGW44sRmhi4WvTbV11pPUCoZZjxKmRuC+EY+xYDsbblJcczX33BORYYfpwEzPqIRt
         k25sRMTmNT9SwIz02UFohYEWIgeVJxv6E2vBnmgUF1JTR9c1ym4lAwTjX5mYhF7dGunP
         WKTgP6h0YOonRQdE7V7xrU1qchMQOexmSThVCD9DQjBOjAnYpBKSl7RvQK1nKrq6Q/Gc
         KmMXUdUvRruMUZU/AXviHnCL0CdrGLoJoXItRnvo8LJCtj43RXpdVKV5O3zag9wlWZ4w
         1jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160316; x=1723765116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ7jv4RhI7SABFvCFqFeJd8kC90euBslE65wDW83z7M=;
        b=wULhGFqgBYM8B3Ej19FgkAMnIM5tJb2ZvJOFnAJcKNPBlkV3KKnU6ieFIPcep6XdY8
         iVzTBqtgKIUBkop8ChZ6ICcc4kH3LGA9E3L5yy2TFg3ZlzHeAoarcc5j1B6t0ROIfwzd
         KAFz8G6pz1Oim96yBGrnGmmGwbvDu/FvnQVfJZydV0XfYYstWFERpXnh2zcP77pKskpy
         PJM+l7XCfPBPdJXkWniB+DJFdAcWskf4xGyxiL60f6ImJM5E6QEInaYPNGrPENTTPzc4
         fiU5gU9eMED7bwpgih53f6GdjoXEhOecFwpH8IGReInl4d5Iu67gXgWgOVZQfd6Uwdqm
         Dfhw==
X-Gm-Message-State: AOJu0YxOpeTWkPgL2kLFnV1fWBNr3mRPDVkxricv5D0seKDuekP0pbT7
	v8GeLP9MC/D8uExURTzbxHznvr6MyCekZgYg6whWb8kTqNH+PDw8
X-Google-Smtp-Source: AGHT+IEsDvDhVIL+X83T3OHlaW34pOURZU7v4PWnPHrMMqz84/q0bfMITQ5socTy44KMBnYTL6DsYQ==
X-Received: by 2002:a17:90b:368a:b0:2c9:a220:bab1 with SMTP id 98e67ed59e1d1-2d1c33fe308mr3854098a91.20.1723160316389;
        Thu, 08 Aug 2024 16:38:36 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b36067sm4031917a91.41.2024.08.08.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:38:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Aug 2024 13:38:34 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Make scx_rq_online() also
 test cpu_active() in addition to SCX_RQ_ONLINE
Message-ID: <ZrVW-mXD69t1uirv@slm.duckdns.org>
References: <ZrPxkt57GdP6ILlA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPxkt57GdP6ILlA@slm.duckdns.org>

On Wed, Aug 07, 2024 at 12:13:38PM -1000, Tejun Heo wrote:
> scx_rq_online() currently only tests SCX_RQ_ONLINE. This isn't fully correct
> - e.g. consume_dispatch_q() uses task_run_on_remote_rq() which tests
> scx_rq_online() to see whether the current rq can run the task, and, if so,
> calls consume_remote_task() to migrate the task to @rq. While the test
> itself was done while locking @rq, @rq can be temporarily unlocked by
> consume_remote_task() and nothing prevents SCX_RQ_ONLINE from going offline
> before the migration takes place.
> 
> To address the issue, add cpu_active() test to scx_rq_online(). There is a
> synchronize_rcu() between cpu_active() being cleared and the rq going
> offline, so if an on-going scheduling operation sees cpu_active(), the
> associated rq is guaranteed to not go offline until the scheduling operation
> is complete.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 60c27fb59f6c ("sched_ext: Implement sched_ext_ops.cpu_online/offline()")

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

