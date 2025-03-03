Return-Path: <linux-kernel+bounces-542395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C283A4C949
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD33B77E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF512231CAE;
	Mon,  3 Mar 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HhOkGXS9"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCB212B14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021121; cv=none; b=aV+eCv1fIU4C+NvWYX0552rhieFSj54OQg80NphFfCwT82Xy9/THySJj1NcDsdUsKtA/0onarqjEWzJwD3/cOYRDmXl8ciMkhbo4VSg4xWs0IlOJJCOMBwnJYFUvD4LxOhughkQnktTTGLWc9JfAxJWdqFwPm0U21j7yjGuSIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021121; c=relaxed/simple;
	bh=YHj9TlkwI8DIOSvKJXZ1duOgH7lPVfw3fAoCLxsCQKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFI2XklyKHnEBoJJXFC/W5/NcwaSJdd0Gqm3V2oGL0BO53i3R6+MsZV/f9+hZOEmE7XVj1+Ywljt2iBovvJ2cAEm2T1pGLTc3hyA/msaZRWqA0R82e6w2S+ULWqglDMw/A4WU/q3aI9viQylmR3XWwhXRlWLCjRhPDpN4IIoz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HhOkGXS9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=eify1ppexQzLZIydQf1js6wBEcaTPRspfLPDS+j4sgM=; b=HhOkGXS9hzrPnBgG
	js0R3iDuM827LR2ODfImua1CO958uEBMOAST+8q+d2jCg+JA9Dn/4xk52j8Yt8imzwo40/QDKTvIm
	/9Qiw9DrKkmvN32vYK0M7qmcYQnFVtZ2Ja1qsp+ZXtrfBKwqfA0TGgHsCr+fZPPoWgAeVhyFVoi69
	q4yhC8y3nXluzbdXXjEmFUJP1Wt97s1RTIYNZ/NkrO2R53mfR65TGeacKpZe/OQr5zKkR0bsEkx6u
	2pJbxV5a3xOBLihnQNicSxMWvuhhB1NlfvlSx6aZnqQuevwJOeBE8LxoYvyh2vQ0ioeKzyv30ozRk
	K5+iA/7THNCyJW28aQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tp97a-002BjV-2Q;
	Mon, 03 Mar 2025 16:58:26 +0000
Date: Mon, 3 Mar 2025 16:58:26 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, tzimmermann@suse.de,
	airlied@gmail.com, simona@ffwll.ch
Cc: ville.syrjala@linux.intel.com, jfalempe@redhat.com,
	tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Revert "drm/client: Add
 drm_client_modeset_check()"
Message-ID: <Z8Xfst88r_M_RZ3v@gallifrey>
References: <20241029234706.285087-1-linux@treblig.org>
 <20241029234706.285087-4-linux@treblig.org>
 <4ysvn7vcynvmjc53frgj2nwuctf6kd6xdphgfjm3ulgfaxwngm@mod6oqvfmxav>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4ysvn7vcynvmjc53frgj2nwuctf6kd6xdphgfjm3ulgfaxwngm@mod6oqvfmxav>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:57:31 up 299 days,  4:11,  1 user,  load average: 0.06, 0.05,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Tue, Oct 29, 2024 at 11:47:05PM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > drm_client_modeset_check() was explicitly added in 2020 by
> > commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
> > but has never been used.
> > 
> > This reverts commit 64593f2a6fc933bb9a410bc3f8c261f3e57a9601.
> 
> Nit: Usually this comes before the commit message.  No need for repost
> though.
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi,
  Can drm pick this up please?

Thanks,

Dave
> 
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/gpu/drm/drm_client_modeset.c | 35 ++++------------------------
> >  include/drm/drm_client.h             |  1 -
> >  2 files changed, 4 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > index cee5eafbfb81..39201c11eaac 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -995,7 +995,7 @@ bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation)
> >  }
> >  EXPORT_SYMBOL(drm_client_rotation);
> >  
> > -static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool active, bool check)
> > +static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool active)
> >  {
> >  	struct drm_device *dev = client->dev;
> >  	struct drm_plane *plane;
> > @@ -1062,10 +1062,7 @@ static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool
> >  		}
> >  	}
> >  
> > -	if (check)
> > -		ret = drm_atomic_check_only(state);
> > -	else
> > -		ret = drm_atomic_commit(state);
> > +	ret = drm_atomic_commit(state);
> >  
> >  out_state:
> >  	if (ret == -EDEADLK)
> > @@ -1126,30 +1123,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
> >  	return ret;
> >  }
> >  
> > -/**
> > - * drm_client_modeset_check() - Check modeset configuration
> > - * @client: DRM client
> > - *
> > - * Check modeset configuration.
> > - *
> > - * Returns:
> > - * Zero on success or negative error code on failure.
> > - */
> > -int drm_client_modeset_check(struct drm_client_dev *client)
> > -{
> > -	int ret;
> > -
> > -	if (!drm_drv_uses_atomic_modeset(client->dev))
> > -		return 0;
> > -
> > -	mutex_lock(&client->modeset_mutex);
> > -	ret = drm_client_modeset_commit_atomic(client, true, true);
> > -	mutex_unlock(&client->modeset_mutex);
> > -
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL(drm_client_modeset_check);
> > -
> >  /**
> >   * drm_client_modeset_commit_locked() - Force commit CRTC configuration
> >   * @client: DRM client
> > @@ -1168,7 +1141,7 @@ int drm_client_modeset_commit_locked(struct drm_client_dev *client)
> >  
> >  	mutex_lock(&client->modeset_mutex);
> >  	if (drm_drv_uses_atomic_modeset(dev))
> > -		ret = drm_client_modeset_commit_atomic(client, true, false);
> > +		ret = drm_client_modeset_commit_atomic(client, true);
> >  	else
> >  		ret = drm_client_modeset_commit_legacy(client);
> >  	mutex_unlock(&client->modeset_mutex);
> > @@ -1246,7 +1219,7 @@ int drm_client_modeset_dpms(struct drm_client_dev *client, int mode)
> >  
> >  	mutex_lock(&client->modeset_mutex);
> >  	if (drm_drv_uses_atomic_modeset(dev))
> > -		ret = drm_client_modeset_commit_atomic(client, mode == DRM_MODE_DPMS_ON, false);
> > +		ret = drm_client_modeset_commit_atomic(client, mode == DRM_MODE_DPMS_ON);
> >  	else
> >  		drm_client_modeset_dpms_legacy(client, mode);
> >  	mutex_unlock(&client->modeset_mutex);
> > diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> > index bc0e66f9c425..ead3c3526ee3 100644
> > --- a/include/drm/drm_client.h
> > +++ b/include/drm/drm_client.h
> > @@ -177,7 +177,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
> >  void drm_client_modeset_free(struct drm_client_dev *client);
> >  int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width, unsigned int height);
> >  bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation);
> > -int drm_client_modeset_check(struct drm_client_dev *client);
> >  int drm_client_modeset_commit_locked(struct drm_client_dev *client);
> >  int drm_client_modeset_commit(struct drm_client_dev *client);
> >  int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
> > -- 
> > 2.47.0
> > 
> 
> -- 
> With best wishes
> Dmitry
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

