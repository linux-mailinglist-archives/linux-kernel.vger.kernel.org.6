Return-Path: <linux-kernel+bounces-364618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86899D6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387C91C2408B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB8C1CACFD;
	Mon, 14 Oct 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="is99wqzn"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC38231C83
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932753; cv=none; b=ZReuJTA1jQu9hPG6nRnzwsfQUDI4xYQTSi5vSWebwqgxek9TTMzMVoh+Y/Icl4E9Ejc8g472WIzs+rbjdUikoVQQwaRfzZOjIO9avBuaOT0MHLxeGJxg91BA88ulyQ0t+Q5qkCzGmhl8APMqptfRPwgZXAsYAiIviU8zNiED1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932753; c=relaxed/simple;
	bh=q2AP1UGVXj10Le4lSKDQwqNm1XcyZWUeYt8vJyET5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD8VK7xyBikUtj2D6mj2476qnivGY+6tJaqee5CzPj4XSdHqgzSgub2sNo8M/6GzE4JS552xFC7pQN7t43aEzD+1Fa6dSw1nhkveEmYTuWSU6TkYrKao6WaiP6BJf1zXbMC+uwVi2kjhwhXJ9gTD/xcPVrvJR+6JhamUwMoRo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=is99wqzn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4601a471aecso463371cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728932750; x=1729537550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+08ml2AiYkHcW3Uf8z1s0UAC7gIOd7B+tcl/Ogi7DA=;
        b=is99wqznbBgR2vyajhWipTiezjmiK9e+frkx9WHbJ5eQky0j6epiAsdY7WLqJWzxqY
         1OlRmutEw07KT94Fc5FBz6njSmWkcIG8rTK0Qf3z9OXqk8YC5OLZn6u2cjEWTmqmRjgP
         KzOt6w7QnzJcvQS3Rq12EWo93oZNcitv9+5a2LbZG1WSY4NdHFzPfVVS+T+IBDdMnTFq
         KsCYc9zJi7AC8VLQGofJu8bvpRUe0g3aAi08wekHigSFIIcwI+zAKvLmH83/kfnEAdvB
         ZF24p7i9xJi7GVsaHNnAzqm0efGaFxPew77SIPTJItmpPH8Q7lkxWEDcEYAms7DjAyhp
         kuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728932750; x=1729537550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+08ml2AiYkHcW3Uf8z1s0UAC7gIOd7B+tcl/Ogi7DA=;
        b=CGPEHzU+Epwwzx4dWtYsG8mt35PN09P36ezyegHC++jbJDrBZVEVnrQ0XjFMseQKta
         DTtacLRFATfafi8KJ4bF4BbLk5mmO/0ATG3DL6cUrbczqM/MafTXbSjP8kKJ4lGhVPmA
         kyVMPmjbGVxscb6FaAbATbnm89y97RzSVMuf5/tHZ3IHKn3HOjzWSHGZagkaAMpe+xJa
         kHObg7uPVLJNk72HocyOz8rZpG6Ar4fzJb56iWZvHGDZ6PEfwUE68a0/Mo4h2dtIyF9g
         vskNvtp2+ccAJK2ufHWzSnlI/5ZJzsQiz7blaHkJhkM+qntAbDxM+K+rVVX8d3gvE/5v
         L6EA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZ13bEQORYJIUJsr4YeBW4sJX+aPNsMDim2c+BjIS8rG1o11RBPfkWA265H8woItXCZ2gkRF83a/Aico=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyURUOiK/P1IGtmZnDDOMXHykQdlFrFhJ65zxwZX2WLpy0+UF
	6B9XdkHMLJ2xQZXZw/sa9Kb5G+9jBz7zBeB5lTLNuWvGBrkMEqNUbYhJJWpZwAl6O0Wt5aHs2Yt
	tOQ==
X-Google-Smtp-Source: AGHT+IG1y0320eFk2rIA6XdxiuawcYhmw0SDyMWfWRVB2YHXvJgxfkz66sY7nDwhnTmK6zKM9kty6Q==
X-Received: by 2002:a05:622a:5798:b0:460:77ac:8773 with SMTP id d75a77b69052e-46077ac891cmr737801cf.26.1728932750091;
        Mon, 14 Oct 2024 12:05:50 -0700 (PDT)
Received: from google.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a7700sm48747846d6.7.2024.10.14.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:05:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:05:46 -0400
From: Brian Geffon <bgeffon@google.com>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Weil, Oren jer" <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
Message-ID: <Zw1riiTCTho7_8_R@google.com>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101335-turbulent-smelting-00f2@gregkh>
 <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101439-vagrancy-cubicle-77e0@gregkh>
 <IA1PR11MB6370FC19D0985EF452C12156ED442@IA1PR11MB6370.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6370FC19D0985EF452C12156ED442@IA1PR11MB6370.namprd11.prod.outlook.com>

On Mon, Oct 14, 2024 at 02:43:31PM +0000, Usyskin, Alexander wrote:
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, October 14, 2024 4:25 PM
> > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > 
> > On Mon, Oct 14, 2024 at 01:15:49PM +0000, Usyskin, Alexander wrote:
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Sunday, October 13, 2024 6:08 PM
> > > > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > > > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > > > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > > > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > > >
> > > > On Sun, Oct 13, 2024 at 02:22:27PM +0000, Usyskin, Alexander wrote:
> > > > > > -----Original Message-----
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Sent: Sunday, October 13, 2024 3:14 PM
> > > > > > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > > > > > Cc: Weil, Oren jer <oren.jer.weil@intel.com>; Tomas Winkler
> > > > > > <tomasw@gmail.com>; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
> > > > > >
> > > > > > On Sun, Oct 13, 2024 at 02:53:14PM +0300, Alexander Usyskin wrote:
> > > > > > > Read buffer is allocated according to max message size,
> > > > > > > reported by the firmware and may reach 64K in systems
> > > > > > > with pxp client.
> > > > > > > Contiguous 64k allocation may fail under memory pressure.
> > > > > > > Read buffer is used as in-driver message storage and
> > > > > > > not required to be contiguous.
> > > > > > > Use kvmalloc to allow kernel to allocate non-contiguous
> > > > > > > memory in this case.
> > > > > > >
> > > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > > > ---
> > > > > > >  drivers/misc/mei/client.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > What about this thread:
> > > > > > 	https://lore.kernel.org/all/20240813084542.2921300-1-
> > > > > > rohiagar@chromium.org/
> > >
> > > [1] https://lore.kernel.org/all/20240813084542.2921300-1-
> > rohiagar@chromium.org/
> > 
> > Yes, it's a problem, I don't understand.
> > 
> > > > > >
> > > > > > No attribution for the reporter?  Does it solve their problem?
> > > > > >
> > > > > This patch is a result from non-public bug report on ChromeOS.
> > > >
> > > > Then make that bug report public as it was discussed in public already :)
> > > >
> > > Unfortunately, it is not my call.
> > > For now, I'll anchor this on [1]
> > >
> > > > > > Also, where is this memory pressure coming from, what is the root
> > cause
> > > > > > and what commit does this fix?  Stable backports needed?  Anything
> > else?
> > > > > >
> > > > > The ChromeOS is extremely short on memory by design and can trigger
> > > > > this situation very easily.
> > > >
> > > > So normal allocations are failing?  That feels wrong, what caused this?
> > >
> > > 64K is order 4 allocation and may fail according to [1].
> > 
> > And what changed to cause this to suddenly be 64k?  And why can't we
> > allocate 64k at this point in time now?
> > 
> > > > > I do not think that this patch fixes any commit - the problematic code
> > exists
> > > > > from the earliest versions of this driver.
> > > > > As this problem reproduced only on ChromeOS I believe that no need
> > > > > in wide backport, the ChromeOS can cherry-pick the patch.
> > > > > From your experience, is this the right strategy?
> > > >
> > > > No.
> > >
> > > Sure, I'll use
> > > Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> > > where the first time such buffer allocated and add stable here in v2.
> > 
> > So the problem has been there for years?  Why is it just now showing up?
> > 
> 
> I suppose it is the combination of some fairly new FW that requests 64K buffer
> for content-protection case, underpowered ChromeBook and ChromeOS running
> content-protection flow.
> All three conditions should be met to trigger this failure.
> 
> > thanks,
> > 
> > greg k-h
> 
> - - 
> Thanks,
> Sasha
> 
> 

