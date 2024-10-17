Return-Path: <linux-kernel+bounces-368968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E09A171B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1B288075
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523C38DDB;
	Thu, 17 Oct 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kGHGmvk"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A731C139
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124811; cv=none; b=l9a6Kp+fWt3yPUz0Af3Qp0ruOhW/ig0IGGRD84uxr1p7WoAAch/bc0s6mDwADTsPFeWE67XJ/mRw8ZeZWZvVETJXQadnyndBTq65DIFjFmm9CTfmZkwpFty0LkXl98pSq4uPkBcZDpSXvFPpwMydVBwwFrUcy4cpeqtl9HnGIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124811; c=relaxed/simple;
	bh=ke/U6M/R8mIq/tqiSoJRAHs0IFxG3jrmo50biIZXxwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OiQpgXYLgNav8CxdqNcj4nR1IjsRA8eAcMYZYyVfWUhVcsyzKlttp05pIOy/Q4XglAwijcM+kcg9SnDftW5AZ4Pw0tR5ym4NYDewBSz7oBMB7B80uoLyt2XuCSlLPK1cbJuqFA7Kwet+HkZ9ydj4NvwQITDvL9KT2AvP1xvaDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kGHGmvk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db8197d431so483321a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124810; x=1729729610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PC4Hs0E5dBLkCnCinTPyvf/aLxRI0UAFEABy+KMCotw=;
        b=0kGHGmvkTsMpbIrj+betRITdaHo8WJeRstWLoZwp2w72x8Igden3Mr4Y9O++fi+MJn
         C+7w5yRuNXENi8g0vMAME6igLaAp87UXljTMye+ZI+c0KEKgEL0ebrW6GDyiopRQqDK+
         IJZaeIjn2XHI6+dXj7KIhY27tEOWw4nm+rjaOoWEukhMVfWI/QqK7mViW7jTIeIYvH+q
         R9BlLAj5w5AdPcTm3bAxZfN9wAIrBAlDdtkosqTubVDQRZs1UGZ5HmmV7dP/434I8gwA
         M/mVZwEFLDVhRzUfaxb6PunPxQ4LqTZ+kvnspCDQBwN6lOm+WlpFQ+6tueGLWs41DIGF
         Gf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124810; x=1729729610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PC4Hs0E5dBLkCnCinTPyvf/aLxRI0UAFEABy+KMCotw=;
        b=Q7N7Wr+sec31aGEDG3ppLESrb2qpfXMc3qxmymaXcaeZWdPE92GmOhw1BPhIL5IKwa
         99v4mTDFOBhnLkGWd2ngF6BaC1RqSerbWtpuwRf3tfLA/PzRWgMJXCGOU9//RgC6s8nq
         1SDJCcgJgjmq1r6OHZZvHtMT0ubT/r+EhG8Samq59yorxkJXhNXHxzOGHZrcFM6MzAAy
         TGVpMTC46V08oTiRw09FbDBKVEIrzEcpXuXg9Tan7SuM2vBSngnPlfED2u6iF/n4XVSW
         CpoLI5PX33xreI2JsedJnqO3RhGoI1sdJ1OhNUvhySQfWZOrGFroozf5V42CBl4ObhiP
         xLiA==
X-Forwarded-Encrypted: i=1; AJvYcCXf7Gaf/VSmrN3EzjBI83tenYSpFaLAuqe5v2UQV8WLPKOFhIvTDaEZDPi9Ow3Y++4pQaFsYRDo1OhahzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiip9CwNp/f7Nj0LXF+PpMeeIT0DJUPG8ZDa90aCtqC60G7F1Y
	rv3ab8RRfAq/3Zb1t90uIldqxPbm9vZuCwr7wq/44W5xCLqCD02TJYV4qVogQA5RfXRftQ1z21N
	F/g==
X-Google-Smtp-Source: AGHT+IHcZEDYoFZqO9vMeq+B+EvG4lcuq/J99qdXry7nLvP1k/6cQ8eP6ZnNUNNOwC4IGrsVzTHyGmuCdRY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:ef50:0:b0:7ea:7907:7076 with SMTP id
 41be03b00d2f7-7eaa6c965a9mr6883a12.6.1729124809640; Wed, 16 Oct 2024 17:26:49
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:26:47 -0700
In-Reply-To: <20241015152157.2955229-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015152157.2955229-1-arnd@kernel.org>
Message-ID: <ZxBZx5EUhJFjTcXP@google.com>
Subject: Re: [PATCH] i915: fix DRM_I915_GVT_KVMGT dependencies
From: Sean Christopherson <seanjc@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Ripard <mripard@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Depending on x86 and KVM is not enough, as the kvm helper functions
> that get called here are controlled by CONFIG_KVM_X86, which is
> disabled if both KVM_INTEL and KVM_AMD are turned off.
> 
> ERROR: modpost: "kvm_write_track_remove_gfn" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "kvm_page_track_register_notifier" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "kvm_page_track_unregister_notifier" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "kvm_write_track_add_gfn" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> 
> Change the dependency to CONFIG_KVM_X86 instead.
> 
> Fixes: ea4290d77bda ("KVM: x86: leave kvm.ko out of the build if no vendor module is requested")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 46301c06d18a..985cb78d8256 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -118,9 +118,8 @@ config DRM_I915_USERPTR
>  config DRM_I915_GVT_KVMGT
>  	tristate "Enable KVM host support Intel GVT-g graphics virtualization"
>  	depends on DRM_I915
> -	depends on X86
> +	depends on KVM_X86

Can GVT-g even work on non-Intel CPUs?  I.e. would it make sense to take a
dependency on KVM_INTEL?

>  	depends on 64BIT
> -	depends on KVM
>  	depends on VFIO
>  	select DRM_I915_GVT
>  	select KVM_EXTERNAL_WRITE_TRACKING
> -- 
> 2.39.5
> 

