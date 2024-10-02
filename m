Return-Path: <linux-kernel+bounces-347405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2480498D233
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAE72841B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D91EBFF9;
	Wed,  2 Oct 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZNe3MI/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1461EBFE7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868515; cv=none; b=brOlFQHHUa8ZeBXIJC3SpnZymbI+9rSTPWQpLAvxE6qwkRJ/PbMnOJIcV5DPjOErKr+O+r1yqJxJfHhU5ZxBaEoElvtu5Cs13OJN+k9lGnqaiUbWfdak/24SZ1tSgN0hiMcU+d/YTuly2IjZb5FyH0jSqHmy+frT53Y9eirCwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868515; c=relaxed/simple;
	bh=vZhy5RK2jzgVOh3tvzv0EPTSBO27cI+FkL56P8MDDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTUCOY5toEK8T+QfF9Bg7QgwKipaWSIjJBA1xN8eCP4OnWPTqCJlNs9ZTCFMrFBVd3VAfJOtU4y3oAZKzpwMOz32lY/QcKg80z0prCYD2+I12imV1rQ1+ZSrWrqy7Sipdew8B5la2zQQfWvUZPcc4slHpE5cyu30FI2n4p8PKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZNe3MI/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so4650165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727868512; x=1728473312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3CsujielR0/Lj5Yt3DNTU+m+GpBohBJmAfQEZ4LT/A=;
        b=EZNe3MI/lj5kJwBE4AKLJjc6iI9Ooom5Xi8zWAIvNX1/Ew9sAIHOz97mlIDRQNUOJj
         Wdxd3SReaEdOi1BJWt+I8qnAubFkNRs/xVOSFAMJS8d7HAXz400ouALV3y0qEUAcKk8l
         AflE8z20yD1e4L/+2fSG4wLdQgaHnGFysfJq1H6H0M6ktFIBGCz9wsyX9EPkplF42Ws6
         7cziIFK7oGrYntJgZp+XcK7/9svociT8d2NA4sps4JpW/bDEc8+9lBAkV2Kfsb54ZX4S
         /DJNpybTn/e1b+2B58DeG6/JahZonMtWntrLvN9BHbklNmLfGNsrmLSv1Tl3dPavRijN
         439Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727868512; x=1728473312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3CsujielR0/Lj5Yt3DNTU+m+GpBohBJmAfQEZ4LT/A=;
        b=qa4USCL1xkmqPHGsJ6nPjBCnWTNqm9njyF7bWxsAcJ1kj7wJVGqnsyGq++dRIjY/xT
         mVyneWTsinrfRtCGpYImLaXa6spJn9c8Xa7e598ibZPUoBIfZGUW2TF7Iu3tc/cTj7Sw
         SPdsR9J+wo5lqm0qxCDKkDOA6DR9gSTtT5L3xd87QRnemnPErbAyOCb9ZzjNHDdiE/Hz
         B+dvkVEZAvy4SHUbaQimgQHkLxPfRUS0Ky4dbDV8t9/mPFNlDWmXEKD59lQ1/ymGwVUc
         +XrmaBOg291TRPruCXSZo2oZBnK8tPme2RszgghQr+fN/4ZhRxtv6qzBRVZxPe+cZtm4
         G5rQ==
X-Gm-Message-State: AOJu0Yx1L5VN+CvelFSu2218gQJoWuHjey/iCL9KCveWBbGqmjwH+cu0
	BG7TAIk8d1QBw96jYRH8yztaVAL78OD6BuBQg/wG0A1bgBWNHp6RbTCXcSte5HE=
X-Google-Smtp-Source: AGHT+IHWQoJyjFnm5vg1HmB7MSlkALHoLRiM0a0Cqaw736TMNSFThw8Yvva956argTiJOV0cwtJp7Q==
X-Received: by 2002:a05:600c:4710:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42f77720814mr15171335e9.17.1727868511844;
        Wed, 02 Oct 2024 04:28:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d693sm16276955e9.2.2024.10.02.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:28:21 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:28:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Kairui Song <kasong@tencent.com>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
Message-ID: <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain>
 <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>

On Wed, Oct 02, 2024 at 02:25:34PM +0300, Dan Carpenter wrote:
> On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> > Let's add Kairui Song to the  CC list.
> > 
> > One simple thing is that we should add a READ_ONCE() to the comparison.  Naresh,
> > could you test the attached diff?  I don't know that it will fix it but it's
> > worth checking the easy stuff first.
> > 
> 
> Actually that's not right.  Let me write a different patch.

Try this one.

regards,
dan carpenter

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 79c2d21504a2..2c429578ed31 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -65,6 +65,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 		       bool irq, bool skip_empty)
 {
 	struct list_lru_one *l;
+	long nr_items;
 	rcu_read_lock();
 again:
 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
@@ -73,8 +74,9 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 			spin_lock_irq(&l->lock);
 		else
 			spin_lock(&l->lock);
-		if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
-			WARN_ON(l->nr_items < 0);
+		nr_items = READ_ONCE(l->nr_items);
+		if (likely(nr_items != LONG_MIN)) {
+			WARN_ON(nr_items < 0);
 			rcu_read_unlock();
 			return l;
 		}

