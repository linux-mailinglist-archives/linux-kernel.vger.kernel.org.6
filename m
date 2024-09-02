Return-Path: <linux-kernel+bounces-310451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15B967D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18C8281D93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194D0179AA;
	Mon,  2 Sep 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw79jg3D"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072934A0F;
	Mon,  2 Sep 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239424; cv=none; b=KNFO8dM1TFcFcM+JcVgFR8hcCRnE0CGC/zdtuYgGDCt2ahPkq9WFZSM+IQrqPocJffiKbqFtwDVkFdAobk6p7xIoWMeLhapBPuKHS9j56S7CUWAVAsdaSjpjf9d9Df1kmUd9D6T8xJ8DEkTfofJQZXg2tVNFvG4msqx6wClYZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239424; c=relaxed/simple;
	bh=E4gzV92PxZE+qFNA+RekwmEuIebSetmvmkFXMiYp3PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErlsuV59133d3Su9FmLT+YNQhHRQ0f7Y+vcdamzdDa+Wexd3R08uboDRioYTYQeRkrEs7e+pqjg4jp6bCwfnwqUobZk1q7BUBnXkq701ocuNd9FtTAhAfeH71OddQojihkuTdMo93DWxAOzxvjvFlhs1sMus7NlV6hQUgNiMt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw79jg3D; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39f539a83e0so3899245ab.2;
        Sun, 01 Sep 2024 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725239422; x=1725844222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4gzV92PxZE+qFNA+RekwmEuIebSetmvmkFXMiYp3PY=;
        b=Cw79jg3DiUssKVxFQSzY/3SyS/2b5SSwQEhF/VMzGUjD9pqtTkvaFGWezdHhAcNXxm
         vKuyKgtW66Xdr5/b0geYlAU5CdgvqNFz+dE5Uuc8rA98h5vCrf4dA9/R4dJ4Do4hcdGV
         FLR+qkKITbyy9VqecasQdG5nAOUYoiHX6Bauila9QPEHYjGJhzXP08YGKwZIkxWELN8U
         f5B70t6ABYH5Kf55vllohXcyZUF5D6/fZIq/IYq6FyPedBAOuxM0cESKbYff7dKzrdYA
         +qxhJ1xkN4zYuusrzJ6fjE9sGqQoKprpXJBpszEEIBZywGTaW6djo7ZND6wUuwTn8G3h
         yTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725239422; x=1725844222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4gzV92PxZE+qFNA+RekwmEuIebSetmvmkFXMiYp3PY=;
        b=r8lQi9Dc1Vq7HbMaHlvTfxzQznTnKRuWRkVzseA92LLlGoHwFq9BB9Qywg3JbcX9S6
         UGBHTnNA2VNAUPfO7nauA/PYmN/feAWf2Kw/KGgwVBe8HlK7QnnF4hM3U9LWA4B7rupk
         WHcCUPqkr1fQt5mRn+UII9JlrrYfCoJa9JVWtHnwtZBTCytHIoCFv4iCqFiQQXTOhr/E
         qOWZCWa8s9KycFnmOQumyivPRxzXT+caA1pEnlDUjDv9wMhXjfaW+my8b6Kw1q5Zpo27
         nnD5YHz76B3jHZpht36yhf1EzW2lF063A68xm3/HO8oXS8yMsFJTNw0oF9GbKVqgn4jH
         rk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUYq2pry3Gbu2sGNtCy//qrXNv4AyZdNtSVjMgRlDafYwsnUwYD/qQd9M31osbik8/R4GIFltJc38Bynu8/@vger.kernel.org, AJvYcCVYVk1O8rXSUQ7Vm9OQN6qmd4S6WqyUUNJkQE/LHht1CKjt0OEQlcyeP0vkKoPjS77ae7buvyBdGec6@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXFIvdh+P3xvZ/cScoyYjFY6jVtriHEadIrw19Ev/nRplVClp
	zzRPtJ/cU/PX4rWrq+rqExaT/gT+n34e3U4J8PJHfx9t+0pmaaZC
X-Google-Smtp-Source: AGHT+IFyhMM0xDEm3decKqdzpa8ZS+bTABQJ0zYWbmUuOdCfCFThXfgY07/epTd0Cp/ktdQ+h6vMgg==
X-Received: by 2002:a05:6e02:194d:b0:397:6dfc:993a with SMTP id e9e14a558f8ab-39f4e11924fmr65501285ab.21.1725239421925;
        Sun, 01 Sep 2024 18:10:21 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f552cd162sm9103755ab.17.2024.09.01.18.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 18:10:21 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: cristian.ciocaltea@collabora.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: Re: Re: [PATCH v5 3/4] dt-bindings: display: rockchip: Add schema for RK3588 HDMI TX Controller
Date: Sun,  1 Sep 2024 20:09:48 -0500
Message-ID: <20240902010948.3654-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5ea24ad3-7faa-4a59-ba10-d43b32b3b40e@collabora.com>
References: <5ea24ad3-7faa-4a59-ba10-d43b32b3b40e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cristian Ciocaltea wrote:
> On 8/31/24 9:13 AM, Krzysztof Kozlowski wrote:
> >
> > Please define all clocks.
>
> The other clocks are defined in the common binding, should we reiterate
> them?

I would suggest yes, they should be reduplicated, if only to maintain
consistency with all the other docs. A grep through the bridge docs
shows that there are virtually none which use a "{}" placeholder like
this. While it seems kind of like one might worry about "don't
repeat yourself" syndrome, keep in mind this is not code, but human-
used documentation. Having all the information available at a glance
would seem to be the most convenient to the end (developer) user, so
they aren't having to toggle between two separate files. Of course
there may be some questions regarding docs becoming out of sync, but
*ideally* we don't want to break backward compatibility with device
trees (esp. given how I am imagining firmware integration to work on
these platforms, as the RK3588 is at at least low-end desktop-grade
performance and UEFI packages have already been built for it), though
of course that doesn't mean adding new options is off the table.

(FWIW, this is what I did in my now-withdrawn-at-your-request
re-submission; I reduplicated the bindings as it seemed that's what
others here were pushing for and thus that felt like the quickest way
to get this important driver approved.)

- Shimrra Shai

