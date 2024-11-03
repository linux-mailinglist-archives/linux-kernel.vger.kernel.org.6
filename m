Return-Path: <linux-kernel+bounces-393852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20749BA653
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC7D28143F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F9180021;
	Sun,  3 Nov 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In27ywX1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D3171E6E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646652; cv=none; b=EkXX8jjalCFYlYRlcM/xWhBOoCdtM5XFZQCsRGkaT8JGoZ7D1U8lxsQ7MKBZ6fJu3pzBA45JjLJR2GEfXiUVISDxQkmUVMxi9S/9MdhQywGV+9YQ0zw0puDj11hW8cYNyAFS4CytlUA8TiHU/v7TpPmu53WzrEsQJjDhD8ZxMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646652; c=relaxed/simple;
	bh=tMB/fJGNm9+JsG3RkWjw4oTwHyNW5C0yfmIxhcRZGec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRzeDlxq6obuPvRrK0LXCX7RXZtVnEtVUys0HH3S4hQdDmysPcRGMXf1n7n8cKkDNUfniP3iz8EM31oCJxVV6BzDdgAYkFEFKs2I9I3gg0dqHh10vVSwnwieTc6rlJtjq8dol1EAGqq7acTrDy/cBRjluksGaRH2gJlunOvW2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In27ywX1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso476177466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730646649; x=1731251449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nz3r1Hpii+Ch8EYMCNIE/V74gLWjSP1nHZUmQ2/A2GA=;
        b=In27ywX1b4GQIFdAY0K1GrqmrSQ/K8pObHwNRjMjGcPPd+eFB3LV5p2MrIWT1updCo
         EnuoCwGeNqLH0+12qsJJ5bMENCV72CH2Q0qSv7sIxrvrtz4SxviPl4FVReAfejw0FgMo
         R10hSUf1urVE6g0445UZAgBjV1mtDuijjI2i56mTHDA7pOvlz78bpp4pFQyj1oeSBXhc
         nKVhxQgo+j4eGcU9QLR4YzvFe3YJ1yBgwdVUKgRQrQtVFrv4ie1M5hgjWNiYNegiLGvt
         /7hSL1dkAgghp1NwtZPMkCIOZs7CYeVXTD1AVOaB/vH2uIyooCTEOYZE931eQ9FlY7MB
         fWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646649; x=1731251449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz3r1Hpii+Ch8EYMCNIE/V74gLWjSP1nHZUmQ2/A2GA=;
        b=UuI3yHHyr5muNlhyWuIXzwY1BwXltjiCziE8qzmkEBwTV1FM/rEXKY5rXsu9MwgFcE
         GvUjenlJ9kp0UXhoiJY3GLsJqWV+xlWDP0Qiilhp1ioiP3jbsxVkRyuzFzwd0G1z7pGS
         3KD3YDKss1s6ydVNxZ0JLXuycwp8559NFXHcJphVhhWEiS497VVRzRZk+Ebl7Hdoz0LJ
         0ayM6lOhOXFv0qhydGgfiHdwdTshJmXpn5t0v8Dk3p5BZb8mqZpc5bvdOIOERpXnYnLp
         M6pf/l5zuG9LgBiEZmlifdK3Wwf/yUUsJsW98A2aR7q6HmLkbr56M4MRiwnvdsBo3buT
         Lerw==
X-Forwarded-Encrypted: i=1; AJvYcCWRqLmnpTOM9bVcwQRCS1rmuZBtG3S24l2eRy5wOVX/zvHpWBDIr5lvikzKsCObJFmUDKvgf52gykN1c5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZbDRhMuxca+UxRZx5/h9ZK+czuXVgI7j2flKr9htW6ld+w8V
	CLMonGC7pMzrT4+OPZsyJZIEgwru4SibhR+WPooerMCV+eFmdysm
X-Google-Smtp-Source: AGHT+IHUmY7geESJ8kCdBUqY+5Y+Nt2zmyXPqAPEff+mb+ZOGsyqYHajjJjuKQH9KTjBqdxIlsn05A==
X-Received: by 2002:a17:907:9729:b0:a9a:7f92:782 with SMTP id a640c23a62f3a-a9de61ea441mr2820644066b.52.1730646648964;
        Sun, 03 Nov 2024 07:10:48 -0800 (PST)
Received: from shift.daheim (p200300d5ff01130050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff01:1300:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566843b0sm431466066b.212.2024.11.03.07.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:10:48 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1t7cFb-00000002Nzh-40r9;
	Sun, 03 Nov 2024 16:10:47 +0100
Message-ID: <15435fb5-ae39-407d-b022-93bbe9e14fab@gmail.com>
Date: Sun, 3 Nov 2024 16:10:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Remove driver using deprecated API wext
To: Nam Cao <namcao@linutronix.de>,
 Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux Driver Project Developer List
 <driverdev-devel@linuxdriverproject.org>, Kalle Valo <kvalo@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, Xingquan Liu <b1n@b1n.io>,
 Tudor Gheorghiu <tudor.reda@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Manisha Singh <masingh.linux@gmail.com>,
 Dorine Tipo <dorine.a.tipo@gmail.com>, Tchadel Icard
 <hello@tchadelicard.fr>, Felix Yan <felixonmars@archlinux.org>,
 Moon Yeounsu <yyyynoom@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Roshan Khatri <topofeverest8848@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20241020144933.10956-1-philipp.g.hortmann@gmail.com>
 <20241030093830.QSofC7Cl@linutronix.de>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20241030093830.QSofC7Cl@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 10:38 AM, Nam Cao wrote:
> On Sun, Oct 20, 2024 at 04:49:29PM +0200, Philipp Hortmann wrote:
>> This driver is in the staging area since 2010.
>>
>> The following reasons lead to the removal:
>> - This driver generates maintenance workload for itself and for API wext
>> - A MAC80211 driver was available in 2016 time frame; This driver does
>>    not compile anymore but would be a better starting point than the
>>    current driver. Here the note from the TODO file:
>>    A replacement for this driver with MAC80211 support is available
>>    at https://github.com/chunkeey/rtl8192su
>> - no progress changing to mac80211
>> - Using this hardware is security wise not state of the art as WPA3 is
>>    not supported.
>>
>> The longterm kernels will still support this hardware for years.
>>
>> Find further discussions in the Link below.
>>
>> Link: https://lore.kernel.org/linux-staging/a02e3e0b-8a9b-47d5-87cf-2c957a474daa@gmail.com/T/#t
> 
> I added owner of that "replacement driver" to CC:
> Christian Lamparter <chunkeey@gmail.com>
> 
> I vaguely remembered that he mentioned the replacement driver doesn't work
> very well. But can't find that email again.

... and neither did r8712u. what lives on is the OpenBSD port:
<https://man.openbsd.org/rsu.4> and the firmware: rtlwifi/rtl8712u.bin
in linux-firmware.git:
<https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8712u.bin>

Cheers,
Christian

