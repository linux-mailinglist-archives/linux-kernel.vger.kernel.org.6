Return-Path: <linux-kernel+bounces-391384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C239B85E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EF1C21A70
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756C1CEE86;
	Thu, 31 Oct 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITP1XNRk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B01CC8A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412603; cv=none; b=Sy4JpcjqlTdu5FbUeb001Ix90n5hHIIGqf1/JDzOceAf8X6B8F0DhRxRacVjuoaYXBGAYOL0FbR4nWbqhRnvmFsG0ojbmM/iCLl907EzoDv3RhInsM7gBNUE3nPM8vWB7a82WStb/OC+RXFI0/Rv93ZU583e1J5Gy6BBa4WGTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412603; c=relaxed/simple;
	bh=9jy7OKH5Gw4DyEdcwI9/11CnAl9Znm8UsxuOcfs9oDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1sHwsADyi/RpoAXmeNyDQpM0n6WuEsLkLXf7ftUsyzdUMpvo+gnzQ1x1NWNH0vh6CrXGJUezb8ggnSSvflb+fn3NIacELKW7sL7nsuIWrTtEU6bWosRXt2W4ZXtascGlCkbLkF7MlT87WtI5Nc+Olm5v8wF5UBMb91U5S5OYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITP1XNRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730412596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdTjHkCcsfnnKS2t3sdvmvU/eSjQzYm9Ho2FZ+8bgBM=;
	b=ITP1XNRkGTdv8SPj2TBL0vuz4dn/9fkrGdi90E1EjA0Kv4hb7/aoyKfxMNogpIt5RnCTuS
	hOY3BlljfN/xA+Kx8d2/f1gFQ0XJa3SBpWGED+n0EVRRYndGQ/1t67+ECVrXwYQzYfu9wz
	zX/0ytMXbuXuY1P+zf6tqW/zJBucMDo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-hqUPbjIoN9-8T9vpaega-A-1; Thu, 31 Oct 2024 18:09:55 -0400
X-MC-Unique: hqUPbjIoN9-8T9vpaega-A-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4dc12d939so2314635ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412595; x=1731017395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdTjHkCcsfnnKS2t3sdvmvU/eSjQzYm9Ho2FZ+8bgBM=;
        b=jtJHS3noQe1Xf7UzSmm6O7Vja7xtrPbf4CmXMTK2a9/Pkv7FJUYZPd5rQ4kmBeLTDH
         CbDTrN/LgZ9JfWTHhgmYj+Hql5YKIB0SY+j2uzzv80yWCaG3QI94HCMZFcxCLk609Iiv
         auJMSiII1/ouWAU5WBgCgS4EVEixv1FQp5JV/zcn1nwOnmeuuFNOMh18URNBzgQ4uIc6
         wZh8mDdVQLy/DXa8DC+E7xXwlJEsI+KCqb//Bg1tF8x7ZpcRj6wepejNII7kuBsqWzlQ
         CHW2MzICVY40vRYdtIb+cBtvzsQcOl9JbgXrxvha7zZk+igfVPc+eaEitGpzEAjq1z3F
         oq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW5nOhFv8+ZC/V+NDZhZXi8SO6jFGagUcpwoCOtlNj4UF3zp4AOBonR5gtG/tgKZacqmCV3kNFij9qCyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIUrEgjjIOaGZtWsspU2buBnKr34GuPIhcsFVNZub7HgqEC4J
	PvEHeInXHbj+3nUKYfsmUMJaMSjpSn3WXEdPTn2r0AMXbzSr3K2E1EqPam/gfjYTNTUceaZ5aEQ
	qD+wHL9xF6dg2KC4+uWMLZl4XHpl5+mc9+H/52mGSp90ucnkAvmNdSfnpki61zg==
X-Received: by 2002:a05:6e02:1aa8:b0:3a0:9c77:526d with SMTP id e9e14a558f8ab-3a4ed28374dmr53647045ab.2.1730412594743;
        Thu, 31 Oct 2024 15:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHes6NcyeGK9ZmJwopYOsZWbir4fr/Y/edup6IPaveMm0NTJdKZw7jSWysnUlNcfO2TCoircQ==
X-Received: by 2002:a05:6e02:1aa8:b0:3a0:9c77:526d with SMTP id e9e14a558f8ab-3a4ed28374dmr53647005ab.2.1730412594307;
        Thu, 31 Oct 2024 15:09:54 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977d7esm460341173.99.2024.10.31.15.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:09:53 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:09:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v11 4/4] Documentation: add debugfs description for hisi
 migration
Message-ID: <20241031160952.3b93d4af.alex.williamson@redhat.com>
In-Reply-To: <20241025090143.64472-5-liulongfang@huawei.com>
References: <20241025090143.64472-1-liulongfang@huawei.com>
	<20241025090143.64472-5-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 17:01:43 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add a debugfs document description file to help users understand
> how to use the hisilicon accelerator live migration driver's
> debugfs.
> 
> Update the file paths that need to be maintained in MAINTAINERS
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..89e4fde5ec6a
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/dev_data
> +Date:		Oct 2024
> +KernelVersion:  6.12

We're currently targeting v6.13, which is likely Jan 2025.  Thanks,

Alex

> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the configuration data and some status data
> +		required for device live migration. These data include device
> +		status data, queue configuration data, some task configuration
> +		data and device attribute data. The output format of the data
> +		is defined by the live migration driver.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/migf_data
> +Date:		Oct 2024
> +KernelVersion:  6.12
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the data from the last completed live migration.
> +		This data includes the same device status data as in "dev_data".
> +		The migf_data is the dev_data that is migrated.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/cmd_state
> +Date:		Oct 2024
> +KernelVersion:  6.12
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Used to obtain the device command sending and receiving
> +		channel status. Returns failure or success logs based on the
> +		results.


