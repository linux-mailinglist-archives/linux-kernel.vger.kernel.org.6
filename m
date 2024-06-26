Return-Path: <linux-kernel+bounces-230542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AA917E52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC3B273A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31A617A922;
	Wed, 26 Jun 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="pCSxauuG"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09016178CEA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398357; cv=none; b=e0ShYhqyHTxljo4+AzQqSmwaWrbu86BkoGE6sgYpPVOmytVe9yuDMX2sVpQOx1gT1U4UvAXIzmD3enbbAoKDPnt4nId7wRkxvohKxRYxjKxR87yiey+O4HTCNvr1PY7Dj2mHR6DqyfKhRW4RhYVTTA262bdrWS5L1whWbn0zkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398357; c=relaxed/simple;
	bh=0WHKZbvNuX92u84qLcbUXpAEPMgHXpjkUAo84IV0s/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCoJtEuKUgW2a3cZF1nhwhfb7SuTp/Z/jQSIV/tuQtpCN1xoYU1y06O35g0kiC95qNP2PJVSwLCXQ2HX0N4F84/yHOEZOXvTQxMmVaCbbkDi2kS308qKgE4UBHT8ooYHEGkvZhbQqf86M6bHwNGqppaTe1CS/dG1j5hqgI+djxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=pCSxauuG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4450292a50bso6504001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1719398354; x=1720003154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHKZbvNuX92u84qLcbUXpAEPMgHXpjkUAo84IV0s/o=;
        b=pCSxauuG+J/xl+MRtZqsL2O046UHewIWUsgp5rvi3ADzvhBhn+4e14ecMwxEF1z4bz
         6P1+dgOYF5TOXBMbG1Z9QLvSnC9ZlbnmxEM2VHRlNaybExTaX4YhSmOkai7tmXh2d3GH
         S3HoP2sDv9Id3vfoXy3AYQCSiT7HfLCx+A6F795VBM+i8neeJbA7Is7cyz437G1DNUK0
         d64vxJ4douE2IdfZc9BFHYbx0cpB3/rorP6aJlXGBN4+OwBbnGERl3aRoiC+Nk1Veqcx
         Nkxo1iNxwkmCLXAenPkEPk/r6Kxmw9sgOVXyKgWyb8ZJiVewIebFzsLhpGSSItNpbMdx
         9asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398354; x=1720003154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WHKZbvNuX92u84qLcbUXpAEPMgHXpjkUAo84IV0s/o=;
        b=K6gZwp9wrSHDA1GZocdM1kjtfxJ6HpfSGZN4MyrnbeXUo5WyPkXSYsEK3Se0PwCLk3
         nXMF5W7AwvR8Ji6OcJu9G3Qla9xHYfv0lMqZPr7ZSseNqLE/x02XTDpoUkK1vp83zKPo
         YNVkwjgec5ztc1er+g+2+VpyyK4+LgDZB4w33TV5kYPsrhQJBIweih+pwUAmOxzdUNG8
         Qsyil1KPIFwaHIbw2ikXnxj8pVGtYEXXGZsURU9AaG/d+/9tnZaA/DHrMlR6ZZcKGtWl
         JxtDrgsCO1ehsRT5I2+veuGknXv67FCr8a86McUUiq1Vx9K2Df3eAlooksnK9suAMS+V
         dmCg==
X-Forwarded-Encrypted: i=1; AJvYcCV78iu+Eb4UynwNAad9PLK3BbLMIzYgpAsfkRG22d4tg0l0vXgHSxQ+oQBQ2W9gg4bsNSNiJYVRH++CwDOSRf0wDJ2DM5Po4QTtUGXP
X-Gm-Message-State: AOJu0YwcB1e4wB7jNqpOlQp6nfsumhRdZanuXgOuqaUuaxYqdm19TT7I
	V/GWqzbGeF7vxAX3xBlRF/ER4AhQWrUv/YzL6vHcyIsYCbRfdr5eUMUcoCc5vr5Yc+Fetc7myHF
	JT8v2tesL6bKV7YYl0ciKi6s7a3OFpRjZgF2jsg==
X-Google-Smtp-Source: AGHT+IEJ812eF8zWIpx152aNazf7TkH1mzWCEt7UM4JhxnxcwMH6yI68IWE7/8fYUJAfdVLiQBlSAhQNkYlNULRX6aI=
X-Received: by 2002:a05:622a:49:b0:440:f54d:1bac with SMTP id
 d75a77b69052e-444d91a819dmr125069131cf.16.1719398353655; Wed, 26 Jun 2024
 03:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local> <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
In-Reply-To: <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Jun 2024 11:39:01 +0100
Message-ID: <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Daniel Vetter <daniel@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 26 Jun 2024 at 09:28, Lucas Stach <l.stach@pengutronix.de> wrote:
> Mesa doesn't cope right now. Mostly because of the renderonly thing
> where we magically need to match render devices to otherwise render
> incapable KMS devices. The way this matching works is that the
> renderonly code tries to open a screen on a rendernode and if that
> succeeds we treat it as the matching render device.
>
> The core of the issue is that we have no way of specifying which kind
> of screen we need at that point, i.e. if the screen should have 3D
> render capabilities or if compute-only or even NN-accel-only would be
> okay. So we can't fail screen creation if there is no 3D engine, as
> this would break the teflon case, which needs a screen for the NN
> accel, but once we successfully create a screen reanderonly might treat
> the thing as a rendering device.
> So we are kind of stuck here between breaking one or the other use-
> case. I'm leaning heavily into the direction of just fixing Mesa, so we
> can specify the type of screen we need at creation time to avoid the
> renderonly issue, porting this change as far back as reasonably
> possible and file old userspace into shit-happens.

Yeah, honestly this sounds like the best solution to me too.

Cheers,
Daniel

