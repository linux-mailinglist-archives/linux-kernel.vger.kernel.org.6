Return-Path: <linux-kernel+bounces-374383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F89A695D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3452D1C2270F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473851F8F02;
	Mon, 21 Oct 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlLGUBp5"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860851F5854
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515550; cv=none; b=eFAgeaYpcdyWWN2rHfMgDHKCmbC1Kns66eNvrHyxfHxmVV19aD3HUb0UMrlBuD7IbZ7r5DpZkmObdBNYasSWwqI+1wNfBraQhc/yz1N5zmRhqlj3WzT72f6l2uIQ8dx7fakyxLyhLNWaX0ktWuLHiobU+NJ3y7reZZ5jufFfzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515550; c=relaxed/simple;
	bh=icYhlIDeG/QMQw5FvTkHiaRIxM7hF19m4Iid+gPHQHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f9q9vMdB6Q9blQ5efZqlpx+W8bGbWcyrUVTjBKHTR+/lSAmH4dKL7C+RYUTZ0owKCIoNr+NBI9+iEMRSMdCjCBUiT++DBNJUPGG/J+8g//KUnbyicr8xlPvS6+jVwGUS+s7ccimKIDh23WFKpvV1FDZOL3frpZ+pINLgpZ0gzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OlLGUBp5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so20235775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515547; x=1730120347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+RUoH3ha/Lf1gdT8O1kbMPjqS4t2rKUPiMbdD9TVZs=;
        b=OlLGUBp5ZHZ3KiQsjkwiF/k7KxVO+ByhXufNbyo1mxpMHo70Q9W2IOHfxoqAyWbUmY
         xdcglqLKAk8vJvafenIb6t6HQ0/JYe1td7+CgPIBq4Af84/Bsh6yHwxPMoRBprpW5Dh9
         30J28q9gXmxNRFq3rHeEt+kGPY0dV3j4cTKRcNFumnoUG3HPfBQiVOnpqxSFM3+hqTpj
         /Y6qo5mblEVXeXlKGJeFTYRNhCLFno52zmvB9w4yJn/ayzZq68d9wUhaogH7LYijKDmd
         taaADHnETflukE8SWPsphov201oI19AQIvuenpibD1emRhY9oOrGx+0+UgxvJ+NGjJ5v
         WHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515547; x=1730120347;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+RUoH3ha/Lf1gdT8O1kbMPjqS4t2rKUPiMbdD9TVZs=;
        b=NDm/ZRl1f7xBO9yJlruupITdAKIbuoNpD3pYjHCd+Eocqx1gcGFY8wNgZHqszsDtTo
         hs9OXGPJApSRmtWUMabstmW7cGcp7BfysbeX1PjrpgFGsvZXZpLyhyZ2Je9VcJ/U8tiS
         nSqIanyVtgJW5iE9xdiaTatvxq42czxr+2CHoVHUEwRynFSkGjq6Vp8ABPOeTxt3v4wA
         Yh+aTwAmsaw2htTBuQpUV4mNQa5A2nS7rqqu/FtAH++SGF4VUCFcguV7SUH5WQEU4XyJ
         JbJU2I0N4HGInOoKR6Ewrh8c+VDuNRh9L6oeDxvMpiDx4jS4aEjhWPGvrebu9c9DDwQM
         6pQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4s45fdSG/CVXy2YAzyokn9V8xgObdjlKl12SzRbFxBeJDbJKjViXzwAR7H+qBtypsqz6RxjLXIiH2to=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotfYu/TXv0vTJvBtZ3GvfBcuPiB3Fdg6crU7R/mObgaUVGCWs
	eljn1DgZDN+AUwSez8ghE7kBexTb/eTPUDg7bhlysEfHxx8Bf5tQnpQeFfpHs2M7qr+zOKyva8G
	W2sk=
X-Google-Smtp-Source: AGHT+IHXnEjrjk+oEEo9O0YjJCw+q+G4imwHDuLvf2Jz7pO3SM5vNPJsiMiVQ85ppGf6vf0IjdMjtg==
X-Received: by 2002:a05:600c:1c97:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-431586fc609mr90806515e9.4.1729515546759;
        Mon, 21 Oct 2024 05:59:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm57452995e9.45.2024.10.21.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:59:06 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: andrzej.hajda@intel.com, rfoss@kernel.org, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, bbrezillon@kernel.org, conor+dt@kernel.org, 
 krzk+dt@kernel.org, robh@kernel.org, upstream@lists.phytec.de
In-Reply-To: <20241017085556.3045686-1-w.egorov@phytec.de>
References: <20241017085556.3045686-1-w.egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] Introduce bus-width property for input bus
 format
Message-Id: <172951554588.1240386.2012740643085248533.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 14:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 17 Oct 2024 10:55:54 +0200, Wadim Egorov wrote:
> This patch series introduces a bus-width property for the SI9022 HDMI
> transmitter, allowing the input bus format to be configured based on the
> number of RGB input pins. The default is set to 24-bit if unspecified.
> 
> v3:
>   - Add Reviewed-by tag from Krzysztof
>   - Ensure bus_width is set/defaults to 24 even if an endpoint is not defined
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: bridge: sil,sii9022: Add bus-width
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/096d518c43341c5d8b80948f6fbc90e916ffc7f2
[2/2] drm/bridge: sii902x: Set input bus format based on bus-width
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d284ccd8588c9b87222ec666a1da57f197023e5f

-- 
Neil


