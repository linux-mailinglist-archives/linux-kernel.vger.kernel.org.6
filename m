Return-Path: <linux-kernel+bounces-233712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D991F91BBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8152B1F22297
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C60153810;
	Fri, 28 Jun 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="B5HthRP+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD61487EB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568475; cv=none; b=YA1IlVcR9QvgucIKrt5F3sMuz8DCCRzRDopMWEZRbWYTyffby1HUTE13ZIPITIBXWl/dDIvua9FTybB5wCfaL/78gxCwUBVRCkr6eHFOAprQHx1zwuq3LXsS6qdrBujORKISu8jIqWevnTLUtaavrvKYIM0e6/4GpQUeqFlbiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568475; c=relaxed/simple;
	bh=i9yd5IeywhU3UMB+zoN0GXyMJftk0239YPKabyLj6sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peGhujcAFpTeltVOqFvSDTIU/RTT6ik8vpzN4TPOTpGSIuyuEPQeCWyrjcIZnuYXzxsDevoO3ngTqLhsIxsh/ZR3zyM8h/klDLPgsoWhJ7+uIywKdy5tZayjE9K/XrV1vJ62ausLnbY0o3+ZGIi3GogVe+OZZ5bCxMLHUTMLm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=B5HthRP+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-707040e3017so275310a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1719568473; x=1720173273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9yd5IeywhU3UMB+zoN0GXyMJftk0239YPKabyLj6sg=;
        b=B5HthRP+cGMS7y6PptPDsKOjGQGYfmdGK8WF0LqGikkuaPlwtMnSgVvHX28bHME6Dw
         RDg1FsxS7sJvQK0N964krHU5leDVWLgORorGCvCAVZA4Te5tCXG5cXPnHn1u1wy+58f3
         4cnUsrpCbV6EPaGsOjE1geHg/WuOGDekOtMBifSGV2Rb+iXwE5G92lR/leQOBQoapOxW
         Bg1ylnU8kKmGWsx3Cu8uw8wpYAlxsdaKz0xmTZHEPHcbflDvPVDY6YOguk6fVn3jBxI6
         jtI762Z9/SAVIEMwELUYRJY1UgKIyqHVJuiUi2E0iDEwr/9V4i5+p49KrHlOW3sYVV2W
         UUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568473; x=1720173273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9yd5IeywhU3UMB+zoN0GXyMJftk0239YPKabyLj6sg=;
        b=QiVrWkBwUtFHknL3F6up/5DOYaHCymiFK9U16/IxG7DDKuiM0E4BqE37t/WFq7711/
         ussGihApHGdOAHiKgcgI/pwLtVX4gFXLOgLFEMUiGAuwT97+Gi+1Had9QUCeKy2ynxFE
         MwMAj/TWqRorRgvHYEUvIB9iRmCGOptw/BA5b9tW3yErjaNZK0Qt4fGMeEYTXbyEkN4r
         mcS/TbjiD5H9fN9xNdeX+c3uaS5oIxI0RFf9ZEby/wsFB9Gbv0EcF09M2E7vZYEnUc5D
         EuH/Z8ubBknmkWKWFTT5FLfYslUa288BuQYYhU9XFWk+W1Dc4M9Bkhqu/xMCnncXvq6P
         AYkg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+T2Sx5mRIJP13hSgN1rCqq9P7MvEMCUb/baAEJ8+AUee41PX1aAXdy16HPSNlbC5hE729CDcs98kWUArD7Z6BHWhST6/X0vCyarq
X-Gm-Message-State: AOJu0YyKe7pUtnVga0M44PI8v2OrWYL39pmxQyVGkWo0seLvDn1x8Svo
	iL1FRHm1SWbCYQyqJRIzin/TSanLVsTJ1Ro7gpjX2cZWag9Y5rXmfE/N8JDDzia2E5EkAtGjBih
	koUwpRULdpx9BT0MADVfpUfIrdOQ1iwxbmb2qAQ==
X-Google-Smtp-Source: AGHT+IGvcAEX02VPxewqLgLB68oUm1hCavQ9Ot+w2MXu96wdn0wBsvfW3v6NAE8XWNNpFNolk3LKsB/HSTb26oji3wM=
X-Received: by 2002:a05:6a20:3556:b0:1bd:1a36:321b with SMTP id
 adf61e73a8af0-1bd1a363345mr9391899637.60.1719568473476; Fri, 28 Jun 2024
 02:54:33 -0700 (PDT)
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
 <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
 <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local> <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
 <CAAObsKATM0hQ=XTzTTucArBzSnVEu-CfdkUU4c6UVHd1+G5-gw@mail.gmail.com>
In-Reply-To: <CAAObsKATM0hQ=XTzTTucArBzSnVEu-CfdkUU4c6UVHd1+G5-gw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 28 Jun 2024 10:54:20 +0100
Message-ID: <CAPj87rNtzrMjL6tFfDG9-yMAiomi+PxwL0eXW3RYDaJs+knhbw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Daniel Stone <daniels@collabora.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 28 Jun 2024 at 10:43, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> On Wed, Jun 26, 2024 at 9:26=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> > It's not just etnaviv, it's literally every Mesa driver which works
> > with decoupled render/display. So that would be etnaviv-v2,
> > panfrost-v2, panthor-v2, v3d-v2, powervr-v2, ... albeit those don't
> > tend to have multiple instances.
>
> TBH, I think VeriSilicon is the only IP vendor that has recycled a
> render-only IP into a compute-only IP.
>
> That is why I liked the approach of conditionally creating an accel
> node, as it neatly reflects that reality.
>
> > Anyway, I'm still leaning towards the answer being: this is not an
> > etnaviv regression caused by NPU, it's a longstanding generic Mesa
> > issue for which the answer is to fix the known fragility.
>
> My understanding of the consensus so far is that Mesa should be fixed
> so that Gallium drivers can fail at screen init if the device doesn't
> support some new usage flags that we would be adding.
>
> If for some reason that doesn't work, we would be looking at having
> etnaviv use a different kind of driver name, such as etnaviv-npu or
> etnaviv-compute.
>
> Did I get it right?

Yep, wfm. :)

Cheers,
Daniel

