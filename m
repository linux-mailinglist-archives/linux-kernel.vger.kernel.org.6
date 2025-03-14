Return-Path: <linux-kernel+bounces-561002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE5A60C39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7AE189D7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188321DA61D;
	Fri, 14 Mar 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bexpi/8k"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E31DC988
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942369; cv=none; b=uLhQwV4tk4foI8TpK0JVv0gFxmGnYdUSVATrLVY+Eqj0Nf6fd8sZ2JAODonVJwh8afSqezm313vIGdpNPCY6aEhNUWMSmH6x93bMp5HMbsM1gOgcrCznAkP0M05Gpz0AQ3N2wdM6RG5CDwO7m3piE6hDpXqe39XyT4e3zljANdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942369; c=relaxed/simple;
	bh=U8UC2gIF9o0Nhc2v+e6c4HQdMiDf0IJmkSCRALHlx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNjVLlg7FO49zGINSerb3/uqGGlNZS1lhrPrYFoL9I8UTDglc80WYAssWUc3y8c7BgmHksctlGpn7scxApx8W++hcBExzuHwqlG/T4p0WWDmxhRvARZceO2Z/x2oozM+Pk+PzL8rHuAhKZ/+2JT6g/P66Gr4S3UePAgPlQo73IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bexpi/8k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so275653566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741942366; x=1742547166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHaG7FKCn55Pj7bQEh0xrrto1Kn/+ohEIM1jtxueJMM=;
        b=bexpi/8kpqJT50f7AnQtkEduQQhQ9pl9lQvQTldEW4V8YR4nSxlTd5p+GrAyfGusiE
         lWzaweOQ+/rg1SGxhcGwWuaTMwfYaiBBciPzKX4rywhuXow8YEIRx9P3N+9K7+rRN6+Z
         kIQnWKEQBRL8i9JfX1FMTBTPuSw9vEyja32/K9b+2wAofwqgJaZ6HYbmQnwKcgK4uKQY
         QeB2xrNGH1qG2ytyQ7sxRR6UcAHXeryQGyn0Qs3uQEarIsPbbKIskTceeOAnsaBuQ5PC
         8MN2PG2X+HR/SbakMnl3xrXMSnxLmZ/s7B8vAztLDJCuUAHLClELmUc6czwpYBcmXZSB
         Wj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942366; x=1742547166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHaG7FKCn55Pj7bQEh0xrrto1Kn/+ohEIM1jtxueJMM=;
        b=lqDCwNlICzSenh0DUGsd5ykp/i1+UHIRst20kVek/KKwS1HbYXyLsfjjPa6YiemJUW
         zUbOnsv+z3cZo/5Os4Gz0vQuOpZdwqvxd9QBHEDkj8LHXZ+q7T5JITfN7DLII7JxkSdu
         ByV5caURsV0Uog75wrYcOgEM9L+K3WgKTAIm/YR3MT/e5Y0HbhoTqi0C+UtkrNAY3CId
         0cAXVMIvNyNn4v8WJigA7MkMltyylcXMF2gBVZ6h3Y/xNUSzMInMrhBdZVxp1xvnVqyi
         CzphOvXulsmbP57jlPf15dsCvuBTRp49yfFf9znbvgF5yUvv7gBMbjGjKGgtFWfmuWLu
         eJUw==
X-Forwarded-Encrypted: i=1; AJvYcCWchzd282ZwXsdm17HnjczLt329JZ5B97XIBg/Dd8xtPWRIoZrCi8NZ4gkQbcY/wd39i4dc7LxQ7FvYVvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCxKEMYb0RlBX0rTI6LBBIW09TZ27zAeIXlIp/BygiPsBr4B6
	1EEYsBUkP0yQKlpBRobi267aPtly9utkLLgJkjp523d2ccyu0ABMQnKNfrgjM/I=
X-Gm-Gg: ASbGncuOxRhLA3mbbmN744EJ4VUX/lGfk1/yrudLsGbNBiLzEMSNkP4tQ/PkhG5v0cF
	igTkgKOk8RmYhDFfcgqJ4iiSv8H676ZViYDjYZnc0Phnd8LfCQvv3mtBDWVaUsL0CbJCombUCXM
	S4cDr7hUIv92nB2Cp5V9doEoLtlM6HLlA282sLMwWhZESQm3rP0vgeclwzA/3j9vxZMbP0ysAAK
	1CyP70cwa/PMmznw7oKyYBONJQhj0J6zQR+89zYjBrsEhEg8psIHZvw5/rxP0wavGIi9a8FC+UT
	oYzUTIXbxTLyk+PG3z36fF2NeKlvVYFrViwVm1m4DFM82ZUkoSEnAnFv8A==
X-Google-Smtp-Source: AGHT+IG6EIx9d8PTfLAdazXSoMvFJDIVIJlOXLltf+Qc1+aS7cgJMHAxVIqlJ9pMPC+fuwn0HD0EeA==
X-Received: by 2002:a17:907:805:b0:abf:6db5:c9a9 with SMTP id a640c23a62f3a-ac330441fc0mr185944366b.39.1741942365632;
        Fri, 14 Mar 2025 01:52:45 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac314a9db94sm198560466b.171.2025.03.14.01.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:52:45 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:52:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev,
	yosry.ahmed@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <Z9PuXMlHycL6Gco0@tiehlicka>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>

On Fri 14-03-25 11:33:50, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file folios.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
> 
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
> 
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available. For example, if we find that a certain cgroup has a
> large number of inactive anon folios, we can reclaim only those and skip
> file folios, because with the zram/zswap, the IO tradeoff that
> cache_trim_mode is making doesn't hold - file refaults will cause IO,
> whereas anon decompression will not.
> 
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.

Haven't you said you will try a slightly different approach and always
bypass LRU balancing heuristics for pro-active reclaim and swappiness
provided? What has happened with that?

-- 
Michal Hocko
SUSE Labs

