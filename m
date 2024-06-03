Return-Path: <linux-kernel+bounces-199123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750E8D8293
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83001F2639A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126D12C47A;
	Mon,  3 Jun 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dRUKEDrH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C177105
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418580; cv=none; b=uSgMAmYPcTRqOgx7ftPpmQ4SkK9+YRD2z9Y/Y02JaVAr/0GJSS6wLueb9qx88F04Z4guR9dBXO3mSbOKLmOoGVbOBDKXK0FaK6Rt0bVBrcCdIew79NXJ7ObFOQVOEEp02SXHtQVXbgAbKHqmWx9PJmbQljq1xgd+awjgLRIjFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418580; c=relaxed/simple;
	bh=hyw7FeH5zXqqRiWwpndpSm83YNiACzGxeYh4iQDnAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0vz7QsHDUkZawHahG/xeTGFhhTWwNf8WCcLTKM8LEJ4DafPVPlB4JtGe39DjLdV6aKJMAYcT+xsNQ98axeGCgiOWUY3prQXkZ+N5dnKxWLmaM/g+44N49J5EteOZy30XTK8eCsi2F9wYLWVeZJvfjbRfO1v5oyiXlwnQaGZGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dRUKEDrH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso64299491fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717418575; x=1718023375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyw7FeH5zXqqRiWwpndpSm83YNiACzGxeYh4iQDnAcg=;
        b=dRUKEDrH18KKqvNnix+v6zWrZ0N/TbSPxz48S3e2naiFWT+YfyYsY6E9yxuiuAT2Ni
         CL1mPOAPFN5oCIIxg2ocOijU/IHCZMSjrnv232oqfBtmkrpbwojpXX0SmOEeiYe3vxqn
         6ZuZHrJx0+21ZPTFFaU7GhWApTGVGnx+vxKZQydRWEcRYtmjKjtSpLQfvMPJLBX4kyOx
         MnRTDYZNHsmx7NFq68TjIYlk+JSykWO0f0DXeyn2Za2cc0YHzaxoScOqhzR2g7OIyj6o
         CCQuptNQ+BRBvnLmYxT0+AfK79Q/R8cHzkEs2eTnNTJ0tV8lalPPlWl4vQ9A6rqILHz+
         l68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418575; x=1718023375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyw7FeH5zXqqRiWwpndpSm83YNiACzGxeYh4iQDnAcg=;
        b=HbHgMV2wN6GuhE3lGkSQii66w2MpZcpWfQ7pZqzmktnMZyTeHFWqVjmZaGypeNdDTF
         o/DCYOcqzK+ZbszxqITOT2jIuYStnHuq45Zoi+UtIKKFGw/uqF3tgPZyzF8cm3FTBS/s
         1bBJsMhG7C2UusnJn1ZeIHGahMxCLM4UTjV3KBtIIeIWC5L0E+p267KnfWDcKP1k4XJQ
         cavfpaE/JIfGhPp99dtz7gveqZs+lq/otUmemoqvy4nn7LhQ/zrwqv1LabSWaQGTiVgw
         EQq9FMigYOeS/SosP+qNe9lnI/DaFggq0lirol8/SeMh9ACgZPnmdL+sSvTHWHoawgAU
         RgVg==
X-Forwarded-Encrypted: i=1; AJvYcCXkx833g5qsK6BfECDkAoeQI2F+MgP/geaMAWvNSDSA75uz9WipVNxBU3kPXahvSEAGBL/sW61g+p8GscY9+QnpEvHuxAKJNyNo3ijM
X-Gm-Message-State: AOJu0Ywqpv8p7mUB/5LarnbvPphkWigY/lkU2uHXY7Ty470j4YtEVtaf
	wNu+9Wf7bed9dmrvkunYSh6tNYrQgJLvMq0+dlEnmx0o/O78l3l1tHRmQ+C92or181f4nFBLi6J
	u
X-Google-Smtp-Source: AGHT+IH1AoUhmWaH2/VV/vmujB3NiMF/fudntLa6lvqqGwFso05mADVd2hsufbrTRxe5dUYxXGRgCg==
X-Received: by 2002:a2e:2a43:0:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2ea9515426amr64684751fa.26.1717418575172;
        Mon, 03 Jun 2024 05:42:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77baebcsm8365156a91.53.2024.06.03.05.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:42:54 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:42:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: "gxxa03070307@gmail.com" <gxxa03070307@gmail.com>
Cc: "john.ogness" <john.ogness@linutronix.de>,
	rostedt <rostedt@goodmis.org>,
	senozhatsky <senozhatsky@chromium.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	fengqi <fengqi@xiaomi.com>,
	=?utf-8?B?6auY57+U?= <gaoxiang19870307@163.com>
Subject: Re: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in
 print_caller.
Message-ID: <Zl26LDOV_v946kOv@pathway.suse.cz>
References: <20240527091929.316471-1-gxxa03070307@gmail.com>
 <ZlSewPTyQ-jMpW5n@pathway.suse.cz>
 <87y17tktze.fsf@jogness.linutronix.de>
 <1717404421510.qmo40jy5kubcunlrdknzajsf@android.mail.163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717404421510.qmo40jy5kubcunlrdknzajsf@android.mail.163.com>

On Mon 2024-06-03 16:47:01, gxxa03070307@gmail.com wrote:
> I need to populate the temporary variable "caller" in "print_caller" func with the additional information. And it's no use defining a buf in out-of-tree patch.
> In out-of-tree patch, I can only add hooks (special cases), I can't change anything else, because it needs to be consistent with mainline linux.
> caller buf in mainline linux is it better to make the buf bigger and leave some space?

I do not understand. Why the buffer size has to be consistent with
mainline linux?

Really, it does not make much sense to upstream just this part
of your out-of-tree patch?

Best Regards,
Petr

