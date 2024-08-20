Return-Path: <linux-kernel+bounces-294303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E9958BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B69283D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79619DFAC;
	Tue, 20 Aug 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy5ohlDz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD35197512
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169831; cv=none; b=UMu4549W4f8r+WCS0ONIwKzfEiC5R7xc4SiR3EeSMrExC9mGHnKzREg7GKmbH5k4SZCAUYuS3EFZUvBooM02Wv0hD88M9C+6X64u3boP7Q4x2V+DFYnqTq6tfJkVFw331yJt1puQXjWoUzNLtXJqRivya78ha6tdRsg4E0g1DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169831; c=relaxed/simple;
	bh=3R/sbCCTx+Tx2nNxzbNIMyhmtfFyiyLEecqNKBht//c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THM/ts8QXfWaIUmGi2VlMg8ngKx+8f6MmZv7nOmjtZyK59igH2i58+DkNLgEaJ8xMX5loPa3BWk7BcZ/HEwu14CtZM7oHlWcPay5HkwJLIk/ZIX6qFicfH24zzEbvnKLFYG/NIwd8lK0Y8yaBJiYuZacZeQ57zOvum2RMuMILd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy5ohlDz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso2978548e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169827; x=1724774627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EelLEAshHFEbe/ENFdi4xWbWs41G/vbuSzZK/f4xSrE=;
        b=Wy5ohlDzU2hFZZXvfqwfZZoMnZw6VZW7vbUQriY6yQ+os6rj2hxLSJQBpKm304Hitu
         IghQkMKrCDn4usQii7G6U60CVKnZKbyfpq8WpJVWeZhXwa+g6+KOhKTTRxZ90ceentWV
         Wu8MtW026KGRVBcSsUB4fsG7+MfcNsEjWpVm6VId1NLz1o2eUdwgwTpLeibdvA7ZisOH
         RTmgiSpy18eOgkjoeVrfbMz1mkh1UBOJmVyCBDevkNvzL7++4JBjEkImGI3cAINR0Uy5
         ciPgwX4KKNdAuz1VTceCaJSTjKytlrbt+0Jqr84HmY8EGfvll/5+8Cvgd/qrkw44FrBU
         RVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169827; x=1724774627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EelLEAshHFEbe/ENFdi4xWbWs41G/vbuSzZK/f4xSrE=;
        b=cGqDBEPcwqb6EbQTj9xWK+eI/C+Y1HpFWCI4OGAZxPAH17+/ZSJ+eE7ywqO5WmswvR
         jIGzVCk+wodzK4oWNfOaruq0rQhJEzpOGqCzG6SNVT0rgcuWYs4YKpvs6xM7JiEl+FR3
         yY+XYQLnwDadp/T0WLQS9Q4Gw73gtGGZcv58ungR/0ePiguFMcCbufw5VDoWsh2OMIUo
         +xN49lvRHZEnUYb/oZe7NkbpVSrNpg9imXokiMjpPtQMxyQVoDEMHpSFxO/uwejcpd4+
         fF4Ud+UvpxeF3CfG3td1HK8JV/foMnIROOE1YG6rStUZ4dKcgwbfBi+dorR9sTWCfOuM
         vDJg==
X-Forwarded-Encrypted: i=1; AJvYcCXX0vdyz4u2clnCGu4qg3zmJG5Oiz9t4dIWm8H9IkiCz4YuQnkF29AwWDgy6MhmwEBfBHF/D2PJ5XDGMeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtlWORPeibZYCQ8nO8DI0M6LVNaVxakTOdOdnUG1LBHHccmni
	XhAH/v5p4hUY13U9ti6Kxnjse7/rLLtpvUlGdmxxw5dY2vCn60M8
X-Google-Smtp-Source: AGHT+IH0VkhNqgO4I1oP7RJepzs4REpjlCOgLICe9cxVNyNkQp9rp0USBqmqhAbCuyYTI8ztrYEigQ==
X-Received: by 2002:a05:6512:e84:b0:530:b7ef:9f6a with SMTP id 2adb3069b0e04-5331c6b450fmr8529783e87.36.1724169826818;
        Tue, 20 Aug 2024 09:03:46 -0700 (PDT)
Received: from fedora ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded720eesm200311985e9.33.2024.08.20.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:03:45 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:03:43 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com
Subject: Re: [RFC PATCH 00/17] VKMS: Add configfs support
Message-ID: <ZsS-X_ANCKfqHtAY@fedora>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
 <CAPj87rP0HZzdVoH18O6gVe1n8cHjhNn2LFSAAVvqj5m6tN2y_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rP0HZzdVoH18O6gVe1n8cHjhNn2LFSAAVvqj5m6tN2y_w@mail.gmail.com>

Hi Daniel,

Thanks a lot for looking into this.
On Wed, Aug 14, 2024 at 10:10:39AM +0100, Daniel Stone wrote:
> Hi José,
> 
> On Tue, 13 Aug 2024 at 11:51, José Expósito <jose.exposito89@gmail.com> wrote:
> >  - When a CRTC is added and removed before device creation, there
> >    is a vblank warning.
> >    The issue is caused because vblanks are referenced using the
> >    CRTC index but, because one of the CRTCs is removed, the
> >    indices are not consecutives and drm_crtc_vblank_crtc() tries to
> >    access and invalid index
> >    I'm not sure if CRTC's indices *must* start at 0 and be
> >    consecutives or if this is a bug in the drm_crtc_vblank_crtc()
> >    implementation.
> 
> CRTCs and planes are not hotpluggable. I recommend you just create a
> lot of each of them statically at startup, and hotplug only
> connectors.

Yes, it is an issue creating them before the device is active. Once the VKMS
device is active, it is not possible to delete them.

Because of how the CRTC index is handled, it is possible create 3 CRTCs
(indices 0, 1 and 2), delete the second one and end up with 2 CRTCs: The
first one with index 0 and the second one with index 2.

This is handled nicelly in the possible_crtcs bitmask, but drm_crtc_vblank_crtc()
tries to access index 2 of an array of size 2.

This case is not possible with actual HW, so I need to fix it on the VKMS
side and make indices start at 0 and be consecutive.
A check on the drm_crtc_vblank_crtc() side won't hurt us though.

For extra context, see Louis message on the topic. It looks like
we are having similar issues:
https://lore.kernel.org/dri-devel/ZsS7x2y_HKgqGUFR@fedora/T/#mccf9a9748ae67a07a7e6ad694c42afc2ccd3c7f1

Best wishes,
Jose
 
> Cheers,
> Daniel

