Return-Path: <linux-kernel+bounces-278773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5594B496
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC99283575
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1679CC;
	Thu,  8 Aug 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV0oFUra"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651520ED
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080062; cv=none; b=nClmKxK5BEe1Ub0w6vwy4SpgWbclGb/8Qj/Cv1JcMjvDXWdsGKxTbqn+k3/HrzNRD1nkn/DO4mjx4OIvLyFB+d6a3Z7j/XOZ7uDH+Wx0Le1vW3ud+yylsue2ekKP0a/maI219DRsqFuTDoEw38aa5WeWsIuDb5Kingz1kyT+COk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080062; c=relaxed/simple;
	bh=ajeMim90UvalacYDca1a9fc0jeI9eLG6wQ634RMEP5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=aYhWKVZ/9msdbjktmA9S985FRj3GSHlUrqWfCnACHJqaGt7/9JJV9vamMisy5xujdI5oUUrXWbBhjM1qyKj2GMhUVs24P1eROv/sOpMcdix9Etbwp+ZAEKwIlzRUF2XAnTtRn2KmbfSttoY3qOF7fuQwq81QBXE7YXzEBaNsrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV0oFUra; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d316f0060so1053873b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723080060; x=1723684860; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sgrFpyqpMIIoSCjw4gHzwzuWC7LSft9+V2d21z+sLXw=;
        b=YV0oFUra2BYQZezUn4T8oY6aLIhc/Wra5KjwIs1KDfj37iLjP/iGl/7P0Mijyl+ILH
         htCl5V+eeFMJgTKV7jHmtJYHxZHoWOXZxTqzH1ggmr3mLo10ZlK5AGJEzGxToq/NmTPp
         uU6+ReTzvkjUh7OtGGKYNf6ndXuwVpPaZv6GMZtXhIRSf8EvMZQey6hLrSy1qzxvoQyZ
         oofjauNo9XGxtDu14g2Sltp/OlKBvVqWrnu4hqpoJO1TOKDRUOaSvLlLgzk+pPzQ5Du+
         xePgcG36BwivJ/OsyoPMIxP2ALNOGWSEdjoTSjGpt0Q3mN8NTOB66Mm9bha+Wio6Z+ca
         1LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723080060; x=1723684860;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgrFpyqpMIIoSCjw4gHzwzuWC7LSft9+V2d21z+sLXw=;
        b=oRK7Uten19sm5kXs4jLBi/Km3AR5imSANU0VIjJg7YThAR+SLdcHbTQMy9Q1m6YtgP
         xXFJ3KfXEvPZnEnS1OICwYgtK72teTvPVVkH5I80utdBqQR6gInvO1i6gYAWhzyBIz/9
         IIz47TL2TSLeaQBBACQ+c4Vq+QrdH+PwWdgkn7k1MAzb0TtbxFZw2aZJnZZEIB2U4C0U
         CmPg0vFW6A/MUH/XCAr/euOtu/zw+PMlqxjEFfHRa7O9FQ5928tepuJ9APN06Qo+4b9U
         1fNsv6Xey2RSVBonghHvUuBZli9rUyYU5iphJEDs3VVCHJCPm7d+PB9oAzkwZ1qUDepl
         qcMg==
X-Forwarded-Encrypted: i=1; AJvYcCVL0Kijf73OTxik897MwqZMc7XosWtQ5eUw3ulkYVp5/lf804K16b6yF93t7L5qkwi/402kjQASsOvniYeMfkjOTTzBPNou1Bz2fSH3
X-Gm-Message-State: AOJu0YwvT2bhCPozIDUwpLsOm+V7FAXznbZIgGCxT+Of9EumR5wQ6r2E
	xGZPdZlcu+Yrn1XFtywVwd0SFIobItQuQ1W78PePxdKWRVz4in2otbJDjg==
X-Google-Smtp-Source: AGHT+IG3mrZOTPiOQK6HTGGGu81lQ9knbT5Iw3b2XivEv3jJH1Qf/Y7ZytHdxcF0nqD8lQiXI0LOkw==
X-Received: by 2002:a05:6a20:734a:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1c6fd687f7fmr308583637.17.1723080060078;
        Wed, 07 Aug 2024 18:21:00 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fa3dasm122488b3a.193.2024.08.07.18.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:20:59 -0700 (PDT)
Received: from jro by jrotkm2 id 1sbrpq-0000OH-0q ;
	Thu, 08 Aug 2024 10:20:58 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
    Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
In-Reply-To: <20240807143922.919604-2-cmllamas@google.com>
References: <20240807143922.919604-1-cmllamas@google.com> <20240807143922.919604-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1502.1723080058.1@jrotkm2>
Date: Thu, 08 Aug 2024 10:20:58 +0900
Message-ID: <1503.1723080058@jrotkm2>

Carlos Llamas:
> Adjust the upper limits to the maximum values that avoid these issues.
> The need for anything more, likely points to a problem elsewhere. Note
> that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
> had a different symptom and has already been fixed [1].

I tried setting all these configs to maximum, but still I got the error.
	ld: kernel image bigger than KERNEL_IMAGE_SIZE

For me, these are the maximum.
They are compilable, but could not boot due to "out of memory".
Also I am not sure whether these values are meaningful.

CONFIG_LOCKDEP_BITS=23
(CONFIG_LOCKDEP_CHAINS_BITS=21)
CONFIG_LOCKDEP_STACK_TRACE_BITS=25
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=24
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=22


J. R. Okajima

