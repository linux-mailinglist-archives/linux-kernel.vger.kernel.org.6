Return-Path: <linux-kernel+bounces-383608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653479B1DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B84281ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74E15CD78;
	Sun, 27 Oct 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="F4cmpKCq"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E961D540
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037649; cv=none; b=gFVqDQgjf9pdL7HarohW/ZMTQPFutq3yAIrfR/t5VZuuELMM5NduJCgBBi3cPswXaiP3mHfd/waRzHs+aEDrIyfvcUdZkN8Oe/CdgMqNytIxYME2bqlLd52sWKJ5UO2mo/f9MJ+Shzm7yIzaogo+8NgOTkQPGH1ERwS977sP+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037649; c=relaxed/simple;
	bh=uq9Um7mpIVkVjnfKAB2drVKLUqxpKFJaQ+x22tx0kTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDsWdIGFRcLOxLejt6QdFu1KYdAx0srDmJ5Y8rJPdBusoFVw2LO9yoZqxsEs7yDh5r+erfXb9bYmB6JIAW+RRG6eWXEiZK7K5Jzzh2963XOTNw5MJZ0ykU+t2iqI3m2AVajYzTsvvUFRz+ihsFJvqXq36rjlKBpcHpU/d8pxLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=F4cmpKCq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83abc039b25so134987539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1730037645; x=1730642445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDtIO9biG3LuVSVqi5dhsp4ov2sWS6eGJBXEdghply0=;
        b=F4cmpKCqydZsD6symmHEUVjCqRAfvgNCWiZRMB4Yh5EYdoEPcrrl82T1Jo1yssn3SZ
         EqeNMj4sgzgPl7l/P5FrpFUT8TaMFb3YResVr3P+QJFaWgF9RON97qkfq6M5/1xaa9Zv
         t99A03v/yLQse5pC/Frs63vqZ9+H4jYNJK4Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730037645; x=1730642445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDtIO9biG3LuVSVqi5dhsp4ov2sWS6eGJBXEdghply0=;
        b=KDkbTnMGLUdAIJpiAt8mgjeDNcaaXiucPCtnvtCSqdZdNwCb1kYqSt9/IwNqkGqOFw
         bRjylT5TMnj9l5HHycaSRX+a4VCxmh3/BhH8lQBeTbBy1i6583ygqvEHK/hswraK8KmD
         EsKjffdV34FXAXXrxungu0WT+2/opSmGPvzEyi+4iy4iQyxmWeFbUDGjCBFW+SDuGuDT
         BXkEzi+iJslMIOdgVxOjyBZxaslhuupgWqPQd13H4s4h7QR3/laLKPIgtUoEcO6+FO+5
         52n7aGIDTkn6O9Smxik/FOWpXj/MGglzK74yAcmln4EXxkaPEsC96lNbRIjhjzbBUnud
         74VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5nm2K7iAMk4k4fpPOqIDXSqsiiFO7896fYNT57el2fTxutBExh3EWPF0ZHWvMkzPagzOD+6tT/Gn6jRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqryWeNDNeeKYVJI8RMEp+pZi8YZEmzFTtHxoOTzmld9kilJD
	Mveo6cR1PXKKmHw/zXIq0oOtkvkcBDOtccwfe2VNzEIruvUUzM5pFkAtN//43hk26ch0teLEDDk
	=
X-Google-Smtp-Source: AGHT+IF9RJ+pjofmPm2SqDUnt4GShxn01jUlKEdZotXvqANIPexEfcBxmSfD4FbqCLjoIoJ+M8Z6uA==
X-Received: by 2002:a05:6602:2d81:b0:83a:a82b:f856 with SMTP id ca18e2360f4ac-83b1c3f4053mr425316239f.3.1730037644863;
        Sun, 27 Oct 2024 07:00:44 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4dc72610be1sm1190339173.42.2024.10.27.07.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 07:00:44 -0700 (PDT)
Message-ID: <106ff2db-befc-4899-8f28-6f8b6276cdd3@ieee.org>
Date: Sun, 27 Oct 2024 09:00:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Fix null pointer dereference in
 gb_operation_response_send()
Content-Language: en-US
To: Suraj Sonawane <surajsonawane0215@gmail.com>, johan@kernel.org,
 elder@kernel.org, gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20241027075304.7301-1-surajsonawane0215@gmail.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20241027075304.7301-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/24 2:53 AM, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch static tool:
> drivers/greybus/operation.c:852 gb_operation_response_send() error:
> we previously assumed 'operation->response' could be null (see line 829)

There is no need for this.  This is a case where the code is
doing something that is too involved for "smatch" to know
things are OK.

A unidirectional operation includes only a request message, but
no response message.

There are two cases:
- Unidirectional
   - There is no response buffer
   - There will be no call to gb_operation_response_alloc(),
     because the operation is unidirectional.
   - The result gets set with the errno value.  If there's
     an error (there shouldn't be), -EIO is returned.
   - We return 0 early, because it's a unidirectional operation.
- Not unidirectional
   - If there is a response, we attempt to allocate one.  If that
     fails, we return -ENOMEM early.
   - Otherwise there *is* a response (it was successfully allocated)
   - The result is set
   - It is not unidirectional, so we get a reference to the operation,
     add it to the active list (or skip to the end if not connected)
   - We record the result in the response header.  This is the line in
     question, but we know the response pointer is good.
   - We send the response.
   - On error, we drop or references and return the error code.

					-Alex



> The issue occurs because 'operation->response' may be null if the
> response allocation fails at line 829. However, the code tries to
> access 'operation->response->header' at line 852 without checking if
> it was successfully allocated. This can cause a crash if 'response'
> is null.
> 
> To fix this, add a check to ensure 'operation->response' is not null
> before accessing its header. If the response is null, log an error
> message and return -ENOMEM to stop further processing, preventing
> any crashes or undefined behavior.
> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
>   drivers/greybus/operation.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 8459e9bc0..521899fbc 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -849,7 +849,13 @@ static int gb_operation_response_send(struct gb_operation *operation,
>   		goto err_put;
>   
>   	/* Fill in the response header and send it */
> -	operation->response->header->result = gb_operation_errno_map(errno);
> +	if (operation->response) {
> +		operation->response->header->result = gb_operation_errno_map(errno);
> +	} else {
> +		dev_err(&connection->hd->dev, "failed to allocate response\n");
> +		ret = -ENOMEM;
> +		goto err_put_active;
> +	}
>   
>   	ret = gb_message_send(operation->response, GFP_KERNEL);
>   	if (ret)


