Return-Path: <linux-kernel+bounces-385096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0A9B3259
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10701C22C01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B61DD0F5;
	Mon, 28 Oct 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VtOhGLFt"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F091DD0EA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124053; cv=none; b=Qcj4ijiGkNW5ptcNdWQYlafILfFrQsFQPF8XR09WlLhf+p8bHg+DOEZUmUTMfak9TURz8BYpnIEFAJ+JsiZNvts4q+eWeMT+m/6OhnDlIxWWPA/XBdRLxZJLRjr2eAf8RM2FyRaflSDVzpT6lLuN6kw5kjVhLQM0VgHqPrEQwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124053; c=relaxed/simple;
	bh=Ew7uv1Ej9gxdNQJgHdVVARFS6iEQx+F+aZ8qXNu4Ti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiTTOrel0Xsevh/yeis+MyNK9ghrpahftvQnJlW5rhuHmM/EA1bgUULY0Zdp8LYkU/hoE7pw6KhHUOASChQtDh1sdx1bMqz3YaBfLU6Ocfw8oK9bnQFXUFl2y9YHBU7gOvX4LFf1OFoO9KpY7DOREN6pcIGcASWeJ0lF9QS6oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VtOhGLFt; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2302186eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730124050; x=1730728850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CyyWAppIMSemT0CuK62Hzyft+OY6WztWx8opHDh7Gk=;
        b=VtOhGLFtMRINgCVX/MFbzoAWe/kNK7gsR+YtXeb7ibCI3qfQPXBfnw8go6Otz+5C9/
         FaKvsdwrUKETyIE06QSa/6ojAKM+TmqFq9WBw9ADBLdMyPxEtDr+ieb5PR1p9RL1XTTj
         1zQELN6mahRrknLnJiY1oXkJ91IICjMk7iiVgBA3sICGEmmCdi7r8IF42aOxLME/M8tY
         GBIk0xXxbyWuvA9IMX6uQD5LyOqM8fWEUx7OOefeseDwcf1+sW6pZWAAxQzytNmZk6DK
         vwqO7LDNNrvrw+Z5fhTkDc2HNRf6NWqYXNEK2+ilNxMtu17Wo+k5OCYNDCl6eP7kAdp2
         0XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124050; x=1730728850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CyyWAppIMSemT0CuK62Hzyft+OY6WztWx8opHDh7Gk=;
        b=nISpgltTFXJKhWuAO5F+MbRD9fEL/VKezAJDGS2h8vvM+wjlLXcbPwvsyWMsl50TAo
         nnj39nFRbBpM4fXgKnMwi8nQTNL9MBACgFTCbT1luBEypbVCEyQoknahTL9J/8AhDesz
         wdDhc+s85wQGE0kfoh7HSJYiH0IiP85HcP89Sw7ClTuwzxQTP3sxCDvghlx33Qyn/CRA
         4HzNpI+KVHqLJPSgQBZnrHPMKXFDNkX3zLHjFgY8oT06W0f9dekFg2fiSaimCyOJ2rhc
         RnW6IDYAwlmPlDya7GS6EeHQsLrpekJzZEpJCtB8rvMGUGY7hhhlSs/vlSaBVt06w3xg
         hk+g==
X-Forwarded-Encrypted: i=1; AJvYcCVgrXSv6DtnwYIU4pM8hUi3HizsrwC9F7V1iJp5L9XEyRZFMIa1SAWMKQm49/ZexkBkE9FK5XhlfSXHCqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEN0FSCGYHHEfgxjJeO8DBy2koVQ47ecMDMVM1/GPSZ/iVQH3
	OC+YZGKs57nUkGfr70b8hhVYX0FgG/KM/LjM2nnbO3NS6iw9rR9AcHuHAexnZKc=
X-Google-Smtp-Source: AGHT+IGBtH1NdyVtTtxosvWgimQBcEYOE5uA1gln4dVd1rWRKzOv+q6qmhcV6IpETFtUChiH4J473A==
X-Received: by 2002:a05:6358:e4a9:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1c3f9e18e55mr223282755d.10.1730124050180;
        Mon, 28 Oct 2024 07:00:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d295ebasm318533385a.50.2024.10.28.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:00:48 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:00:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 4/6] memcg-v1: no need for memcg locking for writeback
 tracking
Message-ID: <20241028140047.GD10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-5-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:23:01PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the writeback stat updates do not race with the charge migration.
> Otherwise it might update the writeback stats of the wrong memcg. Now
> with the memcg charge migration deprecated, there is no more race for
> writeback stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

