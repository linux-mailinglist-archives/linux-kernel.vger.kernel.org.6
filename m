Return-Path: <linux-kernel+bounces-554869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7732DA5A2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E460E16EBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373B2356D1;
	Mon, 10 Mar 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZgo46Rh"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941A2309BD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630977; cv=none; b=P5yDu3U2K3zvEaoSI2X5M/weryWBcJkI8Hsr3pxMjOa3xSQKbdHsT4laSCJQ1A4pnChuFjezPBBPGL9YJpWA3+9i3ek4Ay/XTG8or1sxGkzJ9HxYbtFzE+y6cj1Yc6iUP/SqDKqyg7lCrPZgticrjB1lpQhCEF2BYBt39A23f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630977; c=relaxed/simple;
	bh=V5zgplvVRoRG9PUqDpcEAcOkIYbWdq7Xr/9YnYVlam4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYHu74sLZiBd3Xccfck1XhL2DKmF3rUKn/cp/kXNDvaTZosiwBwpSXhKPVatUg0Jk9qJbXx3ntNYf8+WS+XDkFMJd+EclLgXSQ9HpXP+jynReUShwkEY3jXy5Q2LmK4twcNLU+d04Cpb+sXG0hxZMCvSirK16B90xPKPgvtawBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZgo46Rh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2497431f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741630974; x=1742235774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IM67112e6aVWPb0y1+A+iibMGJnbZ9dK5fhRXopQ0Rg=;
        b=bZgo46RhUkKv78PmZhL5yvn7kJ3Rib2rwQSH+4+ezIQHWvl64y6lht3nmR8ALE1twe
         Ij1Uo3Sq+MMahZMhsrsB2Yh5re67x1zzvr666hTdXWgGa0pXctQky7uBOHwBYGm+7l1P
         CKmukxlnItiQ45G1IoOL9M157C3ydS7w8d/5C99GD1U3YvGCymL1aLK7iy5i6AYVVoLj
         9gKf0C08zgvGAF7KyVyGGR8i0Ndnl6Ms+TPMzKD1BOUM5Lp6ne+GJlhNI5Fx2k34B5E2
         n26K3gcjwUNyNPh9MgjetJTb8/kgHGqEnVgEjNWniu2bz8XTSiq1Xeum6RMWfgVOtnyi
         12vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630974; x=1742235774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM67112e6aVWPb0y1+A+iibMGJnbZ9dK5fhRXopQ0Rg=;
        b=cajh5Gum5tYuklCV41qjHPfDEfrgEeFZzeX1RDPyvEkZWJgqg47C6EfQLuiOdfevC0
         HylTEZWxTDQnXtIXJxcLGHYiyh4wGjuu2yRJY9lJPFn3hXfqhqw72eDd1itrfla+Wzq8
         w4+QZ3tYfnQe/BEqCi5S2+96F9JJwFAVoCP7bj+1aH1wo+VWMiT7JXQy5kYhRNXjPfxh
         m3puZxWOLpDoT3umjZ4sj8fBfRBm/2w4D/iYBKQ+0uBIJdlSCjH+03tRjpqyLwsQNybJ
         tTNvmyFSEzEccvTIrHzzTn/xOSJ5GMKEUC7Li7tsUPOwT9x02aZG6BwQKugH5sHeGalJ
         YpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLjhh2+99TGCk5StkshKerTcqNuAnc/V2VCoqXN66pIzjTjfWHGkySDKX7T5NfuZMGXwJWI71mY4KoTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndDL75Jzz4aGtcwLrOiNeJxhvs9s8K6ghSIDfWU4+Fu1uv3iV
	oLDBNWynvN4xGRLw8iji9EAMgPkXR3ROWxZcGiOWp2oj6L9kcXuonb5jJJgXmMU=
X-Gm-Gg: ASbGncup2iD0qxCugy0WmveueulGmbWRJBElLEQEEsGedE9saVH0Rsyw4Boyegi0GIq
	m147tf6XgeJsO/3wG3WLpEDL1tSvsSL/yflD7p3wWVH+ZnCmVZ5XoomtyXVqoF4w3YmiO0cTe71
	89JEIHGbNvHJmVugJUPrE1wOlc8fYyDRF0BXGu4vH+wNBrCUmqn7zpLpgUm9anQDZphGG+3DCEc
	LWVXoiNXJWL0rtfJIo5hAlnvtSy6BwaDrJmTadObUd3jEqZNtG+Bbzd8Uwaind3UzZaJomuewk2
	F6G25ZnFye4NJ1OPY+B5KH59z4c5u2fdsvJEH9zYaTPFcEpeiA==
X-Google-Smtp-Source: AGHT+IFPPRTmEdhJHKxLy8Tag7aJ8MCR6K5N/RY9rHYVd+ENG21KhflHXXSPp3UiTZ2sQh+jQtPtYA==
X-Received: by 2002:a5d:584f:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-39132da08b4mr9411995f8f.40.1741630974330;
        Mon, 10 Mar 2025 11:22:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c015c2csm15382176f8f.49.2025.03.10.11.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:22:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 21:22:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/xe: Fix uninitialized variable in
 xe_vm_bind_ioctl()
Message-ID: <95a4da90-dfa0-4033-aba5-276b3d9a1824@stanley.mountain>
References: <4a74b296-8b51-4dab-a2f1-69919da1ca62@stanley.mountain>
 <Z88ZzoFA5KpQTLmH@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88ZzoFA5KpQTLmH@intel.com>

On Mon, Mar 10, 2025 at 12:56:46PM -0400, Rodrigo Vivi wrote:
> On Mon, Mar 10, 2025 at 01:48:00PM +0300, Dan Carpenter wrote:
> > The error handling assumes that vm_bind_ioctl_check_args() will
> > initialize "bind_ops" but there are a couple early returns where that's
> > not true.  Initialize "bind_ops" to NULL from the start.
> 
> It is not a couple, but only the one goto put_vm where this bind_ops
> gets actually initialized, or not...
> 

I'm on linux-next.  I'm not seeing the goto put_vm...  I think we're
looking at different code.

  3063  static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
  3064                                      struct drm_xe_vm_bind *args,
  3065                                      struct drm_xe_vm_bind_op **bind_ops)
  3066  {
  3067          int err;
  3068          int i;
  3069  
  3070          if (XE_IOCTL_DBG(xe, args->pad || args->pad2) ||
  3071              XE_IOCTL_DBG(xe, args->reserved[0] || args->reserved[1]))
  3072                  return -EINVAL;

One.

  3073  
  3074          if (XE_IOCTL_DBG(xe, args->extensions))
  3075                  return -EINVAL;

Two.

  3076  
  3077          if (args->num_binds > 1) {
  3078                  u64 __user *bind_user =
  3079                          u64_to_user_ptr(args->vector_of_binds);
  3080  
  3081                  *bind_ops = kvmalloc_array(args->num_binds,

Initialized.

  3082                                             sizeof(struct drm_xe_vm_bind_op),
  3083                                             GFP_KERNEL | __GFP_ACCOUNT |
  3084                                             __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
  3085                  if (!*bind_ops)
  3086                          return args->num_binds > 1 ? -ENOBUFS : -ENOMEM;
  3087  
  3088                  err = __copy_from_user(*bind_ops, bind_user,
  3089                                         sizeof(struct drm_xe_vm_bind_op) *
  3090                                         args->num_binds);
  3091                  if (XE_IOCTL_DBG(xe, err)) {
  3092                          err = -EFAULT;
  3093                          goto free_bind_ops;
  3094                  }
  3095          } else {
  3096                  *bind_ops = &args->bind;
  3097          }

> but perhaps the order in the exit is wrong and we should move the
> kvfree(bind_ops) upper to the end of put_exec_queue?
> 
> Matt, thoughts on the order here?
> 
> Cc: Matthew Brost <matthew.brost@intel.com>

I feel like ideally vm_bind_ioctl_check_args() would clean up after
itself on failure and, yes, it should be in reverse order from how
it was allocated.

regards,
dan carpenter


