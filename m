Return-Path: <linux-kernel+bounces-348848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5D98EC88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C41F223EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA414D456;
	Thu,  3 Oct 2024 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOmT5H4G"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119714D29D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949138; cv=none; b=L/F2t+wvLkC27xWic8UhFOdHVmvd9UNeMU9WiRTXQ8T1jKFDXeAg/tmbluLZP5Faulnrm3tz9FEJm00Ua0sRBqkMlg/pzI4vikX6hI58PXBkmgzPc15eJz77hsbRyaLy0ehSe3zbSEYe1zNZRAB5MGIwx/W8lbj4bGFxqpPO/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949138; c=relaxed/simple;
	bh=ZK23YV09G5NPnhMJsU2t6zsI91DapwC8NpJ+yBiMqKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnV0KvsVRpLcMPcvqolhU8d3KCsTf0Lr6ojvvlQ399mLvUukOEcUnewdl80knmBJcdOV662GLJXOof4r3ViUdtHyuo0J1BNN2NjUzl4glwdO1BlMXiBINW/chsuCp4a6DcKJ4gPqPDEk2mKveH/Rxqd2s1ro6aIfxOjffAPV8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOmT5H4G; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d24f98215so115766166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727949135; x=1728553935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=198000I1J4GZG3LQ4nrMVIGx7oFrEH8rZ5KRJ7ZtSTU=;
        b=HOmT5H4GYAQB8Nc3Wv5UhOcwMvONKHS6y3t9wdhpoQeJf5PrjHWxUcyitehGtLftO+
         aPgvDB1GmDulOmvh9n4WNQ1OqywJ3AEZJM0ouOWqXIyYsoNySRjefy2oPSheUCt93UoS
         /cs80IJtMxNWWEWlRPXbEOnE9B6K5RhNtTYV9H/rRktmeC/pd4dm+YjNDOX+taI7+GNt
         UNx9tybg9pcGSDdlxUokv8nlN1m/8YGgpUJNDTEHPp3T69FqHUQE+uqBEulZgY9J3I3B
         Uaju1fdgUz4GHnBMNDc3dQW7gX2Pm0rCPcpPxBbhM3HvDJ1/gEu56G6EMKId3ZS9vOSP
         5zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949135; x=1728553935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=198000I1J4GZG3LQ4nrMVIGx7oFrEH8rZ5KRJ7ZtSTU=;
        b=dTzh6vMxArePS/KSS+dI1KzVdXN3MQkxV/17+7UgQeLqiLtybZ3ZAtLVv2vfmV3Grp
         FLd/U5zSF2edJ0F5vZfRtIi1LQK9vgWPX2saIOkGOtYmMxozvpCBJEN9Gfr7nPcBw3NK
         Sb9RWsa8T1o0YZXrqHvzdAQeiKlAvMbJG9IRIej87ovDupbN4wfWtp0zxJl9iQstDokN
         x2MJbt9t9i18Y+8/+uNOlXeX1ttCRmipFFyc9JcLEBfsojl4QwYXG9XfvhDhbBNif1oM
         etcOOtqCBwt8df+h2qrCw1PlSLCtmtM9CgMqj21Dg4MHBj2D832h8fQgyKDMbHXeq7DU
         fsEA==
X-Forwarded-Encrypted: i=1; AJvYcCWnR9y2lm+ON2ytaLKQsbnY7SsS+d3IIvzQ8LoUUcT0vXVaNGqDRg97PRRuyT+mPCaxam5VCik4qi2ez+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZaPxjIhldWHXG4nmYMZu2j0B3t3ctY72AW0yHJMKZ19F/wRV
	dOC5mIoDRiKTLJKDwsZSCU7w1Pf1HvliWoa5zQmsumWjFyR/pvcZ5YxBeePnJw==
X-Google-Smtp-Source: AGHT+IEftv/Se2bfhfJELlrfHZCrJlTKEzUH35+9TLP/9p/XMuTeo0i+E4SjE/zliqO64y/ipRHYcQ==
X-Received: by 2002:a17:906:794c:b0:a90:b6e8:6919 with SMTP id a640c23a62f3a-a98f83615e1mr607022766b.48.1727949134451;
        Thu, 03 Oct 2024 02:52:14 -0700 (PDT)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910285a85sm62300966b.39.2024.10.03.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 02:52:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:52:09 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	qyousef@layalina.io, hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zv5pSdRsSsfRSNsJ@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
 <Zv5UDufqpoXvSocy@google.com>
 <CAKfTPtAmgi0QbtjqjJ_mzq6qat8ivd3vXXNYMiniDeKvLwujDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAmgi0QbtjqjJ_mzq6qat8ivd3vXXNYMiniDeKvLwujDQ@mail.gmail.com>

On Thursday 03 Oct 2024 at 10:57:55 (+0200), Vincent Guittot wrote:
> The current pelt algorithm track actual cpu utilization and can go
> above cpu capacity (but not above 1024) so a  task utilization can
> become bigger than a little cpu capacity

Right, the time invariance thing. So yes, I still think that a mix of
co-scheduling and task migrations (which is likely common in the
overcommitted state) will cause some CPUs to appear lightly utilized at
least transiently, hence tricking feec() into thinking it can help when
it really can't.

> As replied to Lukasz, if you want to discard utilization of a trask
> you need to check the previous cpu

Please help me out here because I'm still not quite sure what we're
talking about. Could you please expand a bit?

Thanks,
Quentin

