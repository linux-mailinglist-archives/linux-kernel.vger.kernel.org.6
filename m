Return-Path: <linux-kernel+bounces-523801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F71A3DB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F103B701C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546B1FAC37;
	Thu, 20 Feb 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnkCLemb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675E1F9A89
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058514; cv=none; b=qy1/ewp112O4ZFv6hTcbYWyYzpTYj0ukwwqahQYX30b0eh/eLNumI0NCkSYKG0QWPzS2wsbsCzIm6EOCI960fgpoiXML73IKe7PZpgsMemMN6QcC6+b0rCO/u6V9CFZvKl4vlA7XZJns4gwjqgV88aVtyS12Y5maKuNls5QLWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058514; c=relaxed/simple;
	bh=iGKWw/Jp4O684XPqBZY1NaijUqt9X1Q6WqX7oXpfDb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO0dwX6wV4bU0Dt/tvukVdwT6q+pkcIfusBBty/AVniy15OwQRHt35Mh0JCmug4/YZv6ptDj6atNWJT/zYjZfFt9tEIr1rrZy/v/PswEUJUxXFLG1P6WEOjWVk5vnNP78aaXFNp6pYuBrs8iptDZ7R5xHaMcj4t1rPPN3d8dD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnkCLemb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO4PcIViHdQyavVvLMrj/YEPUa21Ec0ETgqyOGCH4Ok=;
	b=NnkCLembgdFN/Vs91GyNeQZM1TrtcAFLSvTOTr97wWWUP4xJ2hxgiI4Wi4z/LJ+U0E1BN0
	ztia0U2OA+ytZ8PUr9qJMbvKaEAW3eKcdlIR1Hdh9pIH5hiOqmuluhLJ2e5jtl7wMtgky0
	9aUOsY1yBhWUbBPtPVwuV6NsVIn0kY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-l1fH8ZFzNKazDmArjTKpBg-1; Thu, 20 Feb 2025 08:35:10 -0500
X-MC-Unique: l1fH8ZFzNKazDmArjTKpBg-1
X-Mimecast-MFC-AGG-ID: l1fH8ZFzNKazDmArjTKpBg_1740058509
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439a0e28cfaso4744795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058509; x=1740663309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO4PcIViHdQyavVvLMrj/YEPUa21Ec0ETgqyOGCH4Ok=;
        b=B3hNJDGEMQMy5KrOueIIdp42LNuyYcBQe/R2hiJzYfLPQFy5+v/u/i1QOebq6hZRpJ
         oLQUCMIHXfYFoEYTAw5+Aqs0docg9JfeD8145Jiw76WHH/e2fH6IEtColCwnUJnxMLWo
         qqZzo1+jJLFtxBIq0clYRr37lJqYLblQRz4Y9Fww8DjeSXPezUFgdGgbHhR7rjVWbvoj
         tZE9hvWxOYUTl868eW/FXot/w05WtiEXpHIkN0zdjtQPRNg9DuCfrkZrh851FdYlkc/h
         /UoD8gk+S5XEs9UyTFfHH4OeCgXuts4yVNnAwDrqooIcwnLfnDL494OGtvUEbYbe5JhW
         id7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH+EA1P6Jdp/+5V3L8zyuBwmLOHgoUO0bitPVy4CWmFv4rFgSQ+u4EKSZSQBUjNkqIubAWygNww4n8cYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NmoSTE9tbX8NJvpCkJUuq8VLtOwt/2ERcpzqVzdyPrRaAWf7
	3Yd0u/Nacl9fvR08TNJ+VZhZS5VAj0QYFO8ZP0WtUqrOkv2X4qA1ViWKMQBvakrcIAxZh0ujN7A
	lDb+qaLPNi3UsUUuoyu/HFzx+o71gHHowWBao6Dit/AuChwPoxfJlVQeFyZBORw==
X-Gm-Gg: ASbGncvcRRjvxMaDbm3Ot8DG/nbFr6dRaKthuhJBlDMRkqi4yIRgDpQCX7jXqR1YyJK
	HCdLg7/voFGsUtS0ykLbnl1EQgqyn5gkpKNnVkoNuGpDndhL5pAAMRqJJiRhN7/RDwuDXpCM5PM
	e87NXW8bjkgKiflcWGDoGZnnCQHjlq8NHVFLTC0hwwxKswbRUHV73xDe6ATHEZ99MWzV5QREkXv
	xy8jii+UGGV/IDMaUx8e0w+1DhL7seL7Vux9YVaAWDqHvV0FRIj+R7GZdvUezKmDdjFubVd7tWy
	OyGnq2lRSXHoGdR02P4IaYAdiqiJPUVn4A==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr147810125e9.30.1740058508986;
        Thu, 20 Feb 2025 05:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq8bu/kLsT2fhzC3KUiwBKiCUw4IFM7M43h2RvM8MW10I7TQr2gnV6PTyti5sh8uc3WT6aCA==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr147809865e9.30.1740058508620;
        Thu, 20 Feb 2025 05:35:08 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8e62sm20757009f8f.71.2025.02.20.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:35:07 -0800 (PST)
Date: Thu, 20 Feb 2025 14:35:05 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux warns `sched: DL replenish lagged too much`
Message-ID: <Z7cvifR-y0CWK1e6@jlelli-thinkpadt14gen4.remote.csb>
References: <6ebe1130-0143-4388-9d69-ead0bf1fddf9@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ebe1130-0143-4388-9d69-ead0bf1fddf9@molgen.mpg.de>

Dear Paul,

On 20/02/25 11:47, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 with Linux
> 6.14.0-rc3-00060-g6537cfb395f3, waking it up from ACPI S3 with an LMP USB-C
> mini dock connected, that had an Ethernet cable and a power adapter plugged
> in, everything was lagging, and also the video in the opened Firefox Nightly
> browser lagged quite a bit. This has happened in the past, but not that bad
> and long. Today for the first time, Linux logged the warning below:
> 
>     sched: DL replenish lagged too much
> 
> (This is from `kernel/sched/deadline.c`.)
> 
> I have no idea, if it’s related to the hardware itself, that causes it to
> lag, that a suspend/resume cycle fixes, or if it’s related to the USB-C
> controller that has bugs in that early generation, or if it’s related to
> GNOME/Mutter (*mutter-common* 48~beta-3) or Firefox or the Web video player
> used by the site.
> 
> As often the case with this, I have no way to reliably reproduce it, and in
> this case to reproduce the warning. I can only say, that this warning has
> not been logged in the available log files since September 2024. Linux
> “6.11-rc0” was used then. Please find the log messages attached.
> 
> In case this information is not useful, should this happen again, it’d be
> great if you could suggest what and how I should collect debugging
> information next time.

Assuming no explicit usage of SCHED_DEADLINE, I would say the warning
message might be related to the recently introduced deadline servers:
5f6bd380c7bd ("sched/rt: Remove default bandwidth control") and related
commits.

They were merged in v6.12 (IIRC), though, so I would expect you had
noticed already before if they introduced issues on your setup? That
said, it might also be the case that something else changed more
recently that now triggers a corner case.

The warning message per-se it's not fatal, it just warns that the kernel
is recovering from an unexpected situation. Did you notice that things
went back to normal (no lag from a user perspective) right after that
message was printed?

Thanks,
Juri


