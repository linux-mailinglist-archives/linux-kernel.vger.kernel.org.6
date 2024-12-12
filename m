Return-Path: <linux-kernel+bounces-443013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185C9EE5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866F916749C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485E2144B2;
	Thu, 12 Dec 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMGeGE/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72072139C6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004344; cv=none; b=niEQix4Qh2udncDNvRx0y5jUt7AbVsx5YEg8Zq2pM8oIQOutAbRhCYweo/hggF2IoZsljcYjNanNraowpZ6kP6Gwuvd9LBiiHgEKz9piRMGEHZakFZ/2x20pZh6d+m29feQICp0uF1dxvPVmUGpEMDpqBrgDeG7uGKFSoCPhJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004344; c=relaxed/simple;
	bh=03RLHQIxmlqsUGfZhGuFm/JltRi9jnj0chF1CLFHW4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHHNWIZmicyLyH1QqKvd2V1nz8NRz4ILu1cFijhs0dm7p8RRBobAZqQEniiY8STe2OOOos7vQ9YfKMZzFEj485VJmnFq8H9oFr447TpuwobwdX63/znmPiGHyqGHv54W8yBT+JuGPoITCKMWnRmx4eXeveZsdmIU4qa8mSqvem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMGeGE/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734004341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exOqWP2BDOKiBjUw7UxafSDVojWNBvZ5jScU+cvyEpQ=;
	b=PMGeGE/WGMFVtJDzxUodVoz+Pf6yX6YU3PCC7jLntqnGJzRmXn5s1I0wVtIqJbKA87JGyc
	zOp7UIDqUKhhay5sVljVH/Bt+BzRJAWCzduXvACJ9T7ce2fTE/xP99vvGAWDep9TZt+Dar
	WloBXjAgeQkE062jWmuG6U1l7DmFdT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-cCnzfMANPHq5Oq9vCdq10g-1; Thu, 12 Dec 2024 06:52:18 -0500
X-MC-Unique: cCnzfMANPHq5Oq9vCdq10g-1
X-Mimecast-MFC-AGG-ID: cCnzfMANPHq5Oq9vCdq10g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115300so255166f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734004337; x=1734609137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exOqWP2BDOKiBjUw7UxafSDVojWNBvZ5jScU+cvyEpQ=;
        b=cSS5dFmv36CISBR1GeRUCySLdFyOhdENWdv+/U+p7fgKikSFQG4l3bHGTqTxDPnZZJ
         pEe+DQH1ooPn4I9JtQ5S0VZrEyy2qlN8W2LkITknL3vTjUuUK6BpefcOJzz8i7QcVbA/
         hvx/qmpPnjZ6VGYSjezjYA7aaTQ3DQRsqd6WhWNyiCwbgDgslGZnTT46FHtksmGiW98x
         JPD8lnWnNXCWzx+CMP4akYDC4jz8qu2/C3SmblqvIa/SM8VvsroO+AUf37ZgSpQbvjyF
         lb7S5/rJOWxxuWKaGm0atQQgZSY23Xj4ufp8ZDmuyjgtSX7gHVciXl3sKlg/R7CqaSG2
         udnA==
X-Forwarded-Encrypted: i=1; AJvYcCVG5hlTQd5wEduTqFqcAIiOCTtj3SMCcLn/YXniGOWobUFndRTg2UbgUivmVL1EV/986uLfRMNtF7u3Rw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqluy+cA0XRJbQzeOiaG6WK5PIS/PQdh3RAsc5PyDOYljX2oI
	0c1ACkFtIXbHIyBGjpuYLWLdBzH2QrOF4sVTRkprJNGhTkzVti/f36bqS41Bcg/6W+NR6gnkctl
	Z5Mr0D6Tw6w9NgQ8lijpw/WWMeaNsT3IvllViK7XkyEGm1zt9dw/hSef59XJzfA==
X-Gm-Gg: ASbGnctgYG87emttXwQBLsyHytnAlT9wXY13IF7hN4g/72OyWe4svocVwfa0okPjdbj
	1GFiZ/NDp79WNrTP1URmg51ww3R25St74oEh36bdLAyAXcrRv5JEEXl2T1NAqkmeGx84Fp2CjVt
	wPIMUmZ8x63ThhOWL3jssRb4n2NCr8xrpNgbdj0b8Vb09AyZ8i0a+124T14OfUGFKBzRmEgqJwJ
	6thAI8Fbxr2mLkd0Infey9DwH3nivniQaqBBfkyVS2JJkSqW4WgdGVE/+nuRyYU6Q/EhbaTx/Nv
	HrZIZTmp+TLi0qxo/vegBD7k1guvM01zXWaiY/WdhCY=
X-Received: by 2002:a05:6000:4819:b0:385:e13c:5406 with SMTP id ffacd0b85a97d-3878768e893mr2859489f8f.21.1734004337359;
        Thu, 12 Dec 2024 03:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3N8A0Ggwd5o/UsJAbeJrpIatw0dxmVjtUtM1F9p6Q9Qhx0chkYeFNKJKkp3A9C3hhq3niCQ==
X-Received: by 2002:a05:6000:4819:b0:385:e13c:5406 with SMTP id ffacd0b85a97d-3878768e893mr2859479f8f.21.1734004337064;
        Thu, 12 Dec 2024 03:52:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-197-226.as13285.net. [80.47.197.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dbbfsm3774727f8f.97.2024.12.12.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:52:16 -0800 (PST)
Date: Thu, 12 Dec 2024 11:52:15 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH] Documentation: sched/RT: Update paragraphs about RT
 bandwidth control
Message-ID: <Z1rOb9D29H8ZCNqd@jlelli-thinkpadt14gen4.remote.csb>
References: <20241211170052.2449581-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211170052.2449581-1-mkoutny@suse.com>

Hi,

On 11/12/24 18:00, Michal Koutný wrote:
> This has slightly changed with the introduction of fair_server.
> Update the most relevant parts.
> 
> Link: https://lore.kernel.org/r/Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb/
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


