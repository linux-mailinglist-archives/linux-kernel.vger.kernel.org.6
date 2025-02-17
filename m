Return-Path: <linux-kernel+bounces-517249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7EA37E29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18467A31AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75E1DEFE6;
	Mon, 17 Feb 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VgV45f/e"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D71DED55
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783720; cv=none; b=Zn5yRFWAl5HEeDkLcLRs6Yi1DDdJ+ZHuNQT5LGLR1eNeykVxrgwlfpLeCnZL0fa6RerdBsdJY0Kxp2KfwBP5o+CRLbHjIsfTDtdEhfrRzior4Zt8R1nqaLHhsA7NyCNMngA26OqoKYfeDkK/rpn7AO/XOvk9qWFvZC0D8jkBAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783720; c=relaxed/simple;
	bh=f3MTvzcR3GA/z9r5gc8v5gx850whg98+ehNQEjHsoe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kHrELBaakgxLZrysBpqaoPTKTg4hvhHWdyk1DzkfWOp06WCTn9v1DYTr6WWO6mIHHzjKyHalYdz2/Nlt5hcdM4intw+ywCH7ImnRjTqrfI3hlnr9JwtxCYCr9zTGB7AkzwLMjNJ70Emm3gyRYeGvIc06eGXfvyBv3+OF7OwzPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VgV45f/e; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so5117304a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739783717; x=1740388517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B74dWrHkdsECoNtjQdU0Obn3rg7n8WfP2B8f9PshJuY=;
        b=VgV45f/eXOdtTQKIIp5ME/L2tEjhGqZ+qU/Urjbw3MUC2L/hBJHHWc3d9n6L9C6XB/
         mG8b51v/4jGBqp5TsrpiVCecZlo16glo4LmuqfMjRNDE1XyCCYRsnAO+4sEEicXoL3G2
         gttnmqwOkI5tqSCrJiDNHWq3WeSLi1CELxeeu6u6I1TwisBJ5drvyuIDdYbWpg6tl5fA
         N/bARgIzTuRBjqJTrN83eeFUDLBrP62EHZC7FQ/bkhhwVdEWpU+oMNOuOHPp+UeiOhOB
         Kw0gSwuMrHpYUQYHDotku1fyiQuoZ61E6tXSleBfdmaYTrzFL3HaO0xzs18PQKA1fLZa
         zX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783717; x=1740388517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B74dWrHkdsECoNtjQdU0Obn3rg7n8WfP2B8f9PshJuY=;
        b=FBm66SGDwiXUqh4ofI5jlxC0OPIkYrzPCbolSgmtWO3zFcSg9mqxj+OuoC5/KGn6qm
         gC5DBnZaxdRsEemiFfdbwPRcIIZo0aRvyZmgc1d+hMWbFK+4sPxj4R5SJzzcteJYq/wA
         nAi23zyQdTqE64Qqe40BFyEul5pMirm6mHxnswHePANiWI4t5P7m2NNUmHbNQ4wXxrlJ
         KhK/w5gWJJJlAPif3UYRBfJeIq8Pj8Es2xHc88x0u1LjoStyL0vahhHcB2+D58FhLaZD
         CEKf9onm8VYn4sG3inB+efQZzjFEhznvOs6jcir/H12vyH//MdNYnfhNXFoGAeJgnQqZ
         BWug==
X-Forwarded-Encrypted: i=1; AJvYcCWxhy+3vOOc/1a0s2srXwvTCS3lfrYtdQ/ra4qtnGQiAdp/vunaaCAphelGeHa+IuFOdnC8iNVB3EMu+8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEyP+TsGGITyED5s2nfS5QlYgRLxzC/RZm7BUIRN3+PF8a/RG
	J/eVQD0su/hlL99N0mfGv//VXRu+oJ5awt4mZbst0OtuQgiWLcVqMrg9R5qGx1Y=
X-Gm-Gg: ASbGncse0Mje9RriSqt5nHzeXp9DySThjgIY0+kkf/8QDTSl0wEf2ajKGiJpjIqZMwl
	6Qmfu+a+TvN4e2gtO/Lu6QSeL/PaivNLBWOtYR8pEaDF6cIAq/RXNszZvsVE1QG3pICHC8BOEb/
	XHC4qeHCULISPj7uRg19QsG+TeWhL8rvb7NlWzL88eFgqKyG3MauCEjyD6CKrmi3xzS+JqWQkJG
	OPpwd7E9dWGa6zhFTxwzI/QznXAdLoxio10q3tQgBju2siyiAtItIhNXAVwbXY8r8KaYTDxv3Jk
	XFf29PN/8WVGJ2BeC2l0hrE=
X-Google-Smtp-Source: AGHT+IEMrhkZcva4RBS+kkon7q84KVXR16ulAthaujUtAZ/PxslVHVSNe/geC5YVpS+ivaoXq+QuxQ==
X-Received: by 2002:a05:6402:27d3:b0:5de:c9d0:673b with SMTP id 4fb4d7f45d1cf-5e03600514bmr8825804a12.1.1739783717480;
        Mon, 17 Feb 2025 01:15:17 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270b17sm6933732a12.62.2025.02.17.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:15:16 -0800 (PST)
Message-ID: <15ab9baa-4644-4b4b-a6f1-ac71afe8465f@tuxon.dev>
Date: Mon, 17 Feb 2025 11:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add power monitor support on sama7d65-curiosity board
To: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250211143302.4102-1-mihai.sain@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250211143302.4102-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.02.2025 16:33, Mihai Sain wrote:
> Mihai Sain (2):
>   ARM: dts: microchip: sama7d65: Add flexcom 10 node
>   ARM: dts: microchip: sama7d65_curiosity: Add power monitor support

Applied to at91-dt (with some small adjustments, please check), thanks!

