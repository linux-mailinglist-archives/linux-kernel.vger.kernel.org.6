Return-Path: <linux-kernel+bounces-429695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E780A9E2031
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3487D165CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D21F76B2;
	Tue,  3 Dec 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEszCSdy"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF01F758C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237681; cv=none; b=CYz/DNcgJRf9d1J4sOKxHlv3FCckXWg6RtV1xb3T57LnJBI7VnvLn2hCUb6Rj1XVSLVVOfKsZFV/s4E5L2+hTFRM8nFgIpq/WxgW0gBANoQmY3jnt/a4ClhMp9xRDKU+RgC6QvQ4o0At6n+Ulv+oDDF271thF0oT3GePsD8YpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237681; c=relaxed/simple;
	bh=1IAIN/8H5junEHBZ26iMTzfLpfhHD6gUNd1uIhVvdUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l5ZAyrkaERGiWT1e0MzQ9lTCHIXhp9KNAoEIME0xTK5b87vYQGa1pjPMFkowIFC1iQKR/406yarJkKw4X/qUKCSBS36QJHq0eQoAcbvunWzLiuJwvJSp3Pev83mZHeKkCAZHwAl1n/L6j91zp78I+BHXAUZMid9iGFOm5Wj3inE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WEszCSdy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e40aa2e6so206389f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733237678; x=1733842478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVQnKfNjMPfmMsvNdciOTib0L8uKRN+DbCQBwL/l93U=;
        b=WEszCSdyb/quMaY/xM90z0vbReOThk7ymw8H2b8CXqyZytrnoncXrTaS3iyO4tfJp5
         0oUmDVFKuNFpb0H02/3/Bx80fE2P4qXHZqSA+2Pngba7anNwWdV1W7kUHLKTMLv2eD8b
         07nOQLsosDRp/fJACnPmjMQlzXoNWXrkamo6n4p1c8LpMlu5LqA737bB0vCP5zHQMVDX
         G8BSLNa1HYfQWnFAcSI7SIClmMFOvcCBJ4UmyRBn/tHfek7LPaieaW80vCAu35YaTBrQ
         gu2UGUp/mJJp9g3qNcABz34cZDLTxF/Qf/xDIA2LAJNk31fdy8VB5qCOYm0DtYALvJkd
         21sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237678; x=1733842478;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVQnKfNjMPfmMsvNdciOTib0L8uKRN+DbCQBwL/l93U=;
        b=FibE6uTbTztqS7AOoqQ7iukvE0ZQ5e9mvm8jJ1za5mRPx1/NqKGYkcouVDzS1CftMJ
         pzdci3rse3Yb51qDbUutSo8+hGg/siE3OUDMZQdaJolfoslfvD5fwVgFih9G7WLftPjA
         qh46o07wHUT9CQceNFiS+KfjHekprHcGDZ93rXCgO5i4DSOgfmZplwjsq2z+NhY1rRxT
         pPcrVjLLBKNxMmde9PAUWRSi1jTAxtJ/bOywKkz13qSMwN7p4RMSbjRW9uIe39xarH0P
         iD96sSKJgfuTp1GpeaKXuolq3yEDJWkUEEvwdFQY9ltHsP9BukSRPoU3xTpr+M9+pRja
         O5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWjJDuMgHYykbh7SybnVjzkmyfqcYUHPztruYRpnx3s74vVSmIJQQv6JGNipUED7jkm3n4irC3390QOwD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tkxhK4TOVVqHRYAncugJ3OBYQ0tl3Dt8+vw0v/ZbqTOtwdIZ
	9VvhWxwZnYo00B6DB3s7JZUiTagxgk+4c6CbWdHsZyocVix1ga8gwVSwcmeLb3I=
X-Gm-Gg: ASbGncsfjw0zzYs6yzOrm0yWZtRFwH5ob31XoQjXsyN5Jr3LpxubpUzo7aKgE/rNYSh
	cv7bktCrcOxoA3kHyGRULgW9y6HHc0hN49/AF9Jw47USayDskggUO11w9MYdn+eipBuce+xN/67
	Yv9P6LVBg6S4FfTHLIjFqBzOZ0r6VhKcaVHVWR0XH5WeYkQM7Xb8uaWhsA40HlviMstwGxdft5q
	l/S5gQbPVCOQKLZYjadPljnNk7Bus731hKgDGREhNXKvjBBznGGKKyhzymu2ug3
X-Google-Smtp-Source: AGHT+IHjNqIwgyhBQxftpcXHAw9igzv0feJ/dyVPh3zNKBEM6I1JcxxoasxFhTbuCSeSbCfEViDLAQ==
X-Received: by 2002:a5d:5988:0:b0:385:e374:bd4 with SMTP id ffacd0b85a97d-385fd3c76c5mr949206f8f.3.1733237677714;
        Tue, 03 Dec 2024 06:54:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4df1sm223440855e9.39.2024.12.03.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:54:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
References: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for attaching a regulator to w1:
 ds2482
Message-Id: <173323767575.74728.10700048422477290412.b4-ty@linaro.org>
Date: Tue, 03 Dec 2024 15:54:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Fri, 29 Nov 2024 14:25:52 +0100, Kryštof Černý wrote:
> Kept the exit_w1_remove path as requested in the review.
> 
> 

Applied, thanks!

[1/4] dt-bindings: w1: ds2482: Add vcc-supply property
      https://git.kernel.org/krzk/linux-w1/c/be197d90def4282af7d1f7f1210ee1f9342a67d1
[2/4] w1: ds2482: switch to devm_kzalloc() from kzalloc()
      https://git.kernel.org/krzk/linux-w1/c/19c6d8bd88652936c43f5c53550d74563829a15e
[3/4] w1: ds2482: Add regulator support
      https://git.kernel.org/krzk/linux-w1/c/6e0bb206c6af6c8775b447b2fae9209f02f13143
[4/4] w1: ds2482: Fix datasheet URL
      https://git.kernel.org/krzk/linux-w1/c/5f69c091a6c0001ffade8bc00c1d33e1e224a2e7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


