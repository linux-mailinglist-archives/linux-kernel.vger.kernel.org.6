Return-Path: <linux-kernel+bounces-269775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885399436C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333BF2842BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDD148FF3;
	Wed, 31 Jul 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q72fWqRe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042A50A6D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455540; cv=none; b=WZYH/hMFCMoj0djH9ApS57njRWmhy6fCBeNasp+GEdbs0kgMXw32YSrHGSPVhKoUIhcAO92FX/gzxFCPusUhtKRsqYsgJLXuuKw17Lflc1emYdFfjbfYb9eo+4jCKuoWp6WyQdlNBy/eAJw1kVIEWm+LAOPPR8mGiTCqrupxnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455540; c=relaxed/simple;
	bh=5wKwM2WjspVaSSkYmcKPggPVFKPJi93u2e/t2OgWwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=DaP9BObfYw0z9T5bShn2p4kbjh9Q3ksE3rVX7mbu+gaatWtVUZrln6MLYzm+LHGsDtNmxl7UmmRTuRjajSxwnVz6cMc2lnHu88NbetG+79aVZrFAYFwIHrfZ2XRNKmhmnGpiSw06Oj0nOv74LZQ5W2uonF/yXq8QmXX6muKA8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q72fWqRe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722455537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTZVFu7K6+uiaFa+bz2TYcCEINvR6BMH3QXaK+vFRmQ=;
	b=Q72fWqReiiq9ASr07l3aArPOm6bUywe28l1yagPUghj3DSDoeI6+p2lDQnwqk6p+0Lg44V
	EGm/nWMQ9FMaa4KhRvwozXALJu6YdFMwFhXju+4+j69MkOio30GVEVNBBVqFrSJ5XcN4kU
	ZokBjzpHGUOks6bZb+x4Bs6es0Vfkag=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-E2xrxJMFOc2igvO1H9vKXg-1; Wed, 31 Jul 2024 15:52:15 -0400
X-MC-Unique: E2xrxJMFOc2igvO1H9vKXg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d44099a3so745190185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455535; x=1723060335;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTZVFu7K6+uiaFa+bz2TYcCEINvR6BMH3QXaK+vFRmQ=;
        b=eigB2HkN9OEL5D2oRo0jHsauNLKZw4U9ABh3B9wYny6X+9nAAfMdTuypAXk18u4Wcw
         wFqUSJdEUoksEeuKRGrYsu635EJrATBNy5ItWYz051qYqCgC8oo+PPzOpDiXGxx8YASj
         O0paWUSrneC2DEFzbqUzvxXFAWF8CxjJy/1VfXSt/RgCp7YZn2OQOwMY/ATXCCb2duvJ
         +XlCa1+ILJwH0QprR/n6ndTSweEFifOsks+I+an/b47WJSDa4laB6HhkPqKVsA4xH33m
         pw1Dth7F+jRzDreYXz+z4DR+0qJLzLwuZ9LIQAYwsWTBYhcq1v0gcuhNS11hjgDSK9sZ
         iGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVppw5GiiBdyhB9aCrLr57NJbFLr1ZndI9prNorePvMxIomSqHVet3UfKKUC/c8foBPIfc6GMTBnSuOw7CCcnISxLx9HWlQ7NAlk3Zs
X-Gm-Message-State: AOJu0YyBx26rot9SlCHdUfH4hyS/bBBwMbiYtkc/8Albtkqx15KEStWL
	vQtzz/Io+AXFgOeIA7VJzhuvxv3RRKPrJpXAfXrCKVMV0Xr94zOxjcF2bdlbPxWd8WhoCR38iIo
	VhguN6mxPpvO0VIk/+aST56ECUOIvzXbS0YhtX//LmJuW0WYiCSC3OohKA6D7kw==
X-Received: by 2002:a05:620a:4109:b0:79f:b0e:2e70 with SMTP id af79cd13be357-7a30c6e268bmr27103085a.55.1722455535063;
        Wed, 31 Jul 2024 12:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhuQ/z0VlR0lBY46ZsSRSDGD9PSMp9Yhs26uV9BPy+b5xNpe/oJVl9BHdbGlhD4R9L+KWtw==
X-Received: by 2002:a05:620a:4109:b0:79f:b0e:2e70 with SMTP id af79cd13be357-7a30c6e268bmr27100085a.55.1722455534705;
        Wed, 31 Jul 2024 12:52:14 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:da7:cfdf:ab65:d193:5573])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1f89bf270sm310411285a.92.2024.07.31.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:52:14 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Leonardo Bras <leobras@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	anna-maria@linutronix.de,
	bristot@redhat.com,
	bsegall@google.com,
	cgroups@vger.kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gregkh@linuxfoundation.org,
	hannes@cmpxchg.org,
	imran.f.khan@oracle.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com,
	longman@redhat.com,
	mgorman@suse.de,
	mingo@redhat.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH 2/6] sched/topology: optimize topology_span_sane()
Date: Wed, 31 Jul 2024 16:52:05 -0300
Message-ID: <ZqqV5OxZPHUgjhag@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <9fb7adfc-701b-427c-a08e-a007e3159601@wanadoo.fr>
References: <20240513220146.1461457-1-yury.norov@gmail.com> <20240513220146.1461457-3-yury.norov@gmail.com> <9fb7adfc-701b-427c-a08e-a007e3159601@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 14, 2024 at 10:53:00PM +0200, Christophe JAILLET wrote:
> Le 14/05/2024 à 00:01, Yury Norov a écrit :
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even though cpu != i. In such case, cpumask_equal() would always return
> > true, and we can proceed to the next CPU immediately.
> > 
> > Signed-off-by: Yury Norov <yury.norov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   kernel/sched/topology.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 99ea5986038c..eb9eb17b0efa 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2360,7 +2360,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> >   	 * breaks the linking done for an earlier span.
> >   	 */
> >   	for_each_cpu(i, cpu_map) {
> > -		if (i == cpu)
> > +		if (i == cpu || tl->mask(cpu) == tl->mask(i))
> >   			continue;
> >   		/*
> >   		 * We should 'and' all those masks with 'cpu_map' to exactly
> 
> Hi,
> 
> does it make sense to pre-compute tl->mask(cpu) outside the for_each_cpu()?

Looks like a good idea to me.

Leo 

> 
> CJ
> 


