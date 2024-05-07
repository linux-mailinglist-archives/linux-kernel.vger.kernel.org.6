Return-Path: <linux-kernel+bounces-170858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC498BDD05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6F7B211D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8C813C8F7;
	Tue,  7 May 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z56JTiuB"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F73530
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069777; cv=none; b=m9TqDC/I4GU0/TUbfyOjngjRsvlhRbvRZO+PQ57OSdvwaQpRZwPIPcJndO2xFNU7i4JvwAU17+gA3SeKb/6/DY2N3skkawyHuG5KukLDD79AKbcuXgHvyr7IMc/xrdOqTx7Z+4lFzG7cmzE8Q/7lAQg2fDAXlAe6G59PcInSvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069777; c=relaxed/simple;
	bh=2+y64KNlfoCsF/eTA3qhiajZ6xhZj0/yNaz4WIzLHRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IRQtQFmyfjezfcQdvXYd0ZKXD3mrM/8jhbk6TsajPjzjf0aJ3IiJ8ulzt7FEvGkojzlPz7vAoi9OCSyP51URICAiYlhXfL2chw4HJLif6giLRa+dpbGFBUFNviu50OVYr7Zl/wxx6Y5nFTn0Cs2fFwKbSETfzz91Too15ewtXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z56JTiuB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34e663aa217so2186657f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715069773; x=1715674573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5t5Ex3m1EQ6i6GNox3M/TDaitl0owauxMfmQZyI69Cg=;
        b=Z56JTiuB+QFXq/gyYD9zyl696GXZmThals3rtjUVUELvlGtT/fdVdt6M07BYCO3KYs
         7HK7QLu4Q5grMolW1S9hm1A1E74lQRc0FsVghOqeK6IQ+D7M14umtn9sREcB+2/8NuX7
         /TVApXI0u+1040ARGNXHltMyJ9IcjikHhHzuXSBYNn181OuDap2pTcCLBxxrv77Gc8jf
         BEdE80AiUY59RElTGI3P4uPtkl2zhn8ttwDziy1cSFoaIJJOy3GwREzpW3WTiwC3BIj8
         RepKsIOQ5GAHX4n9o8UDKV7BNfEYGqOUH1DJyIdslbZ+Ul8/FcLGML67t6T5yJRyVzT/
         pGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069773; x=1715674573;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t5Ex3m1EQ6i6GNox3M/TDaitl0owauxMfmQZyI69Cg=;
        b=b7UQd7ys/1zDA3pSL4j6kAoC1E4tvL3JOiRnxmihck2udDpJ8PqzNJbWBX6PXh0oy1
         mVbnHQkwbbmWNjb5owBXBH/SGAom3n8uB56QQ7JsR3XVwFzMD572ZHmyA0x73PCiil2I
         HLYx4MVJaGS9s7q/aNL4NjiGylTTevvC5nccOpfeU80no9G8gzR3hl3DwY48WWWmKDPz
         OwUvStrr5t8dmOeeTA4TDkeQ2rBrngjBLQbhsgJQCxzVFIJQi3afPwKloBJbWz14TrLh
         j4SO+6wFWF05o+u5ZbRhmeukO2dgBan1ruWf9Krq8t3YAmfr5FFUXyuAtkaiHeBYxV6H
         GAlw==
X-Gm-Message-State: AOJu0YypHiOszEzkoWELTVxqiITxwIO7JJs0y52HLniXYO9BZ3SDtoZw
	7+9f9r6InxyPftB/h/TK+eKv5E1Ov9N/pSmk3pDW/vmJSvenSqY9EprU1SgN6ZY=
X-Google-Smtp-Source: AGHT+IEpUA4cqxmGgkDKa//PHTAzrHuZJT0OjTd7fUBCCEX0BhVaON+3vxbkZLf0uAV0uuPXmCDUwg==
X-Received: by 2002:a05:6000:e4d:b0:34a:e884:fd71 with SMTP id dy13-20020a0560000e4d00b0034ae884fd71mr7916638wrb.29.1715069773121;
        Tue, 07 May 2024 01:16:13 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76? ([2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d658f000000b0034ddf05a3e6sm12427966wru.76.2024.05.07.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:16:12 -0700 (PDT)
Message-ID: <5305f69bd74d4d4ecff518b42287fbc4b9204918.camel@suse.com>
Subject: Re: [PATCH] firmware: dmi: Add info message for number of populated
 and total memory slots
From: Jean DELVARE <jdelvare@suse.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 07 May 2024 10:16:11 +0200
In-Reply-To: <b1d69d07-14a9-4f10-9155-a0a46d8ea872@gmail.com>
References: <b1d69d07-14a9-4f10-9155-a0a46d8ea872@gmail.com>
Organization: SUSE Linux
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Heiner,

On Tue, 2024-03-05 at 21:55 +0100, Heiner Kallweit wrote:
> As part of adding support for calling i2c_register_spd() on muxed SMBUS
> segments the same message has been removed from i2c_register_spd().
> However users may find it useful, therefore reintroduce it as part of
> the DMI scan code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/firmware/dmi_scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 015c95a82..2c682b580 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -42,6 +42,7 @@ static struct dmi_memdev_info {
>         u8 type;                /* DDR2, DDR3, DDR4 etc */
>  } *dmi_memdev;
>  static int dmi_memdev_nr;
> +static int dmi_memdev_populated_nr;
>  
>  static const char * __init dmi_string_nosave(const struct dmi_header *dm, u8 s)
>  {
> @@ -448,6 +449,9 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>         else
>                 bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
>  
> +       if (bytes)
> +               dmi_memdev_populated_nr++;
> +
>         dmi_memdev[nr].size = bytes;
>         nr++;
>  }
> @@ -824,6 +828,8 @@ void __init dmi_setup(void)
>                 return;
>  
>         dmi_memdev_walk();
> +       pr_info("DMI: Memory slots populated: %d/%d\n",
> +               dmi_memdev_populated_nr, dmi_memdev_nr);
>         dump_stack_set_arch_desc("%s", dmi_ids_string);
>  }
>  

Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support

