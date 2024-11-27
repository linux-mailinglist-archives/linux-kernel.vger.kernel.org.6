Return-Path: <linux-kernel+bounces-423571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A39DA9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8933F281A29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E91FF60B;
	Wed, 27 Nov 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGPXHth8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A101FF600;
	Wed, 27 Nov 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717286; cv=none; b=mLqQqMqgyVvcLyunisyY3XcFTf+PJt/cetY6OAOV376BtOaBmdeqIzSnQgh6/QGm8TR/FYTA32UGujRNmzAE91+mZLwqHd662DcltJ3i13tsuOhcZxo2+PJ1H8opn+DPGhs6LsBqk8/wQDc5dQ65dg4/2C4C/Hx69w+4bjuW/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717286; c=relaxed/simple;
	bh=TQ9JiApntJLIYIXRcPg++9QrBYmA+RtMrGsgqQQKEP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afwGLpA0Vwv1HHIbwZhSpfmeFt6rF83iQQH5k4e0LShjbW7BWuPS5DTm5LS1nUJLsPHS9CPX2PNA9e8TKaEmGruck/HaQdl2zI5wrwQxeq8ngE1fgIK+kG1x5cq8o1/3PUHzm0oiiCAfiaNxUMhc9/3CtIwen7Q5/aUtUGWcf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGPXHth8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso8740873a12.3;
        Wed, 27 Nov 2024 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732717283; x=1733322083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jB30OEOTBI/dWjDLW+IofaDVc+ErUf2vlR2vQMQXiJA=;
        b=mGPXHth8I6dnMs7jfnIlDP5lgIjlVOb9aAcSPIlx33oczbHAkNPoMlD365hpV0PKZy
         Ng1dtLgb8pL6PU1ChxX+H6lpUFE0ugKlZSMPyn6RMUJO1/4XeWNxKf/CGKFfV2PQCypr
         BFyg0P9f/BVXeN+OdrnlPii/jQ3sY9ixeZMZF+vYrn6fjWE9Qm62fuBlByS27g+RypDP
         ihIdyy+Z8gZNReUNYMHQ9TsTEjlL6glTf4LoyO8ygIcRJj8y5Z6VNbGoMoxI+VAMGTaG
         LKjVdhCeVQsUdfh5uhzhtak8V9zCekQQOZtvqALJDAMlc5JXq5svh0K9URLujm7RHe+s
         i6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732717283; x=1733322083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB30OEOTBI/dWjDLW+IofaDVc+ErUf2vlR2vQMQXiJA=;
        b=l9owdNjEVOpUA9nGWJLRkEJREUkG2VuCbzDBI0kI5gGeJvpY/AEFu52xaKLB5Sc5rz
         byzSmuGXmPdbWTHICnOaSUOQgLlA36v7dC+DiAJcK1FtaB1aqnxt6dOY8e816Rcfz/JQ
         J3j+qMQgnOjGqVbk/midF3MWtdVwTYqKlERbKY0IQ1Pt33hd+IjALzfy2uyPEJLCkA8P
         Bogr2iHDlvReEsBmXP8rkkbPyOxpSHUmQcBWNkl/DjDVEBlknISC4Aa/gq2Int7j2qyr
         DI1SS+5XAPzPqozrvHN0Zr8u/OLqvojTc5giVBewsYtL059nbfYwOqMvxfgMN7lrcR85
         beNw==
X-Forwarded-Encrypted: i=1; AJvYcCUHRDf1RquqX2Qzh9Mv9lxizw+EcfPnxNciKH76oQatm2NkQWnlReOxaeEswciR33ZOh3BbVKnVH3W6@vger.kernel.org, AJvYcCVzKA5hXOGPKuYAOmOgE+m8n9HJzwoQ7CV/aZCn35xnWlPJCdCYBc6yE8H5BCGRb+PC50Y82nSBzEMcLLEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLa1c75g9L2gzbr5BbS4r+bqL6SKyQQu7RhCuZ4xDsgPYjKpr
	3mB2YoZ0rHYRPOhttHwL5OiTuyfWUnIB5DWEZxYKD1n6NM25X5Vh
X-Gm-Gg: ASbGncvlqeMSycup+HX+jApqlSq5qmcfbdDEzMSSbq0fiuO5RdGBicNuhYUuVMbP97p
	aDDNACAe1e2kk3TVy10/lSASTzaOvChD+rjtO3jnVJ3nSjqXHEU4fg9XoLTYhz5g23m8SSmSmN3
	uq70ROUoj48fV2rTE45SMI+5c64kd/8As63q1cZa8O2piYhlgSubLWioEschwP2ig/lPR0wr6Kd
	Fu/w9asKIQXy6rvtQVmImDgynLj+IwTxUrpXYfCTR+d7xcZQHFDFQ2LgSC2Tm4ksdLkBA==
X-Google-Smtp-Source: AGHT+IHe150xbicT8zJH2pK+sdFFqfuimlWI1wHv0E59eCRbFhzq6xB8ZKKCD9y65J/fD8U/jvaTPg==
X-Received: by 2002:a05:6402:51d4:b0:5cf:c321:d169 with SMTP id 4fb4d7f45d1cf-5d080bb5b48mr3160413a12.11.1732717283279;
        Wed, 27 Nov 2024 06:21:23 -0800 (PST)
Received: from [192.168.221.195] ([81.19.10.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3be73fsm6191421a12.39.2024.11.27.06.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 06:21:22 -0800 (PST)
Message-ID: <d83667b9-23a2-4f1c-9a9a-12ce1e3a3983@gmail.com>
Date: Wed, 27 Nov 2024 15:21:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] w1: ds2482: Add regulator support
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
 <20241125-ds2482-add-reg-v4-2-475a7a08df96@gmail.com>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <20241125-ds2482-add-reg-v4-2-475a7a08df96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

			     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> @@ -457,6 +459,10 @@ static int ds2482_probe(struct i2c_client *client)
>   		goto exit;
>   	}
>   
> +	ret = devm_regulator_get_enable(&client->dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");

This will cause a memory leak of `data`, I would refactor the driver a 
bit in the next patch revision. Should I create a separate commit that 
switches from kzalloc() to devm_kzalloc() or keep it in patch 2/3? The 
separate commits way seems correct to me, so it is clearly 
distinguished. Sorry that I missed it.

> +
>   	data->client = client;
>   	i2c_set_clientdata(client, data);

Best regards,
Kryštof Černý

