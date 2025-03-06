Return-Path: <linux-kernel+bounces-548559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F06A5466E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EF83B0EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DF2080EE;
	Thu,  6 Mar 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYc6XZMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE6201270
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253738; cv=none; b=IJo/cnCgK3XTKE6PbcuUVuLPBPZyeYgBX1kJEVi1jlC198l2EsZNRak3Py5ljUHypu4cgOT0/VzUSCN2uVZt/Q24AMmZHBEKwBrIfU05IjBp/OBPITo4zThzQAmksrHi79JcitoYX3QfIEUVzxv5m0znItpK9JhNmZ94SGPta3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253738; c=relaxed/simple;
	bh=d0zVXr+v/Wgiq9owufdrl0TSiKuAeBy/lLTh6slUbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmv3W8BzeRerXVgpXEWeIdPHwCesMXQ1+MXgLSKbUDWOCMijBoiQTw+6TETHL3TjU3VvMLp3sX6BN9Ubl3g+fYAwM3sW3HqcHXQnwrN+FOrquUBr8s18Rtow2moH7eo/2Xl0e+b/WwItNv3txEi575vXRAkTusmx0a23iMzQaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYc6XZMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4Gn6RsFLMWYDAgd1mOSGDSxptCBTGDRt0g2HKO+JxY=;
	b=YYc6XZMehntATG0W9uPSCmIO2tIhEfoSCbaVmGP7hOhIk8gyDmzK0pJ1NmPbEYsZNl6ZI2
	VCyNjtjoSJCwRR79c4TWqOh47QACwkDUE2vTeTZmItQbJ8k50ZxWA5ktjoD2GEL4xkdcyr
	HipMYRdJmS2eV/U+F7AeWZEmSed6RZc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-7gi-7KGFMxykCg-wqEzRJw-1; Thu, 06 Mar 2025 04:35:33 -0500
X-MC-Unique: 7gi-7KGFMxykCg-wqEzRJw-1
X-Mimecast-MFC-AGG-ID: 7gi-7KGFMxykCg-wqEzRJw_1741253732
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8cf10d1c2so11515356d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253732; x=1741858532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4Gn6RsFLMWYDAgd1mOSGDSxptCBTGDRt0g2HKO+JxY=;
        b=RV4z/LWgH/9ZvmTXir20PWG01emIT/UjZoroZgl9M1lNkp9RJl6L5pF6MFLAH9bbGI
         Qct1NVFxbBGCGctQgN2qCBBf6cFCN6lT4VOYfdPGIS+FObXI6sZbX0Rrk5Fh41RSotZD
         63UGWY86MEzBNWyQunSze+BORiPXeVgvfbzXc3qodHE2BGz+R+WcUG8MySgqUHJ2Vy2o
         wSvHojplKAtJ2fJpEg8M9s77JZVdboV1aKcZElOy8zhII/QieYl4j9OGtZw/pexDZtPV
         /hvEhwfNp+YI/XPy/MrFBynaf7nTaNUreL5F+dWHw9uHN64NyX74rmk9xGYSGQISclGy
         GMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWc0vui8FZFB6Ms/cxG0wMr46mBjGEB/RQbaD3iQcJD/cRcY8NFb1NrEqTjbaC+x46pclYKbLyh5iIlV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xr9J75g+VffVv1UZCjbmaUcFvtco2q+uIdShaDql4ux1xZHT
	ol2WhXDnhfRK+ggdHYyHV6Xoli2TbFo/F64NtFBb5+WFmbT6xvNI3DH2MFRm5KbTMSsD5L9eLYa
	TbidrahKPv/FaPjTRaZGR7spCkPxxyGdqAZUB4zii7bkadaA5J88faLbxg7wLqg==
X-Gm-Gg: ASbGnctvhXAc97q+1yy0mw/6N0qLKoEMhA7kpqRsvG2EmWD6NzYXCIdA1qEhBmDK6E+
	C9KnqVc2Z6z9UVLq3Y29Sgd6swbIlWHDw1CSd0X+Pj53Yl4z1dvsp/oUY0syXg3yLizbzpiZ8Fi
	/kAv66IbMXFExg4Xt6mqBcSaoBm+O6ItAwAMbPEi6wLGsOWUtxmS5EJPY3GE9xokIixDzhcB3IK
	eht0Aue+JKk84dUKHGPK/qjvhqnjKwUmbegEzdowElxfrpLuK8eK4eTfZd64xaqmu8RG4uV7jU2
	aROdCAJ1cBVgFf5sdIKgZTtquf/39E33XGyhSvrKyP+jrlEKoF9fV/tqe8zsMn6SGzx6FRDFdsx
	RzQ7q
X-Received: by 2002:a05:6214:2685:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6e8fb7ed69bmr5852676d6.33.1741253732648;
        Thu, 06 Mar 2025 01:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9D2PvqOQ0l2XmU4Rpj97A53jhU4Fn7KveyE0/a4OKM8y07aCbsVmiHy1x6Z7yx/4binaK1g==
X-Received: by 2002:a05:6214:2685:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6e8fb7ed69bmr5852426d6.33.1741253732352;
        Thu, 06 Mar 2025 01:35:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b5f9sm5383796d6.81.2025.03.06.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:35:31 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:27 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, stable@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Disable DL server on
 rcu_torture_disable_rt_throttle()
Message-ID: <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306011014.2926917-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306011014.2926917-1-joelagnelf@nvidia.com>

Hi Joel,

On 05/03/25 20:10, Joel Fernandes wrote:
> Currently, RCU boost testing in rcutorture is broken because it relies on
> having RT throttling disabled. This means the test will always pass (or
> rarely fail). This occurs because recently, RT throttling was replaced
> by DL server which boosts CFS tasks even when rcutorture tried to
> disable throttling (see rcu_torture_disable_rt_throttle()). However, the
> systctl_sched_rt_runtime variable is not considered thus still allowing
> RT tasks to be preempted by CFS tasks.
> 
> Therefore this patch prevents DL server from starting when RCU torture
> sets the sysctl_sched_rt_runtime to -1.
> 
> With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.
> 
> Steven also mentioned that this could fix RT usecases where users do not
> want DL server to be interfering.
> 
> Cc: stable@vger.kernel.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> v1->v2:
> 	Updated Fixes tag (Steven)
> 	Moved the stoppage of DL server to fair (Juri)

I think what I suggested/wondered (sorry if I wasn't clear) is that we
might need a link between sched_rt_runtime and the fair_server per-cpu
runtime under sched/debug (i.e., sched_fair_write(), etc), otherwise one
can end up with DL server disabled and still non zero runtime on the
debug interface. This is only if we want to make that link, though;
which I am not entirely sure it is something we want to do, as we will
be stuck with an old/legacy interface if we do. Peter?

Thanks,
Juri


