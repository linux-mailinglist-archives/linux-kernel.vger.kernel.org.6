Return-Path: <linux-kernel+bounces-345525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F0C98B740
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BD81F22FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867C19C56E;
	Tue,  1 Oct 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X58Lvs59"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61033199FD7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772064; cv=none; b=hgaB4RFiH0Tb8iOIussCLQNZ12ltN6QM1g6E3cVuo6crr1LjpRhmPio+8+ofFwn1DOAO33ZeR++IbWtv9qU9Lccm+M92YJ/gG+YB0NS7l6/+SelaCskS6n1F+mpA99p52BE46VitPncX2VM8cGYRNPvoEAAkZijFGv/a7xrseHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772064; c=relaxed/simple;
	bh=S/hm8byYrXPWLYJoUOTPqJkAHsjkL8FhDtbM7y2LsN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMgKqJ1PvxTR/EWV5YuHZUuy0b1nnn6cEJPTdJ3L6KQytN3MxGcAApa3Qtt/5BuNEYc8UgEOXQX3OErmejsEXBONMWLqrYkijQZ2weBNp3007qyCtLTH62lOYoSOs5QOGi44Wq0VxnbIfq3+aoKZfZwMlG3fTwRub7CPVESh+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X58Lvs59; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7163489149eso4378989a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727772062; x=1728376862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kABUXr6QP7x6BoTLABHvwSUGMdxtLRlyQbuXzsHLQB4=;
        b=X58Lvs59yEfS+23WKMwmDcuZfyjwZhQdIF+iawbXBJMN2AlfAQ2EVts8EJBGB171kn
         1WDVeOpqgpeApHryW+sXc8HgN4GmIa/HgsyfVOl1OuxStCk5TkQwVbEaKDDb9MhHQEsO
         hVy8UEY2urscQU3ug/MGwDIRoRN1OtK6dRLhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772062; x=1728376862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kABUXr6QP7x6BoTLABHvwSUGMdxtLRlyQbuXzsHLQB4=;
        b=CkLCHwKW/qRyVXePlDAJbGZ1JKqeZWMFjdSQmLnSKb2j7VZf+UCChwU9bQJhM0E5X0
         SRnmDRbP/iBmj8W3llS82zk5hpY7N4j7vCY+yMSqE7JZ5p+9EGUWhpLCuuTrpVe/5dEu
         IwpltIos/XU+HmE/QC4OIX2nt6W4wiR/P2Vz9aFatGle6lvRgYzr4gyRSdH30xrmvx8b
         cDAQq/NKcgI1STCEGN/kMm/9tweq+6gPgcPqnqBqXT3WFbO+xtLXBW5XiW7pVmUxYthU
         QetWHULoHjVI+BMIu3wIpBpQNzel5bNSsT1Sfz59VeHRn2U9ehbm/QAtNQkSqVb83Jcg
         wuxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuwSqLf7BVkA7yd5K4WMSa9/AqDCPO16tQYqAh6NmZbnntuacDmCZAr5GHuPnwS+YOp3t9ElSyUZ0IQ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1RiYrron3YbBavqmsUHZ1qqIBqNm7TSW2AziaaSysIyyouao
	UsDhZjfj8lotdbv0fLGlqSq0D//84EJb/9bNs9hdZMHpJnIRK/xaczrCTRPmdg==
X-Google-Smtp-Source: AGHT+IHE90sSzu2z9X1FRWU5gdEauV0yPhNp2TK8DXkRbC2THAaOn4t5Y38bZKIQp2SOj19DVqw2og==
X-Received: by 2002:a05:6a20:b40b:b0:1d2:e97c:c489 with SMTP id adf61e73a8af0-1d4fa7a66c6mr24163079637.42.1727772061762;
        Tue, 01 Oct 2024 01:41:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8dcb:9ffe:3714:b8ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc443sm7520886b3a.70.2024.10.01.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:41:01 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:40:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 3/7] zram: rework recompress target selection strategy
Message-ID: <20241001084057.GG11458@google.com>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
 <20240917021020.883356-4-senozhatsky@chromium.org>
 <61e752c5-ed1b-4b9b-8bdc-0562d2fbc828@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e752c5-ed1b-4b9b-8bdc-0562d2fbc828@stanley.mountain>

On (24/10/01 10:42), Dan Carpenter wrote:
> On Tue, Sep 17, 2024 at 11:09:08AM +0900, Sergey Senozhatsky wrote:
> > +static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
> > +{
> > +	struct zram_pp_slot *pps = NULL;
> > +	s32 idx = NUM_PP_BUCKETS - 1;
> > +
> > +	/* The higher the bucket id the more optimal slot post-processing is */
> > +	while (idx > 0) {
> 
> Why is this not idx >= 0?  Why skip the first bucket?

That's a typo, thanks for spotting this.  Mind if I send a quick
fixup.patch online liner to Andrew?

Theoretically, we can't do any reasonable post-processing on slots
from bucket 0 (yet), because that bucket is for objects smaller than
64 bytes, but technically we should not skip it.

