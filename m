Return-Path: <linux-kernel+bounces-353436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8D992DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C4EB2109B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562071D45EA;
	Mon,  7 Oct 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYOQYw+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366D17B4E9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309086; cv=none; b=Orxddwbg9ETGISBcSXwLJ/1l7H3SoX03/L9jGQd3tmtkUaA4RJ0micBiOkcrjHCmJXTXz2foxRx0gx9nHoKCFiHbFFB3NXvpI95XZjqyoqLE/oHUtmfp0Mi4B8n7LOL9Bv9neJcxm6ODM+mzeKfcKH+u5EoeyZVIGzdpi1VzSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309086; c=relaxed/simple;
	bh=Af38W6K14UukOEOgx0/mvgFmNDN3th5anBo4M2ARqD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSuiZ23g4pO7xQmJ/u2FsRTXtGDtwHNkAlwcZvrWQX/wDzQvdCjNTZkQFzbAPPqJc4F0Qfyr50EUSRiY+lxcug5yQiIrdc73cCfIioGmGCEHBdar+Hpiy+inNEhQQsmH2hpbAQcN3dZJuU0YfBCDIe/Ni+xX/UYg2/79g82fETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYOQYw+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5106AC4CEC6;
	Mon,  7 Oct 2024 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309086;
	bh=Af38W6K14UukOEOgx0/mvgFmNDN3th5anBo4M2ARqD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYOQYw+9XtOkvTunR9e38VIVowN1HzmEpxK9oazjAOIT8u+nZpZOeZd+BHJW9NAZZ
	 ffuG0u9XKF8lbBICED9/x6YC4Vpt7/zlQaTJpWBEq4uiiUuyRvhLn+N9LOgaeMeDP/
	 VXnhsALO+3r57KtWSGLtebuB3nuDOcoQbPC2lUAJqOYkC8TqVnCO98oZmRwXNeWiis
	 vPSMS0ca1LAPd3KcwpVQgX9PK4PJSTuBtp6z4hcsFc0Gm6/8w4lfAC1ay6sduoqTN/
	 hn61yCmMmifgqJSeoy1ey1MJ1Zk6CWZZnqKf2unlTW0P2ur/TT2gozgx1sMC2US0/c
	 9IjSzIHTFuYAQ==
Date: Mon, 7 Oct 2024 15:51:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: nouveau@lists.freedesktop.org, Gal Shalom <GalShalom@nvidia.com>,
	kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nouveau/dmem: Fix memory leak in `migrate_to_ram`
 upon copy error
Message-ID: <ZwPnV2OPJhOUcsU0@pollux>
References: <20240923135449.356244-1-Ymaman@Nvidia.com>
 <20240923135449.356244-3-Ymaman@Nvidia.com>
 <ZvqJgMVBs2kAWguk@pollux>
 <f9fa14c1-f487-4ad9-9bc9-7c1db6de1ae6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9fa14c1-f487-4ad9-9bc9-7c1db6de1ae6@nvidia.com>

On Mon, Oct 07, 2024 at 03:28:22PM +0300, Yonatan Maman wrote:
> 
> 
> On 30/09/2024 14:20, Danilo Krummrich wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Sep 23, 2024 at 01:54:58PM +0000, Yonatan Maman wrote:
> > > A copy push command might fail, causing `migrate_to_ram` to return a
> > > dirty HIGH_USER page to the user.
> > > 
> > > This exposes a security vulnerability in the nouveau driver. To prevent
> > > memory leaks in `migrate_to_ram` upon a copy error, allocate a zero
> > > page for the destination page.
> > 
> > So, you refer to the case where this function fails in nouveau_dmem_copy_one()?
> > 
> > If so, can you please explain why adding __GFP_ZERO to alloc_page_vma() helps
> > with that?
> > 
> 
> The nouveau_dmem_copy_one function ensures that the copy push command is
> sent to the device firmware but does not track whether it was executed
> successfully.
> 
> In the case of a copy error (e.g., firmware or hardware error), the command
> will be sent in the firmware channel, and nouveau_dmem_copy_one might
> succeed, as well as the migrate_to_ram function. Thus, a dirty page could be
> returned to the user.
> 
> It’s important to note that we attempted to use nouveau_fence_wait status to
> handle migration errors, but it does not catch all error types.
> 
> To avoid this vulnerability, we allocate a zero page. So that, in case of an
> error, a non-dirty (zero) page will be returned to the user.

I see, I got confused by calling this a 'memory leak'.

Please add this description in the commit message and avoid the term 'memory
leak' in this context.

> 
> > > 
> > > Signed-off-by: Yonatan Maman <Ymaman@Nvidia.com>
> > > Signed-off-by: Gal Shalom <GalShalom@Nvidia.com>
> > 
> > Since this is a bug, please also add a 'Fixes' tag, CC stable and add a
> > 'Co-developed-by' tag if appropriate.
> 
> sure, thanks, I will add, and push it as V2 patch-series.
> > 
> > > ---
> > >   drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > index 6fb65b01d778..097bd3af0719 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> > > @@ -193,7 +193,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
> > >        if (!spage || !(src & MIGRATE_PFN_MIGRATE))
> > >                goto done;
> > > 
> > > -     dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
> > > +     dpage = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vmf->vma, vmf->address);
> > >        if (!dpage)
> > >                goto done;
> > > 
> > > --
> > > 2.34.1
> > > 
> 

