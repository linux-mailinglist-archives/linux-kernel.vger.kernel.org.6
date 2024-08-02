Return-Path: <linux-kernel+bounces-273007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC0946351
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC57B22041
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A31547CF;
	Fri,  2 Aug 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOR7Q6qD"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5E4C61B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624054; cv=none; b=TEDvhGCVYL5mPFBdHgtML8d1MGlFRZgWoNRGqd3am2kNzWWLhzDrGQWbOybs4nYHNAC8CqUddX77ocmQcZWaB2UU1NRFuXQ/mtuIzF+BjxBXnKRnvGm9UeSbUk/ieZuR5EM5oLaY4v+k5Yz/1YZd5Q6sb8YmNMyNZI9Rau6WwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624054; c=relaxed/simple;
	bh=soaWkkvxMuF/KL4j9NvlZDNMnUsdIhZ7s8k20vjq8Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5r8dthaK7act0Ls18jrZGFvpZ0qIJ7IFy71k/B7nBGqmx4tB4UEWuCC4TzPx8c3b2Y3AQT9mft3CY+7a/GKqx6dyeR8YbMCpusgmJ8oaemMWLE1JtdsfU7JyRhpLwI0LST+whQWguCdyCWdJ6/Ri/1D6YUY4TpcaaFTrJzir5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SOR7Q6qD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db1eb76702so5427506b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722624051; x=1723228851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2MgDSbbqQmpy8ctPauIiw6bFDpeTQHQdACe1c0ZfrU=;
        b=SOR7Q6qDV2kY4RdoTrVv3SCeiTJcqxN0xRtQ2dmVwKoZntX7vbAZ0U5yAaBFkapG1z
         ptf6rUnrRBrpuXJ2SbNaq2yoYd5Ee9wN1wkt61BFGHhIiPEjOVIITwhgv/D4wyDGpUXO
         oaPFTCo0QoTQs5ZshN3ksUc/DNtrXJ5IpDIai6EiCWAbb3tadv0k8RdlFUJA9ajHdJg8
         mFR/sEI5RrTvtGEXVa59id3WW16RuEe+6WXEtWBXuPaIrAPKI/ZzXTQ1Drnp5OKyj3mY
         YSOt//o53UxGq0cgT9/eYY1Y0LENq2pq9GyFNgyvD1bHnfmupn01oXSrfMlAoab8gMJC
         ZuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624051; x=1723228851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2MgDSbbqQmpy8ctPauIiw6bFDpeTQHQdACe1c0ZfrU=;
        b=Vy3KSnkTYwJGDBdkr+cvdifMgoN92YithNjKXU91TupuII4KpzKvGngbm9Ym2OIwBn
         x6fvfjusdCzfyGKVtemnmYUK9Lq9yXd4L2MNGm9VLpZKUwxpF/O6sp09+5i/j7eBgsLL
         atn3aGjvDM9Ho3f0ZRR25QBRaPCVnHyAMvwgvjvy+wvwDHAAFLJLybNBK8GhIiVkEjLl
         rTlt11sNs5mjpLJoZSTszBne0n4H7OEUavoCk+F+q+JoiTKvij+PERSF5ZRqfL0O0ENU
         cspSuaQiDn2qzFjaBLFAOK4G7xEIAKWXrVFod7URv31uSpzjbvXBLz7xDTwiknJhxDlC
         3wBw==
X-Forwarded-Encrypted: i=1; AJvYcCWonEZhZXl4NTrgkDMfKQvcz7SnsRf/F8ddQrtDMx2vKH75N8Xo4DKnOR9w8e8iE58qvHochQf+DARk+4m4EDPF0pY/6uWGa6RsFk95
X-Gm-Message-State: AOJu0YyPviuokVMcSqSyeuyXQgdWST+ilnT8WSu0f2o0zgXPbyv8a5m/
	lfuSukFdn+08CLT0bugJm0neRK8HZx2QSavktwuFIFpQmVlqW6AK6T96AwOxg8U=
X-Google-Smtp-Source: AGHT+IEbOLxLULZE+aqsPWXdEEIDOBEB5UNl3N8Whqj1J3sEeVgdjd/tswCl5f1XStLJ5RnuoLGyCA==
X-Received: by 2002:a05:6808:158c:b0:3d9:2348:6d94 with SMTP id 5614622812f47-3db558486e7mr4949302b6e.46.1722624051319;
        Fri, 02 Aug 2024 11:40:51 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db5637af3fsm572507b6e.28.2024.08.02.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:40:50 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:40:48 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
	gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <a779ee26-fe93-47ac-a25c-b842534e0317@suswa.mountain>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802180247.519273-1-abhishektamboli9@gmail.com>

On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> and uvc_v4l2_enum_format().
> 
> Fix the following smatch errors:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>

When I reviewed these warnings in 2022, I assumed that the error
checking was left out deliberately because it couldn't fail so I didn't
report these warnings.

Almost all old Smatch warnings are false positives.  That doesn't mean
Smatch is bad, it's just how it's going to be when you fix all the real
bugs.  In this case, I just decided it was a false positive.  It's
possible I was wrong.  Other times, I report the bug and the maintainers
say that it's a false positive.

There are some old bugs which are real.  Sometimes I report a bug but
the maintainer doesn't see the email because they go on vacation or
something.  Or someone sends a patch but it doesn't get merged.  Another
thing is that if a bug is over five years old and minor then I might not
bother reporting it.  These days kernel developers are very good at
fixing static checker bugs and these kinds of things are pretty rare.

I don't review old warnings in a systematic way.  If I fix a bug in a
file, then I'll re-review all the old warnings.

If we decide to merge this code, it needs a Fixes tag.

regards,
dan carpenter



