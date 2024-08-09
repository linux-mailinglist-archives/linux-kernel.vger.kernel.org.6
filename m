Return-Path: <linux-kernel+bounces-280258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95294C7C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3D8B22F05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D713C2FD;
	Fri,  9 Aug 2024 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SFia7mHQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C216944F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164444; cv=none; b=cjFKSGMtTTaKEr6DAJJ9y067OhUcQO3xM1DqXere0y1Ap0FmIMr2QHHWVndXNufDKfW5jRaKz4plg0I+Y8+0hFY8cjhTlD0Y0cG3zE66AkdHqP30p7C7a9er7vIhF33cx30VFibtle3z6Xv6oIrLcSvK3oHm3LspPyD1psWf7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164444; c=relaxed/simple;
	bh=fouKT50FVw7UqNe9uvc0/oPM1u+E42v2PZIZQUWhjKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew26W6v3pQTgV4HFN2yj8zSt0WlI0MjB4CWKxn+7dNKoA6v9J4KoQwyOiuInO+22WXXBtArWqlus8hkMnyYNhDBEp2IUmPqTAYdxSwGGpksMsH808PipMYpbJiI0/ZwrGz1z/l6YiqNpubvtJNTwdg7U3CsEjfJAtjiaeeGFznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SFia7mHQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368712acb8dso862865f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723164441; x=1723769241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxVq7d+6lXAdN7ZFIDGRdxH6RrI8kbrtYwFqEDODc8A=;
        b=SFia7mHQ1YUsT9TLtEnA6tC1C3rUdVnkcflV1JOa2jKWX3pu+UimyBXbsbRfVPv1uR
         O7ADGf4x8x9FvREGU5RKPNlQlLPIz7/sWbetzYb4Birg7Xh9BD/q72hDYdFuQ994AN6s
         qVLw8/SpkdfOEzVfb2sEmlFAdGcx7ppqM+2yUttGsceqLPyXAcd+hSo56VMZtGC0uoJO
         lAkytWWKGNWF1VtbGVGiYMVkGT0QMMpYlpL5uS64BV14pdEzuxMa+geojgJTmYkoCp15
         /XnT7lQguQNrxDs9LOuPOdKH6q090/VSdW7jlIoacHLV3nW0fzrgP9K4g4GHZ8aA3aVr
         KlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164441; x=1723769241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxVq7d+6lXAdN7ZFIDGRdxH6RrI8kbrtYwFqEDODc8A=;
        b=wtPKpRALt1rE0JoCqLcVKcZmrabITsscpiQgwo63IpX+1RB9KkV10LShbae2cPRUrV
         oAaKyx3eIyu/pDbqUHn+Q5OWJOEaSY2hcrX1pHGyKbQvPLc5T+66hGjzvIkNAgVq/16H
         5483z789ORfIvT4Bi4sWXnk9Hk3gLJFS5yaNDrkSrj7nlIx9qjJ0dCf2+kO9xqIS0pnb
         SqZN7SAf1R9/wjQF5lj6wgWbHe04JnrKrd4oHm4S82DFdcoEc7guqO7XALoNPZIgYdzS
         wRgtrzZ2oIt95y6tQ5w5wWcOsdO4ZsG7kwjv45D5sN6jgpCn5FpeyjuXDF9cJRZVzae3
         V4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU+zL7CXCZmlqD5RALukoZxcjc8aCsXc3DApoACP6zQ2OMeW5V9x5MOF83+vrfRbzhmznC8A/Aid2D8f0LMrb6VfqfDAtgXEyBXj3bq
X-Gm-Message-State: AOJu0YzwmwibxjfIko91VEkmLu0eIzLv+PcDAMtGQgZyO2PfTRnKWqKL
	jD46Ba4UTSzWQIE/+9T2cHEoTAOhtFllfJxtWNASHXzwYwec/f1UPR9X8V6TEbw=
X-Google-Smtp-Source: AGHT+IG02JlKzPETdcPuJPuSgKYXAOpTJiQ4atbv3qc1eTce1EJoHA2HclbW28PrRP/jDb8I8nRh5Q==
X-Received: by 2002:a05:6000:1f85:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36d273cfcf9mr3084838f8f.7.1723164441070;
        Thu, 08 Aug 2024 17:47:21 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156d99sm3578981f8f.23.2024.08.08.17.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:47:20 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:47:19 +0100
From: Qais Yousef <qyousef@layalina.io>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240809004719.yuxvge3n3gnqziyz@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
 <aabce4b6-2d3d-45a9-8f75-b1a6b3ede6f3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aabce4b6-2d3d-45a9-8f75-b1a6b3ede6f3@quicinc.com>

On 08/05/24 22:54, MANISH PANDEY wrote:

> > > If no matching is required, it makes sense to set rq_affinity to 0. When
> > > matching is enabled, we need to rely on per-task iowait boost to help the
> > > requester to run at a bigger CPU, and naturally the completion will follow when
> > > rq_affinity=1. If the requester doesn't need the big perf, but the irq
> > > triggered on a bigger core, I struggle to understand why it is good for
> > > completion to run on bigger core without the requester also being on a similar
> > > bigger core to truly maximize perf.
> > 
> Not all the SoCs implements L3 as shared LLC. There are SoCs with L2 as LLC
> and not shared among all CPU clusters. So in this case, if we use rq=0, this
> would force to use a CPU, which doesn't shares L2 cache.
> Say in a system cpu[0-5] shares L2 as LLC and cpu[6-7] shares L2 as LLC,
> then any request from CPU[0-5] / CPU[6-7] would force to serve IRQ on CPUs
> which actually doesn't shares cache, would would result low performance.

For these systems rq_affinity=1 is what you want? the rq_affinity is not
supposed to be one size fits all. We wouldn't have different rq_affinity values
if one is supposed to work on all systems.

