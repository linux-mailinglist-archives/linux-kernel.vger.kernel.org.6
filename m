Return-Path: <linux-kernel+bounces-219748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F290290D756
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AFEB26300
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8664C3C3;
	Tue, 18 Jun 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SGHubyGp"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611746B80
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724371; cv=none; b=YdK67wwhqDLK1p8lQvkUGnuAfVQrX9oqIygyAl3YpoN9vIWBY8IkYxQt5QdDHnL6Nqp/AsU5P6v+nG0FQ9fgvTN7rbepOchbMK+R/ksTk5QgoUgsF2NAusgQvj0E8heiEawCSFsBE8DjkfXQNrsnfqab+eJEc8aryBK901msDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724371; c=relaxed/simple;
	bh=cf72wR2tCKUhaqjXCy4NwLTF6wnlPcaNOvhD27SiT2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opKXDD63QJLC0Zx7I8ujignjDg2MCClt8eXqh7Wgm0N/G0ghZAucIgIkIN7EmQTWigkYHLbv2dgoogSJAHzSfbXGk0k81/7xX7cocdWEWlYk+SM8PygQE7clxjWVonU1C2RgalG2F+uH91Z7Jo9hPrx825G3lCyXkQyKHzsNdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SGHubyGp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso39639135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718724368; x=1719329168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/j/POhDw8j7BqHWHRDUXhgoGNwq6KDVynkRgrtyg/0=;
        b=SGHubyGp4qFhU5u2kMJeYoPinHdZm4PE9/yo0y3ASsajmfmoaze8d6oefPZk9XMkKh
         Qnu+D6WizqSK1J7614AV0LOIOVFI6Yabzbm21gzTsb0bZovn6tYBW4oNatGSxePep8dp
         D7+I+GaB7mlblVJR06YD7E1+kuzeUaeuVGg+ZGMR99fvbEiM/yIWIQGfsiskNp9o/E24
         YyY/G3d1RQbONXjMyB1EXb3Qg7figU3MVbT09vW9xniN1UZNgTHdTZjN9W8zOPsmr2sD
         yCTshJ5Oxsnlvegh9X6ryKT2F81+Twxx6eeWzV5QI2UrCFS6mWkidkrSuJ2AeCiozr2p
         6vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724368; x=1719329168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/j/POhDw8j7BqHWHRDUXhgoGNwq6KDVynkRgrtyg/0=;
        b=dSEaD3sz5uUybR28I65ScQWrwJifT77/Fz62kQK5MahDarzhoh83Izk2ueMD0nvM4Y
         Cf/XTjgIboBw5rqn4XXsfvZn3NECjjDm4LUXtQQtQTsBCGwpi1/oxEsXA0li+f1rIHHV
         HMHNAD7j5f/WPbJZoeIWwIq6pIqZUT1TGLfQrjV1vUfKdAnPqqixrraQrE/39+K63C1m
         OfRvbInnZblIonqrBfOpSJRemf7gWMf/LKqjjxBxfOHkJK52VqJe5TsfdNFBNjWf1GfE
         bfgrVE05LwBkTVcJDQce8cv3tI/Ba1J6FmD/ahjd1YlXHp09GwzxffgdWtMxBME8Q8Uy
         4Ifg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnAGfA8uBAjzHPzMPhPTw67w7H8jxnKA1+tqh9OirnYyGEyUGxQjRJ75oMYWr1VGtA2Ld9AuVVUnnNHOyVkwnGnLgRSOgSCxr9A/d
X-Gm-Message-State: AOJu0YztX0OYc3U9GHP/Ms3PLjSHMaMAbT5+3xJb6pXgN7Tp/Lve6dNw
	lzY55Mr6ZsrYU1KIAUvVUZl2AkEuOdRycHzU7th4MKU0qtPmdlFdQuQJFV7hFmA=
X-Google-Smtp-Source: AGHT+IHCRKG5T2/B5mI2eq9yMYlqQGqzZz4FlxfndTtd50NoESqajxtiYKT5NruA28W7apsbjEDvYQ==
X-Received: by 2002:a05:600c:4750:b0:422:8557:2ef9 with SMTP id 5b1f17b1804b1-42304848b1bmr117043815e9.30.1718724367846;
        Tue, 18 Jun 2024 08:26:07 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f61280f6sm191548175e9.27.2024.06.18.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:26:06 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240618152606.75wa7wuebojhp72s@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu>
 <CAKfTPtA191thPW4Yw2JpnToQjpAnNTw+oWacMShT9F_z6VrA=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA191thPW4Yw2JpnToQjpAnNTw+oWacMShT9F_z6VrA=g@mail.gmail.com>

On 06/18/24 17:20, Vincent Guittot wrote:

> > > Sorry, I miss the "fits_capacity() use capacity_of()", and without
> > > uclamp_max, the rd is over-utilized,
> > > and would not use feec().
> > > But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> > > SCHED_CAPACITY_SCALE,
> > > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > > return true, and the rd is not over-utilized.
> > > Is this setting intentional?
> >
> > Hmm. To a great extent yes. We didn't want to take all types of rq pressure
> > into account for uclamp_max. But this corner case could be debatable.
> 
> Shouldn't we use get_actual_cpu_capacity() instead of
> arch_scale_cpu_capacity() everywhere in util_fits_cpu().
> get_actual_cpu_capacity() appeared recently and there were discussion
> about using or not the thermal load_avg but everything is fixed now
> and  think that using get_actual_cpu_capacity() everywhere in
> util_fits_cpu( would make sense and cover the case reported by Xuewen
> just above

Yes agreed. I think we need both patches. Although we need to confirm that
uclamp_max is what is causing the situation Xuewen is seeing. Otherwise we have
a race somewhere that needs to be understood.

