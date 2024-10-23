Return-Path: <linux-kernel+bounces-378481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE19AD130
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0355282AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493961CC178;
	Wed, 23 Oct 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjlCJPsb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4A1CACEF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701592; cv=none; b=snhr09VXDSx6sN77d86LcJ8YuiK3Qfl96pnDfAeKHCa8QjTYxgHB2Fyrr0WXVblWPk0mxK4HW6qhvx9GM8JxeozWN92ucMlykJj2ncBzL0kqyW2cJ95CpB1EfmFasZJfEeKiT7U1DoQxBTyBmyvbtZcx6KHeP3wJ+WsqjAOr4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701592; c=relaxed/simple;
	bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLhMFxNNgMKxn3783ec+hBuJDWpUt9LBQ8qBNEGE3ntAQdNWwfklFpir7NxtxCCoKCQRQt8TDcAMZVTsY+D4Avw17YJ/328fC9EzPLRgGdA/P/voR+HFTXXZu2t/zAbezP2VuoZWilAf0fvWbABWuZQ/OIST/wIH943xx+G/kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjlCJPsb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729701589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
	b=AjlCJPsbqBUCDHF0YU2CJpfdGOE0iw3Ny+ehywjHHmHVvm0P7UsAtAqsC/yE04t/1SM/fP
	W0woKbysIKa28q4Jd3NtKzQ+X8JoMOmufAQwcOVx4Hn+H09ctwz98pgSUleBL8wFxdVWAB
	029j+p32ziETfwTlcRaYN+/HuE+B1cg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-s9KCCAWwOdydW-1A49XYAg-1; Wed, 23 Oct 2024 12:39:43 -0400
X-MC-Unique: s9KCCAWwOdydW-1A49XYAg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb59e38e9aso5156592eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701583; x=1730306383;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
        b=iSlf0OyDZ5POA23DWeBvVlynfOw83ytzPV+xz9Qv9SbXxxfq1AGZKhgytDOj0AaEcX
         eRA8qA1eDcbzogug6ZYxVHz2jYtgb81zW8JIO0Qkuypnmw+057l/5wz+DSBW6u13VuCQ
         lf+dE7urzTKkr0+mWKusXDPuaTNwc/a9BLxrWgpx09RgU0KNFgGlBfij8ecokeQJXECP
         CdbBKOV/Bhd6ZH8CrD09P2bL+htnwgniTNER+GAavpxs0EHySod234ioWANycLtzx0kP
         gssGr6oh/HztQ1DojzSvKmYeA4QLELb/rurx/DPWToXK8xtS39S5qvpZJBUnDGk6CwcB
         wonA==
X-Forwarded-Encrypted: i=1; AJvYcCVl0SNPACuAjx6XF0UdMh3tagcLI0jLkyYfR5R2T0KPG7V+rpDXFZLoVZ9nARGa5Gr46KrRo1WuHzp06CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNMC0w2dA8XSF9sMvni8pOBBEDk4MveG1i2g8mzzv33KuhtJD
	ONSO4RVFjMB3B9VGFQP1qHx0U6TqJA4BsKgD1Ao86WxauOYGe6cCKFKvHj1A+mZ5NYBg/w2i9Nw
	wzbDWjdLAfUtTpuap8CxXfZofEs1WAUGS9SSGdMoObVMZM4etn3U476cNb6BsQA==
X-Received: by 2002:a05:6358:7301:b0:1b5:a38c:11d1 with SMTP id e5c5f4694b2df-1c3d81b1c55mr215714155d.26.1729701582816;
        Wed, 23 Oct 2024 09:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5uJ85hkEz2INCCPDQFtdhJuoP49vMzKxw9NE+7RKWs4MM8KvFHPEu83z6kixqE7MV11l1uA==
X-Received: by 2002:a05:6358:7301:b0:1b5:a38c:11d1 with SMTP id e5c5f4694b2df-1c3d81b1c55mr215712055d.26.1729701582497;
        Wed, 23 Oct 2024 09:39:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d70a6bsm41746811cf.63.2024.10.23.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:39:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, ssengar@microsoft.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
References: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
Date: Wed, 23 Oct 2024 18:39:37 +0200
Message-ID: <xhsmhsesmu62e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 22/10/24 10:57, Saurabh Sengar wrote:
> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> around 8 seconds cumulatively for all the iterations. It is an expensive
> operation which does the sanity of non-NUMA topology masks.
>
> CPU topology is not something which changes very frequently hence make
> this check optional for the systems where the topology is trusted and
> need faster bootup.
>
> Restrict this to SCHED_DEBUG builds so that this penalty can be avoided
> for the systems who wants to avoid it.
>
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Please see:
http://lore.kernel.org/r/20241010155111.230674-1-steve.wahl@hpe.com

Also note that most distros ship with CONFIG_SCHED_DEBUG=y, so while I'm
not 100% against it this would at the very least need to be gated behind
e.g. the sched_verbose cmdline argument to be useful.

But before that I'd like the "just run it once" option to be explored
first.


