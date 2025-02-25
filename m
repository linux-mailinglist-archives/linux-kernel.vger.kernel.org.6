Return-Path: <linux-kernel+bounces-531314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03FA43EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EC31889583
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E718267B1A;
	Tue, 25 Feb 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O0bl42Jf"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACC267738
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485312; cv=none; b=tbOnWdkw8gQ1DyksjFEkj81X/dQImLhQKzQ7XMKZC4jXJ28Ir0W0ZaKIFTY7Fa/XR3vpZMIEy66e6aoQIv5SmuC0pvXsWaXokYbe0jxx7NGzCBY+Yp09EzawcdPiR0XHxnCaPfzIO1ChTow6qLe9Y7CtnqWAbzRJWxJKbU1x7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485312; c=relaxed/simple;
	bh=Q9LTud62PiNP68Npcecb+Y8o1+UPT1AVOMCQPZBgGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdYCtrv+Fws9srt5VOCXGhB0gOnNQrhq2sTYZtJWuNfYtuOO5TJ+PeGJ9SPJ0U65w0PEHefGD75kFzM38yxR+BKoSHl6lhLImQzeyru7evB8JRengwqDaA2C3e3k+uRLkU168jH1Ky97BQilP1ca84z0gsIiasgOSALuLGzO70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O0bl42Jf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso7791266a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740485307; x=1741090107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSFcV+r5E4WxO2+xTlVlzsifVYmK0gkUHuM2wDK2xfs=;
        b=O0bl42JfY9iW9MVVQmivUg+zLcrBvsDb1fxDe857MejbJOhKV++ywxFzxdGE5zAWS5
         gzsaR+V9C+DnsxbwKuryVhd0Tl9f6rJyv50w8HY/Wt1b/VLiuJAMB70b71+sJNUypyWe
         I0TgZUbKv4FfJxop1eTMAKrJ0T/vvwqlg8efNcDcXRtHSS7HCMFlxHE3Y7ftRSOnePhF
         LQACcCDB+q8TFXvb0HQHUbtSBD4U4QWLcjsrgSJMmK1TnW5Tg0nUQH7PizlFwoOxvjTh
         P+GnZyrCGT4CQemAhPQHglyZgG2S0qsSdWIbFuY87BlFpVuZ8C5NfjCu79cKcWoGR4nS
         zE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485307; x=1741090107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSFcV+r5E4WxO2+xTlVlzsifVYmK0gkUHuM2wDK2xfs=;
        b=ONbU0NNfilryXGXYXWuAhn6ueiC4jzEjmPIGcSENdY12VgcdLWc/jRRjl87ZUTJB5T
         Ca9FOtVy/ZW0+/M+S70YIQdii8H2eq+9beAK1MvA5Fy0FUlkqjs7NLcYEHIS9ZrRhybi
         s4iRD6PlJvP1YZ3RLytZbwSrw+HYSmWeiywtDEBxHX+evQbOU/rH5odprIrAERJAuiN9
         xiHR+r+aHjf877cQg99SY7O3ZKkYxH0ghh48qSa0pxRaKOXyvLYS14iCElDxljgr9O07
         GyqORBHa6pnNiqGOA/e6IKBe0MK9wOm5YtMh4PxzQHPff8TQnrOoRbyMF86hIcrTd1zz
         oxig==
X-Forwarded-Encrypted: i=1; AJvYcCXXBckuh0bfHguHUACE5o89x6+hNhiweouHKvQpXJayChSe9rqS/j9XfkLchdUotFRHaXkJZEeR4B0FPcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6Q6CKbN76/HsC+b59ghBdhvNSBw5AFG/nXU4rKBJlYdmLuzp
	JnjTJdOkUiTYAaSoQW6a2P72W3bwLJHMX3rBCVaLqy0AeorfbxXdixPErgQx1Jk=
X-Gm-Gg: ASbGncujOQkkWIoCtafmtiKZYqHCSRql0R2SCHyI3kDIoGTPx+AD+7+Yi8TReCydyRx
	6QN7OheL8upaqUwZY2EiBUEnQ81HRacnKZOT4XKZnKWlGS7p1wsEfdnTHr4sHnHAG4JgIv5gKXx
	Hook2EEwVSwoeG2himvJFhGqQvAzFs5MCHdJNXwfTTG8H+8SkMNjaJYlv0CUqBj53vGglJVLme8
	CuhLtgwt+0oBYT76PrUYp4jwCUGy6Xke9ecI0YVns7A5pzYgjHfrAcRCpuqVG9TVsGgdgWk5dO4
	RSVfcihA8urHQVxjV/EZJZ5973uj8/RuNnDgIWCVk1u3aYV2BiG9fKCQtl3BRpukPQIbCk3wzuQ
	QxKqc5MWJywv2m2k=
X-Google-Smtp-Source: AGHT+IH3gdzX3PeChiwCGAsoV3Kg3a9bzz9OmkI9aT6t+gpVTMMM2ymgKcITTcD1763s9dbf6zqhuA==
X-Received: by 2002:a17:907:9686:b0:ab7:d7fd:6250 with SMTP id a640c23a62f3a-abed1015488mr297536566b.43.1740485306884;
        Tue, 25 Feb 2025 04:08:26 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com (194-212-255-194.customers.tmcz.cz. [194.212.255.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2057276sm131230566b.142.2025.02.25.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:08:26 -0800 (PST)
Date: Tue, 25 Feb 2025 13:08:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Message-ID: <txrxpe7tmpsyiu4cwjd2gbs3udogmzdo5ertjwmhbeynu23iep@dcryfdoi7o5x>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
 <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
 <CANeGvZVoy20axVTOd4L=d0rwgMWvH_TJqV6ip=_TaDNPJVEqkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANeGvZVoy20axVTOd4L=d0rwgMWvH_TJqV6ip=_TaDNPJVEqkQ@mail.gmail.com>

Mon, Feb 24, 2025 at 05:47:04PM +0100, jiashengjiangcool@gmail.com wrote:
>Hi Jiri,
>
>On Mon, Feb 24, 2025 at 7:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wrote:
>> >Hi Jiasheng, many thanks for the patch!
>> >
>> >>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> >>Sent: Sunday, February 23, 2025 9:17 PM
>> >>
>> >>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>> >>dst->freq_supported is equal to src->freq_supported.
>> >>In this case, if the subsequent kstrdup() fails, src->freq_supported may
>> >
>> >The src->freq_supported is not being freed in this function,
>> >you ment dst->freq_supported?
>> >But also it is not true.
>> >dst->freq_supported is being freed already, this patch adds only additional
>> >condition over it..
>> >From kfree doc: "If @object is NULL, no operation is performed.".
>> >
>> >>be freed without being set to NULL, potentially leading to a
>> >>use-after-free or double-free error.
>> >>
>> >
>> >kfree does not set to NULL from what I know. How would it lead to
>> >use-after-free/double-free?
>> >Why the one would use the memory after the function returns -ENOMEM?
>> >
>> >I don't think this patch is needed or resolves anything.
>>
>> I'm sure it's not needed.
>>
>
>After "memcpy(dst, src, sizeof(*dst))", dst->freq_supported will point
>to the same memory as src->freq_supported.
>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>dst->freq_supported still points to the same memory as src->freq_supported.
>Then, if the subsequent kstrdup() fails, dst->freq_supported is freed,
>and src->freq_supported becomes a Dangling Pointer,
>potentially leading to a use-after-free or double-free error.

Okay. This condition should not happen, driver is broken in that case.
Better add an assertion for it.


>
>-Jiasheng
>
>> >
>> >Thank you!
>> >Arkadiusz
>> >
>> >>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>> >>Cc: <stable@vger.kernel.org> # v6.8+
>> >>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> >>---
>> >> drivers/dpll/dpll_core.c | 3 ++-
>> >> 1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> >>index 32019dc33cca..7d147adf8455 100644
>> >>--- a/drivers/dpll/dpll_core.c
>> >>+++ b/drivers/dpll/dpll_core.c
>> >>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>> >>dpll_pin_properties *src,
>> >> err_panel_label:
>> >>      kfree(dst->board_label);
>> >> err_board_label:
>> >>-     kfree(dst->freq_supported);
>> >>+     if (src->freq_supported_num)
>> >>+             kfree(dst->freq_supported);
>> >>      return -ENOMEM;
>> >> }
>> >>
>> >>--
>> >>2.25.1
>> >

