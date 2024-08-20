Return-Path: <linux-kernel+bounces-293830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C9958576
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F53B254EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305018E746;
	Tue, 20 Aug 2024 11:10:26 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383118D63E;
	Tue, 20 Aug 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152226; cv=none; b=VWdsvrAgYYB6m92ksA+VZGKIfJpMhSKbzASKEllNn1gTtZQdkjXuMqBHhaur+g5waUbow60l5FfFRGeJl7lAJhiFsjmUGsmZIJTt7ZR8CHKcEqa643MxRhk1iNfiUoMNt5UI9tYy4Ly1Scmzx/XJo0R9umjR3B/CU9jgHUjaT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152226; c=relaxed/simple;
	bh=hjQhT/qUKcPqbMV1YGAkqUAI41RaU4lOS+ZPTQ/daVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHbACf0r04dWmsz67olRLT7akuRdvrTMvxR0RmGlFyT23HxHUreqC91iS8s2WrtW0fQBDrBkB4CmU9OdIbWv5IxjBLqgwo27SLpIR135nJWgJUqAULtlUKnvthgUPiiWtiIHkiqtTpfh6MmEkqQoK7CywvCQGPdQf+gH6fcddYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42816ca797fso43936855e9.2;
        Tue, 20 Aug 2024 04:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152219; x=1724757019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fInxDh63lUo1pJrQRWGa0VqFjDqKSYMTvciu7osvTj0=;
        b=eZcWgK6VHPaiEC+B7URewa9o1nH1drFdl38t9iEUSRME0aIplEaXV551SgT1dAvCdp
         PpcVxQZCVoaGpayRDeZR2swySezWpoR1zlt1rUaG6ZPt+jkL4TWos2rG/4EqXEQic1O7
         nDoAvnjkEufSMICjisKjbiha42p6n+QbWUffml40C5lOwO3A9zSFsOUtXgQhQzn/bGjP
         EXQUcHnfyiRXAwIQ9idgyX43YZNUjcxfI3QUL2xwjZOr8n+wle+fDoyd9XFzAD7N9SS5
         H3bv9w9FTrkJnwSgYSsKHVFIbC2nIz9/IpKmrn2MpH/yqwctnNFxe5caKuFIiZELEk2E
         AYfA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkBHcsSzbPN5CDsSWYlnEV90pIDXS9u/lzZrXCUriYeKuHUfC5CmpLnvPvDG33Yc3QFU694Wo7hCF@vger.kernel.org, AJvYcCXRZ0eC+ReyPS1V6MohwwKESgfEeWhI1y7KeSV/YvIPNesIptSm/8PUvSrSegCsvWy0+NqojniCa5AVns3e@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUyN1r1g7F6w72X04gq5Vz68z6g4dxRLmEstemVVJEZWdSYLL
	kuKkXEQEr/CYvXFVEt6TYwqeGu2exHyfTcczGycSGTYbFFN1soy7
X-Google-Smtp-Source: AGHT+IFKueD4kujwz2iAYYiHm0x6pXa7zOH0dqc0XttMsjnIJ4KVsIzJEoUzeluMlqGg4HQjTlqfbg==
X-Received: by 2002:a05:600c:1d07:b0:426:5f02:7b05 with SMTP id 5b1f17b1804b1-429ed7a6156mr84932665e9.2.1724152218409;
        Tue, 20 Aug 2024 04:10:18 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ed784726sm139348495e9.35.2024.08.20.04.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:10:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:10:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com, 
	jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: dpi: Add power
 domains
Message-ID: <b5wtwpkwgg3tbwya6zllmymaaf2qvnyfbspkynr2ruzncej2ql@qloslxfinvos>
References: <20240820080659.2136906-1-rohiagar@chromium.org>
 <20240820080659.2136906-2-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820080659.2136906-2-rohiagar@chromium.org>

On Tue, Aug 20, 2024 at 08:06:57AM +0000, Rohit Agarwal wrote:
> Add power domain binding to the mediatek DPI controller.

Why? Who needs it? Why all devices suddenly have it (IOW, why is it not
constrained anyhow per variant)?

> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml     | 3 +++
>  1 file changed, 3 insertions(+)

Best regards,
Krzysztof


