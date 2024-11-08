Return-Path: <linux-kernel+bounces-402210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86B9C250C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872681C233D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDD192D89;
	Fri,  8 Nov 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCTM4scF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBE233D80
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091664; cv=none; b=tfrXTxi7TkYpe/+lADeY0Vv9fZSVVJY82P6LTO/cDJp3U+x9jn4+Jjz5p7wBmf4VK3ttBQsCROuHj8IPvdy1JQrkuoRsUtdsjGAtoxp4JFUPhkAmQ+jdn7wz6DOi6d9WK9uEAhx2Y+6yy6n9TkckpX0WyhEIrav1XyBXPy6k9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091664; c=relaxed/simple;
	bh=BQFGZjExaBwhdOEExMxWiEVMkMXZw+/gxRhjn1nnWgM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jR41aftWE5auKtFleDgdegyfiz1yoAuoLqwqYBSxQjeGV0iQAoe6pxlTVFZbBUoE0y1RwrOr6BIRTOQJzvWWDHvesGnIkytehpS+FnrqSuEC8f4LZ6khd7ZirbLTaB7tauIQHd6KAeCN5KblXdz6NezoLoZQyi3ZjY5Y1klpxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCTM4scF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731091659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lO6tSY+Ynx6UOn8H70VJb6PSrsgx7Xbiq4JEkM6wr0M=;
	b=KCTM4scFXRwBzp/dR2w7QxxKZXvldz08GjWLhlu9UR0rXoMCRgU4JXGSYkP+iaRm3GD8Id
	f6WMgK1A6Flrd6Nx8zXub/zXK5zRA+ceiyDUMceCa/Yc44chfoouPxlSFznSasvO2nJ8XV
	bh5h5iG2/mSAS1Jgd+llQ7BXzZRY5J8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-DanGLUsyNgCCLfI_eWe01A-1; Fri, 08 Nov 2024 13:47:38 -0500
X-MC-Unique: DanGLUsyNgCCLfI_eWe01A-1
X-Mimecast-MFC-AGG-ID: DanGLUsyNgCCLfI_eWe01A
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d390ceaba4so45891706d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091657; x=1731696457;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lO6tSY+Ynx6UOn8H70VJb6PSrsgx7Xbiq4JEkM6wr0M=;
        b=k3U+dGT5I0TFkyI62k/9kICNbJM/iFfkIwWyc7dzZHvS86akTj+R6VZckI9exr77hE
         p1e71wmHUdUUS4wwV+R9lJmBRRRKbFsRQkRKzIyYB0PP1E9+V+/EcEswxEKRD5M2hNak
         SMtrZr4uc7sZQuyXhLYiEwOUDFnYwpzPD9AHTXXIgByAGMsTgyp/vQDyNpICaP6hcBHE
         /OeqNgIuVg7R5Foe4nGScexVbcc6NDwnJ0wQwiK80r2d22GZdzEi6aWIGNwQZH5u+sPz
         kXfcNz0CpETtBtT/mG6gqjHGitYxluTSWLIdORm+3E+PTiiP8DFnadOblmNPGWAvWwjS
         zEkA==
X-Forwarded-Encrypted: i=1; AJvYcCXFoK+7qnt+QZX6V3ABOVRGedWlpX/DNbpsOoR90ZZ7UtrohY9GzXOPgjBd/PQpqPjJoA8nbhn5HTOUkuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+8Qp7oguHCKevzh6FcqJecatX/NsPG1MkgVQw1NV3tCxC3iD
	EmFw/Aa7We8DA/igKkAuWKjRoqa62usXyf7WoTmoLTmA3QpUvjgaC8PqUyMZyCnA7T93/TIbsj2
	6tWtlMM/auYewRS2SzA7SWDtHtzztdSHqDvyq4d4BYN7+Z797Up7pCy4j83MDqQ==
X-Received: by 2002:a05:6214:c43:b0:6c3:5338:9116 with SMTP id 6a1803df08f44-6d39d6670c6mr64684476d6.23.1731091657420;
        Fri, 08 Nov 2024 10:47:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2B3H0/FM4ZWbUpv2lg9ytjgZ5jViQ314vcY+kD14rs/A+zTJJ2kfXoDwQlti4C0GgV9OFwQ==
X-Received: by 2002:a05:6214:c43:b0:6c3:5338:9116 with SMTP id 6a1803df08f44-6d39d6670c6mr64684276d6.23.1731091657131;
        Fri, 08 Nov 2024 10:47:37 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3966303e6sm22089036d6.99.2024.11.08.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:47:36 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ff47f735-241d-4dc8-90b5-0b57f7148128@redhat.com>
Date: Fri, 8 Nov 2024 13:47:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Skip overflow check if 0 capacity
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241108042924.520458-1-longman@redhat.com>
 <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
 <735344cd-1c32-451f-904e-235578e1a360@redhat.com>
 <Zy48-zbUnjTzxXXB@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Zy48-zbUnjTzxXXB@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/24 11:31 AM, Juri Lelli wrote:
> That said though, I believe I just found an additional issue. With the
> above the system doesn't crash (it did w/o it), but happily moves
> DEADLINE tasks out of a domain with a single CPU going offline. Last
> time I looked at this we were properly checking and failing the hotplug
> operation, but it was indeed a while ago, so not sure yet what changed.
> More staring.
>
> Oh, so broken, yay. 🙂

Is it the case that the null total_bw bug let the cpu offline succeeds 
in a 1-cpu partition with a DL task and cause it to crash? I am also OK 
if you adds the check for the presence of a DL task in the cpu and fails 
the offline check in this case.

Thanks,
Longman


