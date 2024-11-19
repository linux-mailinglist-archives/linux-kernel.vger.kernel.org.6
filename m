Return-Path: <linux-kernel+bounces-414097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D59D22FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F69B24317
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54BB1BFDEC;
	Tue, 19 Nov 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAQ/jXKe"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B741AA1F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010554; cv=none; b=jq2692ibhSUc2zbzPndn/G2lX58AuTuprUOSCY6ApqJZ60fomyBpz1ZWdZag5e9umAgV5s7bdq7voO0MuEMnpAPxoK1bTgrcuTLic9yNiIH4Knn6MArrQZ9lmDf0nRRzf1rFFzvGZFC2rh6SIxcZpc87672oWjyi5+QQsRa9qpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010554; c=relaxed/simple;
	bh=U/dnkg29CFiAagKOAy6WY9VH/O8NhrnUijHJPbJH064=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmgVhtdgS4lUC7tIOgbr1cFw6CyfWLOSl1Qli9Rl+DzfVxPKM3FbK8rRYIp07CiFnzCBri6UG+JvatGg3++gm+kCbgJ9hslYW2/SmLHeND6XazWZrb6fFazcL20Y2RguEmVfkCNG9wrFZRKFo3WMEhjN27FmEE4sa/vIVe/ZNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAQ/jXKe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa20944ce8cso936651966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732010551; x=1732615351; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKktQgA/855CKbZagQ3pWk/uvzbosXgHDEz5A5W5b+o=;
        b=CAQ/jXKeCRlheCUrhNog42doDr56wdVjrLyTcd5tG0Nu1BdpxHcxXii+b30hv73mpJ
         HNxJNuUpBVkcHH4HEUlUvIWAxrnFltvIQU/0g/8tgP1sVyrIwbekp0oS1oSDJ1cjG0ux
         VnMe/SQQiA5iLdWA/uSpPs5YuQDO/8Tdma3trjdC6OXBWWfC1EVlP+G4TGlqWcV3rpJe
         qI4Mqj9YT7I4mYyEabo3uaK4Y9RZrOPH2kazKsgFLPSfw4J567A/JYljuVXBqb6PVCcv
         OGoZ/qG7yCbVdKsTNgnman2KLyqzPTx2Dm/1BQYlww0rrK601NZC8RNFJaZVx7+BTt+i
         xNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732010551; x=1732615351;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKktQgA/855CKbZagQ3pWk/uvzbosXgHDEz5A5W5b+o=;
        b=xVpHOR5PN7xW+f9wcVNvN9hEA1ETIhCdHM+icQ33ngb0qTPRGg7Mr91/YK08bePX2O
         l+uHdoJprUPzbqluAAUU/f00z4AdaAIHhYiw6zC9+maK7Q6AnsfRqtV9Ds+Wag95W/eL
         ldjUnCt5UnU1jpW2dVhSDrYMGbjPUEhpEYyh+v55GvXy3d88G06lqZ5Uiv7GYvx+ibv/
         tfeUseAEmeBy9Dm8CSwzfT6BXTnVW2LK7EXrUrfN6JMz41zYCDP2ixQ4xp1jG6f+w6zw
         B1tLnZJwx5uTURyy7Vci9ZeWvYpu7uh1OX2qp9b9esZ+lRvvw+T1Fr3/hhuFZZNJyieD
         GEOw==
X-Forwarded-Encrypted: i=1; AJvYcCXEom40fDJMT0ZtR6RqhfmD1fK1E4ky3XGZlfExcIDZ87giooLgaXRcVX+v03wzcyz/eIH7599n8t1msTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9qvlevNaf1MpRkdVoBWLChzXrH2FC6B+x0vUKyS1k9AEsnCk
	LTPcogngolQz2+ajxz1UloGerdB1E+iphM9WxdIIdqnSv+BQOls+
X-Google-Smtp-Source: AGHT+IE1ni1f9PRiK+TCqoMQX5SxmLXKEhMDrdPkJ8b2DQOadGlCwTjJ5uqwSnTQ4UpXJyZerlw5ZA==
X-Received: by 2002:a17:907:7ba3:b0:a99:3db2:eb00 with SMTP id a640c23a62f3a-aa4c7f2d47fmr234420566b.28.1732010551005;
        Tue, 19 Nov 2024 02:02:31 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26809sm642329566b.27.2024.11.19.02.02.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2024 02:02:30 -0800 (PST)
Date: Tue, 19 Nov 2024 10:02:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correct typo in MMAP_STATE() macro
Message-ID: <20241119100229.xxjjmsaaitnaulja@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241118175414.390827-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118175414.390827-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Nov 18, 2024 at 05:54:14PM +0000, Lorenzo Stoakes wrote:
>We mistakenly refer to len rather than len_ here. The only existing caller
>passes len to the len_ parameter so this has no impact on the code, but it
>is obviously incorrect to do this, so fix it.
>
>Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

