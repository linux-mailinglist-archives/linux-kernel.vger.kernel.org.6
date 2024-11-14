Return-Path: <linux-kernel+bounces-409666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B79C8FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B70928283C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58417187870;
	Thu, 14 Nov 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cefVpN9b"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0E8F62
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601977; cv=none; b=Qz1vUk+UCwafkKXUcqhVEdzkfVh2s6pqRuU11oSN8QDz2nASdGhd1CcB2nkaQHzQ9HsL5bP9k5CdSpFVvGqJl0+TgdBWgL2UPw09iHioQxMwa07eGt4v72YH+1skFVUwGo6pLsTAheo4T21QuUPM2NtiUHvUFICQvvM9yNFQa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601977; c=relaxed/simple;
	bh=dlXIr9tKs7vPkAzL0HnnUtvt9u/9jJ/S5o15xU0Q3VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed2535vtbWOTFr7Hk7fcukU+2ipxzzyG8AhKgxqMSolAXNYrUDSE4wU7qb6yF50Tlf+QSwADF5YuPyyv+FAbQ3AV9j3WkX5qpedBaM1fKfBYcV+uvfuRY5Y56xKkb4YaCayDVIyg/0sB9tg2J5ytmdIJ7pGZ8VTu6NYfuaVz6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cefVpN9b; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73f90b28-aa7d-472f-bc60-cf165244858f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ei9lw3VRPRcBExPMcai1+UYlC5aERBmiEkbnI3n5q78=;
	b=cefVpN9buSgX5uQ7nKrRLbz9g1n21+ovlkUsgJGvjy3DpqqVsYzpOItbDzMCsN+D3K6HBE
	eXxNxuHBJtWv3B7OY0TXgZwVrx6YaMBITF6ZIdw4Xc56ZKLahcB2xk8NEBVVjvGc9RHj3K
	gM/LH76km7oLpiJGh/0zjEvMJIUATtk=
Date: Thu, 14 Nov 2024 16:32:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 7/7] enic: Move kdump check into
 enic_adjust_resources()
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-7-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-7-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Move the kdump check into enic_adjust_resources() so that everything
> that modifies resources is in the same function.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

