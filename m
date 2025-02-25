Return-Path: <linux-kernel+bounces-532693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC67A4510D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059013A9285
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914123A98C;
	Tue, 25 Feb 2025 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Iv1V3kpe"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC42153FE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527712; cv=none; b=VgmGDzdUciRLNEPha+o7GCNnhEioE2getPiUgutA/VOuoB5Z1HrxmewbihBUzup/pVRmR8LVhvV8oSoAWChdcVFIaRzfkaX7kGOx5nu3so5gvludmGmrX8WBGCYTCbFxul+syodYklh8WV7U7P2/7u6h5WkQRUwmnL24/g3r1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527712; c=relaxed/simple;
	bh=sSju0BgS5fdbP5bJXxnI1mhD392jojs14xjCr3USU/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnmlT71S7TbwiXKk4JSrvYigPfgrdtsgrVbpStAc9SM9V0+QDTtquGGYu/WDij9C8edbSgOoWGdfmB4CpoZqADP4/kgtviJrmx4Q4HMT7cBc5JFBMhjrUSGw02ISCJ+aM3Dj4RvcPQAiCyd94G3WpX7XHR47BbM/S+hWorCOESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Iv1V3kpe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0818add57so634241985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740527710; x=1741132510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5dMDjXKxu+T2AG0RdE1FsQr1C+kvYp4sA7RFoC2U8Q=;
        b=Iv1V3kpePGOsVJPR7iZTZrUFxHJ2K2LyvzWbKGW5ufieDLZfh7Nu4Z2E/LW6E5qVvy
         NYlSFeYNl3FyZS/k70vXLG0xzN5i2Z5GOa6Rcmpr0lu8fXkNstVG3U2/SK3U1y88FhDL
         eEfHi/hdcqNJMF/tpPVafnNQSh4tPJnfHxsnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740527710; x=1741132510;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5dMDjXKxu+T2AG0RdE1FsQr1C+kvYp4sA7RFoC2U8Q=;
        b=YxEDD6Ee4FOINFUJ0leyttaNjLZRyW4Tym7U1DrcHCul8nARHrBViORLwVzVUb/62f
         3A4tuO5wPLyc33u4GjvBieCKZNFwCCzaFiUniRXYiMFDCEpqJWeuewpfcwV8mxiW3Zq/
         8QhNv4kANwsz9JaD8vKo3PgBOtDGM19lj2a7APlbXouSy3Du7ARNHGzONcBaAyRS6iQS
         cHbDUyjFgWoArHHL/98NhHz8xuLIL8FrREaBFXgf32wMje7fW6hXng3rZ0WGgtCavxV1
         A4GOgzyFRbPs/pAB5QNYxEyOK1aERrYAoJrMLnMm5UfEHBc0coGoskdVQ8wVQN9qZbwn
         cTgg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKvHVciQuMZx3a7ehojaMZ4o+4uSIWfG8DeiSM9NrcZvLTYiiGswuo4U3hpFu0ZoO77ICzZTyr9Ijed0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdfCmiGHDnFaajgxn5cB1vKjXwbTKp/VQUhgCR+BJKnm7Etsi
	SrTHQP/IUaVDhMHbnYf5bGQqyTOAKya8Fn6xN0DW7s36BeEH+6wh9WMgzWU0pyM=
X-Gm-Gg: ASbGncvj6L9aeYLI1FnWsk4EVK/Z9q88hBHtUKIXjxqLB6Ysc9bhDzScWniz9eNyXTT
	suKrpK8Sk8lzpTfE3p47l+219Ze39r4CMaLwdG17FYjVMJHqEddVknjRIJrMhBLbw++NWm9yUUW
	dvae0KAAkwjVCgpyU7Gg9dlcQzAzRVQI6pUv1H/ZB4LzFMU/+O/LqvLGbrq85uS3X5XuGsX3gc0
	YjVta2DYQpK9MSFxTTw1+5E+Sg22XhEIXtoAFx2/dF85MVlaHb1rE5dZFTtPpJ5bWx0R5oM5kLt
	qIdMPHPrzObrmlTe2rPDClsuJZomBKDsDhtZhzHELZ+rbbMNoey7+XrHOWrPFKvC
X-Google-Smtp-Source: AGHT+IEQKPLVcj2d7UodbbPtUnNi2hKgmOPHZLs2IO/LLKJ0Sxi9MIUzhinnLH5GAtqXty/lewDjdg==
X-Received: by 2002:ad4:5aa8:0:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6e6b01d78ddmr267840586d6.42.1740527709979;
        Tue, 25 Feb 2025 15:55:09 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b08857asm15479706d6.49.2025.02.25.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:55:09 -0800 (PST)
Date: Tue, 25 Feb 2025 18:55:06 -0500
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: Check if combined-count exists
Message-ID: <Z75YWvDcvzsMlVHK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225181455.224309-1-jdamato@fastly.com>
 <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>

On Tue, Feb 25, 2025 at 03:11:24PM -0800, David Wei wrote:
> On 2025-02-25 10:14, Joe Damato wrote:
[...]
> > diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> > index 38303da957ee..baa8845d9f64 100755
> > --- a/tools/testing/selftests/drivers/net/queues.py
> > +++ b/tools/testing/selftests/drivers/net/queues.py
> > @@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
> >  
> >      netnl = EthtoolFamily()
> >      channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > -    if channels['combined-count'] == 0:
> > -        rx_type = 'rx'
> > +    if 'combined-count' in channels:
> > +        if channels['combined-count'] == 0:
> > +            rx_type = 'rx'
> > +        else:
> > +            rx_type = 'combined'
> >      else:
> > -        rx_type = 'combined'
> > +        rx_type = 'rx'
> 
> Logic is good but minor nit in reducing nestiness:
> 
> rx_type = 'rx'
> if channels.get('combined-count', 0) > 0:
> 	rx_type = 'combined'

Thanks; will fix in the v2.

---
pw-bot: cr

