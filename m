Return-Path: <linux-kernel+bounces-291614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75839564C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7576C281113
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67776157A55;
	Mon, 19 Aug 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iYG2qi9N"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D114D28C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052948; cv=none; b=KadOxs6Nm0JwoxRLViAYBm12rOraHTHlPSPf02EEbo2jJ1G+hcAGm3wGDW8DvW1h2KKGueHGhz8pqUpvzMw4RbRqyxFuFbStWC7VinULRa5SxSfxxfq+eTRyH19lTDeAcACRdkdoHEt+QnPRodwYtUPIChbtd+oMO879F3ZEWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052948; c=relaxed/simple;
	bh=spq6B6sb/ZIFGYSOPazEWb0knQr9sjtzp6ILO0qVbpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A85EOX02iVsDd7ropAlijNFPPckwgHO5CQJRwvwBocLNLcLUvO+0VTOlIois6poPdiYNn8hT3+V9GW4+ETEgzHtsrSugnOFwnvybHBZsv57pcrZvXWLVKgBfsb6jfYo9pP96CWCODspMiOeCMRzxthDNjChFs7q5R1Ozjzv0l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iYG2qi9N; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83597ce5beso603081566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724052945; x=1724657745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NyA3r+0SEkxLBULpRBSrNH9reIkd05NfXfPtxwYdwY=;
        b=iYG2qi9N+XFV32ngjlPE6AfO67zxKYdoqJX7bo5UPvTH+dmQ0HH1u/XAIPvJ4Y7jPc
         taMHmqmvaswoQD416pv2cTVRCaQk7qHWK8f6lByr+SrT9h3HiKojnyTF1FDbS+SHqu4y
         gjHfw4md/kZDnEauNzOyqp8mL2MtQDGVoPBin9E997GVYnACYsvJAtJtgA1cZoOyOsVr
         bV3B00fYS1DmIHF6BhLA4e3rjx5rnMfuV1ZFgTLKivEgahS3SW5nNQZZEXJl27wBcmzk
         ArnSbicerKyq0/qfldlIUIjzW16bJCGbOb7W4nuPlQfh6DFL9mDys0pd693Lf0gjlKyE
         CBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052945; x=1724657745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NyA3r+0SEkxLBULpRBSrNH9reIkd05NfXfPtxwYdwY=;
        b=tL6Lbq4S8padoGeNdlvBGKOOKl/0wDFQIZ//IlWW++wbOShK7SyYecxBoQwsGnhyYh
         wy1wFUflJUkFvrSTy5ZVBztnxbmCFAZHUYvd5nzEJbfNAPls91HjJxEw9GIfYnWEEuJk
         L4v3BnrdYslcmjIKiaIa49FClM0LQJyYfsQOltfDs5GLhdxdHt/ohVCxxuH16pLOAIxL
         a3ngNmmDtUO4Wp1BBLZ37eq0PS1tou75cDwATg2dyiVPXTQWKPhuduEpmSPhsIbXJKD6
         Bqp2tDy1BpzKKa1vLx4KMN4F8PnVAJOPnRS/ruQS1wO64ezr3JKNNxZ0XmxKhanZlTli
         whPg==
X-Forwarded-Encrypted: i=1; AJvYcCWYm/hO2nHVcpyuO37L5GICjVfJgIuqc3z22YNZN8UCpQ0BAq186Sqgish3S6aGS7xwwp77Ox9zjmFhNa5B/6LdOpytSiv885ZIE6Mu
X-Gm-Message-State: AOJu0YxhTSCnWHy5Gqh9UBwlptYjq2Lgc30YGWurY3hIZjqliW000AEB
	TJ4aSv2VCWV9+oNg39GpupYyVg1ft+7UbLRiy5N2DPBqgrEOH9AWbQRcV9dAQfQ=
X-Google-Smtp-Source: AGHT+IFGNW4Rp1MF9pErnW5tAeVHGUBzNbSFgBGlimGRBnHwWDOlPps9HXt2/6wAXUpzwZnZvX8mQw==
X-Received: by 2002:a17:907:6d2a:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a8394f7e0b9mr963569066b.22.1724052944878;
        Mon, 19 Aug 2024 00:35:44 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6c07sm603195566b.43.2024.08.19.00.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:35:44 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:35:43 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, maz@kernel.org, mark.rutland@arm.com, saravanak@google.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v3] of/irq: Support #msi-cells=<0> in of_msi_get_domain
Message-ID: <20240819-3fd4ff3cfa1d216a1241f5a0@orel>
References: <20240817074107.31153-2-ajones@ventanamicro.com>
 <20240818161816.GA173148-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818161816.GA173148-robh@kernel.org>

On Sun, Aug 18, 2024 at 10:18:16AM GMT, Rob Herring wrote:
> On Sat, Aug 17, 2024 at 09:41:08AM +0200, Andrew Jones wrote:
...
> > +	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
> > +		d = irq_find_matching_host(it.node, token);
> > +		if (d)
> > +			return d;
> > +		of_node_put(it.node);
> 
> Pretty sure the iterator does this for you. I can fixup when applying.

Doh, I managed to mess up my usage of OF APIs twice. Thanks for applying
the fixup.

> 
> I plan to tag for stable too.

Good idea.

Thanks,
drew

