Return-Path: <linux-kernel+bounces-325775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44852975E11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE13285B49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B779EA;
	Thu, 12 Sep 2024 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM0gOnM/"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC0632;
	Thu, 12 Sep 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726101928; cv=none; b=RUpW2CVwi8h6XeVvThaEBAZfERp2NqgsVj3idxoHun1sniZb/TJhwSZuZ42u1sy+llG4r32k+IaxWAWmabWmE8YAq2Y+ZdfwpUmwpcbKF0ZUo5jS25BL5522lbPuWFsSZjn9RUstcc7nIh/Ny94XXolS2mU1MWDIVkk7rxWazS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726101928; c=relaxed/simple;
	bh=0uaHx4x1yyJDSLxsboXvUD14IU2KPxprqTlUPWK7cqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjO6eWTIxqaptPvYK6QgtB4MOlUCmVlv9n+72Y6VUqSq/UGuExnLZwQnmYsQjWpSWRwrrviPX0CdjTORfuBduH8oWRgOs+W9xosBIUviWOASPDgXbgkntfJmDjshAhDqz/Bm8I6zsECvnrPK22R7pp51o74zXgXKalyv4t9rMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM0gOnM/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so266459a12.3;
        Wed, 11 Sep 2024 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726101926; x=1726706726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXFeEE7MIL9Z9sVBfBbEtID4t2efTNAyYO/k4o/Sl5g=;
        b=bM0gOnM/ZKUvpEdGEvjGNedcCSI0tgOZpSFATVK3gSgJWfpt+rU9aUHYnr5+A0OYgc
         Fo9Yb++DzBXH65Q/hcDxiCTttGP3YTscnCgyUsE/46JwPUpIZLdUezFGLc/7oilGs5XC
         XztYOQMef3oMRwEZ4UGTAc/tbA2pOL/9Ea1hy3Dw7AfBMqIq7jQoaOaGrmHYK9RMHX0f
         mvAybklUzdG3JSw2+e+J4aHLSCjZ83rlmXnIbJ6i5cAJ6niLs2SgWuHQms5exIFCrjlY
         cCwnjEnsRK4/yf1TDx5VCSwUsvTNko6Et+mZ9ZKLlYSh8eBEsbYsaEYGpvyj3RXhfgk5
         I0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726101926; x=1726706726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXFeEE7MIL9Z9sVBfBbEtID4t2efTNAyYO/k4o/Sl5g=;
        b=XswIliIzxu6HYAdgvjZHVHPsZVah7bEt+qShN0xEwMUGmH2We3uZIehK307g6ktYVQ
         XvtCNZBukIBQ+ZfyxeMIbbe29c9r/3uXhrBBsyMLkBB4KRGYk1mcrCsP88r+wa0ViN0r
         RyephBOueilk6cty+DuPTYbee0iq3mU5mO9kQmqJjUwHBAk3UPZgVGS/Oof0zObdWTdl
         xdCYe/XtFXxoEEsYPbZdddlebWuE+FknoXiP1b77j+DYafTPLuYTemkPwVIkg8BX1pw9
         CRud6D/OeY4r1Jonq2Sk6I6DPP9eSHkWNy0SgihN18Ky9e1QYbbquIhFZm/rcA1RD1dB
         3uDA==
X-Forwarded-Encrypted: i=1; AJvYcCVTQI9bckV+WYkguRSBwv5qBWZKRmnPg+ol9d6jmP81qmi1ZuPa+Vx5zvURv0MvVOCpw4kFNlpoXN2jdPM=@vger.kernel.org, AJvYcCXy8BEzx59u3yd3o8Bht/r0/Xks5BdiAosdYMBv2NomWDOSRcX0ei9ENDgVlQfdJ1WrVc0XQgZktUaT@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxEoCAnRyAgtzm5h0MjfU9WxsKAWAC2eBxbMRyq7woT1J14lv
	EHhJBfj0ogfh4YEGrfgU+YsCwTILbrlSKtiIFB3haKnuxVq9f51zxZAUeyIfuP4=
X-Google-Smtp-Source: AGHT+IEksB2QaBHw7RPvGTa2YA8PRJJaWVzkbYoySyhn/h6Bg3bUYHOMHC+R3N0ppsvheo1qaPCRDA==
X-Received: by 2002:a05:6a21:1518:b0:1cf:39bd:bd61 with SMTP id adf61e73a8af0-1cf75ef29d3mr1140446637.23.1726101925872;
        Wed, 11 Sep 2024 17:45:25 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.234.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fe11ad7sm560045a12.94.2024.09.11.17.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:45:25 -0700 (PDT)
Date: Thu, 12 Sep 2024 06:15:18 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
	linux-usb@vger.kernel.org, skhan@linuxfoundation.org,
	dan.carpenter@linaro.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <ZuI5nptdk+BcXh+R@embed-PC.myguest.virtualbox.org>
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
 <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
 <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
 <f5d4711f-9b4a-457c-b68c-c2e9aefbe4a8@suse.com>
 <890e0ed1-25c3-414e-9e8e-f5925fe8c778@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890e0ed1-25c3-414e-9e8e-f5925fe8c778@rowland.harvard.edu>

Hi Alan,
On Thu, Aug 01, 2024 at 10:51:35AM -0400, Alan Stern wrote:
> On Thu, Aug 01, 2024 at 08:54:18AM +0200, 'Oliver Neukum' via USB Mass Storage on Linux wrote:
> > 
> > 
> > On 31.07.24 20:19, Alan Stern wrote:
> > > On Wed, Jul 31, 2024 at 11:34:45PM +0530, Abhishek Tamboli wrote:
> > > > On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:
> > 
> > Hi,
> > 
> > I should make my reasoning clearer.
> > 
> > > > > Replacing the variable with a constant won't make much difference.  The
> > > > > compiler will realize that bl_len has a constant value and will generate
> > > > > appropriate code anyway.  I think just changing the type is a fine fix.
> > 
> > While that is absolutely true, it kind of removes the reason for the patch
> > in the first place. The code gcc generates is unlikely to be changed.
> > 
> > We are reacting to a warning an automatic tool generates. That is a good thing.
> > We should have clean code. The question is how we react to such a report.
> > It just seems to me that if we fix such a warning, the code should really be clean
> > after that. Just doing the minimum that will make the checker shut up is
> > no good.
> 
> With this fix, the code seems clean to me.  It may not be as short as 
> possible, but it's clean.

I noticed that the patch has not yet been pulled into linux-next, 
even though it has been acked-by you for over a month. Is there 
anything else I need to do on my end?

Thank you for your attention to this matter.

Regards,
Abhishek

