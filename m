Return-Path: <linux-kernel+bounces-561517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86CA612F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5478E3B3616
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343F1FE46B;
	Fri, 14 Mar 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HnMhbbh5"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141C1E991A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960005; cv=none; b=PHbwr3AkzjRqKrTCrVm5p+xfIHQj8QlAeoxrqFx0TBn/Xtgy8OX0FWwtrTdl+W5yrxEfHMsZvlY+k9vK+M7P1yu8BWoLDbuuXGDarj02Q5+viwVeiz2UVDT2VsdM/RKJ8FTSRvQgpy8yZJKJB+ZpxtOQbbvwTbZvDXnNcRgEREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960005; c=relaxed/simple;
	bh=qsF+GCSSP1hKNdJdQJMBEH9O2/UfBdYkuS3yMvSb0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjQiG39iaBmD4sZ4RzEunAShoYfc/I/0AtRGHjxS4wZ+jDWQkPNaY+9pQc/Nlg5Kbr/LVWp6mv32lMz4C6cLbq4HY8aKeLwTvWn/nympguPXlHrUVoFc6vAxBS+4FfIeMo5Ts1tIH67ywviz7mjWx8BjsV5qFP4ysbWi4GzEUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HnMhbbh5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f281714so224974485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741960003; x=1742564803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rcbULF3LHd0+z4mfmpPo+xxeDyKnDv8t+oi3P4Vssk=;
        b=HnMhbbh5M3OD+hE7ogrGRbRRNb/XMlihPuSLhTcpEoMtSFnFYn4KZKz9CpBaCV7SwO
         CaLdskppYuvDjjL5rLLARIXEE85kyxDP/GrTQGUiELM0j0zVqOFomnuslMfIlyCVr8Vs
         2PeDPXxONxvgBy9wgb/HrCbWtLn+xQ/GpL2E2T11L4eTJLaJho5oWrLBP5BSnXGCTm8E
         Qy4mcXABN7pgFBBNHtmi1F1CGzhSsng22WA7DZGSFzb/JvWX/HMimtETM9/pRlQcAOux
         BTWVTl2a6xPYk++uKk/twBFqux/p9+/ChGrne5uaF+BcCj5ynr9bdCtZAn7YfmjcDYb5
         8Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960003; x=1742564803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rcbULF3LHd0+z4mfmpPo+xxeDyKnDv8t+oi3P4Vssk=;
        b=I7UIcRqcAXDG9nhwvyy/jII2Uxl3oLww17yDdj1JNkNZRdbRMDcb00zueJ2HB71Tg1
         HhEcv7VVOliZFm4WE/JX6wv16J2exq2GArShBwpwTy9rnlgzJynIgLhsIPoSbl4B0c+A
         nyUbugO/MIRBWl6XHe4WA3EXN5rQjNvwHJXItfG8xeNYFLY4RnlA4yUbNPShx0bx/qjA
         LxZPo3FZOV9IRdldWpYddqGWb1Ol4BR9xFGsEuTz76kP2WRPja2Sqa4dfleCDV53GXWl
         4zI3eSp5lRPsny/PvgTwtA4Re9RU+qbMcKKeuOt3rxEQ3Z4YY0M0ZQaeX1KVjwZ98piI
         fl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8L76COkq3HX5KZZsJ2UPviTHAzWvfz0IVNX39rqbTAJqYIqi1JN5PcEOA7pbVgv8lP/30pc1pzDIZh1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIkqPPPxscc8zfXETIwYSknOwumLquPOtea3kRnxc3YDLs0Zk
	FGOaTGJO5NPZ+7iyf/FixFzW9EVBXkmhnsbI5sJeC1hwO/f2hatVXIS8x78V2mfT0g3tdqe3u1C
	F
X-Gm-Gg: ASbGncusfKiRt5ZNPqLHRp2uQKZhRxrRN4eIbGaELWFZrf/5gNcI4XAKLw8+t9LbmHO
	k6qZO8S/v5eLvkKm5V5WGl2M0tq8M4ZMZrVzzhQHfPePYCzL/3HM5adMFKV8qhrJBQj4QBW9rms
	tIg5vP+QUmsRurNO1tWjey0+z9BOs8etg3OO8N7oYkFgSsgQpbmvrsFM/1KfUj3yaQLWCZ11NT3
	iDdZ0MF8mthRFzHgxhEszcZaBv1VENY6E8UOfgd1FD53A6/av3GBQSHSbINvYG6Oigqq6cJxxsp
	6W4g58PEkNZ9WljhUgclTOG1ohznoUqdWpGU6Rua8AN0iLX7KL+VE/zJNXFT/T0/6MHoNaKC5XR
	z8wy8ZHTXhdlzXRI30LH/Z76eeI8=
X-Google-Smtp-Source: AGHT+IHVQBuUbLZtTeB8fDk67fek3JEC0e06LBLUL+yeI3ow/ytEEdIxrurvEd3+ik7VQtEVYcYhqg==
X-Received: by 2002:a05:620a:40ce:b0:7c5:59a6:bae2 with SMTP id af79cd13be357-7c57c769737mr291429885a.4.1741960002746;
        Fri, 14 Mar 2025 06:46:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f31f0sm22865331cf.64.2025.03.14.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:46:42 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:46:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA Flexiblity
Message-ID: <Z9QzQEzcpHjZQI7U@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
 <20250313172004.00002236@huawei.com>
 <Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
 <20250314110942.0000476a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314110942.0000476a@huawei.com>

On Fri, Mar 14, 2025 at 11:09:42AM +0000, Jonathan Cameron wrote:
> > 
> > I was unaware that we blocked mapping persistent as volatile.  I was
> > working off the assumption that could be flexible mapped similar to...
> > er... older, non-cxl hardware... cough.
> 
> You can use it as volatile, but that doesn't mean we allow it in a CFMWS
> that says the host PA range is not suitable for persistent.
> A BIOS might though I think.
>

aaaaaaaaaaaaah this helps.  Ok, we can repurpose the hardware, but not
the CFMWS.  Even more pressure on platforms to get it right :P.

> > 
> > Along with the above note, and as mentioned on discord, I think this
> > whole section naturally evolves into a library of "Sane configurations"
> > and "We promise nothing for `reasons`" configurations.
> 
> :)  Snag is that as Dan pointed out on discord we assume this applies
> even without the lock.  So it is possible to have device and host 
> hardware combinations where things are forced to be very non-intuitive.
>

Right, but i think that falls into "We promise nothing, for `reasons`".

At the very least it would give us a communication tool that helps
bridge the gap between platform, linux, and end-users.

Or it'd just makes it all worse, one of the two.

~Gregory

