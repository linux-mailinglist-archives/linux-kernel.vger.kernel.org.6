Return-Path: <linux-kernel+bounces-554055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C2A59238
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CBC3A5D00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97234226D1A;
	Mon, 10 Mar 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/TaV/xJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E980226CF3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604842; cv=none; b=PEgCPXYneJ5cpEhAGSYXQOMzVG4WHbtD6AAb4KoedeBjDLr8y2Qma8mXqRbdk2VjlLTb5yoZtbTnht0NmrFRfhiekMExkuCRjQhJVnXZF7+5XqteaDae/8ROC+5rKJb3rZD9nZmnrVq9XlpSzNLEMS0O2ei6YlrDw5tlR4IE1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604842; c=relaxed/simple;
	bh=E3SkaDiyXKVedK5kf/LG+F6Dw3khT24RClCdqmT6xxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opjjZYoPYEzhdUV8sIIVB8VwOAfFWcN2qvAuNFZ4rVS1cEjfUOsiRJQurZbRY7Qcl1yI4NcdxTl9ieNijU3mNRrnQlLCMT4r+21bhpj4ixZiQnV/w87pQcm+cU29JV710L37USKebDh/oIAgEMMP4/1dkMs4epvNHqiSkumxByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/TaV/xJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1057155f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741604838; x=1742209638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBcgqyPlbosjp2zy3+ac6vsF4qpWptDr9INnNUVK6yk=;
        b=O/TaV/xJ5qCwzereSakC8r4boyJoWxcCHOqZ+eK5aWyGoksPS2T936FrSQXgg6DAl6
         8StyBZEN7r7VfqcgRXSR+zmPNIq5UvurImiM6nT3YcheZq0NN1RcS4Rdz6nhzKXjci9z
         NJ5zCIqTlIDMbvRHBdVDmjfzzk9V1+MEHSCQ8HKRcsgXkzlq3hqogaHlJCqcmVshk3VW
         F5zGaqpTUI5nBZ/Oqnx6azJXuq+fdK8l5crZv8l42ldrDuekIz4ly02+q+S4YrB85d3I
         VZ2qUuwSzUcPguvuLSzKjprr1qpHojW3tRFqgQgbUigCYlDKOuJ2/UmvKIPCXIQNYP40
         hFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604838; x=1742209638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBcgqyPlbosjp2zy3+ac6vsF4qpWptDr9INnNUVK6yk=;
        b=L4Cx8fp9lGS0FXWU3VNVSA/9FXWTLLiXzsYqcYoJcJAmT5pk3hz5HMf2NvvrdW0NK1
         UIRQSxrduXbOBVsLf9YYQat7pbaqNmvbnV5pDwAQLocnPHB/OIJiIkYJBPGMTgGqzhUK
         3a5pZHQohcwBwPEiLw0AiH3MMwg4bebSVq3aRImX8R+Mxsu+4uT8/3Vt2DFmh+h83bCJ
         xTGgp5TPCc/ThFI94HTCvv6xPZnsk3Km9hc7u+k56ljtnHtcJP6IQpGh6wWEMETrZEwo
         b/SEg7m+sYqccMeyfT+nlmh9xfLgH16R7XxRPZphwYKdbA1zeJtPu/CpLt4FUMDCnyOS
         7B3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzoNfkGJp/ndj7Q1twEIDa2P1T5NaxViheulhrexNW186LYEDmamGcphyTZrqbM7QvxKR+XTb4BIgBgWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOj9hX2dbSKAlxj3Vit3YmxclYFhgDTYIOjl0If/55rIfaDXb
	6prM0kwqzvQ1b/uk0Y3aCLaZjboOz2zM/2LsO4DRNrStVHzl84hz/QKgYyMGDGA=
X-Gm-Gg: ASbGnctOAEmg3JT6NEuuPKVLSvBiMTstB6V+CNzvUptiDLweYTnv5qC4TwcK1m7I/dS
	JOf5CmlvOI80ZFYRBdpiHnIZzJoTsATGLQjlElgyKZzq1LvqXxVkrU/0hTeIP4MJDl+2Dn1unJP
	+v3tPB4oJ5jhM9Zql412qvJ3ymbmoaoqkBJTaJP5qZuIIxOQW1lY0CXYoBoBSlkDoPjsVS309Tk
	a1v0HROcUENtqBMZAwHrS++dUTkwO73nGOphznDxfTGoBpPzwYid6UheChwKLVwCWRDTWSV9+0n
	zN0CAKp9vd2FY8pQvO2zlIJgR3sinIeVQZJXNcanaApfjHBh
X-Google-Smtp-Source: AGHT+IH9/rdUnizpqSBA8HQZRuo5gzzbf5lJb9mjbnEeKpVc0nSuueyiE3WfSrFLVop5GR7AmRPlJw==
X-Received: by 2002:a05:6000:184b:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3913af2e472mr5183779f8f.18.1741604838405;
        Mon, 10 Mar 2025 04:07:18 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfa7e4f36sm24039495e9.40.2025.03.10.04.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:07:17 -0700 (PDT)
Message-ID: <975dff84-234d-4fad-b15d-0427672785d1@suse.com>
Date: Mon, 10 Mar 2025 12:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Replace deprecated strncpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-hardening@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307113546.112237-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250307113546.112237-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 12:35, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy() instead. The destination buffer ownername is only used with
> "%s" format strings and must therefore be NUL-terminated, but not NUL-
> padded.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. I've queued it on modules-next.

-- 
Thanks,
Petr

