Return-Path: <linux-kernel+bounces-186354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66948CC31C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8428364E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59E1DA24;
	Wed, 22 May 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YALm9vI7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9A141995
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387657; cv=none; b=F3MlbyH4MJ7zcALVl7sKCz2V8FISoi6vBCFLE/xxzJTG7jCZAovZK2Gtt7nqMVKYxn296/OLJ2IxP/Bqklb69GvoO1CfXgvI3vnf7jqtmuxk4+hRt80BjMw5Ya8N3lIiPzVFWVbHSSxhJgL2mq1puS/jabRlTM4UGOLybsmhmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387657; c=relaxed/simple;
	bh=wiHvAt4aG5xr7RlqSNws4R/08iwTyUy0i5hw/IiiJXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KjkPXXa8rXiQoy4/rPIZljEPH5XmMbBXYWRUTgxbH7AVk3Y3UYhHG6TFsYmaoOW2h3dqkOj2wrosY/V4Qul3SGTUfU2J816k8sVK2mDWzw0Biw61v89ArdrSIrugFoCYhgt3JhInpsJbzu+3hFxWgrOJX5YWuooJUFPt22Dz5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YALm9vI7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1913144a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716387655; x=1716992455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFMr3MMlN9ccj6zDjuA2RuE2zH4kKscYyAKXBqfTffU=;
        b=YALm9vI7vD53ny2Q5Otp0IxU1jr2QVPDkPBEi4CO0fxKS+141tVtStMwJ9LMWToYrV
         zve6oywESIO/oFUp/hkV/CWuVdsvApkbVM0RYRFQZkYvLBkHuPmn8hAlMNDtQ0nHN8YG
         TQ+7OnUSuKguGkWl+vMcHv4xV+ZVSYyAaxzZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387655; x=1716992455;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFMr3MMlN9ccj6zDjuA2RuE2zH4kKscYyAKXBqfTffU=;
        b=I6zSW1yjLkMaoa1dj0KekgakVMSMP86pX1OBvEHbA0+qy817k7EsBRNtZqbV4qaLlU
         dh6Xo2RoIX5oAE/SToRK9JkbBbT1I+tAhrqClfLWjTFgHjGppFW4dXkmI1hX/qoxZVEB
         oz2YxrOE2zhJEN93je9ZXL+KQtw7cyUxDL8q+RBTbHFP5ypU+nR+G7mT9NqhO/Pw3T/L
         RDKZBZSuLGE4UiPIUWwDBougHO2lJLkAe2m8vRBgI223ccm6VPXLcDLOpvFIccIT8cTI
         mORHnhT8NfdHIljjSP3rB6rSem/4Nps7iIR64sjD/oFZUSZ1k4DatdXl0zw7McnY7Cw3
         iJeA==
X-Forwarded-Encrypted: i=1; AJvYcCWYOOrgCyeYWkYWgLgtijUKFTXXZC7Jpc3fDHsLiW5QjLIWz1I8O1AgWjIS1Xa3GReEC/tWhBaKEJTC4xPd89KqXXCP07Xkt7f15kXp
X-Gm-Message-State: AOJu0YzHZdxnbCqbf/LjSVFmNdrt/T9O129RkiRvV0uhIrDkeln6Rwb/
	A3yPmmjiP+QizitO2l74vxqlVjOhn9UcRfJGrOYMuUMyOGRISpwa/ErGmF/kOw==
X-Google-Smtp-Source: AGHT+IGHIinTCDwt/PEgWlkID0Una1sqCjW4DV4H213H9PaTp4eMUvMwciKgrPBvbyKEA415+UyAmA==
X-Received: by 2002:a17:90a:ea81:b0:2b9:7afc:e7be with SMTP id 98e67ed59e1d1-2bd9f5b96ecmr2046384a91.46.1716387655532;
        Wed, 22 May 2024 07:20:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f9bb:ebce:f86b:d551])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd74309db7sm6244367a91.33.2024.05.22.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:20:55 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
In-Reply-To: <20240522113924.1261683-1-zhouhaikun5@huaqin.corp-partner.google.com>
References: <20240522113924.1261683-1-zhouhaikun5@huaqin.corp-partner.google.com>
Subject: Re: [PATCH] drm/panel-edp: Add CMN N116BCJ-EAK
Message-Id: <171638765427.3003190.5451039339852663119.b4-ty@chromium.org>
Date: Wed, 22 May 2024 07:20:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 22 May 2024 19:39:24 +0800, Haikun Zhou wrote:
> Add support for the CMN N116BCJ-EAK, place the raw EDID here for
> subsequent reference.
> 00 ff ff ff ff ff ff 00 0d ae 60 11 00 00 00 00
> 04 22 01 04 95 1a 0e 78 02 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 18 00 00 00 fe 00 4e 31 31
> 36 42 43 4a 2d 45 41 4b 0a 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 31 36 42 43 4a 2d 45 41 4b 0a 20 00 98
> 
> [...]

Applied, thanks!

[1/1] drm/panel-edp: Add CMN N116BCJ-EAK
      commit: 7acacca1b157fcb258cfd781603425f73bc7370b

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


