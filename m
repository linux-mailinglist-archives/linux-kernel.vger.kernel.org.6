Return-Path: <linux-kernel+bounces-546711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DBA4FDE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2143C1891189
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080F241103;
	Wed,  5 Mar 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P24Yyaim"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911B1F416D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175039; cv=none; b=HX3WsqPLq8+9et8TLYxh3rQO8jJWX0dNqQZAVbmjTRtZ2pd4GZCUSLe6HLtU8rBZPu2qQFzLvS9WhVA/zcgZnIlndmfUS5pP9ZGtRYbqT5taAYQXIkz16UE+uXa3iefoVlLZemF/kcfAZmOdloh6MbPxnPT44p0pj6Nfb6mdShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175039; c=relaxed/simple;
	bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWryD7RKSkRkQRqn0kDqB+vDoWWMoM/KKgprc1yB1/d22g8ccrwQpjGSy+UL0yPmgPAjrpdWi9JPCfc8nohDxJSRXRvBzCNMefGyBUZ5PK0fQ+aP6ed3U2X/P2jjLFrrV4v0mxDviSCbINXHAMATUVoJLzDyAnc5qeEPO0T+B6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P24Yyaim; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741175036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
	b=P24YyaimjZJ1/zkU5CjMoqQZa9xIRGuaSCjGLwGQaF8O09V/aVrMBDwSAyruL8zq4iX6nl
	VsNtHqkWUwO33FAwBzywzMwx+p9aNr7R6m1xTAZCLusH392YuH6mUq+PNmTJDiLRBXB3fb
	BMvSimsHMrN0adHQHM2wJBM275GR/Ms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-CwTxsaS_Ps2PJxnZXLJpoQ-1; Wed, 05 Mar 2025 06:43:55 -0500
X-MC-Unique: CwTxsaS_Ps2PJxnZXLJpoQ-1
X-Mimecast-MFC-AGG-ID: CwTxsaS_Ps2PJxnZXLJpoQ_1741175034
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b8b95029so496938085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741175034; x=1741779834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
        b=hQ/oEl3lJORHHQlxmC7ieB9nx52b7V/RNkeeYXx7p99/blEJcAjzvNJKoC7tYXGm4H
         5hzMXML6ELn11Wi28YcN7ApjXPp+MaxzWeFCNB6BWf3YIvaE+jFF3ORklf7jIG030UQI
         c758xV7TWD2xyRV3swcDBE2ObySTz9swYTYKYDJBDCopmO5Ce0jwgl2Eb6HLkXRX2bOa
         1lb78ofnmCQzxGX8nj7DR3vkEbeJW+Q/6yPe1zpGs6ho7claPNuLSXIwrmstwQ3VgVEY
         XlouBq+Ue7jkQkdwOVZl4yZ8/pFvi1h02gf+xwUpGXV42PBhoPjQ4f4fYtdVFkmijS1S
         ICpg==
X-Gm-Message-State: AOJu0YwEWfT6URKKYX5EVH0pRTHeL1T0a6+om52/C8VoMajnXW2A1H8Q
	GX3F581U3V80bJ+Hn/k6U5cOAUUP1cPHGxsRZou84c5GXRGOXKiiRFpT4qrORWUGIeT9VH8agVv
	k+Qh8XW9NZD34hAUnGjEK0Q1dcolKqugAiD4+ROe6dVlDQGLV+/a1Bfa8WIX0ew==
X-Gm-Gg: ASbGncso02rsel9/1ZSDSIWou3evPeEXl8/1BDS0uNmDwpB32l+QXIHjQ8mDPm1Q3g2
	HcJQQW/uy4RDKh3kIku5Rgo7gK04MA/D8y9gDs/4tli0M9nUAKOBTS7J9GRF9qXnUwcRkEevIzv
	ERWR7v+3PftP01dsoH/Cr5HMUzNzM97MnmBYYLSFYZAFBJyEC3GCn6+pNmg5jSWqS+wT/bnJwY1
	sSPk4g0tUBXxn+2/7I77nWyhBf8pi0Btr7/Bq4bJb8mMk39UcQC8TqnPDPDjQXbPvbEtHkZS4EZ
	kZpEk0oPZzaZk6H0mP8BpVq4cK9t0qDvD7UiCwjeDNrQDOVg+HE7xOtC5wM+6nH2F+kskNZ2f5Y
	pyZee
X-Received: by 2002:a05:620a:4455:b0:7c3:bb38:88e5 with SMTP id af79cd13be357-7c3d8ef9afemr474811585a.55.1741175034534;
        Wed, 05 Mar 2025 03:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeM42f765loSizjHEJobaXam/I1bWNzdv8SjjSG4IsKkXXUknDDoOYHG829povW2NR0z7mQw==
X-Received: by 2002:a05:620a:4455:b0:7c3:bb38:88e5 with SMTP id af79cd13be357-7c3d8ef9afemr474809885a.55.1741175034249;
        Wed, 05 Mar 2025 03:43:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d29d77dasm179383985a.115.2025.03.05.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:43:53 -0800 (PST)
Date: Wed, 5 Mar 2025 11:43:47 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z8g482-ZD7iuhhoC@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
 <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>

On 04/03/25 10:33, Waiman Long wrote:

...

> BTW, dl_rebuild_rd_accounting() is defined only if CONFIG_CPUSETS is
> defined. I think you should move that declaration to cpuset.h and define a
> proper wrapper in the else part.

Sounds good. Will do.

Thanks,
Juri


