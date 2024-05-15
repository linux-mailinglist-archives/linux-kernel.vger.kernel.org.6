Return-Path: <linux-kernel+bounces-180316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4C8C6CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F711F21F18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B915AAD5;
	Wed, 15 May 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEulcoZP"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2473219F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801225; cv=none; b=T9Zijwcumn+8/BiXxsQEZbqaV2gfderT/Xl4KQO6qaCHbk1dE3F8qGcGkZEhG0yBWdlve6YqD7bJMSTVjlNcP6nNRFeaHz2rggL4SxfAvjlQuAwPF0983lsHkXC6FNupwI8B5Dgh3vfqbzVHns0BwH2Hje9wsDlBeBP/TireZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801225; c=relaxed/simple;
	bh=OXpojmQlRwzaYm12qng9p5GOA5dbl4fRkAxLUVuGpj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gv+ZbirHkLiLv3bIlr/VVT+hpNI+iaCohfSJbJ031EysT7ItcUq3J3nqVpDbyHanKx+YQzx0YrN4Uy2HUQXOcHPOW9t0jp//GVkJ/ARqbEqWu9XOo2qkMhcKA/RBv8QmTFUpqyRHvgZz4S9Nk+uOepBey0g5UZAfkwft9CJg1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEulcoZP; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f8df927790so2406626241.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715801222; x=1716406022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U24rj1LtXAZgNzKO70sKfJcotZtTB153GdIBMBfKLOQ=;
        b=BEulcoZPh1LTx156BR266Xg5PnXa5HYF7AtZf8Rb5uBfZCoSHCjbR32WH9sbf8S74y
         OPsitkoIutFtF7YaZBEeKlBZUfxy/cmV/x5D+v6++Cd2JW2lU0Q9tkalcPmteppU1JUt
         QQbqUNsUNmOkRdHO+QzuVazDBZYdx62DidqDojlP9rQO3jB1q771INle+PD4SgP9aTKN
         EICe0GjfSgbUtXldX46WsKwaxs1OkbnYfMoWdSfSXZK6P0HVREBDeToaxp5c2fq7OhGI
         dvn0ebmnHEEvoElMbEOmRyjY7jsLJS04n7eXB23Ynhn5fgZnZFJNc0zNc1VCtiaz7L/s
         ccCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801222; x=1716406022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U24rj1LtXAZgNzKO70sKfJcotZtTB153GdIBMBfKLOQ=;
        b=dlhsD1dFgE4E75bgnLTZ9QCMS5M/+X3gtkO2T2nXiT2Byz37mil705xVFNWuylkt9b
         j6Yau9DB0exmTbiXtlQXBEVolMdLU8As+sO8B6jn+4j9QVkoG2br5PzUoxd27tjAnDiv
         C92I60F3fxEy9npz0l4nVtGfwGNYBJp0VVVg77sCU23Kwgbn1IpA7yi12IDhm7Oy+0qG
         LPhOzSSFbIqqWSW9CZWSFiP/hW7TSFzzk/WsNgiUqlBdvQ2TFcOMWYkjYFqcMX5TdNU5
         uLEgKPR5Nf5cze/QoQVaUNZ8FvMshDbliKdoLHoDdLjDQwZntMJ2JzAYuvoQvaw5W3+8
         SMDQ==
X-Gm-Message-State: AOJu0YzZDi/6QM8F+1hrBOtYz69fc6GRz4JpnPFJvDuf6dnKV1ZRza7Z
	uYpOj2sYZwOtWCB50uorFNy4YBGMt8Y+Uepomkk8mLSmW9lUqpIX
X-Google-Smtp-Source: AGHT+IFCIU47TfCgxYirl7KkQaEpNvhi3tPYF8xRB/qX8obZ4UlYoaN2Mp0Yb76cvEKCLsNpsalawA==
X-Received: by 2002:a05:6122:31aa:b0:4d4:1551:6ef6 with SMTP id 71dfb90a1353d-4df8827ffacmr15222044e0c.2.1715801221120;
        Wed, 15 May 2024 12:27:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6a15f194d2esm66355336d6.68.2024.05.15.12.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:27:00 -0700 (PDT)
Message-ID: <cb0f929b-75aa-4ff6-98dc-217b34421e5a@gmail.com>
Date: Wed, 15 May 2024 12:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, OlteanV@gmail.com
References: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
 <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
 <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
 <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
 <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>
 <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
 <CAHx5RXC44V-qsN9QiuhKrDdGZ4ppXpT_cQz3XNAa2aQnf7Pe5Q@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAHx5RXC44V-qsN9QiuhKrDdGZ4ppXpT_cQz3XNAa2aQnf7Pe5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/24 02:23, Stephen Langstaff wrote:
> On Tue, May 14, 2024 at 5:17 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Tue, May 14, 2024 at 05:08:24PM +0100, Stephen Langstaff wrote:
>>> If I sorted out building the dsa_loop_bdinfo.c code as a built-in do
>>> you think that would solve the ordering issue?
>>
>> Probably.
> 
> Well, some minor progress... when dsa_loop and dsa_loop_bdinfo are
> built-in to the kernel then it appears that, at least for this
> configuration, the driver probe function is called:
> 
> [    0.053068] dsa_loop_bdinfo_init
> [    1.509255] dsa_loop_init
> [    1.513178] dsa_loop_drv_probe
> [    2.633673] dsa_loop_drv_probe
> ...
> [    3.273496] dsa_loop_drv_probe
> [    3.276589] dsa_loop_get_protocol
> [    3.281608] dsa-loop fixed-0:1f: skipping link registration for CPU port 5
> [    3.288558]  (null): phylink: error: empty supported_interfaces
> [    3.294500] error creating PHYLINK: -22
> [    3.298343] dsa-loop fixed-0:1f lan1 (uninitialized): error -22
> setting up PHY for tree 0, switch 0, port 0
> [    3.308145]  (null): phylink: error: empty supported_interfaces
> [    3.314070] error creating PHYLINK: -22
> [    3.317907] dsa-loop fixed-0:1f lan2 (uninitialized): error -22
> setting up PHY for tree 0, switch 0, port 1
> [    3.327677]  (null): phylink: error: empty supported_interfaces
> [    3.333609] error creating PHYLINK: -22
> [    3.337449] dsa-loop fixed-0:1f lan3 (uninitialized): error -22
> setting up PHY for tree 0, switch 0, port 2
> [    3.347223]  (null): phylink: error: empty supported_interfaces
> [    3.353145] error creating PHYLINK: -22
> [    3.356983] dsa-loop fixed-0:1f lan4 (uninitialized): error -22
> setting up PHY for tree 0, switch 0, port 3
> [    3.366855] device eth0 entered promiscuous mode
> [    3.371497] DSA: tree 0 setup
> [    3.374474] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f
> 
> The -22 error appears to be related to the issues mentioned here:
> https://www.spinics.net/lists/netdev/msg922961.html so I will now try
> to apply the suggested short-term fix.

What changes have you done to the dsa_loop.c file for this error to show 
up? Currently the driver does the following:

static void dsa_loop_phylink_get_caps(struct dsa_switch *dsa, int port,
                                         struct phylink_config *config)
   {
           bitmap_fill(config->supported_interfaces, 
PHY_INTERFACE_MODE_MAX);
           __clear_bit(PHY_INTERFACE_MODE_NA, config->supported_interfaces);
           config->mac_capabilities = ~0;
   }

which is basically to say: I support everything, except 
PHY_INTERFACE_MDOE_NA.
-- 
Florian


