Return-Path: <linux-kernel+bounces-247843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1670C92D567
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478A81C22362
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E4194A5E;
	Wed, 10 Jul 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4GILrDZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658461946D9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626867; cv=none; b=qXmBjmNrlPgkoml2f90SZCVW5GOTUJmR58L3k2phmhtMBygkxZ5TO6vYfsc8w7CHLwK+VueWAYw5/OFxHHpZD4Ntb3MY4WwQ2WEweg1lsDnp40ZrfvUcize5DNl3PQBhWwBKbMfixowu5lyDHyMS5AFCtdlLP34iwmr7TZtMWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626867; c=relaxed/simple;
	bh=5zXJc6o5WFID6Ss47lJRv2Q5FBvPxZYh92dhVrPPWiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2RFOcvjQM79Llbm7TO/bI1FrL1w4t2EnLhOxqPWf+jU1iC20e/84y/Jj208Oy22MPtMsee6FDyAWekTMZ7N+kl1OvdnjqMGIGd4S6Y6iz3RSXzzfIph6ku38an/OCMWdRsxkcWWqF0DzxoxroSIbJ5rbPc3TrM0MfTFYm/qcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4GILrDZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af3d9169bso4311712b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720626866; x=1721231666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK0ZtBYtuw7fpnAqJ6Vx7USrS3cI47s6ZHZHseYaOts=;
        b=Q4GILrDZpn5ibtUSGcQ0DjtKsKpfd/x/bZ/Rgug8GoMSnWq11LwIfihcTxcZZ4mn4t
         zQLRcn/mmSnBFtk0gXIIAYjjiBTt0PHwEUttoSbBUHDV/n+Mt/WxA7uzwugnidAuYHGn
         TLdJHp3CvzpjOlEOOdzIKzrBFTsfOAE7+ZwSXjtT4P3NrK4uKKw5xaVOsVWNSEe77s8+
         MSDNHKvMG4o3xjZBTZiF/e4U+12TM5VrTZdrSJ4KVOKeeC24YhQjsO3JoCNm7FMHPwHp
         clFrqOPIw2z1IdbrhgTlpWNjfZBhQZ+wlobb/UrdCzplhSKkEeq7DPCNR6oYHOpMqZW0
         cesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626866; x=1721231666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK0ZtBYtuw7fpnAqJ6Vx7USrS3cI47s6ZHZHseYaOts=;
        b=KU0DOndrflWyp2w639zYVRcpDBawOMOXabqUAHQhWqv/gVCW4t6vcNgGei1VeCeWt1
         Q7QknJ3bOA55dq9NMb5atKKns0G9S4TrHRvAsjD90mlfNT9qjeqPkDmRYNbMHkdwbtD0
         yrYFaSkhfwdR8CG5OIOsgSBPQYRdQPa8hNXUKHaEDkvaM5klolIZtr86xudGBeMDPiwg
         KeLZisPQY8k9YEOK3EeNQHdgSlgto9mbvJbJJSp02QrnA9itwYoar12KzIpeQn4NlVFI
         PR1LUsXnW1Q7bYRGspprQ/am+6REi3hyhDH4JXfHiBxy4Ybg9xtGPCYIeWwS78/iPzxW
         P8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUWywpZWHu1BX6DbXA6uxIUJLEB+0OuxFFkmROFZxvfnCYpvpW8FMKr6jOuz+DD4Qw5Juj0H//tavt42aayXbeQwz4lSRoItanvKsSY
X-Gm-Message-State: AOJu0Yz7zUeRuKlGOCVrtRuPjaWEYUlqkVYVOvNQRP2XvMInqg7tDKeF
	2Y4+w3CQh0/59ZfWLW/8NQp9Tf+hhOrJ0iXnBrbY6ko3+ZG0t4sUbkgfEwFdzc8=
X-Google-Smtp-Source: AGHT+IGBjfdGcpzMj6d4WA2gZ3ribwtBdZ/W3krvf0I4UIgH0q8heu072Iu/MgBGkLWE/ls9bwaHVw==
X-Received: by 2002:a05:6a20:a11b:b0:1c1:61a9:de5a with SMTP id adf61e73a8af0-1c298243012mr6526092637.32.1720626865760;
        Wed, 10 Jul 2024 08:54:25 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8408:4ecd:288d:848b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7687sm35271645ad.140.2024.07.10.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:54:25 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:54:22 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Shun-yi Wang <shun-yi.wang@mediatek.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	jason-ch.chen@mediatek.com, yaya.chang@mediatek.com,
	teddy.chen@mediatek.com, olivia.wen@mediatek.com
Subject: Re: [PATCH 0/1] Support multiple reserved memory regions
Message-ID: <Zo6urhrP/Wl57sUp@p14s>
References: <20240703115308.17436-1-shun-yi.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703115308.17436-1-shun-yi.wang@mediatek.com>

Good morning,

On Wed, Jul 03, 2024 at 07:53:07PM +0800, Shun-yi Wang wrote:
> From: "shun-yi.wang" <shun-yi.wang@mediatek.com>
> 
> Besides the reserved memory region for SCP, there are additional 
> reserved memory regions for specific hardware use.
> Currently, only a single memory region is supported.
> Modifications are made to support multiple memory regions.
> 

This is the changelog that should be in the patch.  Usually there is no need for
a cover letter when there is a single patch in the set.

> shun-yi.wang (1):
>   remoteproc: mediatek: support multiple reserved memory
> 
>  drivers/remoteproc/mtk_scp.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> -- 
> 2.18.0
> 

