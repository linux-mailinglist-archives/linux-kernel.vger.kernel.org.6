Return-Path: <linux-kernel+bounces-557804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F837A5DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE5F189711E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CC24BBEB;
	Wed, 12 Mar 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTKjr61L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3C243376
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786349; cv=none; b=TmDrkrFbFcFm+5J3jnvh2ZUYvs/8H4pbXpNGRH9o+6kG1G8dQjKP2rFjFW0V6KvT2ELJkytJEFGBq2BomCGULN+8jnYIO+5Uu5ZG/xHkQNj5ruhz2HsihzsxClsRhzcZmfIac7ggmvZmUawlNR80Eg6eY5ME738h8L3nkCzwsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786349; c=relaxed/simple;
	bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/NkMCLRE6+H+jTwfuw+DwLZi3zDdGIO/QTsXJohX7CyguC204aOeJ3xKgdKMJaEYJ14XJv/AV4JEg/qAifxnWii2kv+l3tgZr8dsSKJ6DqfCff+a2k4wGLj2oife5Yu6vXhlc+4MIOBWZlTYMD/8NpV1kyk0GSekyzVjcDWmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTKjr61L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
	b=VTKjr61LBeBIggjxTkH7JI9s4j6ZW8KeG8LMXsdrS+x0xbiGN9bPH7bqcLv+HcAXcPYAll
	kQ4OcPAOHoN4IIt/ad1ThVhcZDTdbbHFUZVUuuoMjVvOwgT8I33KcPA6uSorbqqkhHdsti
	9K+427GqECf/enQwUWe2902qrDwgyQY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ryLqBoJXPEm67a3VE7-png-1; Wed, 12 Mar 2025 09:32:24 -0400
X-MC-Unique: ryLqBoJXPEm67a3VE7-png-1
X-Mimecast-MFC-AGG-ID: ryLqBoJXPEm67a3VE7-png_1741786344
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so10259255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786343; x=1742391143;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
        b=GwIzNe3J62PYnFJXHwHJQ9qFQNw8HF/c27E3/fqHIrai2buyKLH8QB/v/SLCjVCrrC
         CcPCt5dVA5lsgK8ztrExVv/tal1/Z92WERypkR2ZJYv5IOs23BeZBBKfVLanI37TAWNq
         gBfsyWiWmIkn5jLmbDEx+Xo5KrDQzqcH0fjY0IosKNE3wam7gj3mtlNAaMvr2lmQWtUk
         JbM/T4XP3/M7xqI8psnMqJ62Nfnhujv8IlUapxh+qajbq3oQ9+ir5tjnCOJY8UyIydLo
         67Ht4/U0kmZtlEUIPfrKpoQ4LYkWU040dS5hYgG5cMCfnm7N1Gkl52N464ZrPBzdFPBR
         0JWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuIIVq1KXivIB08lGy2HrxVxTwulLz+itYJNgNRmI5jd2ktAvzuvEAMdQFmwYCicEG5ytMJH/ToswYXwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6I+l/uEhuvOlXf+6fBAnuY49Xhq8VwI0IWv18pNpV24IyVzq
	rQub32EFG1ukOANJTdzEiu5AT2AMKHGoI9lLOfntebgnQkQh3ukQAFjpeouMIg0BQAz/Bsrs2G7
	/tpxbKEyqTOFSzdwoFT/N/np03vM8YREVGfftR4aLU/XeOc9o5Wi6ED4qPX7pEg==
X-Gm-Gg: ASbGncuEP1hEaAjJTAFhqY4Hpu9ep7gFS+MzsgdFoHiLaRIGccDx236OiYhMO2zv63/
	YL5RIlG/16ftqUdNJZ1kpDKpOKW5M6JvPKnsX4C6kn3T/v58HoKrHiugyG3DNn7MVX1b6GKKM6F
	7XoLaGr+80wzd4act7I39TwNNggPoFx7AAzI6XHvoY+GYhWrVw3VGK08KUHPYxd/Nm2oqZqLjrG
	tZDcYLyLZ1To6Ck6RFopGz2rfZ19DhNbEgtiJuPX26yGdn2ELpScpr6Cd0BLJ2cPrKZhExAGWZC
	OkuxHxB+Y9/RZ76/IPGvCl+NLMox/RrYnbVArGI7pMDXUM+LagZi1w4bKSJ4FeaweQVtq1R6JJ1
	T
X-Received: by 2002:a05:600c:1c25:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d073805dbmr42351315e9.27.1741786343668;
        Wed, 12 Mar 2025 06:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhPw8NJ1lb0q/giTLWm+iKpfer34XUJS5eQYqmpFdFHzSRWp15aA/RZ5hULR6/Yxjpn+5pew==
X-Received: by 2002:a05:600c:1c25:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d073805dbmr42350935e9.27.1741786343296;
        Wed, 12 Mar 2025 06:32:23 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78dac2sm21127785e9.29.2025.03.12.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:22 -0700 (PDT)
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
Subject: Re: [PATCH v3 3/8] sched/deadline: Generalize unique visiting of
 root domains
In-Reply-To: <Z86yfz-pIHHqC5TP@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yfz-pIHHqC5TP@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:21 +0100
Message-ID: <xhsmho6y6pe6y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:35, Juri Lelli wrote:
> Bandwidth checks and updates that work on root domains currently employ
> a cookie mechanism for efficiency. This mechanism is very much tied to
> when root domains are first created and initialized.
>
> Generalize the cookie mechanism so that it can be used also later at
> runtime while updating root domains. Also, additionally guard it with
> sched_domains_mutex, since domains need to be stable while updating them
> (and it will be required for further dynamic changes).
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


