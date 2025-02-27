Return-Path: <linux-kernel+bounces-536831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD3A484FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D9D17ABEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9318DB35;
	Thu, 27 Feb 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLSwDdIy"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436C1AA1F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673011; cv=none; b=WEp71Nr2GuQz2ciF59RAXMAOhOGH8S/UvdkJMZf/LR3LE1Qp8HvE4z6HdneNb7wgbTx4cE7AkS0UjCOkqsoUoObo+0hzFU+Dmf5/z0RqZFtDeEfN1sl+kha8UeRHCrfQP7qm8xADQLtp1inbZqtcqVV8lgGwuHvs2RWmkllYWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673011; c=relaxed/simple;
	bh=6tX3VW0JQJM4rtNZsodPM3RlPxfmHNE98XD+MwNbMWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTiN2A9yVM90xY9yW3rN5KtaPnY+WbEGxssHEMD8ntzIUqXSRhzbMgtSW/E8pPo3uLEHlNF+yMd/UOkPCQdtPHkW50P0vepsWwRYrhWtHf16FWq16+aIqiTW5FcKfwit4BJJ40vfgR2boKFzicxU+YTZ/JUTAn/fR8onBfjUFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLSwDdIy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so10829621fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740673008; x=1741277808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX4u7UXpPGZ8D7QuEZ+oSNt1Lmj3UsF/9ZW9EERgxyU=;
        b=gLSwDdIyLRjbowUKXHcSFJrhu7doxxPNbCehrWygyIFJRA/fIRF5KDSTJT7SaGd1ed
         MEB9T5gePRnr+KVgZ6zf/5BaB2o6/2tRirYh2GoA7cKzJe2d/vTlPSG9WFXYgo8XHbhE
         LuZf3g1PCOpNIp32U5QzGMMg2WkzdtKSbvSSZmVKoPBXEjuO4BXgDFLRdLUun2blale5
         Y9eCMXzfmFCubGF3lPRaEHturscMAYxSRLAQ+XepL3splVrBqlpdNgwL2qbB0OTKdPl0
         pnB98Cya4BPY2BY++Z3J1Nf6r1t7IbwqOODjeDfMh0UyQjAzdVmhGWez7jTSot3bM/FO
         Uzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673008; x=1741277808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX4u7UXpPGZ8D7QuEZ+oSNt1Lmj3UsF/9ZW9EERgxyU=;
        b=vCYXskqEfdpZwr662PjsYR+HbNmEAyO9Oqc0C5FdGGRi0oY3ClgxK8P3ZV6Wap0VCz
         jcIwkDbtxiWGT7XO8P6soKYYXOOAeCGzKcEWlUyaZD+SaXTb0tLWlXY6LvW7QEYpoXSD
         1gvHXzgWj7XnYdQMuSLiVOeE0ZXDMuaZ7OGXUVdktaw9lgVmjJsXQfrTWz6dex81EYVp
         gwl4pdpraGqiwjL/QoRl3grW+DNfxXV7Hxoz7EsCxlmvNwonKCXhEGie46AQS/hrhDBF
         R8IN7bwg7zEQNJJd93TLmecYYTZafBHtLjOvUmnr8BziImXkOj3ff6HIh2Viwl++80BT
         2nlg==
X-Forwarded-Encrypted: i=1; AJvYcCXaoDe8yWPSSEoALDBhamWuJ1DmbwZlACWUkiuPc1ugRH1MDw0AC1o8w6bl8gRBwqt67iQuhOzjEZ3a7gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0wFOkmFBODURBg3Y4T1Whx8/pKu8+WyWOh10mVQOuvGcnzpo
	Sco8RdqkVU/jrq54sqhGgKbFD6bKrzKOk7pmDsQW5aPV8/ghIpmGemtuxQvydhg=
X-Gm-Gg: ASbGnctWPIYxsNK2dEFA1WzTSjycgcm/WqaYshL05n22LbzHpoBckrLNwRE0Rg64+JR
	B5e7H+H/BugmfKYxBtSUguxraXiIvDc7Tn8D0RBPY7paRemhxwxnBYf8NoLOdq1Jrbe6xYt8h3c
	S0E/ywXQfCVOAZLx4cXpe9tv1r2fK1pk34BT/wo5WQRjRpyRL9R+QpiJqF8FV8ZGtSSqZufhkWs
	LnGiewm/4lBExmjLeUoYHAT0H8WDgWOnNCHIfg46lWNvPH9F+zDWsVCaj5KvF/97GrDJmyhdx+w
	7JHyzwLVmFcZoa+ELso9lwRch8n1ST2AMFRafiNBMtCtaTwUeSHxL6t3dx9aVwRnegcLh+jNEep
	YGzzhIg==
X-Google-Smtp-Source: AGHT+IGhMeQvxuZ+T+1REX+KfUprzvLbHM1rkujw3Y1YJH1DeORbGd9+QyXWDYYtv7KMCaQcqexPVw==
X-Received: by 2002:a05:6512:b11:b0:545:2c25:44e6 with SMTP id 2adb3069b0e04-5494c31aafdmr4735e87.25.1740673007689;
        Thu, 27 Feb 2025 08:16:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b133dsm197118e87.134.2025.02.27.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:16:46 -0800 (PST)
Date: Thu, 27 Feb 2025 18:16:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc
 node id support
Message-ID: <gxqjfabcqafqjzzwc3seadfuldqfxlfappsotjbhkbirvorcyd@mahdpv6klwn5>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-5-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-5-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:10PM +0000, Raviteja Laggyshetty wrote:
> To facilitate dynamic node ID support, the driver now uses
> node pointers for links instead of static node IDs.
> Additionally, the default node ID is set to -1 to prompt
> the ICC framework for dynamic node ID allocation.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 16 ++++++++++++++--
>  drivers/interconnect/qcom/icc-rpmh.h |  3 ++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f2d63745be54..2e654917f535 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -285,13 +285,25 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  			ret = PTR_ERR(node);
>  			goto err_remove_nodes;
>  		}
> +		qn->id = node->id;
>  
>  		node->name = qn->name;
>  		node->data = qn;
>  		icc_node_add(node, provider);
>  
> -		for (j = 0; j < qn->num_links; j++)
> -			icc_link_create(node, qn->links[j]);
> +		for (j = 0; j < qn->num_links; j++) {
> +			struct qcom_icc_node *qn_link_node = qn->link_nodes[j];
> +			struct icc_node *link_node;
> +
> +			if (qn_link_node) {
> +				link_node = icc_node_create(qn_link_node->id);
> +				qn_link_node->id = link_node->id;
> +				icc_link_create(node, qn_link_node->id);

I really don't like the idea of reading the ->id back. I think in the
last cycle I have already asked to add an API to link two nodes instead
of linking a node and an ID. Is there an issue with such an API?

> +			} else {
> +				/* backward compatibility for target using static IDs */
> +				icc_link_create(node, qn->links[j]);
> +			}
> +		}
>  
>  		data->nodes[i] = node;
>  	}
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 82344c734091..cf4aa69c707c 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -95,7 +95,8 @@ struct qcom_icc_qosbox {
>  struct qcom_icc_node {
>  	const char *name;
>  	u16 links[MAX_LINKS];
> -	u16 id;
> +	struct qcom_icc_node *link_nodes[MAX_LINKS];
> +	int id;
>  	u16 num_links;
>  	u16 channels;
>  	u16 buswidth;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

