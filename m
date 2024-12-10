Return-Path: <linux-kernel+bounces-438746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5BA9EA508
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1642188C074
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E355198833;
	Tue, 10 Dec 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjF0Xo3h"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FC7E111;
	Tue, 10 Dec 2024 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797013; cv=none; b=MgZBQztQ6sh8wZVKRIOA5ir1r6Hnn7jnCZmEaUnIlEzA5U9PfmKauEs8CgnJsvSEn7GNJTaN3ObiJJ/OQ5z5IDYiUeiCzFr0xzQD26PiLQLMqCXQlHfXazl7P3kbqp2tViy1sCrsz6bWvl0pY98UdlvhBa2yC33R4k+uw4j67WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797013; c=relaxed/simple;
	bh=MpyU19CYUvKymcfdBVCNc1R/EKRlB///6nfxu5d/sMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx3z7yC0mP8yfpP7wISoJ0GD0INXsmQFotR5242cwXh2pRIarPUekkMJklk4Kgeb4uiaY/otE/dPqgX82hF7JwT8TmgEF50lbYvsweQ98MHW34/y2FXlHrxu2sCYAb7jKAOSLWvfiq0h783COIwC9P5k6wRXyjropnw8qsX6jFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjF0Xo3h; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2804174a12.3;
        Mon, 09 Dec 2024 18:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733797010; x=1734401810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qU/pZlhRQpK/V0MlYplTW5NKgMJyL6UnzD2pzHAPmjA=;
        b=UjF0Xo3hO7kIT/mf8ukPldx4Mouz1eYebKKp2sleGT1Ryc1Ty/5gRWRP0nrt6IwwBV
         KSiLbm3xL8Ruty8s4JFrGncT0P7W6QlneO9/oqA93w98j6Ouy3u4l9JK2VbGovHveL6M
         rHD5xCktoeomcLF9ExQqh5mgHA0mfeSDphB3XknSoV01GrfgUDALqKbzqxvSUHkZgd/t
         KfmKY1WltEt8eOdznJViIp5OTQQKDhQ2Vu2I5FHwVt8LBLPWe4+7xYBmLqkCuu8QfLh3
         Z9rsDkr4GC+3T0Bz6w2O7TI94l+2DUEdUfcMrQYonckQxT1TA73HbBnqkev8ZDGEKy0S
         V7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733797010; x=1734401810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qU/pZlhRQpK/V0MlYplTW5NKgMJyL6UnzD2pzHAPmjA=;
        b=QD6ZfWUGGllbTBKX6Lmib/QS8Qd3dURVsTufr+ThkmVdqIe0AwxuSr0yAvip2vnOB/
         cZHw6/8fWQzLSG9hYroWYkNlUvZ5VOePcCoVlN59e/xFekQeNlBvgxyH094FWlk6eG7s
         85YFS2Kwdpp1jWKC7bpgrqs25CmmMtMIaw6yRsHvxeXq5baQyvJ1qXaelyvw//GkyGH0
         Bedfr9eymzQ098Bl+w0eazRX3Om/Qu1LDxvYdyRhX83buqpRN2qm1LNkugteEVr0aKqL
         tn09L0WD9f44x4VTrbJXSxlo4PzNhPjMdYqOGgb6BSCieIxYTBTDdK1kCA6PELE7K/MZ
         oihQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKPz981jEYCTvgV59+oBwX1gz1uNrVPOGK+mR6o+kAxLYkh6TZly0Hj/mWvwULDsEkWaIXXp3rsirL56Q=@vger.kernel.org, AJvYcCX6Wziey1eEvFcgPBXxihfLfAji7mN+Aik9WEGXZiS+DuPP4dKs50SEYe3grT/HIn76awxjDWANDmWYw6Em+CjjgzgZsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqjyUz67Er+8nCrz6LkUn7/eGciSp6JP+LvE+QvzyneMqBK+o
	b3Q3LLgy4ugtqEAJoDAIUKt4zdBML4NqnRdRvNzQvbXxKXJIXtiaJdRK9A==
X-Gm-Gg: ASbGncvb4SgwbTR2exFderlOYyFebJrmeotayi52N4n1xn6/tyRMtijthdoNqk6pFgd
	QxH0MVAAoTLa3Zy6CwwCC6sJC3MLjfhpCHzCfBuspBlaXOJyy1oPjEe2/k9eo61yu+oicsrLs1e
	66H+k28Hpmplc2mduAwNzH/D2zF+V3bNJNR6Z+KxwAsEti7CaTwv5fn9Mn8VSc2NunlDXY6/4Uc
	ow/Woz2sAH33NsqZW7U1dk/pOK5tQMeAVN8ipEWAoiIAc3+ETkQ0mWasIv9M6YZ3/li7Lw6uIs8
	U2ItuC+OWRZw
X-Google-Smtp-Source: AGHT+IHGyK7TwlMS/V1leqtNDVcpeXtyObAmLKiRnlKy+hdsOfKjXv8WOOoHPei4zsM7DkkjtHh9uw==
X-Received: by 2002:a17:90b:50:b0:2ee:c797:e27f with SMTP id 98e67ed59e1d1-2ef6ab296e5mr19997132a91.36.1733797010216;
        Mon, 09 Dec 2024 18:16:50 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm11657154a91.18.2024.12.09.18.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 18:16:49 -0800 (PST)
Date: Mon, 9 Dec 2024 23:16:46 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] platform/x86: acer-wmi: Ignore AC events
Message-ID: <jxqp276qrzg32zvm4zmyzq6qzru2ex4fbgyogj4ynvetf6j5gp@kxocmd2ky6dv>
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-6-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210001657.3362-6-W_Armin@gmx.de>

On Tue, Dec 10, 2024 at 01:16:57AM +0100, Armin Wolf wrote:
> On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
> AC connect/disconnect. Ignore those events to avoid spamming the
> kernel log with error messages.

I noticed acer_thermal_profile_change() behavior changed whether the
laptop was on AC or not. Maybe users expect some kind of behavior around
thermal profiles with this event? Like switching to low-power when not
on AC or something like that.

~ Kurt

> 
> Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-120c8e7afec8@gmail.com
> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index aad8eb0ddae5..ef26ec8d90ea 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -99,6 +99,7 @@ enum acer_wmi_event_ids {
>  	WMID_HOTKEY_EVENT = 0x1,
>  	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
>  	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
> +	WMID_AC_EVENT = 0x8,
>  };
> 
>  enum acer_wmi_predator_v4_sys_info_command {
> @@ -2304,6 +2305,9 @@ static void acer_wmi_notify(union acpi_object *obj, void *context)
>  		if (return_value.key_num == 0x5 && has_cap(ACER_CAP_PLATFORM_PROFILE))
>  			acer_thermal_profile_change();
>  		break;
> +	case WMID_AC_EVENT:
> +		/* We ignore AC events here */
> +		break;
>  	default:
>  		pr_warn("Unknown function number - %d - %d\n",
>  			return_value.function, return_value.key_num);
> --
> 2.39.5
> 

