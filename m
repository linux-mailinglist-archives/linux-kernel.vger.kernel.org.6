Return-Path: <linux-kernel+bounces-211825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1490905779
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B0F1F28B49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7677180A83;
	Wed, 12 Jun 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2fEKgNO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135B182AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207651; cv=none; b=X2etvkYR+22lUny02JNlbece4bkgfyEkPCA0tRxOz2nSMNAygBmyor/dfkI4EuIZJ1ztoddKvkTB5pLQ64PrtlP+OAoXSTo8AhJoY1WtHWpD0nJGzWV5vmAXAg7iw351E2rp74NPBv2kiIHJE96GHEScYcZKJNwdRrbhbblNcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207651; c=relaxed/simple;
	bh=QdhPZnflueKeszAeF4v371ojdYwe9ACDEG0gUSVvmtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNCTi1emumNJOPMFoGBDgAY/dZOOOiXj5dWw/dr2R3DYszAIShAhGYdzigtaIv14XL1rdFmKooRgaMGl26ZnHDcLaA1gFP+ZhH1RKzNI+lXkc1XWju2DJXORDjxEq+eQjRv3PJv4ThXeRx6FPEJzsoQSCZvOxEmHIMeI3ieDXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2fEKgNO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718207648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWITcPld692gjBNY4dq4HSNit6UcpgCJOc4MJm877h0=;
	b=A2fEKgNOjrI+g/5hLGcuTvUau7T6yskTxQ/BxyWQeT63DSUy5Hcgx6CauJGIOAl71St4p/
	PhUO5fpySHzaqreXaY3YCmu8eqRnMfC4ye4zhIK42BP/HDSqc2KxBqVfQkG/Tk9hU7QF6T
	CoNT+8NWdbyIk5ARNrPgbIfoWa/Dtz8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ylgDqTpaMkWuAu5eIWyGlg-1; Wed,
 12 Jun 2024 11:54:05 -0400
X-MC-Unique: ylgDqTpaMkWuAu5eIWyGlg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E1C91956095;
	Wed, 12 Jun 2024 15:54:03 +0000 (UTC)
Received: from [10.43.2.69] (cera.brq.redhat.com [10.43.2.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECEB919560AB;
	Wed, 12 Jun 2024 15:53:58 +0000 (UTC)
Message-ID: <04c8da79-6d94-406c-b168-73c23a9c0e43@redhat.com>
Date: Wed, 12 Jun 2024 17:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ice: use proper macro for testing bit
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marcin Domagala <marcinx.domagala@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Konrad Knitter <konrad.knitter@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240612154607.131914-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20240612154607.131914-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 12. 06. 24 17:46, Petr Oros wrote:
> Do not use _test_bit() macro for testing bit. The proper macro for this
> is one without underline.
> 
> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> index e4c2c1bff6c086..b7aa6812510a4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_hwmon.c
> +++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> @@ -96,7 +96,7 @@ static bool ice_is_internal_reading_supported(struct ice_pf *pf)
>   
>   	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
>   
> -	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
> +	return test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
>   };
>   
>   void ice_hwmon_init(struct ice_pf *pf)

Acked-by: Ivan Vecera <ivecera@redhat.com>


