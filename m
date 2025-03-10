Return-Path: <linux-kernel+bounces-554057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B88A59242
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668D73ADA13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1D227BB5;
	Mon, 10 Mar 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YUntud5z"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC548226193
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604915; cv=none; b=b5EnSpnwodid7WkDdnKAUgyb88hNQXgxc0WBuuiEIbb0t+SU/7UlmNVzka6rqU3gf5VA1F0o0D9Kk9WKnfr5ccYhVcckXqSYB7YQkx5kONsrAx7XqxL+8HDRACaLI7ni2gzqBr+9IxDrdadgLLXiRoWK2cF85xxjVyKyLztFJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604915; c=relaxed/simple;
	bh=2Fpr2s87toqjJkcGUKAHl60+P0Bejz42/H8P/L324/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCze4xcMq0bp0FdaHvY9A+QVB2vXyf/nVMiXuaK5VOjsE0aTqvupE/ZNiliowpBGcSkvTXABK1kbJ9mwZgYADZcAPwwCU8Fqe+dZLM9VdW0l04Dkr7zDHWR8DuloG6eRgyinzRolos1detstUP0kINsLAuAuZtVM/1Pt3/KPtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YUntud5z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso16012475e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741604911; x=1742209711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj6OoGMan3+aUrpTlqHKjbVxQYo1LN6nRL8tRMEyjJo=;
        b=YUntud5zAu+Rp6uE/+1ueFvBdFDG+9gJ2rGB6yXRPOjeSBpWLgFB6fpjQsM+Hf3WNi
         eFQGn6lEMd1a6tl0J1DuzmNGnIfC8j5EjC7wv15iAVJMPkEZdeHx1Znx9LvSxeQrQzYG
         F1UTylS/TQEFuK/p+Avl/RuuvY0+ex1YtHLRpROHh41N3yNN9srrXADUWn93U3/0eEBr
         FHBzLhVx/zNomN7zRdPYQBnlcUGt0aSL3kAD+3ZIBZCXjLIzo/7ywjCIx+SdAFyTvd8W
         yIvjt9vMS8WrJcQtEOyjyXsh0E0elp9gAsB8Yl6tCboNCfAi+dTDviCK+BP7a0208UyN
         ypmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604911; x=1742209711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj6OoGMan3+aUrpTlqHKjbVxQYo1LN6nRL8tRMEyjJo=;
        b=Gvdmf644a3HWMlufaQvlb1/If4fUuG/6LGupAlxZOIC+/ysmrfKS8g3tp9cjlUWoRZ
         AnB/ss/SEtMjW0G4jsCR4P1QIspHZ1Tr6BqoGPjos3TnpWH0vN++PXQ+xvxWYYiK3GvT
         /NGSXxMiScIJ/2LjcPzyL9BaXS3I5NNV6hOyfX70f7IIz/Ac3Ahe2Hmxse7SWbUSvZbk
         wOBr4QkrYbs7h++XcVRQzp6x09PUdBT3McVsZwLkUMrGufkLsJr/980byFE6xSiWYNbe
         Klx+092Uci3MRavhlNrFb9dr8ouk7kmIZZi92vE4Qnqy5wzlXRw7JPH1Ffi7M8KxFRSD
         cB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNek7+oYvMyhQQ1nXdiYJoL1qtWuUbrnwpwuRt4SAqrzJNbL73ZQw85f9vHaaejaxlEYyInSVQF8k7I18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVmpoLJIUq9F4KT1UbC7Pi8Hn7hywE0eLbQ9XhU+t5cdt6z7m
	Xr7v2PwyeKiuM+66pCSdoVAbOcsgPVJhyKeN+ISc25dh/AwTo1TWoibIEABwolo=
X-Gm-Gg: ASbGncuLCTLqPfjqzBdqs7CRQFsdtuSrLow8bB22SFJi2hk0N0kPZNgspuKvrUXDtOB
	prCsavfe9SerrnsDQMSm6KbOQCaFMQO5QuNiF0UiaInDy4J02ZohJX7WsDIGtBVeqr1g7pGZGbC
	5UbgOMiUKiD+eYn71xKhBC9NHtRC/8ng2CoY9ginNjLX2WP4KVS2ILKDgdq1RLzr9OckHUzlqDi
	fJuAbv5Mrh60DiwOIvCKydt6WB9RdiooHa2eI2VzwEwk7Q5RwXf8gRZdsrkwVqmDLN1cXzvoHBt
	OnDngfMTWsnNQJVSLlMsYmwF9nrul7Mhm/4maHUXNs2rGHob
X-Google-Smtp-Source: AGHT+IFUTAvlUQocnZuhWGDfsKJ3140vKmzfp6gwINFwcRcFXRbdY+k2lSsw1FVLxDt2VmJcsMNhJQ==
X-Received: by 2002:a05:600c:35d3:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43cf1cd3ecbmr26249125e9.12.1741604910988;
        Mon, 10 Mar 2025 04:08:30 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0425sm141811095e9.3.2025.03.10.04.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:08:30 -0700 (PDT)
Message-ID: <5d21bf87-37c6-406f-8705-82968ba0e8df@suse.com>
Date: Mon, 10 Mar 2025 12:08:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Remove unnecessary size argument when calling
 strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250308194631.191670-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250308194631.191670-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 20:46, Thorsten Blum wrote:
> The size parameter is optional and strscpy() automatically determines
> the length of the destination buffer using sizeof() if the argument is
> omitted. This makes the explicit sizeof() unnecessary. Remove it to
> shorten and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. I've queued it on modules-next.

-- 
Thanks,
Petr

