Return-Path: <linux-kernel+bounces-213214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E1907179
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825CC1F26083
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F714199C;
	Thu, 13 Jun 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="if3XD65s"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690F20ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282236; cv=none; b=dT6NzH7OGeLNeXuxx8rbtU+XVSlYlw/aIiy9gguZ0ai9+jS5IW7SqYaiGB8WPR3y2jAWuO0vPIqqJ0JojOPvHWsdZYzjwgvo9HgwJNabuyEJ4w+MUe8FnohUdbM/pWomzBDYHZX0toX5D9sF55lKv4V4zIBZrJzQMI40IdGhNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282236; c=relaxed/simple;
	bh=/13ngaRTyPeB4vBu9MQ8WJijEgAX5lH/Z0IZ+QKcV+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXVFGGAMJ+jNxSwoS9Leh1e4lnfCxmfOEvEp+pNPP6Bsa8PvO7LGKpN+lm+mreKP9y3hlhKSJoy52yabHmvH5AdMY8v0g9McHqJ/wCaPfaWOXLKcZgH/uBLOFkE2TsS/GfWapBoQchyxmfsQc361UZgksBkoDWK+1RKSHrT2NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=if3XD65s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso15649a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718282233; x=1718887033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MznSC12yYzkye/+ENgqiPXuQSrlPFjsWMKgcvI0Z2PU=;
        b=if3XD65s+cw5yGk+YkOEH9hfN6QWVFfV+HKtdiUNN3QPgCIW1KaBs5+SkfeWFlM9m4
         RrbWiBkeM5mBPi49f5NUouwYgHR/j5cvivHnWNDxVFj+5VV2jy5uouh1vy64Pw9Y8J5b
         UYrCqqYiZIkFQcktjkeVBR2b+1Z/GRrmRsf9JUImYYOo38S3ZB3YbhfQ4/JFxk+AMZKz
         tyPswwxCNRgci/xIOc6lAt9wrdBsIouUsOiR3LdihNqnW2dFPEs8W2N6yVPhu7f027Xr
         qZuWD3OCqrMtJ/+2j+o21/z/Tk3A910iRv8QN4Yrmvz9nXLccwbKeZ3gyVcDRxLqmIHR
         cmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282233; x=1718887033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MznSC12yYzkye/+ENgqiPXuQSrlPFjsWMKgcvI0Z2PU=;
        b=Srp60DGAfp3mTe0heIge1sweDbL0AlbsTe5ekB8JBjL0EO8NRNuw0uiVEFX1wJOb+y
         9AzsRnmJ4n1u7gAVlEEzDXBQelnU3Wqr7wbsPRbwTrWCtBUeKEQchjBvxnJcCpDMbEg4
         8api0AHFRmO9OwqXEQqqPNJwXbN6uncnkz8zn19UR4bsexJ/nnP8eiDRrH94hLnbMt6m
         N0DW11H95jy8Ncs1pwi/ddc61BT8ZB8K8gghrVKuSK2DObQzMT6w6MaBx2G1r55JuuWU
         JrRgp3y6LV98kNCWtXp1ig7DJVwoYxbYL/aPHikBui2fN9vNoZTWkYMlePjIgW6gDQyR
         JkuA==
X-Forwarded-Encrypted: i=1; AJvYcCUVEIW6lehv9GRzSQd+fSwtR0sie7at19o096kZKTcaxbMkMeA/HX+7ZNorDzzeoxArznjF9DO1Bp9L3gGOzxUb/AzlRyIiK4Ba7kBm
X-Gm-Message-State: AOJu0YwL3iSXSlgwccbSDxXgBIRpqDRKAtcnLyAMontDSF8t5E9oWVru
	oWe2NeqHPAOa2CBYISZbkMUfZU9IxUe/RSHa2FLun5J8+HSjcQToeusXhWOnjg==
X-Google-Smtp-Source: AGHT+IFP8djsGWBB5M7AJLJBWEREHC1E9615rPjaCU+riDmr7PzZ+qpZx22Wb8eUXNrKQ7Be+vXNdg==
X-Received: by 2002:a05:6402:524f:b0:57c:b799:2527 with SMTP id 4fb4d7f45d1cf-57cb7992890mr126050a12.7.1718282232985;
        Thu, 13 Jun 2024 05:37:12 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c890sm1628667f8f.28.2024.06.13.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:37:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:37:10 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, suzuki.poulose@arm.com, tabba@google.com,
	will@kernel.org, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/4] KVM: arm64: Fix the identification range for the
 FF-A smcs
Message-ID: <Zmrn9u8pJ0nduxfQ@google.com>
References: <20240515172258.1680881-1-sebastianene@google.com>
 <20240515172258.1680881-4-sebastianene@google.com>
 <Zmmy4pmgLFZNhXqp@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmmy4pmgLFZNhXqp@bogus>

On Wed, Jun 12, 2024 at 03:38:26PM +0100, Sudeep Holla wrote:
> On Wed, May 15, 2024 at 05:22:57PM +0000, Sebastian Ene wrote:
> > The FF-A spec 1.2 reserves the following ranges for identifying FF-A
> > calls:
> > 0x84000060-0x840000FF: FF-A 32-bit calls
> > 0xC4000060-0xC40000FF: FF-A 64-bit calls.
> >
> > Use the range identification according to the spec and allow calls that
> > are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
> > identified correctly.
> >
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Not sure if this needs to be fixes though. With addition of notifications
> in the FF-A driver(since v6.7), host can send FF-A messages beyond 0x7F.
> But since the pKVM FF-A proxy support is not yet updated to v1.1, so I
> don't think it needs to be tagged as fix. Just thought I will mention it
> here anyways.

Yes, good point. I will rewrite the title of the commit to remove the
fixes tag.

> 
> --
> Regards,
> Sudeep

Thanks,
Seb

