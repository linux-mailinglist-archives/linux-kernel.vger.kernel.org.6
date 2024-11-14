Return-Path: <linux-kernel+bounces-409420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CB9C8CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD5B2D278
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB732B9B7;
	Thu, 14 Nov 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT0GHCfW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7620B20
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593256; cv=none; b=iOkG4v9U0fl/oZxRg8K9R7+N7/0oq7TOtm47frveudVKGRMwJmuqE17QshUdGUrOrSzHLgVJg7xLERRLsVHegA4f7eaHeEjdolrZJAtGpkOmlHmDzUJ49veNnzR10cvbMlhqdli5wFzGUYndisU+9jKYq+k2Nk7Mx5wLdVaJyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593256; c=relaxed/simple;
	bh=WUzDeLLAJtW+Z0kgOfdgeEqqhYnBqQ4TWuHZqdvOLmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8Ch1lNgy4FIIYRgbvn3XFBWucaOciBbYcFXa7MgPsc7YZ/fOFhjFQlW+IK6rPLeYbHkpG2dI5cnSOlcvWHWf0dk6suikxHLdC3wND+2gHkp+9eVv7p4nAuYTOttnhixa9E0/gMClA6DBCBXEE09yE/p3nm5LgzazMLgCBf8QuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT0GHCfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731593252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0gBUaNEyoe8hJ+dYpFL/aTlXJr3V+IJ2ahMbY21d80=;
	b=jT0GHCfWv1HUgAfDfPBs9up9oBzdFJvaPRSoIRF1DyDHTugqjexxeigSoirScn7i3eJTFd
	bdir//QXaf2ieYnaOfMxT496co5BlOpfDPVkfZVxgmc3ExUXo8iCdjXADyj3RuqIQD1GnB
	cI8oqpz7cK1Gc+uQITO8ZVJgLYTDA18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169--LCoGOq3M4u04yOJ23Sdgg-1; Thu, 14 Nov 2024 09:07:31 -0500
X-MC-Unique: -LCoGOq3M4u04yOJ23Sdgg-1
X-Mimecast-MFC-AGG-ID: -LCoGOq3M4u04yOJ23Sdgg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4327bd6bd60so5115745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731593250; x=1732198050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0gBUaNEyoe8hJ+dYpFL/aTlXJr3V+IJ2ahMbY21d80=;
        b=euF1a7mzRoyk2Z59Z74xwqhUBmIL+C86/oRZqprkre2g5s7edvGCIjyTzomxgnA/Eq
         P3YTZGC12eu5dzEeuQa4yihv9KNHRL6e2GIEzYZ0ws/PuaCF76e08g10kPc89KaoM+f4
         3hjer7Y34X9xyozovbj2boMHF9uw7wMY9a7j3P0V77IKdATA9Rs8cAPxKSe+n/lb6RHa
         /z6RfJfedc6rj59q7tgYGX/5+Z4JBBEKKYT9iObE6p4wAqCN8DEA1HixXqxZ8GuweAR7
         ZSoctglBncbMAF5a4XcIbUDc7HBbpA98gJZAjvcwR2iex+/R9IHnaDAgi84mY5M9rszc
         Cplg==
X-Forwarded-Encrypted: i=1; AJvYcCUbFLeeHoHcbrc87nF7C5+wlhK9AOXe/055Q2M8WI2+wmAfphDuHBcq7FXKRPEDUk9ZcSY4nQ5daI30+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKWnJSBBOD3UfGHbZJa+/OpjaQ4WahIk/OLJsl/TdVqGJwGj6
	WZMPQNl1pua7nZmoqczxeDM0NFcTdk7G7dERDodpDaWtmakgIwSALS3fIayjJIHS1iDAShDXN5y
	t/lhEBul12zId7WQsbjzYPR0fqh2FjPSqKdN41RvluJSWhXcleJkNCIG6rUXWHA==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr223068265e9.14.1731593249955;
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlAsv5aiN/Qn1l2dvPuDWBAlvuNUEXu9wk/kXmBPHQK9kBVTOoQJEVnzmbxW6W/XkP1hbywQ==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr223067825e9.14.1731593249568;
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm21463955e9.25.2024.11.14.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:07:29 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v4 2/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzYEH+q4AG5FBCiG@debian>
References: <20241114-am65-cpsw-multi-rx-dscp-v4-0-93eaf6760759@kernel.org>
 <20241114-am65-cpsw-multi-rx-dscp-v4-2-93eaf6760759@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-am65-cpsw-multi-rx-dscp-v4-2-93eaf6760759@kernel.org>

On Thu, Nov 14, 2024 at 03:36:53PM +0200, Roger Quadros wrote:
> AM65 CPSW hardware can map the 6-bit DSCP/TOS field to
> appropriate priority queue via DSCP to Priority mapping registers
> (CPSW_PN_RX_PRI_MAP_REG).
> 
> Use a default DSCP to User Priority (UP) mapping as per
> https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> and
> https://datatracker.ietf.org/doc/html/rfc8622#section-11

Reviewed-by: Guillaume Nault <gnault@redhat.com>


