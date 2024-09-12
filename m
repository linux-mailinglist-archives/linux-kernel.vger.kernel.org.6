Return-Path: <linux-kernel+bounces-326358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3D976720
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3AB1C20E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DC1A00CF;
	Thu, 12 Sep 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO6tbmqD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5418FDD7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138932; cv=none; b=rCI/Jx8bVsEFJqzeqv0ziN1yIlarSi9hGfwTBQ6DCX1rJcaLZ8b9/ZYIXQtFpBXdXvb80e79Br6XSJgxmXekqfG9iS+0Gwsumhus9CDAID5j9i7IBRSXbz/WPHDBIMT4dqLaSkk5/L8r/+4t1uauZYsFM1YZtvV5p6SGHgPj87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138932; c=relaxed/simple;
	bh=iSFRqjS802RyPaWewVKLE6Z0eOo6FOgytp1gzYNapWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTsM0LWIqf+ySGgjZ/0aQN6th+ZDKFaxyFqlRjqkh1xTBS3NYjYsFl5x8647wOqA7Ry5OfajtwgSgNtl6s+8ZazY2wruddjV3M7noVbu7XUdahJKo5Fh4NG0C9IsZdnRRx3OG1EtHH6UUica4vKXA5XFiEMsilFq1GRfzHlY2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SO6tbmqD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so5495615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726138929; x=1726743729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8YgDvsz0zZZNsvZSRLc2gP+RWN7Tywa4avobNoXpqs=;
        b=SO6tbmqDygHxZOF6/+k8NphqCSmin7AUO+rXJrFOq3rwtwN9xU6zN3Af5S/cZNfNRl
         /MXdbLLNFkakXjE5vGbEjJ2jcKAFSndtDwjV3EFZSHnLRkrHVABJgmAr3WX5CTC26uj6
         5ypxjDE20gLNecFVovxIBnFzBskvV0aCMRjcdVEKMHydKAqh3BDDxPvWVgaqfqe8bhVd
         S/2z/OK/D9x4czRIslgDDuIAx8Fnu7oGuY0c6QanboON2KpuJmHVtEHHathionTLR6Xt
         o7ZL8Ctc5VJEsbhFw1MYmDatgq16mHHY8oKPU9KOAs7nHPSKrg2Bkip8V06rEnILXGvI
         6EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726138929; x=1726743729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8YgDvsz0zZZNsvZSRLc2gP+RWN7Tywa4avobNoXpqs=;
        b=JeeJIUymPbgZIfYlOa/GTGA7akLccJdUFpuiCDK51yF/PY/KXoJNwNcV3DWEZmv7r3
         Ga4L68GdQgQds680cQH2Q0RFMWqLGBDAtt1MhvKWIU4EXMNSYwnX53Rxd+R+3mKsP/qC
         3dEQxZ1gQq7Y2clmkIj3syIwfG/FWYILw+XKB2ICiNtFIlAhFJ/9Ayee1MiG+/+8GIdG
         SheRZIQrlH1Y3UUri7Tv05UNzpTY8qqOoyN4EycRH8NsFxW6jGcRSCWlwHP4/F0HQRv5
         cXMXWUqpZjLm4V2e6mBio9r9cK/14En4ja1Zu1RQ8yxsAip6BxBZykcwFvHENpC8GT6i
         oO0w==
X-Forwarded-Encrypted: i=1; AJvYcCWqwkucpRr87RIYsFZKoXV5qxsWquLD+L71NG1xET/PtxmrNR6F+2AC90HlU0/Vyb3dPZ/DB0WM2J1gF9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Z7xgUisn0XNppyXWY12ybZb1DUy6SEPT7CfL1FoFkr6xoIUd
	6HsoSJUCL1+s0jDMZgB82T3/TPtDcbkYXoY2xvRhjxnSDzlkAHuibjK4mHvcZNw=
X-Google-Smtp-Source: AGHT+IGiAe01YvkcVX90GD90UjLnJ3ZtuxUcowYL8ZhP77oXJFmWmoTp7C6JXVc6jHyAE+p5gVSttQ==
X-Received: by 2002:a05:6000:1e50:b0:374:c059:f2c5 with SMTP id ffacd0b85a97d-378c2cfc673mr1365424f8f.22.1726138927751;
        Thu, 12 Sep 2024 04:02:07 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3738sm14038583f8f.69.2024.09.12.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:02:07 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:02:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Christophe de Dinechin <cdupontd@redhat.com>
Cc: Cedric Xing <cedric.xing@intel.com>,
	"dan. j. williams" <dan.j.williams@intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-coco <linux-coco@lists.linux.dev>, suzuki.poulose@arm.com,
	sami.mujawar@arm.com
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <20240912110228.GA28024@myrica>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <B3201E6B-D479-45EE-9E44-868042E04E5B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3201E6B-D479-45EE-9E44-868042E04E5B@redhat.com>

On Thu, Sep 12, 2024 at 12:03:05PM +0200, Christophe de Dinechin wrote:
> It’s nice to have a similar structure between ARM and x86, but how does
> user space know what each register holds? For example, say that I want
> a digest of the initial VM state, of the boot configuration, of the
> command line, or of the firmware, where do I get that? When using a TPM,
> there are conventions on which PCR stores which particular piece of
> information.

It's early days for Arm and this is still something we need to formalize.
The initial VM state always goes in the RIM (~MRTD) and REM[0-3] (~RTMR)
contain runtime measurements. TDX already defined a correspondence between
PCR and RTMR in UEFI:

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension

  TPM PCR Index | TDX-measurement register
   ---------------------------------------
  0             |   MRTD
  1, 7          |   RTMR[0]
  2~6           |   RTMR[1]
  8~15          |   RTMR[2]


It would make sense for Arm to follow the same convention. This way, FW
knows where to put new measurements. And extending this mapping, remaining
PCRs could for example all go in RTMR[3].

Verifiers and other consumers don't need to know any of these conventions,
they can just read the event log to know where each component was measured.

> Is the idea to defer that to user space, or should we also have some
> symlinks exposing this or that specific register when it exists under
> a common, platform-agnostic name? e.g. on ARM you would have
> 
> /sys/kernel/config/tsm/initial_vm_state -> ./rim
> 
> It looks to me like this could simplify the writing of user-space
> attestation agents, for example. But then, maybe I’m too optimistic
> and such agents would always be platform-dependent anyway.

I agree, it may be useful to have a single platform-agnostic link for
generic applications that need to extend measurements. For example one
RTMR could be picked by the TSM driver:

/sys/kernel/config/tsm/extend_measurement -> ./rtmr3

I'm not sure it's useful to provide a shortcut to initial_vm_state
however, because as I understand it an attestation agent just wants to
bundle all digests and send them to a verifier, something already provided
in a platform-agnostic way by configfs-tsm report/

Thanks,
Jean

> 
> One data point is that about one year ago, CoCo has already split the
> platform dependencies away in their attestation stack, at the time
> mostly to cover differences between AMD and Intel.
> 
> > 
> > Thanks,
> > Jean
> > 
> > 
> 
> Cheers,
> Christophe de Dinechin (https://c3d.github.io)
> Freedom Covenant (https://github.com/c3d/freedom-covenant)
> Theory of Incomplete Measurements (https://c3d.github.io/TIM)
> 

