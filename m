Return-Path: <linux-kernel+bounces-267364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9A9410B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F611C232FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C719F474;
	Tue, 30 Jul 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhL8iLc8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF5166316
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339503; cv=none; b=f5PQM3/Gm1NZjTGObkyo1EiRMeVTdtric32y9XgCKn5JsvAAJc3KnqAdPKs217AYXL9h+d1SNJ1VIY7mSGIZKkuT4hekiOHYZYcqPeHZx+SFjWtUcwAzLv5lvfcobCvF0ma6zYkzbtoimMyxq2OQbfYu0UQj5NSzGNZP5NOQTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339503; c=relaxed/simple;
	bh=6G1biqxBW4A97FWPzupirAJ6si3ybW9x6Gmja8IXRIE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP3kSUckIQ6UssfIVLPT2ZKb/RIkBV8s3FGA9Ichaygn6STpU1/uBQK84KksO/4H2tt1ZReDx+Zg1d+j0H8EvfgkdKXlxwv2E60z980kx2VHZJO6EPhc9j8GeQxYAPHwiKaCEr0Jsz0hYbzgrVXoVFCiD+qWna4VvjVDjPsQVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhL8iLc8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efbc57456so4688793e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722339498; x=1722944298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lP9ZC3R5hMrSLBrjIcRWHj9UaDtclwyOij0udu20d1U=;
        b=mhL8iLc81e9zGaxif9BYkWhSeBEydVz4MxlTKz/7LNz/CbKG/12a2ikD44dvsYtnul
         dbhh7beQUuzyVEgMGbBg54z8irIagbx3d2uyss/Kamt1fxaBpRGB2+BxRgkNwmoa5nCC
         oszQyoUsYtiHaTbOAkDAaO/Ay0a7W0T2qJ+EziZ24c9RlpgYXqHKTMfiRuy4m0dXimRG
         3tZLmPcPCzYAYl76ExrxqEdoIUqA50iP5EBULi/e9H5F8iPp/Vhq96ikVK1Cteg5Er5R
         dGY25i4rwZMShdPNVelPf7f0WAn5SJEJ4cu2BBhlVCqieUkg/oi7WZvAHrCaaXrmqTG3
         pYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339498; x=1722944298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP9ZC3R5hMrSLBrjIcRWHj9UaDtclwyOij0udu20d1U=;
        b=LMgrK6o+2NiUTIFi8mPw7RuMrI2lGBmqhurSRszzRJIno+fb82bXcLVBLELVF7d1ey
         I8dlGAgNaCvhlakxcAgAVRXJey3396XpqbFGqpwZfhQ9eGY5s27wd2oPWgzNWG5s5lkR
         Gkejlt6tCda5hWQJhkFo+JVAXq1682AXNx5sSWLnmFao4OuQTjWAL6DRQ43yAf/XeB1q
         xkd9A4PBNKDlAjkBUf3GAWHhKPHDcVO2pexYKaOofzXVydF0a5v+hRIWQsSxj46Jmd+f
         SjgHbmW0XmuyuiF4DoKHug7uCU5sGw1+VWq/BEJcGph8dm0Gjni8hPLXZYlC6JT9PX4G
         pc7w==
X-Forwarded-Encrypted: i=1; AJvYcCX4Y8QXM1VuQLmxeHKUVyiOs0QpventmXinuMW/N+dDNhDoOwD0/zwosWCgAq5iPWwsi7fh3vPnC90H3xNsds0BspD6xA3UYe/c/8Ct
X-Gm-Message-State: AOJu0YyVdCXtuqcwC19/iys0qey7xHvp95+kW0jI1HfWbNNYsP0kObO3
	FqxARdVWFpnONhAwLZcQ60RRZAcJTWEdZHb9sVTeKmTIJTxV9Gn+
X-Google-Smtp-Source: AGHT+IEhL0AF4VJATyVfHZMXtaBFUppKExZeQWXMI1cwWGjKNu0oR/QUccYAXymk39Z4fcAa1bkkqg==
X-Received: by 2002:a19:7404:0:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-5309b2c3071mr6147385e87.41.1722339498077;
        Tue, 30 Jul 2024 04:38:18 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08ec2sm1876073e87.127.2024.07.30.04.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 04:38:17 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 30 Jul 2024 13:38:15 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: urezki@gmail.com, ahuang12@lenovo.com, akpm@linux-foundation.org,
	andreyknvl@gmail.com, bhe@redhat.com, dvyukov@google.com,
	glider@google.com, hch@infradead.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, sunjw10@lenovo.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-ID: <ZqjQp8NrTYM_ORN1@pc636>
References: <Zqd9AsI5tWH7AukU@pc636>
 <20240730093630.5603-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093630.5603-1-ahuang12@lenovo.com>

> On Mon, Jul 29, 2024 at 7:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > It would be really good if Adrian could run the "compiling workload" on
> > his big system and post the statistics here.
> >
> > For example:
> >   a) v6.11-rc1 + KASAN.
> >   b) v6.11-rc1 + KASAN + patch.
> 
> Sure, please see the statistics below.
> 
> Test Result (based on 6.11-rc1)
> ===============================
> 
> 1. Profile purge_vmap_node()
> 
>    A. Command: trace-cmd record -p function_graph -l purge_vmap_node make -j $(nproc)
> 
>    B. Average execution time of purge_vmap_node():
> 
> 	no patch (us)		patched (us)	saved
> 	-------------		------------    -----
>       	 147885.02	 	  3692.51	 97%  
> 
>    C. Total execution time of purge_vmap_node():
> 
> 	no patch (us)		patched (us)	saved
> 	-------------		------------	-----
> 	  194173036		  5114138	 97%
> 
>    [ftrace log] Without patch: https://gist.github.com/AdrianHuang/a5bec861f67434e1024bbf43cea85959
>    [ftrace log] With patch: https://gist.github.com/AdrianHuang/a200215955ee377288377425dbaa04e3
> 
> 2. Use `time` utility to measure execution time
>  
>    A. Command: make clean && time make -j $(nproc)
> 
>    B. The following result is the average kernel execution time of five-time
>       measurements. ('sys' field of `time` output):
> 
> 	no patch (seconds)	patched (seconds)	saved
> 	------------------	----------------	-----
> 	    36932.904		   31403.478		 15%
> 
>    [`time` log] Without patch: https://gist.github.com/AdrianHuang/987b20fd0bd2bb616b3524aa6ee43112
>    [`time` log] With patch: https://gist.github.com/AdrianHuang/da2ea4e6aa0b4dcc207b4e40b202f694
>
I meant another statistics. As noted here https://lore.kernel.org/linux-mm/ZogS_04dP5LlRlXN@pc636/T/#m5d57f11d9f69aef5313f4efbe25415b3bae4c818
i came to conclusion that below place and lock:

<snip>
static void exit_notify(struct task_struct *tsk, int group_dead)
{
	bool autoreap;
	struct task_struct *p, *n;
	LIST_HEAD(dead);

	write_lock_irq(&tasklist_lock);
...
<snip>

keeps IRQs disabled, so it means that the purge_vmap_node() does the progress
but it can be slow.

CPU_1:
disables IRQs
trying to grab the tasklist_lock

CPU_2:
Sends an IPI to CPU_1
waits until the specified callback is executed on CPU_1

Since CPU_1 has disabled IRQs, serving an IPI and completion of callback
takes time until CPU_1 enables IRQs back.

Could you please post lock statistics for kernel compiling use case?
KASAN + patch is enough, IMO. This just to double check whether a
tasklist_lock is a problem or not.

Thanks!

--
Uladzislau Rezki

