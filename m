Return-Path: <linux-kernel+bounces-369259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB79A1AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453CFB2583E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153C1925A5;
	Thu, 17 Oct 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hQl8A5k3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AB25779
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147602; cv=none; b=BM4LwPSAW17fU3yxy6HzCkCUU9pzWdjEV62Kn8lXG/jyAlIaOz/H9pPLVu3w1UfFKSlBhQzH4NUH+2MVbZ35ndpxk3C4j001o5dm8BK0Epo6LwODHgYwXiWRvC+v6iJ2h1boauhcIjfO9OQH7V8cgei+jd3Pyw/wOI4AkpsWDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147602; c=relaxed/simple;
	bh=mHzjW0gx/VK7EjIrCVRD3DafBTu7kglcFyZPXYwLpXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ7rqQ2nujChiDEhuYy1TPnmBdCiVIghSRMx468SmmfblYMm4MZtNWo82SrfXi4dzqgzXd465xhoy+fDZQu+R44mFaFCDUDNLLdJBBCrDqRJvwFl75Y2zD+93MZkfeTxSLUlyUYGIdAa9+KsDHoXrg9auGXDlL6ZZuiwcUvnwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hQl8A5k3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca96a155cso4745205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729147600; x=1729752400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv5UJ/Xk45I32p3AVak0iA4xEipZAR9oPUhdZra2dK0=;
        b=hQl8A5k3j6wM4gzA588iYYJy6dTDlGF6zji2awPMI2Qi8v07Qu6kfSrPbqCsXNhAvT
         CW4/K4GMHkJyqG75yFZZvluScTTdffbYENhzjbnY9UQnLOjp5i3lEMiHWaz38++mi+Gd
         4H3Tv8G0PmFswxVor56WOnm9qizFERwZvcfYSwVIqCChQaLXgrkFghr1dAaO+bqpS5RX
         4FIP8FTocqLMMjLW+oMuH6O+jR431S76b1w0G7mHU88rVcX+KrOaaCDPRqEMO+bJ5pgX
         wEYtOooTdan7nLpJWOPynZ1bhTpBF+gvNEPUiVOdT11X7kQL0uGkdjVWkKLjLw1/Gm4G
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147600; x=1729752400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv5UJ/Xk45I32p3AVak0iA4xEipZAR9oPUhdZra2dK0=;
        b=Xl3Fd6IslwkEMlKl9rD0u35zFieW5TXOalaL1fjXDmR9es1ykWcGacGfJfpdivGuLE
         wenNvST7OUTIlca+WpT63/VtWTefxZppHa+SGU6wzlTfAkd6NZyhsZLihCH+MGDEIoku
         vK0uNNzjMuMwIbyxKT4ZKjTwUGAgN7GwEf4MRSVzvrnQ3l60Hn2DJJoXvkbjrgyjG5Id
         7O0k0jOUoGptbQPqdbZzd+QGeqk6o7SRWRkq+1zjmHj1mdTtYPLiQ8TtnfEMTfU/oYqh
         fSEiYlAFfzOFoObqEMkgFLO3hyBZPPbEjDyLU/6XEilZRllnTNY7LBd0rysO29hLAPtK
         blNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQQnhQGtlwpHdU4dFwg1cmT2guUXHT4C7xpJOeNjNOlz9BKkbbghsx4x0K9AFWGCmACegOMVG2FfKUYv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXi/2rlHNvkKg89IOj78ob0pBZ1qI5e9kBRykRS80MypBaFcoI
	QhflvPV58f0+0sNJmKoU4qAaCz34FISVcCGCuNDdvmQjxj+0raZk0aH5xcHJx/c=
X-Google-Smtp-Source: AGHT+IFAYfgIy3AbgiLfa0obsAVwN3fi3s02lU8uuKwdk6B7U1BGpCPxN9O4XcRG8RDsPtRfI6ReYA==
X-Received: by 2002:a17:902:f545:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-20cee489d9bmr163242905ad.14.1729147600311;
        Wed, 16 Oct 2024 23:46:40 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f82c92sm38182635ad.45.2024.10.16.23.46.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 23:46:39 -0700 (PDT)
From: lizhe.67@bytedance.com
To: llong@redhat.com
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Date: Thu, 17 Oct 2024 14:46:32 +0800
Message-ID: <20241017064632.82771-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
References: <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 10:23:14 -0400, llong@redhat.com wrote:

>> +static inline void rwsem_set_owner_upgrade(struct rw_semaphore *sem)
>> +{
>> +	lockdep_assert_preemption_disabled();
>> +	atomic_long_set(&sem->owner, (long)current | RWSEM_UPGRADING |
>> +			RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
>> +}
>
>Because of possible  racing between 2 competing upgraders, read lock 
>owner setting has to be atomic to avoid one overwriting the others.

I did concurrent processing at the very beginning of the function
__upgrade_read(). Is it not necessary to do concurrent processing here?
The relevant code is as follows.

+static inline int __upgrade_read(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	preempt_disable();
+
+	tmp = atomic_long_read(&sem->count);
+	do {
+		if (tmp & (RWSEM_WRITER_MASK | RWSEM_FLAG_UPGRADE_READ)) {
+			preempt_enable();
+			return -EBUSY;
+		}
+	} while (!atomic_long_try_cmpxchg(&sem->count, &tmp,
+		tmp + RWSEM_FLAG_UPGRADE_READ + RWSEM_WRITER_LOCKED - RWSEM_READER_BIAS));

>This new interface should have an API similar to a trylock. True if 
>successful, false otherwise. I like the read_try_upgrade() name.

I can't agree more. I will add an read_try_upgrade() API in v2.

>Another alternative that I have been thinking about is a down_read() 
>variant with intention to upgrade later. This will ensure that only one 
>active reader is allowed to upgrade later. With this, upgrade_read() 
>will always succeed, maybe with some sleeping, as long as the correct 
>down_read() is used.

I haven't figured out how to do this yet. If the current upgrade_read
idea is also OK, should I continue to complete this patchset according
to this idea?

>Cheers,
>Longman

Thanks for your review!

