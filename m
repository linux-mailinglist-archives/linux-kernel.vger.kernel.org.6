Return-Path: <linux-kernel+bounces-297436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFBE95B847
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CE9B2737A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F31CBEA6;
	Thu, 22 Aug 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GiFrl87j"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36841CB154
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336643; cv=none; b=Kr4hwSnR/RT+OCVOZJYIO3cQwiOjR+YQYzA7x/6OJgLQbENm3MNft7PmyOAVy/MxwZEexxz+3U694Pe2ORSM2pD5qqbILmm193Sr38As01cB4bkMO21MdrHYP+eLiM4sADNiZGp5r3TI6AbaU8+rS2MeO6ifFtaWxGNjgl0XE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336643; c=relaxed/simple;
	bh=lkUmh8kqDv6rlpgwNmld5jylwheB9x2Jnlen1l/qcr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh98bMc6zsfqaA36j+rd1V7fPVB5wf/eA4es7BvJZrGP79FlwRMYDKJP1EN5t3MAnBTzUYLwVGhsPPMorzT5OLPxXRsCphF7g6Gf2G1U/kRjGeJ8fzqYVdRzae7+JprpxIxBrbEVwaxVE+6eAJRd89OrnU3ManGyHb1BlGGYVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GiFrl87j; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5343617fdddso368302e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724336638; x=1724941438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0vupdR0O34Z1LoDPZ4y2Q+jEfL3sKziPtGlfr44J9w=;
        b=GiFrl87jVV3jJNSSsJT/8TvYvJg7+vjTZl6bfwFSoMIVlz1sHawIwi7O1QUZxtAqBR
         r4AbAoobLdsMH5wq/dqlJaAolXs+yaEOBhxvWfzUuBjcxxtvKH1Q5IIGeioxWrsFH2rJ
         N46M33A2v4n32czX886mPV8T2/VnoRRg3jMN58sVfwDDHPMIt1T7GVbalIgfiJvSacTv
         ev35I1sl2hwXB/NIGcefVCQfXHjeHMDtScYZgypZA6gk0jFQ2QjCIkgN9e5XQjRBMLUh
         QlMYnWaQ4jrxV8iwwmLnI4zhvZRV9j7CMp/Byd+UWXKUQUXwluUViLG7YXO8rLNG4gA6
         ASFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336638; x=1724941438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0vupdR0O34Z1LoDPZ4y2Q+jEfL3sKziPtGlfr44J9w=;
        b=gd9vXyuq8gE2kiFi9vrABDFMd9sm1d4mXmYeNg5OjICOwJ7U+7ptc5a2Uxw7Fap5ov
         65FDLPbann0d8VpQW0d8nF3S5BCvlqTVknnUcpfclkeunX0e6bqtn+HIJIWna9yjwUna
         8iEhAmIHM4nqBmdCrYW+GaNjyq7kQtwe/P+L2rPJFahIVjVSAfvXv1MDJg9h3MgSjT3F
         wIsdalRVZFUWochiscK9MZld9WW4W381Szlz4Jj4VW9SMm6Nxx4IUHn/uJ7X3yRaIIP0
         aDpBl6LkDD2Uw3rzbZkQo7Lt/mS2g8zRgvvPzc2rLYKr4uqYvamTSRx6NKwfMkc7Of2R
         2gjA==
X-Forwarded-Encrypted: i=1; AJvYcCUPpMSZEbTk4JpfVaHxilcVmCXgCCi75bs7IChq8iK5jaoEnkQF+0g8Y0GZ94Yc0iL4Jp57FnuE8tBbwas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/k0vjPaNbFpeJhybLKS1Tn1brl5lA4YvmHAkrowh35Oc2yth
	V0SOca5DmGO7iE5ZPjf7J1VgbgWwzJV1oW9cUxzvwR7crb5u+6dkSxgQF1rOo/w=
X-Google-Smtp-Source: AGHT+IEqVuMwHdOT5+FeXRdxzeTb7FlqYRhO+iKRdQC+uzG9vreqwtLdAu7nR6PD/W0i+/Q8ZuOzew==
X-Received: by 2002:a05:6512:684:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-5334fae3b8dmr1986403e87.8.1724336637363;
        Thu, 22 Aug 2024 07:23:57 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d2bsm127675066b.43.2024.08.22.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:23:56 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:23:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 08/11] octeontx2-pf: Configure VF mtu via
 representor
Message-ID: <ZsdJ-w00yCI4NQ8T@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-9-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-9-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:28PM CEST, gakula@marvell.com wrote:
>Adds support to manage the mtu configuration for VF through representor.
>On update of representor mtu a mbox notification is send
>to VF to update its mtu.

NACK

Nope. If your patch does what you describe, this is certainly incorrect.

VF is responsible of setting MTU itself. If you set MTU on representor
netdev, it's related only to that, you SHOULD NOT touch VF MTU.


>
>Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c    |  5 +++++
> .../net/ethernet/marvell/octeontx2/nic/rep.c    | 17 +++++++++++++++++
> 2 files changed, 22 insertions(+)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>index cdd1f1321318..955ea941a53b 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>@@ -854,6 +854,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
> {
> 	struct net_device *netdev = pf->netdev;
> 
>+	if (info->event == RVU_EVENT_MTU_CHANGE) {
>+		netdev->mtu = info->evt_data.mtu;
>+		return 0;
>+	}
>+
> 	if (info->event == RVU_EVENT_PORT_STATE) {
> 		if (info->evt_data.port_state) {
> 			pf->flags |= OTX2_FLAG_PORT_UP;
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>index 95301faf6afe..5f767b6e79c3 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>@@ -79,6 +79,22 @@ int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info)
> 	return 0;
> }
> 
>+static int rvu_rep_change_mtu(struct net_device *dev, int new_mtu)
>+{
>+	struct rep_dev *rep = netdev_priv(dev);
>+	struct otx2_nic *priv = rep->mdev;
>+	struct rep_event evt = {0};
>+
>+	netdev_info(dev, "Changing MTU from %d to %d\n",
>+		    dev->mtu, new_mtu);
>+	dev->mtu = new_mtu;
>+
>+	evt.evt_data.mtu = new_mtu;
>+	evt.pcifunc = rep->pcifunc;
>+	rvu_rep_notify_pfvf(priv, RVU_EVENT_MTU_CHANGE, &evt);
>+	return 0;
>+}
>+
> static void rvu_rep_get_stats(struct work_struct *work)
> {
> 	struct delayed_work *del_work = to_delayed_work(work);
>@@ -226,6 +242,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
> 	.ndo_stop		= rvu_rep_stop,
> 	.ndo_start_xmit		= rvu_rep_xmit,
> 	.ndo_get_stats64	= rvu_rep_get_stats64,
>+	.ndo_change_mtu		= rvu_rep_change_mtu,
> };
> 
> static int rvu_rep_napi_init(struct otx2_nic *priv,
>-- 
>2.25.1
>

