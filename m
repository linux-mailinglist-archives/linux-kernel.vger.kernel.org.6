Return-Path: <linux-kernel+bounces-557805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0BA5DE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD5A18971D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA724C664;
	Wed, 12 Mar 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0j+fsYL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063A24BC1C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786353; cv=none; b=mToXCzE9YCAQGosFWbuC7Ad6l4lMMNzOredE49M46Rak1my11jyDKfNhacUE0Fd2P15VE+BQryPtNcKIEwPVA1vyCOrmQ+DhwIFaaWM8xJcQFpTgB/0mXkWw6h5QGNQcVtMmDM/Hh9g4OdR3a8q4cklcoKZtiQY3ZGxso/YXmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786353; c=relaxed/simple;
	bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkcVGNBGufvGa70T0SDtw/kACS77tjPY8A6FIWguUGkud9RR9Fr+8lnDreg0WtqhAJT2anS7a7iGm0NNHERtGwP4t3Mn1Fusaba/iBK4RC41msdByX+M/0RzlUnGzBbsop3yWegDF75hjwCGO5j5kBh0QJk056bWX5FYo3+fk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0j+fsYL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
	b=A0j+fsYLGvxYsg0Onhmw8mGqf0dFL2I0HsfmiJllI2Ro0vZF4gk0EzGYyzt075wNrDOaZQ
	Pvpp6jejLfEWfsnUig372Hr628+zPyOsKGerIBLs7mEznmxcscI8E4HsLDenFRTwzf8X7M
	3YFsR6nMB7cpr1qD+dgU7FzhmUNB9g4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-UClqo9NCMCKhazLFdhL9KA-1; Wed, 12 Mar 2025 09:32:29 -0400
X-MC-Unique: UClqo9NCMCKhazLFdhL9KA-1
X-Mimecast-MFC-AGG-ID: UClqo9NCMCKhazLFdhL9KA_1741786348
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3933ab5b1d5so1120192f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786348; x=1742391148;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvFWTVB9pNVjfzXnK7nMkzfPYUMt0e8Mg3/x3bUNZQo=;
        b=l5QxRwtTKL47JqUj7keLPLZhTWzuBRlRIr0NoR5Klgc4dlnQ0zjZvHbZQI7Kwvihxv
         hteD91Fgay151x9cMJ13FvCQERl34oTkhT4KsBUWXkS9s1dMjU0e/ULu9Cs+C3S0qQ0v
         8HcLqQsfLieCwMSCCFGP2m3FeaptjOO7uaK/+20UVUg2plEV4ZFgZZ9Fbw5PBN1CgTlq
         9lDU9KCp6an0Tj1X8jqNZ8cLB2yfa6NF9+RKnEN4AdEkQ9b9z0Q6jkueJow8uH2j9BbP
         xhF+yTQiQLOjIAS3tZAdX0pbopk3aUT5wTzDOFmoRijmjCfAVPgwHmTsEPj8BP+/vjQk
         3JyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2s6T40wpF5FAaiqCxJFNC6P43WsBccPx88nVp1cbOvUYtnJuZqJ25YoqZN1P7JbtlwR5SNiMm/GWLNHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQ659yC5OQaED2YKslmLiWYtx26Pgyk0qytX935ejnbd5cA26
	O9Y1uajsRytAllBFOSWQKFihXHhdJjj8d+UaBeiFk+yHF0POrTf12/XaJYGsliT67bfeJEFDr+t
	I8oU9sIgrNg89B5okyc6h8EsnwkqrDxC8y/atzycvwLSj1iAzfvGr3l2ZbF+ejQ==
X-Gm-Gg: ASbGncu83Q9FL99g89In+L1ZFwAUO+ehcWaz/n+Vjn5rarGx71/P6iH2sBM0A+2Ejp0
	SbQpI8kYio0iH59FVxZ0jW/St0C6gBfs57CzMYsb5JnvF0Mr5y57p+d92ar//VHbAXqjC3Tv6WS
	UG8QfRp2GRPNlz7MJVIxPNxCw1dgq2ireDc9QHEpBjy7o8hdQkNgmRKAmUJ49buXQPt149nlE04
	Pc1qV1HbRvj3ic6Dmp7oTX5nbdp0177Qw4PpRVAKoEt15X1QSpo4TqLNjlFxB7K0ae4ts81EBJn
	1Crk94uKe1+J6KSlSKTB8LcZ2zSeNb6WU+kQTQhiqJKS+Uzeju3XB8W/9jVgcpzCVLNLp8xzIDe
	/
X-Received: by 2002:a5d:64cd:0:b0:391:2995:5ef2 with SMTP id ffacd0b85a97d-39132dace0fmr16368592f8f.37.1741786347821;
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaxFj59P/gx27aef5+vL3NWzByOCREFSl/XlWQyAR9XNy1joOV+02tZso8UnuMgsytu5Tqg==
X-Received: by 2002:a5d:64cd:0:b0:391:2995:5ef2 with SMTP id ffacd0b85a97d-39132dace0fmr16368578f8f.37.1741786347457;
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1037b4sm21279510f8f.92.2025.03.12.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 5/8] sched/topology: Remove redundant
 dl_clear_root_domain call
In-Reply-To: <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86y_ebAmhSaND09@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:26 +0100
Message-ID: <xhsmhmsdqpe6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:38, Juri Lelli wrote:
> We completely clean and restore root domains bandwidth accounting after
> every root domains change, so the dl_clear_root_domain() call in
> partition_sched_domains_locked() is redundant.
>
> Remove it.
>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


