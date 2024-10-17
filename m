Return-Path: <linux-kernel+bounces-369227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB19A1A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046FF1C22CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B81179204;
	Thu, 17 Oct 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ByC9XU/i"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F44084C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145933; cv=none; b=t3LdVX1z7c7XOMStZVMr1kHbIxoFq8m8Uy3whojenk4PI93D6FiJL2/43Wfr906f3m9/JZCAoL7XBSQNAI+YEzknso/0qH8/l2T89LesF/Jxbnn7mICEKKxxmvl54g0VKMpGAvCp70Y2NB6Yv+XJUNLZaUL5yDpdOwQZ/TAlZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145933; c=relaxed/simple;
	bh=OrvOI+5HalLgcSkXH2hhozrOBcNEIFwsHg4/xYLS9Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT/pQS+EdvgPzkLIZ+cqnYk/XIGo4/VHuPJW2OpWspZxv74c0hant9/mTWcw4XkXvmodhd/aDOouLxn7En7DaSJn6tliuBVHJPFo4KTijof5VKDr3al9OgL05mLaGILB8z4aea8w7V28L+L0oAjyKK+M+KYCU4vrsSGNTIIfaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ByC9XU/i; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288d70788d6so269368fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729145929; x=1729750729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AMuJ7HqPV1JOGCg5tobowAHNkSY7nMnl7ipVjQvkNU=;
        b=ByC9XU/iab4rUuadi6d2Lz0apWlg3Wbgbs4kPgairSh9LdiupWm9UrfukWd5ZZSsEX
         vjceaI7nogVJcomuKXELNf7ibGl6vMRv3GTyf6IPjignUVZVj1kwBfvNfL+1mj6Ts4H7
         d6MslgbPkEB1YAoG3sBuqs1BZBqEwQqVCSW+kRxUy+zmsjhpVupE7vmt6uXZo42r/Bmf
         1btKIJyHIPWjrIIixk2Sovfjc3Wid9AaC/XN78QRew7fyXSeHQQmgxCXTmWDjSIpzRjG
         dUnz8HCQ8L0pW7qbuCV+WLAVe6to51X7tTl/2HPq5u74bFmR+0A9zzCIeQgRadb8rZuw
         4WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729145929; x=1729750729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AMuJ7HqPV1JOGCg5tobowAHNkSY7nMnl7ipVjQvkNU=;
        b=JwWfUZr49ZEQ+xjYCYnUpfXCYABOe67qHSQd0QOzcToNE5YbcKoKAjv2iHNryAIkp0
         dXTU14lI9WyhGLs6jToQEqBxGMkuxcCFlyCDTJYT1rBBCUX4BuFC7u5llOVtLVKU50sl
         FGtyFyDLlIXHdkQQ1D5YsnKtN61X1AZBipzpuXEfS3e/5n5i+8dHjwVsWAV5uZwdn2mm
         d3kkqRTYF3gPTkOK/MMzEKCKQ3GVZeyZGDnhwUMutTGLk1E+7QfLBZhaI7gIr1Hz+gZB
         qohAYc89O/dzSgWSVNQqCAnbqWG7GOwDTh6mNLl0FTZt9Pyk98AFSvEzkwUAoMIrxflA
         Fbqw==
X-Forwarded-Encrypted: i=1; AJvYcCWWfXgmVYywqBCwiJaFPZoNLEChh+9nkJsB+RQuAE4ZZFD/AgUlegu5bi+39+xlCUmK8aHpJ+3DlXZgFJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngBZzkkEX+AXhPitNQE1VJ3TczcULSBT5uefCcseJxOUoHATU
	Jb1TLPfdSt6cRszcqbZCKBBmurvBn89OQ2WhIRK6lmD4GX/lOEacIKCGXD3cryY=
X-Google-Smtp-Source: AGHT+IGzYJOejjtuqJo0nJ1nynkWMnHU8ii7Rd3gZibJ6Lwzw36puDjCRZ94B0e+iKiVQIQOOVVwsA==
X-Received: by 2002:a05:6870:80ce:b0:288:57fa:961d with SMTP id 586e51a60fabf-288edfb72femr5245852fac.38.1729145928950;
        Wed, 16 Oct 2024 23:18:48 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c442bsm4259549a12.28.2024.10.16.23.18.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 23:18:48 -0700 (PDT)
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
Subject: Re: [RFC 2/2] khugepaged: use upgrade_read() to optimize collapse_huge_page
Date: Thu, 17 Oct 2024 14:18:41 +0800
Message-ID: <20241017061841.81240-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zw-pK_4wCvJHKfSi@casper.infradead.org>
References: <Zw-pK_4wCvJHKfSi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 12:53:15 +0100, willy@infradead.org wrote:

>On Wed, Oct 16, 2024 at 12:36:00PM +0800, lizhe.67@bytedance.com wrote:
>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> In function collapse_huge_page(), we drop mmap read lock and get
>> mmap write lock to prevent most accesses to pagetables. There is
>> a small time window to allow other tasks to acquire the mmap lock.
>> With the use of upgrade_read(), we don't need to check vma and pmd
>> again in most cases.
>
>This is clearly a performance optimisation.  So you must have some
>numebrs that justify this, please include them.

Yes, I will add the relevant data to v2 patch.

Thanks!

