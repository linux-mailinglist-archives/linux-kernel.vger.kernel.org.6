Return-Path: <linux-kernel+bounces-268302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5949422F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA691F241A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D718FDA3;
	Tue, 30 Jul 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwG8MXvS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D338B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378852; cv=none; b=KrTQXK0s5z/vDacJSPUKKtdD/vAkSjy2ZMEx/2yCwI3PlUjwgk87qwlNhrNqB7GBFc1iGqyn73rT8n8BLpIHPZHxyaLUXYZ+mU11g8jQoqZIqwjFiQKGnsWQ+MuoOBZpHXDPqWff2J1cZs+HhUBFB6Q0yxYe4pKvl4XDmyf2ISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378852; c=relaxed/simple;
	bh=ACxRB1KnbLurwJqq/VLuaMCJUyRXmJFACq7ZQBFy0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEHxGY3bfSeArXJG83PxVKQXEb7YVtxvksu0dop/v6bzgx+0QW+Q6O08O3fQE1S93xTplHZ/qcKQOrx7iHgiB95UBSDSBJEcrxs36TI/UJCOlF3I6tfTlHVXiLOb7Gbxe+zvGMYW6dcZ3MZK644uZLkBESb4rWfLoIv2UrSYnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwG8MXvS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d19c525b5so3439115b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378850; x=1722983650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGVgOlNgOT878PCHFDWA1bgAufTRCTw9AMRW+Zn7Z0E=;
        b=QwG8MXvS34+JgX45eUcCbU8G6j23iV95NRnLbQqGX+SVVIyji9iWN0ozoWUSgbC3Ji
         isGyv0pr/QDDYi8pBd3r0MhkSIas6TjI8wqmT6lDCcQncIhHrF5lHMg4aH4+w0wvxemQ
         x5UjPuj2hCFpcjNxNk7dGlg8ieswwhUuIRSNjhfsGyvKfmb9u60bLyWAQOjdxJSQZ14x
         Jx9rvpeXix2L1XpS0Mu/wRp5bIA+Hy0z1Jcx2TxBj0IATPFNETelEZZnsLkvQY/9L7P1
         ddmkwvrR28Z/O+fw8kasTasvF7Eo/aYPDbz726HsUAlzV+j/SWVqDq3/r3me45lgbKLa
         G4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378850; x=1722983650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGVgOlNgOT878PCHFDWA1bgAufTRCTw9AMRW+Zn7Z0E=;
        b=lZuW0rjSDhW0i48btx3JT9MNeXEd0ybHR5gQYvS3BT/5AAgZ0WbzuJXfbbkeYcb4ho
         c9yrZd299iWV2gio6/OkposkkDNW76OVrIRznpWr1AfI6bvn/W3phc9EjEHkAWcNuURE
         jEVZhqIUZAb/0w+yIzfdzk2zj3IZJcxAc5Tzl5vsgZ/fNBsvqtCWFUWKCHQNSCVOF7j2
         ZxTFQVA38PztAEeatAbWEVYKyYAcMTVzf1eHUk7V1pQR1nNq9A16B4DXSjUng4SF9P9k
         BUNfxduWwSM+dqeH5BHXwFIcvIfxO4F0A3odHcyVAmHlvYy996VzbC6WHYRUUJv+QVkU
         0Rug==
X-Forwarded-Encrypted: i=1; AJvYcCVosgDUqvk68J/d9vNUXbbhEaUMvVbDaHlf7Ja8OS0E4qmD1x6ZeJe9z9S7IS7vDyV7nq5IPohi3aNGLefw3ht5pbfbIV5YPT8NmjfP
X-Gm-Message-State: AOJu0Yw92Kv9EMpYaRlRKFE6ygFDvF1wzXtbom+RH102IpKVm5zkizvf
	xLvXTHUw2mfXm3TkacmZKc90bWwkxcZqkdIJDz+arIRWdS0849za
X-Google-Smtp-Source: AGHT+IHLMghuz0GXRqifWQUr2fqTNJGM+/BW5td2jxBxhYkXrbaXvteLwK2lMQMAN2FE+UH0wfVdxw==
X-Received: by 2002:a05:6a00:1389:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-70ecea0e6e0mr12366446b3a.8.1722378849828;
        Tue, 30 Jul 2024 15:34:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a39d8sm8934759b3a.213.2024.07.30.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:34:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 12:34:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 1/3] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZqlqYLZWCiLKhVJf@slm.duckdns.org>
References: <20240730221742.2248527-1-matthew.brost@intel.com>
 <20240730221742.2248527-2-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730221742.2248527-2-matthew.brost@intel.com>

Hello, Matthew.

On Tue, Jul 30, 2024 at 03:17:40PM -0700, Matthew Brost wrote:
> +/**
> + * wq_init_user_lockdep_map - init user lockdep map for workqueue
> + * @wq: workqueue to init lockdep map for
> + * @lockdep_map: lockdep map to use for workqueue
> + *
> + * Initialize workqueue with a user defined lockdep map. WQ_USER_OWNED_LOCKDEP
> + * must be set for workqueue.
> + */
> +void wq_init_user_lockdep_map(struct workqueue_struct *wq,
> +			      struct lockdep_map *lockdep_map)
> +{
> +	if (WARN_ON_ONCE(!(wq->flags & WQ_USER_OWNED_LOCKDEP)))
> +		return;
> +
> +	wq->lockdep_map = lockdep_map;
> +}
> +EXPORT_SYMBOL_GPL(wq_init_user_lockdep_map);

Would it be possible to make it a one-piece interface - ie. add
alloc_workqueue_lockdep_map() which takes an external lockdep map rather
than splitting it over two calls?

Thanks.

-- 
tejun

