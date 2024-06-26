Return-Path: <linux-kernel+bounces-230942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB3918426
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998631C22905
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DB1891B2;
	Wed, 26 Jun 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz1KbViq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A86188CD9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412099; cv=none; b=QDI7hJOlsVPnECj13cZS2fJK4VzoAPa0OdmMHeCh9nK10vq+bUgk//iUrKXQZ0xSlhJ5O2FArcaV00clhYnuh9fbFpOPu5nCKN1BOzEqI+HYo0XUOZrDp1qRX7CPtEVu6psJirdBGP7J50Tp+OUXdsHmGPIIYGwjF3FGZxmRMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412099; c=relaxed/simple;
	bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlXSWpDTCe/77Tt/4PC7GMz04gyDdIQLrJ7nVnPir/7Ly6fDzX/LId5jxeaJCi62U2p5qjBSNnLsAzQb01mtxFZTqLkqtKXTdxYxadgGpS0kG4cR8ZQvOYI0amtIkoe8vv8rhCH3IkAKs3rg9fz6f/qaQVoAsRe4s55cDXSsSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz1KbViq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
	b=Dz1KbViq9uEKoH8aSunI6MBUYQod2tCLXA3aRtMIBudyNu70QuoyUgR/o/akjHTGQHX5XF
	xS+ltMg6NJAne8/5T0Pvw4HNKGAidVqCRntIHvzTptPMSQnx5Y3f+7x/y5FDzk16+ITge5
	Mj4ims1ayI0TqdD6Vyik+nEumfyOyso=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-S8yFQrZ_OM-3FQ1W0OlxEQ-1; Wed, 26 Jun 2024 10:28:15 -0400
X-MC-Unique: S8yFQrZ_OM-3FQ1W0OlxEQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a727d1e7e9aso106627566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412093; x=1720016893;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
        b=M7t2YGMA7rACkgUK6SeVL1x8Cpt+DAuNlY9/Sc0CADgA20P+tEIasGAbP4BfFxmsLZ
         CLxiUntJMwMtAEpY5MdhjkrdO7PKv9fqr0zC5J9sci0NspGpToBLUuwwXmXpBSrmkBt6
         gobcQQy7u6rPPVCl0hgxgVKjefTUqCIvEKvVXh4AqpedWZE/cBRRJlfwN2iulWojjLkk
         HiLZR6jAxU39H141SPpNSY5gUbowMb3XliKdBa9KT0/f3MCTsRPzLpJ8AJlrEiL8koTy
         ZxRNQbLyvHO1Nj/mJs1KH+VWaou2nDKXVlQN8Tv/Yl0AX56FqtgADylGGee3uprx2AcJ
         XZSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+LpVxaKbHqhO+CaIzgBcRyCEjy99SslxwLVHUNd78f1atCsaRHYZFJCeFf1Pe+mKlxP4cwjkUy8izYUKwBS7BygaVxN5LQUWJl/Ex
X-Gm-Message-State: AOJu0YzlQcBEm+Qb2yHephDZp+nK8V6mJII+C89uv++rsa2DSB59K45l
	kKuQ35D50z7ARscMRQ6qI5e1/k2LM4r5VgLLTJxmcZPHaCeMkzER/gfyHnKssM3Scd3JZYoZa7Q
	TxDVuuyiHHXG8esGD838uuG41Qmp3bJD3vA8o9i7pP7aW14JVRAorubE2OmBicw==
X-Received: by 2002:a17:907:d303:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a727736aac0mr425935466b.52.1719412093776;
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmV1TpazIQFGMovVoqeNpU68OOwy06oabzZ41ccRnAAgm8yJJ5ATd4NSBJj5cE3s+8/2DuZw==
X-Received: by 2002:a17:907:d303:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a727736aac0mr425934166b.52.1719412093503;
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/10] net: psample: allow using rate as
 probability
Date: Wed, 26 Jun 2024 16:28:12 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <BB7EF7B1-1237-4EA9-AD05-C36563A3BCA3@redhat.com>
In-Reply-To: <20240625205204.3199050-5-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
>
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
>
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
>
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
>
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


