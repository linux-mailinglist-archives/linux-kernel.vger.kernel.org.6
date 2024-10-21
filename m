Return-Path: <linux-kernel+bounces-373554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9909A58C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328D01C20F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B231CFBC;
	Mon, 21 Oct 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnRue/+q"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97514263;
	Mon, 21 Oct 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476584; cv=none; b=Ae8KKTBsntMfOe89R75ARysszNW8eUJmnwrlE0tfO8M1w3XMxnNWjwG9hXxOxSIn+891MHrT9EJB/+XqXgJQfzVeyvnW+7UneRWfxwigQEyn95pspUxmmE4b31WsualsGHGzZnPVshKJMc+Rm/owu0RrXWz0AtoirLOFaDP0FXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476584; c=relaxed/simple;
	bh=24Le3eiapDQH83aOtSutIRNiu1Es7vn9zmebqUHO/PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4ZfxQRCIkr9wXDe7cfb71jDm9O0Jw/JYHHsoo4sZBLQA7lAHnOC3h6PJHIUuAadHyvVKCZi2jLBrrtBm4aS8PpAL7QL0WvohSlg+jr24XhKi/ri9ZBkLQJT/HbLp3kKAFQsbAs2rr6JEt6JfYAnNV4jAVcRXJEOiRRRmcvBz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnRue/+q; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e681bc315so2457734b3a.0;
        Sun, 20 Oct 2024 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729476581; x=1730081381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf7ZQ2vXj6JorqEGjz7XEV1A94uZWCECK/fe9E3SPTo=;
        b=SnRue/+qCQq5Ny5TQjYtz/OJMxTkHejN30TZ4dYyfLd2QfMM2fTbkmVkCUFNujSO5u
         922739oAsHhGTm8oitDfgIqfUOCVyWfc9WoyPYoyg+cgbeDm1DkkM8ejfLzF1GFXz5Q+
         5OH0RrTooS1YFKExyJt+r1V3MtRhe7e6JWmEfAg7KBsZHkj2jy6oQQflzH4Y6U07H0gi
         rlWOvhcuBLAFpArgirQM/uPTaO//PpDLQaAwnkM0cOlrpj9OZOMf8uYz+OVeGqy/GDhP
         mgrLdnU3amVQ1UPVJ6t4w7G6zR1CzrxmQ4K4uikJJ+8U/hEceoKPq9QwvB3P9BBla4Al
         6taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729476581; x=1730081381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf7ZQ2vXj6JorqEGjz7XEV1A94uZWCECK/fe9E3SPTo=;
        b=egaCNW5qbZnt8+VOas/cxfg3w+hViT3bS5Ys/o72FXl9t0EpKYflCutvb3UyuwRts8
         ZOmCSfAOiiYc06WD/ZH6X26M69acRc5R3mvHFXXf6VSmL4q75aCa7zCdeAcZHEjBui5G
         IxPa7VRArws4WxQ5Pbd485GtISVe6z8EmX+Ge65kvwzgK8JEGSY9mqlRJ2PEgAd6fnRG
         MTtfKDFxIMYesBe4iVowlRPRHhcNiawOGg76FAcOvR8eg5vOK+lCczsQdNFHm5NcYg+0
         YeWb7cr1TGFMgOLP+SN+HmRistQCqkdhe6Vs/OpY0mdyRU+dmn+kACk2WQyBQDFKqqTO
         MYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi12M3eUUZauNqDzN/t9UiEDIy5X1LOIIqmT5XJ9WZW57hbAmRJpoT5G/SEPw+V5PK9qWmxZyW/8csk6gF@vger.kernel.org, AJvYcCVLCx241EWBQL4tQpMrbqbbpTdiAINC1VglmfI9EEt3V1X8v5Qdf6gcNFWR0ROSvYSiqTsveuuHPerb@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhLguqB7NBcfciCiTBzBcL23Wu8/KIV0+EO9QFL7EG7Q9BvNe
	NsAMDPLeOAUuN6Ciem/EaXi5My0xUP5nLiOdG4nD7JUdF+QzlaCP
X-Google-Smtp-Source: AGHT+IFq7IOvWK3WEZq7H92NJ9rZFuPaZ3gta4tblIVUEdLtLS9whI4zUy8XlVEj522zW40a785d0A==
X-Received: by 2002:a05:6a00:1d15:b0:71e:591d:cb4c with SMTP id d2e1a72fcca58-71e8fd43bc5mr26167952b3a.1.1729476581198;
        Sun, 20 Oct 2024 19:09:41 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1332f6asm1775801b3a.69.2024.10.20.19.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 19:09:40 -0700 (PDT)
Message-ID: <c89f11c0-e0f3-4a28-9de4-341d0238f8cb@gmail.com>
Date: Mon, 21 Oct 2024 10:09:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nikita.shubin@maquefel.me, arnd@arndb.de, vkoul@kernel.org,
 esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
 <20241018022519.721914-3-hpchen0nvt@gmail.com>
 <ZxItGw0m_w0jgtAq@pengutronix.de>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <ZxItGw0m_w0jgtAq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sascha,


Thank you for your reply.


On 2024/10/18 下午 05:40, Sascha Hauer wrote:
> On Fri, Oct 18, 2024 at 02:25:19AM +0000, Hui-Ping Chen wrote:
>> +static int ma35_nfi_ecc_check(struct nand_chip *chip, u8 *addr)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	int i, j, nchunks = 0;
>> +	int report_err = 0;
>> +	int err_cnt = 0;
>> +	u32 status;
>> +
>> +	nchunks = mtd->writesize / chip->ecc.steps;
>> +	if (nchunks < 4)
>> +		nchunks = 1;
>> +	else
>> +		nchunks /= 4;
>> +
>> +	for (j = 0; j < nchunks; j++) {
>> +		status = readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
>> +		if (!status)
>> +			continue;
>> +
>> +		for (i = 0; i < 4; i++) {
>> +			if ((status & ECC_STATUS_MASK) == 0x01) {
>> +				/* Correctable error */
>> +				err_cnt = (status >> 2) & ECC_ERR_CNT_MASK;
>> +				ma35_nfi_correct(chip, j * 4 + i, err_cnt, addr);
>> +				report_err += err_cnt;
> This is still wrong. This should be
>
> 				report_err = max(report_err, err_cnt);
>
> You have to search for the subpage that has the most bitflips and return
> the number of bitflips on that subpage, *not* the total amount of errors
> on the whole page.
>
> That said, the statistic counter should still count the total number of
> bitflips occurred.

I re-examined the return value of read_page, and it indeed needs to 
return the

maximum bitflips for the subpage. I will correct this return value.

Thank you.


> Sascha
>
>> +			} else {
>> +				/* Uncorrectable error */
>> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
>> +				return -EBADMSG;
>> +			}
>> +			status >>= 8;
>> +		}
>> +	}
>> +	return report_err;
>> +}
>> +

Best regards,

Hui-Ping Chen



