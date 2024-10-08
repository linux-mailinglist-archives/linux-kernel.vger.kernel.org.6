Return-Path: <linux-kernel+bounces-355642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84399553D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A031C25400
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A851E0DE2;
	Tue,  8 Oct 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQZHJC5X"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7806F2F3;
	Tue,  8 Oct 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406963; cv=none; b=Ws9CVzZCF7diB5fiVuKjFYY+a6YK4YMe7WqJKVxn5q2r6cG1oF4vmvKcuq6lO9P/WRbHFIkt6Zv16EdXvBXY1LbVPUFKpzUlS/md/WBs0T1pAIBrbrn712Ai0e277kwQ7ksXuvLW+aml3FvlR/3qLcblPpnB04bQceEKWzIhIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406963; c=relaxed/simple;
	bh=sMbNsoCJrjOwNF0YWvFzRa1qE1wyTBhsxmOAUFS8/fM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nfXyvDZmRaWwqBsvOdkHZ7Fi1R3ubZhNZ+vIGnWTs+6ALU3LV5XDpyMrIVZ9cD3gh0mFcI2Rf5vdGiZhLTiD84A8iBMOxU78zp82GslaVWkGCYGjsTPL0z1WsCNvIoqSUPwwbr1VvDE0dwG870pFFq0AvPtTpX1cwqr3cVZ/8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQZHJC5X; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so680137966b.0;
        Tue, 08 Oct 2024 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728406960; x=1729011760; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH6Q+86lLIPQsPYsHY5BtMivrSzj8a09vJ6dNtdDv1s=;
        b=aQZHJC5XIJgl70SCF758rTY2xT/IapzrivQldtR1Gh4+rfWZR46RiIaSZlp1yQm8aL
         B0IQAxsgtDmaRIWPx4zzO0w/GMTBBVFOKYYy7QSCGKq1nuNcMsCNJQVMZsl4FjScsF5Y
         fZYB2RwcNfGRsgVmoDA13a2ALrdPKwG60SWJE6nEFh1RdznIpVh326JGNRQI7FzWE6qi
         Xay4gEOv8cjZiFyLZxrKmDq9tssBR7K5Ta+RS20YUC6S2Yjk7A2EcW6Xdmi4v7PiQeIM
         GamDoCd+mdJwvQEKiVjfzB16hyvRC25gqKIURBMG9TsH6u1YQa6tsiWo80cBdvuVyrHQ
         IOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728406960; x=1729011760;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fH6Q+86lLIPQsPYsHY5BtMivrSzj8a09vJ6dNtdDv1s=;
        b=Ho203injxEqQgtHG2tPGRFQvo+/mKCb8r00Wez7rRO5e2QXfoePeaWHNK/HiGEAI/W
         2ZiNVup5vXfJz7/F0uAAQhfdQbl/Sz8MSiyrd2rsGCjzlzr1beW1zOx69LabKNvHjpNu
         nXKtJbQblw5cge5wDxbVX6pCLgAmVkKaYNGp1iSHyCFhcOfd7qMRnVjZd8PUbgTx/OVt
         KGnXrMY5ZjRvCyBluas2n0GWINh/EmbfwZb68dAmGLKdTgMXQ013V+mNJcRvm12silDI
         OgCLi565samcyNb9M3NRgQHmhEK3UPva6jeHWMUHZwnIv/AwJ3uTZgZfhfSFQW1s7Je5
         xn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWJcFYa2wUxLgKnkeJHT+zBz7ak8BGOcQlA4IfrUmnUvfUgQD/y0xrSduMM9vBKJdMeK2RX/8UR0khvKhg=@vger.kernel.org, AJvYcCXgHEk+1gwqrXp5OmUo3W+oPvdHH2PPV0/OPmTqQJZ3ToCO6uz7Fk8oj1Vj6wTZGn48HWkYNg4i4U1YoI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChu9TpB2kXXuPiFKJYAy09d8k+r9Mi/bc1c6/UgYbI0NxGsEq
	1dtQJsJsfqoZPVN088v537baHaxowt1J+oAeuu7lKPjg7d/5Tz4DgxS5Bw==
X-Google-Smtp-Source: AGHT+IFQrL6WPapulu3Wh3pTUUGiA9lYvQ+jaBWiSMotTWC9FnG/h70fI58S0W4VNXMe9Y7uBJN+aA==
X-Received: by 2002:a17:907:97c6:b0:a99:61f2:49eb with SMTP id a640c23a62f3a-a9961f2967amr478404266b.42.1728406959493;
        Tue, 08 Oct 2024 10:02:39 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a993c1b353dsm473226366b.35.2024.10.08.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:02:38 -0700 (PDT)
Message-ID: <d4ff08fa-199d-4114-bae1-fd36f6a9313c@gmail.com>
Date: Tue, 8 Oct 2024 18:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jack Yu <jack.yu@realtek.com>, linux-sound@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: ASoC: rt721-sdca: Add RT721 SDCA driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jack,

With respect to the recent commit in linux-next:

commit 86ce355c1f9ab943bbe099ea7d0b8a3af2247f65
Author: Jack Yu <jack.yu@realtek.com>
Date:   Tue Oct 1 09:17:38 2024 +0000

     ASoC: rt721-sdca: Add RT721 SDCA driver


I'm flagging up an issue in function rt721_sdca_dmic_set_gain_get there 
are a bunch of nested if statements as follows:

                 if (!adc_vol_flag) /* boost gain */
                         ctl = regvalue / boost_step;
                 else { /* ADC gain */
                         if (adc_vol_flag)
                                 ctl = p->max - (((vol_max - regvalue) & 
0xffff) / interval_offset);
                         else
                                 ctl = p->max - (((0 - regvalue) & 
0xffff) / interval_offset);
                 }

The last else statement ctl = p->max - (((0 - regvalue) & 0xffff) / 
interval_offset) is redundant, since this is the !adc_vol_flag checked 
for in the first boost gain if clause.

Colin


