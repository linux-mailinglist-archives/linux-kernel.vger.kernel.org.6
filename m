Return-Path: <linux-kernel+bounces-546717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F287CA4FDFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C5E1891C22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AD241C87;
	Wed,  5 Mar 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Uovnawnc"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A406241132
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175321; cv=none; b=OKFJCBRU0z7Dcmkv0RYQSnrjmQc2nXhlxyNZ+AZ/XE3JDqY1DZ2ZWnqkOx+6rvDj5ONgvyO64hMmUXSqsL0K3ptulp6ELipqXZNek1077MBHTeoeseO3xF18/Sz53SKctvUD8ZtO+ktvgQ/eQBvqS1sAss64bDrSTCImJss13Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175321; c=relaxed/simple;
	bh=Q21NDekGBNQTIfKbTKns37l4fTuwmkz/QevP9S3vm50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icNMLlPQgfEprVtSYkykkjhSvv11bgexjvz7Q0JbZLplBvg+ISgn7m+IAZLniTipZ29gM0dMHpoh6yqBLt3DYL2Gf1MxRSMOQgRAiVWsKg/VeoQo9rEBLctnVIZVLOb1Db9x4gS/y/JA/MZxHw9dJcYfncT+fsgq/UoGuEVtJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Uovnawnc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so31304515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741175317; x=1741780117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjEwmig9AGzAF/y06SLaWwIs3RII9NjSOkKtK2LhVm4=;
        b=UovnawncvM49TaeC0cgH0TQWg57wNy7LbL9GLz92hJUWJytoA09KUmLFP/BVluyf++
         bifGjXmYU+LszaB1OpXNpB2NmP1rV+oviwPCP43cV3uaQjPcFS6V4s+MmixwBTFiEVTl
         zceVGyrZZhV2V7kXoTqoWnFt/Uuj7XemNcYXIloe4QJy6U0h2UZocUaf0hD91aW3qMKg
         V2RgEsdLlbrnjJrWZyEQ9moKjvqV9t5fRi/Tl0+mzWnoAD9gh23nrt/T2ZdWFuXGjMiS
         pMji/rgrGxQHJQhNMWDZ07Enad0IkR03MlR84IBBbCzU4qRm0celFFQKZYZBlNKj0W7k
         raUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741175317; x=1741780117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjEwmig9AGzAF/y06SLaWwIs3RII9NjSOkKtK2LhVm4=;
        b=C6YXctyhTk9Py9BhbyGMPdF0r78x7B5YFTrGjbY8nBAwmknvONk/0m+UMShjAJDBjg
         ctw3fc3QSIIzZPgVexkBciGB3N1IbmODNmKZJpRndm2bDHxhhf3uaTzCgkNDnKmRJq33
         lqNl/oNIST93vMxODHbzrseDULCKRq8ONtJ/DxI1X2F1lTphsURKdZp33dSCAaIPcJEP
         +52xb52I3zFdwuQlzgfXn14SqO8SHv9RD7noMsCgRROubW588JCCKc8kk+N8cumzsTqO
         A/fxArIsVbw8zyS6RYNOuWB4MOt7JO2KJbDYX6viQqP874si6JHzpF3RBpHNoxu4ws3n
         ROxw==
X-Forwarded-Encrypted: i=1; AJvYcCUQyl0mAIcsWdK1HnTvDd+iOFdoHIskNMLlyBx9BD0VrfJqmuv7502lDB4nQQhtR6E3oi3Q7Wk9DIfCIWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OJoIEAOJEZbrud+8LXvrtCGdivE57w96MGJnYOj3S3NM8C8a
	1EuTfFr1HuyHllDtEIFUgXmQiQfUvBZmPAYSnhflDnjbj9vDUipwV5OUdU1ZlJ8=
X-Gm-Gg: ASbGnctoSRLIKHPUJ0Yx0ef1W5qowB3EIVSnAcA39RZeDs9xpwa9I1dB/A9LGkKseBq
	NzgJt8oJ0VlC+pQ2N87DriDiuXgt2Bxsl9MuQu2TdfN8yGTPtKsLxMogWErtfVBTB3E6/Aeuevp
	6HHZwwEGS8DI9hs0fX31/cLpubNHKQzRMM1Jm61v5cE22k5zG9I/+OvjLQCOgszhfhjKOlmNeXZ
	TbD0dpwn/p1RFQkEWYfK/fgJBbXc5O6Jrb/2Aae8F4vaFCmuYPlGUnnJWxpiCsw3eP394pb6ijq
	X9vTlrF6Ul2TesIVoQhhG/6PVelgdzkquoJc2qfCmYiLaC5VXp4Rmz871L4rQuwuVhPNXrC6
X-Google-Smtp-Source: AGHT+IEXNFWx3dw1pIcEsbwbpOTPx3uvL6lGE1yf0XdlpTePB7sGcvwk+nr4zOCYvvAGQZ42wSzpcg==
X-Received: by 2002:a05:6000:156d:b0:391:22e2:cce1 with SMTP id ffacd0b85a97d-39122e2d0c7mr1428279f8f.42.1741175317004;
        Wed, 05 Mar 2025 03:48:37 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4353003sm15541105e9.28.2025.03.05.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:48:36 -0800 (PST)
Date: Wed, 5 Mar 2025 12:48:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <qygqjbhvk5ycigyxcojzakllelokkos3rgpolhpebmfiqzsajp@jxle4qz4ajxz>
References: <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
 <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
 <20250226185310.42305482@kernel.org>
 <kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
 <20250303140623.5df9f990@kernel.org>
 <ytupptfmds5nptspek6qvraotyzrky3gzjhzkuvt7magplva4f@dpusiuluch3a>
 <20250304160412.50e5b6b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304160412.50e5b6b8@kernel.org>

Wed, Mar 05, 2025 at 01:04:12AM +0100, kuba@kernel.org wrote:
>On Tue, 4 Mar 2025 14:11:40 +0100 Jiri Pirko wrote:
>> Mon, Mar 03, 2025 at 11:06:23PM +0100, kuba@kernel.org wrote:
>> >On Thu, 27 Feb 2025 13:22:25 +0100 Jiri Pirko wrote:  
>> >> Depends. On normal host sr-iov, no. On smartnic where you have PF in
>> >> host, yes.  
>> >
>> >Yet another "great choice" in mlx5 other drivers have foreseen
>> >problems with and avoided.  
>> 
>> What do you mean? How else to model it? Do you suggest having PF devlink
>> port for the PF that instantiates? That would sound like Uroboros to me.
>
>I reckon it was always more obvious to those of us working on
>NPU-derived devices, to which a PCIe port is just a PCIe port,
>with no PCIe<>MAC "pipeline" to speak of.
>
>The reason why having the "PF port" is a good idea is exactly
>why we're having this conversation. If you don't you'll assign
>to the global scope attributes which are really just port attributes.

Well, we have devlink port for uplink for this purpose. Why isn't that
enough?


>
>> >> Looks like pretty much all current NICs are multi-PFs, aren't they?  
>> >
>> >Not in a way which requires cross-port state sharing, no.
>> >You should know this.  
>> 
>> This is not about cross-port state sharing. This is about per-PF
>> configuration. What am I missing?
>
>Maybe we lost the thread of the conversation.. :)
>I'm looking at the next patch in this series and it says:
>
>  devlink: Introduce shared rate domains
>
>  The underlying idea is modeling a piece of hardware which:
>  1. Exposes multiple functions as separate devlink objects.
>  2. Is capable of instantiating a transmit scheduling tree spanning
>     multiple functions.
>
>  Modeling this requires devlink rate nodes with parents across other
>  devlink objects.
>
>Are these domains are not cross port?

Sure. Cross PF even. What I suggest is, if we have devlink instance of
which these 2 PFs are nested, we have this "domain" explicitly defined
and we don't need any other construct.

