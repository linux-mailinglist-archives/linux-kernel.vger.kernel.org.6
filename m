Return-Path: <linux-kernel+bounces-386868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A319B48D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402FA282E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0F205AB2;
	Tue, 29 Oct 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FraUuCOj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E962038D7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203239; cv=none; b=KpJ+TNoVUHLdzkq8kx/GP8DQXDTiENiVx+OaNK/Ib36gaOCa2TQfe4/329/XdsCoYp7UjRLXdz5UJVmR8gHPMAh3qdKYgjPMTxD3GZWntSlld+VCqVZ5Wf+r33jT2ytZDm9etV7lN9gzmSjS0YPR+mIvvPBqfOE69rlxm3HO40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203239; c=relaxed/simple;
	bh=pv+9pjVCO4yhV1giOhiQZxDFW1VigX/FY4OQGgw4PX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz7TS0J/1fXVisER/a/Jtz8KU4ebSgcVgKHUNhTHjieBUcyNf/B8jSyvCdcwUJrpBjIV0Zyt12cn/JMl0PVhAlh+YW2qdpVqTPmO1kb8QsIEPTUg9ugDhsadXq2fVZ9i/yed7bX4HAKI4qfGHSOsDxiUzmU1oDYTvT9e328nYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FraUuCOj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so49459445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730203235; x=1730808035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuboLlR7Ln4DJnWdMqj7oZQediUBcjGUfxubi0VCihY=;
        b=FraUuCOjKaJF2cyu9GK+eB/+IW74jvjRc/0hHxhjjaRoh5B3cPifTDasAmL1cwjsVi
         pxDFnQkQ/jU1jO3rkxYj36sM2n9Y9msrC0zE/Dxl9foC9obrgW4LS6sItjDlbpePZPnZ
         Y+knwNkU2J6n8JhYErZlbWO+RUdzdbXZBxt0IyAr7C9IHOVa8aNhwqibCUbuclTFBtdd
         XbcAxciL116awJbZbylA9mbx9uNgr+9M90m2bc14EYLWLDNDJz2QDoiEnzmhgEChV95q
         0cdRnuC8PygUt0wR5t0vVO8vRC0zrQc9lx3MMz2oVP3/ZeuwfSgeEWrX64hndHONIe1I
         ZthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203235; x=1730808035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuboLlR7Ln4DJnWdMqj7oZQediUBcjGUfxubi0VCihY=;
        b=HND5g0oQj6t6yTKkujlYLIAnZPcZdh8EtCnhIeD0ibk00d1B/vKc6mt2jZp7c9XhA6
         jp+XMP3sT3gLySZ1Qd8CnkNODvBs9dmJ2tHkGab584ikWEe0spit4cveUgRCa0BogcqC
         I4KkQ3PE+rzzi0sD+6xJm+BztQnFxvt/Um1YxiAMYjjy9WgAjrv7iDnOz8vlOi8PZoOm
         GTfSDjDKiClOzAREiU1gNEMBK7LzKlV1Bd4FMmp75G+YlREJvgwqAk4CTgWExkLoWmiK
         tT8A6VX5HxsUPN9rlZFb7fw/VDOVISeyBHf5UlXLLwixgyBQ2+zR4/BeDuy4EuecvvRd
         f6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWAqxor6jsX7nX+PnyXmS+POnHJl9SYVHAbcoeQTqJTsl6/YhCtOkQdyo6ik4Dcr7Gp7FfIY4HiYqyHPe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiS8nalaO3LAeopSQD8j+gHo2odHhUBORM6yACNo5LyweMKK/w
	cyG7eGAOTwMVh6gdZM1u3tJUf9WGO8gnkW6EhSxhDgTN+iwK6fsnBAWAyQ6Ga2U=
X-Google-Smtp-Source: AGHT+IG3uy6GEqVkZdtcpNz412sDdy/Ri7d0Q2JMRYAoIL/cB40gRqu7rJes6ZEOY0Wweyi8Lt6ASA==
X-Received: by 2002:a05:600c:35cd:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-4319ad0f10cmr99294165e9.24.1730203235401;
        Tue, 29 Oct 2024 05:00:35 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579968sm173118485e9.39.2024.10.29.05.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:00:34 -0700 (PDT)
Message-ID: <b5ada63e-31f5-4aec-8499-7e34f1943659@linaro.org>
Date: Tue, 29 Oct 2024 12:00:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: media: i2c: Add bindings for OX05B1S
 sensor driver
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, hverkuil-cisco@xs4all.nl,
 laurentiu.palcu@nxp.com, robert.chiras@nxp.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, LnxRevLi@nxp.com,
 kieran.bingham@ideasonboard.com, hdegoede@redhat.com,
 dave.stevenson@raspberrypi.com, mike.rudenko@gmail.com,
 alain.volmat@foss.st.com, julien.vuillaumier@nxp.com, alice.yuan@nxp.com
References: <20241028190628.257249-1-mirela.rabulea@nxp.com>
 <20241028190628.257249-2-mirela.rabulea@nxp.com>
 <c32439a5-4230-4ca5-8d46-fb00d25072e5@linaro.org>
 <20241029115747.GL22600@pendragon.ideasonboard.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241029115747.GL22600@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 11:57, Laurent Pinchart wrote:
> Aren't they needed given that the binding ends with
> 
> additionalProperties: false

Yes.

Might be nice to have

unevaluatedProperties: false and just rely on the top level

$ref: /schemas/media/video-interface-devices.yaml#

Seems redundant to me to keep specifying these properties over and over 
again.

---
bod

