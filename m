Return-Path: <linux-kernel+bounces-367526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8EC9A036F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5511F22754
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AEE1AF0AE;
	Wed, 16 Oct 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QSO+h8Fm"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65338165F1A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065667; cv=none; b=lWQiGRvWuu5Ns3c0nF02jmTNoQjPV8yDCa/7uurRq1mUyDz8oVHTNxS47kh30OgdAtmLCdsQZypyoMUvfdX15Dej6VGYjxhWHhtjW8G2N/bbA2uWvmvuJOH/ZwV5al0eNJUR0YAC7y0JM4uo6CNqGnRKoZPAkMl3UCedU78KAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065667; c=relaxed/simple;
	bh=Ofgeqz/T5iVUr1qT6y/00HLBUoBrcmyVunPvwLZIyiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KntIsRfkqg9k/3kfWRDfPykzW0oR7pMwQL6p2k+zAyHCm8OFn8HxfCCofxIZmzoM4GVlHqHuItmtLsiOonrT2iz9NPO+Xdy0laMdYRI40/bmsfKIA8Pn79yTbBr9n3O4L4x/XxcENgzF83BDqr1HKwLa+ubm874UVzhsFxPW798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QSO+h8Fm; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71806621d42so329224a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729065664; x=1729670464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M21h/dt7Iy1clPFZAf1njDI7NLprN4WDvOrcQEo2uM=;
        b=QSO+h8FmhFrSYrWI07vwaWbO9KD1zmGGS/UqwyRjjKUlvk90YVYMQzzBXjuVFLMQby
         j4S8WvC2g+21EgMtBdNlBPsmoMISM/80DYiGXQJzj3slZduRaKu9u33QJl+jT63zSAoJ
         vOSgkEoo2h34DH0H0Nybi8fNrVquw5mJNvzMYw1MusoYd1lFD+bMlvKhm/XV8yMgRooy
         gv58K+O6Coqps+PWADlMz+IOJvolimQn80FIVaVP+GgnkVXGuNK/lYA0u4X9P69+vNDC
         Z/xr3ZgK0asSv1IshSBbKH1lTpkKDVVe67mZdYrj5Tij3i6p/cZgNnXCDNO7D77SSAcP
         d+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065664; x=1729670464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M21h/dt7Iy1clPFZAf1njDI7NLprN4WDvOrcQEo2uM=;
        b=Dyhsty+QRQUNGlUJPzlIzuRWIJ2Ap8lQ8HyzmywU/Zr8c/bXsZqFOuo4e5agWwVlcw
         JJhuTkd6BJOuI2b8X6BzvGQ8UW7UWPmMP4OXjCWIBXuMifTrU5wIDhrrSu/EWcUI5iN3
         qi1RYAZYz54EkP4ax6o7ZUq2fymiuSbP84Ce/hSL4y2eaksEDVFh2F2o4gu7ylXTymN2
         vEt8Qjak6kDi69bBrcb0F6VHT2mDUxQyz6V9wv4euAPhwP2vHTNCkjYoTDNEWvtJlqp8
         hUs4rA19Qc2GBZA5ciwgsMNUf24aVu7pFeYtu0dvJaEMzUmuy52nAw+eQlehBPqdklCO
         zZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUr2MIWGD4CHU3EuUCCZ9lX/KfHnJsQ0MkxO8jUL5x6z3qp8dbVgbasNroPEhgedWKbRcSeduDzvsXGQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrEyLk13I+w5xIEikwtAXt165JKQAfyRzj2ZpO2joCWw1psMK
	CCIP16lIBIiskCFOdcgfAfaKfFUH4KLlhNc5mCIPUMRWi6w0bEVSLWOU0PXBmWA=
X-Google-Smtp-Source: AGHT+IEU0iiZWXAVlkZdbgM2jqbTULI7bF82PQoDahkKYTLIu4dgObxdkg1xqbqWZWjo+hb6vHoGMw==
X-Received: by 2002:a05:6359:5c21:b0:1c3:6e2f:fc03 with SMTP id e5c5f4694b2df-1c36e300a76mr369097955d.18.1729065664354;
        Wed, 16 Oct 2024 01:01:04 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c728767sm2675079a12.93.2024.10.16.01.01.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 01:01:04 -0700 (PDT)
From: lizhe.67@bytedance.com
To: hch@infradead.org
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
Date: Wed, 16 Oct 2024 16:00:57 +0800
Message-ID: <20241016080057.43997-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zw9s86K0Dv2FZvt2@infradead.org>
References: <Zw9s86K0Dv2FZvt2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 00:36:19 -0700, hch@infradead.org wrote:

>> >> +extern int upgrade_read(struct rw_semaphore *sem);
>> >
>> >No need for the extern.  Also please make any new advanced funtionality
>>
>> Sorry I don't understand why extern is not needed. If we remove it,
>> we will encounter the following compilation error:
>
>That sounds like you dropped the entire line above, and not just the
>"extern ".

OK I know what you mean. It is indeed OK to remove "extern", but all function
declarations in the rwsem.h have the "extern" prefix. I think it would be
better to keep it consistent.

Thanks!

