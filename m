Return-Path: <linux-kernel+bounces-205430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE28FFB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B20B1F234D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663214F124;
	Fri,  7 Jun 2024 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVDDYZbC"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF114E2F7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739723; cv=none; b=d2DHOthUFBUmLu1k4eXQej99St39xyQ0u97TvPUt7AcdOVlURWYenaKf8Ip8SkWF72e0RML45KUiofwr2m3V9Ijh6xjDfvW+nV25hy8s1CRvwSJieGuv5SE8aHzJkNyEvO8QihPasewZ36e2gu8co+6iVNkolBDFgyT8znPhrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739723; c=relaxed/simple;
	bh=ZhXwI1cGzdbG3/xPhux84aeXE5uygV37OsetZ+A49tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHk6YiGjMGmjXltctApk7+JYryWv5iSgzByRCg69B2I2v93mujBVzQYeccRC0E0a+oatGbfFJKfcqUa8uPlkv0wJL0n2qUwRLvfd8rg/63ZGWyKJDkrJWGgqMre1E3jUGcmjdrErfSVCOGfFrPeqctuTyNep2SL2NEODJtMac/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVDDYZbC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eabd22d404so18211001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 22:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717739720; x=1718344520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BPHj5tjsy40u5xnIOS+sJiXd9TZKhkHWvmbm5XCXCM=;
        b=RVDDYZbCHjjSb1ysoxB8BQxmkpI/NReyrjiApQ1a5ucarQr4KM2V/kiXNnIkcBcD58
         oMKVojybysSXvLaQ3Nq4f7iyV9DoJ6dUnMWQyYWtYFe9dPW0qpwx29IvLJL6nhulVR9p
         I+BB2JU6pejVBI+iE4u2X+H+CEP4V/RUHSEQJ/om125O6T+R6NOdLu8hdQYeQKH9C7ZS
         xuESyungs6DPZmOfLSOToop1EveK7BuWTubGewGjQEjpzzxKDWZ+j5cBMBMas4IlGCul
         JXh9wcYGP+I0pKHdAOAcUmkxApEW2YudQ9chdntdv2sUcFSVoLCIn7XHTd9WgtbN8T84
         bxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739720; x=1718344520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BPHj5tjsy40u5xnIOS+sJiXd9TZKhkHWvmbm5XCXCM=;
        b=DyTBUjnTIkJ3vr3g98VKCs10ZVJKynWm0N0wYxK+mns1Wihr9ia+87fP6ukmuzlo9e
         sYvWPMW6Pkpykz9bz1rXWZ7/lHYXsYSFZlIGEz+puoRUiDoADdc4qMz4D9gxvVpBHsDl
         kiCv+CXgKkOejJ1cMOdUhpG5NjcZUBCLJLPPVjBKX2W64TMD+xQKG3F65njOHYH9mjsa
         YUwop4WVFIiVgjTdffZX2AB6oKoJn+nAGGVFuBPlkv5nVk+EAIyaNNXg38rut5OAjHNo
         NVmohoXuu2WDsV0ElkMGNM7HTOrJlrLpvyhAbL1jCCqALDynam+9heU6Q7jvmaG7+K5q
         XM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBOKt2BP1gn+fsCj39GMQqBnHnlTLY7jkKHL0gn4L7cP1LzlZEBCNQMEW4nnSMhqyghLAaIsn6PLvH37kEHc2WsE9NOYHZMNuB3kj8
X-Gm-Message-State: AOJu0Ywp4e57hpXemCLegYmaE6c+n+WRvz9z6IPaS55ewiF82DCUuYt7
	QOtfbhDoFMe0Bke0xjUqi6eFp2N6olrZKlRoNy2k1VPMACGd9XXoCGtduYWYVtttF8gBJhrdLtJ
	C
X-Google-Smtp-Source: AGHT+IHoz1Kc5/yTC4dbwlAKkn/RxZ/i22SG7V2m9thfEVSDlUh/a8lngHbXSPt7qixcRb4bTIg8IQ==
X-Received: by 2002:a2e:99c2:0:b0:2e9:881f:66ac with SMTP id 38308e7fff4ca-2eadce34e53mr9065441fa.21.1717739720539;
        Thu, 06 Jun 2024 22:55:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead40f11b9sm4233071fa.11.2024.06.06.22.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 22:55:19 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:55:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] usb: typec-mux: nb7vpq904m: broadcast typec state
 to next mux
Message-ID: <i3ampmzac6rsbvjkysfcu264jhhzre4rz5jkee4ktqlwxnpbor@n2jjzv7sklz5>
References: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
 <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-4-c6f6eae479c3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-4-c6f6eae479c3@linaro.org>

On Thu, Jun 06, 2024 at 03:11:16PM +0200, Neil Armstrong wrote:
> In the Type-C graph, the nb7vpq904m retimer is in between the USB-C
> connector and the USB3/DP combo PHY, and this PHY also requires the
> USB-C mode events to properly set-up the SuperSpeed Lanes functions
> to setup USB3-only, USB3 + DP Altmode or DP Altmode only on the 4 lanes.
> 
> Update the nb7vpq904m retimer to get an optional type-c mux on the next
> endpoint, and broadcast the received mode to it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/typec/mux/nb7vpq904m.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

