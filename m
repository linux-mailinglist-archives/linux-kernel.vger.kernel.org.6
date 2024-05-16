Return-Path: <linux-kernel+bounces-180544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104668C7000
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424F81C21155
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A510F2;
	Thu, 16 May 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjEIwh6A"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417FA47
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822709; cv=none; b=KX8rSoljiWr1tD8gIeWOhFsblV/a6hcfUvj1VJ/yu59UFj/I4kiJzU52d2CVZUgI8eGJhwo7cFvNcsH8Z0Ka/2hIls601KRwt6wFyo4n7ZF4DMF7XrHXzIYbCOJB7FBeglrwC2EFronP3QepVTEyuQR+kb7WHJqifPtvR5a774A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822709; c=relaxed/simple;
	bh=ch0ISu0sLepp5E8LsMxeWAFsQS70H1fESbPnJVdppvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gh59LgT8lwa/3rfWqEMoWwdAaPlSK3Z7vMdrkTdY5tbFDqGMpy0EIZinf7ULxjnM7TIyKsKX2W6Q05TX9bws0Cl7K8U1jTaGSpqjpGxzQbXWEd881sx30s8BPagbAu3tNQoHJaehRCAGp9W8y45YPIvt9Iku6nshanGjizWzVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjEIwh6A; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so4246300a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715822707; x=1716427507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fmWXC4STobP3Pb92e4kqt4VpFGocCfhWdVYzSq5P7k=;
        b=GjEIwh6APoOkzJoEZcGFMk6ndGsgw5u9oBV+e55WxW7p6B0s+MzCXZIigVhvSd+TPX
         xbm23OW9TvxZpRfkxP4cZmR2Aackqw/i4T8HiIMIZeX18Ykto7QpZ+MIEiOhANbPEr7s
         rMt31rYIgQh7CG880TvNkQo+uBtY8msqsI7uPvfH2Onh9KZXeKGhBIONSSjzAJUaJ1FK
         STPsmAJSjKnQv0oO9bg3mtjtzw/hVUgaNrqr7Bqy48Y7R8mNZawET6/Q31HDVtq78t55
         m7EJjYkzia4nUYcCsDzC90umF9Or2PC2lkD/gDJCVvjZs/QQ78WrXHbAV3nfMDUxK/TG
         K+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715822707; x=1716427507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fmWXC4STobP3Pb92e4kqt4VpFGocCfhWdVYzSq5P7k=;
        b=jTQv3spVKlfAuzHbl5BG0L08v9n2A4C2jXY+l9Y1IYZNUsGIoLXBRBZLZ4xb0d3V+I
         4fxL0R04xXRd5iP6HgRgci8gfOK2TUDhhhQwbOKCaV4s0Q6lgqFomEx3qcUq4xcc0dKm
         o5fC/OUWNfAILnY97gyLsxUdD5N0PDdEsQkTH6ZNM3jwQazKM7T4B5nMXdoP7CHo7HKV
         5DmIiPDFaxCISx94pq0k8wfwSC88KQmbWJHaOIEHJKDPTXIXAJabf6+VK/ZVIGtCdbxz
         WiVMc8FjuBsDmw6LADkFBxZ41BL6C7VLzeXuXJhX2/VkjbaxPDf4FjkV6Kgo4jBVO4HW
         ECpg==
X-Forwarded-Encrypted: i=1; AJvYcCVRUaAaCuX4zurnBvaKqbubY/cF319pOVpDbDvyCyJVVwLuZ2a6id0Yyg45EQH2X3JiZHuqh/GMtSReHNMFqag8pN7XjiMtxQddAjVi
X-Gm-Message-State: AOJu0Ywnl51BFbQV4PIeTEzJqjPDhJm3S132U5v4b8b+ot/aq8ITWwhs
	zUHLMaYvtSetibDw4p0C0u3GWA0NiN8zOnBDlVzWvAA/s5+fPVBj6JV7KzHjy/QoQ6O+fkT7ZE0
	IcvqwZOrbKyEDjutE9wjK1kosrpA=
X-Google-Smtp-Source: AGHT+IGK2DJmWdWb2pJ/jm5+3f2H2Nf0KVc5NYGgyCDQZvmuV/RjgwR54xXMLkmuUSFv44h/oUsqaa4I9KLghqoFWTI=
X-Received: by 2002:a05:6a21:c98:b0:1a7:5e8f:8707 with SMTP id
 adf61e73a8af0-1afde10af9emr18413459637.26.1715822707151; Wed, 15 May 2024
 18:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513212836.292589-3-thorsten.blum@toblux.com>
 <CAB3Z9RJ+VVAvVfKWF2LCzH3288vi6CF7uv+g+qbeu_L0c_k0Nw@mail.gmail.com>
 <60613D48-7C93-4B9F-894C-CE70E5F8D123@toblux.com> <227C6981-AFFC-4E0E-A95F-BF8979D5AD2A@toblux.com>
In-Reply-To: <227C6981-AFFC-4E0E-A95F-BF8979D5AD2A@toblux.com>
From: Luc Ma <onion0709@gmail.com>
Date: Thu, 16 May 2024 09:24:55 +0800
Message-ID: <CAB3Z9RJ3RXOMc887N3cJntC1U24HXLkS4jm72xZtcDxNawRN3Q@mail.gmail.com>
Subject: Re: [PATCH] drm: Combine identical if/elif code blocks
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 15 May 2024 at 17:31, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> On 15. May 2024, at 11:22, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> > On 15. May 2024, at 09:43, Luc Ma <onion0709@gmail.com> wrote:
> >> On Tue, 14 May 2024 at 19:37, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> >>>
> >>> Merge the identical if/elif code blocks and remove the following two
> >>> warnings reported by make includecheck:
> >>>
> >>>      asm/ioctl.h is included more than once
> >>>      linux/types.h is included more than once
> >>>
> >>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >>> ---
> >>> include/uapi/drm/drm.h | 8 +-------
> >>> 1 file changed, 1 insertion(+), 7 deletions(-)
> >>>
> >>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> >>> index 16122819edfe..315af7b19c97 100644
> >>> --- a/include/uapi/drm/drm.h
> >>> +++ b/include/uapi/drm/drm.h
> >>> @@ -35,13 +35,7 @@
> >>> #ifndef _DRM_H_
> >>> #define _DRM_H_
> >>>
> >>> -#if defined(__KERNEL__)
> >>> -
> >>> -#include <linux/types.h>
> >>> -#include <asm/ioctl.h>
> >>> -typedef unsigned int drm_handle_t;
> >>> -
> >>> -#elif defined(__linux__)
> >>
> >> I think it is intentionally like that. Please see
> >> https://patchwork.freedesktop.org/patch/78747/
> >
> > Thank you for the link.
> >
> > Does anyone know if the reason for the change from 2016 ("make
> > headers_install can't handle fancy conditions, ...") is still valid?

I guess it is. If you can try ./scripts/unifdef as below[1], you might
find out the thing.

[1]https://elixir.bootlin.com/linux/v6.9/source/scripts/headers_install.sh#L41

> >
> > Other headers use the same #if directive:
> >
> > fs/ext4/ext4.h:948:#if defined(__KERNEL__) || defined(__linux__)
> > include/uapi/sound/asound.h:11:#if defined(__KERNEL__) || defined(__linux__)
> >
> > And there are many others using similar conditions:
> >
> > arch/arm/include/uapi/asm/swab.h:27:#if !defined(__KERNEL__) || __LINUX_ARM_ARCH__ < 6
> > arch/sparc/include/uapi/asm/signal.h:92:#if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
> > arch/sparc/include/uapi/asm/termios.h:8:#if defined(__KERNEL__) || defined(__DEFINE_BSD_TERMIOS)
> > include/uapi/linux/soundcard.h:1040:#if !defined(__KERNEL__) || defined(USE_SEQ_MACROS)
> > include/uapi/linux/stat.h:7:#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
> > include/uapi/sound/asound.h:11:#if defined(__KERNEL__) || defined(__linux__)
> > ...
> >
> > Thanks,
> > Thorsten
>
> Re-sending this to linux-kernel@vger.kernel.org because the mailing list
> somehow got lost in Luc's reply.

Sorry about that.

Regards,
Luc

