Return-Path: <linux-kernel+bounces-569918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F756A6A96A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E70168BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D61E32DB;
	Thu, 20 Mar 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="m3izvTXp"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9E1DE4C5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483312; cv=none; b=VuCni9y5IvNHBL2h6E3R75/5FA5xoHodMDhevgSKl17XQqBTmhkeul3K9k8f25v+ZlvQBM1i8pxsBjRPo6/qyQdehqkCKZWbdIX7cSFwGJhQsPMCMMKEK3ljcfOnnibxcB3HcHP1CbasjT+4S5Zz0i2ue46AoIyWeekeTW8UrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483312; c=relaxed/simple;
	bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzmp1RuF6XTPs90ZxyjSt7m+c8EidOM+uw5T/8xrKagJGCviiP5CTn8brEFEOFIaS2YKyHbzv9gcjM//MZGzjLpfX0AUBk649KwTI4yVZhuAeVb7aBE735a2Atl3ThqfjJBUz/od/6Araa974XIVhE4ayqIaQeNJ7RMgVOVh9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=m3izvTXp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476b89782c3so10439491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742483309; x=1743088109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
        b=m3izvTXpkq8MM8CAfUIKmfW77lVHpp7BZ+9eWIBDi4jytqMSeq5KvZgkm4JxUVgkr1
         01l5Hlm/rPlczg/x+65Ratws2+oHGqfdEw1wI2LHjVY+npMo9sssCXwR2UcQkTEIeTt3
         Nxt169msZ0nT28ER4yIZWQmsZPImwVQlzyIULufq76F1wGQKxRqFfwio1Frn0u3YFahF
         Qiv6UhkGM6r0suZnh6mKo+yeEl9iKnpzS2VQXALgrk+UXQIXj9BA78fDF99mKADy75AG
         2DiTDs99fomJHp8ODRsP2xATAjj1WJHydJN/ZNRaEhD+iZU4ttXFL5lJr9gC/WiOW48/
         2eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483309; x=1743088109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
        b=sT34YNih0w7eIdxDZV5qWUS9cSVo9Ssba44DDgcFcgoUl52j2A2s7v+rbZnxUc6Efr
         1YFbBR9AnXW8luT6l95pLcOG/p2a338HObYpayN7D1bcOQyFLwv+YRvo3d3gEXR4FLAE
         ptY5ZC6pB7gWpwx1EfUXfG67ym3/8nWhVLU2t5Qq1tJZchhm/FVqFQTVP4dcKxUFgEId
         tzOG+e0Z8nEGE4X11WEjSVbROx+Evg54eWAa1u/iRJtPAKtYa4XlwANmFcD+7U75LPOU
         4NNw4qDkvt95/LmI3mL/3B53oLRfjgAEd8QyLd3YAWQXAMg9xrmXpeKmPznQXSzJ2mMw
         0Bog==
X-Forwarded-Encrypted: i=1; AJvYcCXSXztFGiXiL6iJXDUexSfOezcimrKMj1S8sWOg0/LZyUoUGd9g4o7kHkz/JwkxPdxJESLFZaHs4usUXXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVME5qC0owBH/iRfSUyC0aTHyrZjgJ1sqTpEI7yNaD60mWgfq
	2rvooBYnNMpj8KZ+oMVCcHBZnRCZA7331N2/tB2EXVY3qPCxwSHoB3tfhKRnoHQ=
X-Gm-Gg: ASbGncvZNPAIGA2T8/cGx9x+dBljJyyTXdHnCgxaoCgrUV7LEiLbZ46xuUQww3FFDos
	b0Afrv8P0rnLRB7nts6Dhdzwr8uo+lG/Hv3mhVcdeo+4rkv2lBgp6W5UO7T1fGPQqpANl35Vpb5
	RvBU9zb/hQnKA7TmEk8esDfOf8xuZ/34ZTpvcy+0vvZDe912CT1XqRaHv9crE5vCnwaVM97BiJZ
	hZJxAl+C1G3NhfevFk94Ov0mticxtHu3FvhGfX6k8R6pYh67B2wrObQjbd4Oqo0iixKbJPPPuyW
	DbXUEerq4a+p0RM28QhpQ3dMhCfCqNH4jbQJNZHeBeE=
X-Google-Smtp-Source: AGHT+IEqDT7L31lKb+4Vt3imVDG99K/l6IxQtEuRxofKiOxuNW4VzwDmBVYfyocCiaVRZJSQ1vSRuw==
X-Received: by 2002:a05:622a:4cc5:b0:476:6d30:8aed with SMTP id d75a77b69052e-4770839bf5emr111115461cf.49.1742483308620;
        Thu, 20 Mar 2025 08:08:28 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d176113sm209421cf.17.2025.03.20.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:08:27 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:08:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <20250320144722.GH1876369@cmpxchg.org>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319193838.GE1876369@cmpxchg.org>
 <CAJqJ8ig7BrPp0H3Lzbd0u9R6RhS5V0-i3b4eMWf+4EhujRU-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqJ8ig7BrPp0H3Lzbd0u9R6RhS5V0-i3b4eMWf+4EhujRU-jw@mail.gmail.com>

On Thu, Mar 20, 2025 at 04:09:29PM +0800, jingxiang zeng wrote:
> If both memsw.max and swap.max are provided in cgroupv2, there will be some
> issues as follows:
> (1. As Shakeel Butt mentioned, currently memsw and swap share the page_counter,
> and we need to provide a separate page_counter for memsw.
> (2. Currently, the statistics for memsw and swap are mutually
> exclusive. For example,
> during uncharging, both memsw and swap call the __mem_cgroup_uncharge_swap
> function together, and this function currently only selects a single
> counter for statistics
> based on the static do_memsw_account.

My suggestion is to factor out from struct page_counter all the stuff
that is not necessary for all users, and then have separate counters
for swap and memsw.

The protection stuff is long overdue for this. It makes up nearly half
of the struct's members, but is only used by the memory counter. Even
before your patches this is unnecessary bloat in the swap/memsw, kmem
and tcpmem counters.

Fix that and having separate counters is a non-issue.

Overloading the memory.swap.* controls to mean "combined memory and
swap" is unacceptable to me. They have established meaning on v2. It
may well become a common setting, and there might well be usecases
where people want one setting for one cgroup and another setting for
another cgroup. Or maybe even both controls in one group. And why not?

This is a user-visible interface that we'll have to support forever,
and deployments will be forced to use forever. Tech debt in the
current implementation is not a convincing argument to forever trap us
all with a suboptimal choice.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

