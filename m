Return-Path: <linux-kernel+bounces-387924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7589B5806
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3631C225AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F020C31C;
	Tue, 29 Oct 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kGhLa/it"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4D20C314
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245695; cv=none; b=WF7A6aEdmhG3Yzo1s2fbeuO4GHDPdmlS7KVvkJOPIGEZXVl3fj1PMKGDJ2zI5sRXWUXqEhYepOVviRnzrx4MlzY/KRzEiY9B1NDvw3oU/WMg7slxl/i17Eh2Ht4QIisk5VkfZZVEHEAruf1RRlc9rikbTqWzCgF4RcDrrGUJ3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245695; c=relaxed/simple;
	bh=jgZcEXWn5FAyFMfBkL9XNG86xSsh3jDzUkE6Laiba/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJghY7MV7HVLyIs0vEmgiovQS4pAESbhke1ZBOMNMMhe5cSbJIhKntJL2E1yvHMM7IhdjpYRmXSwbv8IkmrF2LF3UYTfNLb67I+zONkjQn2DUldxOCu9/SRDd4RJ7G4SLLlyYkvsOqUxrNZGlFHWZaMbnOxCcvZgzJ5uec+02zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kGhLa/it; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=dVXmpPydpCBDKRSRi23AjHI0LcnEE/ZcNFXMhp9UcJY=; b=kGhLa/itrt4XfnPp
	fpe8Y96xjiq0Ekymx3ldS0oLhGbJ2ruuIZQu5OIydCOOr3iUY1eue6M3zzQODSswoyRSAJJllijYI
	4vqa6O8dK20s58G8NfHYY+rEicKrotxU1HHSw69u0ac8CNB3Lw2iEecuhQNkzy9yGfnle+QcxigzJ
	IcKQXVia41wKmCtSO9TeurX41fXe4NqdbRKRROnlzqBkOt50naaS75uWNpYynJ8rwEd2xdOs4a+W6
	Iba+uJqPMpprGnF0h5pPj0doom8QlRVunoLtrVLaVgkBnI/Q67FRI+Y33cjxwxwQO6vljwvOtid/b
	CnbLf1NAaE2wMl2n9Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t5vwV-00EMRW-3D;
	Tue, 29 Oct 2024 23:48:08 +0000
Date: Tue, 29 Oct 2024 23:48:07 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/client: Remove unused drm_client_modeset_check
Message-ID: <ZyF0Nz89DpjdaQw9@gallifrey>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-6-linux@treblig.org>
 <zvhtltfbu6dpwri7yuwwrpnno6g2hu7tv2q7ua73epfj6gi5e6@x2snh7otbalb>
 <Zx-XK7XTJLOpzpvT@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zx-XK7XTJLOpzpvT@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:47:40 up 174 days, 11:01,  1 user,  load average: 0.16, 0.05,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > On Wed, Oct 23, 2024 at 12:29:34AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > drm_client_modeset_check() was explicitly added in 2020 by
> > > commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
> > > but has never been used.
> > > 
> > > Remove it.
> > 
> > If you are removing it, it makes more sense to revert the mentioned
> > commit completely, dropping the third argument of
> > drm_client_modeset_commit_atomic().
> 
> Sure, I can look at that; and resend this series also without 4/5 which
> people still wanted.
> What about 3/5 - that's the only one that's not reviewed either way?

I've just sent the v2 with this as a revert and the contentious pair dropped.

Dave

> Dave
> 
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  drivers/gpu/drm/drm_client_modeset.c | 24 ------------------------
> > >  include/drm/drm_client.h             |  1 -
> > >  2 files changed, 25 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > > index cee5eafbfb81..69e1ce4d18cd 100644
> > > --- a/drivers/gpu/drm/drm_client_modeset.c
> > > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > > @@ -1126,30 +1126,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
> > >  	return ret;
> > >  }
> > >  
> > > -/**
> > > - * drm_client_modeset_check() - Check modeset configuration
> > > - * @client: DRM client
> > > - *
> > > - * Check modeset configuration.
> > > - *
> > > - * Returns:
> > > - * Zero on success or negative error code on failure.
> > > - */
> > > -int drm_client_modeset_check(struct drm_client_dev *client)
> > > -{
> > > -	int ret;
> > > -
> > > -	if (!drm_drv_uses_atomic_modeset(client->dev))
> > > -		return 0;
> > > -
> > > -	mutex_lock(&client->modeset_mutex);
> > > -	ret = drm_client_modeset_commit_atomic(client, true, true);
> > > -	mutex_unlock(&client->modeset_mutex);
> > > -
> > > -	return ret;
> > > -}
> > > -EXPORT_SYMBOL(drm_client_modeset_check);
> > > -
> > >  /**
> > >   * drm_client_modeset_commit_locked() - Force commit CRTC configuration
> > >   * @client: DRM client
> > > diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> > > index 560aae47e06d..e1fd32adb3e9 100644
> > > --- a/include/drm/drm_client.h
> > > +++ b/include/drm/drm_client.h
> > > @@ -176,7 +176,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
> > >  void drm_client_modeset_free(struct drm_client_dev *client);
> > >  int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width, unsigned int height);
> > >  bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation);
> > > -int drm_client_modeset_check(struct drm_client_dev *client);
> > >  int drm_client_modeset_commit_locked(struct drm_client_dev *client);
> > >  int drm_client_modeset_commit(struct drm_client_dev *client);
> > >  int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
> > > -- 
> > > 2.47.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

