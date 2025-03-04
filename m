Return-Path: <linux-kernel+bounces-543297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B8A4D3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09453ACA6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3F1F540F;
	Tue,  4 Mar 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwru0z9w"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD81F4262
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070320; cv=none; b=SQ5dPFMrQECMAP9yKaQSJxtyuWsFrwC86La65O9ZVjQW8biPVWi2+geoMMgxknwlLCNO2rHTsrnCRWX7J3KPpZvzPvUgW3ClZ+Bg4W/uqpWcyyZa/bpG9+xMPS3/Ut/20/IYCz7WrjhsCbQ5wMn6YWzD7kLrdyeqaitsYn7Fz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070320; c=relaxed/simple;
	bh=UNemzjEolWkVpXd+vHEUDLISnHTvnYzN1kSGKvl6Zds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGcpVwvBTT+3P0wg2IDGL8O6OCSg3gZPCSzAaoZWggmUrTBpKUwi/xLOjSdO5+HaLCllt4VY8J8a0yDyWM7M/JrSsmFpzMhMgHVenfz5MLmohAHtSfV4XNuG8HJWUuQi9Jzz5bGHGVP41Y5BKP1KycKAefRMrBJutk2K2Hifmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwru0z9w; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4d756135so475324866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741070317; x=1741675117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=cwru0z9w6I9kYZLHKjC7ShcjO6Q+m6+8TlfAW59dooRqzfVOsnvZ8nO3TUlXuBdde3
         baONUhoME8sU56p7a8tuM/OQJMoUt6UyFBibY8XuUWOtskjywR4hKBqvNq0mXBPzOCBj
         S4W6ZPC9b6p5IAA0zxVcxZOly4KcJVh8XaJN+NfGGefGGnHwaZ13DHhRdP8Hny5JvG6T
         0lXPEO1BIH8tKvd2jkPaNfwS7hcZ+2EN6NCX6bDc/EMbKbsMbiuxV8lHqEj/cEWkzQMN
         gNNBnsaXDIysx3oz6z14lA+esNgev8AGwyI9oLi18+D2oYbeMZTRDnFhAK30SQj3ItkY
         ikOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070317; x=1741675117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=KjTypIi2r7c4Qb67lEYUSln7yOoGqpl6fLQvwteDg0IpgpT7+81ma4WoM9kV7iSSyk
         cBTOg3k7g337h0eKZ26GJlNqCd+RQpJvB/fzWVyfFZVxEiOIjtIocKTiEDtNCfSly+Wy
         PErisHtHMAsWRux6VIrH1hXkx7VCvUSsNDpDD4ZXnr6vltnDgPhvGpKllb+WqM0WHfHj
         Q79Carr+MqkhxsNknLeyCYtIm6EU2mLf69Pkq7lCOqP/awkiTmY+88KdrXUcKCTamA4O
         sFY3sazC04GlTpKELW0nuCYYQvmjM5xxJy/78zWZ0VTjStzY1zbjfePoaZcHbmL+EK3b
         UNNA==
X-Forwarded-Encrypted: i=1; AJvYcCWpf/8GtDIRZGzm23zqA8EGstI+cg5FxHdTep2u0VOR9Hn97/nToZjxdo3iZ3NXASJySBu5JnNvxU9wjos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEe9v4o36VSY8ZnS6IL+G+0bMOlE9LbwDvVzMk005EvkbRGN9
	W1zAc5xhXnF3/A6Ra2g216Uq1m5MRbVByh1Zj1gIe6MLWJdfprSH8MmX58xtpP4=
X-Gm-Gg: ASbGncvuaq5cpEyXuAT6iHqJ7BkTStyWnOnwh0fRiNiT63HxHqNjMaXQzX1e1UhWa0n
	BeGqbnqoMgwtb1UIuEBW1rhnvA6MFr9AId+n044UmWT9m8OMVVWgydzm5KlsYrcBw4QLiNi2heO
	11nqogAQaA80bEs0rHmiPNDZfICziudHRa8AIImMFCRLM4o6MoshLXQ8WH3pjhkcygNcDew5EE3
	TxIz3qmbJCJJL6FyIrOCIf6RTrBrraTQVI5cHGtfenHa9CagM71+JHHdawzcQfwhiqETbxrcKGY
	UfRZzc8lFlDvXwzcohLzaSgurKf7c7GilbCy/nkpit852jXF2g==
X-Google-Smtp-Source: AGHT+IGe2iwcRIWzldTGCdfW0AwQOIiSjBUeo6MIzBTmW4OuUn9Z0MsTNtF9xRej5K0PMydq88UZNA==
X-Received: by 2002:a17:907:1ca1:b0:abf:6744:5e9c with SMTP id a640c23a62f3a-abf674462f0mr1005575366b.5.1741070317014;
        Mon, 03 Mar 2025 22:38:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1de83fa49sm199356466b.158.2025.03.03.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:38:36 -0800 (PST)
Date: Tue, 4 Mar 2025 09:38:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Message-ID: <b71c4088-4d8b-4613-8af5-e81f32abecf9@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
 <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
 <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D873FT11P5M6.JLH3TCARWATJ@wdc.com>

On Tue, Mar 04, 2025 at 01:34:00AM +0000, Naohiro Aota wrote:
> On Tue Mar 4, 2025 at 5:31 AM JST, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 22 Mar 2023 20:10:09 +0100
> >
> > The label “out” was used to jump to another pointer check despite of
> > the detail in the implementation of the function
> > “relocating_repair_kthread” that it was determined already that
> > a corresponding variable contained a null pointer because of
> > a failed call of the function “btrfs_lookup_block_group”.
> >
> > * Thus use more appropriate labels instead.
> >
> > * Delete a redundant check.
> >
> >
> > This issue was detected by using the Coccinelle software.
> 
> Since this function is local to the zoned feature, could I have "zoned: "
> added to the subject line?
> 
> Other than that, it looks reasonable to me.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> >
> > Fixes: f7ef5287a63d ("btrfs: zoned: relocate block group to repair IO failure in zoned filesystems")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Don't use Fixes tags, if it's not a bug fix.

regards,
dan carpenter


