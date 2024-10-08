Return-Path: <linux-kernel+bounces-355979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9C995A13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F068F1C2108E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A95216440;
	Tue,  8 Oct 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="G4vtp/9X"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D30215039
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426487; cv=none; b=BggiuMJ7hfWHbE5AxAlgtvU9Rd4W/RfvL9Gyn68KTU4xH0amBtMuprXKrsUyJk0Wvd2hofo1FZyejSvRJE7w+hEEuLRNer+IBbgehVnUKSbCQFcJek5AKcVYiLjGp+vaAyRcpY6KNLYTXqvEILPmUdiaAI+LrBEyQgZyT/AwWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426487; c=relaxed/simple;
	bh=PeQ+3ZqZao8FTskqbH9VfwLkZaZ1/LLm/N0vThJthsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xawjsgm+KREBLU8nGMjCE/OKyglTtxmLauqZcqcCjweaJ7y0pjC12AMRoy9hXtdOI49LyUR8n5+et3rpHRja2FIK6m5126n5I9pRxtxhJt23Yk/qX3w207jft92ofWXT2TnSgi/OUgwvx1qAQANdkblntEo+xmMVo8lCyV7o4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=G4vtp/9X; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so819704a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728426485; x=1729031285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GpPyK5gRQWrst+Fyr+Lsx8V+lp2jzKPbwoFf+V+Wos=;
        b=G4vtp/9XxuXOyk84EUhUcPlEV5RmXOskkza4Mx0E/x+ObEIANVfRH2EzsGCbQZpIt9
         Bub+bhikT1AvbLSWiGU8v3nE3iL8a7/DiDb1fyoBmSs6nPBVaIYKB4A/+NGaF8foZW6W
         MuSkcJTkpD5lYufFmFK8vMMSZkH8ZjDC+9GXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728426485; x=1729031285;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GpPyK5gRQWrst+Fyr+Lsx8V+lp2jzKPbwoFf+V+Wos=;
        b=P0U7U/ncJr2TvSxibYB1KaM/pRToXqB4nhDC37bb5zB77tMt1iCt7lJJbg5n9ndilP
         ljtt34m9KWZmRidNMqHwNxQtsKk/PtjFMqipBiZY5UfvghhHuoONluCp67I8BdSbEhCm
         KYIWnTSxsxF4rgfLQCd1081K3DNa8fV0eo0JBcyki2xQQkgUecYtx/SeiwMH1JVCtKkK
         cEH5tn9o9vt+2iwnsxs3DP+Y0QtHm3pQUPwE/iSBL3ZzaJMXf5/f2/BNFjaP1bc1/FPk
         /GjWpIldvAYoWukf+iAHfCpRqRl3bVhshdwh2iTX86w3gogcFxYL2s3IsutGPLE9P+cT
         X7+g==
X-Forwarded-Encrypted: i=1; AJvYcCWfji8Pp0V/Zhx5Pi26pItH9XZrYY0zo5lz4wmHuMm705Q0POtffhZlXYxZtRmHZdt5P9XGOs2TC4F5rc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktcjIo5iXuxZuoiL5ykfjApCIxBz6YZyLISYq5CPu2dAvRwFX
	9HlR5MecImErXzMncUpp07N8plUsoaHVvNEsqjGGwW2hGjbqFr3RuigWicdafWg=
X-Google-Smtp-Source: AGHT+IE1tXuqOdJ2//PwSHKA9ssLoCKqnAz9+E7C6N37yGYWDeMO+zE60t4b/4luCg6NBXDD2oLj/g==
X-Received: by 2002:a17:90a:db07:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e2a22e6e31mr558509a91.4.1728426485495;
        Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a32e1sm59872155ad.296.2024.10.08.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:28:01 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 5/9] net: napi: Add napi_config
Message-ID: <ZwWx8V1kQBDLFT6i@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-6-jdamato@fastly.com>
 <20241008151701.6f8bb389@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008151701.6f8bb389@kernel.org>

On Tue, Oct 08, 2024 at 03:17:01PM -0700, Jakub Kicinski wrote:
> On Tue,  1 Oct 2024 23:52:36 +0000 Joe Damato wrote:
> >  static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
> >  					      u32 defer)
> >  {
> > +	unsigned int count = max(netdev->num_rx_queues,
> > +				 netdev->num_tx_queues);
> >  	struct napi_struct *napi;
> > +	int i;
> >  
> >  	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
> >  	list_for_each_entry(napi, &netdev->napi_list, dev_list)
> >  		napi_set_defer_hard_irqs(napi, defer);
> > +
> > +	if (netdev->napi_config)
> 
> Could this ever be NULL ?

Ah, good catch. I think this was an artifact from a previous
revision where it could have been. But, I'll double check.

In the current proposed implementation, however, I don't think it
can be NULL as it is always allocated.

