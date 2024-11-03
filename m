Return-Path: <linux-kernel+bounces-393904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3619BA749
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B924B21A97
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A917BB1A;
	Sun,  3 Nov 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLCcVtXC"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF77080F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730656229; cv=none; b=Ek08jlRZCd6avH674werUzBwRtSZj0ysd32cpcT7+zc4KgJSZQZCXfm3Kv/lyAkVMD4n0LxBCc3SKeeBHF2GDJP7r/M1hqHYIJPOmAe+Xub4bvrTCSZZgY/JK6o6qPWTMdOntqCNoOlqT+KPOTjYw3ojAedAh9/zZt4yPVKxXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730656229; c=relaxed/simple;
	bh=rV8Dw31hL8PJUzAzId38ufghwsRz51LOwUvKyOAp6xA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFEaNyQIYOSD5tQ05tpDkxg+nZHICVKB7CfCaPWbyPDQWFECD6UlZO0hLFhDrRi/tnS4V794oJe6DBBC3y2qmj+PqE0uzc351unJNY4ZXQy0xamzdM2tNoNBV+nwjlaWQorgXFrJmd1CPegWDB+BfxZkJNHoHF3UfslyE93BAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLCcVtXC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso618928866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730656226; x=1731261026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltbmxni4Ig6VIv7g8rtjq19v+cbmckPc/oW9ZpyR8L0=;
        b=RLCcVtXCAKJsLW884lAbrTWXMDc94Rf8suat/1+hJAugVvU++vm7bDsJK0u9ZAA9jU
         pPD+gBYwNmSDXLIYWxKvdotWem8i8Q4dMfCfOMYVayWa6fiitiG3bbqvc0GqGLJzVtSL
         lxR3Qc7AN8Dio+9I2XjeP0NJ4tF6eB3kl07PciFuHoB1hOYZJpYlIYnYBsZlEJkhwhtQ
         worj/GkVuuGTFEaHZF/M7pwZeVoKynSSxJ7glaMkSSJLZxbdAyDPdiheiQn+GRMAg+oU
         wu1f4q6dpqMTthY0PeHKRby7tGqWFDj60KWEd/cl7cq1lLHZ3FDO2nlnHNGla7JLkFk1
         OulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730656226; x=1731261026;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltbmxni4Ig6VIv7g8rtjq19v+cbmckPc/oW9ZpyR8L0=;
        b=O+UjM5qpmfvHaMgwA+rQmBHsnNpXjWi1ZDcPJVWJ57afSeUALvc3ibemvPBI34coNK
         TaHpTxx9rSU7vtjHsQbdg+/If+C/OFKqway3iZ5wCz6xsMa/XnmgY6oYkAb2ogAiV6yf
         D+WFBnqNztWWvPYjtYUGVwagop5ZUc8zsuVDNBXPbu/b1T/UTlzlXeDV4DGhXcbL4Sau
         wRPgzXtfu3oRIvL6yDJjkQ+tic3JahTlxv+cjA16lP8bUzpdGkXtKoxH2Pq6SfvMMuOW
         ZG2PjDbnpxJZ+4H/NfElo1BGx726iQro+QgOqPfuC4+IB/MV1rp+f8tq2fbSaTsDTW9B
         bB8A==
X-Forwarded-Encrypted: i=1; AJvYcCXyKkpF+DYK+A7Vk7pNjxQqleOc/FyCTcgsfHv7f1MhQyrwMgz6AWzy5rVhm9d3e8dFu2G4+w3sVqfGj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6wrGwsLoaSq9ydV7EpkqFuFKGklq1n1GujJx9t/D1ZcG1hQW
	CRuRvq+q5z+yCVCU54hzKtSgafBoMRfVxbbAbO6ozlv98xfOjTlOBeDcgx7XEIg=
X-Google-Smtp-Source: AGHT+IENCImvfO2QCr1lf+/YLNCq2Ar5y9VgTYTz+UawvMnJepxeEvYadyyXZrISn1tbPDhGiTomxw==
X-Received: by 2002:a17:906:c10e:b0:a99:f183:ea8a with SMTP id a640c23a62f3a-a9e3a61d7cfmr1748975066b.28.1730656225357;
        Sun, 03 Nov 2024 09:50:25 -0800 (PST)
Received: from akanner-flex. ([79.140.148.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565ea53dsm446538666b.114.2024.11.03.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 09:50:24 -0800 (PST)
Message-ID: <6727b7e0.170a0220.294c3c.d58a@mx.google.com>
X-Google-Original-Message-ID: <Zye34hCwhRI9vwu/@akanner-flex.>
Date: Sun, 3 Nov 2024 18:50:26 +0100
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: remove entry once instead of null-ptr-dereference
 in ocfs2_xa_remove()
References: <20241029224304.2169092-2-andrew.kanner@gmail.com>
 <cfd351ed-01d5-42e6-a764-2d915bd3adeb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd351ed-01d5-42e6-a764-2d915bd3adeb@linux.alibaba.com>

On Fri, Nov 01, 2024 at 08:53:18PM +0800, Joseph Qi wrote:
> [...]
> > --- a/fs/ocfs2/xattr.c
> > +++ b/fs/ocfs2/xattr.c
> > @@ -2036,7 +2036,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
> >  				rc = 0;
> >  			ocfs2_xa_cleanup_value_truncate(loc, "removing",
> >  							orig_clusters);
> > -			if (rc)
> > +			if (rc == 0)
> 
> Seems in this case, we have to ignore rc and directly goto out?
> 
> Thanks,
> Joseph

It looks so. After ocfs2_xa_value_truncate(loc, 0, ctxt) we might have
ocfs2_xa_value_clusters(loc) <= orig_clusters.

But we already do everything we should for '<' case in the following
ocfs2_xa_cleanup_value_truncate(). And probably should just return
error code for '=' case.

I'll send v2 with your suggestion. Thanks.

-- 
Andrew Kanner

