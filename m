Return-Path: <linux-kernel+bounces-362264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55599B2C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CECB22177
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12314EC73;
	Sat, 12 Oct 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l06jm7Ak"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3349136330
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727481; cv=none; b=nIT7JpWOD0M1ic0n6jzvp3Fo9fkklfF4IWc2ZTsbzGq4sn72fup0J6b2z4VXGSKFegIzFV3nLZMPndm+fU6mjaZ2WtsUhNdBicveW8GFT8ZmicfZ5BHYrw2dBnBDxBwEh+3TXzpoQreDpcrnV67MQcroGv5Q6yvKqI/b9Qhj3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727481; c=relaxed/simple;
	bh=GwMWPsFTPSs4Z/GrwCqitUC4u2Kc9UV4RwNKPwpOQF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HFfatQAo+StMwBH+9vwmwhW+pZmpCb++8ZuqIJM2dPx2XkeB33ExNna1g0IPnei2LmawgXvIB9ebuXJXPrCATXNXb14Hh1qsB5erm7EtfZbWdYZ1l+rVJ7TdJ9V9tzdSEWK+cFU/G0kYLjugtvccFC6VYduf5MhrgRa3ivAWEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l06jm7Ak; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso27820475e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728727478; x=1729332278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b2UtuTQmzvjGYkTIA37j2TC0Cks25DWgr+G198C2/zw=;
        b=l06jm7AkdaD1mR1/51o4ziDyL0eLVrBum7hk8uxDcyyLPB5V0e/wJmn7mDGXcJLUkC
         czHfeMTMkHznYB8qLYUNPp6Y6tPt+Xn3TlqL1TcdpV8fTuKxlR8h83TORaq3Y6ur/OkB
         fVmK6S3LV8qusvZuADExS0XbLaKOfWP+kxWlMfShiAWqFH83/cs0r3P9z9Hk4Ya+Ek4A
         3bQaQuZre1V7mastqAZvsb7KbilLpsQH1WuVL2TNNZ1ATXNHXbnKxnM/mZJdiSP3ApSR
         1YYlUuNjGOyjbrz/FS13ML8xWf7nPzfJaLzxIScEQexOaxVHmWJvVzaTZD+O5/Gc0Yex
         Z2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727478; x=1729332278;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2UtuTQmzvjGYkTIA37j2TC0Cks25DWgr+G198C2/zw=;
        b=YEzFkjGijMaiEaswQkWLM+Ik+qqJejXUpHQ1iO1GpVvcXJDLbUF8/RGDJJ7F1fJDzV
         ml1n+qlNrG8jNPXni/xuekT0ZPw/p6YlQa1S06qRd3qehCTsaquVsplkjIFhPwPWJVay
         WEGeb4Az2wUxVLVpS7EgD9JiYaB3tdwrmss0yYmtb3TcxhCCGdENgGRoJPbL7b+IG3Hh
         iXt9ImPt4TmSk1MJXziTotJm3wgzIph2f8ZHOf1vomVsZdZ6jBE0NabTVf0Axaek7v8d
         Arm6oH5LhR1JtHBZu+FCh0l05aLKcgtAAWKfCRUr0bCMtlMkr8GSGCOTTUpl5IFmyyq/
         96Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV8odV1lfzfO3clnxNfo6Wmm1iBgDapv5Jl/hj+NqomdtFDBDR9zN+Adl3cboOZxoJciEA5ym+bndFOg2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9DU2CWF92Xbjehddpa1hswTG/9KtNSWRzXdL8vvJIht66Wb8
	EB5nP4zCccwEWEj4gy3Um0DoOiIDcxgevN6QAkgXPrQr+gWJISE8
X-Google-Smtp-Source: AGHT+IGFmd0GCcvAiWziNYf3kxZmwULFCFyXb7MDzh9e/LlZpwTQCJSVcTsV+Bnk6YrLnGm8B9OuVQ==
X-Received: by 2002:a5d:56cd:0:b0:37d:511b:aec1 with SMTP id ffacd0b85a97d-37d600d3861mr2014345f8f.45.1728727477914;
        Sat, 12 Oct 2024 03:04:37 -0700 (PDT)
Received: from [192.168.96.164] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ec5aeceasm58254966b.224.2024.10.12.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:04:37 -0700 (PDT)
Message-ID: <d18e714d-787f-4d30-a32f-4b0f55d2f5be@gmail.com>
Date: Sat, 12 Oct 2024 11:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] staging: vt6656: Proposal to delete driver vt6656_stage
From: Malcolm Priestley <tvboxspy@gmail.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Straube <straube.linux@gmail.com>,
 Sathish Kumar <skumark1902@gmail.com>,
 Florian Ziegler <florian.ziegler@posteo.de>,
 Pritthijit Nath <pritthijit.nath@icloud.com>, Arnd Bergmann <arnd@arndb.de>,
 tdavies@darkphysics.net, m.omerfarukbulut@gmail.com,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>
References: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>
 <b2ac0a21-989b-4f36-9bb4-923221a77fb1@gmail.com>
Content-Language: en-US
In-Reply-To: <b2ac0a21-989b-4f36-9bb4-923221a77fb1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Dear Sirs,
> 
> Forest Bond contributed this driver in 2009.
> 
> The following points let me propose to delete the driver:
> - This driver generates maintenance workload
> - This driver has a maximum 54MBit/s as it supports only 802.11 b/g. Peak throughput is 3MBytes/s.
> - ping times can be 17ms are often above 500ms and worst case 22 seconds. 


Hmm I see the rtl8192e driver has also gone need to buy another device.

Looks like staging is closing down sale.

Yeah okay from me to delete vt6656_stage it will be stable for a few years.

Regards
 

Malcolm




