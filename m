Return-Path: <linux-kernel+bounces-209546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780DE90377F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0062D28726E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEAC176259;
	Tue, 11 Jun 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3DRp0dr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA817623F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096988; cv=none; b=XiRWMs7FJ/Sgeyfw/h/by9pLTJ+zpdaC5WYYAMloQXsX3TqnQ1Y97O84y31PJul86zeBve4lgYQJpHDx//5tpyWmjNk/4wry+JA2tl/K9qjOmayHxmiY7c1FbO//TiRwjYsRO/SQpsNgv6g9PheHj8guduzBOQO8mjuGAxgeZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096988; c=relaxed/simple;
	bh=i0S4WNj+dZaz3hdz9rhQaN2ahipED7/FlbM3wn5jydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9cMuqsU3x31SUNPTLlm97n8Aj99RJ1KwglzJLXIlZcUgf39EMoJTOQD/8TOotMMCh/dXfOiuxgt8wRYGkaCe+4/SNg4HbrML8dKFVTpTzYljNU+wKZwSMmJRYDjPl/yGUgfxuc6ea5fkf66Al41wTMg/rpj0CbBHVojQx85iqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3DRp0dr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718096985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ6NmEpm203v83OTy1RMNtAkzbu+fQMhPGN0G4SJVPY=;
	b=Y3DRp0drPMTWvUhgWN7OOrZTDOl1MZVMls6e75ksl5KrUWqlNXj2mW04PRfQdKI2eXTg/H
	5G1eJS/sIyNe0Jx/Vpya1HpJfRGjAZdDnRq8Kh7WjobHbHZjnKzwIjbUP/CwCPsTyjk1YP
	8R82thHS9wnRDklSew5ogBlUVkKNqvY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-WwYsjR35P_OGqUmdm9STpA-1; Tue, 11 Jun 2024 05:09:37 -0400
X-MC-Unique: WwYsjR35P_OGqUmdm9STpA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eae7631293so32368041fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718096975; x=1718701775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ6NmEpm203v83OTy1RMNtAkzbu+fQMhPGN0G4SJVPY=;
        b=G3KrTy0/Rxe1Xxft5YHRM9RoTAkQOxYcxqcLgx81u9dR4DiwIacKdDTbhxFiUqbHl+
         aXZqSKX+ECItRT2hGKyE7VMk0ejZk0Ky3yBwDCr/a4D1wxJhei7Mm6qngBi3S3c0qabT
         FguCK5rwfMatetyiJW3W+i/8TvAseeumPtNoTD0XabjFQEFP56Zade2EhdAJOu/6jNrZ
         Dj5NfDmzbHijzK5flA3D3Z35CMMeneGQ+L0Pg9XEA5Q03ApIClqu8tC4MagLoRv3WSp6
         9SAAjpB+tRRLdeCZ46y9pLro8uXWbhpDzMk5Z9HgtfmQ0t+RTNt3KiYuIWORw+hJFgkl
         khrg==
X-Forwarded-Encrypted: i=1; AJvYcCXKq6H1RP8rGtgjLMlrVUx/Dwe6hcS2mxshT5RymL9LsEw/49Oav952OMZnewfgrm+IdUlV4upPdVaM8I2SBAu/hX/83kfSvZPfGUxt
X-Gm-Message-State: AOJu0YwcZpo9Hx1QdU8EzUbzWOjrAci2Wp+Mw+tZDOFNTmhlD+vXBLR3
	svCzoy2AfS8QQ2YpVwqhmoS7SfLIqbj9Zj30ZdjPH8hERgxvkI+r6H6F1H9LbeJZ0gxykd1vlrz
	wp8DkuUxSWkBtviFV4lgBhw+UhORUv0P6RaIJ/QU98fy5DLBMeIL1ZZizgaYplA==
X-Received: by 2002:a2e:8004:0:b0:2eb:f5ec:5ad6 with SMTP id 38308e7fff4ca-2ebf5ec6fb4mr4791201fa.0.1718096975461;
        Tue, 11 Jun 2024 02:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7wwWojKAzRVTdY5Y8CDndML4n5EP/ZdMfOeDFja/TJ2/4XahWfKaFctCxnoWRR7nsots0ag==
X-Received: by 2002:a2e:8004:0:b0:2eb:f5ec:5ad6 with SMTP id 38308e7fff4ca-2ebf5ec6fb4mr4791061fa.0.1718096974914;
        Tue, 11 Jun 2024 02:09:34 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4218193b0c0sm84032445e9.31.2024.06.11.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:09:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:09:33 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>, linux-net-drivers@amd.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Louis Peens <louis.peens@corigine.com>, oss-drivers@corigine.com,
	linux-kernel@vger.kernel.org, i.maximets@ovn.org
Subject: Re: [PATCH net-next 0/5] net: flower: validate encapsulation control
 flags
Message-ID: <ZmgUTZPFKk1pNxqR@dcaratti.users.ipa.redhat.com>
References: <20240609173358.193178-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>

On Sun, Jun 09, 2024 at 05:33:50PM +0000, Asbjørn Sloth Tønnesen wrote:
> Now that all drivers properly rejects unsupported flower control flags
> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.
> 
> There are currently just 4 drivers supporting this key, and
> 3 of those currently doesn't validate encapsulated control flags.
> 
> Encapsulation control flags may currently be unused, but they should
> still be validated by the drivers, so that drivers will properly
> reject any new flags when they are introduced.
> 
> This series adds some helper functions, and implements them in all
> 4 drivers.
>

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


