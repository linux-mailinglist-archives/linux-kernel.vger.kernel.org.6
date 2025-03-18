Return-Path: <linux-kernel+bounces-565562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559EA66ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891C5189EDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90941DE8A6;
	Tue, 18 Mar 2025 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPvUm0i9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216971DE2BC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280269; cv=none; b=S/2buQHgmO6UEhLsEEFxte/oRlQccclrcyOWRx9e9jU+Fc3vrpF5HGvG5RQBzEvqTnpUQGpi5wSbg/zqO07m3Mj6ZbKgGnk6cNQfDczhlMao0sfdng07IzgZZHTYUmH1RWa2xjPBjcwPmiPkSCJPptw52JeaHG/bAgNn/ZrVOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280269; c=relaxed/simple;
	bh=SV9DG6e6mgA/lOSmt6NefQ8XUMo16/bUKqUU1uGTEag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rashMrkkdKsHaKPEztsimt2gz33g9eXYTrPoI9qfVBPlS2bFGEd+/OvwHh53UDuG7HfbpqAx7yqyVFL5ZC/wB/Q57X6V/32xW5PeIrO6lq3NB2ByBYrhiMfc7t0CnVjnob8JraP9X40EGrmgsZX06rLUqVCHNFh9TyxIq6muZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPvUm0i9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso95543345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742280266; x=1742885066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AXbeE+q9B8uny1O22+JXIAcL6hxd+XvgftLgch9dqZ4=;
        b=aPvUm0i9qEkd4ObL0B9xJC1M6DGa8vxK2pAqRj41rHCnSiv+XCqIs2HJsQPrhoue22
         KHMPOGwrqJC9oYP1liNOrukg0txEZV2nmbe8tgsyyLLKDcc4wzCBbjHTu+ABQM/XuAkF
         RiQDYV5ouBcsGxUVXKLIh44RJK3bbnhUPSOI1ayeia5YhLHxLvSuaPfP4T4PokFIfsNs
         Nvjczk3yLsNZxpsBC22a1Nq0LyytLX5f4Q1B5zVf25v3zDcESUxTAUy8FZMTubGraEnN
         Np4x0X/UudeauO6H6EtOqErJagNTutlI4gd7g9mrfp65BDdz+Wm20bn5OD8PMjmhOPjd
         gegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742280266; x=1742885066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXbeE+q9B8uny1O22+JXIAcL6hxd+XvgftLgch9dqZ4=;
        b=LD0N8sokHYfKYWW/LxJ5Xlz/giULXIkMTHt1xJk6APcIzsALHvGzg45q3zjNQb5VBG
         QHootesv319Sd78p1fk+0rmx0lAxYvh4TZvdLbstk2u5Nm1jRosjhpi0AeZgnutl+VXD
         0Whkkolilr/1GrhrrkO4d7HCHZs9LUhUy+7I1bq6tvP2V2yci6H7tCOQIE1gMygYRDxz
         cy/GG7ojkJi6ThcTFLnloh03M/+Xru4iqMutbtMfTllxczP8edDbzhFCQk19kDNNSlpX
         fdpTaEPemKy+wIcMnek5eTZEd16gZ5GuCQDuRyhTu/+sYeho1KfrAUGADcJloZUKdV4L
         JgBg==
X-Forwarded-Encrypted: i=1; AJvYcCVdjIGhaDtPyA7qdZ8ANj0Rd7Pf5Jt4YDLboMX74X71MUPH3m7sCU1sGxWZLdkTOAjp83zVkiu/ndr5p6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkirS8MWTIO6zf3we2O6FlphPxqsM9P5pJ6E4UsmaND8wctT3
	U5oBvmj6AJ5VrX5ROIEh0Xz+HtEXuDdE61pR/EDLmsy0/geC0iUmwjIByOFAcA==
X-Gm-Gg: ASbGncupMLv+9Ih72wYu1KnnOCP2hU1fox89TofNU/sDNKXflvok/nKpprcofvQRWV3
	OGvrubIUblEUvzI2v3lO/uK3Jay+ksNamhgxf0utzBpECaS9MakELJVTR55qjrzkiUiV1pC+U7c
	81eNUHfra50/yc9dXZzANnWQzXucR9+ne4zGmy+P4Amyps1gQPgp5NkC3kJNMFzRIj8UMqyDNjk
	bv2rc+DHmwwhbuEMs+P/sb+WQNKp5N4H024JpjJ1C0uTsfOvMa+pshea7ZjBLSibahF1uOWqyAZ
	RTKNvWiA1/Ka5/V5/xkIjA2Y4xkeRCrP05Oh1kR9E50OpBku3ri3vcaV
X-Google-Smtp-Source: AGHT+IGUoUDJ5vTYdSQ2RELO/IbV2/iGzzF3b1wNuHTa0nhz/p/MbaSJgXtRU6hyx2Anrag4ph7yJw==
X-Received: by 2002:a17:902:f545:b0:223:635d:3e2a with SMTP id d9443c01a7336-225e0a8f4a7mr180304005ad.23.1742280266436;
        Mon, 17 Mar 2025 23:44:26 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbebebsm86560405ad.201.2025.03.17.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:44:26 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:14:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH V3 2/3] scsi: ufs-qcom: Add support for dumping MCQ
 registers
Message-ID: <20250318064421.bvlv2xz7libxikk5@thinkpad>
References: <20250313051635.22073-1-quic_mapa@quicinc.com>
 <20250313051635.22073-3-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313051635.22073-3-quic_mapa@quicinc.com>

On Thu, Mar 13, 2025 at 10:46:34AM +0530, Manish Pandey wrote:
> This patch adds functionality to dump MCQ registers.
> This will help in diagnosing issues related to MCQ
> operations by providing detailed register dumps.
> 

Same comment as previous patch. Also, make use of 75 column width.

> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> ---
> 
> Changes in v3:
> - Addressed Bart's review comments by adding explanations for the
>   in_task() and usleep_range() calls.
> Changes in v2:
> - Rebased patchsets.
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241025055054.23170-1-quic_mapa@quicinc.com/
> ---
>  drivers/ufs/host/ufs-qcom.c | 60 +++++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-qcom.h |  2 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f5181773c0e5..fb9da04c0d35 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1566,6 +1566,54 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
>  	return 0;
>  }
>  
> +static void ufs_qcom_dump_mcq_hci_regs(struct ufs_hba *hba)
> +{
> +	/* sleep intermittently to prevent CPU hog during data dumps. */
> +	/* RES_MCQ_1 */
> +	ufshcd_dump_regs(hba, 0x0, 256 * 4, "MCQ HCI 1da0000-1da03f0 ");
> +	usleep_range(1000, 1100);

If your motivation is just to not hog the CPU, use cond_resched().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

