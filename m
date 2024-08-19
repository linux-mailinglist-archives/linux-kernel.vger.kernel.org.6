Return-Path: <linux-kernel+bounces-292685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F09572C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071531F23F02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA481891A8;
	Mon, 19 Aug 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b="YfznrLSX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837FD531
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091438; cv=none; b=OWgxWekLvaH9a9Wc46BFWknIl0qDNnti8k1QgFBLZuwuLWd2dTenwbpLu6LGXtp5A6+Ww3OZMb3Zpgp3iqRNIyjXwSI14EVPsReRVIaSFZSOprxEnBRQNQ14znF2DyltUEBzW5XVhL1w/VUTq2tgCHXmarw0qyxdPSFKu0kziS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091438; c=relaxed/simple;
	bh=vN9VfRlmGvy3YQFxJIT2Vq5YZXks3hjQLPnt55QuAZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+89qyKlBnc3LEqiW2Gsjnc/0Z0YeCvVlm6cCUzA04Ut4uE6PrlucNfiWihe6mPIfx/MSiod/h9G3VoIOfmdxA1lFjVhS9r7yLNF7fyVQZAvBWlnccNer3TSk3jHErAahiOIF2X0vdV+aiE+9vZmI6FtY8S2j3NuN7Llf7EqY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b=YfznrLSX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so36061035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary-zone.20230601.gappssmtp.com; s=20230601; t=1724091432; x=1724696232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8FoZIbuvwQvPWmR1MSeQfa4tcso/BUCB+N66Db04Kjk=;
        b=YfznrLSXQudQiXlI6skTxnrjPPl1Hyk/NbLFBbRRSWsHD3o0Z0WxtHq2okOsCNd1dS
         cu/q5D5IsUxZSsrrME41K1g3nkVLtKc1jxtusgK1rNfhSaEsnraMB38RgqSCwkyWdeiS
         3i0p+/AAV/f8k5FtQdZJCTAlLSErSArhQZKuiafWZPspGer7CrJKu8IMDfY/Ue8rYkVU
         732lXN6qRufWD4RnBqbCFrC0ieGU/MNQ6bYzzz5uueKzwgKxWAL3pEVoKJa+cznrTCd7
         /QdutixkUljsmrq7TBYNBwX9ygqSWN9GVl+Qch7y1NlQwAczRSz3Nkw3gmrg3QiSAIBu
         BO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091432; x=1724696232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FoZIbuvwQvPWmR1MSeQfa4tcso/BUCB+N66Db04Kjk=;
        b=mujDx/G59yfTkhRwpqCOMz90Ul4hK6Y9i3z2k5JGNdTo4f517DLCo+DcaQt0f4/6ly
         ZaIFm56nBuz9Q2oe6T075pAJLp7zwh1RxfRIAVyphiEvdJXc/TOIZxUIvXfmdFv1uKfn
         Y3TjotTgoimPQprVz0S3CN207A6gOJYqYs3bmms1+Ly+Z/myvFtlqZ6/e+z1QRoV0wUx
         YamNA2UAfzD0ObnT8HGLKJcSy97piXq0gsoPWtP9IGwSwwSoh+LE+7qr3SsYWOZAYzBm
         SNT/fhE7zV0z+6IXwj329TnBaTK/B4EKavVOHNkcvjDdIF4DDLdekcjjavTj54/UAb4d
         lLnA==
X-Gm-Message-State: AOJu0Yz6HUb/AyiwkwSA4DGkfl+kwofZM7VuvtskOivd0kDhshhIWBz8
	JhNUPaqm8harB1AT8LFGmCrlVOxYx0slXYCGUUoQuhsltRVXs1GTuadklKWklHI=
X-Google-Smtp-Source: AGHT+IGJJQZeKISlIF5wMeAHKYv3hXnZmpUjyZu3JRdPGIt4k5Qy/XezBg4IK2DyWAizJBAaMttqCw==
X-Received: by 2002:a05:600c:1c0a:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-429ed79be6dmr87170715e9.9.1724091432250;
        Mon, 19 Aug 2024 11:17:12 -0700 (PDT)
Received: from kuroko.kudu-justice.ts.net (2a01cb040b5eb100cb3bcc29e5f2b7ed.ipv6.abo.wanadoo.fr. [2a01:cb04:b5e:b100:cb3b:cc29:e5f2:b7ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f0csm117277185e9.9.2024.08.19.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:17:11 -0700 (PDT)
Date: Mon, 19 Aug 2024 20:17:10 +0200
From: Mary Guillemard <mary@mary.zone>
To: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Peter Wang <peter.wang@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] scsi: ufs-mediatek: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP
Message-ID: <ZsOJKMg8xlpdgoi5@kuroko.kudu-justice.ts.net>
References: <20240818222442.44990-2-mary@mary.zone>
 <20240818222442.44990-3-mary@mary.zone>
 <20240819120852.tdxlebj7pjcxjbou@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819120852.tdxlebj7pjcxjbou@thinkpad>

On Mon, Aug 19, 2024 at 05:38:52PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 19, 2024 at 12:24:42AM +0200, Mary Guillemard wrote:
> > MT8183 supports UFSHCI 2.1 spec, but report a bogus value of 1 in the
> > reserved part for the Legacy Single Doorbell Support (LSDBS) capability.
> > 
> 
> Wow... I never thought that this quirk will be used outside of Qcom SoCs...
>

Yeah I found that by trial and error some weeks ago and noticed your
serie while looking to upstream this change, quite funny to see other
vendors having the same quirk here.
 
> > This set UFSHCD_QUIRK_BROKEN_LSDBS_CAP when MCQ support is explicitly
> > disabled, allowing the device to be properly registered.
> > 
> > Signed-off-by: Mary Guillemard <mary@mary.zone>
> > ---
> >  drivers/ufs/host/ufs-mediatek.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> > index 02c9064284e1..9a5919434c4e 100644
> > --- a/drivers/ufs/host/ufs-mediatek.c
> > +++ b/drivers/ufs/host/ufs-mediatek.c
> > @@ -1026,6 +1026,9 @@ static int ufs_mtk_init(struct ufs_hba *hba)
> >  	if (host->caps & UFS_MTK_CAP_DISABLE_AH8)
> >  		hba->caps |= UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
> >  
> > +	if (host->caps & UFS_MTK_CAP_DISABLE_MCQ)
> 
> How can this be the deciding factor? You said above that the issue is with
> MT8183 SoC. So why not just use the quirk only for that platform?
> 
> - Mani
>

So my current assumption is that it also affect other Mediatek SoCs
that are also based on UFS 2.1 spec but I cannot check this.

Instead, we know that if MCQ isn't supported, we must fallback to LSDB
as there is no other ways to drive the device.

UFS_MTK_CAP_DISABLE_MCQ (mediatek,ufs-disable-mcq) being unused upstream,
I think that's an acceptable fix.

Another way to handle this would be to add a new dt property and add it
to ufs_mtk_host_caps but I feel that my approach should be enough. 

> > +		hba->quirks |= UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
> > +
> >  	ufs_mtk_init_clocks(hba);
> >  
> >  	/*
> > -- 
> > 2.46.0
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

- Mary


