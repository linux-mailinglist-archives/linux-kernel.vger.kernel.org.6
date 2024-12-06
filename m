Return-Path: <linux-kernel+bounces-435079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204E9E6F55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F078F188277A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FD11F9EAF;
	Fri,  6 Dec 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+DmwXlz"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49161224EA;
	Fri,  6 Dec 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491984; cv=none; b=SA+JWTyVtI5fNFTCksm8n3H0N2w2w00D/oiTmaFFKrSGmV04ssv3ALPMY2sA+Zea6Nej9dEz3mgIEqx5oyndL4ir3IqmBTk+luhIkImEwB11W/yTUbMyN4laqn+c8BOuSYfLZMfy+ApP2F5mQRt/wp+ZwqP4gPt0sLc5UITtkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491984; c=relaxed/simple;
	bh=vLP1tsrLrBn5UbOMsUTvwsyw2ImcPlXlTvJJHcQ03AA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=SquCsVFBsB/VkpNQugzc/dLTgfb/CG9Vlj9g6svumuzY6HeX5ZhF2/WsfUXDWwKteUbrolNk6rIxDCGQxY1/XUJtRPpADfe+pRwjJSzzCbhasXI4sI+XGMz0on+Ta1uL+hwWpk1qdV2ffP3vWeNMNFiGCOqAdEH5zR3hAROfX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+DmwXlz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30037784fceso4807271fa.2;
        Fri, 06 Dec 2024 05:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733491981; x=1734096781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSrFoYGsGUHyZVE4nB9VSg0Tyg06nqGrBpnSKe/0vDQ=;
        b=P+DmwXlz7vgfLv8ZmhNAbX7TbTQKO7exI5VpqDX/Z+AEMIgRhHMiRABfT6FndsxSLh
         JhBSXfw1Rx5B4F0P8bOT7WSOhRUJoh0byCqkL+3H3TgcRsEXsQo5yZ/7G8t0ynkQ2Pd4
         AWGda1B0T7jb2kvxv/ZvVJwcOKcDxk9XLydUdodgoMSftFkLUqXjcgISFfTuH5SJDb2T
         MGGrS1y8r68LUAiDycu/rCNvYbBppjNMDba+Sj0g1O9kw2S3Raj0KSFNqO2j+Aug/rEx
         kWZwf9V4bzsC+kKYYhere0Bre1rUmoxYlSKJFJ/jAGgLQHJGqz9Gs39ZEF8UKrntiOHo
         thGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733491981; x=1734096781;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GSrFoYGsGUHyZVE4nB9VSg0Tyg06nqGrBpnSKe/0vDQ=;
        b=jTrpECgoH2ZofVyrDBDYLMtjim7s8jB/p5IMMRqxFVEgEHs12ZZXSzcABWMa0AqnBy
         h1lUBruEX5Kp/j3nKM1bgKy5av1z3HSBbAmI1fj0g5gD5zEPAnopuloOLQSFGWsVp8cs
         1IwSRcvXqgBbN3u44UTw3DMSgNx+k3p/0j0CLTy521Z0S/UNwJh/lmwQDJrPBci7mP29
         P0UbBc2ev4H0KN/n5zB/pR1CYODmyewRr80zdIMdrQDSxgDZNxxejGdsVA1wvLONaBt+
         FjfPUs9Urwf0/WZhFfcGRSt2UEMGxYCHouoPvZ+xSSaEu/nMA3YaNpvIm5tVpXWwC3Ik
         VR8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8huDsQfaLYIidj4llbAPOpFDPWbCH7lInElnO98BlgEUqFxYDcYiBlaHxhia5b4uRpsWiYqZV72mveGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UPyEqkIrgUU3ZdqvKfIX5JgK6T/p1m31cDGWTdRl1NUJ9hbf
	MiPrsg7n0X+7quvEoDIYMFRts6PoJMUke57R1ndv9eIU+sbXF6BVI7DO3JGp
X-Gm-Gg: ASbGncsVCXEKD+EjC4uKIe0b4TbX8sQB2T9fCZj6e7IwqSWaTrtehiTITB121v+xpFL
	nFGmcHEsrs3w0lOGMHfp6t/iM5YXLjuC9u34pS7upn0R2XLQjkXAkadeTjQe4lZQnLyVOkYctZF
	oaFzqr9XIjzw1EWQSIvxJKRjK7m0tfOdUsza+E/DqCMH0bHaIpdlrhyftwHQDrdx/fKPFu9+fnI
	kOiICsCO6jYV5Rw/y4JGYkdpIDUA2DqH2/CXpvbmgw4X5iC3tI0
X-Google-Smtp-Source: AGHT+IFN6Nih4BPUS9vHqQD9JB0tRflwPG1VssIbKhDZvAyx2rQwUJqNR0m9Anlg6c9QjKZZHtkGjw==
X-Received: by 2002:a05:651c:901:b0:2fb:4b0d:9092 with SMTP id 38308e7fff4ca-3002f89e98dmr14923121fa.1.1733491980769;
        Fri, 06 Dec 2024 05:33:00 -0800 (PST)
Received: from [192.168.0.205] ([45.152.72.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30038254e47sm794911fa.61.2024.12.06.05.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 05:33:00 -0800 (PST)
Message-ID: <33bfcda8-3d3d-46b9-84f0-44e0e9f44230@gmail.com>
Date: Fri, 6 Dec 2024 15:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yura Strilets <yurastr100@gmail.com>
Subject: [REGRESSION][BISECTED] asus-wmi driver fails on my laptop
To: platform-driver-x86@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

After upgrading from 6.11 to 6.12 a bunch of Fn+Fx buttons(touchpad, 
mic, kb backlight, my asus) stopped working and the 
/sys/(...)/asus::kbd_backlight interface is missing, which, considering 
the dmesg, looks like an asus-wmi driver issue.

I've been able to bisect the issue to the commit 
[b012170fed282151f7ba8988a347670c299f5ab3] "platform/x86: asus-wmi: Fix 
thermal profile initialization"

Additionally, here's some maybe-helpful information:
my laptop's model -- ASUS Zenbook UX3402VA
linux distro -- Arch Linux
.config for bisection -- was taken from /proc/config.gz at 6.12.1 arch 
kernel(attached in [1]) and missing options are default
dmesg logs -- The "grep asus" parts of both good and bad scenarios can 
be seen below and full logs are at [2] and [3]

== bad.log ==
[    3.664546] asus_wmi: ASUS WMI generic driver loaded
[    3.713358] asus_wmi: Initialization: 0x1
[    3.714126] asus_wmi: SFUN value: 0x21
[    3.714131] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.757420] asus_wmi: Failed to set throttle thermal policy (retval): 0x0
[    3.757425] asus_wmi: Failed to set default thermal profile
[    3.757429] asus-nb-wmi asus-nb-wmi: probe with driver asus-nb-wmi 
failed with error -5
== end ==

== good.log ==
[    4.557898] asus_wmi: ASUS WMI generic driver loaded
[    4.776587] asus_wmi: Initialization: 0x1
[    4.777253] asus_wmi: SFUN value: 0x21
[    4.777256] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    4.777258] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[    4.805497] input: Asus WMI hotkeys as 
/devices/platform/asus-nb-wmi/input/input15
== end ==

[1] .config - https://pastebin.com/raw/3nDSV8Sm
[2] bad.log - https://pastebin.com/raw/fvR5Sjzt
[3] good.log - https://pastebin.com/raw/EazfLAWA

Thanks,
Yurii

