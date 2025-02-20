Return-Path: <linux-kernel+bounces-523635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625AA3D977
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E373B754E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144E1F4735;
	Thu, 20 Feb 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPWwdPZ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1F1F4615
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053179; cv=none; b=s2QzKm3Y0FArSJOSxRKHDOu20wAXS6y5ATBrryXfjhbpvuLnHgInGlOXKrt8d+WeWcryhah2iCkjdKzvJJOn+lkcmin8bRn6mXYrIecq4PWMSmPdy2/746q+03iC4N+bLkFELzilkIQ054ECuCSqnSxhXWHez2nb4z8DbGygGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053179; c=relaxed/simple;
	bh=1g9+1cZqge8rnomoAmd54b5eLonL6/ZnUBtX4cRQtmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kXb/guzAUtPUyve85qDrizZ6jrB+xMk8yATJcdrF/7CiJXjeKCdEQNmtzV4rOGs9ZabedxFCRN2IQBoXqPByKJkuUPp/z5Od1KIfhbpel9HZ8E+vC8qZgx7H0/C/nuthCkWaeus64ttZC/4Zf0ryCT0FLgTBU0H5N6WYRMjHc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPWwdPZ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740053177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ho/1UvI95B5CQStQMwkcH2O7mPFLu1K1yaiiqa4yxE=;
	b=YPWwdPZ9FiWoBJjjFrOr9c0sk2uaPus8nmnBoEXYSwhL1Rzc9iAiEqJ8eI2OiCpSI9LEkA
	DsQk8kYHe9zaW2Ipsnvta9ZwADKyeOJj13OdCDDaFtHETPhtqn3kXEKR0/IH78h5N51YXV
	ZZPkvVVwOA56FgNylhBuUv7bQgwKxPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-E_RDIJATNvmeF34mAGKLwg-1; Thu, 20 Feb 2025 07:06:15 -0500
X-MC-Unique: E_RDIJATNvmeF34mAGKLwg-1
X-Mimecast-MFC-AGG-ID: E_RDIJATNvmeF34mAGKLwg_1740053174
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4398e841963so5613155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053174; x=1740657974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ho/1UvI95B5CQStQMwkcH2O7mPFLu1K1yaiiqa4yxE=;
        b=SyREhGEgGW3H8SXgEu1+td+plkpMlbG8u+J163Zv282w+xNQnQqDZpKCHt/AnY4In9
         HArtHZvveRNzB2QXne8F4U4kQZf2GwzZxKhg3Te/dKEaPO2ofwLMj5yZ3qQs86FthH2J
         zFmz0gkSjFeyT3vjjqONV5SmVRla6pH6r7bOMSIfV9DMTnXQzKLcQesSz/u/kZM5+bXv
         +SxhucWTqK59x4IpOyBFzrqyqX9SkWS7JUZw4LYlGu5Zo2MsZJr9Xp9YO/bHe1pd1+Uz
         37vjH1IqTzcDbUbUPqeUWmnn5L4OVgqv7bsLmGNE0PxjU4KUqBvxrisVx4My/UwBZATP
         RYew==
X-Forwarded-Encrypted: i=1; AJvYcCVvMk4ulbN7c0gwGoLWZf7CFS4VMkmBmvAQe0OVEPS7iBQUla8pAFMBoyKpzeCEpZZNQ7fq5cYFi+xgRVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XYmCTIiJ56rIbL5E21UCktNvOdr9eUzKnNJ5gsnLtB9emE/f
	THYjhKmlkM2b0dggMUShrXYy/HZwf9WOgNHvgSAWuhPn9850gyBn0vfibQBgSG8XvRvzgBxOxIs
	4mU47Q88KmeyNNpjZA3NiAFcKLo0W0Dzib5/eZ2zS57MmtjZmOoBIOhO5ebZ7Cw==
X-Gm-Gg: ASbGncsUDjWBw4QlBMG2HE2rFFp0iH7c0Yv0cbChqzB15iuAkUlI4ZYiyZwFyHjzv01
	Iin/DwRH2vrdT29XKyzreR2LH8NWon0GDCUaIKYiaowJfYBqjAJMKveyMQQE7VBXb3zT/W0SPag
	Z2ofygt1bX/EwYwVAkHUPx5GjLlllFFyf4Wjn6T0GTda9n+qFSbEjMh/scRm5VaM5hCRLY13gZd
	TEz/61ULunt2I3WKQCl9L7XRaf2D8DeEcU/dIAN2f5aossI6SQ9cgVmHC+SPLFWXsefuXZdRcBl
	wf7o+R4Yu0lJJ7Trf0/RFGiamQwx0uSXOmg=
X-Received: by 2002:a05:600c:5246:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-4399e132fe2mr54814965e9.2.1740053174463;
        Thu, 20 Feb 2025 04:06:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd6GsM8jbxZduW4qm186TbxSW/IS1olT9UzqrdZI2rJSblVbeQhFUlIcSSzG9+n31CSQZzaA==
X-Received: by 2002:a05:600c:5246:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-4399e132fe2mr54814715e9.2.1740053174115;
        Thu, 20 Feb 2025 04:06:14 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43999e5beebsm54710255e9.22.2025.02.20.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:06:13 -0800 (PST)
Message-ID: <d35d5b44-e0a4-4d07-8199-dfc916962c39@redhat.com>
Date: Thu, 20 Feb 2025 13:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 5/6] octeontx2-af: CN20K mbox implementation
 for AF's VF
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch,
 kalesh-anakkur.purayil@broadcom.com
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-6-saikrishnag@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250217085257.173652-6-saikrishnag@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 9:52 AM, Sai Krishna wrote:
> @@ -61,3 +62,49 @@ irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
>  
>  	return IRQ_HANDLED;
>  }
> +
> +irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq)
> +{
> +	struct otx2_nic *vf = vf_irq;
> +	struct otx2_mbox_dev *mdev;
> +	struct otx2_mbox *mbox;
> +	struct mbox_hdr *hdr;
> +	int vf_trig_val;
> +
> +	vf_trig_val = otx2_read64(vf, RVU_VF_INT) & 0x3;
> +	/* Clear the IRQ */
> +	otx2_write64(vf, RVU_VF_INT, vf_trig_val);
> +
> +	/* Read latest mbox data */
> +	smp_rmb();
> +
> +	if (vf_trig_val & BIT_ULL(1)) {

`vf_trig_val` has `int` type, why are casting the mask to unsigned long
long? A similar thing below.

/P


