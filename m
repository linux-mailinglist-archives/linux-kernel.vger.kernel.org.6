Return-Path: <linux-kernel+bounces-423687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF69DAB58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7212812F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490E200136;
	Wed, 27 Nov 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hptcp77l"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B4433A0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723519; cv=none; b=sgb5+yIRff2jm2kXex+MgkGnxZ2cGi7KAmWEGPKoduS5ZaTnwv3W6EPSqj0guo706AHE17HkcK0tjAhFM2r7902QU3SJLwH0iwwrl+HD9PXBNtohUEFOGwQLQLPC3LLXblQu83O5KSAfegpQVIiKgZbOKy9LI75n8oobLMyITDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723519; c=relaxed/simple;
	bh=kJux8CTGJjwy7JaVNhvqox6C1OvW0rOsjijhFfo32D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6YXxC+rUNVYwykTZCxdr9DnGuAd01WV/ZTx4haXViWPUl4t75Yfl2STLXQosOQOE8Xesrp7OxlOOzeMEiIXHKaVnr6k9/2ClQmnZd39OdQucDEt1eZDaYJ/0WZx/Twc7B/hzDjQ9v2QEiImsjB6ZFSqOBZ7A5q96eZiNjr/RTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hptcp77l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2128383b86eso64886265ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732723517; x=1733328317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXghdq5gnDC0AhzevsU4wobK8NyitAj3TdceWytLpJA=;
        b=hptcp77lmk++ZZkiXJWqQLVxnQEp3HAe7Bm1KTDhTJaptGUBIG7IjyVC4lGs1VInu5
         phzFXAy+qdu15/rIxIeyPR4TL7iNPMsm0nzY9/ThliNexo+78seK4PiDOeu6afERT2nh
         hON+39AtA2f9t6h/aO7P/7GeZVGFMG5SuGApnSxB7WPbCeINz57fiYd7He4oQnOq93M3
         pZFgk1pwwW2jx5m0xuhC2lsWGe2rVMbnqMt7TtNWnruiRiYup+hF0aSeW/5CYchUJwNh
         5jNpBNDzITvPwQBNagmVLCxf7en5NH1/8aI3B6wxUkJyIDdJfFVb4OjWDU8O5+KIbVuV
         9x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723517; x=1733328317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXghdq5gnDC0AhzevsU4wobK8NyitAj3TdceWytLpJA=;
        b=pGTqWk5w74ioUfVwm3YsBvYsHSd2TEGXjZ4FkE6P/MKbv1qdHEVsPpUDoaEPskyezR
         D9tzK6scwcO42wX4Q+LslDYGApaNEyxP1Ee8nZsbEU8NsQhS1xlIf5ijbk8N1s/r0+Nk
         nmftPF7XGLZqPBLizpp2GYfXlbzFrGB0wGhpRu/m1dOMM3XiOd2u7YNMpsyX9lqEH84n
         kcq68UBqztpmiOgqWjHJ1ZWfReMm7HbMcjEn3BI7VPvodYzb1vNH0InOoYwo5b/0kKLm
         OypXDmyTdzyNfZE+RNYAN2l/VnSlyCZZFLDNEJjn85Fs/9bC0rdPENv9qKn23LdIbBMO
         m0uw==
X-Forwarded-Encrypted: i=1; AJvYcCVIKICAWL8l4aP9fwQdcQN6g5FXYwaO93SlBIXg5MRCqKMuFjBmiaCMPUcYXtMg2+WgeRZs1X18GAKVvVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+/BkkojXdX9NT3UscK9G3GEKDsqNEV4wX3VNOEWgcfxKRwiN
	79lFCXx17FeiZgirK4DqxwyBHcauXN95VvLHbE4MbJpLcXlJGiF/
X-Gm-Gg: ASbGnctD2EAtzOtyE5Vc9g4sta8tl1sX4tRCVjaNpp0cJxKk49mGaYWYk57Y4+r7AvQ
	9c/ZtsTQP4BxfrPxMg72yjLEOtytffJ70BjsLRvW8ibfY5fYL8cBzOqjXAk5C3Q7sTSkNiybsAP
	6FmoNgqii5OiWrY2D/dKaGXZYc4gZPfJEXuTCXVNLqXiakHNxEM/swnfxM/IcBr98ymjUqozBvt
	jgXu5OlSw7og51q/TznJHYjWV1QCPECXu11fXR7ZkWCQPsFGYfD9D8biM9CsY+ajowt1g==
X-Google-Smtp-Source: AGHT+IFzPE8txcyq3LJ3fYUvH0PEWhhQtW4rwSdNQ79KmN3tpOYbpWo+WsnxF3tqr6eGqFpwGlP7fQ==
X-Received: by 2002:a17:903:1cf:b0:20b:8776:4906 with SMTP id d9443c01a7336-21501b58e10mr36821985ad.37.1732723516894;
        Wed, 27 Nov 2024 08:05:16 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b50sm10726499b3a.101.2024.11.27.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:05:16 -0800 (PST)
Date: Wed, 27 Nov 2024 08:05:14 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>,
	"jstultz@google.com" <jstultz@google.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ntp: fix bug in adjtimex reading time offset
Message-ID: <Z0dDOje96uI_t9sd@hoboy.vegasvil.org>
References: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
 <87zflkydgp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zflkydgp.ffs@tglx>

On Wed, Nov 27, 2024 at 03:10:30PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 25 2024 at 12:16, Marcelo Dalmas wrote:
> > Due to an unsigned cast, adjtimex returns wrong offest when using ADJ_MICRO and the offset is negative.
> > In this case a small negative offset return approximately 4.29 seconds (~ 2^32/1000 milliseconds).
> 
> Nice find.

How did this slip in?  Git blame tells:

    commit ead25417f82ed7f8a21da4dcefc768169f7da884
    Author: Deepa Dinamani <deepa.kernel@gmail.com>
    Date:   Mon Jul 2 22:44:21 2018 -0700

    timex: use __kernel_timex internally
    
    struct timex is not y2038 safe.
    Replace all uses of timex with y2038 safe __kernel_timex.
    
    ...
    
    The patch was generated by the following coccinelle script:

    ...

So I guess combining random other manual fixes into a patch that
claims to be generated is a bad idea?

Thanks,
Richard

