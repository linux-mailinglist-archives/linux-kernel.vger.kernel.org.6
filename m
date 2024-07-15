Return-Path: <linux-kernel+bounces-252244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDB93107F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E638E1F22286
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C316186296;
	Mon, 15 Jul 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gEkwye/B"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0C185E52
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032866; cv=none; b=NzU255kBbDzlsXfKiKMuCqVEDHfFWs89tR4Fo5z8E+uZhAwfv+T6HOp5AefqvJir4cvXFCnfweLyyiz6vns6zTW0aEqonEjBFGE8JorOAD9RFFySoTSmB1s3w6DIMwvSCJSOfYrN+IOlE43RewYSeBGWBc0bsboJiJOwNrvkk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032866; c=relaxed/simple;
	bh=RUbOu802FObA7IIjMs25LzRHhyMkjLGv4VUMVW8rvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP4pwEGmiKNQr8/y5HWiNpA7xS8SyC6xwIawST7hk9LSmwE1qsBhYrWTm7c6K1bJzzO78RVpDyF8Y2gF/h5LsKmRJ+rWSgfwwoujP+jVjbEB74tssEMwdhoTJRA6oQOib1zafbhc3j7i8hvIw75TljiNrgcLIYcYNOUTrwbYfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gEkwye/B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367ad05c7c7so303423f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721032863; x=1721637663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wE9o0AoaxkCNt6yWEqEM1FfzrCaKVi8ZoRBGSgkms4=;
        b=gEkwye/BvrHnFakG4gXUwazfOgSPGzRS65eoVNdDD0ubZ+elGfzyH5rGip8pGGUKdc
         4S9Y2K7jdUjP+AZ3qslm2ePmguyDwHvwMc4JapDRKBlG105YUE5uisig6oQSiBziZKvZ
         gSDy5c/qQsGTPLn1cenyOvrcpRcNM5M1g+j7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721032863; x=1721637663;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wE9o0AoaxkCNt6yWEqEM1FfzrCaKVi8ZoRBGSgkms4=;
        b=ecVgmj55LQ4YrnQ+d7rvAQ4eb/cMzVquowibCDfXu5iYSGb6SEv+6YJjP28XiPWGQl
         5P0MbmoA6mryAAgdh9tdSz5fS7DDTJ/KcAzxRQLl07ceYqhvXvjsEvgWzAjMJJp+LD09
         bxcU5138gUZ11rn6gPWCtrSvizoYn8/BYtVWOd8PBhwfyvQ35pRemSHgcjpZWvBl9kdt
         gdJw8NNHEeFw7UxMWZpKQjDILj7E57DvSxC2mdHW5XmPnNsOHXBFr6hqGjOJc2Xab73/
         AYluEJc9vtNPLxjlHQGattSinrkIy/VR++I1bt52R4OaruvdYXWnf1X0MxDc04nBi/OG
         KfIw==
X-Forwarded-Encrypted: i=1; AJvYcCWh8P89X1KKrtC5uHlN5zC2CTrX+rQflgvWEbhdBPmWlKG1Xnm/WiCfoaFhhPi09PkOvTdCzifw7f/hISET2aBYe4YQWjV+xjXQFTII
X-Gm-Message-State: AOJu0YzLSLpvOKIBGsjvUz8pLOQzWXAndYDaCcxnqUb9MoMD6mazbSCA
	Vgi5xAKGAbR8NMqtj6V0FT9iMtGCDo0QfbfHS0C6BkS+f5LJBnuTRCDZ+nsXHPY=
X-Google-Smtp-Source: AGHT+IEnN6FOav9A3AKqXktLUvs+7f+spQpY4HMaSuJJNHw/kLWQn/dIV7dG+F9Zkj8/H4T8tKXNZA==
X-Received: by 2002:a05:600c:3b86:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-426708f1979mr107374755e9.2.1721032862752;
        Mon, 15 Jul 2024 01:41:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc229sm112008435e9.38.2024.07.15.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:41:02 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:41:00 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: "Alexander F. Lent" <lx@xanderlent.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] accel/ivpu: Add missing MODULE_FIRMWARE metadata
Message-ID: <ZpTgnNxSNbbeEWQ8@phenom.ffwll.local>
Mail-Followup-To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	"Alexander F. Lent" <lx@xanderlent.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240709-fix-ivpu-firmware-metadata-v3-1-55f70bba055b@xanderlent.com>
 <35a7963e-e92b-4c73-b03d-a846e93adf5a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a7963e-e92b-4c73-b03d-a846e93adf5a@linux.intel.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 10, 2024 at 12:23:06PM +0200, Jacek Lawrynowicz wrote:
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

I'm assuming you'll also apply this one?
-Sima

> 
> On 09.07.2024 13:54, Alexander F. Lent wrote:
> > Modules that load firmware from various paths at runtime must declare
> > those paths at compile time, via the MODULE_FIRMWARE macro, so that the
> > firmware paths are included in the module's metadata.
> > 
> > The accel/ivpu driver loads firmware but lacks this metadata,
> > preventing dracut from correctly locating firmware files. Fix it.
> > 
> > Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
> > Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
> > Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
> > ---
> > Hi Jacek,
> > 
> > Thanks for catching the error, and for the more succinct comment.
> > Please find v3 attached.
> > ---
> > Changes in v3:
> > - Simplify comment, per review.
> > - Fix typo in 40xx firmware path, per review.
> > - Link to v2: https://lore.kernel.org/r/20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com
> > 
> > Changes in v2:
> > - Only annotate the module with the production firmware paths, per review.
> > - Drop macros for de-duping firmware fileames, just use string literals, per review.
> > - Link to v1: https://lore.kernel.org/r/20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com
> > ---
> >  drivers/accel/ivpu/ivpu_fw.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> > index 1457300828bf..ef717802a3c8 100644
> > --- a/drivers/accel/ivpu/ivpu_fw.c
> > +++ b/drivers/accel/ivpu/ivpu_fw.c
> > @@ -58,6 +58,10 @@ static struct {
> >  	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
> >  };
> >  
> > +/* Production fw_names from the table above */
> > +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
> > +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
> > +
> >  static int ivpu_fw_request(struct ivpu_device *vdev)
> >  {
> >  	int ret = -ENOENT;
> > 
> > ---
> > base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
> > change-id: 20240704-fix-ivpu-firmware-metadata-3d02bd60768d
> > 
> > Best regards,

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

