Return-Path: <linux-kernel+bounces-171672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43388BE727
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E942285BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD11635B9;
	Tue,  7 May 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBeyiRVv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B63161318
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094911; cv=none; b=r1I/IBRDxs551FJtpTEHqP44UGdZQUIDELr8VUh1loB/EuPXy8OVpi6ujJ6qWSSQaP6GVIQUAbLBa2mNpw6laM3Z26F6z0/A+GqT3n86PbNd1iScBIBqBCZem4wnTOdUZorbyhyyQeczy/O9OgIw3b5Jh1tmfBS/fXcam7JPW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094911; c=relaxed/simple;
	bh=IcrNwEYyvx0qglVf0QIVfb8UjmxLQ52vtI1NNKvzKZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JO4o1DuA/a+Dtpeviq1Eic+CaW7vVxj+cHafH3wM+MDLBsc3Si9ETQ1diUmMc+QWQp/Oca2JaNFcU58IW9S/vzBp9B8T6wDW/fs5zZxQQkDvZ++Fi9YejZ7fGFLpoCpUQZQo+7hqa8ongffjyW7qlvbRP24oPKJOQGxpJFEnNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBeyiRVv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so24713015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715094908; x=1715699708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnDKUzJ1K4d32Zvr481HYLHQmHX8rOjTCcbf7ypp6Tk=;
        b=uBeyiRVvgK/DiKvZGopZ/Un5K6Z2SoV5WdABrpKslm0y1k38HqCjGjnYqOGD1Nfmpp
         +omdhuod0nP3T2x8AABjqdXb4YwptzwxkmDermFBetKevz6x+ngv/vcVAcmII4tqyqvX
         gDKmYgCsE7sme4a18tFk6z+iyP1RpDkDssdfRAwb7Nee1QXbFVdIe8VAhBFHuSJ9VpKT
         d467eqHdisumtQyp/oGFrUdFsS5j7N1RI7XzdeyLAHVcGIKaB4UZb3fewGtF+w4EpP7c
         +esvzZhqOR2OTWm+Z6IHkOf9pN5EgtMxFC/f4Md8pRt2cQEU44rmm4xgOQ+QeKZB0tR1
         CW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094908; x=1715699708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnDKUzJ1K4d32Zvr481HYLHQmHX8rOjTCcbf7ypp6Tk=;
        b=WQWcwq4eqRLu68cBVU2ce9HwXYaIz+TGRrETFatKobaRwsyRJuEIFtB+lizDdK0E1T
         bZA3qL2aDvGkY+f6OE/q7Z54VeKv5HbiRlFmfP8peOE0+kv8jeWua8PiM9g0S3UlhceI
         iPL5yn+Or+ojondjRICOLCfJrbo2v9CdVYczKfoUmgMVOj/7tLYAo0A2vac+CJJNhrzT
         tDhgocCDBA9xtF58xb64tkqYGZX0gw5SzbziDXJWZ+Tsw/oh6Az7ZIEfm3XlKG1O9kQW
         uSpwXF9mSGH4zz0xHXifE4gKWu/TlDznIXq7d/bD8SAT6Of942pBuejFo7qGRnQBhFMe
         Qh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfijZZpeEQAdu1ZdyOZw76nSZ1o+j0wUSAkvygu11zs/+5gwKqdvXBQagQZbBm02ZrwHubd+BFIYvBex54GDrQkwcP233ErbPt91lS
X-Gm-Message-State: AOJu0YzbdHLjjizQCvs0tkL2YjzxKybuUDoW4DdPicsd/lf8LDqNl7j2
	E03dJaphu/6UOwgtLMNBDsvlUpqQ1oGpeVlFbjb2N8a6C6m0+OjHNQqRy3HmauY=
X-Google-Smtp-Source: AGHT+IGlcCfFKvdN6aJzvhdwXvMxfsPlGA98qekQycZhIaKPKQlXQ9xf4cXeathWNzjqKmhDo4q4+Q==
X-Received: by 2002:a05:600c:511a:b0:41b:b77c:679 with SMTP id 5b1f17b1804b1-41f71accb88mr961465e9.37.1715094907784;
        Tue, 07 May 2024 08:15:07 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id g7-20020adffc87000000b0034d1fe44278sm13176378wrr.39.2024.05.07.08.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:15:07 -0700 (PDT)
Message-ID: <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
Date: Tue, 7 May 2024 16:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lennart Poettering <mzxreary@0pointer.de>,
 Robert Mader <robert.mader@collabora.com>,
 Sebastien Bacher <sebastien.bacher@canonical.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Milan Zamazal <mzamazal@redhat.com>, Maxime Ripard <mripard@redhat.com>,
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
 <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2024 16:09, Dmitry Baryshkov wrote:
> Ah, I see. Then why do you require the DMA-ble buffer at all? If you are
> providing data to VPU or DRM, then you should be able to get the buffer
> from the data-consuming device.

Because we don't necessarily know what the consuming device is, if any.

Could be VPU, could be Zoom/Hangouts via pipewire, could for argument 
sake be GPU or DSP.

Also if we introduce a dependency on another device to allocate the 
output buffers - say always taking the output buffer from the GPU, then 
we've added another dependency which is more difficult to guarantee 
across different arches.

---
bod

