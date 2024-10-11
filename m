Return-Path: <linux-kernel+bounces-361160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434F99A470
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133091C2189A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33A216A3B;
	Fri, 11 Oct 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQZPuOvd"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5652216A05
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652012; cv=none; b=ddWVtxztN1H4uQphSsuBJ0Rnxr1+beGfFj5HBKJVIKaEZmj6lhiVWC23Q95KJJlcijGifx2YN98xMPQHV5MYwWRAE2TOSR27ojBH+h4A/e7uLGqwb20sJzcZ/uq1y7CpFq8RVqybBvDrHHipEHlC50Rz5tcrttLYfrBtYGcFLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652012; c=relaxed/simple;
	bh=EV/DN9flHr69IblBZ66lRvABdVFuHlpPau2lTDOjQY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XSB4oSlEvCOWFByHWiiHbii8Tv1VnO/bsAi0zgUtvzuQ2QdO03QyyFueNSSb97cFVJNbMYt8HPrCKCoSE40ibAZlRdEFodlyq8aYjLtV3f1dTcj0EZvx+8YxNSfgQNvmSQ1ewFcXRl3b7ExSW8PPsmhkyLyzgRZznGM9jkHesP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQZPuOvd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so2339732a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728652009; x=1729256809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkbEDziZ/ZDgy3PW7wlM+6buWKEuqwUhvBUdoxjonFU=;
        b=SQZPuOvd9YdXw7LmtDpyDC84j8ULQPnI3gj+EK0HFa+23FqAaWQgB35VPUEqpSCtVy
         Q2ajrVxjaFqYUEjmN09mm+W6dZFm3PQv1FlwvKtWPo57cRodJAl4LU6E0/MZHnZMHvCD
         d1vaCe2sbTNr8yus+lIsrozzNTaYo3j12v9T0OeeA5CQzXQWqEMD8jTLSGpb0NcLw6a/
         R2R5FsQfuQgkthJwPLaR6dBla71bwdRAkJHA3HB1e7Qpuvtv4Y3GMY2cqcVu25G7S/TE
         0yAHlDVFhN6kD3ldXd+WLHDx89S7Ptsm3LaW+WAEWMJ5BqrJVCTIbYvKpahvbIav6NTh
         W6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652009; x=1729256809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkbEDziZ/ZDgy3PW7wlM+6buWKEuqwUhvBUdoxjonFU=;
        b=aIrtxnfM3/eI6RIx92yES+zU7SpQJ6gPet1YKGBosWrMdITZz2y8PjHbTHZLBbOIbm
         4JwyDj/wmIeTYnKVJ7mjMa4pbNuKiHqqg6Lqu1zGSM1s2B2ppmM7XHSwQ5JPdRmM5y9i
         G9yYj48petitDVmxpRJHQfCv/OZCa1hKtTQUhLw5HRXxnlIZokKRo9KMn7OH97Z4jyBX
         jO1DooC0sUU3W6iBI9IDmb77dz19Z1SoUPamqsWJslfLkikmfEQPW1ZTNZLYYM0j2JDy
         Svxr8Y4rkB4jDS6TV9js4UZqf2X0+1qZ6befFHMoM0bTHesghEkhvzOUX8uPYfQH/wSx
         Wy0w==
X-Forwarded-Encrypted: i=1; AJvYcCXHJzwUovzaFSFxfVTj6JEXHstwYPFA2D4LF+AHle3JaCqUeZOTThAIlP8DB+yA5gwsObdfXbotFUW1IZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HNIwqFRJbuUXd2f+Spi0GfHzLv/0bFh7Zoh2rUYz9o86XxK7
	9f5nMKqZXvY4AFqDJkx1nbz7tlNQ3tPGulRtQZT+v8zxmROdrq7Q14qINLcz
X-Google-Smtp-Source: AGHT+IGEF4uRBen/CEubOYBZjPs0NT7x/gbFOaP3tvZ71aP7jtVN5aWU34Fo2/mQxXUedHpaZiVz8A==
X-Received: by 2002:a17:907:f752:b0:a86:b85d:9470 with SMTP id a640c23a62f3a-a99b95a7e09mr210833966b.59.1728652008944;
        Fri, 11 Oct 2024 06:06:48 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f2c1f4sm211008766b.87.2024.10.11.06.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:06:48 -0700 (PDT)
Message-ID: <fbaefd5b-8677-4af1-8ace-206018bd9265@gmail.com>
Date: Fri, 11 Oct 2024 15:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm: logicvc: switch to
 for_each_child_of_node_scoped()
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
 <20241011-logicvc_layer_of_node_put-v1-2-1ec36bdca74f@gmail.com>
 <Zwkhuyq39LQSZCIN@louis-chauvet-laptop>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <Zwkhuyq39LQSZCIN@louis-chauvet-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 15:01, Louis Chauvet wrote:
> Hi,
> 
> I think you can squash this commit with the prvious one, I don't think 
> this is needed to add of_node_put and remove it just after.
> 
> Thanks,
> Louis Chauvet
> 

Hi Louis,

Thanks for your review. I did not squash them because the first one
would apply to stable patches (note the Cc: tag) that are older than the
scoped macro, which was introduced this year.

Best regards,
Javier Carrasco


