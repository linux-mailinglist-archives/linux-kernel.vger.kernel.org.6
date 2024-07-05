Return-Path: <linux-kernel+bounces-242493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE99288DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4436B23EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4A14AD20;
	Fri,  5 Jul 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7Ns89rD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F405149E0A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183316; cv=none; b=Txax3VOBKJRkaCc4+4c/J/7m06fSBIOSCJ8SFn09IhomOkq7iMu2nP7KG5ZN7YhYaFTQdW5wDLxLcykF8XAPQmjVaNAmAD0VeuFydUaLp+2Q3J2xlBG4PAZT0lWXpyBsNZ5YMaVn84+9b0V9YOpt3xGcUwxlH/oZ28VbW+nO618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183316; c=relaxed/simple;
	bh=0VkwOEYNEGTePOxeBzMH5nAzeX1LMR2wiTaFcPC5G8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkcQASdADm3tcIEo6aE5bsa5/Ntca8RwH/t2Sr2jUWTIOZSPzJbkyScxWBiYjxeLCd19fNvUnEv/hTyFAn/rB0tIisEfNFr+5BSdS6exwXzb3VyvJTjZhfhjgWmW7+YRd+ihRpu+jspSPdhs4kIH5q/fc6btLu1w9qRdmzznQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7Ns89rD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720183313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUmdoRcwxF0vtGDq5CApO6vlw3HSpxN+XRrrWd5A6/0=;
	b=U7Ns89rDjXZfdBRrFoJA5fNqUet0mulb8Wr2gCgsmPX/K2MLDkE/jf+ggDLvGSczlMTWRm
	GPfbGFncWmoOECi80IpDlELpDCB4Slro+ri4mbkCs6bs873C5GDHVmJTe3ufLDgjH/BCz/
	882sAOclsAXaCmV4SNtAAVm1tz0TKVM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hw7AewvSNIqz0IDBA7tUng-1; Fri, 05 Jul 2024 08:41:51 -0400
X-MC-Unique: hw7AewvSNIqz0IDBA7tUng-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77baa2fc0dso65923266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 05:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720183310; x=1720788110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUmdoRcwxF0vtGDq5CApO6vlw3HSpxN+XRrrWd5A6/0=;
        b=CmJ8FzjlKAtSMlBiebtLuM0kEfNLtLbimyDApEPnNrtRZMlIt5CNDlrIt3klYOtF6W
         +s5l56OdJteN5OXz8Bwk8xLqMQuKNf9/fdY/rMr7qMBaLYIea6PoYZgHsmYDKOjYDCPv
         iskTK2qYsYTvfQnfQqTJzBmUlooHmiPm12q4xyZQoH7UTlpYOm9js+Sjzi5HY12CU7+t
         mnGiqWWsZTG7L593rBiG0j6iEbgqiZTdDI7uqgs7w1TpfY+G8EILfBj0LczBq7IAQFTa
         q9N2nvApY2eiC73HjrizxV/eJhLwiRkgT1GUwWFk7eRKxjmjiRpd99O6AW98sUWJFqG1
         cwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQXLouhZWEgOEHnbwfIiZC/P/6xy1QYKVXDGYvi13PHO337ftXW8Qj+VnHfHFegHyrrrrCIfpJTIWKEA7iEaN1hTOP65Y1VTYkcXdB
X-Gm-Message-State: AOJu0Yy4z/FTT7WrJPnTCxQ3J/Zi42O8sYM+mGKTHpm7gpNnugtSidwy
	qjzZaLCdOFEeL4073d6OsVRkNbmQ8bFcs3lunXhjttiQVWkaxTnkfJpJ4JZPps4xM0BAqhRLoWJ
	5kT9+VPyFHSaTVPWQ3H9X4wtobXTSvXsTL7VAt7jc+qIgbwrf9eSxztQQrR14IA==
X-Received: by 2002:a05:6402:26cc:b0:579:73b7:b4cc with SMTP id 4fb4d7f45d1cf-58e5994df08mr4069645a12.2.1720183310545;
        Fri, 05 Jul 2024 05:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKvFDzwRQlV+iTOvh4/L4b/Nx5EKEO6E1JE+809E/tI6VMgbL/Y6rWpOPm+MTM4DSqhdFdnQ==
X-Received: by 2002:a05:6402:26cc:b0:579:73b7:b4cc with SMTP id 4fb4d7f45d1cf-58e5994df08mr4069621a12.2.1720183309878;
        Fri, 05 Jul 2024 05:41:49 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58eb85cc1bcsm1692664a12.94.2024.07.05.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 05:41:49 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:41:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
References: <20240705112821.144819-1-sgarzare@redhat.com>
 <20240705073017-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240705073017-mutt-send-email-mst@kernel.org>

On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
>On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
>> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
>> filesystems (e.g. XFS) may require larger minimum sizes (see
>> https://issues.redhat.com/browse/RHEL-45951).
>>
>> So to allow us to test these filesystems, let's add a module parameter
>> to control the size of the simulated virtio-blk devices.
>> The value is mapped directly to the `capacity` field of the virtio-blk
>> configuration space, so it must be expressed in sector numbers of 512
>> bytes.
>>
>> The default value (0x40000) is the same as the previous value, so the
>> behavior without setting `capacity` remains unchanged.
>>
>> Before this patch or with this patch without setting `capacity`:
>>   $ modprobe vdpa-sim-blk
>>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
>>
>> After this patch:
>>   $ modprobe vdpa-sim-blk capacity=614400
>>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>What a hack. Cindy was working on adding control over config
>space, why can't that be used?

If it can be used easily with virtio-blk device too, it will be great.
@Cindy do you plan to support that changes for a virtio-blk device too?

In the mean time, for the simulator I thought that this change was fine.
It's just used for testing and debugging...

My main question is how to use that when we have `shared_backend` set to 
true, since we use that setting to test for example live migration. In 
that case, how do we handle the size of the shared ramdisk between 
devices?

Thanks,
Stefano


