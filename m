Return-Path: <linux-kernel+bounces-560619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9EDA60725
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0311899188
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17526210FB;
	Fri, 14 Mar 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIyNBkZU"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A484A35
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916986; cv=none; b=vAt0eUvEuj3DOzS4xZTOKsswmUqUhzRAb0HQbr2cfKxzCR5VQS1Ph34EAb5IFF7eVYZCgkwSbd1t6r41p36NsNyGt47LYNbdi81LZWbW1/jK4+I/opnzFmmTAJ/l6NiHzNk8eu61YXatdcva99AG14ZG7LlDJKkrliuy6EAtn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916986; c=relaxed/simple;
	bh=yzjckJYDtH6LoM4L1UVKwAD2UJuBV64I35BWYAuX4Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRd3rWGxwbD0SdveQi/1kwXXXse4om+frRh71RbJLdNp0BEIaZGMl5b016p0d9E8tVbxZ6oMm2+1jE0aSZnMv2J7+H29FNnD1IuAKPE7HCizHw6xKlAjnXs+lE4z3RwCP/Y+WjN5tSELOBYPfXHjsFz/V2dZaYTntgTjXP+bfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIyNBkZU; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3011737dda0so2915582a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741916984; x=1742521784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+emGW/c8eu5PKqicRx24WECyYR/Tb4Cl3qpWXGBUv4=;
        b=QIyNBkZUkbHATuzqU17YjFcQqCZoLhw1YAvaoHg8LA1G+5u2GmYdhuoEfAuBd+r2Na
         XH8I0K9V+HbfsceJLuDBrif0GFdNvO4PmL0sekjTw/tUSkQO6OC7tdb7UyXxgQ+GDpgX
         4NAy5VeGpytXmaH+2ij2L6qaKxYF4CtRRsYoRJk3xma471u2RQJj4ybh7Rg2iQvOQh+D
         4QnEjSfGvuw39mt6bKKV7EdjTXwkod3G0MIt/2c2sMJDNn8Pvh/DrNhN/Y7ZBW1xzyF5
         FlMs6Mt8ugA7siS+j4CPSGnwCVodGdf1d+LFWhJaH7U4KmYp+aueDB+tZXgh9b2kWD0Q
         rNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741916984; x=1742521784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+emGW/c8eu5PKqicRx24WECyYR/Tb4Cl3qpWXGBUv4=;
        b=U+RUUxH/RQOOSZtwLUHottxi+livObi/7mPOha+4ytFXdkxHm7HQm3ShcqfAeYJkM1
         SPcauNZQtAC6b7A1JsFgKRo2I6eX7+6eLwI6E5LR5aLvfBbI1I4PTuMIE1zuidOztzj/
         hA50BIUnHdg5BnUQVzdaK4gcFn3nlwjAojplsmtcpoKZhMRIuyVafgpGr8LpyCk8SDez
         42kCKqj4uuaH4EtbFEpCX+fC+JxeXHQVgMsAbV9AbhIaJ5zEOJCDjw4c/nYiIY5btL8B
         VP/7IFCtggbW3jxQH4pUpcirtopwaUj8b4ph1qzE2/9vqjm4RdK7nAlhpw0X09kk7MyR
         Fflw==
X-Forwarded-Encrypted: i=1; AJvYcCWIIALW0czY/+gSZ61rU17FmAnC6RcFuevOjrCruDDWFUDVtbl4gH0/dfnXEuZ2ZuHxoWUpnlPjfeF+v7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz783ALoKtWs0/VPHI79XYkOr3GPfW3PkRorxb9PnGaQsqO6bFm
	xOZqcUOq7AKNlD3PpMsez7SsuN6ZhW9fyh3n3KgsPLFIZm3WWr8c
X-Gm-Gg: ASbGncsNssCxqcMtaqS3Q2IbYzQENHm6ofpLMDgHpg35YIz2PGvgIpMPyvUUpztd75G
	VLktjYgqUDnETl3E19jXVQgAOGJ65Jzg0LYhSTkEJEruZTmAGzKibYZK/Ywea8U7hGW43i9mpC2
	rReOzgtCfl/NFs/oBTt3DjNXQZ4I375XdtU2J5wADv6wl9kq4U0P1FctuAQYrRvkdVhJYECK9w9
	OhtOcbUscBiKlPYlGUqbal3QX3XZwuRFph/ZIqtRRpME6z0SvwPC5uIzlcpAFQSZQl1iePUaYT6
	zIrKEqWrgmlXKGJnqrdjRZKuFeCBd2Ut4qm5DtmpDS6ge8d2ZgBix4XX6fO4jjtIb3Iz7QE=
X-Google-Smtp-Source: AGHT+IF/F/lT16o7LXOeNzm0tdX6+48LZ9mPSwe9paqT23CoV/EIrGGAvmXLnOpOZAMzk8rXmWkSAw==
X-Received: by 2002:a17:90b:2dd0:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-30151cc3da1mr1022481a91.17.1741916984133;
        Thu, 13 Mar 2025 18:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:2:90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363278bsm64032a91.31.2025.03.13.18.49.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 18:49:43 -0700 (PDT)
From: zihan zhou <15645113830zzh@gmail.com>
To: kprateek.nayak@amd.com
Cc: 15645113830zzh@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Fri, 14 Mar 2025 09:49:03 +0800
Message-Id: <20250314014902.56810-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <3d0f9c2b-8498-4405-b178-9f6c8615f73b@amd.com>
References: <3d0f9c2b-8498-4405-b178-9f6c8615f73b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reply! I don't mind at all, and I'm also sorry for the
slow response due to too many things lately.

> Hello Zhou,
> 
> Sorry this slipped past me.

Thank you very much for your guidance! I realize that without a good
benchmark, it is impossible to truly do a good job in scheduling. I will
try my best to make time to do this well.

> We use selective benchmarks from LKP: https://github.com/intel/lkp-tests
> 
> Then there are some larger benchmarks we run based on previous regression
> reports and debugs. some of them are:
> 
> YCSB: https://github.com/brianfrankcooper/YCSB
> netperf: https://github.com/HewlettPackard/netperf
> DeathStarBench: https://github.com/delimitrou/DeathStarBench
> HammerDB: https://github.com/TPC-Council/HammerDB.git
> tbench (part of dbench): https://dbench.samba.org/web/download.html
> schbench: https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git
> sched-messaging: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/bench/sched-messaging.c?h=v6.14-rc4
> 
> Some of them are hard to setup the first time; we internally have some
> tools that have made it easy to run these benchmarks in a way that
> stresses the system but we keep an eye out for regression reports to
> understand what benchmarks folks are running in the field.
> 
> Sorry again for the delay and thank you.

Thank you for your support! Wishing you all the best.

