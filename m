Return-Path: <linux-kernel+bounces-402726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BC9C2B03
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A721C20F07
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE8113DDA7;
	Sat,  9 Nov 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5DAapXI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AD1DFD1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731137326; cv=none; b=FTD1ec6h3p9tRdlRbMzZysBza/PJVPGInhveW/QN8/PJJHe2xzP0y+FLNG/boG9Bf60vldHnz5Ih5U0+4odgTUYvOMCtZ6ZN8EMREWqyuVcQfIvfi9bzEM/C5Bc13w7gbV7jI2WJRph7ea28vmKpXi+RN2ob2sF8M80ufeTXygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731137326; c=relaxed/simple;
	bh=0rK9USMAdn+m99OBN6AdiI+FuGgOxsBLT5lZFk38DUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOMMEhIveeSka9gDq6/32qF4dax4UP35RNsIoD0hgE+SykUYjzjvbhn57Kr6NfEqpBtm6klZqliLFyyO6i/5dRR3DTNIe2IHT/HBm+y+ER2MGbbBH0RU18qp5oMh//s2W0umaBRKuYr1kzia6xDVb+aegJLMl6+xAcI7RSoinkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5DAapXI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53c73f01284so3541991e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731137323; x=1731742123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/M/bCY+jOqOzGq7l1q1iV1xHZ3InGaYe9yg94zWyinE=;
        b=Q5DAapXIRhfFgQeLXgf/LG7v7m7un0Ndnc8Erb9azsrZVwDBhkuOrJ5lmk9woZmq+Z
         rolW2qm4HFgfHGVvlUbuaaEyQ5ICwvAw+0mcI/+Gwy5uro2ms+3hylpyhZkVaurpnYqR
         NVDiJvDk86tni/NYq/I4nTVnt+LEOk+d8bpYPV9nn/n5xVmWG/4wtvZhWmgtUwk1c4nd
         XukOUWlmTC2T9HNrc/eC8XRUR98BIuZmYW5MhRQUc3fOSF/xoGipJrt2dHcVV0mUR8w7
         nKG7vJ2Hb/FP8r8YuBtVPmWAiWAP08V1nln0yUCLNINIrHsXj97ZSKAztAbtwySzZMUO
         CkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731137323; x=1731742123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M/bCY+jOqOzGq7l1q1iV1xHZ3InGaYe9yg94zWyinE=;
        b=p+0n/zk35G5Aa7GB9GXqPAE0uOFC5YFOaru6nYR249NkVN7108nNibyjdRBPEYnxzR
         /5D9vsd1LhOKlg4Eai3fv+U8BolMX46VDHzUVOLosXcC37i6rLDBmh7MgYv5QPtCHxH+
         XVzOc9q0NwRIuvav/Tz4NAgu7Q8bM9301MsyMKUyTJpoys+N0dsRPGlwA6MK/s0lZ8Ty
         i0+cKzD3OSLA3mYpB4SguU5/c+6z04u/uBS3KjxXw0fup0IRoXIa1virJ+74OANcgxn5
         Moe2IIGZAjR4CRrEJpOqhQ/c8JjHfgmasAbL2O/633cbcEJKmbBim2nbLIKUPXDdVTHF
         czew==
X-Forwarded-Encrypted: i=1; AJvYcCXNqmN2dB77PhhAXEu4N4oBDohv/ObowZvTkCO23WAWmNE8msj2aQvnJqU7Lp4uR5hQZtY21pK9ua0HIkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX9ENIr/y/hIBxYgkP5qyV+5cq/OQVcAB/8xCi+4wQFB88+2x
	FbrkQ9k0q+N4plUeA9itHKF/coVk+LSBvOM0aihaf13oe2RcaAPVjGV22YZmQIo=
X-Google-Smtp-Source: AGHT+IGr74wZluvmUo8uII7mpyFPgo2pXGdkwS9etFnNLeaSzsXBX7H/XT76P4oRDe3My8eYZWyC9w==
X-Received: by 2002:a05:6512:6d6:b0:52e:7ef1:7c6e with SMTP id 2adb3069b0e04-53d862c6caamr2461967e87.51.1731137322945;
        Fri, 08 Nov 2024 23:28:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82685752sm870611e87.81.2024.11.08.23.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 23:28:41 -0800 (PST)
Date: Sat, 9 Nov 2024 09:28:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/atomic-helper: improve CRTC
 enabled/connectors mismatch logging message
Message-ID: <3xocdauewfty4slp25prfuyqlhhij4s2rqlngapvei5hihnpuk@za7ispjiukst>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
 <20241106-drm-small-improvements-v2-2-f6e2aef86719@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-drm-small-improvements-v2-2-f6e2aef86719@bootlin.com>

On Wed, Nov 06, 2024 at 11:48:25AM +0100, Luca Ceresoli wrote:
> This message reports a mismatch between new_crtc_state->enable and
> has_connectors, which should be either both true or both false. However it
> does not mention which one is true and which is false, which can be useful
> for debugging. Add the value of both avriables to the log message.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

