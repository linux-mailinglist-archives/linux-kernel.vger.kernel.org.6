Return-Path: <linux-kernel+bounces-421884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE29D9169
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C24516A719
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF27E76D;
	Tue, 26 Nov 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7o3nNq7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1228FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599703; cv=none; b=kyRMa9upAkot6YXCMoyt52oG67MV4PIs/ApJrOamYY3z3aEF2KSOuwZnC8u6I/PoQdqK7extlY3R4qdXUN/mZ8OPWdKNp13T9OYw8pUzd4u48EvIqhUU4SZJMeRENyNxufc2w/FDcIl4QnckyA0z05TLNo7QkKcPGJUVoasDYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599703; c=relaxed/simple;
	bh=jA2jxjqsNqYBHCGkHXnptZD+IoakeakmrW6ZcgyeRl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaJaBYYL33ocLhhkUBPKkbm6KI8R9DO/jeolnHh5YCz4xJpRF1GDXbKfmX1zjQ2bwUnQR8YewZQwhAwXMXWu7+vScHTwE4QJo2xlhIqCLXLMRaXge7A9LnntqPQdKQX+nllLY16KNQYS9RZgO0GZ8Grys9RwP2PaZHV+vgZQ36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7o3nNq7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21262a191a5so46612905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732599701; x=1733204501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZIXv+9dxOLvX44jgEosCeJ1ZkgG3xlaNHk54kHEnho=;
        b=J7o3nNq71hhUtKwGq9PGHz7I3w8fE9X99lE7FPCkWy9K+vv/xyJjoTJKJ3DeAS30pj
         LBn5QLj/CZjODW2sL4LRo4Uqc1xXVlVFcJs3abYeNPa8W6eMcdduSgJ3y7OUsqQPZLnT
         ffLWZazSF5T0s9JbWRvPu4j0fPPzWXQsDs8Ac7cgu4bWMRPAVPLKuOTr+mu3QSAJnRaw
         Sj7RBb9LlxOnXw8YRasZRolo2qszxo7urOokx08uLFVWidEXpgzO9IdkLBDl58nKwIeW
         UxuAILz9+jQPV8oQOPWMwpEQPe+RH3CRfiKx+8t+3bwseRcWEKwmnZc6hle0pu+lvm83
         qvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732599701; x=1733204501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZIXv+9dxOLvX44jgEosCeJ1ZkgG3xlaNHk54kHEnho=;
        b=oGONY53l7kz3Gumj/wyZMVV/sk6PTi7727uarab+bUscwcf8OJRu2STLPBnyBZZMCm
         FtFBkA5mNrg8apnWT5+RNUGeb5CfbLs/2bHjIseU4JDANrMiZi14kgCy5S92WP4t6tfB
         HjkVISrooKnHgz8HKaRojnMYfhf36Vj3RY99rNiwkzGBb8VNN0t5IrQpHzaMU45sQJnS
         isz1TM9+ZzYSUhRUA4580UEpkv0hBy/RF2UEbRXUDwmV+n2ECkECnJEnXgzfvUcn5RRv
         AOJ7uHny/GThlxU2q/b70v0kmeDRp1BDW8Cw+ECmonTTWIcyRQxZoBoJ93WZmqOG0IRk
         QsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHaczC5NMDeDQ0ic7/Jbc+KBq1M0MDfg0Lf72ONFZ9khozy8irrv/cPnn5UE6rOslnvgSIQXnavdL/3ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5UmpvkoyP8BV7y+EJkGb9LqtuVou0TpQFtWYOkJb/217nfGq
	DOKhAu6Gl4ZBes7x9IYgjXDe4ZOvuE4WE1IDblOWmU5zW6yWq3ZvVbVcg2SIeg==
X-Gm-Gg: ASbGncuk23MgntB2Dmq1u0NfUe86OniMaAiPbvfzhhxRsAYx//rdf3bnSqCWPzXbrdB
	dBARLVkaVeWk9bZJPMNozef7vuKHXL5uLWg+oi9r7cUqwAMaRYpsYprJVswvx3pZaxCFMV3Zmhq
	nDGzXVhQeX+/gkG6CLPuGVVmu+BPDs0PUjIJLG+00KIwPBjW+PMb7mThf7nosEzMHmtD1ZeSRGz
	oxvmif30bXtMY8nbAO1JMu4Z4Zbl9QwOTdbdKK5q+n9E7p44Af2fIXZV6HNF34=
X-Google-Smtp-Source: AGHT+IGRS+i8V50r8qVF0iygtYyP45FI8jr12E9Od5qn87IuCcU2RB0hrEDLVVUAawQahHHo56Qlbg==
X-Received: by 2002:a17:902:c94c:b0:20c:9d9e:9049 with SMTP id d9443c01a7336-2129f228d84mr271690485ad.22.1732599701043;
        Mon, 25 Nov 2024 21:41:41 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc11e43sm75706875ad.170.2024.11.25.21.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 21:41:40 -0800 (PST)
Date: Tue, 26 Nov 2024 11:11:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	bbrezillon@kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com,
	quic_nainmeht@quicinc.com, quic_laksd@quicinc.com
Subject: Re: [PATCH v2 2/3] mtd: rawnand: qcom: Fix onfi param page read
Message-ID: <20241126054135.5v7f5ln5vwc64eys@thinkpad>
References: <20241122085933.2663927-1-quic_mdalam@quicinc.com>
 <20241122085933.2663927-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122085933.2663927-3-quic_mdalam@quicinc.com>

On Fri, Nov 22, 2024 at 02:29:32PM +0530, Md Sadre Alam wrote:

Please change subject to:

mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()

> For QPIC V2 onwards there is a separate register to read
> last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
> 
> qcom_param_page_type_exec() is used to read only one code word
> If it will get configure number of code words to 1 in QPIC_NAND_DEV0_CFG0

"If it configures the number of..."

> register then QPIC controller thinks its reading the last code word,
> since we are having separate register to read the last code word,
> we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n" register
> to fetch data from QPIC buffer to system memory.
> 
> Without this change page read was failing with timeout error
> 
> / # hexdump -C /dev/mtd1
> [  129.206113] qcom-nandc 1cc8000.nand-controller: failure to read page/oob
> hexdump: /dev/mtd1: Connection timed out
> 
> This issue only seen on SDX targets since SDX target used QPICv2. But
> same working on IPQ targets since IPQ used QPICv1.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Change in [v2]
> 
> * Updated commit message
> 
> * Added stable kernel tag
> 
> * Replaced the buf_count value of 512 with the len in bytes.
> 
> Change in [v1]
> 
> * Resolved the issue with reading a single code word in the parameter
>   page read
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index cc59461df72e..31ec3db1246d 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2859,7 +2859,12 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>  	const struct nand_op_instr *instr = NULL;
>  	unsigned int op_id = 0;
>  	unsigned int len = 0;
> -	int ret;
> +	int ret, reg_base;
> +
> +	reg_base = NAND_READ_LOCATION_0;
> +
> +	if (nandc->props->qpic_v2)
> +		reg_base = NAND_READ_LOCATION_LAST_CW_0;
>  
>  	ret = qcom_parse_instructions(chip, subop, &q_op);
>  	if (ret)
> @@ -2911,7 +2916,10 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>  	op_id = q_op.data_instr_idx;
>  	len = nand_subop_get_data_len(subop, op_id);
>  
> -	nandc_set_read_loc(chip, 0, 0, 0, len, 1);

nandc_set_read_loc() does changes the register offset based on QPIC version. So
what exactly you are trying to fix here?

- Mani

> +	if (nandc->props->qpic_v2)
> +		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
> +	else
> +		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
>  
>  	if (!nandc->props->qpic_v2) {
>  		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

