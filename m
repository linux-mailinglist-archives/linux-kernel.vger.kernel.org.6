Return-Path: <linux-kernel+bounces-391487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA19B87C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AC51F22846
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116F1798F;
	Fri,  1 Nov 2024 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bpmSUlWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F9AD4B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421604; cv=none; b=Be1yw2TeTwIUAW2G9jBCHhySIxmPjBep+qsd8RJd9bmyeMe1e7yVpvIEdcqudH+BcO32CSWhsgo76SU4XN4pAHCdIJwk1KVw+l2uxewEBeSJahfTyuUqTUdoCqu04t9ODHOBtubz5j3RivePwosB2bYMjn0FsJJo6u1SrVmLGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421604; c=relaxed/simple;
	bh=Q9Y/rv8AW+8uY3IlBM24UIbTATTq+FwELTJtvkh1OAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHyWe88pUpkcqi91olcB/66JEDF/4wFqBfleS970G6qaNRBh1+FfOsrhESap4w9P+u03gohtH1slkYNI7BhKfC+BWAwVCk6a5Ba86una5Ia/yMjJIPtHwRKaNr+rSVRJeoZB8q0b5ekQ1JULJ7RPqQ1J5W6V72fVsUhNW2rPsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bpmSUlWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89719C4CEC3;
	Fri,  1 Nov 2024 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730421603;
	bh=Q9Y/rv8AW+8uY3IlBM24UIbTATTq+FwELTJtvkh1OAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpmSUlWLVUh3d/7Zc1FCiA4LLRqq6b2Xxc5lB7jqcAwMCRElwFVoCBqtHwfT2RixX
	 fvB8fN1LoqAg/q2ipL5DfnBRRhr1jgn0RiQuuFmcrhfaWF3vcRpqrBwIQYajYgTYEY
	 StKWG1LKCmTO0HuwvUuwz7stPF12YIle733CqhP0=
Date: Fri, 1 Nov 2024 01:39:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] driver core: constify devlink class
Message-ID: <2024110105-uptight-overdress-1f25@gregkh>
References: <20241014122849.118766-1-brgl@bgdev.pl>
 <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
 <CAGETcx9GfFsfWymBvXHs7F0S_mvK=eCy=q8-gBu1UPm9QzNVgQ@mail.gmail.com>
 <CAMRc=MdxxfhXw8JP9We5Ty_gpiU+G9mUD2mgfPoQm8gaE=CX=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdxxfhXw8JP9We5Ty_gpiU+G9mUD2mgfPoQm8gaE=CX=A@mail.gmail.com>

On Thu, Oct 31, 2024 at 01:31:43PM +0100, Bartosz Golaszewski wrote:
> On Thu, Oct 24, 2024 at 9:54 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 12:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 2:28 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > The devlink class object is never modified and can be made constant.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> > Acked-by: Saravana Kannan <saravanak@google.com>
> >
> > -Saravana
> >
> > >
> > > > ---
> > > >  drivers/base/core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index a84a7b952cfd..0e618d675792 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -553,7 +553,7 @@ void device_link_wait_removal(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > >
> > > > -static struct class devlink_class = {
> > > > +static const struct class devlink_class = {
> > > >         .name = "devlink",
> > > >         .dev_groups = devlink_groups,
> > > >         .dev_release = devlink_dev_release,
> > > > --
> > > > 2.43.0
> > > >
> 
> Greg, can you pick this one up please?

I will, give me time for trivial stuff like this please, lots of travel
and "other" things happening right now (i.e. my INBOX is trashed.)

Will be able to hopefully catch up by the end of next week if all goes
well...

thanks,

greg k-h

