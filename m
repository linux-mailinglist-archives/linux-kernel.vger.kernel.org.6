Return-Path: <linux-kernel+bounces-438584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F519EA31C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADA9282B85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C321CFE6;
	Mon,  9 Dec 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FzeXRT4Y"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DF1E48A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788070; cv=none; b=TpRyAJ1My693EkL2L/TP0DRoLBx1JY5mXBO4LGhKKnufuJbqI6nENW5V06yoUzg2JjmX7lbAFZBnnd0lFIseQM4GCooAkMbnBJP4i+ryDb1zZ7loIX8kOMvxPDh5RGJQ4MpEypbUwvYVMPvQLOBALdBvvbQybG9xbWI31ZVHeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788070; c=relaxed/simple;
	bh=WSrKulYKd9TJZcnSJsQwfur1QOKzjJeTgnuzBojtgJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJl0HnliZu4BcTtOvm4ElkNmkgcA33pI6U8IbiFw/GnVyaBFBfnQHLSi+JY6GBk9J1c36HvzmC4VdBmYJZslucT2gr18mjP+eg/FW2Qod6Mimaw0WdpMt9u8q9nVgmyKwWQGCZmGzvsWxqKeUUyKStZEbq3PZ/FIF44HTGfHTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FzeXRT4Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1671807b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733788068; x=1734392868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9CRU77qOqowg/whCoRjG1vY9t88dBsls3ueWbUJ3nQ=;
        b=FzeXRT4Yky+WWpXWG+Sa8uM7EOEhZdkFqMq+/FWFb95nCc960fnvErmVjDSaazJGa4
         qpCnf5d96+aVPTZbAQzyLoK4yfrBuWQaWxR0ENbKQwsftDStQz9Ke8p9Q8BeuRnNOAjx
         qGQVHhzgYHtraLdNWSRb2lk1X+E2YoVIdpjcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788068; x=1734392868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9CRU77qOqowg/whCoRjG1vY9t88dBsls3ueWbUJ3nQ=;
        b=dP0NMMaiY0JXPsl0MuCd3k3OVo5D8jXNXdrO4r3SnypsJGq4CoVeo5FzYCC9YozsBr
         6OHnS4/Gy/dXWduu2Rwum3dw51nX1mqpFYe3W4yqu9r4SIsDDi/HvvoZmn89dV/CM74m
         1C3J6EInz7gpacieyW/kIC+2W8oQwnU0+umgr8t+inRWmfT1+jF4xOSR+vr3BhA8/YKD
         0+8vabCho5Koqa5L0/0Eqc14y/5LcP8uquLoLqrvJVAzcdzyEei8Wi3Fq4QjD2udM6qm
         QsXvj4swT+t5kwX7oDYL9HrgTbqaDW+9K3mzfpUS/bT4BX7zIVAVQbSg2lF7OfS139hD
         Pkig==
X-Forwarded-Encrypted: i=1; AJvYcCXP0UuqPOQ8C/2YZ+SPTwfAJBv2MO4cYqQjmVHi3y9GHYaHVilTWOyT0L+eYz3dmUZFYEUNQ9SkQyH9FT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsbXOFg0dfbReynwCqZVsQBZL6Kbe4fyROyv9QWScpAiwZjdR
	63yNVsUQ3rUl4X1pHjXzfbQbx5pK5mUyor7YYPuF2CtfNBVaEEA4Zvxt13aVzHjfc+RBpiGKc3o
	=
X-Gm-Gg: ASbGncs16iPymKaBC8dU2U/hYZe59i4fiYLvCOt7uceOuAOe1qy3/+JSnpHxCmps9oB
	qTM7YZKMyK3p7hLr3HH60qQFnIF0nqS06kjvNexs7VsWAW6AGF5GtWgvNfvRdAxWN/EVuDMA6zL
	Edu5FOJciHTKLeAk/4g5v09CyMGInULp/cNiqbtCGYPU5xiAN75ltDoYEoZWP+8iN3joW7gOwo4
	sIFS5SsPdrZVvXPMhKCpnKBzc5PLTWx8Xsis9JsINyR8g0P7nJos5HaU7hbpQcj4kHPGwBMyNqu
	d4BBk/hvrWq9lqc+
X-Google-Smtp-Source: AGHT+IEbG8UPWeTsJhv40b9jJjEpcFLd53fkoI+cVSG7GhLDKDFY2yYhS8Nu84yGQYK2tE4oYWdnnQ==
X-Received: by 2002:a05:6a00:1820:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-725ef4be556mr8788202b3a.20.1733788068310;
        Mon, 09 Dec 2024 15:47:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:ba79:259f:d432:29b8])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd3891dc95sm4649013a12.42.2024.12.09.15.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:47:47 -0800 (PST)
Date: Mon, 9 Dec 2024 15:47:46 -0800
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't match device with NULL of_node/fwnode
Message-ID: <Z1eBotg2DiaXLWqn@google.com>
References: <20241204000259.2699841-1-robh@kernel.org>
 <2024120450-jogging-duty-fad4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120450-jogging-duty-fad4@gregkh>

Hi Greg,

On Wed, Dec 04, 2024 at 10:37:06AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 03, 2024 at 06:02:59PM -0600, Rob Herring (Arm) wrote:
> > It recently came up that of_find_device_by_node() will match a device
> > with a NULL of_node pointer. This is not desired behavior. The returned
> > struct device is also not deterministic.
> 
> It's not deterministic because a NULL pointer will cause that to happen,
> or for some other reason?

It'll pick the first platform device with no of_node. That likely yields
something very wrong, but doesn't produce a visible problem until a
caller does something with the result. Commit 5c8418cf4025
("PCI/pwrctrl: Unregister platform device only if one actually exists")
has plenty of explanation of what really goes wrong.

> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > It would be a bit more efficient to check this up front before we
> > iterate thru devices, but there's a number of users of these functions
> > and this isn't really a hot path.
> 
> Yeah, this should be fine.  Does this fix a problem now and we need it
> merged for 6.13-final and backported, or can it just wait for 6.14-rc1?

It's a preventive measure to help head off future confusing bugs. It
doesn't need expedited merging or backporting.

FWIW, last week, I also cooked this change locally (+ the ACPI change;
and a kunit test for added fun), before I noticed Rob submitted this
one. If you'd rather, I can submit my patch series. Or I can submit my
patch series on top of this. Whichever you'd prefer.

Brian

