Return-Path: <linux-kernel+bounces-219742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D090D729
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04DD1C257A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F422F11;
	Tue, 18 Jun 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMMVX+eZ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5F208DA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724242; cv=none; b=eeNkj5FylMoSbUGnGEIN6ppYu+9G4CpZGxS8rUEyOPkFOo5RDyhWakvmK3pWbwz1bqjnbN6rE67wAGrOgHaleukuDOtK2V/WfJ8O8PRiHXCA4q/NPeufVoadyaN2uaaT90tlu6d/ou9IvKoe9YW57qSA+swS8pvcVwXk6xfBxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724242; c=relaxed/simple;
	bh=yibzxZqYHodym8sXR0Vzp2MIh1p5lukJY/SWWCHv/g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMD2mEgsfocRFzAesKbixhlluLbh2URg9TxoENT44g/DBK7qLSXYpl91mRj03gUfJUH4nQ3zndk3x+w+EqAX7iR+wQuCgHhbhNgCSqwGKZDMOmhMZh+8zqoS6Qggal8sTT1yT8c6kjdQZPZZ0FEOWyjLBPokaEcHOYnL8NRKLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMMVX+eZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c3050f4c50so4390830a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718724240; x=1719329040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yibzxZqYHodym8sXR0Vzp2MIh1p5lukJY/SWWCHv/g8=;
        b=wMMVX+eZW1z/zcyRVZ+dJjDsfh0D0it5CJC5e8AxOYRIt9+oBNeuKy9BjxSgy+1gqX
         yXOHg2wHrmYETwF46XvvHnQIU5P/UCwi9nOyE8XUUjXcr+D+Tv8hgXyAsiJdDMdIMb0E
         j6/cahJuY+VDEdw2BUt2pbm8V+O0nHlD5b4Of1km8Zc4bRGtC21ZH2ZEtXWH7nn7XHh/
         W94/tkDhUK2zcxg80RaYxybfxb6mQz2bZqXyy22rfecgDv/9YEnQs+NHHDnUaaYHQyGs
         IT3PBkOAFbJcAHeckR2l96lZztaRAPVPV/UB8UJt3/VuUCA10iFf8HzTNdMeSk73josL
         ebzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724240; x=1719329040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yibzxZqYHodym8sXR0Vzp2MIh1p5lukJY/SWWCHv/g8=;
        b=GHUiQ6W/hgPUXavTUf3MqrZaIZy3iBcqA15VsDuXCPDWWOSkTHoFiUHEyjCQZuS9yn
         c6QNksXNWn/oSW/GU4wm4OfPTKgiUvTszSbdoXvG4WoGxgvWLtlcy3wIFHclav4h8Wdr
         g9Jx1mHprNJyENO5rzXRe6Lq2rqhZ2W8CtM7znzKxJTlu2NmWLJoHe3sU5vMRMuP5eHr
         oOwDhEBq8lHg+NGczZ3tbAUsoMP9Kqih85FiX2WWb1f1Xboqn8W9mM5bjkwz0CK895QV
         w9VfipNDRFeXzmse/qnI1R7E6waWEyYVhHjaKUFqUM6vzjDqDl3SsFp4LS2uMtb+B52N
         QJig==
X-Forwarded-Encrypted: i=1; AJvYcCV67v3Ao9O8tL5OKmadujQNm7CRbhh53RGimdUYIQuPQD8Q+i7HZ/mDFOMeNDAfxxS2fi+C0kalH6jSsWeiIntCmtX/tULvVSVNblL4
X-Gm-Message-State: AOJu0YwpXYorLHBP44udmlj3vUcr9KCs4jyTEe0IzFMVlgZYZX10b4Er
	jC3ueTX+tejlcAcaG9SGSoLZ3mfO88opIbuWe+3wvFY3YsktJM7aO601XCpFDZZl/0QCdFwltum
	5xG+oMrmckO59V+bs6IBdMsju8LrVEoD4oP/Ojw==
X-Google-Smtp-Source: AGHT+IGYFxcARNsjA8bcaXtjEm6tJiEujAfiK4nrO31jZxBv9nnkIyeR7E6natOmhucaLIF+Kvu+9NoTSch78tc4AEE=
X-Received: by 2002:a17:90b:3697:b0:2c4:aab1:e435 with SMTP id
 98e67ed59e1d1-2c7b5d8e663mr7215a91.44.1718724240490; Tue, 18 Jun 2024
 08:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
In-Reply-To: <20240617105348.ebtony3ciwxhvj2w@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 18 Jun 2024 17:23:49 +0200
Message-ID: <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/17/24 11:07, Vincent Guittot wrote:
>
> > > And should effective_cpu_util() return a value higher than
> > > get_actual_cpu_capacity()?
> >
> > I don't think we should because we want to return the effective
> > utilization not the actual compute capacity.
> > Having an utilization of the cpu or group of cpus above the actual
> > capacity or the original capacity mainly means that we will have to
> > run longer
> >
> > By capping the utilization we filter this information.
> >
> > capacity orig = 800
> > util_avg = 700
> >
> > if we cap the capacity to 400 the cpu is expected to run twice longer
> > for the same amount of work to be done
>
> Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> min/max freq ratio) though?
>
> We cap with arch_scale_capacity() still, I guess we know at this stage it is
> 100% wrong if we allow returning higher values?

I think that capping utilization to max capacity generates some energy
estimation error because it filters the fact that we run longer in
some cases.

