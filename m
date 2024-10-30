Return-Path: <linux-kernel+bounces-388981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A79B66F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A681F21CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187D1FBCB2;
	Wed, 30 Oct 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z9qzvw2q"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2911F80A0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300700; cv=none; b=SUZIMxdZeQpy6L0cwvGhkKUKYCoXtZo/YlSrWIHmCkfFeYqi7C/oo3vLU8unbEeBRCKFA8V8T+xq5/3J3rw2uXTBHD/QzuxlDxdU4RljlckKFJ9BapeGo1Gtt0e4zzVaA9pyllEgzNSxfY/a8tJ6WXdHg7bLJwvYpyMOXGi6FyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300700; c=relaxed/simple;
	bh=WLSXttbBN+Nchtr3DXS0Di4OQPiMn1CjhtNhKfp8TH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS8/ns4ib1Fu8R7P13rv3km4VZCQIO8aRMt8q9wjhTXrTqjrCg3crdVz3lqh4KTJCTy3x8ZnZiCpRTd7Uni2YJRGfLjFkn89w3J7KK5cO29MEsbkht1tYHT+EXZ3i3gPFnsSa//Fk4czropjS9XAcoHjk0+EpAccXT+UCJrlPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z9qzvw2q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99ebb390a5so188308566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730300696; x=1730905496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvVdPi8ansOXvDJXtgFjdjSxu3XdMpqKtWClsI507QM=;
        b=Z9qzvw2q8Q9LNwJnIK8knRzPFiDU0Zg09LBpCY5GqxZvUVV3OxNYN3e30lrqsYQDld
         KwV9MNGKDqpaPQveVdjyF9R4c6mXPXp5OuxA9cJiF3+6oXUQ5rXDv7lDm35+0gTJMWsT
         ovMDAH9fT3wzZZo/drhGjIhfEiQdahiqEhgLI1UWwEiwXq69UfcXV/xHCd4u1xZ8pQ6L
         AkTdePyW+gVObvZse+fkuhB+tHCcx/UCv2Cs2kLuDAm560soq3Q7NxRVyXwS/xwoCaQ8
         sIZnQGm04CvpoJsHW8I4pbp6fmsCZAEIlsu+C0HdwIj3d9Lej7iDy9kUkaPYW8ZNltJs
         rV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300696; x=1730905496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvVdPi8ansOXvDJXtgFjdjSxu3XdMpqKtWClsI507QM=;
        b=jmfAeLSNOW2tNUiqc3WWWQTpmEYZ4SSGgIOxNrQX7O9vkWcg4s1ZCeAvz5xl0yAwD3
         uFXMfBb5T7NAFHiDJ02vPaJmqZkhvH5hi38LG22Ai5CnTZWIqGSoDwHhfYASjLo2ylHi
         544JCGhfQq3a6arUHUBi/BNwccMAbRQCbBQbF9JcHPCtqTTnPhY+SqFnuh4sva2u6wey
         EXgEoUIN2DYCWeKtGED9In7Ytcl4kMHurNjbQfQ6pNK00biWR8xnTfXBR7sl92m2yQCr
         e6am0eH1LxS0Q92DG7ugkclchelb6fY1/ij0LNWIp7PV4Id4dImE8fwzDjY5EP/0dBiI
         9XNw==
X-Forwarded-Encrypted: i=1; AJvYcCUATeRoqOsYoigZAsGChcIZjX/1hn5A8gBllMZyNcWwkP+1/S2tAihFHW1FNzuc43PSGxzL1GduYTQcIT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFMobEAFovg/ZPFM1MrFoPy3pNdYluYIKW6O97x+ZJqaBcB7L
	bjZsZzYc6JEfErb9Ffi22AcFEZtRQb5KX+kG6Z7A2xhHvHXjcCcruFSdawsl2jM=
X-Google-Smtp-Source: AGHT+IGPlZuIqSn11jkgKQPEzOuv92CbR8SdcSXqv4p+sYZbAqsDGdMUGuu2IPloDxzpWtDzRrTRrQ==
X-Received: by 2002:a17:907:2d86:b0:a9a:130e:11fd with SMTP id a640c23a62f3a-a9e40b99491mr228194566b.5.1730300695909;
        Wed, 30 Oct 2024 08:04:55 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e75ff3bsm576041266b.1.2024.10.30.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:04:55 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: gutierrez.asier@huawei-partners.com, akpm@linux-foundation.org,
	david@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	willy@infradead.org, peterx@redhat.com, hannes@cmpxchg.org,
	hocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyJLFv8TgoTyo5SH@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyJGhKu1FL1ZfCcs@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJGhKu1FL1ZfCcs@chrisdown.name>

On Wed 30-10-24 14:45:24, Chris Down wrote:
> gutierrez.asier@huawei-partners.com writes:
> > New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
> > have completely the same format as global THP enabled/defrag.
> 
> cgroup controls exist because there are things we want to do for an entire
> class of processes (group OOM, resource control, etc). Enabling or disabling
> some specific setting is generally not one of them, hence why we got rid of
> things like per-cgroup vm.swappiness. We know that these controls do not
> compose well and have caused a lot of pain in the past. So my immediate
> reaction is a nack on the general concept, unless there's some absolutely
> compelling case here.
> 
> I talked a little at Kernel Recipes last year about moving away from sysctl
> and other global interfaces and making things more granular. Don't get me
> wrong, I think that is a good thing (although, of course, a very large
> undertaking) -- but it is a mistake to overload the amount of controls we
> expose as part of the cgroup interface.

Completely agreed!

-- 
Michal Hocko
SUSE Labs

