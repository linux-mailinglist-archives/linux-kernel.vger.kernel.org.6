Return-Path: <linux-kernel+bounces-318051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150C96E7A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607ABB23720
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24222064;
	Fri,  6 Sep 2024 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdQM+2wf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0ED1EB35
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589267; cv=none; b=c+kLBwz3eNtVWT4+dCKhBsQeeEatcKaNnQBnDKKZq/XGOp7hgvthlRr6KiHILrnI8V5xnPmjI4ryE29Jj7BjvFOMmTcTd36yGKb3DXQluLAducNtxMC5eATUb6NA760f+/Wms0WQJv6WMLJPijB0nNCndmbUWENXHnJsgjFwkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589267; c=relaxed/simple;
	bh=88UqhZqlnFDosqx8wq1Nj/KcxKdngHyv5b1Bi4Zom/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLtrRe+KtRq/3Ns4OB2ZCD1oViECuMDPkmadaIddbDBMd7EiXEtYfV4sHMbN+j0r+ZcI9opmEJrHwHWNqGMjQjb7Zm2zUHYi1Nw9zJQpBCKgLrMjuMkO3YXKaUvzD9XJn/7BcCFeA2tP9GQzaKMuqkc/DG2Ew1bYWGTYM3Tm02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdQM+2wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934CAC4CEC3;
	Fri,  6 Sep 2024 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725589267;
	bh=88UqhZqlnFDosqx8wq1Nj/KcxKdngHyv5b1Bi4Zom/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SdQM+2wf+LOQuqoHuBv1kibxdXMz4CTY1J/7/WK/XvSTxxynG5lG9gUQzB5dB7Nw+
	 eGbNzuc7PAEWNyvb2H74hRKFWfdTKB/idZ7FKv1mgZTqQYCvJXFqSpLCyuhWJgbh5G
	 cIZamlVBiquW9uf4+Zs55np+EoYXBsdgJ1dKW0AyX5QBtjsgyNUzSrJtCDGjqSZICC
	 /lOqDkZjRblYRGq6Z3o/RxKeYQxj8wMvyH5EsYdK/bhnisx3EWmXw2eYDNQTJKE92Y
	 mfhD1JHI5o6hx6Gq/lw07BCiGbpLrVAdadSTMH1f5LhfnfsssnYj0NKZgD9wXkaPrb
	 imjeUPoidpZqw==
Message-ID: <6a587bb2-8126-43d6-a6b5-d449dbc9a908@kernel.org>
Date: Fri, 6 Sep 2024 10:21:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/7] f2fs: make BG GC more aggressive for zoned
 devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since we don't have any GC on device side for zoned devices, need more
> aggressive BG GC. So, tune the parameters for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

