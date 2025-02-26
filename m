Return-Path: <linux-kernel+bounces-534786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D63A46B23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCC03AF3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C9242933;
	Wed, 26 Feb 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NX0chk+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAB21ABA9;
	Wed, 26 Feb 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598427; cv=none; b=Z1gt0b4HCqGXQ8Qbq/BRprtl/cK8bFOQrzxlSidgRqZeF8D6kccfJH7e/eDAfvhzZGpWmTpECtBsLmvePJRm7I3HqO/JfbAHgdxArkEbqaKOxCNwWOg3w8f9t2pqpKHNQbeGyBpg2d0jkwlWyyybfNUAJwerIwcq/Pm/r+hXaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598427; c=relaxed/simple;
	bh=kZ9rIq7rbJMYNQBhDU2KfRNXZ4jZx+RJE2OfPefQzY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPkke+2skB1ukBGsZCTZ8+85QDwCVAmSS3crjUot0xy7ecVBSGOaW4M/edQegxEc4hEUNVTYQY9WPw1OLz4kz1VibOmmDyIpIRSQ+Px4/lzkAUn9p90N6iaky4l/xgjEw6jWGDQs/nDAnNQ6WjT/JCQv6cXztS6SiVKXTtxjiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NX0chk+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18512C4CED6;
	Wed, 26 Feb 2025 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740598427;
	bh=kZ9rIq7rbJMYNQBhDU2KfRNXZ4jZx+RJE2OfPefQzY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NX0chk+2GsU5vFXy1cTpOS3T/Qhq9Oeggbl+4VMbq5H9uN6wq0rqYgjOWKu5uYdPY
	 m6vTN/YoafXfzX9COt3ucNb8oVmclD3bLQ0/9xzY2DgVEW2pYxw8Sh+QnrbKoCzl4S
	 amlOJU+06Z5+znHfvFhPqQGwaenFkGI+dBqCAQLI=
Date: Wed, 26 Feb 2025 11:32:38 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: faux: only create the device if probe()
 succeeds
Message-ID: <2025022616-refute-unmarked-a4be@gregkh>
References: <2025022545-unroasted-common-fa0e@gregkh>
 <Z72oceZFfJcMAf-D@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72oceZFfJcMAf-D@pollux>

On Tue, Feb 25, 2025 at 12:24:33PM +0100, Danilo Krummrich wrote:
> On Tue, Feb 25, 2025 at 07:35:46AM +0100, Greg Kroah-Hartman wrote:
> > It's really hard to know if a faux device properly passes the callback
> > to probe() without having to poke around in the faux_device structure
> > and then clean up.  Instead of having to have every user of the api do
> > this logic, just do it in the faux device core itself.
> > 
> > This makes the use of a custom probe() callback for a faux device much
> > simpler overall.
> > 
> > Suggested-by: Kurt Borja <kuurtb@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/faux.c |   15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> > index 531e9d789ee0..407c1d1aad50 100644
> > --- a/drivers/base/faux.c
> > +++ b/drivers/base/faux.c
> > @@ -102,7 +102,9 @@ static void faux_device_release(struct device *dev)
> >   *
> >   * Note, when this function is called, the functions specified in struct
> >   * faux_ops can be called before the function returns, so be prepared for
> > - * everything to be properly initialized before that point in time.
> > + * everything to be properly initialized before that point in time.  If the
> > + * probe callback (if one is present) does NOT succeed, the creation of the
> > + * device will fail and NULL will be returned.
> >   *
> >   * Return:
> >   * * NULL if an error happened with creating the device
> > @@ -147,6 +149,17 @@ struct faux_device *faux_device_create_with_groups(const char *name,
> >  		return NULL;
> >  	}
> >  
> > +	/*
> > +	 * Verify that we did bind the driver to the device (i.e. probe worked),
> > +	 * if not, let's fail the creation as trying to guess if probe was
> > +	 * successful is almost impossible to determine by the caller.
> > +	 */
> > +	if (!dev->driver) {
> 
> Seems like really_probe() cleans things up properly through
> device_unbind_cleanup(), such that dev->driver is guaranteed to be NULL on
> failure.

Yes.

> > +		dev_err(dev, "probe did not succeed, tearing down the device\n");
> > +		faux_device_destroy(faux_dev);
> > +		faux_dev = NULL;
> 
> NIT: Maybe return NULL directly (like above) in case a subsequent change adds
> more code to the end of this function and does not consider that we fall
> through.
> 
> Either way,
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>

Thanks for the review!

greg k-h

