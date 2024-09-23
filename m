Return-Path: <linux-kernel+bounces-336166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBA97F001
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E7C1F22137
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139319F482;
	Mon, 23 Sep 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kC5MLjS7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B319F407
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113950; cv=none; b=B1/GANVv3A6k42Bg9QzZbCula9JnblKc0qkdPnw849vsZGzuf6oBIJ+n1o9PMGi6Eb8erg3EkgUHw1tVCZeFge9MTd4bf4LWarN7vC4uEouMluNn8ndkZRt88rPGJJB04u2X1FlenIqMLdlv6BGCvh9bSTiS7nCmnT4korEYBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113950; c=relaxed/simple;
	bh=d012RvO8FEt4oNV/hdC2ORp0abycOdoKV3NqdL6MFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIxQ1kvzF22N00LMiAfM13BdMK+wT/sjAhV5u5qqb4MWm0pgNwqeQflzRuaNlR7agCJ6yCWuhgo2yx8QBIq50dryKwvqiD/6nlGF9UUA7dnCbeY8u7QldnK2grsMsN7Np++KcTSdeOr0K71aDe3aJI9MtnppgtKu3Ex1AdGeiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kC5MLjS7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45830ff5b70so37096541cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727113947; x=1727718747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d012RvO8FEt4oNV/hdC2ORp0abycOdoKV3NqdL6MFLw=;
        b=kC5MLjS7vlx32L+CMo/vijxLpluIvZK6GFWocekev0UAgknUMOwkw6vZ2x/QAQxi/O
         Bc214bhG7DWlIC6bp3btej9mimBmpj/ssPHpH804+PKmzn9qk0S9c7NKyr2t39X/i7Jy
         dxzMGCDmis/JH40iEX0YCAOTCo6I0sXk1kY9UcOA3xFmDNEokZcut4Sy0w+4JpwcVOpC
         V3R0IdkdSvljBaOrLoBYBzB4GrRwS3m98tA4BYkEUatuU8KPFuld/opufxvr05E5vgmZ
         3A4I9bDmmafNkdK1HWGQa2EL19C3dO+81lZcYzGlxoxwnQYtmI3EBw5F0hD9W/4ZRUAs
         pXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113947; x=1727718747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d012RvO8FEt4oNV/hdC2ORp0abycOdoKV3NqdL6MFLw=;
        b=p8GNqudYj8iJierPLuXplJM4Qdlg1BXCVnlSmMM8o8Lv9ZY5STqZMtdbHATzrz+l9l
         lZpNtBnFanp0CyeasQWwJmjmNScPLKwYGUgtW4EF+5I15i4P6iMs27cWt7FEX+iippSE
         uJqAxXp4+RI401kb9MSt1ChEY03bFqyDYY/sxm3pxiju1jR3J4Tf5l9MexmL9qgN4dDO
         ZNcnFHizPHtm/JuR68zHIkg0dxadmV0JgS7wkbc6iCP14pxXTizYYIuhWy+Im+RkQvZt
         3jEOtYbJ3wEHhHY2Oo/We5b8AjxZQoEhqbiewzObM+H7XuyfmObgAyDOkl9bj0BD7k/c
         r99w==
X-Forwarded-Encrypted: i=1; AJvYcCU8U1VYIT3cjm04Y8chVgsBzRBMMs990YyQw24j80Tf78hlWIKIhG1cPfvtf9X93cosm03A9I2PZXQ6umI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4T4XXDnX8r+pqvCI9Y5M1dzn6AoP2qvaT8/1SvrpJMpoM6N5i
	bs8BIiy8qjzilJ6UIFap847okj3zh52lP/RhM2txzy6RCF2arq57IZD2KPtuZ6c=
X-Google-Smtp-Source: AGHT+IHVrqHIowyi3PGsNMuzErMWdcwmU1SRIkTjY6Vp086kbtdmtvbVDAGc60f4mvoOr4wDyCS+5A==
X-Received: by 2002:a05:622a:107:b0:458:35f7:3950 with SMTP id d75a77b69052e-45b226f380cmr178883201cf.17.1727113947576;
        Mon, 23 Sep 2024 10:52:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17888cdbsm49348071cf.49.2024.09.23.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 10:52:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ssnEY-000LlC-32;
	Mon, 23 Sep 2024 14:52:26 -0300
Date: Mon, 23 Sep 2024 14:52:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, zhangkun09@huawei.com,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
Message-ID: <20240923175226.GC9634@ziepe.ca>
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com>
 <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
 <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
 <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org>
 <CAC_iWj+3JvPY2oqVOdu0T1Wt6-ukoy=dLc72u1f55yY23uOTbA@mail.gmail.com>
 <2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com>

On Fri, Sep 20, 2024 at 02:14:02PM +0800, Yunsheng Lin wrote:

> I am not sure what dose the API that allows netdev to "give" struct device
> to page_pool look like or how to implement the API yet, but the obvious way
> to stall the calling of device_del() is to wait for the inflight
> page to

It is not device_del() you need to stall, but the remove() function of
the device driver.

Once all drivers have been unbound the DMA API can be reconfigured and
all existing DMA mappings must be concluded before this happens,
otherwise there will be problems.

So, stalling something like unregister_netdevice() would be a better
target - though stalling forever on driver unbind would not be
acceptable.

Jason

