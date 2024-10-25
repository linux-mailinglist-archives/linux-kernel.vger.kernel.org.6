Return-Path: <linux-kernel+bounces-381910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63C9B0630
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9061C21BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236013B294;
	Fri, 25 Oct 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSEByDXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D4212198;
	Fri, 25 Oct 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867894; cv=none; b=BU2zQpBSN0+WoljNAxf6G0WccUDkVpT3hwTH7yFLXqXuF+bMdZEtyOedPf3L/2EnlXBeYAQi4UOD81qLXFNWhfbj5K4ZJ1f6yw0rCB9Ifbkor+3SEqHMb0JzN1onn7I2deVwvzw3/kUUQiCeR8fXh1LKLZk1IKhfFJH/KKmGuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867894; c=relaxed/simple;
	bh=9mcVmpVxXaPlfof+xihcCDoYFOuyjht0sgCO0aqzuxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2JeAvus/6peguyu3JOW9dCtX1aIrPsbSulJSJiii1qwCFMsZmMJXqDxHQSnSQ72nKR+H35/TAA74md7JtsDPlvcU1ftA2xfFQTehUiC0fAkDtLwozmvmyonfdMSM7fuiPACtT81wd+aJoZUmSHSJA4KS3vOagx2Y0nzXMhjpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSEByDXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BD4C4CEC3;
	Fri, 25 Oct 2024 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867894;
	bh=9mcVmpVxXaPlfof+xihcCDoYFOuyjht0sgCO0aqzuxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSEByDXvYMyRq7DhEVO3naYht5rUMqxj7hPL8CSMQ85jR8NfpXTd/n/FNN24b8opw
	 VPhn1V8fhysYiY8jwv5w7W6YdDXQ1wWq8rQdUck+IQZDIO3PY1s84wlYCVMrI6PuVF
	 ZG4n69+cX2VVooGF+Uwpfh5ID/W4pq6lD9MjNlBUcRTKEGPcCVXkZxc/gsrYnCO8rK
	 vgW28SlpKS/MNZHztdLJwQ+hMj2TDwyQh93wGjrB5AXWbVIkbTlB01rsz8oA81JXS+
	 tNf5pCZ8J6wJ1Mn3B2HcuRsI0yEcRaU1SAZeqld4wX9yG2ZWeaZvpN8qccf6HD39FI
	 gu6XKsZm1OKcg==
Date: Fri, 25 Oct 2024 08:51:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <Zxuwc_OtTdA7MGOV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240917061226.GA3839@lst.de>
 <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-00843e9e2d8919dff345b0da-pchelkin@ispras.ru>

On Fri, Oct 25, 2024 at 04:01:18PM +0300, Fedor Pchelkin wrote:
> I suspect the patch has been lost - it's still missing on nvme-6.12 or
> nvme-6.13 at git.infradead.org/nvme.git.

Thanks for the ping. Patch applied to nvme-6.12.

