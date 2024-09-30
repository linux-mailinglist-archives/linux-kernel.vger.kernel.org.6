Return-Path: <linux-kernel+bounces-344815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3998AE84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7690F1C21A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F547199E88;
	Mon, 30 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="bwxKLXeU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5C199FAF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728628; cv=none; b=oJVjXZUXb5UUa8QoMjlHYvcdkmIxXLuKdjU7a+779w4o3kJvEnQuWOc3Q2JA5ieZ+qlhvlJbc0qyt4Xw7vS5wRfWwXLi01qUaQVWA1Z/EjnLIufwGrMiuS/t+bxI/x9eTtUlnCiALC8B29stL8HNxuv5M2ygoT+8L6+y/2fU8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728628; c=relaxed/simple;
	bh=jnmLdmDuHRs3fPMVKD2Uxf08LN46e+8gtgtN4yECEs8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r8TjbqL3BZknMGXjBicOm/3aDYeIH6Qslu8w6pOQOW5MqQLYkSnrc1tmvwZ6XYlNPg2ganagRcb39OpWYmGNJ4nOuv6pgxpYoXwxFH1ell3ae3KMQJaMwZMIyEYpJK1x1/YXNvFC0kWYSSfz5gvAdQdiipUZOTGKtPu9WVwADno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=bwxKLXeU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b9b35c7c3so10467735ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1727728626; x=1728333426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJJ76z/sCDf8rU24TLfaZ1NtMX+cpeJOgDj7wQ8yj6Q=;
        b=bwxKLXeU8xbhwP7Y7Yf+HQa5C5CXSxJcMjqunLU2/vKKObb45mQkvvIaWj5mKLvDvy
         efKqLvFXCiwbsKtcgnG1lrLWMrrsDbvNNhUTEb8VtCXpJjcAg/Gz0qZ8cKO6D6f40XE1
         P+0vEH6RZVRhD00jH3Aoe6Mm0bVsvLTVytP7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728626; x=1728333426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJJ76z/sCDf8rU24TLfaZ1NtMX+cpeJOgDj7wQ8yj6Q=;
        b=XkZK0qccNJ5NVvvTXCndF3W+k4+3pYCFkRaeaiC/BJRLX3Cg1SwXyMMo2SzMzjkCZ2
         QGkcqernf3VBI6zvJNsq2V0oAVptYA8C6OBwYRQ2rSEzAdk+idarLhz6AzCPvcdZmDNH
         uPk+SwvDlglpM0Y4bHW6UOYZuU6ro8sSutHnIvhleK4U6Pifm88py00KrBZKphoW8QjI
         KErvx6X4WgxnkCRcbZyFGpMNkwMUviKT7dQGPnJT/pU0xeDnB5AfHKAWLdE1eZr5aDb9
         xcRlqF5dKfHK9ieX74I6uGbyzx17etzZS23S9BgPbaxVN9UVdbICaYTKofHgBhhWSnc9
         vAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhOmNNN2eqq0SilFZoDJ6jeALQdAajCCOdXytcyhXdzEpwYBWreogACEgjDs2P0tIiMHmjjyh/G6isANQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAaS63B+3mHakks7ZXUoRZdRGaySDdqqcopk1eJjLSGkIZ0fM7
	FryZ0V5/AMjFGzm/wqOqb2u0iUXwWpY9yMD7FGbYtdNgiFpx9B0g0Qq+iwdLPTo=
X-Google-Smtp-Source: AGHT+IHzSn+v65fVebJaE2zPw6HTo2VHqvN2H9hjFKG7EV9XHLnmip9ciN14A4qtC8Vt5uVKPUnhvA==
X-Received: by 2002:a17:902:f706:b0:20b:4651:13a2 with SMTP id d9443c01a7336-20b46512a41mr207109675ad.45.1727728626533;
        Mon, 30 Sep 2024 13:37:06 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:2dca:6772:d6a2:80ac? ([2603:8080:7400:36da:2dca:6772:d6a2:80ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61e14sm58213785ad.279.2024.09.30.13.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:37:06 -0700 (PDT)
Message-ID: <81c9b7d9-5dd0-49d6-bf34-205e1b6cb852@digitalocean.com>
Date: Mon, 30 Sep 2024 15:37:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
From: Carlos Bilbao <cbilbao@digitalocean.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240910022843-mutt-send-email-mst@kernel.org>
 <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
 <4f6db868-d1e8-42b5-92ad-ae22331f5bd1@digitalocean.com>
Content-Language: en-US
In-Reply-To: <4f6db868-d1e8-42b5-92ad-ae22331f5bd1@digitalocean.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/24 11:55 AM, Carlos Bilbao wrote:

> Hello,
>
> On 9/10/24 10:42 PM, Jason Wang wrote:
>> On Tue, Sep 10, 2024 at 2:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>
>>>> Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
>>>> vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
>>>> ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
>>>> see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
>>>>
>>>> Carlos:
>>>>   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
>>>>   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
>>> This will need a rebase. Will apply once you post one.
>>> Thanks!


I successfully patched linux-next without any issues. Could you please
specify the repo/branch you need me to rebase onto? Thanks in advance


>> Note that I think patch 2 is probably not right as we indeed allow
>> config write for some device.
>
> I'll rebase patch 1 and drop patch 2.
>
>
>> Thanks
>>
> Thanks, Carlos
>

