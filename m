Return-Path: <linux-kernel+bounces-345602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E798B7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5A1B264CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8219CD1E;
	Tue,  1 Oct 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M9mozc//"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5B19CC1B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773673; cv=none; b=F/S0Eu3JE+7j2oDgKffFBoAk0JvxA9WAiaTf7+c3DVGrRGAULmog0TnaYDAn+vpcPFKvKXNSvTL1LVsJeoQYtmYU99JbtIBjgyAMqeZz/OlAqmj2kortr5A9dKYccLe+c2NxTnvGJavfaaGYJI4b8fYtu0kb89fT/WtosCcmVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773673; c=relaxed/simple;
	bh=FLMsOuUBLzeWxWN8JyqoVSm7f7YUda4gd3Qim+0lNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhuRcrv8x7nZwND+nxgjalpJfUP/uqBV5DZlSujaPCHXYkjTglrtO/BtJ+iCRku+ic1xBwv/9knz3zECLWnDkUd6EYbui0JcxXwejn7wE2Vzcltr+uxVVAgj1nIXjFnwCH1uhbHYDWe5y2O111NhAVjDG3ukjh0jIWNHsxLF+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M9mozc//; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so874960166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727773670; x=1728378470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+4NWFNuV3Ow2SxChi7e6tYNwzR6cCZvZxncsIa4dF4=;
        b=M9mozc//r2T2TPCT0WuRDJnVoRiknH4qK9uMH9zbLcvuwwahsgnZFH3XlM6xJEnxGV
         bb2Y+SzBsfvROKPeb/I4QmhiE29nIoMWozA/yQT/v1sFTIpqh9IlMPUFqosK8XOnv2k2
         nVzQn7tw9eVowEiwx71TS5BlMb/zx0XAdrINDuTjVjbMbhonv6NeztIGiDOCaKjeqS2f
         VFdSqJC7Ez4XDFpUEBJ8ymWgoFeh+QlCRIQ8dYeS1JsZaMsYySjAHS85KOUNlcdPuo9P
         +vUUj8Gp9cAyr9FR0Q6MrkFIPIRgmpfOrx1Iq4gIm4b7fOVDjok7ibUlfgCQOkXPce4l
         7pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773670; x=1728378470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+4NWFNuV3Ow2SxChi7e6tYNwzR6cCZvZxncsIa4dF4=;
        b=TR8t6LSqnkJiYZXc8tVJ+iRA7+Waf2hoq/GXIQ8EjvrkPXhreCuFEaP8xv2eiiv+mP
         ehOlAGinZPWYEiQiTKD7iS2jERlVMFMgM+eHUQPrlj0obM68uhLO95qvyMuV5ITkRd40
         CIu2xU7ysY09rVHPsqSHTc/K2CUP7Aph9sbw2yxZV2Yg9RkXVW4qkDzkkhjyhB85w3vb
         DQAE5eh8KuFxI+cFE8H/9swL1prcDHUZHW/tCf5HK3T+GOfWjUEPdpgaz0LvrJDGcXWu
         rPxlOsjyf9+anjQjz+sU7kUmONUIAvPG3w0ttpyATAEf/wufK2s03jiF5cHbPqKzffLW
         rhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/vGTP9BbIBnTAHTWFmBvAx0Y7qPl5PxB4phFQ8yVpUzQAiQERQXtvWIOAEKRdW8DxVk+Vwot5B5xPIGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlA2odVJl08UB3/Ui+cabl7Sv+CjWyNDWY4ivowQZ+fiw648Mb
	UfTUz66ftcGpJXXAVcgp5LWQtDD3jUOFeRx4gvnWyIc4WSO/uhJGhPFCrFHCvDs=
X-Google-Smtp-Source: AGHT+IHFFkWn1R3kNIQw/IMzQ/IIwdPFgOv4sstbYyziWjKhBSuJDf35CmG58GLiNZhbpeJX3EDl5w==
X-Received: by 2002:a17:907:928b:b0:a89:f5f6:395 with SMTP id a640c23a62f3a-a93c48f0902mr1913241966b.1.1727773670042;
        Tue, 01 Oct 2024 02:07:50 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299ac9asm672061266b.208.2024.10.01.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:07:49 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:07:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: CVE-2024-46839: workqueue: Improve scalability of workqueue
 watchdog touch
Message-ID: <Zvu75UxnAl-Ysvd9@tiehlicka>
References: <2024092754-CVE-2024-46839-cfab@gregkh>
 <ZvusWymx4rGO55NG@pathway.suse.cz>
 <2024100116-shaky-iguana-7f54@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100116-shaky-iguana-7f54@gregkh>

On Tue 01-10-24 10:22:51, Greg KH wrote:
> On Tue, Oct 01, 2024 at 10:02:02AM +0200, Petr Mladek wrote:
> > On Fri 2024-09-27 14:40:07, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > workqueue: Improve scalability of workqueue watchdog touch
> > > 
> > > On a ~2000 CPU powerpc system, hard lockups have been observed in the
> > > workqueue code when stop_machine runs (in this case due to CPU hotplug).
> > 
> > I believe that this does not qualify as a security vulnerability.
> > Any hotplug is a privileged operation.
> 
> Really?  I see that happen on many embedded systems all the time, they
> add/remove CPUs while the device runs/sleeps constantly.

This is a powerpc specific fix. Other architectures are not affected.
 
> Now to be fair, right now an "embedded system" usually doesn't have 2000
> cpus, but what's wrong with marking this real bugfix as a vulnerability
> resolution?

Yes, this is indeed a scalability fix for huge systems with a lot of
CPUs anybody owning those systems was simply not able to use memory
hotplug without seeing those hard lockup messages. The system is not
really locked up. The progress of the hotplug operation is just utterly
slow. Calling this a vulnerability is a stretch IMHO. 

The only potential attack vector is to have machine configured to panic
on hard lockups on those huge ppc systems and allow cpu hotremove to an
adversary which in itsels seems like a very bad idea anyway because
availability of such a system is then effectively compromised.
-- 
Michal Hocko
SUSE Labs

