Return-Path: <linux-kernel+bounces-234321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C687191C52A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B7D287F85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6A1CCCCE;
	Fri, 28 Jun 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hs2IDFMb"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D41860
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596837; cv=none; b=bwcVRpX/A8L3rGOUH/9C2uj40VAuVigTPxghZwOib/Qvpn0QXSpPGsafhpgfMVkDzPiOG6++7AKwE0KLLvgvPDC4y7bukZHmhp6Ss/weUH5mxC5S8cTJmDtAaZMOJf+mibBzNOkC1WC5Zesv601vyHJajj1Z6z7N8uDMevNeCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596837; c=relaxed/simple;
	bh=jeKE3wLCjyYkCLtELoOBJdavtto3Dgd5gIknRk6bEgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE52Gkp4z/r67el9qlzDXditla6uefcoWYa/3NVWUQoAJI9ml4vgktZr6aGwE/NgsdwuD4UsyIm+s/Zku0PVJ25MBZD2bRLRoFmZ4EAVIoTpXI2gq+wT/+f6wcIZIGlsjYmX1IktuiJ9VMCQLHXRtTKkNXZDdlman++7kWureTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hs2IDFMb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec5f1b4ee7so1318561fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719596834; x=1720201634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXawiii30SbY22A0WpPOSynPJrUU92tc5F+sXUGGBi4=;
        b=hs2IDFMb/i/xVXhiKerrVG4SMmXpKqRLVVnd+mYJJuiuIIUDuDS5tW/qPZ2fEIeYK1
         swkD2kJ8J6laajGzv7NQKjdflHBRxnvrlNWxRs7lR2hZDkxmS8Id0IjcTDuDso9TB4lp
         uN0VeHX52G23Ug0DvtBm2sh/0gx4ivk5ZF+cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719596834; x=1720201634;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXawiii30SbY22A0WpPOSynPJrUU92tc5F+sXUGGBi4=;
        b=LWj7ybkpZv13/Yy/mA0zyapOeP7M734snlB6bFAAbMaKup6MdN6MwWhLHSUc7Y07hw
         TIBp810LHtxtyeO1NQxzc3P71Jyp1vIKx/IiY+a0G6Do5jKcAHmuF5Uk9HQUrZDU+krs
         TICboJttnxDJzy42gh96DtFgwwm87Yvugq3G/6112i5O1edHTL0cG2pRQkkfZwbX6LrG
         40x+u8eqCpKhja/GXRUWRXSxToMVW3jRGkiQPMj2yIqRzTS8MyvBf5jbs0EArPdH4Kaz
         Do/sa+QFaw0nQW40UAVvHM5dyMOgsFmhGNIXknwPOUGXvzzFlqdeU4O4uw6ldwi26VpI
         SkIw==
X-Forwarded-Encrypted: i=1; AJvYcCUim7OuW0aGc7BDsOYYi3mv27k2/RkHdBQUZN/AMb3alZQlQoGqkwpVk55R/p+SKEsZuaqXlri1TfE+QnWfUHwe8G1eiTBbnV3NX/vL
X-Gm-Message-State: AOJu0Yz+/XeWMz8YoISka4J1BhtEWESTXO+U7jHnnsrurWIrpkn9R6Sy
	gBFCqNs7FcjGOPkhvlnQxavE/LNisC5Iph0hF06Oj4Vj4KCWhXZbGtCv6l/a7cM=
X-Google-Smtp-Source: AGHT+IFupNHWZXb+QLKkwFqtsw/yyqnuJNIOBgzzTmWF8Qysi7dT/74C6TF8L4BTTqPJeAphNz+eXQ==
X-Received: by 2002:a2e:b0d6:0:b0:2ec:4399:9bfc with SMTP id 38308e7fff4ca-2ec55fe3a56mr117145931fa.0.1719596833481;
        Fri, 28 Jun 2024 10:47:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm44514485e9.32.2024.06.28.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:47:12 -0700 (PDT)
Date: Fri, 28 Jun 2024 19:47:10 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <Zn73Hr14DUHfhDz6@phenom.ffwll.local>
Mail-Followup-To: Daniel Stone <daniel@fooishbar.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>
References: <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local>
 <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
 <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
 <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local>
 <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 26, 2024 at 08:26:04PM +0100, Daniel Stone wrote:
> On Wed, 26 Jun 2024 at 18:52, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Jun 26, 2024 at 11:39:01AM +0100, Daniel Stone wrote:
> > > On Wed, 26 Jun 2024 at 09:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > So we are kind of stuck here between breaking one or the other use-
> > > > case. I'm leaning heavily into the direction of just fixing Mesa, so we
> > > > can specify the type of screen we need at creation time to avoid the
> > > > renderonly issue, porting this change as far back as reasonably
> > > > possible and file old userspace into shit-happens.
> > >
> > > Yeah, honestly this sounds like the best solution to me too.
> >
> > Yeah mesa sounds kinda broken here ...
> >
> > What might work in the kernel is if you publish a fake 3d engine that's
> > too new for broken mesa, if that's enough to make it fail to bind? And if
> > mesa still happily binds against that, then yeah it's probably too broken
> > and we need etnaviv-v2 (as a drm driver uapi name, I think that's what
> > mesa filters?) for anything new (including the NN-only ones).
> >
> > I would still try to avoid that, but just in case someone screams about
> > regressions.
> 
> It's not just etnaviv, it's literally every Mesa driver which works
> with decoupled render/display. So that would be etnaviv-v2,
> panfrost-v2, panthor-v2, v3d-v2, powervr-v2, ... albeit those don't
> tend to have multiple instances.

So essentially mesa just burns&crashes when old mesa runs on a newer
kernel with support for a chip that mesa doesn't know about?

> Anyway, I'm still leaning towards the answer being: this is not an
> etnaviv regression caused by NPU, it's a longstanding generic Mesa
> issue for which the answer is to fix the known fragility.

If the above is correct, then yes I think we should just fix mesa. Feels
like the breakage is too obviously there, and that's all we'll do unless
the screaming gets too loud.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

