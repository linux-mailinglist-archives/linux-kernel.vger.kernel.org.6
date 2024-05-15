Return-Path: <linux-kernel+bounces-179632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943DE8C628D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132F4281BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E94AEF7;
	Wed, 15 May 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="hqJCZA4D"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E72482C8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760691; cv=none; b=M+fBy2bxApMe20MhDFI1NH3JionbFaqnvrEtVt2AfRx6EUAqxcTtJ/MbqN2OC8lJsxNpiG7wgU8Znu97rV5MIVNyqt+lg9JeuztZWPiin2fXKb8WzzgtCPq2VptS6UNEj3pBKCvi4dk4Zm7w84do5tSiWPLX0VoG2e2C/DzPEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760691; c=relaxed/simple;
	bh=wgLVDZfo7OUNUCa/aFvVw7eI10FXyDQIuqG4Ml5oaIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJSp/dioSIe5zSDLL8VRnZDaXVoUEQtCJVpQeEuGHihY+62VqCU28wX6Por5udGkGEpRpKwiDQqHFa9Y6q/A5uNACQXbNmL6B0prtBvGwhRCOx/gaUahEOF7jnDK5EFcICx0Rbdfw/kNWAqURXZFRpVenzvln9zU0aNm90yJFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=hqJCZA4D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51ffff16400so10735968e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715760687; x=1716365487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nadn3nJhbpbUcGRwW1AG+AKX8Tqss/4B5lqeqiiCsI4=;
        b=hqJCZA4DdZA/CwAcI7ltBYUJyTvK1J/SEZbazsgOzYKYjDUlS+OUbPPhKqMpDiIgef
         IGKgkbgq8EVhlWqMGBWnXx5mh9GXVazftKK+hVplkKYaRzgViruau5k00yUvDFiunAdk
         R4mASkiFQ/qz3W8Y1kS2J++GjSWQy8p+IlgVN11rCcjM0/ztUWJGnT9wVgyIbknsLcM7
         M8CUBm3LxXSCX94W6gJT3a82BSK1fp5foSDgCcJCmHPyrdSZqJnoQiATlvYk3dptUvpK
         0131mV52A34vO26Lp8ZHFXXrbm/+o+uY98syQzXW6xFxpVNWj4iWYS9Z8ECP/S391oKZ
         I9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715760687; x=1716365487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nadn3nJhbpbUcGRwW1AG+AKX8Tqss/4B5lqeqiiCsI4=;
        b=YtsKN2/WtIwoe1ojf34vVxGY9HXbDylfPR0l472yJ7qbLUKKOa7kt91+iIxO+tr/l7
         64cCUqDPxpLYXHTplX7crEg1GsK4AP7xYoeCDFyeGJVNetDVrQyfeY0FC3mTX6ZVF8mc
         INCI1q7AWH8/usGDAVmfzvTqCoxuKrObc3EPQ/9YxnGRayhXEYy6NpZgg2Igwz/fHFVZ
         E56mY0zEgIE8CD1H5XnEFDKUvQfKw7eO9DW2aPzJugsnFP4gUwUJFHCwCMzImsakdTOH
         cb0iD8tzD5wziQeuvkGHkBc8sMPk1xAIq07jb00c/DbO8ndgEaBFlZN89503t44VarZx
         JR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsPOl7ft71zK7rv0OyEjYQRtlq4C9Ct/iipivlBXmm3bOQ7A5NMtSY8G/6ipMPuLbk4k3I283Fdh+LxkqGWFokQErnBeLFctm8wdxF
X-Gm-Message-State: AOJu0YzcOrHfZ9JqiWkQ6ekes/QcwLeJR9YDhlVxytVeCawm4Ovr3TRO
	KpIr1QAi6sU4sPaLij7ih0M9nANpK0zY974b+uM4YHsrOOHZWsHEhAtAAUbdunc=
X-Google-Smtp-Source: AGHT+IEm4tt3o20ljc2e1O4yFuBQYTb/i4s4EPsBk0XZkzFkv52SwrrVPTrrVXZR+8C3wJP6qscL5Q==
X-Received: by 2002:a05:6512:61:b0:51c:5570:f570 with SMTP id 2adb3069b0e04-52210473d4fmr11529720e87.59.1715760687525;
        Wed, 15 May 2024 01:11:27 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba8e6sm2400086e87.108.2024.05.15.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 01:11:27 -0700 (PDT)
Message-ID: <dc5aadc2-308d-4f24-8a59-45da21b8b2e5@cryptogams.org>
Date: Wed, 15 May 2024 10:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: X25519 low-level primitives for ppc64le.
To: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-2-dtsen@linux.ibm.com>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <20240514173835.4814-2-dtsen@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Couple of remarks inline.

> +# [1] https://www.openssl.org/~appro/cryptogams/

https://github.com/dot-asm/cryptogams/ is arguably better reference.

> +SYM_FUNC_START(x25519_fe51_mul)
> +.align	5

The goal is to align the label, not the first instruction after the 
directive. It's not a problem in this spot, in the beginning of the 
module that is, but further below it's likely to inject redundant nops 
between the label and meaningful code. But since the directive in 
question is not position-sensitive one can resolve this by changing the 
order of the directive and the SYM_FUNC_START macro.

Cheers.


