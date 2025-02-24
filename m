Return-Path: <linux-kernel+bounces-528629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56BA419FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6736C3AFD58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AE24CED2;
	Mon, 24 Feb 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrxCeiNS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1324C673;
	Mon, 24 Feb 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391138; cv=none; b=jJYjrlIVWi2RQSA+3yA5touQyuE4Rv+MbEcB7uzx7TwUydoPJhHL7CGy6xtIJdyRG9LopAprfV3hHNIPqB86Q4icV0wMIOy7DhSSjznm/s1rv3V/UgEYXEONdcJ4o7AO+YbLOlCX7SmrDfsOQmtZ3CxrtYxd6LMYtZE62fXXZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391138; c=relaxed/simple;
	bh=fX2FejRKLHmTf189qkb5nrdkHYro4O5UcpVBV7OFrbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1crYOGguiLgsoRXoXtqthcJ/fh9EMc/Z41JxkahDP0vuoVVDX9AxzGZPZRcrXVvbIx4JRPC8dARhH6ATcOZo9H7ocrJwujoGrGL1Vy3zzpri7B2eZFJVDcIYkXAvfvvqijAGHvRu5eNjL6hgOA7K4bnJbxEvnzSwd3jH0c4Qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrxCeiNS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso712954266b.1;
        Mon, 24 Feb 2025 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391134; x=1740995934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlyuCvvFDo2128e2teHgyAWHlRy7aBFZ5OZbDHsqsLE=;
        b=GrxCeiNSO0J9qkGWsJpUVqc+uAbLjlW18gfdl7LWunVLyDw0h+Ts9S9vl4mH7bw7nH
         Do050fgNuXC4RixwQBcnYy9NsiMgdMexPL/K1qKAk+9E8JFt8wrqQalVxT6f+2BmbV6h
         Q99Z2lRstYHf10AggugiMmTXs+Rg2RpMMWsXrb++zJPvto7oALVf1OYv6QY5AWFtdcAz
         ncI5bXRaJEZfANUYT9en3HQ0azrLJgTmx4oeIEbj/wwGWfrs2zZYPJnvN0aOi2suqjm5
         wLRyeO1Lq6dmd570kSGeklhIGyM0zL9gJlifzX3OzsONUMxfbIcJxlV7IkuFWYRfaP2s
         J+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391134; x=1740995934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlyuCvvFDo2128e2teHgyAWHlRy7aBFZ5OZbDHsqsLE=;
        b=Lhh8t8HNzfMtC5vt5y4ehKvxkI/6ERuuKFPiUJG4pXVyIPuPodkbv2ec1CPuya91qO
         DN8ggoqIh8M1OrrGzF3CF+CLboXvreBTOexn4NQGsSc7uDY3E/pNNzfZm8vacWMA0zYD
         sKJJJsfG47AJRaTsuo/wV7DxMLKp6+U/IknVogbDxqqnA/uYBm8eYaq8WNuszNqLjW3m
         G/l4XF8d78zkeU4i2DbAzYGPPv3+E0epOnDVvoP3BKVoBIond6hobCfztvEtKxSKkH7s
         Sc3gK3cOQR27dKISlhvxcDnY+5enDfBPegn+wmHw9ZtycFVC2PFhMpqeoZYS/OvHBMaF
         bBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvFnH8cxezn8LTrJq0e4HhnUUHFk4ATsmN07Y2bpA8IGBVcXpOQkZCZPZk9rCJANd1lw7zOzWLBt1n82hw@vger.kernel.org, AJvYcCXwFiu6xWUYGdVBG75qb8hAwZPHJFjSiR7BfsplDMDXDl2AtGIrP57bO8MkWQZaUR9IuMaSbuLX3uSF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XcUlAvMPsya8zplEb/cITuTVgm4vWaEFmiVP5VWsWXVPtjDh
	dP5birX7otB2xEcKEngAGkpGbzpFA6Gfv9UTo+vXFaK4OLXxKau/
X-Gm-Gg: ASbGncsZ30PcIB7eT4X6gHIial8R42E3rtOqcHDvXKCyBPOTUWHmDBDBjJ8s29KOJd1
	cc++FvKuwPCDEf3oIuMRGA+f8gQqzSpuZvNxYm5INko+gce/UNq0EicZzY0eJ1HkbodLhjtN5ak
	TV6EqDHvSyvjN7xcj+0MLZjDMV2KyIXWBo+gpGOlIN90oWO9AydvieLR0DMIBaSVFEhIosXhdbt
	b2IMml/OK4YqOyxiqBPx+TUG+krdShJ6tkzYTg9GvzBASBhpM2k+v8HnbQepM1+xYIID5XYyv4R
	a/e+a2yxKgB3RS8GbB8cmxbnKl28wZPawpU8ImR0UcrSGgRhX4s=
X-Google-Smtp-Source: AGHT+IE4DISpsiKgYOL3EFZd4l0OSdPpTIlMEud2TUQe2sSiVQY+CihGdqfWOxw12evc/bJo4FFOAA==
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id a640c23a62f3a-abc0d9e4ef5mr1108032166b.18.1740391133934;
        Mon, 24 Feb 2025 01:58:53 -0800 (PST)
Received: from [192.168.5.199] ([92.120.5.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbbc95288sm1255333966b.158.2025.02.24.01.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 01:58:53 -0800 (PST)
Message-ID: <a62ab860-5e0e-4ebc-af1f-6fb7ac621e2b@gmail.com>
Date: Mon, 24 Feb 2025 12:07:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bus: add driver for IMX AIPSTZ bridge
Content-Language: en-GB
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-4-laurentiumihalcea111@gmail.com>
 <20250224075538.7oetjzllqqr2mlnt@pengutronix.de>
From: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250224075538.7oetjzllqqr2mlnt@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 24.02.2025 09:55, Marco Felsch wrote:
> Hi Laurentiu,
>
> thanks for your patch.
>
> On 25-02-21, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> The secure AHB to IP Slave (AIPSTZ) bus bridge provides access control
>> configurations meant to restrict access to certain peripherals.
>> Some of the configurations include:
>>
>> 	1) Marking masters as trusted for R/W. Based on this
>> 	(and the configuration of the accessed peripheral), the bridge
>> 	may choose to abort the R/W transactions issued by certain
>> 	masters.
> Setting these bits requires very often that the core is running at EL3
> (e.g. secure-monitor) which is not the case for Linux. Can you please
> provide more information how Linux can set these bits?
>
> Regards,
>   Marco


In this particular case, as far as I was able to understand, NS EL1 has enough

privilege to program this IP. This is why Linux can do it.


