Return-Path: <linux-kernel+bounces-542992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D306A4D047
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3D13AC0DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187A69D2B;
	Tue,  4 Mar 2025 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a562cxHf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E735961
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048701; cv=none; b=sF+MqrCWhRMpSTy3mIc7EmY5eOAWsvntPQLX60PSuxAG65/VVVtMn+ResfoYOgHXOHkPs54JW2xBEKpGFatnExf3p/i9esf1x3oFQTdVyO6BhwS/LMxQGSM98BnLFg3SZ8lvGQ8Ek+yvXKHhwFRWVNWVRYRi+H3GPYSXXiK11AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048701; c=relaxed/simple;
	bh=7RoPq9ddys8/BPSx9nAJBHesoRleCVq83HFxXGrTUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yze2d8cdFt8IRc9pUyAGOYfrR4npwqJOeezzGGipEyluhYW65jFc+agz5LHcDggMg1ZrrCpnfCg+uiUnXPBVtL1q/VuFhBtw/kCIytX+6ia8IM73cJ2mpb1wG4yUGfsaVqkbBmqAO3B7ytaZaJum8W46okqB4jyk45pRYxy04fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a562cxHf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bca0048c3so11485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741048698; x=1741653498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6X6RdB4UjE6/nuAZYBU8R5Fe+11M30bcPZso+kk5zo=;
        b=a562cxHfzModqqbFvL1MGA+5G7sIv6N8ib/70jNnAEdNkW+SSNQvSC54L6snAHjvOB
         iWqeTa+KOVtrioiKnBMGDLeya3KLF1pt5WVYxCB5HFaseLe5svn1XREH2Mzk3eGICyaJ
         oRcD+znlesNu/r35pnMVD7Ur4IoU7XDBp2stwzsmqxZ+8SHgf1WEntZDPO+U9b04he9Z
         bMk0GQvgJyfHrdh+1Yi/A9cuucpj9LurKnw0JLBZRiYex1z2ZekcwIND2j69HrLcXv7U
         vHiOE62J4iAMOKgLx08c2ercJfVBwfY3HA6uQ24XrWf6S6IL+B99mnlsoCiBOHqavjB3
         00fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048698; x=1741653498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6X6RdB4UjE6/nuAZYBU8R5Fe+11M30bcPZso+kk5zo=;
        b=kXtIWIyW9UUwj9GUJ/BHvFEbufN4tsHSA9YQCjPjCbYkAR7WcOe8I6GlBfzt+EK+dJ
         DUSPu5FIJGMx85btP8irZdfCOhonqffTo/y6nN9vsxkMGlB8HDO6THjAkhs54UK/d3uG
         JGfCgfT9dhtvv70NxE0mQx294CZtCv3JGWAJUILev1k5uwceYGuYqi6cYZxgO0TzWHYs
         tj5rUZp5syHh0sXbSM5Qd4rHqQlnbTO08kiCZNpLpFwwQul0EUhoC0xoOrF6cdfU3wE1
         hAYYnme2IxXw5ff8o5+zizYaLEJLdREA6XY1k7zRhvOu18n7FazK5Rpi3nm79sbWn/z4
         x7jg==
X-Forwarded-Encrypted: i=1; AJvYcCVc0XK+HcOWM5vCvzeIO5DhRHCTYsL0Y3VCNP2+wDkeFi+cuOnps9uLQ60j5pTrlU6jNv9F/HVDd1IK4PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7k0b381W/FUIFLRALtbzj/2WGgM+uihMNQMD4MME1Y0PNd7C
	OuZzGVii2ML8x8NQV8YpqeFp3D4Xbv7pfzJdHC1T6xjFn5Qs3uQFq/TWWS9hpg==
X-Gm-Gg: ASbGncu3Y0LgqQAPy4ouob1F9nKZbRI3HkxkURaypn2+E3AD70pH6ypV5c9qtTbPo35
	p7K3J9hTADz0VQf9GLtL1HtRsdW0AepgvA5ruCPntbVw43EBnvakidNXGU+iHCYntn7hfBbTWuo
	bv+ZuClBf902Dhc/gaMz6XlbO6a2KySouTi9c18xcZh8/JdYCgTBieI5HbTKQx8mYwhIU7F5ucJ
	yBr1OCdOCKbLWFiATTUKmh0F7eBlegP+muDMofjgp14OeUabid8EGR18/cYOqLeYLK+JT0P2s9p
	Y0nNtNeyr07JBlqJFpU4jYkPWmnuUoAs4WuJs9Mbjm6ea0iCFQUg1s3XpUGrpghB8NKjgt+5QmG
	KqTuSSMWEL7jD
X-Google-Smtp-Source: AGHT+IE9Y0VrehBJlDbDHPyoWXw+m1J69GUEuvY40Y+njXxv5FVs5PR5YGF4xAoIWOX1sa7YhrCg7Q==
X-Received: by 2002:a05:600c:4295:b0:43b:c396:7405 with SMTP id 5b1f17b1804b1-43bcbe292f1mr260995e9.7.1741048698270;
        Mon, 03 Mar 2025 16:38:18 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dcc1sm15629062f8f.87.2025.03.03.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:38:17 -0800 (PST)
Date: Tue, 4 Mar 2025 00:38:15 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	catalin.marinas@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	snehalreddy@google.com, suzuki.poulose@arm.com,
	vdonnefort@google.com, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 2/4] KVM: arm64: Move the ffa_to_linux definition to
 the ffa header
Message-ID: <Z8ZLdwmFzS-lnssj@google.com>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-3-sebastianene@google.com>
 <20250227202557.d3fd6ylzbaho4pvx@bogus>
 <Z8DxZY-09R6lwEW3@google.com>
 <86wmdapei8.wl-maz@kernel.org>
 <20250303234426.GB30749@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303234426.GB30749@willie-the-truck>

On Mon, Mar 03, 2025 at 11:44:28PM +0000, Will Deacon wrote:
> On Fri, Feb 28, 2025 at 10:09:19AM +0000, Marc Zyngier wrote:
> > On Thu, 27 Feb 2025 23:12:37 +0000,
> > Sebastian Ene <sebastianene@google.com> wrote:
> > > 
> > > On Thu, Feb 27, 2025 at 08:25:57PM +0000, Sudeep Holla wrote:
> > > > On Thu, Feb 27, 2025 at 06:17:47PM +0000, Sebastian Ene wrote:
> > > > > Keep the ffa_to_linux error map in the header and move it away
> > > > > from the arm ffa driver to make it accessible for other components.
> > > > 
> > > > Do you plan to push/target these changes for v6.15 ? If not, I can take
> > > > this patch with other FF-A changes in my tree for v6.15. Otherwise, it
> > > > is must go along with other changes.
> > > > 
> > > 
> > > Yes, feel free to pick them with your changes and we can push them
> > > later.
> > 
> > So this series is not a 6.15 candidate?
> 
> I think this is 6.15 stuff once it's been reviewed. Sudeep's message is
> a little confusing as it refers to 6.15 twice (I guess he meant 6.14 the
> first time?).
> 

Right, I think it should be for 6.15 after it ticks the review boxes.

> Will

Thanks,
Seb

