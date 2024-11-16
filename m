Return-Path: <linux-kernel+bounces-411548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C09CFBCA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FE11F238E3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD0610C;
	Sat, 16 Nov 2024 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crM7bwLU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC52F2D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717622; cv=none; b=WOsYbfZi4j0Fly0GmZGHDER6hp138F8uZ9G0op0WuHKClmnhxnJemys04xsSkzSJ8Ptp7+SKP1CaiBQXyjezfw7GYozikupzpWMsWeDqR10cvLAApZORyo+HOluoE1NvojBbd8eE1LsTQOpVMQNr2mdqrIr6CgLF4QsyNFE20MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717622; c=relaxed/simple;
	bh=WEdCMQfli2BaSgFf4rTo0+73c80op+HJdxWiI59yzpo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JudCVS4LLFovLT63BzQ7FTHysutuqGkQ6LakkMNVaZKLYV8+mrh6joExw9J4aBUATMdxhZtyxx0uGqX52d2PQS2PjH6Nz0UNDFzKdTIGlvdXVqDtegqtbxQclsCrWKy+p7QtEBlj+t3ezT6Uj+WODPiLgdwbpbnWxyhupMLA278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crM7bwLU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731717619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ491H8nPc+8CS+1Kn2/2/tGwNeve6hebjiSCMJj62E=;
	b=crM7bwLUEW6GfL8Alc9A5jxXlk0t1/yHukKI21lDUZBB+CrCx+UYOGLXlk+PNE2Nvrn1Zi
	51lk0aWr9mrQUR2iLgMhkhpIEgEr4CbWKh0Q7Ejr16lNc9wHuD7RdVl37XF47kSk1NEEjf
	vRNIXnxstsT2qENTA+IOBKu+KI24CGk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-TWlxJtSkO46lkwJzHlUmpA-1; Fri, 15 Nov 2024 19:40:18 -0500
X-MC-Unique: TWlxJtSkO46lkwJzHlUmpA-1
X-Mimecast-MFC-AGG-ID: TWlxJtSkO46lkwJzHlUmpA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4608d303ebeso18110371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731717617; x=1732322417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ491H8nPc+8CS+1Kn2/2/tGwNeve6hebjiSCMJj62E=;
        b=D6OXrCztDSAQmvoxpIF5FdJPjgD+CICC4H4dDP6GQSCcbvpUjJN7tZurbrgUkwchrq
         lPIe0DydCnTcHS822GkigdEo95u0MsYE4b4WjVq2YGjRB9cXhH7zUCMJ0kZmNTtQMpsi
         UY7JMHGXO+6SpK/uQJnQrDaKeIoI34XdqL8dnS5xD12VTe0lIIpOcfWzBqPCSfh/6i6l
         tfHlY4grpvGelwGv6es3VDPAfE/AjPHYOpZrJpB82P9fNVxs/4Fs7xijuiiYqmJQZWEW
         UdOKCwtYHcKZ6NlWHYVqAtXdYF9P5xFrytaW3Q0fpLXgPq6+MfQh5ggQDcJxGZM1AzgP
         Ns/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF02WhH8fWid/zeVEDdetoFHACTyivC+GVvc/FtX2JPpK8piUNXUowAwGV3JG4sIa4HztvaRfVD0gJSgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8e2jpS5vOiFQb4BY97sEtV2ZuhqPFrENqI6XLkpAtxaekezh
	M4D6IZIZH9218nR404mmdq6j2br7WCJjfkfO7M8/gBzrEbIJq9n2RAVkmSGgPAr7nZAbT4Y89YY
	sdZfB4UCZsljmkG3yfy3ytzEQo+r7pEbX4o7A1g0GKJuUy2drdnMuAquggXLrHQ==
X-Received: by 2002:a05:622a:2987:b0:447:e769:76fc with SMTP id d75a77b69052e-46363e97083mr56852351cf.34.1731717617450;
        Fri, 15 Nov 2024 16:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4OiBBQNU6PmAwmO6S73QsswIAzoZikat/kul0o+V01YiJtapz1/OsZiyX1VAE92HLGSNbzQ==
X-Received: by 2002:a05:622a:2987:b0:447:e769:76fc with SMTP id d75a77b69052e-46363e97083mr56851421cf.34.1731717615802;
        Fri, 15 Nov 2024 16:40:15 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab5d891sm25609501cf.77.2024.11.15.16.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:40:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b8d92f6-0d55-4b43-844c-696e71266978@redhat.com>
Date: Fri, 15 Nov 2024 19:40:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Daniel Wagner <dwagner@suse.de>
References: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
Content-Language: en-US
In-Reply-To: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/24 10:45 AM, Michal Koutný wrote:
> (Also someone mentioned that this could share lots of code with CPU
> offlining/onlining.)

Yes, that is true. The simplest way to do that is to offline the CPUs to 
be isolated, change the housekeeping masks and then online those CPUs 
again. That is good for managing a single isolated partition. However, 
Daniel had told me that CPU hotplug code could cause latency spike in 
existing isolated CPUs. That could be a problem if we have more than one 
isolated partitions to manage. So more investigation will be needed in this.

This is still the direction we are going initially, but first we need to 
enable dynamic changes to the housekeeping masks first.

Cheers,
Longman


