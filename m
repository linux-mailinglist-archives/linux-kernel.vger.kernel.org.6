Return-Path: <linux-kernel+bounces-359519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0984998C92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA18282831
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD41CDA05;
	Thu, 10 Oct 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AQ5s48re"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7C42A8C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575976; cv=none; b=G0KdOoICyds2EubVS480qq1N99z2ZN7LGLTmJl+A7xiVPxrC2gkHLtdzZ38mIVR2bMT4itISXkbCStC9KryLYnXcTrlYrSwLo/YDYPZRhmyb6IEOFSkzNC8KK87/hIJGe4O9xHH8OYpVxfVtwV8fY5y1gM2avuzIRAhVm/wlq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575976; c=relaxed/simple;
	bh=PfZeNcFw1bT/pN+WBxONE28O+RahXMikU7YuitEDd84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJYNFYjhRaUEsZi9C6UeT0dShxa72PHNtSrbZtb9q5fHBMTVIBfIcyW+2pOWEScaWQBm05cAimLfCBGPlVMaF9nV4jXK0xa7ZMjFQFIG0HdvIU+YIaU3g8sa1sH3+K3m3vIBvgJilvNt2aMbKvEgcD0YWvm3SnWkCgMVtQs0tnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AQ5s48re; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e03f8ecef8so626341b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728575973; x=1729180773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeku9+EKhD0eyLZNLUrY1WzCvsvKi1BJ6gq9NUUHrtQ=;
        b=AQ5s48rekCCbw87iaHEPqcoXvyhDm9vluE6oNylcuF6w+wuBxJVKv56ryVuJkFKOa5
         ri9P2mcx05hSIH9qyyi92wKEmr6ZD21ffUSYSr+j0NtQhMirHt/IruIgViA8nYqTHJ6x
         32mpUl8ubnnI42uggIv3yr8QWFwAoYqcZGvmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575973; x=1729180773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeku9+EKhD0eyLZNLUrY1WzCvsvKi1BJ6gq9NUUHrtQ=;
        b=pIBjxH9uELPMWWFaFyJDD8INaznQ0jp7UVNVeJf+7Zjtk3vOV7GpuJVhAYCnjq9VLy
         s9BGGavVMAhn4ZRGNUGRttENwKeI6CINOYRNXVo1oX7d1CSrF9n9ms3TSumF9q+RCooz
         pmCRdWsiyjYR4Zjwd8wCLNOrp+LmeJGAD0BTgOM1l9mRo7B68QnQW7I42NNJhb8tFCLP
         dHdxlxoN782g2xPd8EL4hR9PWfOcLyqxNWEgq7ExHBMRJ5r6V3IZRE9Bk3M1Y+RXC+PA
         i6/5MnQqWlRMsYZyFjVh+UTzLoyGKvR2g1FiQy4iN0+h9ijefPc2RvVdq3Z5q2sd75xb
         I3IA==
X-Forwarded-Encrypted: i=1; AJvYcCUnNTyXm6OOMcMKZzaAzc0k/ZB4idwJuBLZyNmcVCK/YWWQ9EYfTN7mW4oNY1EmvBelpu0ZiPneEJJzBW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28snsM36ktE8LBo2/CWexMHZwy/9U/qJjkuAIOcbZYyRRhxxT
	c+2GaZooe8TjJu7WZ2YtwJMU/cN0bW5Mh6uscP+Jpo9II3l05fwWor8xjiNE46Y=
X-Google-Smtp-Source: AGHT+IEtL6WXGzPYuh+MnBkT5NJl2Cl0DdJhepAOU04VKXDoCawCLBlrMQZVO/pkGBZrqJMIhISK1A==
X-Received: by 2002:a05:6808:1918:b0:3d2:18c1:bf35 with SMTP id 5614622812f47-3e4d71beaddmr4147622b6e.33.1728575973406;
        Thu, 10 Oct 2024 08:59:33 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495d331sm1152526a12.60.2024.10.10.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:59:32 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:59:29 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 5/9] net: napi: Add napi_config
Message-ID: <Zwf54UVvfyx830sk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-6-jdamato@fastly.com>
 <CANn89iKytfwyax_d+7U8Xw-Wvj5z1d7xoi4LNhmUQphDiborDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKytfwyax_d+7U8Xw-Wvj5z1d7xoi4LNhmUQphDiborDQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:20:57AM +0200, Eric Dumazet wrote:
> On Wed, Oct 9, 2024 at 2:56 AM Joe Damato <jdamato@fastly.com> wrote:

[...]

> > +
> > +static void napi_hash_add_with_id(struct napi_struct *napi,
> > +                                 unsigned int napi_id)
> > +{
> > +       spin_lock(&napi_hash_lock);
> > +       __napi_hash_add_with_id(napi, napi_id);
> 
> Hmmm... there is no check if 'napi_id' is already used and hashed.
> 
> I would add
> 
> WARN_ON_ONCE(napi_by_id(napi_id));

Thanks for the careful review, Eric.

I agree that adding this is a good idea and I will do so for the v6.

Jakub: I hope that it's OK if I retain your Reviewed-by tag as the
change Eric suggested is a minor one?

If you'd prefer I drop your Reviewed-by from this one, please let me
know.

