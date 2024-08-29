Return-Path: <linux-kernel+bounces-306759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020F96432B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D3B24609
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845A192B62;
	Thu, 29 Aug 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRKMJfww"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335C1922F6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931227; cv=none; b=kVFMcHATh9y2F9vfBGYU0uoaB4E2vpfCsNlEqwIS6i4GB5Pt+ZoMBcd5vhUVjTwSRMmja2WEpSNi2rENpXTOQPbgG21mrwKcbrh0qamrw/moz7IOeaWJlC2X6AiffVJZ3Z0lte+R4j6kqTbVPZ0ZV2cogEZcdLwNykxxh/iSg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931227; c=relaxed/simple;
	bh=hV5buY2hB1xlUtDfHGx86HK7OMn1QR37YqmoagJMy/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmwT1h2nEtv7Hlb/6ifjEOUq4X9kgk6y5gCTc6HdAkPRCX3gmNG6YAbYeOFrpB/Bi78HbLh/P9xgvsu1OmnVFIFDOSTD0m5q0L5B/QGXSFRjJX2ddAxOVd7usD9Wnb1MG+E+UU+Ifb+QklFOjk5SJM+eI/YSnTfWZUGmkmZcC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRKMJfww; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202089e57d8so3503225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931225; x=1725536025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hV5buY2hB1xlUtDfHGx86HK7OMn1QR37YqmoagJMy/s=;
        b=DRKMJfwwUDY2ZnXnVt4snMBPqmQ9Lc9SpTyrfREi2nlv5JPISBrfFq3r7ysgL56iwV
         4bGw4f5kvio677ufFaItMMMRcGTCLsD/nw/bKJ3IDCe6kGpOwepQKYwynPQzC1VPDhNg
         PBMfbAClmgafsmCSkaNMn4izuwSlDW5BrX7MkP933KKsdSuW+7pveArixzW2UV/lztPR
         Un/Xjr7/CBGwL4PREUK0mLqe9zXc4RLYvAiDp3EqF5J6QlBmCFFyAG1ct2jTddglLYKn
         SORPNXDx9wZCfKD3N+J2M9ZzzK+qDtA9//Ar+pqIvwnQFTjoCPeovDHzvt/cOZWO3z+C
         ZdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931225; x=1725536025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV5buY2hB1xlUtDfHGx86HK7OMn1QR37YqmoagJMy/s=;
        b=gJxH4s8WbuQdwltYlZBkhT2GFcZIupLnKtmQ5zmqfU1FxuC+ed/XLQvBxWqAAcJuCA
         eXR+jz3kwhQfQAv2GRs0FZCiZo4dea0WirD9UDMY/wwDwqfdWtfqrz9tFLRbG34z3I6z
         G7Ww9kWvjrZpl5fWP4tW8g7FbhZt0z/kk/2PZR8gwgroQG6HyIj62aQi6R5wW2GcpUsL
         rNcrGVHVuFmrU9nfGgYM4xjcq4hy/Q62AbpKyvTo1HKbYNPD9wpDy6nN309hqwj58xV4
         HkljSanjVGoyKdO1IVqx4qrAUXfnoWqQMURXUVrYFUYfvYtURpytijheBW8z4iDV7gTR
         Dc4w==
X-Forwarded-Encrypted: i=1; AJvYcCWxqBvFtjl/h1a54luHFmirDCE9nqhoXoQ/AB7Lkf9dV2R5I7JdaEJ9uxPouDoO1zcfLuGYuvlAyixB6iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaZG3z2n+UhaUrubWL4w2YTxOrF6cHXn0195WzMhh6qF0q10e
	BWc/ZFgQAnSKtZnlgraVFRo6zAkBoHeq2zwNZTNTEQbEtR7o2sAn
X-Google-Smtp-Source: AGHT+IHOPdsy0r/rCNiC/mlv05mzznubKK0H9FJgAuRtJqkeD2kv2ZZYLr9eAAiBjN594n/R8zCs9Q==
X-Received: by 2002:a17:902:d481:b0:202:2e81:27cd with SMTP id d9443c01a7336-2050ea14504mr37998215ad.26.1724931224907;
        Thu, 29 Aug 2024 04:33:44 -0700 (PDT)
Received: from ?IPV6:2804:14d:c098:8bf5:58c0:549d:d99a:c399? ([2804:14d:c098:8bf5:58c0:549d:d99a:c399])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a3b61sm941582b3a.48.2024.08.29.04.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:33:44 -0700 (PDT)
Message-ID: <8c1960d3-8f0b-4505-99aa-8af55685bbb3@gmail.com>
Date: Thu, 29 Aug 2024 08:33:41 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c:681
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240825161335.21737-1-alienwesley51@gmail.com>
 <2024082916-savings-upstage-9606@gregkh>
Content-Language: en-US, pt-BR
From: Alien Wesley <alienwesley51@gmail.com>
In-Reply-To: <2024082916-savings-upstage-9606@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 06:52, Greg KH wrote:
> On Sun, Aug 25, 2024 at 01:13:35PM -0300, Alien Wesley wrote:
>> Separated assignments for pairwise_key_type and group_key_type
>> in order to silence the following checkpatch warning.
>>
>> CHECK: Assignment operator '=' should be on the previous line.
>>
>> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> Please do not put line numbers in the subject line.
>
> thanks,
>
> greg k-h

Should I fix up the subject and resend it as v2?

Alien Wesley

