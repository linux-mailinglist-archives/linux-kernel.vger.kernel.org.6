Return-Path: <linux-kernel+bounces-223483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0B9113B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037921C2210F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16B757E8;
	Thu, 20 Jun 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrMeuBDI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F83D0C5;
	Thu, 20 Jun 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916676; cv=none; b=C7gpMZCNMYVdql4to2WgC7+sF3r9z3O+FipOjj8fWj7RrPsfDh38N6h8LUegrCZLW2Wex8nMHNV+CGCEQVPNPX/ZrgaW1gr7IkAYm2g2DsNWZ63860U9Ludq3M3jp3k5oSZpqQsGocCvr9SSESzwU5spShLIdo75MHyg+DHuD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916676; c=relaxed/simple;
	bh=Ry01bOUKNY/YQmuWaeYzO1vGrODt3sYJFKDL/k+WQSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N95ee6mlvFRuzXkfy/OhNLQ9DM2T70GchS/XW5xOw+fpFSyClza2N5dEt/3pcbRvct0F0dqKYIlkRujhHWfCIAQShjYi0OuFI2mgEDFxB8inZPblky9L1o5lLapic1gzJyHRwAVfgA8+BGKZjHx9HB4B/nmE0szNfKtPpqWy1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrMeuBDI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6efe62f583so134951166b.3;
        Thu, 20 Jun 2024 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718916673; x=1719521473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMfg/qkKGleDW4zNFv4Ac6ssqV1biO17IVk9rT8wxEQ=;
        b=PrMeuBDI8eQZG1DwRLxQvQhdL9sIFu1/MMGch99A6YLZPlj0Xo4BBACyPJhkPwJMrK
         bvKMOy7n+ifyvBQNWCRFScHOskQUfF4QaJHtKJB2C474wA46Ui5TO1GuTT/fyNb+ruo7
         fhHfHGDJqBnVc/V31VZhjj252uDZ9pgmxfcCKYFYb3cYGws4MRxqHnCZD2rQ3jdUabga
         Q+x1x/iknGLTYmZNiLD1gXXE7vd2wiehQ1/8gih3NgycS0EgcWUH1YNQhypCAqahjaP8
         dQs7TgD2eo1JZ5gv153MJp1+e5IgwolLd12SGDlyuMMfgE5hc74Kap3IEWA46QQu/X+G
         whuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916673; x=1719521473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMfg/qkKGleDW4zNFv4Ac6ssqV1biO17IVk9rT8wxEQ=;
        b=wxLyjhNfxPO9RDYDq1Z2dMQujdjfnI7Hwcql6QBldfIRelNwB1nKTILtOarZ8BOs8d
         WnxlI6CMgCt7IHluQ1bq2zWxLfLpple064fGumyktA2mVk6RGrDSYYUYt+FQX+0TiyWD
         +nPx8XuU4KVmVD0MCI0TEQ/wttuX0ykjJfTE0W9BaB4OAvrMFDg01xUyI3Xz72cWrFlz
         WpLsDBpzlcBfkuqKz/0W/Qcv884OvmMWijtaxtd0qKXzHOuI+TJFKQKXP9lYRfel4DHO
         +8z8a0XcqGwfmD0VzgiW27gRvRbi+zjU0VVNELkJdcGJptwVwDikGr688x+0Qa2EiKyM
         JL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVxUbTzdyx8hEkX+ZnRIkMGvK/c23ITMDUYAWYccz9PwKEyp6rECymvNQ9eR4LnZAY64V4NYZZgCsZSD3gGl+K4/IsQWMTE+zO3WFJnoNZi/C+pWqeeoE0akAkoR7rFwL8dzSW6wd0
X-Gm-Message-State: AOJu0Yz3m+Sc9esANEtsSvJplkmpgeis9WU0DxQFAa5tHxhDvGo7gK1J
	4Ytw0SzXLC/tHKPW4ccCcyRU5BCuqaIwHlOEnxRviaeHETM/O3fD
X-Google-Smtp-Source: AGHT+IG//b73tseVzwNg+xVJretRngg3yCf4usec6X2lUp2ROKFdiPIU2ImZRLJZ2lUZ2A8NYn9s9w==
X-Received: by 2002:a17:907:7ea8:b0:a6c:8b01:3f78 with SMTP id a640c23a62f3a-a6fab607b67mr517070266b.9.1718916672618;
        Thu, 20 Jun 2024 13:51:12 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:d31:9797:59c3:1c58? (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net. [2a02:a466:68ed:1:d31:9797:59c3:1c58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b17esm9024566b.88.2024.06.20.13.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:51:12 -0700 (PDT)
Message-ID: <10e2c4d7-f033-46cf-819e-22977e2359eb@gmail.com>
Date: Thu, 20 Jun 2024 22:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] usb: gadget: u_ether: revert netif_device_detach
 change
To: Ferry Toth <ftoth@exalondelft.nl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, Kees Cook <kees@kernel.org>,
 Richard Acayan <mailingradian@gmail.com>,
 Linyu Yuan <quic_linyyuan@quicinc.com>, Justin Stitt
 <justinstitt@google.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, s.hauer@pengutronix.de,
 jonathanh@nvidia.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com, regressions@leemhuis.info
References: <20240620203954.20254-1-ftoth@exalondelft.nl>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240620203954.20254-1-ftoth@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oops, used the wrong hash. It's late... Sorry

v3 follows.

Op 20-06-2024 om 22:38 schreef Ferry Toth:
> usb: gadget: u_ether: revert netif_device_detach change
>
> As agreed with the author, the netif_device_detach change is going to be reverted by
> this series, so we will collaborate on a new one in the future that
> brings no regressions.
>
> v2:
> - Add missing SoB (Greg)
>
> Ferry Toth (2):
>    Revert "usb: gadget: u_ether: Re-attach netif device to mirror
>      detachment"
>    Revert "usb: gadget: u_ether: Replace netif_stop_queue with
>      netif_device_detach"
>
>   drivers/usb/gadget/function/u_ether.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>

