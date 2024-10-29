Return-Path: <linux-kernel+bounces-387707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F19B5510
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6DDB21B04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085420400A;
	Tue, 29 Oct 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn7zot2p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33791422AB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237475; cv=none; b=VlLxNglOJdcjmuo4/mjNEo1R9stjTdF5671+w0YyIYFZR2ZatWEoisTOzbAApAtrj4z3iBeuheph27KP8Uj025n/ffpcjsbxC39xneEITbo+rIDgXpCHjSX4exfMm111OtbynIqSdRun86Uft5VpywplEsw3W223XM90s59XIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237475; c=relaxed/simple;
	bh=dWKCH0266812E97d8By6HsbFBUUDCHP1lAzLfB67rL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoYJ/oL96/ku7uk0rg7ifKrPwILv0UJhU9GfBMiE/uQq1E6mftv47v75fA8MJnp9rUszyfqmfNYohChA2F1tsMvV9zvmy7D6N/orTcJSX2mnbnxxzXEnJTVh3FDnn9PTFvqx3QDSGblSBgOUaEU9f1XspdwzmCiNVqEtQkxdR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn7zot2p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730237472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKy0gKvcdEIREMIU1JdiEca9T4X0cP8U/0k2cemcl9U=;
	b=Kn7zot2psZYDCo3QhxArQ++DWKtPE+2sHBZ2cBmf0fyIvEML8C7B1Xfcagt4XwdrO+HKjq
	DxD0IkK2lFFsG7w2nMkSFecZwI1xJ4tH9hQGNrJ/tKIMqUIpcIOgHz+C9O57Y+qDZLUmaX
	UqVUZfR3PVdVafKtwu7nYtpJwBiMJ64=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-BSqDexg2MKiHryaDCas3og-1; Tue, 29 Oct 2024 17:31:11 -0400
X-MC-Unique: BSqDexg2MKiHryaDCas3og-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ce23cf761bso78259496d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237471; x=1730842271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKy0gKvcdEIREMIU1JdiEca9T4X0cP8U/0k2cemcl9U=;
        b=m5ePrSKnb+joJCTPc5i5gj0r+6gBrenep98sEgZu80XT/vjE8JpdI36wNbFSJ2gSSq
         3RBcjkvatnL/PA3MSSgQmffYnnljSgK3htedbN/elHykbkaCvrTYfCuZ2rlq40Gfz3dn
         KXjSUCsSnljZQJA3vtF7FU7dh7zWYxnqUPH7lCDPvGYOU9pJuAyxfzNU69PdCH+XmA7+
         JMoQVUlGx2oj8tjvt1eOl+Ac4FsT7I8v9hXaaxGBdpyxHBnmY26KfkwGPbsdLC60ZoCG
         JihET2WW0HOAIs2foI9L4QvbDypFqs02nVfMsHKlMi3VDPMFJ9lOk+Pyd2oG1L4uAoQ3
         C5BQ==
X-Gm-Message-State: AOJu0YznbzMsai+NcKuf36sGMvAOdgGqxV+k8eJLOAlARwE409I3dl2I
	iMSQW00OYC0Z2EOPwb/Ur4wOKB2M1JBJSGMLu/+vH+ovFsy/i5ZhB0cOp+kJ3DztDKXr6pxLWTE
	/Ogvu4rBRu6a3CqGmoDF3sPQXNTENNDx3LYzEevKPzC4RLqubXyHCMN/44cCl7Tlwpn/OCw==
X-Received: by 2002:a05:6214:4408:b0:6cc:1dd9:290 with SMTP id 6a1803df08f44-6d18584d51fmr189819286d6.40.1730237470836;
        Tue, 29 Oct 2024 14:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD25QFOFNhZxtwFvSXB0+Ij3LfJUM2osTiEjgGy+Dv3Dl65P3YytSqu6WA3w6Prbl+SgD/dw==
X-Received: by 2002:a05:6214:4408:b0:6cc:1dd9:290 with SMTP id 6a1803df08f44-6d18584d51fmr189819056d6.40.1730237470472;
        Tue, 29 Oct 2024 14:31:10 -0700 (PDT)
Received: from ?IPV6:2603:9001:3d00:5353::14c1? (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798b75f0sm46001146d6.35.2024.10.29.14.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 14:31:09 -0700 (PDT)
Message-ID: <b22ce4a7-8480-4d4a-b2c3-0d70c3e05c00@redhat.com>
Date: Tue, 29 Oct 2024 17:31:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvmem: core: improve range check for
 nvmem_cell_write()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241024154050.3245228-1-jberring@redhat.com>
 <20241024154050.3245228-2-jberring@redhat.com>
 <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
Content-Language: en-US
From: Jennifer Berringer <jberring@redhat.com>
In-Reply-To: <5b6901d9-f404-43b9-87eb-577124efa3f3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/24 13:55, Srinivas Kandagatla wrote:
> if (!nvmem || nvmem->read_only || len != cell->bytes)
>     return -EINVAL;
> 
> Does this work?
> 
> --srini

I decided against this because it seems potentially useful to allow len to be less than cell->bytes when bit_offset is nonzero. I assumed that was the purpose of the original "cell->bit_offset == 0".

For example, if a cell entry has the following field values
    { .bit_offset = 4, .nbits = 8, .bytes = 2, ...}
then it would make sense to call nvmem_cell_write() with len=1 in order to write 8 bits. To allow that, I used "len > cell->bytes" instead of "!=" later in this function:

>> @@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
>>           return -EINVAL;
>>         if (cell->bit_offset || cell->nbits) {
>> +        if (len > cell->bytes)
>> +            return -EINVAL;
>>           buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
>>           if (IS_ERR(buf))
>>               return PTR_ERR(buf);
>> +    } else if (len != cell->bytes) {
>> +        return -EINVAL;
>>       }

If you disagree with my reasoning then yes, your suggestion works and I can use that instead of what I wrote. None of the current in-tree callers of this function rely on that possibility I described.

Thank you for the feedback.

-Jennifer


