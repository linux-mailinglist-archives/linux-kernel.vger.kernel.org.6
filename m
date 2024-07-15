Return-Path: <linux-kernel+bounces-252751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315829317AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFD9283653
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02F190045;
	Mon, 15 Jul 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TrOuQ8Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0B18FDBC;
	Mon, 15 Jul 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057616; cv=none; b=lE4TEfFZ5+oxqByMMyWkrY/kVkprYOfUj00YaCBoQNmZliUIA2OtwE0mXS3xFLRzptdy4sUr8Ev+wa5OLyGJ243g874XaWUGX7LD6vjilRQZyApPILTWuSiApBAt1YIistMbYDIkZEQtl9nDJqz47QeTokH0PTT8mLZzb1zx32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057616; c=relaxed/simple;
	bh=uoAgvV4TAFahqFM6MfhR7wnigG35xC2qzRa7VklXYFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cku0VDpaytntkMJRG+TQDq1fdZ24qHn8zxJDqyzCOfxRJ2cTMpzGKV28r2D3LvadFNa5fWxx/SJlbOoB+zYtYyilbvU93Pj0mgQpgl1J8p5AjWBWBqT3OEljJJOuH8gnRayx73uE6PAa37n5kSa91qHezdS1tWRLFyRE40glVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TrOuQ8Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA8C32782;
	Mon, 15 Jul 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721057615;
	bh=uoAgvV4TAFahqFM6MfhR7wnigG35xC2qzRa7VklXYFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrOuQ8Y1I0VMAJvE98QPXVEwSWFlKK4Ld0wZhRimJgRPkQsD4vosoB7IrFE470sfU
	 GlzUmV9X788ahqb2v9TliKZiUF4bHrnDmH7gK/kA26ACSAoyJDYzP7EU55LXsIfO9w
	 syxpId3pITlJaqW9nOuNvRp9XaWk+VvxjV8WEOdU=
Date: Mon, 15 Jul 2024 17:33:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: rafael@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	gfs2 <gfs2@lists.linux.dev>, David Teigland <teigland@redhat.com>
Subject: Re: udev kset_create_and_add() with own struct kobj_type?
Message-ID: <2024071509-closable-drop-down-3a7f@gregkh>
References: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>

On Mon, Jul 15, 2024 at 11:27:00AM -0400, Alexander Aring wrote:
> Hi,
> 
> I am currently implementing namespace support into the fs/dlm
> subsystem. The DLM subsystem uses kset_create_and_add("dlm",
> &dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
> Underneath it creates for each lockspace a subdirectory using
> kobject_init_and_add() with a non-static name and being known during
> runtime.
> 
> Now I want to add namespace support and need to change the "default"
> kset->kobj.ktype = &kset_ktype; that is set by
> kset_create_and_add()->kset_create() to my own kobj_type because I
> need to implement a different ".child_ns_type" callback before
> kset_register() is called.
> 
> So kset_create_and_add() does not allow me to add my own
> ".child_ns_type" callback for the kset that is required for me to have
> my sysfs "kernel/dlm" directory separated by each net-namespace
> without breaking any backwards compatibility.

I don't understand, what "backwards compatibility" is happening here?

> My current solution is that I mostly copy&pasted the code of
> kset_create_and_add()/kset_create() to have a way to tell my own
> struct kobj_type that contains the implemented my own ".child_ns_type"
> callback.

Ick.

> I am writing this mail to get some advice on what I can do here
> without doing the copy&pasted code?
> Add a parameter to kset_create_and_add() that allows me to set an
> "struct kobj_type"?
> Introducing a new function that does allow me to set the new parameter
> (I probably like that because then I don't need to update all other
> users)?

A new function would be ok, but I hate it how filesystems have to use
"raw" kobjects and the like all the time.  It's rough, sorry.

Also, I didn't think sysfs namespaces worked for anything except
networking stuff.  Are you sure you really need this?  Where is your
"namespace" defined at?

thanks,

greg k-h

