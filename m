Return-Path: <linux-kernel+bounces-510126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD3A3187F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F3E3A286F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A777268FD4;
	Tue, 11 Feb 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0lCuePj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FA268FDB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312479; cv=none; b=m35uQT8WccbDxEYx2GwbZt1v6S0u23LkKV6RkJ4KmG3tenR7epXq9HzJDgs2GMsDvibZbJVoy3VT1SSS6p3tJFF6lGNNO5G3q+FgDLAE8IipDXzayG1BVoccleYhnETO1HFpj5JX4La7eVvIJBD51MN21LIgOVB9B44P4C0hUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312479; c=relaxed/simple;
	bh=a1YSwYfSHtvwJzBZ4RED+1zkCwMf/mzH1nEkn7wsbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWA7F64gBsEwlDtXq02c1OQmPh3rbpPnAo48hZ7cFvBgw8qwIk1Gz12YRpd/fN+8VXWoS4tlR/V5IZR027cU/hpWmF3x7OrTAnyBNkfl9Hl4rIBPvGFARVL6HtGrUSwo4eBQXYKSbIsvdX4gpoPOiA/2dyk/SkYzUrb1/pUR4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0lCuePj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f8c280472so15605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739312477; x=1739917277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjzryGBicQVImcaUwF8Kk/J08SYkgXHEDzMrm9AaCFM=;
        b=A0lCuePjEqndR/u2jYv1ql0b3NvLNdLV39OTn9zzp/SpH9Ffo0nZSbQDyt2SFhEULR
         Vw83RJhOLHVFlvbSdhTnJeULok+zImblUmaOLqceK1kTq+2TJ3OyrqOPv2mW0VYkASOn
         Iu4y+Tbbev0jRVYBn8CC0H8miYzZCa8y27YrcXxu1XC84A1wnCFLCW4hwdLDpX1BNW+l
         L1d2FXTfkDzvvFUeo2aKHyVHkHYNEeU9L0O+PZCWPahzQyVUgorJ3g3TdlEovSrCEA+V
         h8bZfytDmrox3TENLcuhozy2bWIxy7Fm4WUA1Ib0Qd8lmED6HjAXmi5+C0iAEyLe1DZv
         0KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312477; x=1739917277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjzryGBicQVImcaUwF8Kk/J08SYkgXHEDzMrm9AaCFM=;
        b=pfNNkHKIrwOHdV9tEWtRdn9QrIu24RvC4eWkSyN+/sgxtebgPay3utDJcnf4xXqFUg
         1PvJX4MsA2N7dxo4HUMctftXF/szFuz0sf4MAs5Z/yEHQCCU445lVNF1t8QODsw+I1Ud
         30AbpzNoqTtvm09wXxlo6dj0dP1hf5UkKHBtiqrTANRJm+9smGFnVemFynfjhTR/7hJw
         lLxg4CkvdIMwr0o0hupCWrgrOv5gziu4G4lZ55/fXtk1AspUqFv0wN36khpth0d7kW73
         L/WqOyrfUd5gTd1JtrX8B8lKwLAlXxCYG4lRX92nVBSMTueL7nEj3cDTEncr1LoUndBw
         I3TA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xJmb2b+uO4cBP+o91I5ZKrbZCM3hMhu7ff749MeU1jA/HI7yFVP1MxMWSn+2iyJDen3yHi5OcJHhkLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5G/R8G2VS6HzEm15SOxQAEivSAqxcUB2/eva3G5XGjnhclWX
	IMYfHMFA0XkdYy9aq+4oA/dXATWSeEC81Jzl1Tqy1q84ZhXmqDuIhPllHxhrRQ==
X-Gm-Gg: ASbGncvKEBoFNT31bCla1UOyhbyYUd5LB3o+p4pIXlB2oWteN8csqRpdg2rkviCZjtY
	YCW0VbtzlY1gyustlugUQlgVc3AAfoxqv6Jb+TpLFoHEDg7M04XybRiKjWNU7wy4MCCfgVD2Wht
	RlXVwuHbNmZG6ZumzWKL7/EYTFKxnMM4tEALRaXhPgQCwOH+I5ipztEtK5JgNYePsDJqb07sJ0g
	8d/pFIVsWYzaegC2fonLnSQxfnl0n23EgZeQg/Hw70/PkPLzoMEVsknDfDbLlmLqE6N6ERoDNZ5
	u490R5VqWUYU1TzGFFpbabGVZ/8UPYhXGxbpWF6ObqTvAaLDwPBI
X-Google-Smtp-Source: AGHT+IE9Eyuod2lYAzKcb7DlMkAvrPxHPMFUvHM7quPOLgjcn1Gu3gW3iwUvOBgkIXWv8Gbuo0K2Ag==
X-Received: by 2002:a17:903:1664:b0:21a:87e8:3897 with SMTP id d9443c01a7336-220bc76be3amr773775ad.4.1739312476858;
        Tue, 11 Feb 2025 14:21:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2e14:7:951b:5f7b:9042:f9d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9aaf7c9sm46982a91.46.2025.02.11.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:21:16 -0800 (PST)
Date: Tue, 11 Feb 2025 14:21:11 -0800
From: Brian Norris <briannorris@google.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z6vNV8dDDPdWUKLS@google.com>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6lzWfGbpa7jN1QD@google.com>

Hi Ajay,

On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > Well, in general suspending or resuming a device is a collaborative
> > > > effort and if one of the pieces falls over, making it work again
> > > > involves fixing up the failing piece and notifying the others that it
> > > > is ready again.  However, that part isn't covered and I'm not sure if
> > > > it can be covered in a sufficiently generic way.
> > >
> > > True. But that still cannot solve the question what is to be done
> > > if error handling fails. Hence my proposal:
> > > - record all failures
> > > - heed the record only when suspending
> > 
> > I guess that would boil down to moving the power.runtime_error update
> > from rpm_callback() to rpm_suspend()?
> Resuming this discussion. One of the ways the device drivers are
> clearing the runtime_error flag is by calling pm_runtime_set_suspended
> [1].
> 
> To me, it feels weird that a device driver calls pm_runtime_set_suspended
> if the runtime_resume() has failed. It should be implied that the device
> is in suspended state if the resume failed.
> 
> So how really should the runtime_error flag be cleared? Should there be
> a new API exposed to device drivers for this? Or should we plan for it
> in the framework itself?

While the API naming is unclear, that's exactly what
pm_runtime_set_suspended() is about. Personally, I find it nice when a
driver adds the comment "clear runtime_error flag", because otherwise
it's not really obvious why a driver has to take care of "suspending"
after a failed resume. But that's not the biggest question here, IMO.

The real reson I pointed you at this thread was because I think it's
useful to pursue the proposal above: to avoid setting a persistent
"runtime_error" for resume failures. This seems to just create a pitfall
for clients, as asked by Vincent and Oliver upthread.

And along this line, there are relatively few drivers that actually
bother to reset this error flag ever (e.g., commit f2bc2afe34c1
("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
fails")).

So to me, we should simply answer Rafael's question:

(repeated:)
> > I guess that would boil down to moving the power.runtime_error update
> > from rpm_callback() to rpm_suspend()?

Yes, I think so. (Although I'm not sure if this leaves undesirable spam
where persistent .runtime_resume() failures occur.)

...and then write/test/submit such a patch, provided it achieves the
desired results.

Unless of course one of the thread participants here has some other
update in the intervening 2.5 years, or if Rafael was simply asking the
above rhetorically, and wasn't actually interested in fielding such a
change.

Brian

