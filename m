Return-Path: <linux-kernel+bounces-404105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA99C3F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA86FB213F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2019F11E;
	Mon, 11 Nov 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gMPFyx47"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACB19EEC2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330080; cv=none; b=HegWLqBZ2cjwvn6ZUARHGmztn5rMQbi7smo0LJrG27wsY13MbFvJI9CJg4tvPrtdikfNVOY8A48IZwjPAhSXMGpVW9JklLMVNXj2XUoGSv3re+BXbQi47TBSumCcmXQdaFtyrzq6RHphcX2OYrUEB790g33yIrD3cPGD+Hj28ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330080; c=relaxed/simple;
	bh=qf2AGztpw+7BETXwf7nDVTsN++k46rWO2VTfDVlLK5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivCvFOthCyd8/dFQJAlcyaqF/wI1eSqo7U6/DXttAuh2Qqsgu/8JqIKLbbTGEC/xRS2UfsDawjA8vEF0+ca/gghUCXK7XaylQYJxnpRssgXAAf8Jluv0+lfAdpvFk8rnFg9GfgSVCcVX6K/IxBGEFrrr1s117HHTdIjhYc6EWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gMPFyx47; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-718066adb47so2647772a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731330078; x=1731934878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7besB3ixSfCVoUejLs6eREEKOfBEP/PTYOw4wky3o0=;
        b=gMPFyx47VFMbD9Vr3lhPd2g2AtYLsA8xcjEsgGcjHLn8J/0YLIb5O9tDeW8d7R+PJb
         THtY5L0a0PnGsR7krLgYxNJIsPo+Sd45EejlJMX/aVMaaUkG2g/RWUKz7INh7HuQGpmj
         hiLd1ZL1JuZbi05AXZYSkSSBM6MbRD024I6uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330078; x=1731934878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7besB3ixSfCVoUejLs6eREEKOfBEP/PTYOw4wky3o0=;
        b=dCvvTKEfGI+4mKIw+JQA8rSmR3E1iDQIiZjmLcEEK2qxn/S3frth/KRT69K6jRz0Yh
         GuMGdIccvK4Br5I7Gnyt6ZEEhNY1lpPwA5objYyFjUB+sRLe3sr7h2vs9o/EpYd554Tc
         67R/17KdgPZSim135ZVC3+mSjscUjoUS/SVARXXJhnpK6ngxkrT2xusp2jiLIe6zsbC4
         vL9VzjlSdpiFIxWg9jPhVGR1ec+X0nx/RREQ4dDyW/Ta/rydr7ZNv9T3ICerYW2Q9Xe6
         kjCcuNP1oy+T9AANLfPycBLmPy9Rgu28oPOz09Hrtl2od9euu41fvO5LvvZVjens85v6
         Lhog==
X-Forwarded-Encrypted: i=1; AJvYcCUqMosfcbWtqPbAVRh9MOhH0IQjpZyyxgcG1t2jdXCXYpTqbk3fZL+PsE/zAf7sGzd2kHjDBhfeRQmAGMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1wmyxGClm/tbGLShLwjHQCc9XOrVE2sjEuwcG89ty34f7bZL
	57PEfyHL0vcCvaFfrT7QbUSSlOP0aM+GTgZtKwE+rgK35bo2SAmiBv/2Y36AuxXm3KdI4hMm/2u
	T91MIWghgnckHWK+p4L5wLt/RlRVvoe4mpCj7wA==
X-Google-Smtp-Source: AGHT+IGTNR7cGBhWbfaR8/LY/XXbZYRnyStViZVZY5OqBZJ63cOBmilCgtJZBZNhHUm6JzzZgO5iJKLQ4tdLfRc1bTM=
X-Received: by 2002:a05:6830:6c10:b0:710:f3cb:5b9d with SMTP id
 46e09a7af769-71a1c298638mr10012904a34.24.1731330077736; Mon, 11 Nov 2024
 05:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241107-statmount-v3-1-da5b9744c121@kernel.org> <CAJfpegsdyZzqj52RS=T-tCyfKM9za2ViFkni5cwy1cVhNBO7JA@mail.gmail.com>
 <de09d7f38923ed3db6050153f9c5279ebae8a4e6.camel@kernel.org>
In-Reply-To: <de09d7f38923ed3db6050153f9c5279ebae8a4e6.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 14:01:07 +0100
Message-ID: <CAJfpegszxKkuXu-7LibcL+40jYa2nsh5VL1_E2NkGr1+eN3Maw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: add the ability for statmount() to report the fs_subtype
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:28, Jeff Layton <jlayton@kernel.org> wrote:

> As far as I can tell, the existing cases in statmount_string() either
> always emit a string or an error code. If a string isn't emitted, then
> the two EOVERFLOW cases and the EAGAIN case can't happen, so I don't
> think this will result in any change in behavior for the existing code.

Both mnt_point and mnt_opts can be empty.

> The idea for statmount() was to add a statx() like interface. This is
> exactly how statx() works, so I don't think it ought to be any sort of
> surprise to anyone.

Maybe, but silently changing the interface is not okay.  At least make
it a separate patch.

> That said, if we did want to add a way to detect what flags are
> actually supported, we could just add a new STATMOUNT_SUPPORTED_FLAGS
> flag and add a field that holds a returned mask with all of the bits
> set that the kernel supports.

Yeah, that makes sense.

Thanks,
Miklos

