Return-Path: <linux-kernel+bounces-413328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047EC9D176E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBDF284E10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC151BFDEC;
	Mon, 18 Nov 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hF9gLtSu"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255001BD9F3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952370; cv=none; b=lAmECYz44MllZeVh2v38WqnqWmAhDlIuJoKi02lu8tXbFv8WvVu7Q0lB2cST+WYgywuQBCAUCApNXhGRL2anIv11a7Ium0YpfRmI0wbx2ePM4fSYNta85hOcj0Njflvy2nAtoChJ20gJRkVvkyC/WLplN6rCQhtmwxmpcgxGGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952370; c=relaxed/simple;
	bh=ACEMVKGGeTJOkHjQxBYlWG76S6ST5YjGCECCYYmDulA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PES7DPaYqkLecOR5wBf+LhXWST7Q6bUnmJ/mTs3TaK1FqEPQypNWpMxNEtEr+zRZItD7O1F67xTHoBmpFrOfpKwwr05ADx+MQ9JFF3ROeffw9uvgYuZURph9U/8uDzoDzj6ecJSg6ADCDXWyODkgqTy90myFJNjxKT0C0Gn02VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hF9gLtSu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f43259d220so1503724a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731952368; x=1732557168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCr0sYPsogCz+quxodgEQ3ar7fg9yYSS/OcvrMaer1g=;
        b=hF9gLtSu7cciRmITtiV1p3k8eQpwdsxmVSsew6zwuuPckOcQ/gM1b4aM8kK4+TalNO
         VKkGjBBiMI0tzSirR2EBGdsmGhp/HEVBurFo+ZMqStiiD6HxVozU6b/E0Wyb+e5GL+/Z
         ryTIoNjDEkjTByffIpBnxJb/MfPCbL33mGUbriREZkUfSClHi3jyrdVamA9Wq+5jPYZw
         PGPkgt8pGePkzcs6glzTNVREFgTl1KzBhni01z+0oinxpYSQUFZeIEXx7iVgBSVLPBi7
         EZGpNRzYx/nWJorVOPXJNwMiHbgPikd0PnT6OgP09hbcI7BFEUaRAy4L8HwLowTNHumc
         kqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731952368; x=1732557168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCr0sYPsogCz+quxodgEQ3ar7fg9yYSS/OcvrMaer1g=;
        b=n9VaH92ph09yQw3BmCVkAv1OvyEnaMGIaQmooFqJMx2NZ6zUT2jEd+rvlAEEc3iG3I
         CU787DFle4kWJ2btU0hDAHIHRh4TMiQmJbIUIR7QRTiz8KxoV1zjeWsABZ9blwBa/k68
         qbS7f3UmcTtxD98SR3Hk8ynEpMZ1GJIDILLCClVbAN6HDOL8OGxNEm1Ftg1sUVQ2+WZY
         Q7RBz+7/ynlQBr4ORoQ3zY65bxhezmX/NGtFNDQRwOR9w1wWEVFcQsuaHyUqK6iBjfJw
         p/hDd4KP8ehPuN3aQu9GhI7pb39VezgVQwll6qXuSd6ztiSLw69CGlXrpjQJzL/u6GEI
         Ne1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzYvQxVArFNdrHQD1uvcDDAPLSNJlNnml8rEDOqN2HkX7Aq7vA6AhAYGCBUADaAcx5mUNt/eYA5WavRdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4c78H1hupFM4tXqjpeXAA9D3LtcN6u8xSGO3s1SuWf9YEgDF
	fTrUIdmfFkDG/QlqrIpI01CPSWQwSpNUUAcJHxbuSusL3OEZecQnCWzZ2dtMjts=
X-Google-Smtp-Source: AGHT+IEJRNX9bZE0xzeLu7+8kcJ+xIr7Kwr2Ag4WKPpTArbvdH5l5IPyQ32YkKJbAIpbhDtnUqCUSw==
X-Received: by 2002:a05:6a20:43ab:b0:1db:e508:cf68 with SMTP id adf61e73a8af0-1dc90b4bbebmr18325105637.24.1731952368452;
        Mon, 18 Nov 2024 09:52:48 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ced4:eca8:f5e9:9a5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770f9d0asm6707357b3a.26.2024.11.18.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:52:47 -0800 (PST)
Date: Mon, 18 Nov 2024 10:52:44 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional
 operation
Message-ID: <Zzt+7NBdNjyzWZIb@p14s>
References: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
 <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>

On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
> This patch updates the rproc_ops struct to include an optional
> release_fw function.
> 
> The release_fw ops is responsible for releasing the remote processor
> firmware image. The ops is called in the following cases:
> 
>  - An error occurs in rproc_start() between the loading of the segments and
>       the start of the remote processor.
>  - after stopping the remote processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Updates from version V11:
> - fix typo in @release_fw comment
> ---
>  drivers/remoteproc/remoteproc_core.c | 5 +++++
>  include/linux/remoteproc.h           | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 7694817f25d4..46863e1ca307 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
>  
>  static void rproc_release_fw(struct rproc *rproc)
>  {
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
>  reset_table_ptr:
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
>  	rproc->table_ptr = rproc->cached_table;

I suggest the following:

1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw().  The
only thing those would do is call rproc->ops->load_fw() and
rproc->ops->release_fw(), if they are present.  When a TEE interface is
available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() and
rproc_tee_release_fw().

2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot().  If the
call to rproc_fw_boot() fails, call rproc_release_fw().

3) The same logic applies to rproc_boot_recovery(), i.e call rproc_load_fw()
before rproc_start() and call rproc_release_fw() if rproc_start() fails.

4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now be called
in rproc_load_fw().

5) As stated above function rproc_release_fw() now calls rproc_tee_release_fw().
The former is already called in rproc_shutdown() so we are good in that front.

With the above the cached_table management within the core remains the same and
we can get rid of patch 3.7.

Thanks,
Mathieu

>  
>  	return ret;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 2e0ddcb2d792..08e0187a84d9 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @release_fw:	optional function to release the firmware image from ROM memories.
> + *		This function is called after stopping the remote processor or in case of an error
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +405,7 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	void (*release_fw)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> 2.25.1
> 

