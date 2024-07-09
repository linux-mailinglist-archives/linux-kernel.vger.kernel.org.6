Return-Path: <linux-kernel+bounces-246174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D297292BE85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2AEB24DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448F19CCF2;
	Tue,  9 Jul 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbHcwx4V"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822C187541
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539288; cv=none; b=g9lsQXSRcny2YHd1HdGtDXRdpsx/FIQudAGnDgvafRFjl58S7KS0Gt6DPdyhsAn92kbD0fFQ9I28FcC5Jsd8iIYlkLbuTUgkTDq7MDsjqJnqhIeqmX+orFNGVRpECCjNx+vFcuyE45tvjYSrJskM5uVlHYOiL9MTfhu9mXq7IZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539288; c=relaxed/simple;
	bh=uikJw7B41RIyBUZg630yZuK3LejUMEJ0vAM2TaW4pZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dyRNr4qP9Ug3jXH2IDr5wPQv0mQqhqVbuc+IstZSp2yQz0poZMwW9ct7cRZ2a3XSPaE0bDnmZaR1TWRLBr9CvivDd+oBdwrPEe24Z/cMlHaNW4UKEdkuWbNdqYkrsYOa+kvWaHoVWC6WYkBe0ux+P/EBRIkP3oOrPEu+59yLU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbHcwx4V; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso3477203e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539285; x=1721144085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yG/ZDYim4z9LC6qifUBZG0/p5bmD5z8CTGL0U90n4A=;
        b=FbHcwx4VsRovqbUC2hnN0t7ADLLp8eWAdazZobDhkUHi2JkH+lc8R5NDnEOmgB0xTf
         YSLcz5rDoCPb311zaRJntA96RLcgX3nylWQYg/7cZ6ld62ro7/Gud9HRr4l9VHcTtNXg
         7/Wb/iiD5bPLexsKKDbNZW63MKw7QlXSBWuyjROS1WdznjlBc3wFuSx7TEB//s7wzgDz
         KRXUL1EP4v0NoK07wKt2Hz4kzMc1ldrKv1+QOP8Lsa2CnTLuoeObb9X0exUXd1JEY8r1
         OWDLsBfx3gKUJqglpI7GizHej/u/oeJ5fbTUgp9ZG6PdSBY1bHF4VWFHMWedN91LJojj
         oOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539285; x=1721144085;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yG/ZDYim4z9LC6qifUBZG0/p5bmD5z8CTGL0U90n4A=;
        b=nkJKH8l8Bjce5AonsmF0mAuXzyv5f+KmrN0TLGpkapiBFI+AohsaHNd2GCeR6igtKp
         1X4W55+JjKWZqSkScYkeqdon+ruTKiWvkSuQxXVt8s4Z8BEyGxjrOYgo5JM7kbx3zKf8
         /kXUjIYQheX4WkQXVqz6j8GHjPsEZKGBuxL07ItSJBodPiWzal+hwLhNlHGHMCGYrfIh
         P62ouRFXenvQv1bn4E2y7hs4G2bm+bb7L9QxUtYmYRIOhbpDyl1HyDANdYWPTuAZyIQ1
         nSB/nOTcT0CnyYbvlBKRd7UNIpm236p+rcJ5wsAk4DaHRpxeWwd7AI0jrDQYXyYmU02t
         BzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Uhhn2MTHDmyWEzePGXYmohUIE/M89Hknz4OWtP9zI76wzAo40tb8attREu5GtX6+oHpvQNqDEu24oBFWv6ptA4aipq2BSDNJ9N8S
X-Gm-Message-State: AOJu0Yw41sjuBNMNgKBhoJ23EolgkBSKBoNaj6mTu4AY+IPNHKY3cx9I
	1vUA6ugwO+1lvu9xbC/Y4sdQ13dxOyz26XdMd21nxs7quHH3AcEr8SkKRv+pNg0gyOIkqL6YJnx
	DlaU=
X-Google-Smtp-Source: AGHT+IGM3pUx5C/Cg6m7uBP+vTz1fPg9IUGzC77G9bSZyWmRGAOxTkESVD8m4RIjQ+Lwn/adRidfWA==
X-Received: by 2002:a19:6b19:0:b0:52e:9f43:c13f with SMTP id 2adb3069b0e04-52eb9990cecmr1756059e87.7.1720539285216;
        Tue, 09 Jul 2024 08:34:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f1182sm44663495e9.14.2024.07.09.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:34:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Jourdan <mjourdan@baylibre.com>, Yao Zi <ziyao@disroot.org>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703155826.10385-2-ziyao@disroot.org>
References: <20240703155826.10385-2-ziyao@disroot.org>
Subject: Re: [PATCH] drm/meson: fix canvas release in bind function
Message-Id: <172053928435.1226690.16610517501511162578.b4-ty@linaro.org>
Date: Tue, 09 Jul 2024 17:34:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Wed, 03 Jul 2024 15:58:27 +0000, Yao Zi wrote:
> Allocated canvases may not be released on the error exit path of
> meson_drv_bind_master(), leading to resource leaking. Rewrite exit path
> to release canvases on error.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/meson: fix canvas release in bind function
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a695949b2e9bb6b6700a764c704731a306c4bebf

-- 
Neil


