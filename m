Return-Path: <linux-kernel+bounces-352653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72A1992231
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FC52817B2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1D18BBBD;
	Sun,  6 Oct 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Q7Ipy8tu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC418A957
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255504; cv=none; b=sW2TLZQy5Iwo4aetaEXXGB0iIWsomC4PV/CvebKXmJaQ97txwStZeFfNdTB7Qlmi+nuOoDbR504h5fmRd9tSepWNmGxZT6bB+fP6y1Zm8CoydOM9+YmRXIhmuyxI++DJ+3k76l/chDhuwJvV1Qtn85Jf94S/WaoH85BF/JIdqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255504; c=relaxed/simple;
	bh=shZDyWvvJS1+vbJKipKl7TBJestfbUJaPNb4A0EOoas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noWcDebkLRgV6mazyrDbTQKy5vmEbh6QiW96VMwssChSZThThUUBn8pX7V0t7dYZS9GIoihXgHsRWKvMmT/IWw46xrmlTA/uw9W7R7XI9rhPNem+W0fQit4w8fP0s44a8v8t6uehSMG+8dF8/LAWxUwzBs4P74JxfTfuztXxxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Q7Ipy8tu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-207115e3056so33686455ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728255498; x=1728860298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shZDyWvvJS1+vbJKipKl7TBJestfbUJaPNb4A0EOoas=;
        b=Q7Ipy8tu/MgBRHVxVfgDLGa7zIPC9ock/zI1bOcq9/jogk6G2EH1AMat11YO9ERxc9
         DKXMr98nr62N3U97cxGQcpUSjGX0BKeBCXN4zd2u3xecrMyTfA9YRMVKCNxn50MFHSF2
         q33fXu0rSYKmKjIC0Gg335DxJo4ldfOY/LiVrAIRlwenjXqtRYNBrbyLa/ov7WeB3TvF
         g32WNV8q2E86DviVlUqNNxcH5SzMZbhG5FjH+Z/y2iUyQoyDSNKGwtmAYNXmlZ6FcI0y
         GiJz4Sssr/3qKfQyIdf0FyAZF3VtnTs6PuMvT2ONXnpxQ31MlPrxc3bJVvVQOw2lzAp0
         cLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728255498; x=1728860298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shZDyWvvJS1+vbJKipKl7TBJestfbUJaPNb4A0EOoas=;
        b=GXgIJ1XL0m3p2kKUqoQtcjx8LUBDmqygxEHLg3XjZFxrpNT6X2zLJ/VsTvaNgqOFx4
         2LPC0HqpQoHC12VmAOWSm+UOhgeA6oUjzpLJITMN1fCM/DBz3QI/Q4ecUPYM/biNIjox
         YF5pCB2bWuWFx0oLrLE6PNBXm5fOtdCpUmo8/2Je2AIxsM3qE5i1x2pA/1OPbD01Tb33
         HmF6CvkSCzfVVy5rz7y72oQQOcYg7bkEbQaT9AkkSHY2trHV0M5a9LsrgTJPz/FHSu1o
         TRSR0vUMgAGbe8Mck8zEk5xDLisw6MJ480AnmKWcoalVRIy99MMcf7DvuNvAVi1TwNC5
         /gzw==
X-Forwarded-Encrypted: i=1; AJvYcCXd7AUFRYY+jQ7aPzHeLA/WjGLVFXcLykD8nVFKQIOY+dokgc/hHVN62W1QvMpXrDtDgzm0AVPNaTRHOIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzubsqe/FgFyHsq3+AtVwYG1cg86xFVhh7VPezOJrVk+27Ohndf
	gWb69lOkHuquFs4Xjedll4yanp6r3qOvQ0UFyL8LdqpHZ1QTjUqnMeNCJBll26QCdFGYVBa7QzI
	E
X-Google-Smtp-Source: AGHT+IFPMCwXglsgE0YefVyYhHWUFUL20s0BZFZ9Wmp5tfe5UAbc/+G9dWvwujGP9G02so7NPzQewQ==
X-Received: by 2002:a17:902:ecca:b0:205:753e:b496 with SMTP id d9443c01a7336-20bfdf80029mr116924685ad.3.1728255498269;
        Sun, 06 Oct 2024 15:58:18 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20aeba043sm3981434a91.13.2024.10.06.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 15:58:17 -0700 (PDT)
Date: Sun, 6 Oct 2024 15:58:16 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] riscv: make ZONE_DMA32 optional
Message-ID: <ZwMWCNYUwrW0oWVn@x1>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>

On Sun, Oct 06, 2024 at 10:55:39AM +0000, Vladimir Kondratiev wrote:
> It is not necessary any RISCV platform has ZONE_DMA32.
> Platforms that not support ZONE_DMA32 should set
> CONFIG_NONPORTABLE because lack of ZONE_DMA32
> makes such platform non-portable indeed

I think requiring CONFIG_NONPORTABLE is a good idea. However, it seems
this patch was sent as a reply to the existing discussion thread.

Thanks,
Drew

