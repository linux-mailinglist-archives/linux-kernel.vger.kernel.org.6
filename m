Return-Path: <linux-kernel+bounces-415495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6253C9D371A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3226B24F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F717BB2E;
	Wed, 20 Nov 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JtdYSBUS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7717F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095227; cv=none; b=M+FC5A1N/zD9CJghOHQrTTLQXqdk3wGjarIpHUBRck3BVt+XLN8rfCQAYuTdqvyM4EO1Xu8/tiu61loT/iH1Q+ygK3ZDuGtGqrKLVl7mskbqaNeuMVmodoirVUIII+yIQLw/sJ5WvSNjIQONALNimlzKlriRQEidtniwXMLXVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095227; c=relaxed/simple;
	bh=M5SrB6pZs4PNP+wyleRamaSF2HZSM4zydeDJ68Rn59g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mykXxrcF95bfs8R2k4YFHJUJTRs1L1t4wm99e7h/9iZEVKb3BkKGPcsFKmiJ7ycN03KIYt/YAGZastvjhBlBLuJeGTpVo8klLAMCpDdqAUUL+ymmt2wqOOXB53BstFj6rtTC5HFvhirfy0gHmcTQQ85ydamlNlWui/d39xguI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=JtdYSBUS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso62304281fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1732095224; x=1732700024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QH6GY/A8SMTS1IvFv+gTBY7cfhFRDLQrBHsvSAO2Qow=;
        b=JtdYSBUSCrOE0T5LrFGOJgoIg6EqH9HtEcv2aRfXYFhbwQBjdGbLNLwH59wICMmi+S
         Ivx+VjKMfD7HzOp+BRVK2G6AVchv13xdnqxVNDElE5eSpvZlWp6O3DzvXabuHP8zDins
         EIQ16dxXrD12QyUgneyCfsbphiAniH898BwVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732095224; x=1732700024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH6GY/A8SMTS1IvFv+gTBY7cfhFRDLQrBHsvSAO2Qow=;
        b=UOXijjodltSswac1XhwvI8anum2VEXScESLNZl/4KacGiV2Vemjh0GKnsotaxjTJFu
         uQs3dBwFrH9rTbzWDpQxkJtuq2wTUlnikp/B4fPpFYW730FbME83fp9bd32crS86xOUv
         tknmWLLMDKEfOM+OCgEZmEEUfhvZosRRsRMX9VUhJeTlv/yxn3O7dM7YgSLb4gI3ahes
         0ASyGhvZg9b9Q1kfJwGWfJXwY/w3rQoynsyur034lzIVegdEMblxGgzZQTTXcULRG6xN
         OZvk1ozKkleu+W/hYze+v9my4LS9ZVPBs8FqVbbFy7hWUv1pt76CZouxFMF+Yx80csL1
         QnzA==
X-Forwarded-Encrypted: i=1; AJvYcCUToVU7R59ralbCKl1b/SqvfKhdIlq4+88+N2njUx/TniHEHUmbf/8A3Lwiq0MhWS1ySvCTb9/ABRORIko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo25f7j6WS+d+yl5NQqrXk3BmyovL1D/VVO96PHZxsJfSQUfDk
	QrkubErK/lZmrrAG8yWmOU3LSSLPivQj8Ew04ZPce5XFIocAocCeMUJ+mvas5lAOorBJ7MRqgx5
	0
X-Google-Smtp-Source: AGHT+IFw/YenHwHFx3tw0Pq0XbvWtaYQmDSd65nyR7KIjehigUBiMAfUnhlnrPqb1DQ9YjYHdTvFbA==
X-Received: by 2002:a05:651c:212a:b0:2ff:78be:e030 with SMTP id 38308e7fff4ca-2ff8db15f37mr16214171fa.3.1732095223722;
        Wed, 20 Nov 2024 01:33:43 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4dc1e1df6sm76641266b.139.2024.11.20.01.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 01:33:42 -0800 (PST)
Message-ID: <3680972b-1871-4c92-9f61-c28ef7c10a4c@citrix.com>
Date: Wed, 20 Nov 2024 09:33:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xin@zytor.com
Cc: bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
 ebiederm@xmission.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>
References: <20241120081721.2838905-1-xin@zytor.com>
Subject: Re: [PATCH v2 1/1] x86/ia32: Normalize any null selector value to 0
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241120081721.2838905-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The first GDT descriptor is reserved as 'null descriptor'.  As bits 0
> and 1 of a segment selector, i.e., the DPL bits, are NOT used to index

That's RPL in segment selector, not DPL.  Same correction is needed in
the code comments.

> GDT, selector values 0~3 all point to the null descriptor, thus values
> 0, 1, 2 and 3 are all valid null selector values.
>
> Furthermore IRET zeros ES, FS, GS, and DS segment registers if any of
> them is found to have any null selector value, essentially making 0 a
> preferred null selector value.

Zeroing of RPL in null selectors is an information leak in pre-FRED
systems.  Userspace can spot any interrupt/exception by loading a
nonzero NULL selector, and waiting for it to drop to zero.

Userspace should not be able to do this; Andy and I lobbied for this
during the design of FRED, and Intel agreed.

Right now, this change is codifying the problem behaviour we were trying
to fix out under FRED.

Under FRED, if userspace loads e.g. 2 into a selector, it should remain
2 until userspace changes it to something else.

~Andrew

