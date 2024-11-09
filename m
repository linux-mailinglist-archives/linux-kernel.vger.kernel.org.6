Return-Path: <linux-kernel+bounces-402665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F69C2A43
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0D2814C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863513D504;
	Sat,  9 Nov 2024 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AgCVibdr"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5330C8FF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128760; cv=none; b=e2RxpJQRmCfngH4xQA7jV349uoZ4H21nV4XEgiaMJS1H5lh8Xp0g9v9cibl8b0sSb1glWy6fEyil+PQFsjUrlao+sNDw7Jtndls8wd5p8OvaoaGtC1jPM4pKvAbprpi8wWIXf7/p3MQiX7hSxPYhKOz7S7O8byPpjXTFm8tIrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128760; c=relaxed/simple;
	bh=5d2luErJ4t2O8IYA7jlZfwk/vLJ8um8i6qUXK3HLdLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDcEYBs1iQCjvImqPkixBHWoA2u4o1Xsbg8iWkq+Qf3YwpNv+E45Wi7G7AVdSnkJwLXSmCrwao3nffT3NG+V/xRttFDBvtAJOiCqtJksD+m3BccNE3r6NLefYogn9dGOL60N7OJTzs69QkuRhXVbT8OEMeNEyY/uopUsDVfpO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AgCVibdr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2890375b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 21:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731128758; x=1731733558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkWm6lu8Vf7YjtBv89buVybDqSSTCm0miO4h7F33T64=;
        b=AgCVibdrXkjNyR4XcC7vnNdJMEanD6/ewK5+Z/6d89atu2d8zHaGLAwqw9OVH/Qvlc
         4EbDNGuHIUE98qu0GSnuxfy719A7VgmHEp61CBT5zc+DX5ipLy173eT4sX5M54XMyWnR
         pFiX0maHdMk7wqFunMhfkz5FuKrWW+rJv4fdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731128758; x=1731733558;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkWm6lu8Vf7YjtBv89buVybDqSSTCm0miO4h7F33T64=;
        b=xII2gv1A64k+gk7+QQT8wZwJOegC05+jsOLVYGrsVY3feYXOwOhFQV2gKXFqsIbzZM
         E9GNTeMIBoTwbYa06T1uKKuDAy59DLILKY/11f5W7y733k/8pdPq0R5jLOejYaxMRrIU
         k4jTPlWAjTI3HI4iI2y9niPNYAXWH5kfZN+6PpWclk/qRP4V1peLKZo/Obtr+SqmdCmV
         QAuBNQyUl+o6lNAoYITViv19hAmcqX+F13pMLcYHlFPLosMCTv8tavJ5p4fSdz0Gpntr
         umoodbOx588VV2chBaU8U23VcL+7T9ASBtQvJodi9ro+oQ6fm9SJbbsmVkCbOvSZwQ1T
         BdEg==
X-Forwarded-Encrypted: i=1; AJvYcCUodgBMkCqn9dk/AlYRZqbCBoAujW4OP9bKIdeGMOPkg1AH9abq+scnpSIZzjhVIUCpHp5/X/3JQRHeeUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqyasAOC7q0G1NoCVnUuLerSYDAZhMjl/ag+dDePC1xibRg6/
	nLNI6dqbj61ORPa57YznOg3EiMTqSJ8DRkBc4vhIeDj6txytw9YkvgYAUQQyi+E=
X-Google-Smtp-Source: AGHT+IFWvbmK3ZUE2ROqqMys6VCbYpSt8HcccaDD5Sd5IJ2vW3JieKKtY77lB/QC93xpM9tDHaRh3g==
X-Received: by 2002:a17:903:191:b0:20c:ecd8:d0af with SMTP id d9443c01a7336-211834e00cemr65937005ad.9.1731128758087;
        Fri, 08 Nov 2024 21:05:58 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc835fsm39402525ad.41.2024.11.08.21.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:05:57 -0800 (PST)
Date: Fri, 8 Nov 2024 21:05:54 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Message-ID: <Zy7tspqY1QimHDfz@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
 <Zy4-GUoYKBo_inRc@LQ3V64L9R2>
 <672e4ea4e979a_2bc2f629490@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e4ea4e979a_2bc2f629490@willemb.c.googlers.com.notmuch>

On Fri, Nov 08, 2024 at 12:47:16PM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:
> > On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> > > Joe Damato wrote:

[...]

> > > 
> > > Nice test.
> > > 
> > > Busy polling does not affect data integrity. Is the goal of this test
> > > mainly to get coverage, maybe observe if the process would stall
> > > indefinitely?
> > 
> > Just to get coverage and make sure data makes it from point A to
> > point B intact despite suspend being enabled.
> > 
> > The last paragraph of the commit message highlights that netdevsim
> > functionality is limited, so the test uses what is available. It can
> > be extended in the future, when netdevsim supports more
> > functionality.
> > 
> > Paolo wanted a test and this is the best test we can provide given
> > the limitations of the testing environment.
> > 
> > > > netdevsim was chosen instead of veth due to netdevsim's support for
> > > > netdev-genl.
> > > > 
> > > > For now, this test uses the functionality that netdevsim provides. In the
> > > > future, perhaps netdevsim can be extended to emulate device IRQs to more
> > > > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > > > and suspend.
> > 
> > [...]
> > 
> > The rest of the feedback below seems pretty minor; I don't think
> > it's worth spinning a v9 and re-sending just for this.
> > 
> > If anything this can be handled with a clean up commit in the
> > future.
> 
> FWIW no objections from me.
> 
> > Jakub: please let me know if you prefer to see a v9 for this?

Since we passed the 24hr mark and the series hasn't been merged yet,
I've sent a v9 just now that addresses the feedback you provided.

