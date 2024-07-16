Return-Path: <linux-kernel+bounces-254243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6329330A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C26B216B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B219A86F;
	Tue, 16 Jul 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtQ2jsFu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C91B94F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155741; cv=none; b=MLIEdCvIfxSe/fCO6tXqLvBY172Q8GWYPHq9auK9E3cfk/5Jjbyl2MKgQ1DMyPete2NM0BSkQMviwulCU78kyaokcZcZH4gHhHEVvOzMkOWtl42QVxOqL6GFsBKOAGp+KPzW6P7Zb+yvTLaUl19/0Bg2VufNPFUDJs/sPc29B2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155741; c=relaxed/simple;
	bh=4a9oizCqoNQJ0k84IxD0VO3ymLl8h+xl8RQJLQgE1k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqxieNU0aOUKVZGlfggbDDF5CyqKWo7Ncnx8Hj/J60hoZjaeJRTaZwhbQJkQi0hyAKtABg+o73u7of9GeRqWbKHJuOjPvyP8wQWhR26xtkLt1u3Fktgt9HtpoSiWmsNawZtgYaxAPsN6CsXcIyiGbFh5sqJnBxNVW6T/RfkqI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtQ2jsFu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc424901dbso6399705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721155739; x=1721760539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjC4n0At76vs87q3pB+e4WmyBPsYZBikspG4sQouzTE=;
        b=VtQ2jsFu8yzIsgFNYjiO+59YcWfvQf2cNYZsuqBT5FaLYwwo1XdqDkUlQNqLjUsm2v
         PxSZ/jG1TiwZIBnQalREVFIr3KRvrN9ky8WZ0mzGSB2+hxTiR/68Dk+4TqepXhke+Dlu
         YYL7cTn4/mJ5/AaDTEDOi3/x4+/QFWOREar2iPm7lgPfWmFBGl4DVRorSQCaBA4JlnyX
         VmqxRuDYKNuxmmiaUANK+Vj6+IYAnWBW/Bq70l7BEHH+BtkqBV3Kb7R3anh02UwAJ04B
         gfu2FapXLqo+fnp30YX9Mge+F2sJp8tK9fVHOo7xgCnllX4BrQLxSZmE1MjfCUGlXLcL
         PV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155739; x=1721760539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjC4n0At76vs87q3pB+e4WmyBPsYZBikspG4sQouzTE=;
        b=Lg/tCYU4E952D+4zIDV3vRMXrhf8LtYvdM/VQJl7tvO1V+N5RFl4xjGCaruhiNBAqH
         c+LMvoOh06JYFH7VVRId6r0ltkEZplViXdqo3Xj2q8/MBLJSdHmX2A/HaOzzITeW541+
         UltLcysoPf3ENJArIyGg6kbvyEDJmASdJ5eeALl9TM6WL/ibx6ZYJPih+GBd1cQg7qQ9
         78aGw3c/OI4637+9r09tm4+ltUho4syNBVD0X6SVaWXNqudfnU0n1bQEwSNv8l+gGd7/
         gQUjxAE5WMH24gW+iYU2EijzMWCe0ajiK3baFIF+Mm8QvjU4xK1K4dwcnEHCQoX600Pc
         Q5yA==
X-Forwarded-Encrypted: i=1; AJvYcCVaotc5IgC4yrzz4a8dOvqFF2iZB9J87Bo1/k+MnUYgmJuB84HX6YJSaULCGpy7hN05J1xZ70C2p7FqXq+j3tlPO3n64v6p5aVsrm3q
X-Gm-Message-State: AOJu0Ywj03PbLwLfjljTf09bEJLPwXvIlRFQ5bvFDRtXYhhfK6OJviKS
	YBL68yisoHMxppzaXsL/Fdk40XPtXMXZiWhZDj7DthVUhFkLO9MLwv7zViFTbA==
X-Google-Smtp-Source: AGHT+IFmEp4bRpiiSSOiyiVjI/X1kRp2cSYdIsnb99+Xoyu44AkxRUTvlxWO2rhInC3LaXp2lP+U2A==
X-Received: by 2002:a17:902:e945:b0:1fb:247b:aa2a with SMTP id d9443c01a7336-1fc3da1012amr26878315ad.59.1721155738703;
        Tue, 16 Jul 2024 11:48:58 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5050csm61519755ad.268.2024.07.16.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:48:58 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:48:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
Message-ID: <ZpbAlnAeCv-eiNzF@google.com>
References: <000000000000601513061d51ea72@google.com>
 <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>

On Tue, Jul 16, 2024 at 10:40:20AM -0700, Todd Kjos wrote:
> If context manager doesn't need to be bit 0 anymore, then why do we
> bother to prefer bit 0? Does it matter?
> 
> It would simplify the code below if the offset is always 0 since you
> wouldn't need an offset at all.

Yes, it would make things simplier if references to the context manager
could get any descriptor id. However, there seems to be an expectation
from libbinder that this descriptor would be zero. At least according to
some folks more familiar with userspace binder than myself.

I think we can revisit this expectation though and also look closer at
the scenario of a context manager "swap". The procs can still reach the
new context manager using descriptor 0. However, this may cause some
issues with operations with refs such as BC_INCREFS/BC_DECREFS.

AFAICT, the context manager doesn't even need a reference. But while we
dig furhter into this I think the best option is to keep the behavior
the same for now: reserve descriptor zero for the context manager node
unless it's already taken. Changing this is non-trivial IMO.

--
Carlos Llamas

