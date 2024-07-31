Return-Path: <linux-kernel+bounces-268376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055C9423DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713FC1C228A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96A4C83;
	Wed, 31 Jul 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqLCpqCO"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6D4431
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386177; cv=none; b=b1o3gngmmWTK/RHEKOzZMXy0tBNldyRcdyVG73AiP06kQSBKkYwhs4C5znyNRKbLCYSHgzcoX50dR93eEKzp2hWwFkPjhfU0lEBD3+5A1/lBQlsLWpBTkLLRfR0y8g+s6PISjfSaIc8vl/neH1OqSKoxMoyz04ITfYT4tsDPV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386177; c=relaxed/simple;
	bh=+VfRhP+FiN6dbxldXwT+21mprcQcLKLpOfnjKRA20ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoAiUTzYpCuAsPXCAHE4xh7BQC50efNbLLg4GyWrXEViKVRG94m011fD/oUKZ18LOLPbDleqbjg/Ic6Q0T1BZrYmXKrzvqk5X5WHffs2TnZpUNWHsF637S8agH9rBA1IaJBMerdoQkuB0o+t5gi4rTXirT1QwETbfU9yIhgjU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqLCpqCO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cd1661174cso3418663a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722386175; x=1722990975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbphnlhavq5cSuDvU9XbuNpAKWiecL5M2ABEBD8iQJ8=;
        b=YqLCpqCOgmAjSutu0KrxCUBdt8L58X58lscDdDoVQEIFYO4qm+C7x4MMfWf21WiS2I
         4IQOsMLxSMvFLX8I8107yFIwwANc/OHZPWwd3g1v8aMLBFNc8kRefYtw6Ky/M2LOdW6I
         G6hWj5tdNaf9xDP8+92O92p+/xVL1dwuxI02R3LNwBF/PGKD3Dy0OoCBRnDsffUVc5+L
         u+HP3lZ/EtjomqEhDi73X7RNNZYZgk7QXQdw+eVD9YMTQeq6Pwaw0I/d1YIYNyqydlt3
         yfS+3b3C9MrHxfNojdcn6J1p8UAKFq52N+SKBfkTeuYK957OeU353oSw5XapPKbokOMj
         HOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722386175; x=1722990975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbphnlhavq5cSuDvU9XbuNpAKWiecL5M2ABEBD8iQJ8=;
        b=bHeX4rc26KXwVzsH8551pfLcJfPaHAvoglmZdJdyxCNTbQJbc4mzcJpb1YXEirlUJ9
         DIHJKemL05KvMdxOrxfqh0ElXFzY5qFw+a4uGfNxzWhq47Q5X+EoPuKH9A+L9gw4h4k+
         8w/ZcLgOdmnMSSVczRAP9lqMYHcoJIMrPAoYoAGE6wM6J+cpvp0GhujvNepXXgMwk3n7
         tavcnIUaEPoHYiSSpJ0PIz3Ep+00dyAxOgBJinXZIFLfguTgOomzQ+h4vK3wxgbv9SOT
         60d1cBfRVOj8sIEvMyIwCKlEtM7Iq9UqMeG7mvJlbhMNjBr94FAjRm5dLCufYHmHHPN+
         Rd9g==
X-Forwarded-Encrypted: i=1; AJvYcCX9ugd+oYtYcE5Kx+tuxl7JiCpM5ADZpJyatU8UdAIxA4451mk5F/jEdk21CiqjahKxnjaUcANJVhTZGG8s5Ljs1rlBRUrqLJk6hvyR
X-Gm-Message-State: AOJu0YzDu1Zda/SocOMpm+M2lKzzXko81ktYkFXO9mX7fuoOwdWp7DYg
	QBjQYsHI1eSrgm9hN7t0wXdc5R8h9RrwZD9YVTjpNvq0N8tZz7BQ
X-Google-Smtp-Source: AGHT+IFCrqsBHFIFrlJDXHKp9UtwqpJ7XQ7v7u+LOGT2ozY+Tg1Y+819VdHY0UnwCVPax6fXKVxmpg==
X-Received: by 2002:a17:90b:191:b0:2c9:96fc:ac54 with SMTP id 98e67ed59e1d1-2cf7e1a1f08mr10524587a91.2.1722386175362;
        Tue, 30 Jul 2024 17:36:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc42596bsm27763a91.3.2024.07.30.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:36:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 14:36:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH v2 3/5] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZqmG_c2tjKNAJWfh@slm.duckdns.org>
References: <20240731003119.2422940-1-matthew.brost@intel.com>
 <20240731003119.2422940-4-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731003119.2422940-4-matthew.brost@intel.com>

Hello,

On Tue, Jul 30, 2024 at 05:31:17PM -0700, Matthew Brost wrote:
> +#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)	\
> +	alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)
> +#endif

alloc_ordered_workqueue() is a macro too but would you mind making this an
inline function?

> @@ -4795,11 +4795,17 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
>  
>  static void wq_unregister_lockdep(struct workqueue_struct *wq)
>  {
> +	if (wq->flags & __WQ_USER_OWNED_LOCKDEP)
> +		return;

Do you still need the flag? Can't you test wq->lockdep_map !=
&wq->__lockdep_map instead?

Thanks.

-- 
tejun

