Return-Path: <linux-kernel+bounces-232203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE991A4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A841C21D02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FED14AD10;
	Thu, 27 Jun 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cCspq3CW"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6014AD0E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487262; cv=none; b=gl+AJSlo+eYsZfUgxA8x3h7pJXac4Z6Pe0X8a77D52zeY8IOlSCYMNEDXaxQvL2UdiKkbEHJXkOy97xmGwZ+Kgqs6++WM2QahZeUUJTfIFQYL9E3dBjyz8lQpiJoCHVjxQOypTo/E44iXNURDEnqc0taiStnkzWtGgzcO63NqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487262; c=relaxed/simple;
	bh=75KvCCJVhW4t+FL3UEW31LoWq9X+BIngFsA7NzpWWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWiZbdZNzedm0eJ483Oc7pFpUmZIQtylxySokskmEs/lbFooNAwUlfmsC+geWaijYOlqD6gU2YGFhDE+zt/iBqwEynk81YrTH92ZJGgSwG1PeXyAjOHzBCXU8zEwkQnDYlucq3xA+2KRoWBEUx9LU7PjlXyweUnJhUHNJPrY0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cCspq3CW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso1553112a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719487258; x=1720092058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPFu/nQvcfxtAExpnDqrbxrbwmGjdRGTJyAiHI3QLj4=;
        b=cCspq3CW+xM59jZv/AEPX2R3LUobyMVdC4VwZUSDwlDceLlLs43vrfDQ1LYcC7s83R
         Ycj3IMI/50WGL1J4EvgO2Eqhw3HgW0bKgl2AuxWaxKy3S2YVNqLgkOHAgHD8cLT8Qa12
         spzjIpRPmGGAJ/LKx+48cRcu6EJ9UD/EFnbBYiyTYFGdPtyRj44xt3YV+PgpLOm0huLu
         ZVhXz3VvFdU64fNHUckxHEIYfXz+bYHVKHsbVpM1aBlwEWRj4pBw59jHTGzWp4DHlyzW
         E7yAomgQQYr2RZ227k3glirljHbID5A1UlTI68uuhRdPr+PG4EmvU+XXSmsPpPTWkLjG
         M0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487258; x=1720092058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPFu/nQvcfxtAExpnDqrbxrbwmGjdRGTJyAiHI3QLj4=;
        b=iRmePBBVfRC7Nwp817pkLTMqJn1emj53ZUFHGL+FVFGbKM3Dldslit7NC4R5gO/tbM
         hXMXY9ySgbEJvKiULnhuNYFs1KG0MeU4DFAP4jnUxV0/gIUzbRZoJTXY9i6PsejqBJwr
         n6znhWHABTaP0O4esL1qJ4ukqOZNaIPGnxYAgQa/RP4VMiiVSKLXoslHo2E0RltBXNgY
         1CCA8eq+ign6XYYDkQNDJt4Ua3iDbSDZsx2VgRvgaa4a962HNRbfQGI0QpOU/t5jhV7h
         VMfBZQF5Dy75CyfkOOQeKGR+Kn6cuq0ZNTGVloMq+Sgf7hFGLz5ovvfbVKFhYCT37BtN
         8XzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXizscxC3y76ilJBYBkL2fhKYYBHjgXo5YFstfdvt1vMNpZfnB84M7mrOwKBrQSjJHFkUJwM/MiVPUJ+MS7M9M5VqD5EJDdyeD5+q8o
X-Gm-Message-State: AOJu0YwyOb1m1pm8+9XueCBbzb0gA/zM46E10z7B7Dsi45hY7GOadM64
	+Xtmo+oaNbnSJFgkCloRfW3+WqDiYBq3lr3/DOlsE9L2vY8m2b5FZmd0Ojo6+YI=
X-Google-Smtp-Source: AGHT+IG6/eL9ZaLc1MJU2YJ1qBWnKdGrFcYuxrXX3ZJesGDBdFzKnt8liBGSx+h6rwkEX4SDaLtShg==
X-Received: by 2002:a05:6402:2712:b0:584:a6f8:c0c5 with SMTP id 4fb4d7f45d1cf-584a6f8c1d0mr1504152a12.0.1719487255943;
        Thu, 27 Jun 2024 04:20:55 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d16bbc23sm740841a12.52.2024.06.27.04.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:20:55 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:20:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn1LFyO_cww9W758@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>

On Thu 27-06-24 16:33:00, xiujianfeng wrote:
> 
> 
> On 2024/6/27 15:13, Michal Hocko wrote:
> > On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> >> Both the end of memory_stat_format() and memcg_stat_format() will call
> >> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> >> is the only caller of memcg_stat_format(), when memcg is on the default
> >> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> >> the reduntant one.
> > 
> > Shouldn't we rather remove both? Are they giving us anything useful
> > actually? Would a simpl pr_warn be sufficient? Afterall all we care
> > about is to learn that we need to grow the buffer size because our stats
> > do not fit anymore. It is not really important whether that is an OOM or
> > cgroupfs interface path.
> 
> I did a test, when I removed both of them and added a lot of prints in
> memcg_stat_format() to make the seq_buf overflow, and then cat
> memory.stat in user mode, no OOM occurred, and there were no warning
> logs in the kernel.

The default buffer size is PAGE_SIZE.

-- 
Michal Hocko
SUSE Labs

