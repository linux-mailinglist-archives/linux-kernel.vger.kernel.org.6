Return-Path: <linux-kernel+bounces-172712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93C8BF5B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D02820CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944D179AF;
	Wed,  8 May 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="PnhsxJz/"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28931208D1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147229; cv=none; b=sBuYYG8ZOdSNXSOKyYAYloW5rLX+yp1kz0nkYiemf3Fdd9I4PVzKFzqPDfCshsaRJSH0TBev6AtsRsbcyuRH1dUOptJKY7Id13g8VsDyAPmlOB5y5DX7DohlNxMZWGsCyrvxAo6W/YopK2H9zKPOh+DMYKnae1xOTP2G2El9Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147229; c=relaxed/simple;
	bh=y+KiVnKXCsbPvzNdODTp1oqWb7A8Ywtkjz6UCYJzfVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=piGCaQrxdb5Wx71GczczgIz1eNhBDCKcldl95MNTWQG8+jod3KCE0+kR19m+S8+ywRHUE76UfjPpFfawXNY6cB3pIclGbc8rytO++ekwgHlJW5h4vVINn8hB62RC1R/nkQ/NtidGo8v3GeK+1x9FumgKsBBfFXwRTmkSSLbfeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=PnhsxJz/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7928dae7befso345763685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1715147227; x=1715752027; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+KiVnKXCsbPvzNdODTp1oqWb7A8Ywtkjz6UCYJzfVw=;
        b=PnhsxJz/j1FE2gMOj5zgLj/RHF2FfD14l8FA6R4LL94bwqCHzl9bmIMMrbj2ZNCypd
         UE22YUJwdX1JApK7ZTG+C3igGr9BmM8+RC0LxaD4tI/hRzSSQshDRyg1Sq5dxhld7/pX
         7A8ey7HvbJWcWt5l+aWSRTqMaj5603hTXJUVtL5GaF5wTP8RlW5yZlk3lIEguKXxiAzr
         rSALGfSFjWmrxVcR43cUuf1IxEnQ1OI7sdQnv354zymLy8abzypBUWY5U5TnZ2OTQWtA
         RqkijhGGt8dRKpuHQr+Y6NtaLE1lsbVPDtvue9hnmpTOoOEolEZEd6Ap+tfwL7E2if1o
         gHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715147227; x=1715752027;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+KiVnKXCsbPvzNdODTp1oqWb7A8Ywtkjz6UCYJzfVw=;
        b=i3bJIelQzyoXYj1BdRkm9Q9/mJGllT47VSJKUYulb/AgfX9RmF1dPHrO5CJ2S+UWMA
         TCRW/t8xEDIavRHSNseAQjvd67b0qYleaNN+B1hBMs9ZKsGIgZu1nLJMbtoZM1i2gs22
         7RoCUErT2++nSWPRSG7C3uTYMRCMXiC7XPHaqeGXjbqHq+05lgcewWHkA+hKxmtrgmr7
         /fFid4xb8AtjifN6XrmEKeaJ/oQdlGSqt/IWP0xF6PHO9BvMbhyMruI7oOHugxI3Z0bO
         IidCWv1d8kGcpoCspJLM7G/xiasW+rambLesgbjmLBlJgxj9d75Qc+w0NGXi/2SSeFoK
         begQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPg++8flKd7flXMF+tzVLmtCyK8lwdRxoRX9orDquMaSHP1TkOnARlqVasxhK0m91DMBjkh7KkPGdU6vEtTbbhtTQMrraMwjQP/Lj8
X-Gm-Message-State: AOJu0YwqzybYdiRVUr+PzECbkk/mw+l7agjGXnVcHQqs/L+Al/84/BvM
	6BGEftfS+z41f+bs2kvcfLrc7cy0w8fgoYgNdNbOSWaXCaqjRwheYlYl/PZ00LmDuvDXQIPN4VR
	7rbS6FKQTVsaBTW92JICXLOEaf5nXe3K/6bIRgw==
X-Google-Smtp-Source: AGHT+IFowOzBUiqN7WcnwrA/LBPZg7N9dHpRdxWUo9yBNCLNtQC6wcuw0TpbjZ6kxNa/4cgHeYqTO5liJl8XTfGujfs=
X-Received: by 2002:a05:6214:29c2:b0:6a0:c922:5014 with SMTP id
 6a1803df08f44-6a151528bbamr23726776d6.21.1715147226926; Tue, 07 May 2024
 22:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat> <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
 <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com> <ZjoNTw-TkPnnWLTG@phenom.ffwll.local>
In-Reply-To: <ZjoNTw-TkPnnWLTG@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 8 May 2024 06:46:53 +0100
Message-ID: <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@redhat.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 7 May 2024 at 12:15, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, May 06, 2024 at 04:01:42PM +0200, Hans de Goede wrote:
> > On 5/6/24 3:38 PM, Daniel Vetter wrote:
> > I agree that bad applications are an issue, but not for the flathub / snaps
> > case. Flatpacks / snaps run sandboxed and don't have access to a full /dev
> > so those should not be able to open /dev/dma_heap/* independent of
> > the ACLs on /dev/dma_heap/*. The plan is for cameras using the
> > libcamera software ISP to always be accessed through pipewire and
> > the camera portal, so in this case pipewere is taking the place of
> > the compositor in your kms vs render node example.
>
> Yeah essentially if you clarify to "set the permissions such that pipewire
> can do allocations", then I think that makes sense. And is at the same
> level as e.g. drm kms giving compsitors (but _only_ compositors) special
> access rights.

That would have the unfortunate side effect of making sandboxed apps
less efficient on some platforms, since they wouldn't be able to do
direct scanout anymore ...

Cheers,
Daniel

