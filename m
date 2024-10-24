Return-Path: <linux-kernel+bounces-380605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8719AF352
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C22848A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92551E571C;
	Thu, 24 Oct 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dYNjqQfU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529A147C91;
	Thu, 24 Oct 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800399; cv=none; b=BzP0wP6H8FfwVQ2fRnwgF/tPfXq5SjnjKo7x2bSRco874EMzwZXx46C3YrEP2SlMFp6ILXbOB8+xOMpCrWsaEkXVnUy1TcWonhJWoKAldff/VEy2dN2eECWz3SjRmT4Tvtq8xI0RqCwYocC7LNs1hzLJeBDP74xEnXwe6uHIsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800399; c=relaxed/simple;
	bh=BWp0SjtnT8I4uhrA1sKVHIPX9hTmUCBsArGUDTFYbUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOpjH6alObDfpjcKGOd5id7y+S8Ubm/BOyfTnWHU0LDiTuhwpjViMQOaeQ2PNFBExWvqJdS7ijmsr60qI7sFN6RnfRXqZpEIQ27nd6fMDu60sw7HZRxb7kIh42Ad7gOzwTQKkoziAP+UKkK8xFYfyWVunUvs1yWMcnmUrDeadMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dYNjqQfU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 960414188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729800396; bh=tstG5mlMvVJLtmMiryQST9/bVMS1nVYqvzc41kuHLTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dYNjqQfUQuuFAV7HwQ0+frD1bz+5keGTwxwCWkU3iPc0ytcX42+WBjLquDtS7G9/3
	 XeFXNHSI9TPDy1Y1/gzHIdCylflSNgH+mzNWPE3Ih35LHDkrsy0dQ0BxoGcOteIVKL
	 yhInJqssvyB2Fxgre09YplBu1HBIoC/9WaPWM1W5Rk5Y0MQAIBoLSJ5ifRPJv0U5Gj
	 LWVOQDPD2zi+sd64HAUReUQyIKO5Gwt4MW6XLr6G6w0p7zLLucsAFYlO6Ea03JUOdK
	 2fFP5ptwxsIGwEiVveJK3Mrhx+tDRAAwDj4eI9Z0PyRJOGpDnpb0XsZ5dXbRR/gmuk
	 3nObE+rIWAAiQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 960414188F;
	Thu, 24 Oct 2024 20:06:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: xu.xin16@zte.com.cn, alexs@kernel.org, si.yanteng@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH llinux-next v7] Docs/zh_CN: Translate
 physical_memory.rst to Simplified Chinese
In-Reply-To: <20241022095925304e1j2evmIRbZsiE0RDUFrA@zte.com.cn>
References: <20241022095925304e1j2evmIRbZsiE0RDUFrA@zte.com.cn>
Date: Thu, 24 Oct 2024 14:06:35 -0600
Message-ID: <871q05465w.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<xu.xin16@zte.com.cn> writes:

> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.
>
> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.
>
> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> ---
> v6->v7:
> Thanks,  Some fixes according to:
> https://lore.kernel.org/all/c95075bc-187b-4d38-b9bc-2f19f29a2231@gmail.com/
> 1.retry 'git format-patch' to ensure the patches can be successfully applied by 'git am'
>
>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>  .../translations/zh_CN/mm/physical_memory.rst | 354 ++++++++++++++++++
>  2 files changed, 355 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst

Applied (after a bit of work since it didn't apply directly to
docs-next), thanks,

jon

