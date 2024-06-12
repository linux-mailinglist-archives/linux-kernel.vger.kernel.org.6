Return-Path: <linux-kernel+bounces-211755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B299D905671
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3586A1F23005
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3093180A72;
	Wed, 12 Jun 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpKSnAsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8591802DC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204805; cv=none; b=k/q1xR2UMNZEZoE83YL8H6dmgwL8mGGiiEXrlIv+9AeiDPdPlNCAUCdUo1YurIuAGW7T5W1CGit/wyCedokOLFdpjKbhZEjGCHgCbB5ahN+Y6Qiher1nml9b0CLJhOeeIAdsXA85ugzQ8a/gfZpWofM9CUGq6w94JgrVI8x66DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204805; c=relaxed/simple;
	bh=0eHVEB5pAxp11dm2HUruK3VO3gn39LNxtkdQM8Bhig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSRHeR6EpuYoe3tlyrNjmIXvI1HhWp6B8Kz0WxsaNRU+Hk4yN36BXtH8Ch4u5XZRBX1G2CQLfSv9rJlsWE2cquidfwMiRxCWoUKrHA1BheuYHhSPbwGVUqUGewB7OahtzAo8tiSI8Sq7sTCyVQxohF1IxsPrt6lT/gij2h35dLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpKSnAsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8tpOuWLrT8Dd7Q1BYypdXJ8eG6sBxcdpUi5JUhFuw=;
	b=DpKSnAsY8M/QmaLexUM7ShC3l6DflZbhQVLovB5j0u43hPXiqhgVog4sZ69TIO05/Ls5PB
	3EvbkAcBjw1nW+qUt6TfaQetiMp7Q/eX96EsPSsX6MRFzoniRcXnTUzYvti9UNKpOea/4I
	YT3+9OJMQNHsG6v28R7VpHTMsuRoYI8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-grclqqDhMO2Vms2dtSDzjQ-1; Wed, 12 Jun 2024 11:06:38 -0400
X-MC-Unique: grclqqDhMO2Vms2dtSDzjQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f358e59so584630f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204797; x=1718809597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp8tpOuWLrT8Dd7Q1BYypdXJ8eG6sBxcdpUi5JUhFuw=;
        b=rBq+eoaUl8B+WgjjYvOWvQVG7SCfbC4YWkvCjtMXianQysM8JnvsjmffVSCGkLYH5U
         9wWNQw312LbePovLNDDvglFBj3rthl1q6HzjoRaRnDtD288vV/trcZ4F0qf1xcmfPVIK
         m0YO2MUE7+pn5unzAlrci4AnX1pa/M/2uiN8+0nENCbfhhzr3ULad38fq42WV1EApUKf
         q3jLc/GL8o8DYCFd2O4UYRAaeVHc3GfpGusLjartLE9dUCNWe10JAfYj/xh//PE5svwj
         BS3m+opYzh/lrvKC4bc0qEfTUiNdghoSCJpE+ghmSaO38X8IUBN29SE8YksWT+GhQd45
         soxA==
X-Forwarded-Encrypted: i=1; AJvYcCUm/kiXNGaniWuJRmu5ouMCpvHZ6DbFy2Jjx1xUKt8z5iA/ca22K/htxnkeqrAxgk2MSPDAz2dBHGX3QnUhSaJny6w1oOXgtlZWIQYS
X-Gm-Message-State: AOJu0YxQAajF0e60dNpzAr/w3OkUKMgcLbklcQgI3gx0J7crLcX9GxvX
	lx4GOJvrnxr/XhptPk10ogwOcN2/ULCPJbPCDuOIZcyerTsrAnuzkOR5YPZTn46wE+xXEDJgFE6
	HuWy7QRiublWFnkYO7l1CkNhj2CDVWW7xjUmkYzTr5KscDnE1wksrySQeTNz0uw==
X-Received: by 2002:a05:6000:186:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-35f2b27c669mr5653331f8f.13.1718204797251;
        Wed, 12 Jun 2024 08:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsmbOL8mSVB2bSnh6EQUk0V7ORdG70D+bjbg3nTZEcncKxeOFt330EglJquQWsox6O0gqZNg==
X-Received: by 2002:a05:6000:186:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-35f2b27c669mr5653277f8f.13.1718204796670;
        Wed, 12 Jun 2024 08:06:36 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1e4075d6sm10290603f8f.18.2024.06.12.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:06:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:06:35 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS
 usage
Message-ID: <Zmm5e3KFxFCQzwzt@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>

hi Asbjørn, thanks for the patch! 

On Tue, Jun 11, 2024 at 11:53:33PM +0000, Asbjørn Sloth Tønnesen wrote:
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use
> the unused u32 flags field in TCA_FLOWER_KEY_ENC_CONTROL,
> instead of adding another u32 in FLOW_DISSECTOR_KEY_ENC_FLAGS.
> 
> I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
> flags to coexists for now, so the meaning of the flags field
> in struct flow_dissector_key_control is not depending on the
> context that it is used in. If we run out of bits then we can
> always make split them up later, if we really want to.
> 
> Davide and Ilya would this work for you?

If you are ok with this, I can adjust the iproute code I keep locally,
and the kselftest, re-test, and than report back to the series total
reviewed-by.
It's going a take some days though; and of course, those bit will be
upstreamed as well. 

WDYT?

> Currently this series is only compile-tested.
> 

thanks,
-- 
davide


