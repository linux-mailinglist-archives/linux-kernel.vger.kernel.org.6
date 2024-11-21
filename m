Return-Path: <linux-kernel+bounces-417174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCB9D4FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E267FB26316
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD211885B7;
	Thu, 21 Nov 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxQhsf3d"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FF15B13D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203476; cv=none; b=et5TnWQHqUrcFmY53nqrlOhl/7CTRQRpz70BUZA88HWMqZG5jOsT/L3/QNvDBUrlz61rzM5KJo0aowWPvErmbjzGh3y4w9IH4zTQbSHlXbTh2a1joBqvJYR+8GpU1gaaJ3sDhaAtNvN9th2KuWpHsB9dsC70E+jF0OnW9Ui3FXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203476; c=relaxed/simple;
	bh=COQ5gUt4uk/xJa/73AHWX9zAKakDL1SeqmqD05Nf8OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oav9H4a88mRuGx2fNCusOhHYqQvKnuktzrIj/VVyFaKCK5MyYy5TvvybJqcqW7oV589uWz0/NJwMFG14bACkCI6VWM8pE+z+dS1tRDePmOoN/n1rjeTP56uKTu0ZTlvS7ega+BAeuFvtKYegQEDtX4291ZIwUEDMFuEsoO9aZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxQhsf3d; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfcd99846fso1369666a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203474; x=1732808274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wglTG1AjoEedTAO/LdRXi9+eQznoDs5r8oxQSUYVkgQ=;
        b=KxQhsf3dbZNs/xCRL0NCOiVFtG+2venygVMqcq4Zga8GCkLxfphwsbDodRZu9+lD3m
         cc/v0PgO/mD7LOY1lBqvnBhudafR3BLpGTPUWxvDSXs7ra2p4rvFhhAwQpiGuy3vx+YY
         KMZ83OmjeVKrN9+nXK1lrF2u3wicafRUv9I1s0C3o0kA/lr7au6IPiqde9V6MVe0VYna
         RQ0x6EDMenW+yNJGtzDybsVzIOh1sMIxBOul6OxY0BWe67/XHgBfHeDg3SDByffl4DiS
         V4W9C+2Bg+jxwL/XF2Wx4utFcWPRA9XUF4BCVUVMJ3ADDG43/ZrkRMPuWcqGm4s7TJZ0
         BNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203474; x=1732808274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wglTG1AjoEedTAO/LdRXi9+eQznoDs5r8oxQSUYVkgQ=;
        b=jOaYjXgrFMV3y8Wbhg/aUItrMvKdtGEBOH/oAyUGR5aAdTbR0CEbw28Jo8LfpQSAfi
         +ZdeXj+HTnXTcZs6GD9UEvjb1I0HWJGIqmfszHJMX7r8M+0xtbkGebloRNOlBXvzMKtN
         GmMrEp6h68dIo4OM+qcLmQN+ftr/Mbo9uwuyTcwPHu1/xiy6JPMAxS28Go4Xxg1bYbZv
         neEnSFbQk/HIFscaTc4Br7SXyKEgr3Qlg350gO9NJI84BDDRy7tkaLS57LluNHnMazbg
         bpkw/jlh3psYBE8FwuN1EcBq7Z0hJvcCispN2PjRu2H19pxeL1uJXa+mgABL/7zPg0/n
         +RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy//5CaGfm0M1vbEIt6beWmV+q1nd2PTb5YWCsz/8ld8VPLVi9i5gc6QrPM1knfFO26VYtUfqOvFH5VtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNalrzDXbMXZLfBsnJocwlHYgOu7ypJYhTMRSYhuKWp5TU+s5A
	izLUbO6XBdNH9OB7sZQT2MgymVlnJVV6LWNidfbQ24KSfYHX8xkYf/5gFkYr
X-Gm-Gg: ASbGncvjBJFzHXStKlvU/cduwUJEY+FfpWwSXa7gg0FhbC6abHpNY9n9Qz8tmnsuLXH
	1FF0hG3H/c7NYjuKi5PqRQus54L7liMc1M/wPVtXktb4sGfab9VExT16ooCcwTl4z4W71JLLwKO
	z2a1ny5O5J/wtsnx5K3UZzagkqAL5B1H1vr7zcQrrMKWQTsZTUP4VNLgubweLcypRduB48O6zGt
	UrM8FAHrdMae2KvzkHtyV2X720Pq6K+3FnD4KWxlUDmz5WOoC4=
X-Google-Smtp-Source: AGHT+IE4Vo20qkJ/S7ZXsIHqruUkrGy/FNTj1vtn6NQozHSObPQ6nbdR7JDOHR5WQxM5Nu+ea/ZqlA==
X-Received: by 2002:a17:906:d54c:b0:a9a:c57f:964f with SMTP id a640c23a62f3a-aa4dd551548mr683639966b.16.1732203473699;
        Thu, 21 Nov 2024 07:37:53 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4380231sm93034966b.198.2024.11.21.07.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:37:53 -0800 (PST)
Message-ID: <d95d3972-6280-398f-047f-23f19e1f9e5a@gmail.com>
Date: Thu, 21 Nov 2024 16:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [git pull] drm for 6.13-rc1
To: Dave Airlie <airlied@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21. 11. 24 01:25, Dave Airlie wrote:

> This is the main drm pull request for 6.13.
> 
> I've done a test merge into your tree, there were two conflicts both
> of which seem easy enough to resolve for you.
> 
> There's a lot of rework, the panic helper support is being added to
> more drivers, v3d gets support for HW superpages, scheduler
> documentation, drm client and video aperture reworks, some new
> MAINTAINERS added, amdgpu has the usual lots of IP refactors, Intel
> has some Pantherlake enablement and xe is getting some SRIOV bits, but
> just lots of stuff everywhere.
> 
> Let me know if there are any issues,

The patch at [1] is needed to avoid build failure with the current mainline.

[1] https://lore.kernel.org/lkml/20241010153855.588ec772@canb.auug.org.au/

BR,
Uros.

