Return-Path: <linux-kernel+bounces-320183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BA970710
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4EE281841
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2014D715;
	Sun,  8 Sep 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ezvQi+xx"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3A4503C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796049; cv=none; b=CCVwXKZECbEjgpP4jodZKffveEl0Z4B5KI9ueS0u7P+w5h6HH5KJGKvM9Zj7HO/lqY6Yrsyme70xSo9tso11mBIg87wNRw+YWCJGXgDUuy/G+BjH09DWjKx9qzMVBv1GyToI9pTO7SEX8o5Yp7SCNmRikHMKQPb9yYhH9iE2dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796049; c=relaxed/simple;
	bh=jtRozMCqHc7WAtSy8GtXCUAgI+/uLULUjFjpmDCx1BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHqkNGWP56foTTtE8NfNO2oYlv5xTueu1ovshWFN7IOiS4YiqVOEkY120M4W3AWgNuGJMZHlbJ1v28qJDsAqV67VuTFOyk4L+rqmP58Yx63Tzm86dWjlZVlEuWBpmOgfUQQ+SlKuq2CzmB8kzAGjxqp+Sq5+nH8m0jb4Qr5u7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ezvQi+xx; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-717911ef035so2641948b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725796048; x=1726400848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiVlZdnVdy6Xr+yAc6DEZPfqEkuWd1ztxcvH+Ob17IY=;
        b=ezvQi+xxAKdWroEwTB3PLc5hsOMlw1JrxPp0AnwX/iy8DiDmH96YEAcYY3P9ESmhZX
         A38k8vBbfrtLqP/ZUfkq9XB+tN7pFnZVUNh3MzNYGfRHQ6rA74rxmvCA9Laxi/f7EhVk
         09l5s+YayXFk3WQF2T5+jMbatE4/tM/JkWv0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725796048; x=1726400848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiVlZdnVdy6Xr+yAc6DEZPfqEkuWd1ztxcvH+Ob17IY=;
        b=K+SIE7isuqjBI2AQLdjUJWgX1nS5SqewYaNO+9qwGW5GdxANED1WwOB/cDBSB4CZtC
         Gje3Kx5TY8aa0IwY64OIJzrjB8F0f3q2mmxy4nkdqaB3ScSfeWeUGaTTVrS5MFdxAo+j
         f56+kygIzkukQPpplnmiNhUsD0HwQEtFVZAMunsfMvIT2II2EKMYFv3Hni/M/INNr9jK
         LMcrW22M1g/PKaQxPL18MCM7JZmY3orO7ygOZ51qXls+ZmARLzGUO6TZA2pgFyiUZgWJ
         CTsnTi1icJqyQ5EVlX02JBrt46pAVy/Mg0QXsqBMOxTIPQfZYC5IfdpMUkCObjcs+LYt
         Z+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkXmKAfCm9Cx1WHNbNDJDSj1GTzyTBpGcwwYj2i9xsuFeDhotlRIAYy3fFaSpNGeCNk7FatInu9QiglhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+pi5AvW+1Yz4Xdnp/7rXFHPYnUIGsLj2GCVUDhdx1iA2t5V2
	f5xIRo2X8Kn1kNGV9Khzgw0V02v92eHA40WeVa0HjrFVmPWHQuNlyWtERnlpcA==
X-Google-Smtp-Source: AGHT+IHDvEF/14um7USRVj5GiDJ7ENz1S3EJerZh2h3cghahW/Vm145ZbSoN6HwE8gnH0cB2SXHY5Q==
X-Received: by 2002:a05:6a00:66e1:b0:714:3acb:9d4b with SMTP id d2e1a72fcca58-718d5ee03c7mr6738982b3a.18.1725796047838;
        Sun, 08 Sep 2024 04:47:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c69ebsm1964793b3a.57.2024.09.08.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:47:27 -0700 (PDT)
Date: Sun, 8 Sep 2024 20:47:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/3] zram: optimal post-processing target selection
Message-ID: <20240908114724.GC2413563@google.com>
References: <20240908114223.3024872-1-senozhatsky@chromium.org>
 <20240908114507.GB2413563@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908114507.GB2413563@google.com>

On (24/09/08 20:45), Sergey Senozhatsky wrote:
> On (24/09/08 20:42), Sergey Senozhatsky wrote:
> > 
> > v2..v1:
> > -- clear PP_SLOT when slot is accessed
> > -- kmalloc pp_ctl instead of keeoing it on the stack
> > -- increase the number of pp-buckets and rework the way it's defined
> > -- code reshuffle and refactoring
> >
>
> D'oh... Let me re-send it properly.  It was supposed to be sent to
> Minchan and Andrew.  Sorry for the noise.

Re-sent under the same name
https://lore.kernel.org/lkml/20240908114541.3025351-1-senozhatsky@chromium.org/

