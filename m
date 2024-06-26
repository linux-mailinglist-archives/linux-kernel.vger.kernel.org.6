Return-Path: <linux-kernel+bounces-230940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FD3918424
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C011D1C220B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABFC188CB4;
	Wed, 26 Jun 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8YL5tRn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDE186289
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412094; cv=none; b=bWBKQAz62mJAuqBpat3XPgx3NApzWCf9q+FbZ58Rpy7E/A7FUuxP76Lgu6/SQjLLajj4+xjq5bOrSwMMGUrxcQeBU28PZYdcMJ3WFgz9TDn54da0r8+Eb9I88iltiAaHicD4wgdv7bF0c2+YI4jgrExu8hHYuOm9WGfObNmxgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412094; c=relaxed/simple;
	bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxNN70ogTQy0pRjxumfRcN4WJvvZ6S2X8zMIPv4kyVgnXZjotpzUnRRyySdv3pyyZQcG0HToEHuPcFUo9QtUmReOqw9vZFHYFgGBHb7quQpkIbpJnJu08f7mg8CTmu8I1OGFsWyLnD2DMNeRV1fZkBryMDBG8eS5yBeP6HLbIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8YL5tRn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
	b=e8YL5tRnubLRzRpz6RP1NzAog5cAOXAx91OoO3ChubLv6mjUm2wMQWA17gz23xgSuK3not
	RZesmTD5IaJvkg9Ps2MyVhVRpyn6IQfyLHmdUMYguOD7KvlnGJmyLnMr3Zw/cRH1tfRilY
	sA71Z0AFRsvx1Btk2Mxn4HJ4QP1DUdo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-_9pKFONfMSKW9BYwA2i7rQ-1; Wed, 26 Jun 2024 10:28:10 -0400
X-MC-Unique: _9pKFONfMSKW9BYwA2i7rQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a728c02df80so55971466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412089; x=1720016889;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
        b=cwFXdvqRk7a/8XLG6MO/RbSWsbuWAU12ZwG83bh3+maUV6ADotMM9EAcEyhESZ5DSE
         dNaZ7j5RUFK+9Or1uJxe4IXEB6ZdhSoGKB8RQBrvVzVB6KxwLIYglg9bVYB85r0wt4Te
         gmvQuYNv3Kxl/RtdUhFowSGT4z/FVbODl8Rzfm9uelfUn0xw7+CxDPrDJyHyGP5Ihvga
         eNV/OW350OPfWRJi6xsb8uqjuj+TGu8w4v4IOBBiooFk0wQgxMSVojjrThUE9iEq0DeR
         gSVZpj0ae+S0S6BaoQgx8kUFu7xUkrq05gd5o1pVOuaEgfNM/eFOO2mE8N/r3B1C/m1t
         6Y9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0Tbmjhq9jXsjZqmA0CRtDkZtCoSAuFBYa6GlG3fcnwq0g25iTs2o/fvXoO3Yh0XQ9EMNRapzkUgnDlSbqPYYMCz9IoNOhpi8MJ8hj
X-Gm-Message-State: AOJu0YxoOvSJ9d3jtfi7nq2T2kR2cgy8bMkGnH1ztXMYiY1rdPS0BX1y
	oS9yRyPJg3vHYj7Akk9nR3Kfngx01ZkbU+86bVb4H5PCHq9Pqy6wbDEh4VFlmumW8BnSmda0ECE
	bRlErfrF+BKhbv04zaWY/JrGgsoLQewjHJHazu6i4jsQl8yh1ug37JwWmQ97NnQ==
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a7245bacda1mr597295466b.37.1719412088799;
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErnyGXF92mNUgOBZBMQOObmC5OIulbtMrV/oeymqUlbkWGwntzFEOPkPZKKgzMJuOQUL7mTA==
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a7245bacda1mr597293766b.37.1719412088405;
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/10] net: psample: skip packet copy if no
 listeners
Date: Wed, 26 Jun 2024 16:28:07 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <51493A9D-9E73-4BFA-95D9-79CE1356110A@redhat.com>
In-Reply-To: <20240625205204.3199050-4-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-4-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> If nobody is listening on the multicast group, generating the sample,
> which involves copying packet data, seems completely unnecessary.
>
> Return fast in this case.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


