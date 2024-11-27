Return-Path: <linux-kernel+bounces-423007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3FD9DA126
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521F7B23BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8377F10;
	Wed, 27 Nov 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNTWuzW6"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9641DFFC;
	Wed, 27 Nov 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678336; cv=none; b=b/kCo+ByZ5pR8hhVJHlfMzWkbZZ6h9IVSZUddp3EuJn5ueJvFZbWfqSCrDrIsunjSKx23AhnJ50rOg+dZRu2mTBFRup2OTCKMB5q8v+lzL+3caGAFT7s5Stm3ZdhON2Qfhd4tNkdQPzR1YmGkWjC5OV3rQ3Qsq3d+PVvpDvgLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678336; c=relaxed/simple;
	bh=whLrwTDQh9Q1vAtIf5Ue5wkiYoi+msqtQm0tKNkrgkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHpP7EtSsvDvhw8FRg17zz+NK/c8EhgvuAizwrjU02FuDGy8v643uBDEU31GKmUV6ZhhwCmRKgrT0cQ7++psRPMXfFOGvyzOOyU9z5OXrtwjwJI1kcbxLbo18QWBX8oSUjYKgLjLPBkSpRu9DodRX/SZzTc3orcy5hj9MOiZ9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNTWuzW6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef0cee54daso29981137b3.3;
        Tue, 26 Nov 2024 19:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732678334; x=1733283134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whLrwTDQh9Q1vAtIf5Ue5wkiYoi+msqtQm0tKNkrgkc=;
        b=HNTWuzW6Or+122PhKS0i/D+jISBh+txZg7clmr7KePjoLchE/rRxkYGDmRdvbKetuH
         78qkO+BD6/fCjchVsRoQ8ArIgmVmNEDWau3Ch/Ef4BqsLsLyKklNAAXQbcehgIJKVjL8
         pVqUa5s/CTTu0mU2Dt7100tV8DWckfcQJlaOhckydQWEL9liI0e6MEIeDodJ2ESuTFu6
         3duPnEIaRB6Z2OUYWJZsgkPfoWEOvHeZDsjukKJNlBcQS4NzZcpR1qzldebaRHbBxYLN
         pqN0brqF6T7sSUGyNriOYJZMbftVvFC7emPBnDHcnoAYhy4gc0HaRtI7HXSvZMfs5KDS
         nUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678334; x=1733283134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whLrwTDQh9Q1vAtIf5Ue5wkiYoi+msqtQm0tKNkrgkc=;
        b=w1EkEVN0yHIlMTwveray5p+jJ6DT4hcbYso6cR8ZMk5uDIVnkIhxn+rVWQpNwnzNg/
         e21AMOlb9mKRSj8dV79c1nwXIMKjoY+iitbulA59fJTV7yGT62ADBbiCGsL0DcS2zquq
         6tgtCezZrdmkmwn6zTATMRMrY79Wf6nyuK/AhrHlRUkb8GNN7VjS8z8uJGinHWf/igce
         K38mBvrXZad7iVAlbt2zsRAtGNNQREoUfExt+0TMD7dcBBwijzjvXd+ZkGjeMg975xRx
         FngC0F4gppzlaSzMDufsmXWbWW0kAEpXL8nZC9A2PeQGp4FKjCAlqH4a5/4aO5/oaOdR
         awNw==
X-Forwarded-Encrypted: i=1; AJvYcCXh/6xS8ZxLLeGuYcpTa2azB8IbjLeamXoUgX3qLqI0hSIU30VAVkBOoVtokNwTjPE+Q8UyNk8WFJsS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nkpkiTQaagGiyX/s1yqSR9FxXGKvl1k6+BSutGDxOEBXRg7m
	D+OFLYTSmFtB82tR7xxUulxSS6JAZaNYHoTpRYu7wzNm/bS4EPBVGwx9ykTNncvVxM0/XzkNGZq
	t6rHcvJBWpfNC5/spo0PSmkslzdw=
X-Gm-Gg: ASbGncuxeKQXv47I2LtpN/bA5rnktxGgn0vNGBrUOq4P9qm4p89S5/YzckzJpSF7SN0
	yZqVXcLbksqqUfrabnOcp0P4sHrvyRyvo7fuP0GYxMzO2tVqppiTOimcHlRoYZwNu
X-Google-Smtp-Source: AGHT+IHJCdr9O45hf+S6imwyWvr7pTvHFpMglC2qsULtDAO0dw5VM3D7UbhCff2gplz1CWWQtUTkOpjnHRrkcXyhwow=
X-Received: by 2002:a05:690c:23c5:b0:6e3:b6c:d114 with SMTP id
 00721157ae682-6ef37281d02mr21558447b3.38.1732678334297; Tue, 26 Nov 2024
 19:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124080220.1657238-1-kikuchan98@gmail.com>
 <20241124080220.1657238-2-kikuchan98@gmail.com> <f0d983f7-5f60-4cb7-9522-ef4429359c52@kernel.org>
 <945786cc-1d6d-4a45-b9df-26d9335fd271@kernel.org> <CAG40kxH8bQHauBAd1B=UpC7LLAJoS=ETKczL=QWBKqvk=VKh_w@mail.gmail.com>
 <d1e8b3e9-526d-4910-8b15-6cce2c8526db@kernel.org>
In-Reply-To: <d1e8b3e9-526d-4910-8b15-6cce2c8526db@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Wed, 27 Nov 2024 12:32:03 +0900
Message-ID: <CAG40kxGZ=BKU4H5D=XhzTkMYMNqEsJuHMpaTh2awVd60jCjrMQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: panel: Add another panel for
 RG35XX Plus (Rev6)
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Christophe Branchereau <cbranchereau@gmail.com>, 
	Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Krzysztof,

Thank you for your reply.

> > The old schemas "leadtek,ltk035c5444t", "fascontek,fs035vg158", and
> > "anbernic,rg35xx-plus-panel" exist independently.
> So you duplicate them. I wrote: Don't duplicate.

Ok, thanks. I won't duplicate.

They are already duplicated in the tree with their own file names.
The panels I want to add are not directly relevant to them, so there
is no single file suitable for the panels.

Should I merge these files into a single file with a file name such as
`newvision,nv3052c.yaml`, taken from the driver name?

Best regards,
kikuchan

