Return-Path: <linux-kernel+bounces-225353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814B912F81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B0D28197E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D217C218;
	Fri, 21 Jun 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLC/wd+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CE770FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005163; cv=none; b=i+lKrmE93LnoXAOJW80RN0pqytz45rM9VbnIMUOEIPrn2sxMpinSmJdZptQdZk3+QXcKAAUuOdnzdKv4kkkFBd28PosOu+LMT1CWbVnayViAu0JAsB8e8D29S0w38B/FozsD/wSe5rboD6FlP1NCxW+oSZdFGHLjMDduNr1lk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005163; c=relaxed/simple;
	bh=YDYCA8wJOBA3X8vhr3CVeTIV+J8Ha3LSgJFg76UCzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdUMgHmpEEceFsPnWIYTCyo0x+kycIMaozX0Q47ysaBGBIDckRck82owzxfCL1RtXTy3YMLSbtAzmhOv6ZiJcDN6ERXkfNzHnBazGmNarBThBpI+LwIutiuDd4D3FPd9wm25W/YR64f+IKeNP8/D0o1aVFy2dyoyi8z+8TzN+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLC/wd+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
	b=PLC/wd+XLbH4Ji4dplFxzpmJGCvWm9Jyk2/m5vpin4vxADvDZ8w9SMBUQaINRX8gBTROaB
	ZJvhU/4c5Kegu0jlADmWRkdzqwBmbfmjAysNb2xNUTsBKFgNks0l2pgOJwUv9Rr/Vu3F1/
	cO8r4HNnXNmd5d43brW4hKmcDoBnle4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-U2wdFwGqO-O4dYPaJ1Ft6A-1; Fri, 21 Jun 2024 17:25:59 -0400
X-MC-Unique: U2wdFwGqO-O4dYPaJ1Ft6A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43e2c5354f9so4320341cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005158; x=1719609958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
        b=KT+Rt0WiwMbLdM0OvPs9M5r18JTp8vN7v9xxDCG/XPflawnaakfbliLQiUpbCj7xBX
         44zDt/5Wl7C+Bd3CTCYkwOTKfqZb8uaIIFecmzxeOiPiCjjWk5q7IsVRETvP54RAW8rE
         Vb1Icbs7znS5aHPw0XEXsl70t0oYl77rT95gMtHqoBF69/oR+8C1dsMGXJ2fHXdFMf4X
         xHZu9F0jCl04xtsi5dzNyZ3BjW/m1pqQ0VOBZPB4+t+xG+rpp5Er1ZMPmsaQA1NHtTdy
         r7Rlg5Ih5aDxyNQsIBclv5kq7QT67LjvXccqgLx3uFypb66NQDVU52oJHIekJxZVdrwx
         8Dpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXG6oiLWJpOssPCWoOL2MmvfJ8X9lhOBFraGKPxPk61NX7me/MAXeofOojLZrI8+SjeFVXrFEkInupCRB7IdWrHFVK+Ms17KdED5O/
X-Gm-Message-State: AOJu0YwnnNgPdB0qh5XrWl0DdkWT4zo806lNauO6xUubzuhWkz1MaJ3q
	r7cX6Vu8Y8EomYcu82sBiF8g0ssSFHZHwfXrhu67ftjodAYjrliBKNNBN721ZVYPYuC2Lx0RDLt
	V+xtj+iY2Q+qRMnv54IDXctpi2IsT7r5iEcggT5fzqXvAdY78kORyv7GPInLraE5tJkawuA==
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680756d6.0.1719005158445;
        Fri, 21 Jun 2024 14:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaMaAMcHEU0045p1ZpCQKXUo66j+A2d+/nXH5cYrtdn67byrEdkgmV5fsdBs5DMdo8eDr18A==
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680436d6.0.1719005157881;
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed181fcsm12172526d6.39.2024.06.21.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:25:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-ID: <ZnXv4rsk11KLS1xF@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:22PM -0400, Audra Mitchell wrote:
> Currently if we request a feature that is not set in the Kernel
> config we fail silently and return all the available features. However,
> the man page indicates we should return an EINVAL.
> 
> We need to fix this issue since we can end up with a Kernel warning
> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> a kernel with the config not set with this feature.
> 
>  [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
>  [  200.820738] Modules linked in:
>  [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
>  [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
>  [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> 
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Please prefix the subject with "mm/uffd:" or "mm/userfault:" if there's a
repost.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


