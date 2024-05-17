Return-Path: <linux-kernel+bounces-181709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A98C800A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C82283CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B753B640;
	Fri, 17 May 2024 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+eIr6fo"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064D8F55
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913754; cv=none; b=L/m7RwNy6fdSwxgJC64REbi4IRg3iMP88dxFQ+JNexw7ZkYrvw65ofQyVzxC9eGNGoTDufXTTNqIQUkOWcFDaRaJJqAe5p8xAcfliSIxqUJTwW0P9HswLEuLCFb7nbWF7tAyDR3CiFh2A2BTSGwRCo0RdkDhMxIIDWvoB/7Segs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913754; c=relaxed/simple;
	bh=k9vt6UAu4sWr/NT1L4OfobC04mqXhcRjUlOo/xVcuQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD/eFF0xzRd4JpLedmtN3iDk0nkzWiEBWmwVyD1y/RHcYRPJk+XmBcyjALv4fTO3ysYslSKPWh+90YcrO3Q6Thr8jzXW1bpaG5hDC/z7++uhS62j0QzU6bU54MXAt1qdm3LmwC4kYaqWHLsmIY/udvhgTG81Pu37V5xgn9g+o04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+eIr6fo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43dfa9a98d2so38611cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715913752; x=1716518552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xcERYLMw1NsaQaJs4tuIW5UTi42E5XYAUPijpvCOAiQ=;
        b=o+eIr6fo4FW7jyHwQr/kasNVkU1uEVv9aI3q2w2ljcI8TKuRNwLauA5PBa3TYtUb3o
         XdnK4Z/lvCQW8qh8AhWnnSOFDbOkO1wk4HbJ2cWLuM5Ex9+f7Zy/nGjPxP/CDHcq6cJJ
         9A2rqdDtfXdaH+ls1lIs0P1K57BE6MIhd86oy5dbaRlI7Mlz67xdEaYDhbxnZZrT2mB0
         z+X7iW8ObyMVh3n1fLjShyBJocDawB1EN+K59SOE6bqmvKXAHGCPjYNMzlnrAAZquiEx
         YVDA0P3JR+YFhGBcAPmvM6k+0oibeIg72lhpeMxaI3xDRCBpDMrhAqyT/jCQjnaMRyjk
         SfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913752; x=1716518552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcERYLMw1NsaQaJs4tuIW5UTi42E5XYAUPijpvCOAiQ=;
        b=pQLTRtvxpASV9DKQFklo/K0DbaosocoMNo+WRajNnmZK7boyvsoqathORyQHxk+HkN
         XktbFIG6t/sqDnrbbRb99zGKZW8j8b0EjY314HS+sNb76fW4d5ksEl3GY3KxEzrA4Jjp
         A8z+q4xg7d6QbrycWyQVagg/vy985MrkqduALt8VxIg66D93e49p6YnwylEkYd0R507F
         Q+cG3roygV/g4TU17NEbESXwijtr7qksZr3YBgPlEMeBfnmmLkn4VN7zT03fzsAEk0zO
         F2E7HDFlvaIqt0QTVFP+M3Gz3LMFsDajZRhFX6HTRKx+5x65/XH46laFgKHkLm1XQSj/
         KNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhx32+N12ZjHLD22V4PCQlCI7M6PaZXRzLZlWAUG6cEud/toyJ5l1uPYnt6CgcjTItCWWqhPoPagVkJeL0pUHV3A+Bv31y1F4bt3Ae
X-Gm-Message-State: AOJu0YwTjHb30E3GhadKdepQwOoyWsjo7R6ZL84P8W9DgZ/PBYKpbw7G
	Ig2iUiyOtDq7Ez9/dsfA9ee3JfGPF7Yu8x70wjHuhmtj56EN654yoV8Q1B66B6FuOtjO6TdxUIx
	AdYT+9YdFzjZvhVIQFYVA9SuYyIFasNRalNxB
X-Google-Smtp-Source: AGHT+IEh8ySbAr1EoQyBSHepFGgUmnRibTndoFVUdDhM/Nh+Klm+zT97+G+CDHxTiKHHKRocVjSF+2B0O4oJOoRrrb4=
X-Received: by 2002:a05:622a:2615:b0:439:ef72:75fb with SMTP id
 d75a77b69052e-43e44b9cd60mr1181211cf.1.1715913751805; Thu, 16 May 2024
 19:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com> <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com> <20231117032832.6k4msq2vlp56asho@synopsys.com>
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240119021520.757vpt3oeig4hws2@synopsys.com> <MN0PR12MB5953C70F29987CCDF3EAC67DB77E2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <MN0PR12MB59537CD8D7AD30C20B52619EB7E32@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB59537CD8D7AD30C20B52619EB7E32@MN0PR12MB5953.namprd12.prod.outlook.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 17 May 2024 10:42:05 +0800
Message-ID: <CAKzKK0qrS=A5HyqrV=_WbjO8BFnDWJ1RPGu8j9sG8+DXyT88FQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Dan Scally <dan.scally@ideasonboard.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>, 
	"Mehta, Piyush" <piyush.mehta@amd.com>, 
	"Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>, "Sayyed, Mubin" <mubin.sayyed@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Radhey Shyam,

> Thinh:  Unfortunately, i am not able to replicate failure behaviour and
> validate the below fix. Tested webcam gadget taking stream from vivid
> and then frame capture on host using yavta.
>
> @Kuen-Han Tsai: Do you have failure environment to replicate the hang?
>

Unfortunately, I don't have a failing environment to replicate the
hang. The reporter didn't provide the steps to reproduce the issue,
and all I have are kernel panic stack traces.

Regards,
Kuen-Han

