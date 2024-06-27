Return-Path: <linux-kernel+bounces-232250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7191A5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C507BB26564
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13914D451;
	Thu, 27 Jun 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nw8St+ES"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0F14F9CF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489268; cv=none; b=GCnoN2i7b8wMv9UIbX1OS1bP/xttOJWg4gUobbDEwnt4BnypPyq6Vn5wOoa7eKtYbQcOgYG6SVm1u7QdFy7oYoarp9Bx2UYiDw66xnE76xVz3xRAbZ4N/wbqwr5nYr10s4GXdO7iizgNZ/hbHldYpYmps8BVTsW0a4kC6Ch3rpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489268; c=relaxed/simple;
	bh=9km+Ve+6DVw+PszI/DZGSdNiyY9QOK+aSdMcxpf0T8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba2KEopIdo0tyS08XGQ3xhloXbhJOo1ZzHx/i4nvSfkjNBFh4nbOsvOqlzs5NVSh1rpYOKwoNGD+xaDh8W8Oaj2LjtOqfA7UNyShM4cpsVP9Jl382AyYOdaV/AfPV7icOJdjHSPARJn8yKHhJl3FTZZDfGJKcWOIDfv/RavjA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nw8St+ES; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so9940583e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719489264; x=1720094064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmlCKFAQTumozZSb2qpyhtZvbivJ59JtxtsMbo9O2jU=;
        b=Nw8St+ESNWxTM/MT3d/5T4T69QAkzFe0wU/EGAlN9vICkDYKlca9k1u6K+d69MdzCu
         WAG3ZZQAUi3e8h2pWkb1uwM0l4OfKQMA3Ccg+8indgik8+8RjxiGQZIOAhqSvYdTIeUp
         TuDwrSBj11sCXfANcC6I8ZTrlrZKXspN7x3Ba3HxXUYgAyQvryX7HS3nQ7AaGVP14bEp
         rbvbC7PWilHlR/SYTppNBweWFgmwBU46mmwR0RGE2+1NeMOMqsC/4mZbGNxvJwSeQJaV
         6FYti2nD7Mvig7pxt+xNjCmrvMa8R88xGw2Jce1mr8SSituXQXErP2ja4hHnL5EdTtug
         hnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489264; x=1720094064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmlCKFAQTumozZSb2qpyhtZvbivJ59JtxtsMbo9O2jU=;
        b=GGGxvfwbW3lgMd5YvdDkUx1mLGilF10nU8ZL5qg1yOZjQlwmzY/K6hkwvzy8CT86p6
         bgGHJnp8x/N3YktzJU8RmSzRXtFVRpG5VxQJ5wZhT7uAqT/GjUfNdIbAkhWdRziswPdM
         a4O91XDnPHpzu6AcTRBSU3eK8LO6TWw8woyyfU6D5fLlLt8ivQPAtgjo78jlc20doL/K
         knffNnwU+PoIZWiAgYh53m0W4bdxj+xfw5CxFvJSJCGlRBkdpj5eJhTmBOIAqYk7r3A5
         6ETsd6LtZqgLPSToHBH0s3RYdBM2+E6Qo1wQXnO+DjiWGooae7+wh1N1wZSxBdcq+4mm
         lPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDLEFXwvkgaNsmmTTedTz7OS9OO40X0FYviL5Iz2ewjdIh+UAao2Mi56o7sbRuO1vN5yqX4HVXuOEApMlMzPU+ZkDsDNOOKkO5kSQ6
X-Gm-Message-State: AOJu0YzDdpmkwpl4eBU/locqOtljCZstPiGXy9rqsjetG/UqaLVeW7ER
	FhTPg+Nsz+DHuRvE5o17GoGrfFg+GM+WojWX058RC5+IhaRwx4ZloQGwNj7aX9g=
X-Google-Smtp-Source: AGHT+IF/7J1Nf5P8IK2DBJMJhVj+ERVjEaTHp3eq1jikjna1dLR4odCLnSjwp6wO7JK6t38d8jeHJQ==
X-Received: by 2002:a05:6512:3d1d:b0:52d:3ada:4b6b with SMTP id 2adb3069b0e04-52d3ada4c32mr6180399e87.1.1719489264372;
        Thu, 27 Jun 2024 04:54:24 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7c957esm52172666b.197.2024.06.27.04.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:54:24 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:54:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn1S70yo4VQ24UNT@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
 <Zn1LFyO_cww9W758@tiehlicka>
 <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>

On Thu 27-06-24 19:43:06, xiujianfeng wrote:
> 
> 
> On 2024/6/27 19:20, Michal Hocko wrote:
> > On Thu 27-06-24 16:33:00, xiujianfeng wrote:
> >>
> >>
> >> On 2024/6/27 15:13, Michal Hocko wrote:
> >>> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> >>>> Both the end of memory_stat_format() and memcg_stat_format() will call
> >>>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> >>>> is the only caller of memcg_stat_format(), when memcg is on the default
> >>>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> >>>> the reduntant one.
> >>>
> >>> Shouldn't we rather remove both? Are they giving us anything useful
> >>> actually? Would a simpl pr_warn be sufficient? Afterall all we care
> >>> about is to learn that we need to grow the buffer size because our stats
> >>> do not fit anymore. It is not really important whether that is an OOM or
> >>> cgroupfs interface path.
> >>
> >> I did a test, when I removed both of them and added a lot of prints in
> >> memcg_stat_format() to make the seq_buf overflow, and then cat
> >> memory.stat in user mode, no OOM occurred, and there were no warning
> >> logs in the kernel.
> > 
> > The default buffer size is PAGE_SIZE.
> 
> Hi Michal,
> 
> I'm sorry, I didn't understand what you meant by this sentence. What I
> mean is that we can't remove both, otherwise, neither the kernel nor
> user space would be aware of a buffer overflow. From my test, there was
> no OOM or other exceptions when the overflow occurred; it just resulted
> in the displayed information being truncated. Therefore, we need to keep
> one.

I've had this in mind

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..3e17b9c3a27a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1845,9 +1845,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
-
-	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
 static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
@@ -1858,7 +1855,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		memcg_stat_format(memcg, s);
 	else
 		memcg1_stat_format(memcg, s);
-	WARN_ON_ONCE(seq_buf_has_overflowed(s));
+	if (seq_buf_has_overflowed(s))
+		pr_warn("%s: Stat buffer insufficient please report\n", __FUNCTION__);
 }
 
 /**

Because WARN_ON_ONCE doesn't buy us anything actually. It will dump
stack trace and it seems really mouthfull (and it will panic when
panic_on_warn is enabled which is likely not a great thing).
-- 
Michal Hocko
SUSE Labs

