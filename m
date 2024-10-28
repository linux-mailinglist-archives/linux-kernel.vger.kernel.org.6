Return-Path: <linux-kernel+bounces-385089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9009B3240
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F471F2147B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E141DC739;
	Mon, 28 Oct 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VqeQRIaf"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DE1DB92A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123703; cv=none; b=sOihwNZ1HOpmjtCz3MZlAndVCdKFVipnCgGs2ohQ0XkZeQu/a3aYyuEaSqi/51WpLuudj9IK/v5HporgY8zc98xjhQbr+zREM+RE06r3IfUEj2Fb848qkmnG9CquGJ3Mp9EnskodwxwcWbo8o7nW+AYAKvMobV1fHlFyayG5F60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123703; c=relaxed/simple;
	bh=qL02jNM6QmkzSbt2ixQNsK3JzmKMePb8iL5x5oQAhv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxAW9JndtOCZpOlRHxpVcu7PfxsCqscOF65SdGW72B6TSSS/OCIhw2YNl7bRk4e3wuL0motaJFHhFhpsJK68PIDavFJyXCX72NurE/2E0wjDEOWvsS70I2WlUQkWbw7EE6LRSqEoh/SdI/RZsvdQCiwoVuvKghYr+YDdV0eGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VqeQRIaf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460ad98b031so28941141cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730123700; x=1730728500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdtW+9c27laTcra3rAzShsDaFJHdIeIenw692lRPhns=;
        b=VqeQRIaffq4EvXZks2ytrJaf97/g6QwUiOjEuIvJEErEjcr+rE1wAihHKj42i7IXjT
         cKN35Rto5W06O00htQJTcgOsq9vMjlcigDhgnNNWtzGtHkbGT01/tLMZH9JECoGBZv1z
         0+oGJ1iGBQ5TPbGFAymYT2qXBB6TqpPMLyAjYhoohvpDH/9FeVGy8vFjk3Wfw8/82Bx+
         8JLXg7gm2atdlb7qDjGFPrIk+l8melaxCAJJBQ1JXdhfTqUbx91ck4ZacHSNQy5tPkXf
         nW4b3rDG6NBFFJl9mZXejGtuVOmHuwluhoRkT7Vrtup4t6rGvUXM8w9eQOaeHFe3Y2Hl
         /YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123700; x=1730728500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdtW+9c27laTcra3rAzShsDaFJHdIeIenw692lRPhns=;
        b=svAmMV01xRWU1WnlQtUxKdC3sNO/9bKUO+buDji0YXQrc4sDMqDCiBAHpmkhn33QHW
         JF8cDn2P8mKLuP0KWAtzTY4Qk2iuVZtuvAGxZ1RKQ2ekHRT7c61UxpJqf6/RedTJaFt+
         y7RHaHpElKuApNBXPKM/kvs5Ohaz4MH2rhWO67HU59uXK/SjdSRBCKRk+tuSQ8m0hpKg
         i2UVuATFr1CjvueBKGP8ak/vONdfiCioDdakqAvKPoCg7WDPd9HAyNnTQ4hvxa3Okst7
         JgoEK9048BY0lQ2jI0WIICSw0bGM/ZrOtnh4Xu+dGhIwmcjdiu8ZJ1HII50d8dTA7aO/
         1H+g==
X-Forwarded-Encrypted: i=1; AJvYcCXji4GOiGOt48wzwxshO0aXCCd/OUQYd+GN9la75jqtD2/802xxTPvyju5/bxOBfBxafcclc8P6TXychII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8nEJOfevzr1TaIrvVq7/1Ny+hqkS5WaEgPKF7DILIZKUmIXR
	V3IOJVV9Rnrqg1s8nrUVqDx2DN1h2hJMT4hE0Dk0WcB+eVZXSZ5J9gcSN+gABSZuGkQOIMwY1BW
	N
X-Google-Smtp-Source: AGHT+IGbX3q3h5Rj5AEwNGKx4zq0zvgm4jApVpmYWXOD0GBg1g5E9PSQsj0MoWVji8f6oOFjZAjUlA==
X-Received: by 2002:a05:622a:341:b0:460:adce:bfe9 with SMTP id d75a77b69052e-4613bfdc4b6mr141463971cf.4.1730123699937;
        Mon, 28 Oct 2024 06:54:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613214d426sm34785721cf.36.2024.10.28.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:54:59 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:54:58 -0400
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
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1 2/6] memcg-v1: remove charge move code
Message-ID: <20241028135458.GB10985@cmpxchg.org>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-3-shakeel.butt@linux.dev>

On Thu, Oct 24, 2024 at 06:22:59PM -0700, Shakeel Butt wrote:
> The memcg-v1 charge move feature has been deprecated completely and
> let's remove the relevant code as well.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

