Return-Path: <linux-kernel+bounces-439802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489409EB414
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0411882842
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2601B425E;
	Tue, 10 Dec 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pm8K3wNB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706EF19CD16
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842591; cv=none; b=qv4dQbALFSmzVGA0hdjARmiwBppWMdzZxkp27XADFpOqkDQ6KoqflihahqNSn+Pfi1iuVixvocvDMPlVqzMLha1KLkSJdXbOIWjt7ZEVa361SWjws4Ye2js8EoDczf4M7fveNeog1/sMHTcVdnjvZuJxu32cMs2fYD2PHZsrH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842591; c=relaxed/simple;
	bh=im4r83/3MFTa7dU7WjsfCIHgV3XDNMNtyYTcEIAa3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3vUK7zT9NP4+a9+qGKg6c0sI0B0dNtC99oloRxxIAwVK6jrcKs+OkjRXsXZVYJ51t0n6po4O6QJRj/Fv2f50SjEZOoOSCnEfqtGONFMN9NsmmIuSuP54pwo007pfPxvSpHlYaNviseczU9L5fNf7ldJ40lCfBdQ94IZkLkJI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pm8K3wNB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d88cb85987so44115346d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733842588; x=1734447388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgMZyCVjX5UlsD7+dFf6mQ2S1Ak5PnTha55MEVmA3OM=;
        b=Pm8K3wNBSj1m7GHbbI4soC60iHHFwwoxdiH62co67hwkh4aaH4/lmB+Oag3Ux8WN04
         gttW0Bu5qGe2wi8ZVcJlS2uxOkbyDnGFrhlIq8bsFu9hsB1iblkelcoOOy3Dqe8d2PQn
         5vEMIWHd5HWqKPkNnL8QbzccxRzwM4E67Nw+jnZXWg3NyH7eSzey+inBooGC178ZMloJ
         6AWtNaF2QAwbiWAVeB3ofcaDIGoFZn0ifb0oDfE95TR8EWeL6LLgxY5nEPWAtVdbhW+F
         qDcY9WRmEipe9S5yfF4jzFDDa4+lVrRBGQyodQLyXzCaouD2rQfhrlKhSmkylPpHQI8n
         FELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842588; x=1734447388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgMZyCVjX5UlsD7+dFf6mQ2S1Ak5PnTha55MEVmA3OM=;
        b=Jqg6/fuezOukCkVg/J1D42/tePahzD5B0tusXQL2Fc8YrGVY/7YK3aziHUaB8UWtkQ
         ExeIGkCp/D9C9nWZesHvvm0cf4JBsMf7ShqoZz1X0qbQ3++qFkyCTMZNBzyhdo3q6Mw2
         8rOEP8y8ULHEk5lrW5igrNK67oPKWT8Cia2nzH+PyJeaIwyrzmWrvMiIuJflrQqO0Y4g
         R1yF+KVDebT910OrP7n7kAAsXvsGcQCRreoMmhNCmHu0KfeC7ZYTOENnZx0RoWN5voLL
         hy82fVEdkQyoUNsYL2E2kI8HmwizAfhawI+P9QTrg7HXTsugqT8xnpWAJf0Vn4XgMG2Q
         t0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8Ld96ApRvbukRbHI4qViHpwL+vfB4YpiiZOYEjiFuw/DWn8V4dd6LXt6xH3IyLUFrdXMaz1VZapNbJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GjyCLPdk6FsDhdhVRR98pbi0VAHG0nKj9abhYyI9N2Jrbjb3
	2GfNVwfIEy6oZ+bsFbqr88pvso3/bLMw4NIPOozzHQt8AmIU3Txn3YIEm5oMp8Q=
X-Gm-Gg: ASbGnctRIZN3Uhgc2dn7hBVj+Cp++pscVYY+bbwPqKsw4R1cgMFPeZjbqeLGBjDQCv6
	U3m8NM+6PSp5Tpp4K+j9ZxD0iBSO19HzkUGcBL9QOrdIPDmYWnBPf//EuzYZ1ai34XzuuBoNfmZ
	r/Pge1q3B5xN7C/3rbWF3XvU1eX1XcdaldoR33+5diz/mS0pEwN4jGoixvmymvACiBiu9b9SMm0
	g+h952nXhYA0LX++Lc8SIiBIxW8R81C2MY19YD4TtI9YZbNPUN1Y/QEyEawO7G7VThvOPWOyBCQ
	vM8llKI6Dmc7DmTkPH+qVcBigv4=
X-Google-Smtp-Source: AGHT+IFfM8EwNH3V/eEsdSGmByzZEtkSueHYuu1In0U8rV2p/p6b9CdRa4FvcdwQ1MsV2//64ZXC7g==
X-Received: by 2002:ad4:5304:0:b0:6d8:a258:68bc with SMTP id 6a1803df08f44-6d9212d61c8mr48969336d6.11.1733842588496;
        Tue, 10 Dec 2024 06:56:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fe9e1sm60627086d6.82.2024.12.10.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:56:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL1f1-0000000A2jg-1ul6;
	Tue, 10 Dec 2024 10:56:27 -0400
Date: Tue, 10 Dec 2024 10:56:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241210145627.GH1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210130351.406603-1-bmt@zurich.ibm.com>

On Tue, Dec 10, 2024 at 02:03:51PM +0100, Bernard Metzler wrote:
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 86d4d6a2170e..c8f75527b513 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -69,16 +69,19 @@ struct siw_pd {
>  
>  struct siw_device {
>  	struct ib_device base_dev;
> -	struct net_device *netdev;
>  	struct siw_dev_cap attrs;
>  
>  	u32 vendor_part_id;
> +	struct {
> +		int ifindex;

ifindex is only stable so long as you are holding a reference on the
netdev..
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>  		return NULL;
>  
>  	base_dev = &sdev->base_dev;
> -	sdev->netdev = netdev;

Like here needed to grab a reference before storing the pointer in the
sdev struct.

Jason

