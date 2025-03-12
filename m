Return-Path: <linux-kernel+bounces-557477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31937A5D9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B551C3AA27F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029323AE84;
	Wed, 12 Mar 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lEiKlRFD"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB815820C;
	Wed, 12 Mar 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772494; cv=none; b=ipYJpxcNvNE07OgDG1RmcmtSXhfCvJcA25A+4qYk3U11zQDrSokjuJNoTB3WMuXyhFx+a4WmDcVdSjM+I0hVJJ2pMFUuoA1x+8c4pBvVsDAr3xJJ3VavEwgqDMPFbGJ1XhyjWfYsRtbktZQpYuXULnTVjq8GxKh7XUItPtPD9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772494; c=relaxed/simple;
	bh=v24X+KcAmfOoIB9ximESyJf7aIFviUTVJprNV7qMLmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmkPMWx1RFeD1u4aXIkEqCoX4kE5osdFvypINqtjwwdzah9fY91Dl976wyYlO7B7Ec4va7oI/WA4bSTNnXJBHbEqV9M/pePGNIvVrpGeVmjfC5GG+u5g+e7YK7+uVtpny1t9MswuGC2kU9W2fqg4HAftqBFiVn0zk74xEV2fhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lEiKlRFD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F25A24314D;
	Wed, 12 Mar 2025 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741772490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYd5syVLmKdM205IPiqRZrSysfgoPICXjHhl29L/kEQ=;
	b=lEiKlRFDzkw8g2+H8Nm4fftbGYrCE92LfxOVzb+R7OkJzqCvjVFZZjpXcsztK6IU4JDrE9
	DkEE5uR7w3lYDAIKvk8gmTyfln9g1j6tJbvS+WiJPrWGzyOAHFmt2CSuAStT1t4o62w7L9
	Io0gsVJ28Iry2yl34jRLHc02pcLF7q03MSTu5RZ00+kcx0B96oYJa1hO8EDUoOKhH3B5dr
	lpRqGVkJ7anV4F90i1IuRD+srpYfh2SKF2l7GBL08zSJW+5UrL6NeumIGgaMcmBwFCjyct
	OtkCQadziDUVsTY1S7yCSzBSHBRT/ZHWSg5J1JXNW46KZl2Px1YQ7j16whkLbA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Antonin Godard <antonin.godard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
References: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
Subject: Re: [PATCH 0/2] Add POWERTIP PH128800T004-ZZA01 panel support
Message-Id: <174177248888.2707180.3560466107849632577.b4-ty@bootlin.com>
Date: Wed, 12 Mar 2025 10:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejheeiledvkeeigeeluddtleejvdfhleefleffffeitdetvdeltddttddtgfelteenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhim
 hhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com


On Tue, 11 Mar 2025 17:40:04 +0100, Antonin Godard wrote:
> The POWERTIP PH128800T004-ZZA01 panel is close to the POWERTIP
> PH128800T006-ZHC01, with different timings. Add a binding and a panel
> entry under panel-simple.c.
> 
> 

Applied, thanks!

[1/2] dt-bindings: display: simple: Add POWERTIP PH128800T004-ZZA01 panel
      commit: 36cb24049b911ed83d34441cd2e9adebfc999da8
[2/2] drm/panel: simple: Add POWERTIP PH128800T004-ZZA01 panel entry
      commit: 6374a1005f20c1c2f7bbcc1bc735c2be4910a685

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


