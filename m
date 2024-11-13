Return-Path: <linux-kernel+bounces-408026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19CE9C790A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75FB285887
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0816DEA2;
	Wed, 13 Nov 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxEii0nY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F72309AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516059; cv=none; b=aSdkJOWMrmk9AWt4SQkBWDgpv6kbs8PFLBJ4RSJ0P3nuwStHDga6MxnQKinUdOemK2G+8B+yL338JIjL4AIAGMfTpreecAS4PviwUWlD/hG6YPsm4hUSylRY+gPgeliwF4kfWJuDPAZxjemIJ6sHUibE6vH6AGpcpBfzThmW5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516059; c=relaxed/simple;
	bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNrEA9knxKLe/+b0fk7+0IbirSimEO5OgGy+inRZ2zq1+t5ludYIMrd2ijHmI91J6b8e2X7wqqXk/yeoCwKPk+uWAj2X8jJeaCTKzJ25+NhDvQDG1M2sGsO5G+1RMkHTTA95S658k/WIrJtkzgbcP4Jg3IR1T028AHbp0vonCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxEii0nY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
	b=RxEii0nYsYHtJacgXGU5O9EdyecneutVSJEiMsAyqUrftYTBzCB985S0O24jmWKzDxWPSb
	k7BGEWmY1YSSZ8xgQhR18we99YnICNRmjgj1/GH2l5mo4wNTlNhvGQ21GVEGSpChsVRB9I
	AHBf3zLIc0Li4eNbT0njzWoEROeOeB4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-IlkHyPl3PBOegkY70ZNhjA-1; Wed, 13 Nov 2024 11:40:54 -0500
X-MC-Unique: IlkHyPl3PBOegkY70ZNhjA-1
X-Mimecast-MFC-AGG-ID: IlkHyPl3PBOegkY70ZNhjA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so54050185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516054; x=1732120854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
        b=ZwYfKsnK6IFZJasq7XQouURlyBcBAlYfQ4h32j+b4KuBQsd4QVzHH19uuH9Oi/97Kv
         VrhZOU8Z9oQBud4CgSiyLm0/jh3GYGcjcm6xuu5CT+DE5LKfimfGYJI9GkUBnkKpeE3o
         H6zIMBpOLa4cTIlz845hzxLxp38Q9CW+eyMa6P+4mkWWAwrVzY2pV/Fqeh+VoQIilNK6
         yP3nEdEyxu+zS3td5SfxIAkqPlfRxcFlHQdGTzsT/3/RKdy1cSB82AtTAIMTLASPbF6T
         kv7hMAt6+KRwEx62QdZFzXWSDCyYacWuuQXhI2q29d5ilH6P6RYLSpcaw2DFYUi3GHaA
         5Lnw==
X-Forwarded-Encrypted: i=1; AJvYcCUourCudG1UnF6uBqXLXvQv5u2jomO2ZATWrkHQsSMH9zFhNHfvS3OUIoJe+yyqfMGWf+HNrh19ParUzZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRs7Na+/hjq0dW86F13AMQhi6cG8eG1Px7+h+GE63Jv8GUZqK
	xlfg1HBNQpOZpeN3CHf2YDVQtICsh5GfPhOR0OaNadqz05RdbBrA/vucYL9MAnmdRb1UbsoXVKq
	+k706kZGxcmbd94kmpecGJ2F55n/CILteaUbi33eU6/PFUFOfwt8HWeilkoImMQ==
X-Received: by 2002:a05:600c:3d05:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-432d4aaa11emr34935265e9.4.1731516053768;
        Wed, 13 Nov 2024 08:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFQ7t1MLzge6g1NzYJfsmBrzfLmhfNgwB0NjnWV3vCzt5pLtHkQ7sgmX7XneDTPBcDj64hAw==
X-Received: by 2002:a05:600c:3d05:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-432d4aaa11emr34934985e9.4.1731516053473;
        Wed, 13 Nov 2024 08:40:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5557332sm29571735e9.43.2024.11.13.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:40:52 -0800 (PST)
Date: Wed, 13 Nov 2024 16:40:49 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>

On 13/11/24 11:06, Waiman Long wrote:

...

> This part can still cause a failure in one of test cases in my cpuset
> partition test script. In this particular case, the CPU to be offlined is an
> isolated CPU with scheduling disabled. As a result, total_bw is 0 and the
> __dl_overflow() test failed. Is there a way to skip the __dl_overflow() test
> for isolated CPUs? Can we use a null total_bw as a proxy for that?

Can you please share the repro script? Would like to check locally what
is going on.

Thanks!
Juri


