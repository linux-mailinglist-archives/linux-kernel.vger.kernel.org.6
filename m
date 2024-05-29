Return-Path: <linux-kernel+bounces-193406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A48D2B75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0952C1F23F80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6A15B136;
	Wed, 29 May 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="j1uWl8EP"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078C26AC3;
	Wed, 29 May 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953426; cv=none; b=kNAwIPP4Kj6xxIKOTyfG5u2sO9+q8YgowFFA9FQNil1+f0GsKtqDMkDBh6UpH/7lJL4PgNwZDbzJ1T3nU1Ll1VNPEdxPHfFg46gLNDY74sIJ4BKE7ZAGZR/Z20JUHPKyycMIwNH1IpUTRIbpeSKmlmrMujKNAeLwAx9YutFMEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953426; c=relaxed/simple;
	bh=+C3wNbIduRzUMO9fBitJerOZw/NtYMUeTn1GhV91IkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UlIn71eRPSkSL5ER6HYzVa+Yybqv5Ertonk40iIffcE/T3G7QfeKYo5qzKrPsUF2FKJf+i8jlQqkBz7U7X76BRQyB5mZ6O9TiimTbkqR0IuXWWSOyhEvRR9RbnPYtVyro5FYjQDXD1ftzKhps8SlHrrw7YkUzjieGD92JmAkmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j1uWl8EP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8C3B20174;
	Wed, 29 May 2024 11:30:20 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1716953421;
	bh=+C3wNbIduRzUMO9fBitJerOZw/NtYMUeTn1GhV91IkY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j1uWl8EPU+Ntkg3ODbZmYwnc8QVMvHNWc1xxQUqZD1T1+uXMKEsQZxp6XAiLOlXDr
	 iarF+7B8/vsItQf++oRTbAtkMqWz7oP0z0ba3wyIIgtmH62t4SoOfhzkJ9valUDjyq
	 b9uVvyGajDjCbIXlYQ4r4sE7BwmIMQiCVrkwCCZs4QCcpJa1/JXz62iWDaRK8nz/RT
	 4fVuJ8TQlzy+w3JJBpoeIPIjGMySfXwOAg1/n8mgnn3UER8M++hSwZ7o/Iez1yLZcN
	 pbJVOT6x2btjyudTtXUblNhnlXyt+S0ikEQicyYft3/pTOeqg7BfmuIdIgQEyghozb
	 PistpX3RlW8rQ==
Message-ID: <4d2fdb7e2f96313cd3945c8e4e1ce59f57451fbd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 May 2024 11:30:20 +0800
In-Reply-To: <20240528194557.7a8f522d@kernel.org>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
	 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
	 <20240528191823.17775-4-admiyo@os.amperecomputing.com>
	 <20240528194557.7a8f522d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,
> > +#include <net/pkt_sched.h>
>=20
> Hm, what do you need this include for?

I've used this in the past for DEFAULT_TX_QUEUE_LEN in existing mctp
drivers, but looks like setting tx_queue_len =3D 0 will do the right
thing...

Cheers,


Jeremy




