Return-Path: <linux-kernel+bounces-523340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11789A3D55B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02553B2EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8391F3BB1;
	Thu, 20 Feb 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ar+lCnU7"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5A1F1521
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044761; cv=none; b=Zn0hb/97ys7T5u3pHKx1W01l0jSJwmcWBborrJV0LLKn9XjwBYuz2XWRkchiIxLwoWh5w/7gfruOMeHRDcsRsQFii1qSahBzQlgodJHust+sOQguVnNLKeYoEBm5zhRmfKyyrxJHxK5bXn6jqnZHR2hjvJz5AfceCPuQoZetVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044761; c=relaxed/simple;
	bh=k4Mpc2rUKaNau9AYpnzFJlL2ymtkltFkMCLDK43v2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYziWVi5j1ZGllwdELPoJX78S3j9zSGmS+vtfMxl2JtZq7SjjV8ZPcqqHRcDq6rIX9zfm83+XfvgrG5Or/7rCI0htZBXVQvEaNuC6qaqjTqAjW01JaYFj+7qPnNXQn3RDki+13DL8wLMskrWrQ7LSdJx8v7hFEfNSIE50gNBNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ar+lCnU7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f22fe8762so321132f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740044757; x=1740649557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/QbdcI7C6XxVE5jz6sKFGZdf665BDupYKEBKSwxSEs=;
        b=ar+lCnU78nA2UpEZWEyiMe0XDyUAQUSNBFFr3LDsDT/1qGEsbv6fjacMiTttS1XkcO
         n5UDWMCRNUOpB2EJttLdWinyCR7aYOgGqGb3LEzANm1MxKhVzMUT0byZYo4URq98BFBl
         zt0s8NSX8uHdhfscicuUJPes7VEICGgmbzHq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044757; x=1740649557;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/QbdcI7C6XxVE5jz6sKFGZdf665BDupYKEBKSwxSEs=;
        b=fry+BryaNUuZ1i7sYBRR0c/X/bsWyBhUwD1VUYJNlN6QsnnOklS35klRNsTeRs77Vg
         UjfZbBMp1aQuWbB0g9Y9ogSmC4+U8a7yTJAbZhbuF/Rqo+gLpnly8TCgOIxnpCS4wLvN
         W83PixrGQIkCTNnV6zjgWvdSPVJTWG9hd5Y7MNkCu7vx0ZNEwjCP6qzre8pQ09YN7ekb
         r3IZOmGLruQJv0lq/VqiVwcj1hj1CfiWsKIW1lMhXH2uG8StNM2zp3377tCL4680ZlXX
         Fl6BIuSThYiqD9VWkeha3tSCvSvLl6E4I8fmjPVLelJDJynOwHlm9ZFbPF9mM2yfu06e
         C3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX39t2a/8S2FsJqbdMh4bDioB9AWR30O5rXE07fAHn9/lLF2GefN7EWU8l/vyfTd6FMbRlyePSxf4AhfbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXStCs/5hVERoWjnGs0AGpnMrfuXhKWUADGudxT6A6mtDfe0MP
	ZtoK6HwSrsTAyHU4DmMFLV/JI/Ff/yfdO5RTQB+LCjB+ozfMszjfWk2fdy9m24+DdMGZOpsbtKH
	S
X-Gm-Gg: ASbGncs90DOQM+4GsxBxoz/iOY4GrdKlaqBWH101dmnsph9qI/HwsNey8d1JCGHbnCP
	9xfYcsmzfmBT7JWEDUyTaXMPmMQxhD4wb9kNl+eG95GEIj3mFbsjkysPNpchmIHbyLDtDePNtWA
	xoMOiVjOOFyL+Q0CNSTDprx/qoFRy50yoXtiDE9CXtzZAogT/Nmfog28KhgBB4HM5rhZYvic5Mh
	XHs5iBfr3kn/ODid1aw5J1UOTAC4w0Vv96xY0YIlkgKi443TdlyLFClAk7NVOdswq3EAqKS6LJ/
	MokOZZ1N0nGGZCDDm51Fi52SBgg=
X-Google-Smtp-Source: AGHT+IGpuAwEB4NAeWO90X12ML8FmH1WxKE/6GeffuYce5PPhHcnTL5xNEF5aXBpLAm2OEdPIQ/h0w==
X-Received: by 2002:a05:6000:1948:b0:38f:218c:f672 with SMTP id ffacd0b85a97d-38f65145d52mr1206188f8f.41.1740044757301;
        Thu, 20 Feb 2025 01:45:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm20419757f8f.16.2025.02.20.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:45:56 -0800 (PST)
Date: Thu, 20 Feb 2025 10:45:54 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 00/63] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Message-ID: <Z7b50rGRA4RuybgC@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
	Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com, ville.syrjala@linux.intel.com
References: <20250125064619.8305-1-jim.cromie@gmail.com>
 <2025022012-viscous-cringing-bf88@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022012-viscous-cringing-bf88@gregkh>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Feb 20, 2025 at 09:31:41AM +0100, Greg KH wrote:
> On Fri, Jan 24, 2025 at 11:45:14PM -0700, Jim Cromie wrote:
> > This series fixes dynamic-debug's support for DRM debug-categories.
> > Classmaps-v1 evaded full review, and got committed in 2 chunks:
> > 
> >   b7b4eebdba7b..6ea3bf466ac6	# core dyndbg changes
> >   0406faf25fb1..ee7d633f2dfb	# drm adoption
> > 
> > DRM-CI found a regression during init with drm.debug=<initval>; the
> > static-keys under the drm-dbgs in drm.ko got enabled, but those in
> > drivers & helpers did not.
> > 
> > Root Problem:
> > 
> > DECLARE_DYNDBG_CLASSMAP violated a K&R rule "define once, refer
> > afterwards".  Replace it with DYNDBG_CLASSMAP_DEFINE (invoked once in
> > drm-core) and DYNDBG_CLASSMAP_USE (invoked repeatedly, in drivers &
> > helpers).
> > 
> > _DEFINE exports the classmap it creates (in drm.ko), other modules
> > _USE the classmap.  The _USE adds a record ref'g the _DEFINEd (&
> > exported) classmap, in a 2nd __dyndbg_class_users section.
> > 
> > So now at modprobe, dyndbg scans the new section after the 1st
> > __dyndbg_class_maps section, follows the linkage to the _DEFINEr
> > module, finds the (optional) kernel-param controlling the classmap,
> > examines its drm.debug=<initval>, and applies it to the module being
> > initialized.
> > 
> > To recapitulate the multi-module problem wo DRM involvement, Add:
> > 
> > A. tools/testing/selftests/dynamic_debug/*
> > 
> > This alters pr_debugs in the test-modules, counts the results and
> > checks them against expectations.  It uses this formula to test most
> > of the control grammar, including the new class keyword.
> > 
> > B. test_dynamic_debug_submod.ko
> > 
> > This alters the test-module to build both parent & _submod ko's, with
> > _DEFINE and _USE inside #if/#else blocks.  This recap's DRM's 2 module
> > failure scenario, allowing A to exersize several cases.
> > 
> > The #if/#else puts the 2 macro uses together for clarity, and gives
> > the 2 modules identical sets of debugs.
> > 
> > Recent DRM-CI tests are here:
> >   https://patchwork.freedesktop.org/series/139147/
> > 
> > Previous rev:
> >   https://lore.kernel.org/lkml/20240716185806.1572048-1-jim.cromie@gmail.com/
> > 
> > Noteworthy Additions:
> > 
> > 1- drop class "protection" special case, per JBaron's preference.
> >    only current use is marked BROKEN so nobody to affect.
> >    now framed as policy-choice:
> >    #define ddebug_client_module_protects_classes() false
> >    subsystems wanting protection can change this.
> > 
> > 2- compile-time arg-tests in DYNDBG_CLASSMAP_DEFINE
> >    implement several required constraints, and fail obviously.
> > 
> > 3- modprobe time check of conflicting class-id reservations
> >    only affects 2+classmaps users.
> >    compile-time solution not apparent.
> > 
> > 4- dyndbg can now cause modprobe to fail.
> >    needed to catch 3.
> >    maybe some loose ends here on failure.
> > 
> > 5- refactor & rename ddebug_attach_*module_classes
> >    reduce repetetive boilerplate on 2 types: maps, users.
> >    rework mostly brought forward in patchset to reduce churn
> >    TBD: maybe squash more.
> > 
> > Several recent trybot submissions (against drm-tip) have been passing
> > CI.BAT, and failing one or few CI.IGT tests randomly; re-tests do not
> > reliably repeat the failures.
> > 
> > its also at github.com:jimc/linux.git
> >   dd-fix-9[st]-ontip  &  dd-fix-9-13
> > 
> > Ive been running it on my desktop w/o issues.
> > 
> > The drivers/gpu/drm patches are RFC, I think there might be a single
> > place to call DRM_CLASSMAP_USE(drm_dedbug_classes) to replace the
> > sprinkling of _USEs in drivers and helpers.  IIRC, I tried adding a
> > _DEFINE into drm_drv.c, that didn't do it, so I punted for now.
> > 
> > I think the dyndbg core additions are ready for review and merging
> > into a (next-next) test/integration tree.
> 
> So whose tree should this go through?

I'm trying to get some drm folks to review/test this, but thus far not
much success :-/ I think it's good stuff, but I'm somewhat hesitant if no
one else agrees that it's useful for CI or in-field crash-recording or
whatever ...

I guess worst case we can land it and hope it attracts more folks?

Wrt tree I don't care, but I guess we should then also land the drm side
too.
-Sima

> And I think the last patch in this series isn't correct, it looks like a
> 000 email somehow.
> 
> thanks,
> 
> greg k-h

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

