Return-Path: <linux-kernel+bounces-528634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5596A41A12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526B57A845F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5032566FC;
	Mon, 24 Feb 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6DqRpp1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A366250BE7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391148; cv=none; b=nJId071rYcFgKxnPknEnXmWKRAIM25ej7WDI74GCwsVAsuis7P34R+ta+ScDzeNal1jTr/cxe+NAj0j5cWQ4VnieCqyE/3EnOCb+K+1t51GuWYPuhC/OdWh7EG80PnLS0kpIk8TnDLbgZxyJakw7fC3R20ulPHTSOT4HXmLkYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391148; c=relaxed/simple;
	bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GszwXLCiaaapxc8p6WoaPfYAESCrHHlX0Jv2LQoMDM1+SaKBJepn2fBFR7Jhc0TOZbqM7lNElr50Xoj03uJqTq0KU+0PBS+AUWhLLIoliaR5uGqCU/hUT4/tduMbhxPiESQxcujwPiTU4wZb88g++B6POzjgQEPshrle3RRCa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6DqRpp1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461a485aa2so3871843e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391145; x=1740995945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
        b=j6DqRpp1AqbwMkHB1n9gUajINEUExYQP0kpwjbsOILhltPoFCTqDxSDYpfFVica3Xd
         UlvQkDyXQ19TQZ7WfLeRUxzh0EMMhHUVbewU3ye6evy0mGp3w2bhMpKq6cWsPSAcE/XF
         AXfBf7zVwyW9k33XiG7FBUFo7hqEdF86mtgjDeiOYJNBWjwYEkKM8fzM9DfRJVLGoh3M
         2PWtWV1z0A9h9s6Od7hN2+6AtN8e8fjrprRAmyofTFBlhH1W2s3JWB/ws/uX3hyeYUej
         1NM/Ct8WBeZIpy5AfMQAD7iGL0kbDl0WERWEmphFlswlZC9wodk57utaS5iIxSdOOvJq
         YwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391145; x=1740995945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
        b=qed0Q/s2Bo6jbPzeEmEXvWMqJWIpLBjIzScugQVvdmMNKQL531VgXtBGNT/4DJL44b
         QDPmm+P2OXiWV7EVEs5ze1bpENkGUa1bZhNTV80NjkmBllxaaVnQF8AeV+dd08rl4nD7
         e+ZwdwjozSQBWiBoJBjkNIEzA2mtPnDkCyhghMrC1jDnf+HgGUSWsbtuadTHXjZX1zGO
         WrdHhrIE7XP8eJrQ3ao9u9NF08iNitLETBitii926xeJ3GtbCyCaVFuMXvxfgO70O/MZ
         nKDZjly9s3AGUn48rm642TzrCSsE2CB4voJmhkUvWCdi3opJUIaStmP2UZ7qmEB2nM9N
         MHIA==
X-Forwarded-Encrypted: i=1; AJvYcCXG8fh2/PcXU0rD67q7XGw69OBiKe5D2w75vN1gZtfSao32Mgd5ES0roN4vvSBLy/t5JPbRIKE9obH5lQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlbjmOEVCYT/gtXgT+PqTFXoMGFJ4aagdaB/sjIqgC/GrwK/0
	kCh9yLxkrNB7xW43QrBULR/ex9dkkBwdN22wk/g32rkARHLSwJMXg5fxEDRRGt84rtaMrIXXtIb
	zXjcEDnlnU/qFHO1fEZMlKmMQdTs7Jq0DGpe2jA==
X-Gm-Gg: ASbGnctv4FGedlnfqdWArqKzLzriN0Knvj5tekUWVP7qV0xcEtg/m6ZEsFNKkUIn+1w
	c1DUyq3Fs1pRUkYoW5FU5qgh/+6OS4pIix2CZm6qHNXkiqtEHZI02n4AQpZkf3+fIxLPExfCuHw
	ebxd2sJmQ=
X-Google-Smtp-Source: AGHT+IFopZlwkhYWY/RNr3zDptTVV6+70BUBCoxks79yWFjaOvVN8kY2ZRjnanDMYkS+tHav+OogpdOyTADvZGRmHWU=
X-Received: by 2002:a05:6512:1307:b0:545:2a7f:8f79 with SMTP id
 2adb3069b0e04-54838ef04b8mr5854049e87.16.1740391144587; Mon, 24 Feb 2025
 01:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 24 Feb 2025 17:58:53 +0800
X-Gm-Features: AWEUYZkMSn4vPFEG-tzi12j8lxJKJk5iXrx5HLKwOufSb-G1VhIWg-Jk6pa97bc
Message-ID: <CABQgh9G7Hv-qboRApRrVQF=Zpu5ZKaEf0zrv1=c=zv=LPB-O0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:16, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v2
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>
Thanks Baolu

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

