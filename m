Return-Path: <linux-kernel+bounces-544124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4144A4DDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DFD1783A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05E202C5C;
	Tue,  4 Mar 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="EYBR6H7i"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B84202995
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090545; cv=none; b=JofYhQ3IHDeb+vCpNR2C8DblK7K8cdBHdQsqSvmYnXICMReJldg+8c7ANbv+RPxFn9c76t5Yi3LUSrBCf70cUC+dy75sZpLOOyLUun9NEufOpng4SqM1adGRwJJJo8CO2RDJ+mDMIZ+QIRSNrvhJtqOfOWpuOrqX1wS5SsNaQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090545; c=relaxed/simple;
	bh=Nj4FPZHzEl6xsYkXGNcRLor6LN011VUsRJstKGMx8VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXMphnOpG5TYbMKjekuewfPRZftMhwJyjqjpAQHlLM7RmAIT8v0cnhrIk4K5dVjyXMbHxF7MZPKSqZ0J03x/fVX8ro/wDKa7o8A10gValQaus/9h0dsKvx2Kw5APQ+RffP89FLkRrNvNcGItTb9bpHuf/vzfuXrfY+rztgxg8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=EYBR6H7i; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e60b04fc3edso4006049276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1741090542; x=1741695342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bPRnq61CWSrP85InozFgg3mhnxsf6EyWZ0fdIK59Yo=;
        b=EYBR6H7imi5t/orWhnTZdMEbhCITb9tXaysh2407q3QkUI0PjNhUSkrEdQGEsJZyAY
         QH4PRICwVakCnjTX2I7wkqjWcUPp/2gugUheiMkYxI2109JZkw7k5/93/ocPCHMdTckm
         np2lV9IJpuYB3fPCL2UkB5nAEcLB+F6AnvrApiP1n0hV0jF2JeOVcmESwWVcyCo+syIX
         720/DmiKI+d/pxuIZAZgfkWtmgROcs7cilL1nPUR8LthMZ1xXIgvdMn2EV7esfqnHB7x
         3ktdMkFd3QkK691vAI6A7Q9zUtSGfbRKvn/Znp/z797KfzpGpgDUQRgwkFn7WPNw/qRV
         IqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741090542; x=1741695342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bPRnq61CWSrP85InozFgg3mhnxsf6EyWZ0fdIK59Yo=;
        b=GkLJSEGWZ1I2dBN8XCq6qyVAUYTsiEsKUjjLIt3RsaEmDURWWkgFj9JnJ/+iWc9DtX
         MyS+70EykJEIRV+bFVqWs2gcAVuAC9EfEhhnTQQgZ0nNmjJ20l5nZni58Q0WsgORVhhD
         n3MXUTfnPkj7dU9l0PgrbO6pECFep+48zsDhMZwN8l1+cx3RWcOKEILbQ3OxmrDsVFyP
         B5eSWolsLaTcjFbZGzV2XVoUGXj9gXZJ1+8Djgy8EqdPg9zIvDqL0p0Y8GpwI51duVoG
         K8rBE1KfTQdr0ggfwnv5SITlVez/ozrk4TsCzBflC8anN3MRURuEm9zVGxSJDXs9s6jM
         OJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxnsoZgVjgOGAWbmFc140dNWFZKbJ/nebOLWGTVn8WXMM8Zft8JYBCBCYfbrEQda27PQzP7To3lSKcDhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwrHl/d6UtZaoBOn9w0LSYJuYLQ9QkN6/k+cwPjnixYnTN5kqF
	057YTaLxWEuqCqdNEDPJkpQ83aHi9tVrIGxtKIP0Ku1swpTM/fL/OTid1yRCDj9AVl5BcZYfu1D
	ChFzXFISf8j/b7AsswZgyQ5kvhbXHJGyC4tUt1kdSOm3KvPnZ
X-Gm-Gg: ASbGncuZdNK28dsw2VvRlHeQI/oeI3XLVn8yCMz5h7OT/NlbY4+QQdk1+TKO0dHhHMg
	e4n9T9Xn5RiOEOd0UWkDc8vC+BVHIOZgfhMns4+M6AUNqEXTOu7+wg12h7ILUey2zwH1a+Wjmvs
	oqsfusK4rjVr1jzg0Wte8XXVYj2HYifYu2AGvzXifZrUGgmWRqN6VAhvw41Q==
X-Google-Smtp-Source: AGHT+IEh9hfGK0IFpNi6SULkZRaGWEAgiLYt1ZFfR4jvQMNQ3LnsNn2VfkB+ZoyFtoMcP/VMwoDzemKKAexqQBexVB0=
X-Received: by 2002:a05:690c:6001:b0:6fb:a467:bff4 with SMTP id
 00721157ae682-6fd4a0c3cf9mr225156407b3.24.1741090542229; Tue, 04 Mar 2025
 04:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-ov9282-flash-strobe-v1-0-0fd57a1564ba@linux.dev> <20250303-ov9282-flash-strobe-v1-1-0fd57a1564ba@linux.dev>
In-Reply-To: <20250303-ov9282-flash-strobe-v1-1-0fd57a1564ba@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 4 Mar 2025 12:15:24 +0000
X-Gm-Features: AQ5f1Jo6zEJjxFrCNLGCt-nqKrT_2K2gYvxCVzxLGfGCGbgSNtO34yt_dHNDSTU
Message-ID: <CAPY8ntCE8EypwNU1dbd_2vA_jS7niAApvJdDjk-gPaaS7rNkvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: i2c: ov9282: add output enable register definitions
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Richard

On Mon, 3 Mar 2025 at 22:59, Richard Leitner <richard.leitner@linux.dev> wrote:
>
> Add #define's for the output enable registers (0x3004, 0x3005, 0x3006),
> also known as SC_CTRL_04, SC_CTRL_05, SC_CTRL_04. Use those register
> definitions instead of the raw values in the `common_regs` struct.
>
> All values are based on the OV9281 datasheet v1.53 (january 2019).
>
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/ov9282.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index c882a021cf18852237bf9b9524d3de0c5b48cbcb..f42e0d439753e74d14e3a3592029e48f49234927 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -37,6 +37,29 @@
>  #define OV9282_REG_ID          0x300a
>  #define OV9282_ID              0x9281
>
> +/* Output enable registers */
> +#define OV9282_REG_OUTPUT_ENABLE4      0x3004
> +#define OV9282_OUTPUT_ENABLE4_GPIO2    BIT(1)
> +#define OV9282_OUTPUT_ENABLE4_D9       BIT(0)
> +
> +#define OV9282_REG_OUTPUT_ENABLE5      0x3005
> +#define OV9282_OUTPUT_ENABLE5_D8       BIT(7)
> +#define OV9282_OUTPUT_ENABLE5_D7       BIT(6)
> +#define OV9282_OUTPUT_ENABLE5_D6       BIT(5)
> +#define OV9282_OUTPUT_ENABLE5_D5       BIT(4)
> +#define OV9282_OUTPUT_ENABLE5_D4       BIT(3)
> +#define OV9282_OUTPUT_ENABLE5_D3       BIT(2)
> +#define OV9282_OUTPUT_ENABLE5_D2       BIT(1)
> +#define OV9282_OUTPUT_ENABLE5_D1       BIT(0)
> +
> +#define OV9282_REG_OUTPUT_ENABLE6      0x3006
> +#define OV9282_OUTPUT_ENABLE6_D0       BIT(7)
> +#define OV9282_OUTPUT_ENABLE6_PCLK     BIT(6)
> +#define OV9282_OUTPUT_ENABLE6_HREF     BIT(5)
> +#define OV9282_OUTPUT_ENABLE6_STROBE   BIT(3)
> +#define OV9282_OUTPUT_ENABLE6_ILPWM    BIT(2)
> +#define OV9282_OUTPUT_ENABLE6_VSYNC    BIT(1)
> +
>  /* Exposure control */
>  #define OV9282_REG_EXPOSURE    0x3500
>  #define OV9282_EXPOSURE_MIN    1
> @@ -213,9 +236,9 @@ static const struct ov9282_reg common_regs[] = {
>         {0x0302, 0x32},
>         {0x030e, 0x02},
>         {0x3001, 0x00},
> -       {0x3004, 0x00},
> -       {0x3005, 0x00},
> -       {0x3006, 0x04},
> +       {OV9282_REG_OUTPUT_ENABLE4, 0x00},
> +       {OV9282_REG_OUTPUT_ENABLE5, 0x00},
> +       {OV9282_REG_OUTPUT_ENABLE6, OV9282_OUTPUT_ENABLE6_ILPWM},
>         {0x3011, 0x0a},
>         {0x3013, 0x18},
>         {0x301c, 0xf0},
>
> --
> 2.47.2
>
>

