Return-Path: <linux-kernel+bounces-445029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771139F1014
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AD02842F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A161E570B;
	Fri, 13 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2Dd3GJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956781E2843
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101862; cv=none; b=bONgF8T7TNbx1Lp6fYZ0lIGHAJCe6v3/tu4tuUMoGFtfJlgGtl/H1vVdnOVRUjlvYkDLEftpg+SqdFxG3iPqOxgViJ0E/VPxyqcBTGuSU5Lveh3Rp3KPz+th9fi+N/kY58gdS4sNPJgy8oHaF/tfjg0pLL4Wh0UraNBHL9Dz1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101862; c=relaxed/simple;
	bh=lrh7m0lFZHJvmErfOP+qhjC3hXEdqN8L3UwU5ksc/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK3J8xG0DGYLCJKoZN2xjjph53pTK0ny4Prb2tw/Hf0navEox6eS2q2/sq6LPMafIeLYaNpAvtEq9Dw49w4GNJJQaHttvbQqtLCLcVL4KYPp0a9BDN62FErAxvrVtQ/Lsmyz8IdwG6MmUkYRJkz6RcWLeKHU7BevWwB16TDyLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2Dd3GJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734101858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2tfhKUbIcOYUrk0xuJCPYYt5LLC03zn1Q0XJSOfGSs=;
	b=D2Dd3GJQp2xDnjdvTn6om9h1xPsJqJMcnEH3zrbLMhFqfRpDZ+c7pD9WkC6Zj8hn71ESvr
	hADm8EIjHHwzWsrH/uAkeE9/FsqdLxx5IK7HS6+V4SaVG0sm9Sg36jAP2qXm8nyZcIAwG8
	K8j721WnrQgLo2Et3+CXFYgDcbzO00M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-MqVWHY9rPAq7-_-gd4dA8w-1; Fri, 13 Dec 2024 09:57:35 -0500
X-MC-Unique: MqVWHY9rPAq7-_-gd4dA8w-1
X-Mimecast-MFC-AGG-ID: MqVWHY9rPAq7-_-gd4dA8w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so11044555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101854; x=1734706654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2tfhKUbIcOYUrk0xuJCPYYt5LLC03zn1Q0XJSOfGSs=;
        b=Zu67ZIjpFrvWJMD4VKipTlAqe8xQgauwR7d7sUBsTvcN8B5gK3alhzHu0xRf5hboDH
         jcHJZWhmf7FBHkVPNh1JA0LL50nD+a5FseP9ypLTaH+tcCsSpxHBoKxliWe1Q6rxcPcC
         OKq+WEGhPLdlyhhwEFi3F4jFfedQz8AcgoJA5fxvkhxufP5UrVck/d+ftmaUkSHTquP1
         6g/D5pSsajy1+EMGUqSyry9QD2z9EiUNIpWyEdHaJIKkEGbmNqHsrHeOCmF4P3eeMZXV
         90N6aw6ZS2brQ6L9//X3oCdLHQA//y3NSrE4mjOfUpYlk+9P/w4OlDjVonVWfPwVGUdI
         JwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj3Enw9wsYKQsgf3rf0c4NnMPp9kJrlCdq2j7cuFh47c2QiJ/TZwi/+WLaG2qCvIkEpN8bs7+NortGRbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSC4wrxYD/bc1a6T+nwC/udIBzc7VsaehySChjMdyMHcZbxW9
	2HaSn+qEwVLMRiwWvstVvs6FEd26if7sxFh21mnbkdMhpmEjR+T5DLNSPnwhcw3es29z/qsv+Zg
	lqcLovmUfx0DO0LCAmwGA/UArUOxUNfObXz9FFN/o4Ciy0ScZj73UU5IqRZSvHQ==
X-Gm-Gg: ASbGncus8tReR3nvH77WQCMLMsoiNm99IsjM3XJU4BpqhIQNvSwh9f7GL3PsXuvi3MH
	BSDwGteErvu48qYch0FGvo7vUxWCZjdwtEPP10vAu8NXmC46KZV9fiSV7p/lHyoenWYwEQ8fKL2
	iK+wRR8azFhMQGB7dC8tVxUWMyDDhACq6SYdktVGwGzkK2iXuKr1vWXJ3whqbKcSQp/sT2Br8Tf
	1oeAKQy2kvBpg5AWP7XTRvTndRhiwk5qywKO+Y+jEpnKjNtf1Ur5W1MCZWweb9+yvRpH+iKVMJj
	Y4nB6G73Vj+IlHKcSb4PbXoXIDopIo7EZ18TeMvJ390=
X-Received: by 2002:a5d:64eb:0:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-3888e0b84c9mr1774252f8f.47.1734101853843;
        Fri, 13 Dec 2024 06:57:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTMz3HW7eTVstHUaz5OcXKBl8XXEsV7siwbGA1VkR83AwBxBhNp9Z4CNB/JxySD245uHdfjQ==
X-Received: by 2002:a5d:64eb:0:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-3888e0b84c9mr1774235f8f.47.1734101853538;
        Fri, 13 Dec 2024 06:57:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-197-226.as13285.net. [80.47.197.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a5085sm7303896f8f.38.2024.12.13.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:57:33 -0800 (PST)
Date: Fri, 13 Dec 2024 14:57:31 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>, shraash@google.com,
	marcel.ziswiler@codethink.co.uk, i.maximets@ovn.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/dlserver: flag to represent active status of
 dlserver
Message-ID: <Z1xLW1_URkdWdjwG@jlelli-thinkpadt14gen4.remote.csb>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
 <20241213125147.GC35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213125147.GC35539@noisy.programming.kicks-ass.net>

On 13/12/24 13:51, Peter Zijlstra wrote:
> 
> 
> Thanks, I've invented a Fixes tag for them and stuck them in
> queue/sched/urgent for the robot (although I don't expect many
> complaints from it).
> 
> I'll graduate them to tip/sched/urgent if nothing comes up.
> 

Thanks a lot Peter and Vineeth for working on this! The changes look
good to me so feel free to also add my

Acked-by: Juri Lelli <juri.lelli@redhat.com>

At our end, Tomas should be testing them as we speak.

Best,
Juri


