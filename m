Return-Path: <linux-kernel+bounces-360305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75539998BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C0B22757
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B06AA7;
	Fri, 11 Oct 2024 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7L6GYib"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468B7489
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608992; cv=none; b=iL6QUgQgNCHugIebIs4OioQS35Z7DsKE1TUrdE7L1yzM7pRJIEZe5X8FD3RDLd5b6g5IvfrkyfGTt9GxXv+NGVL46ruIFFAxAZsAkw60Q85+qPVdz6ULdJFWoNM/QXYuX2ucURlIFi8A0UieqGm8LYaD5qL8H34bzvrOQAc+rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608992; c=relaxed/simple;
	bh=9RkDDwOhXP/cCSzIpAAp4QgSbbnxes8iPUelp8+nPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1ONCTjvtS1qnrocfSea/OjF2CpQsIdUF7nDz+03Z5Vi/o9QWUxPyXyUzBWnQk+tKkIDvMnGYCPVgXECi4cqh2aEpyqzIcXwac2TKXg6gabJ2ajsqK4NeUKf83aTzqtVYfLZ0bUiLhMNDNYgIpJK5HYwDEa0Abr+MGETertNfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7L6GYib; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c91d0eadbfso2061323a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728608989; x=1729213789; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTHje0muZPf49FQkQjwDnqpyf3rz9rMv6QsPFUwU2q0=;
        b=e7L6GYib0xYWDMvxBTonIETwGjiwq48Y6k/MJ6AYF9P0f7NcZjBaZV3d2XqNXk6FiA
         qfmS9ZcNvc06IDo2ETId8VFcs6aOMbbbTek1srDE4VmLzPqHM20LA9KeBE4MjDdDYEGk
         7FrhElDp8/HMSw3OufkDAcEpTEDn/LWXTTVXNzlnEW9LXgofRMFUuOiySLGuwZqVza61
         GjklwnThljmilKebH7fQ2ihPmidZUQrnoLtTA1eqobpI3rqSZfpg/9s1gbCOseev03aJ
         tQsJ5R4gxoXwlvOV2E3groqptkWpZXimTh++qei3veTqLwfDWk2j2qtpJ9UibiByqceq
         TeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728608989; x=1729213789;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTHje0muZPf49FQkQjwDnqpyf3rz9rMv6QsPFUwU2q0=;
        b=hWa9PT6tFoi35T26+KgIF3VrHHV8+pA7qe/C7tKzfODTecFsxiHO+OTO8MvPNCkF8o
         /dcKqyrGMwOTlJP6T+vy/nqkUnqxMppFGPEYtzT+2Tw1bKoxXooyqz4gyDGz2jSRLR1q
         MN7+a5D6J1IpBoP6PgNbu1WtUupcAqrHf7XJWh8qQ4CWmcjGX01rHgspycJ9IJ8JLz5S
         d9kQ3V+awQX/HAf4CLngTS+ahPD4f6Y+0R37BS4OI35noc5GrQt7iQchJnmjE9Po0u0s
         g/9oRqF3cjR2TMoQzLtGvyK/NgJADGjDksv0e7vusoSDxeflSzIShLDjK7VrOMeQzeme
         W0hw==
X-Forwarded-Encrypted: i=1; AJvYcCW3mhKZ9cacqpOk+OgBkL0p1I3H5ajVz/TutsJRH5vxF6JYduVDzWBMZtc46NsGAfqdna/gCPbtNVP/42o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmnZXulYTY5gbF1CIGsTBO6IjSN/KuYbZNHlaFxURQUfZ6dg3
	V9XVssEbsAiZGedTWm7aIFSDxWC/oWi8A6N1XX2PzSx9+BmrAdxw
X-Google-Smtp-Source: AGHT+IG9MwYDvF+nd2vSnJ9HW7qQhl2AOrp7z7oZAVKf8wELtMFSou4SIqZpfnmpwPFuiZTf4urQUQ==
X-Received: by 2002:a05:6402:274b:b0:5c9:2a8c:8950 with SMTP id 4fb4d7f45d1cf-5c948cc83f6mr398182a12.15.1728608989111;
        Thu, 10 Oct 2024 18:09:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937298d98sm1380250a12.91.2024.10.10.18.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2024 18:09:47 -0700 (PDT)
Date: Fri, 11 Oct 2024 01:09:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: fix alloc node fail issue
Message-ID: <20241011010945.usgu7kqjdzimrwo3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 26, 2024 at 12:06:30PM -0400, Liam R. Howlett wrote:
>From: Jiazi Li <jqqlijiazi@gmail.com>
>
>In the following code, the second call to the mas_node_count will
>return -ENOMEM:
>
>	mas_node_count(mas, MAPLE_ALLOC_SLOTS + 1);
>	mas_node_count(mas, MAPLE_ALLOC_SLOTS * 2 + 2);
>
>This is because there may be some full maple_alloc node in current
>maple state. Use full maple_alloc node will make max_req equal to 0.
>And it leads to mt_alloc_bulk return 0.
>As a result, mas_node_count set mas.node to MA_ERROR(-ENOMEM).
>
>Find a non-full maple_alloc node, and if necessary, use this non-full
>node in the next while loop.
>
>Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>


This looks good to me.

I don't see it is in the master. Not sure this is missed.

-- 
Wei Yang
Help you, Help me

