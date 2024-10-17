Return-Path: <linux-kernel+bounces-369228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF09A1AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24373B20F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FCF179204;
	Thu, 17 Oct 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AKH4qOiE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7F4084C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146234; cv=none; b=crbXuHNBiPaVYc9GZhjiRcgKNwIR2aP+fyMdTAKIO9at5XF+mSP8/eiyw1/2gHfGIPApgQJ2yHYD09teRh8y2ne7MQ00e8ucekTiowzBhp0l0Q7X3+4DuJ6zgCzr8rlk+PfT4guTuGj/wGC9/U0CXKGhDYx3EA24D0lC6BRGpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146234; c=relaxed/simple;
	bh=mIs8mOrBVDuMLp0bC8VDeI2tycZKx8rwZKLcw4UcRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaTa7VdHCJN5XT1B4KTSWAdP/y2HkDxU7vhAYrfoC+2BNoEWLeuOY1jYyZgS+BBou1urHsOQJvw5jRUYCSAXw/jvou6R/X2ot8RPX334kzGb4mlivCBl7dbaQdpSahI6IG7Cg9nfxdTEoUCRLXovmWcdKntcQoQFXnIP1SQRRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AKH4qOiE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso449524b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729146230; x=1729751030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv1gltbbDF/5j+IX9+hAlWmk56OtAem0dayAMHJ1ctQ=;
        b=AKH4qOiE+i0FiTmixULQTQKnBgZ+LyF48n39nID3q1RWkmkg59mMUfpn/NS/vDhtPy
         hVKiHThdwXu4yJxhF/y+gzpZKiQwgGEVL5XP4mKxrEl8urTsSd7fL4VPrTmNpBRRO2fX
         zaBDCBQlMWlkrJnmYLj+D8crCzhilbuHqeryTDLG+YaumEQbGRqjIh8h2CytOpQTtYNq
         Da0SZWBBCYL2v4JaVvzukLBrLFeZulj7YEV0+w65fd+IvdPV9RQQlYUFlA69D32bXMBj
         c76Q4ztZVA+IohsIRAa1TnuTf6EyT3qwEjegUizauN9uHwjhbM1kWWs+/Fm/msx7ULB/
         oRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729146230; x=1729751030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv1gltbbDF/5j+IX9+hAlWmk56OtAem0dayAMHJ1ctQ=;
        b=PVo99+bCzoHQhRqCtQzX5ffB6HxP2u2dqSdieiqYSUkhLZ/XMLROlvwck5Nh2hNH2Z
         ys6UWrCPzjbcO8/qq7PvTXdCEJYTPFgsx6eDH0iBGkuevfXWIFQI39sDU6SnUwsB3q64
         sL6vRIa37ivut5dFmz+iy9fsflF3xuhuB+JCvMCrES5A6nEIStXNZ7dllFSVyyQq+zS6
         r2VYZA+ZUutd98cOOPBUlU5i6EHjLvTL7rdRmi1QxHieoRIoayxAc5skW/KvbdiwGS7G
         TgfljxdiQaD7DmebA7i8Ud2GhoSd0uZE6ltJ3gF32X0ZLqta90EYqdL96vZS8vvRu9fv
         B6pA==
X-Forwarded-Encrypted: i=1; AJvYcCV0f0j+Zmpc9mu5NDXFv+dQHL6igGgdGnJUhVvL1eEgsRE4/sWLauINwIRPcEcZeqPKakDXK7d0rYXEPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KS876F9Q8I/6QgGdn/yaiuOivj+vYM2hDflRvdTgv657G7Y5
	juLDZMZEmyYf4w1XIJOOupso5FA4N0K0oDv3ZExCP3/xAXBFJ9P73NYbsYlDiEU=
X-Google-Smtp-Source: AGHT+IF5NhQ/b88MCiGtXpRGy2ZGg1UJAGucFvHdX9TN0OpriGsikVwPLjZ/EKzAJpvOMtpl5EEigw==
X-Received: by 2002:aa7:8886:0:b0:71e:6728:72d5 with SMTP id d2e1a72fcca58-71e7da89997mr9027762b3a.15.1729146230504;
        Wed, 16 Oct 2024 23:23:50 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2b37sm4042683b3a.112.2024.10.16.23.23.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 23:23:50 -0700 (PDT)
From: lizhe.67@bytedance.com
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Date: Thu, 17 Oct 2024 14:23:43 +0800
Message-ID: <20241017062343.81825-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zw-oWIAPdCnQdyF2@casper.infradead.org>
References: <Zw-oWIAPdCnQdyF2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 12:49:44 +0100, willy@infradead.org wrote:

>On Wed, Oct 16, 2024 at 12:35:59PM +0800, lizhe.67@bytedance.com wrote:
>> +++ b/include/linux/rwsem.h
>> @@ -249,6 +249,7 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
>>   * downgrade write lock to read lock
>>   */
>>  extern void downgrade_write(struct rw_semaphore *sem);
>> +extern int upgrade_read(struct rw_semaphore *sem);
>
>This needs __must_check, and I think this should be a bool, not an errno
>return.

I can't agree more. I will fix it in v2.

Thanks!

