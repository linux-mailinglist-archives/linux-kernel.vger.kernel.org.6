Return-Path: <linux-kernel+bounces-217159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98690AC50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BF5B29636
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB1957E8;
	Mon, 17 Jun 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I81JHSZN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0F194C7D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621634; cv=none; b=fsq0tIVvFTALaMN8tsDwCRy8vwvSR2HQljVlz7D/5AfTsCp3jfVZKo4x5G/AEbV1c7m5XS723XKnRDv9mWueM1kOanTNT0JfEjV89mabUysu8PwHXWXaQQrlPWOLV5qptZKCWhQd7m6iAI+FwowN9CdhBFO4P0PKCHKbVoa9kac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621634; c=relaxed/simple;
	bh=JYCJegv03aVOinmfYCBrn0PCCtg6iZCX2AzWfB8ydmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqt8e6vAilhOGk+Zdrwyu1jQAaYq5aH1RITHeLiB0oCVKi2rjMgU1iHVSMmU0pNQgboWfNLtF1YctJnHRBs4jJECxuCeCB/Gef2W6O91dCPOLKCpwK+zpsIIjwzDphrLfF/enmrgr7jusP+zCf/7KbOoo390FC6r4etuVNSrsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=I81JHSZN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-422df2a81f2so30808615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718621631; x=1719226431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI5abRBwHqCqP5M0Gc7e8iMgb9TjGPy4OKO84XUaFTk=;
        b=I81JHSZN4e8ixuP8C30qnT0wXpAkkBZzBAoSl++obt4WWGBNDziiRAL9m9Zalxk8X2
         3NqkB/Q40b5ZEp4KHNcX4gICiOEXsRJ1W0eyHvqCfZaPuWMsaSQDZZImqZXPNBmaG0Fj
         AQ7WJrNPCRhyCwByoY8hKhXxJJ6bUCEMZLAQMV/5CDc2Xi5BdCAyhEY8I2EXQeWNjlxU
         TP0bgNe4xmVfyvTt9nY2PpVJUJAzt9BxScrO/n3ThGNIOFNEjzwpcM/RsdAADcBqTAUO
         wYD3rdMStpv6oj96TBA7K8WoI7SclBUhP6ypWH9btDQukMel8mGF3dAVPTGXP0QyCjJX
         JLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718621631; x=1719226431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI5abRBwHqCqP5M0Gc7e8iMgb9TjGPy4OKO84XUaFTk=;
        b=udpxZpCWNjXt3nIj3O0c2I/Hx7QCFFEEZiijs86x3R7m9ZA4o5uVMd2OJjDYgJpFWZ
         D51/T/dvSdLEu4/etwglwhr6y/eJE1A9gmNYwGNXkxhfeYMSKJkFYTQuvvZh/fj85oOH
         t9RJ+h4GoYGLkxf3G06xFb3b14GgN0yCrLxILz6gsYl844kVjAHgmWWmrPgs02Hz6URo
         HU07qEs1EMYYTBTzSHMLAbWYPLvn/NZD5y4vrOCgYoPHMlD+QqWOjiNUolNxXfxMvOr1
         8uuUmGBxcOEpKugUCmpXZePs3NTaAldVfOlSEnxicewKtqfAK1J7og2NKue8c8qaut/C
         ulug==
X-Forwarded-Encrypted: i=1; AJvYcCUDyuZD8KRrjK6TrvTOmjMu442jcPhmPx2JnhhyglR0GdbYsjDed+RwcOuUQgjd5y7y6K8xMBvXju6eirgrnd6Te48xa5vhz9G7bjdh
X-Gm-Message-State: AOJu0YwNPyy7J5tnGOV/WsIia99uprAP1RRKOmAqY9yhKVoOa5xatWP2
	+gicX7xHbU83Wv4jljD86XvC5a3WN6hiI0kTO2j4mBhtJZUOwV9VCQ9gqXa5qQA=
X-Google-Smtp-Source: AGHT+IHfKnpLm8kd48ivVuHGuCzwntJbUFWu1qPeaSSxuCNbdaB2OudubZuHajH59m/HAAff8iX6DA==
X-Received: by 2002:a05:600c:4749:b0:422:fdae:b687 with SMTP id 5b1f17b1804b1-4230482bcf3mr84358475e9.17.1718621630391;
        Mon, 17 Jun 2024 03:53:50 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422ffdc329asm121452625e9.1.2024.06.17.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 03:53:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:53:48 +0100
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
Message-ID: <20240617105348.ebtony3ciwxhvj2w@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>

On 06/17/24 11:07, Vincent Guittot wrote:

> > And should effective_cpu_util() return a value higher than
> > get_actual_cpu_capacity()?
> 
> I don't think we should because we want to return the effective
> utilization not the actual compute capacity.
> Having an utilization of the cpu or group of cpus above the actual
> capacity or the original capacity mainly means that we will have to
> run longer
> 
> By capping the utilization we filter this information.
> 
> capacity orig = 800
> util_avg = 700
> 
> if we cap the capacity to 400 the cpu is expected to run twice longer
> for the same amount of work to be done

Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
min/max freq ratio) though?

We cap with arch_scale_capacity() still, I guess we know at this stage it is
100% wrong if we allow returning higher values?

