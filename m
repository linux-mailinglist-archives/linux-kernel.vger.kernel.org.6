Return-Path: <linux-kernel+bounces-418761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9C9D6561
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B4C16148C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0290185935;
	Fri, 22 Nov 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fdw0eoSX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1654F95
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732310895; cv=none; b=Fmd4XOhof6i9OiI2OP+ITzB6i7a5eHyp0gDE3wnpz4iTfaeUBbJ8rYF3ttEFJD+WEVCH0y7zp/MOg/a9X3Fgb15uWv2zVSXiFGeuTmZ1s40zAVzxMBDq4knoGOonBlswYmaONM+VR1KJA3jKztiCFqcSNVdC10pko9V1jf3gb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732310895; c=relaxed/simple;
	bh=Inu1YrDiEoZiawEHsCIJ2vIR2WeRDwuWrAFeiKfr+Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZmMEQaxwOf8/9+aXed6iUvqw1QhqDGFJYKKXHXvbOYHYgkMi3hw/0AgKDzGeLuMxy5Uf/jQMPEmhrjigQQVxhg41UYCJpTEp78E8QvLO75UT6aLZTsfeK1e5q0hQhd/n3SjOgtcQ5Jz0O/9EV3Wfq0gNEw/FEeEeHxT1iCQu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fdw0eoSX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3824709ee03so1860910f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732310892; x=1732915692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Inu1YrDiEoZiawEHsCIJ2vIR2WeRDwuWrAFeiKfr+Ko=;
        b=fdw0eoSXmx+XjY0BUqpVz8HQUTdx/j2P/2mAyfre+Tdy5mV6GQEAaY2KS6Z3D46YAr
         Z/WtAdFpSga3IHId16k0HYjm8J0ouuLCWEDJOS6ORQVRmuE07J6QLYHDyA5BSqKPU5ok
         fKp/z964bh3rQIM4EDLso6Yed/IyCqYNRnp5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732310892; x=1732915692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Inu1YrDiEoZiawEHsCIJ2vIR2WeRDwuWrAFeiKfr+Ko=;
        b=oskiwQWYLPNs6yxBshhqGxoJOq48FAMYtVO36fdlQlwoV0T2Y9GyaJluHf6M78fJW1
         kXI8ckaOFbYW0DQ8F18Ck86KBhZPfFhhXoJZhLM3EJQcFnN33BOHJCSYjRq6iGgK9RKq
         kIpP4cg/iMh+8BNr4qRasTYOj8RBv0y82HzkOMiF7qzbtEiZrJeXaioH9uGM6lNSf0aS
         nrYKMlEB9oQcZeoGr02Oaa8iKhX074k+M4v1t4AmE4MwooqWI6EUOECCutga0V8WDiBs
         JnN3YSDngnbkYdcgN7y4auiM+DUisBOUIj41FV63PJjwT9JCkdeGJP+Rqg7gvatfCDqt
         idjA==
X-Forwarded-Encrypted: i=1; AJvYcCW/k/NTrtuoBl+YWffTlpCqpBwJ0WBBwL2RtOaEMw7XwY7JUmYol8purV+4v6LY+R5nRLpkPzjhE1/L1TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwheKBT14L8YjxQ/65sN07R3WDJCK9z2l2TeEKyVg8RqqPznI5f
	P1UT3anUcQ0cU7jGGktku1Tv+q1OmgA7skfv6oWOXcqfTelVj696MZvVW3kNjkl2KSsaBI1Nha8
	UbPJuMnJPsbAo4Bm8yqyCoRJa9Q3iWidHnogC
X-Gm-Gg: ASbGnctP5NqtWaKGPqMcQhMQzDh5Bsl/2cX0F3K0JU1nBQ3MUPUzwolM2BVlJObb/4i
	2ZLsc0EltRK85cARvDHcOzuz5baJIegGY
X-Google-Smtp-Source: AGHT+IGtMNuDYJLYRRIB6wP42xa6e1P3TgJSXUrfsr4yViA8LmGx95MOGbzji6uGfd8CrYJJGpyvLfDnTzZUTlzDhVA=
X-Received: by 2002:a5d:5f55:0:b0:382:4b80:abdd with SMTP id
 ffacd0b85a97d-38260b73d1fmr3787505f8f.21.1732310891686; Fri, 22 Nov 2024
 13:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
 <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com>
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Fri, 22 Nov 2024 15:28:00 -0600
Message-ID: <CAO6MGtiYbPZvL=2ycHb50ATaikUg+mR8xRcxGLyme7FcCTkDpg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 17/18] drm/vkms: Introduce config for connector EDID
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Melissa Wen <melissa.srw@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

I didn't see a `drm_connector_attach_edid_property` call in this
series. Did you forget this? Virtual connectors don't have this
property by default.

Ian,

