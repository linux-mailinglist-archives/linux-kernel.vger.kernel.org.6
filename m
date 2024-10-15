Return-Path: <linux-kernel+bounces-366379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA299F488
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87D11F24B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD81FAF14;
	Tue, 15 Oct 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oa/eAWli"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9D1FAF0C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014974; cv=none; b=IbEnWKjnBARnWXTPbDe7SYHDs82XYBwMmgeLW5YkjNueJgq32zwt+INGIXdIrJEOS4i6CurzkCZ1GvJRCSVPM58LRmB7bxFiJw3aiLmFex+buqgQB/CPljkGHBB5BMqO09LEFrhj2oKiH1OhuMlJ4OI83oxhf9Oskp8uqfzL2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014974; c=relaxed/simple;
	bh=mUGZm5vcRhELl9M94Au2ltqq+3EPdrRv1VatTxlX5zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcKSE2tNAjNLmXzNTZCr1002pe1Y+DGdeiUqrC0gAbdrPdDMqdOw7dmqidxfViSaQnIeibaP5bvf2OGPXMGg//47z1uoe39iZ/2cwT/Uol352Uky3rZn34aw/txFTAd96A9pO4PjQAorgJ2wYEA0KwBk/Pg1q33WiZI0lE7vIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oa/eAWli; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e6f085715so1676737b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729014971; x=1729619771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MdM33dUKv08lPEDtPHcESBgrX05DyJmGGOXHjVz/zgg=;
        b=Oa/eAWlijMpjaQfMhBIJHJINzW08ok3ruCEx9HQWOIh7/noGnWsb+T5VbU+lnLutCz
         0iGyYmVyeaCGoFSR3/b+fzMR62osUdbrncfuHkB3raFFMRw36bIJBU7++OC5s0vecWeV
         7Bb+UjUHS+RzDAcFX0Rg30xlElE9KnEXIuMfM1q91WXCLABSav8dRudccAkt85HAIdcH
         7ai/EyXizdVUrW/aRlkUQ4M36PMbf85maDk1EBv4V28GokHMVSGWxYB8LM1g1JHyMGuu
         Imd/9KucpOl1a/+odBvD8bL384Mzd5c3qbXQLfIi3wesuLIhEJ632ArYrwufTwJv74Bq
         xTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014971; x=1729619771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdM33dUKv08lPEDtPHcESBgrX05DyJmGGOXHjVz/zgg=;
        b=BbDax60NFfg1K363ku/W9gWQo63WdzJ18NxPWaoBV1nIirXod+8kT3X81+L3InQDy7
         gr6cWX8/gQwfC+ukyZcKDwxFBIMim4/INZBCwfY5izPwXFObbibqxdVhIXXOUtexIRiy
         0RgA3xwQpukYKn2fL8xjM7OkTNQnKfwj+7QWIyxhZ3XBDxsNBvTinQuMaMmYkdsiNds/
         t9n/BLH0Oxzkhb4hoEeVgoGipjFQLz6cyXyJoKd5x0x7FUq5Jas60DvYK3TU2Q5dLSBJ
         v/vRHNeB0DRtvLRg/IME4dHG+upVjLMLKH5JS9Lg3WPzXrzxfHwL8Wm9gvmXYY85Wltl
         wCPg==
X-Forwarded-Encrypted: i=1; AJvYcCVQTCrsJIVsHYSH5hWTU72pBaH35gS0bEiI3IcWPzlxDWW0n/3mMdKYd+S1dhZy1vBToJKLYXvjUbipodM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgEYQ4FXFgnP24frykF4XivId678uNKmU9A9Vy5tpVVVtIUyB
	1xH/2TL6FaOjRexKpb+VYcPxhuMB2dqEa+DwFZ1HjLLDlu/1OqSttWYStbbBSP4=
X-Google-Smtp-Source: AGHT+IE3olMIFM8u5X0bUOwj0ApDJXq1jkLtQNmgjA8AdDpE4+M6Ri68eQ35CDFzQy7sOcCu777myA==
X-Received: by 2002:a05:6a00:b87:b0:71e:cb5:2219 with SMTP id d2e1a72fcca58-71e4c151804mr19892905b3a.9.1729014971093;
        Tue, 15 Oct 2024 10:56:11 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3f26:e29e:2634:fca0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773b1634sm1567433b3a.63.2024.10.15.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:56:10 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:56:08 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, upstream+rproc@sigma-star.at, ohad@wizery.com,
	s-anna@ti.com, t-kristo@ti.com
Subject: Re: [PATCH] rpmsg_ns: Work around TI non-standard message
Message-ID: <Zw6suCNC62Cn4fE0@p14s>
References: <20241011123922.23135-1-richard@nod.at>
 <Zw6cyFirqQ6Esr+0@p14s>
 <3194112.zE8UqtGg2D@somecomputer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3194112.zE8UqtGg2D@somecomputer>

On Tue, Oct 15, 2024 at 06:58:33PM +0200, Richard Weinberger wrote:
> Mathieu,
> 
> Am Dienstag, 15. Oktober 2024, 18:48:08 CEST schrieb Mathieu Poirier:
> > Good morning Richard,
> > 
> > On Fri, Oct 11, 2024 at 02:39:22PM +0200, Richard Weinberger wrote:
> > > Texas Instruments ships a patch in their vendor kernels,
> > > which adds a new NS message that includes a description field.
> > > While TI is free to do whatever they want in their copy of the kernel,
> > > it becomes a mess when people switch to a mainline kernel and want
> > > to use their existing DSP programs with it.
> > 
> > I suspect there is a lot more things to change when going from downstream to a
> > mainline kernel.
> 
> Not really.
> I had to revert c6aed238b7a9b ("remoteproc: modify vring allocation to rely on centralized carveout allocator")
> because the DSP has a sub-optimal resource table, and this workaround.
> With that the DSP program worked as-is on kernel 6.6.
> Downstream was 4.19 TI.
> 
> > > 
> > > To make it easier to migrate to a mainline kernel,
> > > let's make the kernel aware of their non-standard extension but
> > > briefly ignore the description field.
> > 
> > In my opinion the real fix here is to get TI to use the standard message
> > announcement structure.  The ->desc field doesn't seem to be that useful since
> > it gets discarted.
> 
> This is for the future, the goal of my patch is helping people to
> get existing DSP programs work with mainline.
> Not everyone can or want to rebuild theirs DSP programs when moving to a mainline
> kernel.

That's an even better argument to adopt the standard structure as soon as
possible.  Modifying the mainline kernel to adapt to vendors' quirks doesn't
scale.  

> 
> Thanks,
> //richard
> 
> -- 
> ​​​​​sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
> UID/VAT Nr: ATU 66964118 | FN: 374287y
> 
> 

