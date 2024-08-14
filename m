Return-Path: <linux-kernel+bounces-286165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47795176A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05185283F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE92143C49;
	Wed, 14 Aug 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="f70sE7HF"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB914389F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626653; cv=none; b=WLj5TJ4BZka+ilrTm9tIMQ39QeiERUsDFSXn+R9YUuTSBPdEtwT5zLfyLPjF769fsL/GIlmkeVw4/TwsDtoQxnQ7XEj6gGBm09G9YrekrSHOhisuTj4t+JJ7vAP47PlFWLnJOaRAfwI4weSfTSVt+pb0Y0OOf0RtzXTltfD3jT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626653; c=relaxed/simple;
	bh=cRtRFKh6kx8KRbGN2vfzoGzSUvlylW9pm3+5B2YJY/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV+IhMniwr0pMjpf5ChD6uwOvahvTw7f7D8oqaiRF1r/pL8Dmbm5iwLZ87SurkuNVhSnTGfhg3++0b0NmZ85ZVaITvUp+5HI817vE0Wx4Fj36ouJQhKS/DuywqmxY1TVfjJasw24PCLSpDVjIkidIHd+jHDM6LuN3RQOjStM0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=f70sE7HF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so35261936d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1723626650; x=1724231450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPEvb9R+nivtOxDWaQTXsJOKPes6soPv2NUR48zGQ0E=;
        b=f70sE7HFLh65L+Ok+C6cXy7C9OD3VEfXbJjxVVneLEEVTTy7IZRxmph45HlxrTHClu
         uDHKr9rT7K7Knl0m0E4U3yfVKSh8KF6IN+QIKjKI0pfT1OBOH6vNVUyheP8aTW0ICPQI
         hsR4lUleNGuxAb7frK4quyau77cmg4KwVcxYioUM4aa2Gn1J4LuSKtDCXZI/21x93FKk
         Dcguvw657BwnwokNkp08HbzHQHagQJrtG8rkqmhUxdABDKGZNFHqKXT7w0G8eF9KsCdM
         OXl5weF50zXbqex3beF99tKDGVNF8YxWU/7PFN+qtPYWPDLmZUYoCryJUUcKdn2XeVNa
         Cpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626650; x=1724231450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPEvb9R+nivtOxDWaQTXsJOKPes6soPv2NUR48zGQ0E=;
        b=kCK/CuI70An8wmuGH+dt1OTHw+HlSwruN0GPahV6+EjYWjKEOHVUzCRDZvkVdtcNWW
         OF3xq5Dtuy6crxb0Hf2ro270fmqiJtYfcMcbWfjVJYTFLASUqJrl4Qr8UO6zUE9iglUR
         e2nDrNiOzeuRfDrdRc6cO8j5NI8rXqebpt2qM+eiOfyASRh4wpr3MHJ7W4DxkacVAzyU
         3qtKJNyIgDSoQl0BzBPX+efjK0Td6deQRW3LQvMOvhF8+m8X9shhlsp+MNU3jcgDuOoU
         i9wceQ1HJCLK/10wK6GuXt+Tu69/wIPEwMYcneENLj2ua8o9y7xdkzaeFLifiIT3aMr5
         t54w==
X-Forwarded-Encrypted: i=1; AJvYcCXPNHV3+LAESimWsR2ugX6a1lRNNAFsptPFZZvnaZB33aqlpYd6ixYc+LmYVzCF7xum44BRSmyeZk2QOV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MqlP7poQLNj1D+ThUyR7ytks8ptSyDB9rjY+/4Y61BfY65y8
	4NldysRG0HNeUm7sAizOiGoYBVJLWcJygFEZowqNX6NVlo6Injjvdo5tTDtMtuT++ADDXNxzfkd
	vS+QaIMvKZ81/VVsMix3ria6r+K41aMwVBh2q1A==
X-Google-Smtp-Source: AGHT+IGeSqKGmFAJUAm7WniNvG9r9PhmhFUNqTMunvROKAZzH3KtLQs8l8fONQIsnzIZGRCqU8+/ty8xiYc4yDX20TQ=
X-Received: by 2002:a05:6214:3197:b0:6b7:9b2c:98d3 with SMTP id
 6a1803df08f44-6bf5d1be47fmr18702656d6.26.1723626650637; Wed, 14 Aug 2024
 02:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 14 Aug 2024 10:10:39 +0100
Message-ID: <CAPj87rP0HZzdVoH18O6gVe1n8cHjhNn2LFSAAVvqj5m6tN2y_w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] VKMS: Add configfs support
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, 
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, louis.chauvet@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jos=C3=A9,

On Tue, 13 Aug 2024 at 11:51, Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmai=
l.com> wrote:
>  - When a CRTC is added and removed before device creation, there
>    is a vblank warning.
>    The issue is caused because vblanks are referenced using the
>    CRTC index but, because one of the CRTCs is removed, the
>    indices are not consecutives and drm_crtc_vblank_crtc() tries to
>    access and invalid index
>    I'm not sure if CRTC's indices *must* start at 0 and be
>    consecutives or if this is a bug in the drm_crtc_vblank_crtc()
>    implementation.

CRTCs and planes are not hotpluggable. I recommend you just create a
lot of each of them statically at startup, and hotplug only
connectors.

Cheers,
Daniel

