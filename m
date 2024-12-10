Return-Path: <linux-kernel+bounces-440281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D99EBB36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B229B2840D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617A22F39E;
	Tue, 10 Dec 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vohvuk7P"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEA22B5A0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864093; cv=none; b=KE4K8xxO7AvpPM3C6Th9qqwXPLFQ8KEhWMVaBMx0CN/8APYFfMf1g/zf1nGEQHG0F4mnEgshB/JlD0b0aAbRhQ4/RoKVN8cmOWUtWVgMGPqWSlyi9xp5Q1jIX3F3qHIqJMzhYQiGgAUqW6haVHR7syfWKdazY/z0y/210JRC+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864093; c=relaxed/simple;
	bh=mYCw5zFdaYamjNq7yWm1N3ddyHnywTLmXo/dBHAWXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Byr75dfPD5erbsTvWdIY30OSl70bAhEmph1kGfFjsy6fFU2Vx5VxUuhzgqqoAUWoO5Gn221+XWxj38SDFLOK9/2N5i93NozD6jYOu6aqqgF9oB0nQaVHEsJ7K06rSfHiqFNBv/NLtYfegV0JtX/r4SqJacGkjGFHZ4Y6GyI/pwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vohvuk7P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ef0397aeso2353648b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733864091; x=1734468891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=Vohvuk7P53xXIT3G8Hy1oycFWfi25n3lJQgFbuY+uj5/YUa57u+eeUCOQX/03yfCu5
         Pm4JreIVQAude1Mu99zqN5yq3HFiJwxTLi23TOprjkD4WjvpYTjUyjJ+juE2+ztu10EW
         q7wVJ4SQaU2gfLy9iKGxC/7OVPHJ5oP+HBfWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864091; x=1734468891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=WsAWeQ/BQqB8c4/C1ltJNW/vpQ1mXLXcCWJQyQnzFaDSauDgQtPx8WRZA3xsu1NN6E
         mYxjHMa/Ml6CtzFqkZLfBg/qDKN7JbVNBjX7bRZQXSOldzSVty6jElyX9Jpp1qRHQIbh
         CnsuHl8t2T4X2lsf0F+tUfz8JLNxV3sLYrKKfUMhQegr+UE7D3BPUQmEdS6oIc+L6vjb
         7hYSLfifaD1aUquFjqceGXbNybmmlh0Q/kSMcDq5cW5dCRPvFq/xnrNoUP/Hg08yQZWj
         HoEH9b1GaPxsPV1byDPM45GM5rucgAboHk8QSPdQ3wsSOcNLS1+ZwCSk93xSrWRDs9Xq
         6eDA==
X-Forwarded-Encrypted: i=1; AJvYcCWN07lc1V/K4z1g6/uHR0ZdmMu1ZaINHGxWD2utjzpcu+gUQg/tlPJ00EaIXuolD8HuxGTrGzMxxra1cr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVfOO9uQeztdMoSBmWPlArbVNxCSKlja+ahV+JYM60M9nJ0Oi
	qoM9cpsCu3w5zTtNeXz7nB/udrVuiXLOsG29fauor4pxeMTmRK9jsovBiqCTxPYynwnbYqxZx7M
	=
X-Gm-Gg: ASbGnctj7c57rDVGqJZV5D3ahzZmqXTe2/uXnbkB4LKpzrwt2vS8pDU0eHPURoceUJp
	tTYnYwXe0MQOqnKB43Mh6Mhb5D4WW+AUulemcVSwLexfolwYHlFFQWu3RHcnuQ+yi/F/MlqcTCx
	7fdUFa9Ra2W6A7VGZV/PHAMoiI1/hUE4KXuJQ5/fDydXjRdV942oRMkkay+Myx3YpNMo3ytSNfG
	QL+GjhcJoi45ZAwboaHYIoVWqE2gy4oDxijREzCK9xgHoYQWhqOAncat9sMZg/WqMcm7yZaXLuF
	fr9qNU0Uk4f/AywsYjeR
X-Google-Smtp-Source: AGHT+IFpZcFGtzRi9gmx1MfV2urtGHtfLbbPdq7ygfjXfXllm4Wzo+FeOUpWi0B/QheVY3N9UDAvPw==
X-Received: by 2002:a05:6a00:c91:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-728ed0c94e6mr602681b3a.0.1733864091475;
        Tue, 10 Dec 2024 12:54:51 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e9f70dc8sm4822646b3a.64.2024.12.10.12.54.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:54:49 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd5248d663so2056794a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzHwQEr6jDmSB5G51AtTFG0TiZ5kvtkwLPK5djResyDEQxKyOn0rMlMnnNHJGYjxoImeNE+WZCqmCQPA0=@vger.kernel.org
X-Received: by 2002:a17:90b:1847:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2f127e2ad4amr750621a91.0.1733864088749; Tue, 10 Dec 2024
 12:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org> <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
In-Reply-To: <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 21:54:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
X-Gm-Features: AZHOrDnfdIek0WgcOyPHb9bMVRu7gZ-lsusONuIHTchFVSzbluwkZ1W9KCGCwsI
Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:53, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:00PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > dasadsd
>
> Yes?
Leftovers from a squash :)

I will fix it on the next version if needed.
>
> Apart from this,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

