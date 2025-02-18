Return-Path: <linux-kernel+bounces-519461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE7A39D29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDBD1778D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4D265CDB;
	Tue, 18 Feb 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpQ+inxR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1E2451EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884181; cv=none; b=ewZNIZpVWAN96tZkcxbvEIFaKy+EunQFuC3XSH1j57edWnLCEH42DDaZiKfgwiMncVFLLLm8jlxj8nK5yMJVYcni62tqbImmtpAV7nuZ3Owzoo9elLakzkCJkjaxIhzjNzPd2aiqGGvfwqdYG8sGrQ+bwmIBdVaXehWASYE8Y6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884181; c=relaxed/simple;
	bh=z0j4Vm144VHYx11zlR4uyhxpBXBQoMAr0tKnHXqln9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsgsPhV4XSFGuQw3jGvXfAJyLq5e8jPZvYP2W9f/4wkdzHFj1+YKXW7LAiAjWK3rsAzqzw0WOy2q0Z7oMEvnP2M5ayD3pW2U041uwMknAE9sl3UN4zKQjyZVjhpR6aQHSpF6R3O/C2xuYyibyc8hL7+JS1u4WQ5++6ENZ5+dEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpQ+inxR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739884178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0j4Vm144VHYx11zlR4uyhxpBXBQoMAr0tKnHXqln9Q=;
	b=DpQ+inxRDCBXZBmIYDxfpIpfcI0wARxbqPwfRURlUj4m/XAVME3VedoIgI8jCUJrLzBZ9S
	u0dV5tCGTl7OchTku5MBfpcpBdMpSCEV0e5Ua9w2zuIDVBC3oCNf7P3DR9IDN1ztxqYxeT
	LFSDX+8CGYAJlK1wuH4FnSysAqQ+vtU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-pfIBvMEWMnyK67nmGJ2A4w-1; Tue, 18 Feb 2025 08:09:37 -0500
X-MC-Unique: pfIBvMEWMnyK67nmGJ2A4w-1
X-Mimecast-MFC-AGG-ID: pfIBvMEWMnyK67nmGJ2A4w_1739884176
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439858c5911so10452005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884176; x=1740488976;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0j4Vm144VHYx11zlR4uyhxpBXBQoMAr0tKnHXqln9Q=;
        b=eWb+YqgNdT+MK5DNYnM2J/Ep1d86ZxYKXzEy/FZTfCkdED9wTaQDPkXbwbgmJIGPzx
         G1FMLlRG0cReo0VPlxaY98ucSPnmbPTQ8WeMdM6WiarliW6lmMOkwEpTkqzheH3c/oqN
         uv2YGWYZO/J9/O6gfQSFgoTq/q8etA6PQJiD39qf3EnhPNJcTKOxhnEzpVcrH04DyhVK
         tS7Hwd2tn5FfjnTdz7FflI3Agycs/qx8flNDqzyqw4CAk1TtPMXVXX87W9WvF/sYcYUH
         tgTvaNVFneiZ4j5/vSioqvxZF9cRve+zZMLAwsfhx3+soO4mXnnvyk4IpXj3R4HTpbWD
         ciAg==
X-Forwarded-Encrypted: i=1; AJvYcCXvR3UxlS1jxqVhRzl9rY+vXSGCOOWIyy7v+fst8PO04AZUwlViJNm9ikFNHL6GalD8E6GIYLQw+VA4tjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cC725T4rtER3wATMhXn4zGYeRW9a8EP/FE4o4ZBjisgoHybr
	cklhF27tWYYTB8pwRDZ0eZMEWBdeq8+NXqGPwwp297UYgYL4XMSeq4Ceauzr4WC1Resw0DC0E0b
	MEoG31+pSQfDEsS66tZkTJsf0agPa1V/pgvj6JRjTvXlQC56UpRji60KhxcimFw==
X-Gm-Gg: ASbGncsDtfCnKPClii626O/GO91OvvCdv1oVSVar/pkVmlmuAF7bUF8Izr7KEL33FCt
	IJisGmAU3P5R5x+ONpOdokcNYSh4AAJGp2OclYes6Z5I9Gum13yOBqUV6BhHQglliHT52iFlkaD
	lu6dZHSPmJIidruf6ysG4g9igkEbjl694+KhA0Ny1ZUWo3Z28zg8GlOYibnrCxC9Vb1TdM8JyQu
	0d1PaCGOpKfCMkfxYVq7DPsG95tZIcrk+8yg/5u5ZRwtuPYEolmdL2tCBqvifpGiA967igttBzG
	6A7oIfXB6TDeeAueDXU/I1mWQm2g67neHNZAGREFmVcQ7hjzy7lQd1bU75k3A8s=
X-Received: by 2002:a05:600c:4511:b0:439:88bb:d006 with SMTP id 5b1f17b1804b1-43988bbd499mr60329665e9.6.1739884175784;
        Tue, 18 Feb 2025 05:09:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0DOpj43RZFNp+JX/ZShx8BlmwPqpc6v5z2QLXz9M5znTKLEaWABk7Mv2M22qyQ8wS4NqHSA==
X-Received: by 2002:a05:600c:4511:b0:439:88bb:d006 with SMTP id 5b1f17b1804b1-43988bbd499mr60329315e9.6.1739884175398;
        Tue, 18 Feb 2025 05:09:35 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8443sm182296005e9.35.2025.02.18.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:09:34 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
In-Reply-To: <CAPVz0n0WG1Q51SONb4fmkzi4q7Q0sZ_aKSLrLnGboNNya6nO+Q@mail.gmail.com>
References: <20250217140910.108175-1-clamor95@gmail.com>
 <c19bd9b3-86c4-4f1a-beb9-b6aed32b3ef5@suse.de>
 <CAPVz0n0WG1Q51SONb4fmkzi4q7Q0sZ_aKSLrLnGboNNya6nO+Q@mail.gmail.com>
Date: Tue, 18 Feb 2025 14:09:33 +0100
Message-ID: <871pvvqu0i.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Svyatoslav Ryhel <clamor95@gmail.com> writes:

> =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:36 Th=
omas Zimmermann <tzimmermann@suse.de> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> (cc'ing Javier)
>>
>> Hi
>>
>> Am 17.02.25 um 15:09 schrieb Svyatoslav Ryhel:
>> > Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
>> > and LG Optimus Vu P895
>>
>> There's a driver for Solomon 13xx displays in drm/solomon. Did you check
>> that this new driver isn't just an extension of the existing code?
>>
>
> Definitely no, ssd2825 is a RGB to DSI bridge in a pure form. While
> 13xx as you have said are display controllers family.
>

Exactly. Both chips are from the same vendor (Solomon Systech [0]) and my
guess is that the SSD prefix means "Solomon Systech Device" or something
like that.

[0]: https://www.solomon-systech.com

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


