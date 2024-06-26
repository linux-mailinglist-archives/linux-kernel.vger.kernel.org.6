Return-Path: <linux-kernel+bounces-231300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A41918B81
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C2CB23FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0051190062;
	Wed, 26 Jun 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MoM49iQU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2340190041
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424353; cv=none; b=Y8frXhldH3aTTzsLxKOefkt25WHHggygtcJm0jtZ3kmjgwsVOuZYvG3yAbLs23aZMFiCXQPyD88+p2FGAsLuVEEVzcmVqEwOb0KqnpFcEc0JjH9uavCxpyIxLG6Wr7j30X9QFTVp1h558sZa18Sec/3ZkPHGTDxKuqpyKPdZMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424353; c=relaxed/simple;
	bh=8C+0143qN86BEc8WiI6OxATrNw/eufThl5x34v/wiPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqhwBgGe6eCZm7eOo8frfUwP3o0ijWokYEAPt90wPT6PUF3SfeTVXd+bhvm/4XlHTuOu/ONx/Q4L1cra+OH9iQhys4sxoUqmhiX7FlrFW3VuBcejR0HRogHDbeFbZSANo6zNjbTDPWPYXjqlKUYsT99YetLZUGTI2JpHd+eT430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=MoM49iQU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36354272c2dso299855f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719424349; x=1720029149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8h+d1YS2lRYJVmm9UX7UTK0tKF7jVIiE4l199Xa8oo=;
        b=MoM49iQUpNvILimRhVcZYoKzNPnWcG7xL0web31NlwK9NIacRsfxjstZHbgHm9NpbI
         7bmBjIKNFbIca4SCPsp3kUEiqtn67F48zQm5P3O8x9HdRoMbvoFQWvCUUwDxyuuST2rw
         OLIZ/aKOosNNoz4PXWAwro2hC/3o9SEU5NWFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424349; x=1720029149;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8h+d1YS2lRYJVmm9UX7UTK0tKF7jVIiE4l199Xa8oo=;
        b=US7391yftIQ//y906jWEvco0tYz05P+U9OykKaF7E19B7ZQKeSmhejADjUYu3SSvqr
         yC4YGk4+nqWaXGXJKPCyuUqnt/Wjle1DI5lh1W3LLyMw1aXN9is94pNHyUVYuOEj2Yx+
         ms6DOeSKb1CjH5I7TP7HW4knlVcPLllQnWClljylmZC//EBDqnaoFh6TVqj26l7hyDUW
         14AtLLrn93tgP86YpCBe1H1c/tkNr9WZhwoghsZwDA4Q4NWr5cNKAlMW5Oyd94OaVaAr
         ffTMvNR2vaoKF0ladr5/wdoNadoFme24W7vAnyyoN3oW4ZxAR5lQtjQ0brtaAu/dGmoe
         FM4A==
X-Forwarded-Encrypted: i=1; AJvYcCUSz1e0o2ihNpCb8PfpF1A+IgPbzCM967FgxheWySnpfqhoQNdK1zsHxtUsT3uRqrUIBifSvHj2XOY0pvyNJ7Cy7LF2LR7lkBrim7jN
X-Gm-Message-State: AOJu0Ywr6TxHpSaofcAASiQHVzd4iiOKDrmO+xN/BgrZA1IO3wekTSIx
	WgzCpfvBd4xb0m/S8ZcRfiYD5hoMe7SHDbCmomC8GWWw3LvzWP5vfVYwKGTrBwE=
X-Google-Smtp-Source: AGHT+IHziMriFU1IvsOiXYNLoJqYCMel+vAaYctnt6KK80gYjPlmHIUg0ZT4GOMRpR+pse+fG/yFGw==
X-Received: by 2002:a05:600c:470f:b0:422:78c:82f6 with SMTP id 5b1f17b1804b1-42487ef1ef5mr100585725e9.3.1719424348980;
        Wed, 26 Jun 2024 10:52:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3670c4c1fb4sm3988958f8f.76.2024.06.26.10.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:52:28 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:52:26 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local>
Mail-Followup-To: Daniel Stone <daniel@fooishbar.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local>
 <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
 <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 26, 2024 at 11:39:01AM +0100, Daniel Stone wrote:
> Hi,
> 
> On Wed, 26 Jun 2024 at 09:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Mesa doesn't cope right now. Mostly because of the renderonly thing
> > where we magically need to match render devices to otherwise render
> > incapable KMS devices. The way this matching works is that the
> > renderonly code tries to open a screen on a rendernode and if that
> > succeeds we treat it as the matching render device.
> >
> > The core of the issue is that we have no way of specifying which kind
> > of screen we need at that point, i.e. if the screen should have 3D
> > render capabilities or if compute-only or even NN-accel-only would be
> > okay. So we can't fail screen creation if there is no 3D engine, as
> > this would break the teflon case, which needs a screen for the NN
> > accel, but once we successfully create a screen reanderonly might treat
> > the thing as a rendering device.
> > So we are kind of stuck here between breaking one or the other use-
> > case. I'm leaning heavily into the direction of just fixing Mesa, so we
> > can specify the type of screen we need at creation time to avoid the
> > renderonly issue, porting this change as far back as reasonably
> > possible and file old userspace into shit-happens.
> 
> Yeah, honestly this sounds like the best solution to me too.

Yeah mesa sounds kinda broken here ...

What might work in the kernel is if you publish a fake 3d engine that's
too new for broken mesa, if that's enough to make it fail to bind? And if
mesa still happily binds against that, then yeah it's probably too broken
and we need etnaviv-v2 (as a drm driver uapi name, I think that's what
mesa filters?) for anything new (including the NN-only ones).

I would still try to avoid that, but just in case someone screams about
regressions.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

