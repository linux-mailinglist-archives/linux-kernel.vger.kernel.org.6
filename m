Return-Path: <linux-kernel+bounces-307618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F396506E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B8B282FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE91B8E9F;
	Thu, 29 Aug 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkGKjMGM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F01311B5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961822; cv=none; b=g2CTUAsrhrMO7zc/wOqxuPQsyfIjlcmEg4okGMLFglQy2rn8lZ9QH0i4aE+roVVi93Q5BJxzJHIIT2m8E96bVnkqcw6/T9ul+MxBlPAVsrdjBEJrxZ/6pvXLov9lXlkPiKYldRpQCuXLCK7L5Ro5YnBsy8/UnNUmnTs2k7WkJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961822; c=relaxed/simple;
	bh=jwuvKMrY5cTod7e2LGlDDYGRX/xeSQPNePjeIZJkTsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0LzTA7a8vkvruahOvGRJPJhfTz7uA/PVRiaElmHNDt2hEsTAFls7C+natHlJ4TQxMaQEV8k02nFATyYOeNyKHMKOMwvW2px19wJsAgTGwtWlRRsKiWg3kVMIMPOHGZnUzd3A14qTVlc69oFw1yNz/8vAPtoiYsWeXxKms4Oz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkGKjMGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7867C4CEC1;
	Thu, 29 Aug 2024 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961821;
	bh=jwuvKMrY5cTod7e2LGlDDYGRX/xeSQPNePjeIZJkTsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkGKjMGMClK2QbKf3YBMwoOS/hzBHGZmfx+sMNajgsvFgOYgq6DuhmPgUPK5Q/LtO
	 R4xzAEbTbZK30cEf/oSCus5JmAMLZcA0nRxtdc3c8d8+ZobnF1lIKkJiGHacL+tcI0
	 cNbi51EvXgqdn2+k7o5326M261WIJy9ootdDMVs8wV9+yXO4mG5QmgO/0wt+38Icvg
	 cVAFBtdeVhXfRyElgXYRs1KTQxZ9KjKaUYGDLSnWWBbuv4BT4A0Z008ajMreO0Jsy7
	 mlF6SA12oa3p+Onm5+A1YC20wob310qOv7XkNOLa3sc4WqHn1nHJTOmgQhGkaLTa82
	 CtZaBn2LrPDjQ==
Date: Thu, 29 Aug 2024 13:03:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Message-ID: <20240829200339.GA2791510@thelio-3990X>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com>
 <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
 <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
 <20240829182255.GA1468662@thelio-3990X>
 <87a5gvw4y9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5gvw4y9.fsf@intel.com>

On Thu, Aug 29, 2024 at 09:37:34PM +0300, Jani Nikula wrote:
> On Thu, 29 Aug 2024, Nathan Chancellor <nathan@kernel.org> wrote:
> > Since commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > inline functions for W=1 build"). clang warns about unused static inline
> > functions in .c files, unlike GCC (they both do not warn for functions
> > coming from .h files). This difference is worked around for the normal
> > build by adding '__maybe_unused' to the definition of 'inline' but
> > Masahiro wanted to disable it for W=1 to allow this difference to find
> > unused/dead code. There have not been too many complaints as far as I am
> > aware but I can see how it is surprising.
> 
> Heh, I was just going to reply citing the same commit.
> 
> I occasionally build with clang myself, and we do enable most W=1 by
> default in the drm subsystem, so I was wondering why I hadn't hit
> this. The crucial difference is that we lack -DKBUILD_EXTRA_WARN1 which
> W=1 adds.
> 
> I see there's no subdir-cppflags-y, but I don't see any harm in us
> adding -Wundef and -DKBUILD_EXTRA_WARN1 to subdir-ccflags-y. After we
> fix the fallout, of course. Do you?

No, that seems entirely reasonable when your goal is to enable W=1 for
your subsystem.

> I don't much like the __maybe_unused stuff, but I guess it's fine as a
> stopgap measure, and then we can grep for that when running out of
> things to do. :p

Perhaps worth a TODO or something? Maybe a kernel newbie could work on
that at some point if it is not high enough priority.

Cheers,
Nathan

