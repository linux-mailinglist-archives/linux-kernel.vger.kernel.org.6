Return-Path: <linux-kernel+bounces-371009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86549A3518
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF95282063
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CF17C220;
	Fri, 18 Oct 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWZrH1eT"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF920E30C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231605; cv=none; b=o1Du9wccQaoCRKKP+wEwazzrGXrEEME4VSXXHbONHUh7BF1Yh8hr5PHEZIdGPFQcCFCx35tyx7u0BYdAVROsjylpjCAayMDTJ2rEg4N+Ggdnl8oCAk9COl5YaSBo7GsHa2rS1t3fTSDJjyIYWLPp9CkD1ZuP1GkawKFXB8SI6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231605; c=relaxed/simple;
	bh=jr/gLFKcTItfqi1gNT92lR8SOn032rSaVRtIUrU0I/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Aqtf0WXnpOXgmJ0EKJtUxmIoxoJ3IN7WvN70ZjkQDZLhGViwTVrHlAznkwpx2vdVdZzCNE5zP/+t6gR9JPA3V6y69scPBOnAveeNwqCCuyRge+YZ+kdNGfKLFbuxOIxuxp/4VJimHg0kaSi++XgbmrvlDcBXvKDpdDI3Q9nTFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWZrH1eT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so1334970a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729231602; x=1729836402; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YB1LmCQcNZuiTRixfyMNEp3sh0blica8ab4H/fIaBHI=;
        b=HWZrH1eTr0k6KePFglAAJh8KxoOhscXWqJv5RxXAE3TMikmG+tnPoSfl8mPG1hSHCY
         Vl8MUdokUUVGN2fQ0oMrEuxojni575oDqvV0yYb7mLA6d+lcuY//fHf+Vm6Tn4hO/btX
         e3ACFU4yGzQ13Uf0cNlmjrGmdfsRgxz7xAfSYg82EqBIlpImwiWZt97iC+xTB5W78NdH
         zmWDOaepzKHCsQxg0IZ/q/ePhNkOk+pfze6hA3oTlTYS1UjKUZSmVA5WcRrUrIDTWd1N
         7NW9bCi5WkpqhzM3n7p0l5XCLjGkQpwqNLx8fBqi8rJOZJ2EJ0cEhi7/7cQvevzymKAm
         v3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729231602; x=1729836402;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB1LmCQcNZuiTRixfyMNEp3sh0blica8ab4H/fIaBHI=;
        b=SY90qdCKJZ6aVgcSgF87D96NjLHxTFq6ykM8rwingvXpO2knsmD6bxvhd4nHifGEac
         cQ5QxTUuklcnj7VBzLmqnI/f58jp1sqZhKQZWHea+ZtOHY4HE5iV5oCUHs1JwAchHy6f
         JPv/MHYN54EUAv5VmCP4ue3/poFNUx3DH8kQ+TE3du5rTUIlUi5din9XY8u1cyPsqvOF
         vsK+dayYCc21Mcziz7enXaHgab8SLTBW9ECXhzUUGD9KV4WIzF9e5c5foGbANX1aQhZr
         6bV72K8fKa2CDIfREJX0uNN+ey4D6pgbYjQghHUDoacNBTBrYplA5KGCSYGv+tC2BiVv
         s3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVBjF4T6w85zdNpZP2dS6PnZF3nWuTaNeWpInO7TJ16fRqSg4BU6bxVyIl0K0mMqkRP1V/8bMYpo3YpHQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hZTB4Y8Y8m11CWcW1zhaLLroQ6g4sl8qjSsuQfD+fM8bmxEv
	INcA/lZro4iASK7I7i0zMf/tuHF7YM6NNOIn10zwkIVPe692/fZon1Oztv4tRPI=
X-Google-Smtp-Source: AGHT+IGMhqMVHHNFIWWyo62KZN/pX0PwPN6mmwV4upUByvOhTYxgCIAztvDcyMFtjUztU47SoKJDgg==
X-Received: by 2002:a17:90b:2782:b0:2e2:af0b:7169 with SMTP id 98e67ed59e1d1-2e56171a95amr1598611a91.12.1729231602464;
        Thu, 17 Oct 2024 23:06:42 -0700 (PDT)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7c4b55sm1027899a91.21.2024.10.17.23.06.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2024 23:06:42 -0700 (PDT)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: akpm@linux-foundation.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mengensun@tencent.com
Subject: [PATCH] mm: make pcp decay work with onhz
Date: Fri, 18 Oct 2024 14:06:40 +0800
Message-Id: <1729231600-19607-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241012154328.015f57635566485ad60712f3@linux-foundation.org>
References: <20241012154328.015f57635566485ad60712f3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 12 Oct 2024 15:43:28 -0700 akpm@linux-foundation.org wrote:
> On Fri, 11 Oct 2024 18:36:10 +0800 alexjlzheng@gmail.com wrote:
> 
> > Subject: [PATCH] mm: make pcp decay work with onhz
> 
> "NOHZ".
> 
> > Date: Fri, 11 Oct 2024 18:36:10 +0800
> > X-Mailer: git-send-email 2.39.3
> > 
> > From: MengEn Sun <mengensun@tencent.com>
> > 
> > when a cpu stops tick, quiet_vmstat may flush all the per cpu
> > statistics counter.
> > 
> > while, the shepherd is needed those counters to kick the
> > vmstat_work.
> > 
> > when a cpu in nohz with a lot of pcp pages, and do not do page
> > allocating and freeing. the pcp pages of the cpu may not be hold
> > for a long time
> > 
> > we make shepherd keep a eye on the pcp high_min and high_max
> 
> I can see what you're saying here, but it's hard to understand.  Please
> spend a little time clarifying the text?  And please start sentences
> with a capital letter!

Thank you for your suggestion
I will create a v2 version, and make text clarifyed

> 
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -2024,8 +2024,13 @@ static bool need_update(int cpu)
> >  
> >  	for_each_populated_zone(zone) {
> >  		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> > +		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> >  		struct per_cpu_nodestat *n;
> >  
> > +		/* in onhz or nohz full make pcp decay work */
> 
> "NOHZ".
> 
> > +		if (pcp->high_max > pcp->high_min)
> > +			return true;
> > +
> >  		/*
> >  		 * The fast way of checking if there are any vmstat diffs.
> >  		 */
> > -- 

