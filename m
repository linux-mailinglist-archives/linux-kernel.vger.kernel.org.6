Return-Path: <linux-kernel+bounces-254836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF16933859
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9BFB21EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B42033A;
	Wed, 17 Jul 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CvxTVdSP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81661CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202776; cv=none; b=OQV/4VxD3YSaaOMKA8BrbU21y2gbSNiwA6pgNrsPJsXprHwVrAYkngNsEp/SEsrBzoH1chDXuEf8yCkZ9BCG+A+6zQB6ZLL0l/hExEsSV1GmRNhyygWYD4/ju0JfaAZWEZR2pOwBuzn6VaLqMQHvxGDZ8VB0VtWWe4SBNVZqSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202776; c=relaxed/simple;
	bh=tmn7dZaZf/63VEF8gNjawg4siNTUl1KUDSGXNI8Zuqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRsCaHpx9r4QMDBA6+nSC58EzPB63++MkKrFEWNA6vfjoQUn6zVceGEHVGnfpPTI/XWCC+UEhhaqzF8WYyBy4mRyXTQI4Edd6oztOteL6UQJk7TyOFnNQxqdWdW0lEpGwRzv2fHBggDh/IZLiYlazsgnLd7nCqRMHn5AUSNJ8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CvxTVdSP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso48244215e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721202772; x=1721807572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7JxP1X9anMugApULpKE/NNH8t1wNvqt4dSmpMOS7bM=;
        b=CvxTVdSPg81xHQ++BLKV3G/no2sn8ynpkd1R4m6I4nf/z6TlSlLGu8lqIiEKdANfgq
         bUMrf7mOqShBWpFeQE04pYfQwqVQ6qsydKjkiqKcbGDfggmfFcL7V2fEQ+B4uGqHWO0Y
         lbIT8RwIWcsZ8U0RtriyknzZhTudiA3+kSVyeU8CH9+OTpcC1kHLJi8kOpiv8ia1jP2O
         P79JQtjlB9XKCCF+eVQKxLDrLEmQllwCypUMBv1BH7m8uC0i/3qBWIbPPLo/Rs0fBL7f
         6MKC2BT6Jtpo0kn90HA2Zyqu7XsN6fUHy1frN5+ypQu8odbADkIXIB7knP5sI/O1uYHY
         8Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721202772; x=1721807572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7JxP1X9anMugApULpKE/NNH8t1wNvqt4dSmpMOS7bM=;
        b=OK7uuOkQU1Rze70O+Tr6Pb1qqk6GaXA1Q1CfUN+6rfQeXPYf+/TuKA/l4QYBlluIzD
         LWcEEwUTQwq7Cs+p2pavKAL2YFNl3WTr9vm5ZfFNAsgHX0aJYhbb56CX3GNyTxSUM6bO
         u14jlmt9E7aXdEK0WmH83GAiwiHNbMRDZT4UEykXrDKl9pj0XbfEr6nq2O6dndcHF/+I
         wlu4u0/FJ/pboRJt9S8QcpuW0WFw0QzMNqfpiz5JDkkPwayNclF3XbxROIT7pE2Ndd3d
         /iYJyekkKrdVJjiyvtPlsKAzrtxTq+efTlycJdpsj/6752LeeQB5aM6OIgVgmnB5nX2Z
         sTuA==
X-Forwarded-Encrypted: i=1; AJvYcCV/icwgOtaZClYhZu/8+QRzpmUAjrZ+X5saTByvJkNfpThNvOxP+eFAJhy+oudEB4f+2kgU/XjYxibiXYlyHvZGybXqn8GDiPaFtWDF
X-Gm-Message-State: AOJu0Yyq6hqMnEq8hCe0vBqA9mE7xOYU1ugE4odOA8QaZg7aTPdVFDUh
	DWMxRyPENboF/MgayCzJqkS2/YNl3WcotTje/IJqJh2BNNxrNokKop3LrDj1lU8=
X-Google-Smtp-Source: AGHT+IFTDDbi5O+/Lw8G4Rbx40psRglcjVnjshWdv+9mQbxcPrfb0y6tuYnBZuD00ssqlWOSynokpA==
X-Received: by 2002:a5d:45d2:0:b0:367:83e9:b4a5 with SMTP id ffacd0b85a97d-368316fad85mr507737f8f.49.1721202771882;
        Wed, 17 Jul 2024 00:52:51 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db038dbsm10862882f8f.95.2024.07.17.00.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:52:51 -0700 (PDT)
Message-ID: <991f7feb-a5bf-4eb4-9623-a13534a02b98@suse.com>
Date: Wed, 17 Jul 2024 09:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
To: Hongyu Xie <xy521521@gmail.com>, stern@rowland.harvard.edu,
 oneukum@suse.com
Cc: gregkh@linuxfoundation.org, brauner@kernel.org, jlayton@kernel.org,
 jack@suse.cz, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehongyu1@kylinos.cn
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
 <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
 <429eb27a-578a-4208-8ce1-89434b8d739f@rowland.harvard.edu>
 <3073c8ce-1923-4816-a442-41b4cc333af9@suse.com>
 <6419a4e9-e084-4eb6-8376-9202930ea8be@kylinos.cn>
 <ee0a5160-233a-485c-a34b-99d4a1e046c5@rowland.harvard.edu>
 <45b87923-d256-4c5e-8167-8ef764add1e9@kylinos.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <45b87923-d256-4c5e-8167-8ef764add1e9@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.24 05:13, Hongyu Xie wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>

> But I still think that there's no need to rebind for a USB device that was using usbfs.

Technically you are correct. From a conceptual view point the only
hard requirement we have is that the first operation after reset_resume()
has to fail with an error code user space can interpret.

> Because rebinding doesn't fix settings lost. And it looks strange from user-space's perspective.
> What do you think?

Only user space can reapply the settings. The kernel, however, must notify
user space of the need to do so and avoiding a race condition is tricky.
However, it is the same race that also applies to a disconnected device and that
problem is solved.

ENODEV clearly is an error that makes clear to user space that settings have
been lost. User space has to be able to deal with a device being disconnected
at any time, as we are talking about USB.
Hence, where is the need to add a special case for reset_resume()?

	HTH
		Oliver


