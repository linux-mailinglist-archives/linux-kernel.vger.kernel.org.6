Return-Path: <linux-kernel+bounces-192767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD688D21CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DA1F22EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A540172BDA;
	Tue, 28 May 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dgPbYLq1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A916D4FF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914418; cv=none; b=Z4oxxw7cu0398KmK5G2pfLDk3o1vgcQLKGUbFQ5A8uDeV+Am2GgBRP+uByymzUGsctxL1q39n33irfvBOblgrf0BFiUef8VlGzroITiu8PRr0R5+GPvxE38TGPRYfxYI7OkdYvMKPA6aPVW8VBh7pukXKRhe4RdbBMdcLktDSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914418; c=relaxed/simple;
	bh=GhRez4Fx0Z0cdleXvJ6KlvooAZU3mXVtsJ2Oxo6UkJ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN8kgHM0BXtYzN4rLj8SM0adqN9uNATMi4AHwYynCmVvPfSqVUNV+c1lHINKUdwVaXNJCEwQMSNDYjP+r33NTc5f2g1jndOTckXRb1w7W5LVXEiSQAYtmlkuRzr6/M5kpSNy/1ymvqqjTH7GJs1szLN2KasrlGHaY3TOJALAZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dgPbYLq1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42108739ed8so12223045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716914415; x=1717519215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+bE3y23Y2jc/sZ470W5Ehr4+nLRjpDlijTRzceXpdw=;
        b=dgPbYLq1OryBxByTEdk0sqznQOsBsd0eIDmd68uTGSYJXEv0thY5vM4mQql4nUEZJR
         vO4mGy9VWUszHRwwZFOSePvh/PEv6U5DqixX79HIVxVH5s0EFn87VxDoj+tjEThI0aGl
         UQsQ7YPLzF/PsNTBIi5YzCtZSFu/aAzJ/7leBoiKG1sfT2wa5w73qX/4xD/WTP1f6xFv
         TKT0C9OgiBSTWs8nS3njwxRtYtFM+722Ehi/Cb4sE/Bu9yTLTQyW0qz3ZWCFdmXxbdPa
         UYE2DrRVoBjIva1VMCPb0GJvcWYqhX1ecM83R7nqeWXX4br3e4qbWZkED5QhUk8CJVQn
         yyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914415; x=1717519215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+bE3y23Y2jc/sZ470W5Ehr4+nLRjpDlijTRzceXpdw=;
        b=vh2BxDR0g+SQh6SjmcuexcWaaXV5rEURSJlahqkx+Rw8y6QfOgRD3e4sIQr0xm5LTy
         BpEsWpaybFDW79N5rzu09lQa3yWAfguP8H4J4qiShX5k6FdutgSm2tfSnJMVc5ovl4KN
         pMveNhk7zyvL27iGE7IXC/52V2kbIIkN+Jm/3HSr18AowGFkjtz7GZeFceOG8MzyB9T2
         ZMInNsvjmYruWbDm46zdTUjzlMtmzIKfDuVYE8B+7bJOR+xRyRBNOWk8j8U+uKFBZK9r
         xMSuhwAT0qpxpX0pgiSAD83SnkK5/4N22dOohxR1bYoXFZ/7QQ674dgaXih5/OPZiGwi
         938A==
X-Forwarded-Encrypted: i=1; AJvYcCXc4WYf5knh72YLYy5+G0B+VEx6VwXb1CTfyoEpXa2BexNNPtC5iP6kB5OfKYIV3dlyIwtw8yyfjsYsAZqRQilLhVla6LRQqUflov14
X-Gm-Message-State: AOJu0YzrrmWZypuL3gso0eIAJvLhioH7zxKSypAZiZbR9eQulpj54qhU
	WrOP8zw/5FLF/d6UHw/D5E20EHRKjoZb1GvuqLlS56QhrZo1B2KpeZykfeANaQw=
X-Google-Smtp-Source: AGHT+IGzWjnSFkB1ANBs2PNdU87HLzoQjdhoU8WSS6pgUppme/s6M+LhP97xyCLiBusTlbckGHkTMA==
X-Received: by 2002:a05:600c:4f96:b0:421:10ce:8aff with SMTP id 5b1f17b1804b1-42110ce8bf2mr86779085e9.19.1716914415293;
        Tue, 28 May 2024 09:40:15 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089667fbsm148191035e9.9.2024.05.28.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:40:14 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 18:40:12 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlYI7BjSgxOy7dbg@localhost.localdomain>
References: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
 <0000000000007cc41d0619857dd4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007cc41d0619857dd4@google.com>

On Tue, May 28, 2024 at 08:43:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
> mm/hugetlb.c:5782:4: error: expected expression

Heh, silly me, I should have compile-tested, but was confident.
Anyway, now pushed a fixed version.
 

-- 
Oscar Salvador
SUSE Labs

