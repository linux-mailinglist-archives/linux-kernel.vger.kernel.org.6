Return-Path: <linux-kernel+bounces-237697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC68923CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437E31C20DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964F15B13A;
	Tue,  2 Jul 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqz4wM9d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72815B12D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920851; cv=none; b=ENp2OeXQpmJb694Sd8Fmo+nicvXVMVacO35xZS+kPCz7Bigh4BF4tBv7IbldtkBDTQ1nOJJTc7CVJU216i52V6J5YT4Nz9pCj/A/EUQKPGePb26y7cAoGX2kxu1x8wOV9AG0e4U5wmQDXM3sG7IQ8S+bDfepYQV5A08QXB7GLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920851; c=relaxed/simple;
	bh=FglxcTnzwOQwmJlE5WNCXHTrByMhmiPk6znqE6jdt1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYxPGn2ws6E515a/R0bydo4MzGflI9fVLjLiSpf4vifaftS8HkjRaSdc0z+vx+94MtxmIdZNZxwJPbwaqg5RcSx8IiMhWyyMlDmot6y0NvPYPQtGlbPVEbi5IMMY5MG0ViYRhOlJ2DhARGMgOOnycTOxWVHtyPeB89D6giZ61qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oqz4wM9d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719920849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FglxcTnzwOQwmJlE5WNCXHTrByMhmiPk6znqE6jdt1Y=;
	b=Oqz4wM9dJJuEGOzZSneRuLUll1qMTNa5KCKO1B9CXEI4+KRphBz32ebwsio5HLCDpIhSCH
	ntAq97vsn/leXHkO5m0rmYcZjjU0kZKibCP1qcHQf5S/4q7XTwXl9XXUd84M68sM9SDLfX
	Mt7YL1/kCco/uJPlZedsvs7sPnPTyL4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-CMqW4YMWNiaOc1-uPSWZvg-1; Tue,
 02 Jul 2024 07:47:27 -0400
X-MC-Unique: CMqW4YMWNiaOc1-uPSWZvg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E632E1955F0D;
	Tue,  2 Jul 2024 11:47:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64B2C19560A3;
	Tue,  2 Jul 2024 11:47:22 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Donald
 Hunter <donald.hunter@gmail.com>,  Pravin B Shelar <pshelar@ovn.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 05/10] net: openvswitch: add psample action
In-Reply-To: <20240702095336.596506-6-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 2 Jul 2024 11:53:22 +0200")
References: <20240702095336.596506-1-amorenoz@redhat.com>
	<20240702095336.596506-6-amorenoz@redhat.com>
Date: Tue, 02 Jul 2024 07:47:20 -0400
Message-ID: <f7t7ce4ow1j.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Adrian Moreno <amorenoz@redhat.com> writes:

> Add support for a new action: psample.
>
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
>
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


