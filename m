Return-Path: <linux-kernel+bounces-433452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE979E588D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADE916B61D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088821A425;
	Thu,  5 Dec 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHU5tGVm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC4217735
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409235; cv=none; b=HtPDpy1iW6p26W2TgLWdOHhtFP/EGuTgZ4kECTENatwwoefeqtCqBQ781Uz569VamrRzBgUz756uHxOPW2F8yuMZ4Avxcxrt8bMmRxWueHXcJH+VWdCTy3uWxw8Q4kb2l6wwwNzI9tvvFLS8vWp3O4ubkAF9QWX9/Dee4SrZXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409235; c=relaxed/simple;
	bh=Jir3FCnl+lGf2P0N/mk9HvX/Ubt1jFBrjXpyS2UCHdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de/R8pwnqFI0lfBl8tXgUl5PH+dlBBfmRnYSlCSh2vIEWdRAT2EpQq2hWKLbH1sNqL2PObts9S2nAHVWvDjnMzlh0dwZFt8X887lcvUz64vz5/zN4U/OLAU5Q4aMpbAuVaES84bUj7A7MBZYIxEZzakW5J2tqZqsrrs69A7pxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHU5tGVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733409232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jir3FCnl+lGf2P0N/mk9HvX/Ubt1jFBrjXpyS2UCHdM=;
	b=CHU5tGVmrtk+8y3JtN1mYeesBp8L04SSCzdxzkVMpLOcwfHlk5O7eZjkth6pw4v8TCPP2r
	nYY3hSTiG0CRV7KgEB5/84AjBxfxHt7YAd1s8sNjVSRkS8kA0RjRzQtamQP3F6Ucg0xQzn
	+s9mklZ0jiwJ0965hvvuKlwdkknu/+4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-cxOTIX_fO9SN1eGzOG0yVg-1; Thu, 05 Dec 2024 09:33:51 -0500
X-MC-Unique: cxOTIX_fO9SN1eGzOG0yVg-1
X-Mimecast-MFC-AGG-ID: cxOTIX_fO9SN1eGzOG0yVg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ed79291eso1104654f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 06:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409230; x=1734014030;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jir3FCnl+lGf2P0N/mk9HvX/Ubt1jFBrjXpyS2UCHdM=;
        b=Qv+JN+IrJoUt3cyIYY4WNZPiGpTgjSAmUeNrwf7WRfIli6+XWv25nMLzj8+ytqfNnm
         o2CAgXX29AOpyJr+2wAmig7ydoCGczPhcojVwj8ZDFhfiju53MMTbBm78Ycug/y4Pnbc
         pea+/DZs7k/QPXb6HseqQAzank/lfI5Iq6PTf0Ov7Z+NwzyAtjuRGdDmY+A7BpN2W3QK
         XiiKSonmAzv91U5gsQCdm8InOGWb9RrEs2ZRqQowg8lyGs1WIkIBbPTpuTndEu3GBx1Z
         Zu3y6Zyr0TYzcBFCu0EoRpy/adxL22Pe5gyXxyo7KX7DhrLTgq/60GGKh0W14RR6S1AX
         u6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVpyhVP7YpKyB/UJ+trkIt8cyrMxL6OkddeH7dOkioBQnR7gG7ULFxf2MEE/rC6Xr2kgDqs62C6YXLJ3Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe1bThbzNQ7w/0g3UgaYtdwF56pNCOn1TwR/0UxSbvSGqw62W
	IpVfpvFDu7Csj1Qu6o4fIm1DREuBKB0dev1VwX2Wa/Mq8QFcsLt8EWjYmw/1+ij8ftU6y5fCvLt
	lxZVJBJAZOSAgD2Qbikv5a0Ygw+LDRhb5RwtWVKsTiURH5fONa6ne+DUlzzbAUw==
X-Gm-Gg: ASbGncvImhD9wI+3sejid6xrUPiW8/YYJux2cAOCKW5Wmc+cSLpPYDCk4S/OLR1GZub
	wd98f1HRRJbdO7WTOFOYury34j15di/bS1/O/0hNusWoryYCmzk9YM/QFNPwm7kQWv37w0cmrro
	2LAsnJ6dWhA1TzpLezO8M7mfj9ryriRvbGnQ58/itsmz7wffAR96wdkTzz//UhaqIjs6c9ZYDf7
	c/S73KQ75R8//UJLrJlr+3fUpXy2QudxlOj2mda2upGTF/DJFPWSkhPfoOsNPgvFshL8vjsETUH
X-Received: by 2002:a5d:5f4b:0:b0:385:d72b:98 with SMTP id ffacd0b85a97d-3861bb4c74amr2735489f8f.5.1733409230191;
        Thu, 05 Dec 2024 06:33:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaZG2BYTZ2RT1a9dY4OQPOx6sg1N6RVN85ljPKoLzCBr5cmOjWR7+C6rxdKP+5jhE/Vmx4Iw==
X-Received: by 2002:a5d:5f4b:0:b0:385:d72b:98 with SMTP id ffacd0b85a97d-3861bb4c74amr2735477f8f.5.1733409229829;
        Thu, 05 Dec 2024 06:33:49 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280746sm63050865e9.21.2024.12.05.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 06:33:49 -0800 (PST)
Message-ID: <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton	
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>
Date: Thu, 05 Dec 2024 15:33:46 +0100
In-Reply-To: <20241205083110.180134-2-gmonaco@redhat.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The patch is fundamentally broken since I somehow lost the line calling
schedule_delayed_work in task_mm_cid_work to re-schedule itself.
Before sending a V2, however, I'd like to get some more insights about
the requirements of this function.

The current behaviour upstream is to call task_mm_cid_work for the task
running after the scheduler tick. The function checks that we don't run
too often for the same mm, but it seems possible that some process with
short runtime would rarely run during the tick.

The behaviour imposed by this patch (at least the intended one) is to
run the task_mm_cid_work with the configured periodicity (plus
scheduling latency) for each active mm.
This behaviour seem to me more predictable, but would that even be
required for rseq or is it just an overkill?

In other words, was the tick chosen out of simplicity or is there some
property that has to be preserved?

P.S. I run the rseq self tests on both this and the previous patch
(both broken) and saw no failure.

Thanks,
Gabriele


