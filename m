Return-Path: <linux-kernel+bounces-384783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39579B2E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77171C21BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93A1DE2A0;
	Mon, 28 Oct 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PiizDYKb"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D71D9663;
	Mon, 28 Oct 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113286; cv=none; b=BYesheePusE4jVetmDvgx8Y/PtoXzvcqc0fIZnBsKOBLg9DkaLFNMtf5GWUcMQq0cEe9BhglEamgFnOMMF0tEDJqCZLvqv7SMI1KKF21mHK8K5lN6lLNMxuR3W1UOAsJ5UbKPAaPpgH1nnYeE99tqevW5m8a3c1TN+ma90Z2BOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113286; c=relaxed/simple;
	bh=cjhyp3wA3ReQQh7IYCNljjwYC1kDjiuexSti34q+3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZIo90IiYQQ5r2W+f0WNjTaJN4CPeIiy+DTKjJWYDD5l9KfJK9il4aVqM8iUfGh48gBdnnRfiQknQQzInpMoUYKp0Y4sS4KNfvrZ/A8B0fsiMdht3i+SokLwYhL6z0ss1Qk6IIhrqO1rmnV3zx6jnIA0j3qyyvVfr6Rk/E85CTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PiizDYKb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9730E000B;
	Mon, 28 Oct 2024 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730113281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BuA4RhxbdOAfhp//bXjXBCAMD3OmfZYY5iEB+CcgAM=;
	b=PiizDYKb2ls1gY1QuV98ayKgjKNvIRSJGlxvXWEYoHmYMCKvRNjhucLXYl1Y8VGduzXE4t
	9Ji1HdYk7YeqIyaSczxTAne/qcMc/uWLmipuUlxtWUefHHOvaSSm0jJ2yrGq3Mo9B8Uj+A
	Umu18l4KvzCdhRx9+vU+kaxFpZIF2tCh7KrcONyQ965jrFr3WFXd6R/NGtdsTyt6ZhiNKq
	ayLCDOXpMcHaGGGmcffaUXyx9plcSijHEnGsqVnIFKqNZaEI7Lm+oOylApc3xRtF6Yk7G4
	hSEvGg8KSHr6hvOrMShFD55k3H5x4uwv/J18W0XUH9GX0+SyPLNmDWFw8QKF7Q==
Date: Mon, 28 Oct 2024 12:01:08 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
Message-ID: <Zx9u9K129dWhfzPQ@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <ZwzYqihbReaLFn-c@louis-chauvet-laptop>
 <d3e8bb5a-6053-4a2b-a445-0cf4e610f112@riseup.net>
 <Zx9eazDt3f2meyht@fedora>
 <6278651d-b61d-49d2-8151-7ab4ca03971c@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6278651d-b61d-49d2-8151-7ab4ca03971c@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 28/10/24 - 07:17, Maíra Canal wrote:
> Hi Louis,
> 
> On 28/10/24 06:50, Louis Chauvet wrote:
> > On 26/10/24 - 09:10, Maíra Canal wrote:
> > > Hi Louis,
> > > 
> > > On 14/10/24 05:39, Louis Chauvet wrote:
> > > > On 11/10/24 - 10:53, Maira Canal wrote:
> > > > > Hi Louis,
> > > > > 
> > > > > On 10/11/24 06:36, Louis Chauvet wrote:
> > > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > Until this point, this series has not received any major comments since
> > > > > > v9. I will commit patches 1-9 next week if there are no further comments.
> > > > > > 
> > > > > 
> > > > > Although we are maintainers of VKMS, it isn't recommended that we push
> > > > > our own changes without even the Ack of another person. Please, read the
> > > > > "drm-misc Committer Guidelines" [1].
> > > > 
> > > > Hi Maíra, Maxime,
> > > > 
> > > > I apologize for this rushed commit request. I sent the initial email with
> > > > a delay before the commit action because I was not sure about the
> > > > procedure and wanted to give others a chance to raise any concerns.
> > > > Unfortunately, I overlooked the need to collect an Ack/Review for each
> > > > patch, even when there hadn't been any responses for several months. I'm
> > > > sorry for this oversight.
> > > > 
> > > > > I can ack patches 05/15, 07/15, and 09/15, but it would be more
> > > > > beneficial for the community if you ask for an ack (from me or from the
> > > > > DRM maintainers, which are always around), instead of saying that you
> > > > > are going to commit the patches without any review.
> > > > 
> > > > I will be happy to ask for acknowledgments if needed, but as you mentioned
> > > > multiple times: nobody is paid to maintain VKMS. Since you did not comment
> > > > these series since July, when you told me you would review my patches, I
> > > > assumed it was either okay or you no longer had the time to maintain
> > > > (which I completely understand).
> > > 
> > > Yeah, I'm a volunteer and no longer have time to maintain VKMS. A couple
> > > of weeks ago I sent a patch removing myself as VKMS maintainer. This
> > > doesn't imply that patches can be pushed without review.
> > 
> > I will acked-by and push your patch, it will be an easy "first commit". If
> > I do something wrong during the process, please tell me.
> > 
> > Thanks for this precision, I understood this, and I will not push without
> > reviews, don't worry!
> > 
> > Thanks a lot for all your reviews!
> > > We are a community with several active developers. Although I don't have
> > > time to properly review your patches, you can try to gather other
> > > developers to review your patches. You can try to use #dri-devel to get
> > > reviewers.
> > 
> > Thanks for the tip, I will do this!
> > 
> > > That said, you can add my ACK to patches 05/15, 07/15, and 09/15 and
> > > push the patches. I won't ack the YUV patches as I don't feel
> > > comfortable reviewing/acking those.
> > 
> > Perfect for the patches 1..9, it will be a very nice step forward and will
> > reduce my conflicts a lot with the rest of my work!
> > >> Acked-by: Maíra Canal <mairacanal@riseup.net>
> > > 
> > > BTW if the patches are fixing IGT tests, please update the list of fails
> > > and skips on DRM CI.
> > 
> > For this, how should I do? Commit the series and wait for the bot results?
> > Run tests on my computer (I only have a x86 VM)? Is there some doc
> > somewhere?
> 
> Check [1] for instructions on how to run the CI on GitLab.
> 
> [1] https://docs.kernel.org/gpu/automated_testing.html

Thanks for the link!

I am stuck at the first step, do I need to ask some right to create a repo 
on git.freedesktop.org? I don't see any button to create a repo, and I 
can't fork any existing kernel repo.

I also asked the access to CI-OK.

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> > 
> > Thanks a lot,
> > Louis Chauvet
> > 
> > > Best Regards,
> > > - Maíra
> > > 
> > > > 
> > > > So, I hereby formally request reviews/ACKs for the following series:
> > > > 
> > > > [this series]:https://lore.kernel.org/all/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com/
> > > > [2]:https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com/
> > > > [3]:https://lore.kernel.org/all/20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com/
> > > > 
> > > > (I have to send a v2 for [3] because of rebase conflict, but nothing else
> > > > changed)
> > > > 
> > > > Thanks a lot,
> > > > Louis Chauvet
> > > > > [1] https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-drm-misc.html
> > > > > 
> > > > > Best Regards,
> > > > > - Maíra
> > > > > 
> > > > > > For patches 10-15, I am currently waiting for feedback from Maxime to
> > > > > > send the next iteration with a fix for kunit tests.
> > > > > > 
> > > > > > Thanks,
> > > > > > Louis Chauvet
> > > > > > 
> > > > > > On 07/10/24 - 18:10, Louis Chauvet wrote:
> > > > > > > As all the rotation are now supported by VKMS, this simplification does
> > > > > > > not make sense anymore, so remove it.
> > > > > > > 
> > > > > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
> > > > > > >     1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > > > > index 8875bed76410..5a028ee96c91 100644
> > > > > > > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > > > > > > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > > > > @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> > > > > > >     	frame_info->fb = fb;
> > > > > > >     	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
> > > > > > >     	drm_framebuffer_get(frame_info->fb);
> > > > > > > -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> > > > > > > -									  DRM_MODE_ROTATE_90 |
> > > > > > > -									  DRM_MODE_ROTATE_270 |
> > > > > > > -									  DRM_MODE_REFLECT_X |
> > > > > > > -									  DRM_MODE_REFLECT_Y);
> > > > > > > -
> > > > > > > +	frame_info->rotation = new_state->rotation;
> > > > > > >     	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
> > > > > > >     }
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.46.2
> > > > > > > 
> 

