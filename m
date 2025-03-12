Return-Path: <linux-kernel+bounces-557802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B9A5DE09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6978316BEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA8245027;
	Wed, 12 Mar 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO6y83ZH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFC1E48A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786336; cv=none; b=WeGlMAZyxCncMwRLx8F4JOwvaROyVZz/QT+IZOXmhoclmlFcbX/LTPZIP9X3DywfDfCXnQFiLV0DPusKP8CbWuHKBp3UxvbAIwKghpzUcSXt5BVPjYWVuGCsR0RKbOS0XFW9hqdCuYcUn+XzWAGthnT1JKBc9Nh/Z340qi11gnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786336; c=relaxed/simple;
	bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MUz3+fE0QH0NOt/GbIQvCmZy8T5rtxsyCTOn07Ci5VmZ4u4gk4om0xx16rfmfftgtDUsBSro9Nar7iS/CGZQ6DLLX07S/blPRRSGtqHknAMEU0LHvCheTGtAWtCiHqtgBfKnMfKw8UftxNcn7ScafSoKjdp+lxVTg2Ou/aRTqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO6y83ZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
	b=eO6y83ZHahVO0FFai4i4/V5ZWx50tRACTNRzNj7kL9QxGVzTLevOQDqSzBp5Erx/fPK0C9
	M7NHjQxVL7n1gVwv+Cxg18+/tEiXnc1ajVEB8ZyPW09jCvMFoE0dMy6UEt6LpxXGXZYyJE
	mIxF2XZJ587X4yHVuBZ0sv0ttBBSK2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-OCoJSGZxNcO-ZazwF6FRdA-1; Wed, 12 Mar 2025 09:32:12 -0400
X-MC-Unique: OCoJSGZxNcO-ZazwF6FRdA-1
X-Mimecast-MFC-AGG-ID: OCoJSGZxNcO-ZazwF6FRdA_1741786326
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so21877285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786326; x=1742391126;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
        b=WXONQbx1tBUTfIQHs2fH/OwcldRu/bAmfS8XS7zmbEMCcU+8R57/UPvYDgArrwd65W
         t9P8pP46J0cC3gYYmK0BRXyJkHsdqRRfeC3rTSff0o9CsyxpED9Gow1OujXbsYf8xato
         ZuJB7YR5MyTTaTbZiQTGM6ekGSeNlxEvIPeHySMX6htWAQ1E7Vdlsxwz8Vj2JX7dLT0s
         oti3dRavauzcB6dt8/lgET1qAYJMlCkl3lZkt+bNqDmCeVNUd8nWbX1F/fmD+UZrMt+6
         PZVmOdI2EoA3pZAyBzt+3rb2GO2gxyDgDsKTVHc8PToo7tZ8SD4cQsbIrf5+MB2ZDkhn
         ZChA==
X-Forwarded-Encrypted: i=1; AJvYcCWynqZyHX5QFsAORDHogBl7Q8IeXoQbzJSfXSySvM8//02Srotxd3NwWEJSgs0V1wYIP60HJZw4fTl3Y1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/3pId+TeAsBtXivab1QCqBGW+0JwJ4Ska82Mt38zjvFvR2Dm
	D1dSB1HZ2w1JuuUk3OWoQ5ZiklwFvVEGP+UKo6bBVzeqL44Oy+qHPEfwZ951008C84SsxvbuY7v
	eXfGk0ATswaFWaxOaN9+U7xa9vx7AW3O94nuMnDU0ZlafgoYCB3hQ/yYGzhZd5w==
X-Gm-Gg: ASbGncvwHQ9Jh1A81dGAG8oeZQSzhJnUtT8LmNgN+E/pMekrCMLSwBpkmker+bd0ZbD
	OXoi7/sghGiKNsfaGvl4DKj21PmZ/7IeWm2i3zK3A8Gj+/PXkx3n6iYCBuI6lL4o09argQF3MKP
	yfCrDutXqB0P8nuIAnKZqa5hR4Nhc8D0sZRDIzE+l9dOQvQk3O0AC/ebEaCL+F9IYsQI5iRuUQI
	Sxy8syXTKak/1gAHrsWyedWb6zcct7mJNictZbRIEY//zAR6rjTsToTzktqTCveOfE0br9j+lTl
	//U849ZPZ/9NLhhS00wu51vlGqsB+xylSX2e1ahfndKVwKmcylQQsX++I3ia/FkNxmiTyONFjtw
	j
X-Received: by 2002:a05:600c:468a:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-43c5a631741mr154089165e9.22.1741786326194;
        Wed, 12 Mar 2025 06:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5sHcDKhieURPdxRy300OU1jc5MhmokRYnxd3zuFMFYr99zeGoJFxp8tbG2zBpfoTzfjxCaQ==
X-Received: by 2002:a05:600c:468a:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-43c5a631741mr154088845e9.22.1741786325818;
        Wed, 12 Mar 2025 06:32:05 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72ed3csm21539145e9.6.2025.03.12.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD?=
 <mkoutny@suse.com>, Qais Yousef <qyousef@layalina.io>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 1/8] sched/deadline: Ignore special tasks when
 rebuilding domains
In-Reply-To: <20250310091935.22923-2-juri.lelli@redhat.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <20250310091935.22923-2-juri.lelli@redhat.com>
Date: Wed, 12 Mar 2025 14:32:03 +0100
Message-ID: <xhsmhr032pe7g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:19, Juri Lelli wrote:
> SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
> make sure sleeping and priority inheritance 'work', but it is ignored
> for runtime enforcement and admission control.
>
> Be consistent with it also when rebuilding root domains.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


