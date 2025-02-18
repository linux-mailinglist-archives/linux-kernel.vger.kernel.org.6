Return-Path: <linux-kernel+bounces-519452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2AA39D13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2291F3B95D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91A2690C1;
	Tue, 18 Feb 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onc8qgVA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E50268FD7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883872; cv=none; b=cZ7u9llKu4I0ZiV+s/dZSx3U17G/hU6HzzLEu2JBJoab8+MwL2BgwpJxQJrxaVXJ8o4zNQiagnH7H6Tu0XvCku0t3JZMEdVuRI4krjZSU+8OFmGS8QXmUr5Juml0lyQAE/stuyqjPqHuv2WXI8kTdWt3ddeYLBB+fvqQ9Ogzn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883872; c=relaxed/simple;
	bh=MHVuSNBLM4BpztBJEU4/kxPfP1t2Bjaby1gsrR8kmdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwks9tgo11MwiTKfORyyAjV8kIFAd+5uHzL4urSFybPEVUNQyXv+fz9/du7SCKEWMEIo36WE/WzCB1fbyGqDEwLkuA03YwTx3ME7eElZEuVmIixBlaY6n8lJ1fUGItTdi4qIWY4rzA06R5lwwsFP6j8CVRYmSoighM6FXNPIpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onc8qgVA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb892fe379so358847866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883869; x=1740488669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Md734qHcyvpdwz9o4Y4J6b9qvgT6ZStj8nzECjc5p0M=;
        b=onc8qgVANXbej1IFqBVtBDxQSBR32a+I0YmK04jpzuECh7EHyUij5GFojJHmPpDiRV
         ZgcVpWOwQf+6nmLUog0Fbb3nHu30Ijw4XwDsizudRxNe8gyXsQ8KBVAltvpmKgy9TW4x
         jpMGI9fP2jcy5UXjtFTDsY/ORBDxbMxfGO4ZXzqxo7fsDA1ghTE7SwyQ2cMpLAAuTwfl
         UNLm5oqhuZklz3SVTt/YGWaf7qJecHbWP+czS+T2BNGQcKkR3Sis2YgJkvaeelqhBrf5
         vBvNv3idIWV8M7J3rKizJwump1ewH2rTLWQTbJINcJEntngAE74/b1cVtmTDM2r+iawO
         mbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883869; x=1740488669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md734qHcyvpdwz9o4Y4J6b9qvgT6ZStj8nzECjc5p0M=;
        b=aOccM0Wr3qNMgcr5acg6VNomWizwTsidV4i+5TRfs0yClx58ool0WGx9SSjWyMZTaE
         y/G4wFvFNmFsz0aZv33BdLCHh+hUIClACZVln+kTimEs1zrun0DCwPFRjjgFKzb9NRQU
         N4g7ACTCIM8s53tw+/bZ1M8y6z7s8cHTQiMIROt3vNyisQFGqe7kCsiwRss2lnoIOYf5
         vKLZvXtwGHh3dZ+S33Jtn8pwwIxuw/xYeNW8+gcyoU7YOsN5G0jScWSPavoHcfDJMW0N
         NiYjeQLex1JWTqzj3fcBnCRdCTQCjdfg2oNBTux3iGMaWDcMBO9QzkapXMUc33ITyMmj
         IXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXUPlf+KT9dNAcl6ZPzF+MDgvmjxKKG/O3k5UgjcxQ6e0ISTYRqmfWkGwNna4SFSGIqVFMOgbwH6VarD/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8SGxvVkAeZ8IwSyuWj2RgtnRGr+0qco6RJsDm7YIrnR4VdHY
	nxw8GlGB8NgChAF7NBKZZbVM4+erqQ7zDhjKsZJktwzd0w0v03MIoe3e05S/cvLbv2RBUHxUTLG
	f
X-Gm-Gg: ASbGncszUsxuTpAjjzPJ9PcRNTxc7Iz83AY2lBe96W/FP1NsjJPrLmiRBNhcLw9QgSj
	PjY1KSL5l4K+P8gN/03K05Awb0t+iGyEVkZTGQZARCF6VcPHqtmQL9jyYEYH9kKHqLJHyM9aSms
	ax/tcS88tYuXdxKNLKQSh6qWp6bodilDxdj0AeziVs6PB049cZ+wM1U9h4RuzsgP/gxgr3FoQ7J
	7I/2ERjaRhawi5kJl5HBcdUYFQRj+mghGk0/CKu3NIwQiS6WLA5Dbeh0Ry5+lie9PQy7HrBbT7k
	NLsbShF0al3sjJRPEXRj
X-Google-Smtp-Source: AGHT+IHbWZcfDwWtXTuM1/x/IlqYTAmRUuYgosuY0tcKBoinJw+DAmVHLUpd5PTsSuNOZAZ5PWkB2w==
X-Received: by 2002:a05:6402:3710:b0:5e0:7cc4:ec57 with SMTP id 4fb4d7f45d1cf-5e07cc4ee69mr5027807a12.31.1739883868810;
        Tue, 18 Feb 2025 05:04:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e03aa0b1f7sm5314855a12.2.2025.02.18.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:04:28 -0800 (PST)
Date: Tue, 18 Feb 2025 16:04:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, kuba@kernel.org,
	rmk+kernel@armlinux.org.uk, broonie@kernel.org, arnd@arndb.de,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [PATCH 2/2] staging:glib:hp_82335: Refactor kzalloc
 size calculation to use pointer dereference
Message-ID: <43545be2-bde2-4d15-82fa-282698d599df@stanley.mountain>
References: <cover.1739794938.git.kumarkairiravi@gmail.com>
 <b3358e0d2c50a7d0777dd11d6e34ed9a52c00377.1739794938.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3358e0d2c50a7d0777dd11d6e34ed9a52c00377.1739794938.git.kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 06:26:17PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> Replaced sizeof(struct hp82335_priv) with sizeof(*board->private_data)
> *as checkpatch* suggested.
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/hp_82335/hp82335.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
> index f1c2045570..66557d6964 100644
> --- a/drivers/staging/gpib/hp_82335/hp82335.c
> +++ b/drivers/staging/gpib/hp_82335/hp82335.c
> @@ -205,7 +205,7 @@ static gpib_interface_t hp82335_interface = {
>  
>  static int hp82335_allocate_private(gpib_board_t *board)
>  {
> -	board->private_data = kzalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
> +	board->private_data = kzalloc(sizeof(*board->private_data), GFP_KERNEL);

No, this doesn't work.  board->private_data is a void pointer.

I recently wrote a Smatch check for this kind of bug, but I was letting
someone send all the fixes before I publish it.

regards,
dan carpenter


