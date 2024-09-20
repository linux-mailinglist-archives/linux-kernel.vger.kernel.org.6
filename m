Return-Path: <linux-kernel+bounces-334486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0397D7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615851F246B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AA17C224;
	Fri, 20 Sep 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvn4L/n1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BDF4ED
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847412; cv=none; b=X0cjPyAiT+gnA4rpv80f50UKUq03LOehldpukWKMVUNt7RrkLuEzojRNFasZs2morEvnSCCpWtUekkpsDUg4ZhIowadGx+7+su+Is9cnLA+HcDXseUY1ggyeQU3+iZjTnX+Gijtqg2uTv/vI1bML66ccQE/lJ6w2V+TW0hmHzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847412; c=relaxed/simple;
	bh=9mX8Lc8FHhzmhdfC4qNmIeDhIa3Q8HZH8o+UXxa3Xbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAJO4nDdRD7bn+YB8+LhPi3wZ7N+RmNjMYl9kUKlLqRJi1W9wCXe3ud9ApmuKjLvWgMyTVsFVmqiU6IKdiVs5gYJ+2MEhAq0gLV/W/cHEhboMXke/NpCpbCia03KYNlZCZb/sUHZfWSu/QFDGzbj72zjFJz6wEcptyjpiCx/ndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvn4L/n1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2960571e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726847408; x=1727452208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KSTgG1ONFuwyX839G8yS/YFRBceOdoCcCoRfbiWXxRA=;
        b=kvn4L/n1TyPTFE25V7Q1eh2eAbL+2A4dZQNfMe7564LZBKDCDJcCciVOpfQF79ee/Z
         XsCztGZEuWRzlF30IDyceY/wzDeDWqc37MoT9ydF9uHZS8la6Coi2yngKniZUWIchjx3
         MBgPsVOuJMDTeX2WS68myN8eiMOP3npq/BiDJyfkUleQUaoMNaTqwldbaHFE3xkBseXs
         YbPzU/yY4VC2t2AZwjqbOUMM1c6Jxp3DPVpU6xVIaE0ruPPgKxqqUqhGVKHUDB6s05F7
         lD8lzIeTo61dC7VK3eTkOB6ZUpfKtnuMqYKX9DxM6idrNSz8R+NTcR+iDrxBAxePdOv3
         sdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726847408; x=1727452208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSTgG1ONFuwyX839G8yS/YFRBceOdoCcCoRfbiWXxRA=;
        b=UbZd/7NpKd1Mku4+URiK60MNJvCvDcCLGVb2u/7kx1ov14WEhGBY0K2VsJm03oV7ND
         GeAArGXi67IlhGQJaQJPqYuVpAfB8RLVHBo+nKo6K88tk1IDYstXoY+HLrz1Zxqgwkp/
         1IkeS0+E9jKozN+qaXwIOoYcXXkZXVFzM2BOAuXDQ1zA3ZzqJMRucJdR/0GK6g0SlBlM
         AfpX7rzXYuifihTblgE5ioyAg+6/pgluiW0yOezzyPCcLNl1Bw62dc+9dthicMbjoNjx
         xUMQruBdOR+S73bn7j1v90fVXwMb5qg4l+e5+e/kPupo9H+pRdQV6J3TXaqJRP90sEw7
         Un6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLurQsEvzwfo/XwyzQuTBmQo0Zq1gOc7mvKYBhqZm+9JOb0wam9E9m9yg3ONOAbUMXbwa3XNbynFCIphU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50ExKJw/JFKc/7xZmc5/KPf1zUg4VQjSsk49sVxCG5dGDuXJm
	sBaS7GSDYtZZstuQ6ae1s0pPv6FLYazINfCsLgUwKWg6q55hrc8+DLLN2fq+Ros=
X-Google-Smtp-Source: AGHT+IFFifI1MUsOVRDjkDVOg+d0xUbcZiymFm1+Kp7WhRry1g/Fga9+FS4wV+y+d1B48js9K9fuPw==
X-Received: by 2002:a05:6512:2391:b0:52c:c9ce:be8d with SMTP id 2adb3069b0e04-536ac341b82mr2170221e87.57.1726847408505;
        Fri, 20 Sep 2024 08:50:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687047023sm2210754e87.45.2024.09.20.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:50:08 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:50:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Hermes.Wu@ite.com.tw, Andrzej Hajda <a.hajda@samsung.com>, 
	Neil Armstrong <narmstrong@baylibre.com>, Robert Foss <robert.foss@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>, Kenneth hung <kenneth.hung@ite.com.tw>
Subject: Re: [PATCH v1] drm/bridge: it6505: HDCP CTS fail on repeater items
Message-ID: <nczuje3ur7sf7uqkygtziwnz5p6b4b7bf5on5crljr2ijmblrv@ym3fkvqxbjq5>
References: <20240919025551.254-1-Hermes.Wu@ite.com.tw>
 <CAEXTbpc7N2v4LwoZ4wpHXi7ogyqGwYC3Gpt5sqfxtOpYrngPLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXTbpc7N2v4LwoZ4wpHXi7ogyqGwYC3Gpt5sqfxtOpYrngPLg@mail.gmail.com>

On Fri, Sep 20, 2024 at 01:27:54PM GMT, Pin-yen Lin wrote:
> On Thu, Sep 19, 2024 at 10:58 AM <Hermes.Wu@ite.com.tw> wrote:
> >
> > From: Hermes Wu <Hermes.Wu@ite.com.tw>
> >
> > Fix HDCP CTS items on UNIGRAF DPR-100.
> >
> > Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
> 
> Reviewed-by: Pin-yen Lin <treapking@chromium.org>

For the sake of somebody applying the patch because it was R-B'ed

Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The commit message doesn't describe what is being done and why, it
doesn't have Fixes tags, etc.

Hermes, I'm not sure what's happening on your side. I have seen several
revisions of this patch with minimal modifications (and being a part of
different series). Some of them were marked as v1 (although you've sent
different patches as v1), other had v2 (but no changelog, etc). Please
adhere to the described process of sending patches.

-- 
With best wishes
Dmitry

