Return-Path: <linux-kernel+bounces-362795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C199B959
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04191F215AF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08711442F2;
	Sun, 13 Oct 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZXnoW3P"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDB1422B8
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821659; cv=none; b=ESg+d81QuLry0eCw023I+yUVR8LVfcaGgvqICjztB4hw5d8zWCcecqkSsPbyBXdzSJ9rTlxLoEok+ErBAyiRVdLvX58G2yyHzoZF0iB1PVrf7OW2ENwzfE9zzly3HOYspz94btdxXJzz37jM/CYTLOcElRf796El6Pcrk6EI31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821659; c=relaxed/simple;
	bh=MbejCc5hRLf8rMuzNW5QpgAw/2tY6vM/eCBlBn5yaFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAgH94IkeGroCm+lO9iwAECztXMpGLsrh6bN//r4M08SkZpbh88C7alsUZgrGiG89bVBeFuaBPm9WVbHiCS7HC9Zvbf51Ko9ay3TWCX0wwCwygDaAzIhjWzCr249cW50yhmVg87aj7zBp1tHrtbgmO81gBxdMLypvn/UGZpfTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZXnoW3P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso4779027a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728821656; x=1729426456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQUUMKlVY4eZTQQcYg7iR5pm4AMRonESTNN0Nj2BU+g=;
        b=aZXnoW3PhlO6J0maK+qMemt4O+JCQiU6S1TaUvENUGUHCv6eEhYgFsLXitkaqJOuy9
         BX7/HlPnleZTf18NFqy2kyku1T+OYfdAzEt7MlS8xvHsVcMUhBVfVRlpR8yAJ8T0z3oJ
         UhwEB0/Mxa7V0H/y8cgqExr2g3jW+MDZU8xHjGOzXGns2XmMqnWRW+GoHpzhZx7nA92u
         qoP9/Qxqx2+ezEltAvXm7s1DZi9hudEIxVgT4cYYZuZVSies8sHO+S7oPTg53TISH4gy
         L8XGwnXucRYIRXwOQ/Sd1vtKGPC/Ul2qOorxd5DMKwn49gmNSjhGfgXOGLTKNcynHbp+
         gOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728821656; x=1729426456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQUUMKlVY4eZTQQcYg7iR5pm4AMRonESTNN0Nj2BU+g=;
        b=LgJf2DYm2hO4M+IPrNEa9FgXpK3KotWW4SS2uZHOyMy4GTm7PkKF76fW53dismm4xN
         AneanW3cV2D/yJZg13XYcAEPgKE+6RmfFrjJlWTmzXhAr6vTPAD/VxFo+xGQ0lrGixch
         GNI8G9O59ZcYEM5vMiNRJZB2Ri2wxI75f/So9ucmc2hI07fBuG+hDvfprF7Hgz/XW6+y
         FTX4PY1nUB6GMX2KzDKTB0ZxsehZDshhoxkglICBfUjSLLP8vwWbMV+9VWedMrSsfjEF
         K4tOiJgtR+2U/DiESzhRGVpaj3BY1VXSasQp0PTtZUPHo0aNOZa9MzJxUrlk9feRDZuc
         3Iig==
X-Forwarded-Encrypted: i=1; AJvYcCUl1nmNiNJN9a+JxmyaspYRObg9LNM0M1vQn6dOxI7teqNvg33dFYN1ztGHo8kH4aDxCb8h6/2MGQnTGYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcjNiXX6+LQ2D2oypavmjakIPU5qqNEEh51Q02/7m797KTriA
	YmSipSQ7we72Ya0UpOUVNNz/xM47dE3cVOLjyKyy0UjGGbWhqMzGsErsv+tdq9U=
X-Google-Smtp-Source: AGHT+IFrfUH5RSr8HHsWDqdFSVlm12Hr8nsnTD7QsUaesw0R98HoNpp1TV24+inCdQdpEJjuhmyJ5w==
X-Received: by 2002:a05:6402:d0b:b0:5c2:5f31:8888 with SMTP id 4fb4d7f45d1cf-5c933577e0fmr11248624a12.15.1728821655821;
        Sun, 13 Oct 2024 05:14:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260735sm3657831a12.72.2024.10.13.05.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 05:14:15 -0700 (PDT)
Date: Sun, 13 Oct 2024 15:14:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 4/6] staging: vchiq_core: Refactor notify_bulks()
Message-ID: <2f4e2139-3570-403c-aac1-c31c2b21b014@stanley.mountain>
References: <20241012185652.316172-1-umang.jain@ideasonboard.com>
 <20241012185652.316172-5-umang.jain@ideasonboard.com>
 <172880414537.1925926.9488617715642757683@ping.linuxembedded.co.uk>
 <14912c78-32c4-4c61-97db-c9f6dbbd3bb1@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14912c78-32c4-4c61-97db-c9f6dbbd3bb1@ideasonboard.com>

On Sun, Oct 13, 2024 at 01:03:45PM +0530, Umang Jain wrote:
> > > +               spin_unlock(&service->state->bulk_waiter_spinlock);
> > > +
> > > +               status = 0;
> > This just looks odd here. If it weren't for this I'd have probably been
> > fine with the initialisation of status
> > 
> > > +       } else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
> > > +               enum vchiq_reason reason = get_bulk_reason(bulk);
> > > +               status = make_service_callback(service, reason, NULL,
> > > +                                              bulk->userdata);
> > I think I would probably just drop the int status altogether and make this
> > 
> > 		return make_service_callback(service, reason, NULL,
> > 					     bulk->userdata);
> > 
> > > +       }
> > > +
> > > +       return status;
> > And return 0 here. Then we get rid of the awkward initialisation and
> > usages above.
> 
> I usually have the tendency to minimise return  statements in a routine and
> ideally target for single return statement at the end.

I feel like the "one return per function" style rule is an anti-pattern.  I
feel like it's better to handle errors right away.  Then the code which is
indented one tab is the success path and the code which is indented more is
the edge cases.

> 
>  But I do agree on the awkward initialisation of status = 0

I sent my email and then I thought.  Actually the solution here is to do:

		status = make_service_callback(service, reason, NULL,
					       bulk->userdata);
		if (status)
			return status;
	}

	return 0;

This handles the error right away and avoids mixing the error paths with the
success paths.  Plus I like a big "return 0;" at the end of my functions.

I like Kieran's approach as well.

But, I see now that I have misread the function.  I'm not sure what is the most
readable way to write it.  Maybe:

	int status = 0;

	if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
		...
	} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
		...
		status = make_service_callback();
	} else {
		status = -EINVAL;
	}

	return status;

Probably whatever you decide is fine.  You care more about this code than I do
for sure.

regards,
dan carpenter


