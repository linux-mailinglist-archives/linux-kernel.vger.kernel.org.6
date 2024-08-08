Return-Path: <linux-kernel+bounces-279743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA894C149
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0D528733E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316218F2FE;
	Thu,  8 Aug 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7kOaz7O"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76118C355;
	Thu,  8 Aug 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130860; cv=none; b=iKs9KsC9fFiZBhzDpyKRHhBahfAxt2N7ZjUqkAbpoRghKnSik6rpr7OaPoKm6RDC0W6DGXPj8AgUSSKi+rTQ21zSXg8gULADiir0VFMtiTZD3h6y6GQ2WtkNQ739z+rJeZ9KbwCQlHvlX0tlMt7Me7bhq9el/mEgODgZlcgLg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130860; c=relaxed/simple;
	bh=PfWOmOcV9l9z+70Q55rh3PrGhzM5r3yXLVKW8y5Tnj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hndmEJaq/d5lzrUzL+vSnfQoSpqcE2zoz1wY5ER3zn7Q8TQ5H+FxfSugJLKkfTOqEu7Zu+Mi5FHzuhK8F67lwLS+n4pmGmK+z+IxXQuTnUUd7q8s8erAusd3yVvRMZKfIE2lth8Yu1h5u+wuPpRxKqJRpl3fBL3J6HYF4rV/a7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7kOaz7O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so948519a91.3;
        Thu, 08 Aug 2024 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723130859; x=1723735659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qrVoz2J1yx28Dbm2oNk/ENgURyNTgPZNBRNbJticAY=;
        b=L7kOaz7Odvc7AAaMWul6jP6G8mxH6+5EuYXcrprGXhkx3J6HGiQzxZ4rgIihbJepQG
         VG0ihGhihUCCUgeMDb//55q19i8SnPyZQE9UxMrlOqqXltxr+vwRokOcqymXaqk51bUh
         OuD3+2e0EdfG3gvMVYfUBvWjWjimD4F07ZaTe2Qw/FjBXnA/oQVOBtPgFhdWO23KRAYt
         H2dIIqN3mbmD+9paaYk5rqrU1v98qQY2LBHK6HxY0dZw16//aMiL0myQBnyih0KICWN1
         v7os6C4ngRapE61YNtQuzmHDVZe3zWpZCUgZOkRMU/dbBElrOrLByZFHNjewINQ/WsQv
         dnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130859; x=1723735659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qrVoz2J1yx28Dbm2oNk/ENgURyNTgPZNBRNbJticAY=;
        b=JUaqTB4msjo1ny24voHpdPl7zwwDwdzEA0W9oOJmfOMCuXfSP9rMSQtVuiKXqGy0Vz
         y6COPtfOTDIXyYgeiHhnQ0z/B2PLfio3myWIIugTP3G9QdJo2usKXctu2RflHsVpVYCI
         Hetc29dX+QvnSsogG3etEWDPEYMGBVL/O1iWS/L0KmYjCVfJpsWJ113y22dqn7Kw/W4Y
         0b4LyMX03CBuvNllyHA9ZHP7s1CW7xJpQfE+M2waChiqd8t39ic9F7dWVOXXeqe5FRi6
         M/3JJ4HBAWZsC4P6P/6XF1ff8MS3IBPc/cvbPm6uRJETvwaquTs5OWNDP81IuLJL/vwu
         Ls/A==
X-Forwarded-Encrypted: i=1; AJvYcCWr/HgtWLap/1VgjTNDE6oTslqLx3+70PnCyP7VDulv0r49VOp7YnMEm4GJaFSuRiWbATakdgqeP5IAhH4V0bec9ojV4UbJuvdaxIE93qtm4ksA7Fi8/HTL5MlXpgHZa3jFb05bODbU
X-Gm-Message-State: AOJu0Yza1JSx/SwaZXWyRxNkbkKZvp16x+YLRE3v0SgcN3+t0vOgtZ0k
	L9mPWTPRYierotuzEcJsUrU+8flEAJh+cvtOsOL/7FHa7nJiTZfoQ6UGXdeJ
X-Google-Smtp-Source: AGHT+IHiHgWTjm1UfRszbp9Jh6b8RCgOFoPHnf4exHKRez7qVshr+dQ3WXNglY3HdV5YdG84WbdkhA==
X-Received: by 2002:a17:90b:3a8b:b0:2ca:7e87:15ea with SMTP id 98e67ed59e1d1-2d1c3459459mr2644200a91.34.1723130858508;
        Thu, 08 Aug 2024 08:27:38 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([110.225.178.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab9b3fsm3638895a91.20.2024.08.08.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:27:37 -0700 (PDT)
Date: Thu, 8 Aug 2024 20:55:42 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: laurent.pinchart@ideasonboard.com, dan.carpenter@linaro.org,
	m.grzeschik@pengutronix.de
Cc: dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <ZrTjdoa66eQxOTqM@embed-PC.myguest.virtualbox.org>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
 <a779ee26-fe93-47ac-a25c-b842534e0317@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a779ee26-fe93-47ac-a25c-b842534e0317@suswa.mountain>

On Fri, Aug 02, 2024 at 01:40:48PM -0500, Dan Carpenter wrote:
> On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > and uvc_v4l2_enum_format().
> > 
> > Fix the following smatch errors:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> 
> When I reviewed these warnings in 2022, I assumed that the error
> checking was left out deliberately because it couldn't fail so I didn't
> report these warnings.
> 
> Almost all old Smatch warnings are false positives.  That doesn't mean
> Smatch is bad, it's just how it's going to be when you fix all the real
> bugs.  In this case, I just decided it was a false positive.  It's
> possible I was wrong.  Other times, I report the bug and the maintainers
> say that it's a false positive.
> 
> There are some old bugs which are real.  Sometimes I report a bug but
> the maintainer doesn't see the email because they go on vacation or
> something.  Or someone sends a patch but it doesn't get merged.  Another
> thing is that if a bug is over five years old and minor then I might not
> bother reporting it.  These days kernel developers are very good at
> fixing static checker bugs and these kinds of things are pretty rare.
> 
> I don't review old warnings in a systematic way.  If I fix a bug in a
> file, then I'll re-review all the old warnings.
> 
> If we decide to merge this code, it needs a Fixes tag.
> 
Hi,

I wanted to follow up on the patch I submitted to address a Smatch warning.
While I understand that this warning might be a false positive, as mentioned in your
reviews, I would greatly appreciate your guidance on whether this patch should be
merged or if any further adjustments are needed.

If we determine that the patch resolves a real issue, I am prepared to
include the Fixes tag.

Regards,
Abhishek


