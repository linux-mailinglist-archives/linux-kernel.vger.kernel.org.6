Return-Path: <linux-kernel+bounces-423593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537499DAA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67EB1669D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BEE1FECAB;
	Wed, 27 Nov 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hzGOFEku"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315501F8AF0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718896; cv=none; b=XpSHbtD8u119bmBRpv/jVevc5I8RCCg6Ga3nbFsPe4gDDXoMvr1pnzOmia2JPgoJo5l6g31O/C8MQkbYvvm7lFYIXSzVzS8hF8bFHprqPGe9EfU5SJe9kBFERSduWgF+s7Q3QGHkf12wxHY2m0Kyhln/RP+bhSYAs8++HS+LqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718896; c=relaxed/simple;
	bh=lZTO1F+K5JmRsqZrFtPyEBylUox52Bl3E5P9xltjypk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pooIkt6kqb3kFdpTGEjPyhBBEScB49d7BSnub10oQYOF9ay3Tl0b2CecsHjsuG4GdHvhFYON8BSak0m390gvfrNFfiJTEKAnr55d54ynSIyz7LnFBK9Rmef8S4mQtScsM4J3qWG6F5vfohiOkkFTRhDJexcf5O5r86E8P1JSsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hzGOFEku; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a10588f3so23817145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1732718893; x=1733323693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zGdCUwsG3IsDqM/i2oWhWlJlnjPcZGvagoXb4ToDno=;
        b=hzGOFEku2MLtF7coVJyOe3/cy55Cc/PYkQM1j8i6OxW9evM1zwnX1AXr9RSB9lNRIl
         EnD8ZF3l/6JR7TfAgYzmUYj4dj2Q4SK/ydPbt0CpWzNB4XodtxfAj09s/dAoeLeOVnF5
         Sp4VRI98omRTuDIhG+t/cDNbGJ+I8ks/R4NR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732718893; x=1733323693;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zGdCUwsG3IsDqM/i2oWhWlJlnjPcZGvagoXb4ToDno=;
        b=aBZEMyiNhjBpSqSgBs1ZT/1yDK8fvEAj+O9XOJamNwR9vY3/teDXbvqGEWMMnXT3yP
         3ujjlk/UQ5Y7aB4SJhI1Xp9ei7GGRLj+u5lC26Ag/tnC6cOoDxrALrnXGUlCtI3CN77W
         zApnfHsDZlD/Nbh4GlCwu36FYfBDE/rrmDcd0Ri0zCX3iVZDqKmMX6FNhBT35ttqZ2c3
         czbrh33fgcO+3/WzMGQriLIxXBw4Z0wenaxiKPUkifsdJkdtZzdrjs9jPMRp5HPcpFwg
         Fdz8LSdeVFyikr7/fZXtciohZyZIKBwBzTyy2ul+vC06U3dOYz2VHSm8GXbkllNLBdWw
         bUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl/nZs34PsH3fugVAGrmmJf1CPBDRrgBbGGy9uHKK7stgl5bVJHpGeErgI33IktlEP4A3I1kdPpMhn2ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvlR0NVwDglp7IG6uyDa0vn9CGrIggkiFiWJ4c/FeJinhn8ax
	moFTckLcoXwvrIa/1HZKx9FZhrKgKrTxZ0qGmtvjgiO699sEwy9Cd6r47eUREyhRz75zAl2lGCn
	F
X-Gm-Gg: ASbGncs+Br5aJ8NtOGfe1AB/vV4lEQ78aytxOjcEeI6xX8xgoOa+mPGhRnU55NXmxTc
	rpeCeqPG05IFMdvWZgzfsLmxNUBn2Uz1QNf99hq1Wd1Rs6QYZiXM0v50A5xmwBapuE5ceP/xcXX
	ogKvd6WMCM4vb6VSHdWes/zfSwhdPYdXCvm4awdv0uhE1Zn/BY3J6kzF3dfzViCHHKxRHrjGhdo
	0KFhh69iHHu0iPUy7Q/Wt6tAAlO/NHvIXHx7M3VYncsTwSuyiw0eVCJCSco2Q==
X-Google-Smtp-Source: AGHT+IG6ksNzlO1Mw898FVD0TgVtTxvVHhve8jTB516NcfNmw2tP0Lluyr6vcK94J/lDcM1jpoRB/g==
X-Received: by 2002:a05:600c:4708:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-434a9dcffa3mr36410165e9.17.1732718892925;
        Wed, 27 Nov 2024 06:48:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e2922sm23014835e9.29.2024.11.27.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:48:12 -0800 (PST)
Date: Wed, 27 Nov 2024 15:48:10 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, Hans Verkuil <hverkuil@xs4ll.nl>
Subject: Re: [PATCH] docs: media: document media multi-committers rules and
 process
Message-ID: <CAKMK7uFZsc+-Os+Pb9MHHbdt1K5Pj+D069d-+FvsDeeWgeZASw@mail.gmail.com>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, Hans Verkuil <hverkuil@xs4ll.nl>
References: <6a3e19d75e504ebbf9cd9212faad12c005dfdfb8.1732541337.git.mchehab+huawei@kernel.org>
 <20241126151930.GA5493@pendragon.ideasonboard.com>
 <20241127103948.501b5a05@foz.lan>
 <20241127111901.GG31095@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127111901.GG31095@pendragon.ideasonboard.com>

Jumping in the middle here with some clarifications.

On Wed, 27 Nov 2024 at 12:19, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Nov 27, 2024 at 10:39:48AM +0100, Mauro Carvalho Chehab wrote:
> > It is somewhat similar to drm-intel and drm-xe, where reviews are part
> > of the acceptance criteria to become committers.
>
> Those are corporate trees, so it's easier to set such rules.

Imo it's the other way round, because it's corporate you need stricter
rules and spell them all out clearly - managers just love to apply
pressure on their engineers too much otherwise "because it's our own
tree". Totally forgetting that it's still part of the overall upstream,
and that they don't own upstream.

So that's why the corporate trees are stricter than drm-misc, but the
goals are still exactly the same:

- peer review is required in a tit-for-tat market, but not more.

- committers push their own stuff, that's all. Senior committers often
  also push other people's work, like for smaller work they just reviewed
  or of people they mentor, but it's not required at all.

- maintainership duties, like sending around pr, making sure patches dont
  get lost and things like that, is separate from commit rights. In my
  opinion, if you tie commit rights to maintainership you're doing
  something else than drm and I'd more call it a group maintainership
  model, not a commit rights model for landing patches.

Anyway just figured I'll clarify what we do over at drm. I haven't looked
at all the details of this proposal here and the already lengthy
discussion, plus it's really not on me to chime in since I'm not involved.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

