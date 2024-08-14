Return-Path: <linux-kernel+bounces-286895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9602F95201B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78051C21F11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4101B86EF;
	Wed, 14 Aug 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmzu2Hqa"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9B2BB1C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653306; cv=none; b=LC4Q/VSlhb6Kt/oxz4B2GcTIwrOCfEW8wRgyNzAVF+QDaHp0FASb91U5Rs8WqnrOICAwTcTky1G8IKTrdyl39wRBbEYO2LeixVYRnjLcUcPssj5RHRhSDkZOc69YUDTcJxvM/a23nQJx1llq5mdqxcLIWn5uyHWNFSLeEWSSgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653306; c=relaxed/simple;
	bh=tKPxLWLP8Cr0cgsnzCLdi9uNz/WUDAmpW1vDQmoZYlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH6nd5DXHIcnryrFTt/Am3eP7gqSOSPdy5BLVj6dospPebj1iZWPaB0JEeRR1cZkoAdXpFE70LEta4nFKglr2ZNB/E3eadL6gGEttA1kk0+dFbCFuSicFAoBVvrcP96A9MJwtTN1Kv6wvrcaJDZz9BrvlaxQ1ZLeNx9iSARl4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmzu2Hqa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so3976043a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723653304; x=1724258104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brecS361Mlbg4KwGvL3bJULTKTrYGllDAjQTVTFSVy0=;
        b=lmzu2HqaiaVQQqYumoP+Ogdca15JCaAWLCowLkKArKozbJWVztgfhqG5kZNQyCZ3Bp
         QVbUHTPVjSf9ocyvRn4vo2O7cpMVD4WeR+jTN1YWrKf3o+NVyXZanqoIQrR4ARcC75rG
         rA92tpHxY63tTqBoQ3bsenv6XkDwozwhtAVoQ5fMnwVX6o6vaqSBgLM/yWF/Ima1kKQN
         s0hcZRGVRL2Dyj7/yRARzIxuUMKgWOOb5YDQ8HwtKsce/xtnkVx5BMUJUAt/ohxWcQTt
         8Olm1+GEsEMEWx8vldQzRJWZY+iurDFff1gDvd8gZuUh0FTojkAA5rJbFnSSiyrKVEVh
         Eukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653304; x=1724258104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brecS361Mlbg4KwGvL3bJULTKTrYGllDAjQTVTFSVy0=;
        b=F7Q7G6ns3Z6jpHhuBkpJDpR5nUmNCgluAO11BgxyglBJYIV7kJm/M9zNof99toOY1Z
         VOqrbVlBNhrrduBqdBEL1+451lUR+8Mol8eVy2PexDybF7pD+bgEyiiSy3zDcZIs4Oee
         Z5/JFciV8ZTPolWflrnAgVDeYH8Q367n86FETexBxPIuB0zg15jAxeL68rWoTZzWrBdn
         co6otSJR4b0leiyvGa2sJrlTIUFSI+XhzxoVjsPF5cOiA8+45pmU6wQITe/zOu1BNPNI
         s7ygQerfN4bZnqnzmFJQ8p2zYYjyZJymwoN9jNWMwkdwIoeBPDDcPtgTjT9KkCOeCguM
         EX6w==
X-Gm-Message-State: AOJu0Yzy9Zd0wxChgKxeIPv9BMeENcAy0I5v8l8s2a+h5o9qMLBX/tUf
	CjnvFP7VHt3/oiDfQ8jct8r+q2Ewkv3khUa8ejZInalMMwHDkHIxiksAyD9J
X-Google-Smtp-Source: AGHT+IFpv+F2dwwAi4mdkLuAVPcv1OpuGAmGnNVXkNQY7r0zeMVv1Wvkh8Aj4txECahNivDwamtQkg==
X-Received: by 2002:a17:90a:7f92:b0:2cd:4593:2a8e with SMTP id 98e67ed59e1d1-2d3aaa991bdmr3594263a91.15.1723653304090;
        Wed, 14 Aug 2024 09:35:04 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca3c1sm1980400a91.8.2024.08.14.09.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:35:03 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:35:01 -0700
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2 0/2] sched/topology: optimize topology_span_sane()
Message-ID: <ZrzcozFadC5xQdUq@yury-ThinkPad>
References: <20240807190522.432388-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807190522.432388-1-yury.norov@gmail.com>

Ping?

On Wed, Aug 07, 2024 at 12:05:19PM -0700, Yury Norov wrote:
> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> even when cpu != i. In such case, cpumask_equal() would always return
> true, and we can proceed to the next iteration immediately.
> 
> Valentin Schneider shares on it:
> 
>   PKG can potentially hit that condition, and so can any
>   sched_domain_mask_f that relies on the node masks...
>   
>   I'm thinking ideally we should have checks in place to
>   ensure all node_to_cpumask_map[] masks are disjoint,
>   then we could entirely skip the levels that use these
>   masks in topology_span_sane(), but there's unfortunately
>   no nice way to flag them... Also there would be cases
>   where there's no real difference between PKG and NODE
>   other than NODE is still based on a per-cpu cpumask and
>   PKG isn't, so I don't see a nicer way to go about this.
> 
> v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> v2:
>  - defer initialization of 'mc' in patch #1 @Chen Yu;
>  - more comments from Valentin Schneider.
> 
> 
> Yury Norov (2):
>   sched/topology: pre-compute topology_span_sane() loop params
>   sched/topology: optimize topology_span_sane()
> 
>  kernel/sched/topology.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0

