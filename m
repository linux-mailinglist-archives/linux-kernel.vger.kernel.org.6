Return-Path: <linux-kernel+bounces-173119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D178BFBC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6578EB23230
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9881AD0;
	Wed,  8 May 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XnrQWGaa"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D2824B9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167159; cv=none; b=Z+5SPS42cPRHf4Od0t8ShRQL9zQYhNNF5esUOm4s6xDUk43yl5D+NhN2qEhOP6l2L0lLeRNSKZdyWp6aRtkEheA27Q9Mc28INkB772tQu99Vg3X5GZra3O3kHpvz50GrRud0lTZ/vDvJZx7+xw72QlB9eHbVmPnhjQLd3Rwyqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167159; c=relaxed/simple;
	bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9L9TV5Snws/PH++RnMZ/q/bWY1C+U4CCGVPM3f5C2EilDfx3RH3LXrfCRm6nUTbNqrD7VahTuDCMBrfveqSA/M+36PGqWgUPR/lgY2bAD91ippzv0QqWqrJ53HLgSmclarRYfcu4hvxvANbsMx85Ra4pUAAIoc2WpP06OJVSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XnrQWGaa; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23d23a6123eso1725299fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715167152; x=1715771952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
        b=XnrQWGaaiN/Jj5WIv2YisHfx21btj2BHsrRbWMz8NcyUfMUYFhbpZWOl67FzUCQiJe
         HQZU8hdvQcZW6DrtIhcPUYRTrfy/GFrfmYCbX9VmkkH8oeir8uLWPb3Ax1+HMQIRRdoz
         +BCyxTpxcpAV7rUNwFE4OfvlfvK/0AeUIlqbsTRbpSlPxwu48hfjALubelTSjgSGDjfu
         hgve/46ujOFIBATvuBrOP65z8wzYh2KGDkLHBiQMOXMQxAsWrOpAIzjpNnsb+IPallok
         jkrP4wFps9w4ddsj+z0IzpuAGVPiBl5IM8tHJEHzeobawMB5V1+P5RsHqsp4C/OC7Piy
         UwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167152; x=1715771952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx+9Xgjt8qYgmhILpcyWB1vEDTF6K3IN0xYImBlQY5U=;
        b=PQHxnadbwYng0J9ZkDYWJEhaKzsrPSX1UnL2cwTThl24Mv0UIkfOZr+KZ5ccus1qXy
         CI7JLYrDNZbrSL/Ed/VtFP97OwCdJz1uoNRy8KdTGWYXjFzraBj2Zmax8W6iDN/iqg0a
         mPKWciNkpoBPXNlmtsMKiw1xayl0cqukiq+WxPDlF7a5cBj8E4BvQ31yc9OV1m9dvbEl
         C5C+Zc6Agk3zHdO1YYBS+cuNxppbsVwfAVm4XI87cNVtG3vv9qvNkssvUXD8g61OEY+P
         4lgT24a1hgrlZl0/lMW80MJ/S4HaQMJpVpeE6ARNZBQJPP4gINHZYOg+UHp2/ToG5Egi
         6zDw==
X-Forwarded-Encrypted: i=1; AJvYcCUeWhIm8UyrqFxe3uMBpLmiQ6sdBlpTG7KwgpuMFJY7DfimsulfcyZWJtZTGAnEEOl6IE47832F66e74jMOcIn+nH2j7ZTHchnUtJsC
X-Gm-Message-State: AOJu0YzPynwXM43T/asDul2svTGDM/9KYv4YTm7Cz9M5RqwO+6K0Jlby
	/vTUgCnhvMBWii7FcenHS3v5aYViEwdEsnc+G+/goBqYObf4824HMNrJ5uCHe6mgv4Eu+tjFwsb
	WLs5sjQ4DH61ct4auib9Q0nbJe3SpgTo2ewuOIg==
X-Google-Smtp-Source: AGHT+IF3+5FujeR3kO7PsOpHF+5mMBxLYw8Z1NzywDpU6OEN5QBCAec77PNwgwaACUPo4GNnUyl3QXQ0Gu3mZ2LA98k=
X-Received: by 2002:a05:6870:c155:b0:23d:45cd:ee66 with SMTP id
 586e51a60fabf-240992d1c8bmr2486931fac.55.1715167152059; Wed, 08 May 2024
 04:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <20240502-herald-catty-a03eafc4e6b1@spud>
In-Reply-To: <20240502-herald-catty-a03eafc4e6b1@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 8 May 2024 19:19:01 +0800
Message-ID: <CAEEQ3wnthxGbrJ_qLnZUQ9w3E_1UWgMign5P=+rNP2p5xGm4Bg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Conor Dooley <conor@kernel.org>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping...

On Fri, May 3, 2024 at 12:37=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RSIC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> : Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> I'm not an ACPI head, so whether or not the table is valid on RISC-V or
> w/e I do not know, but the code here looks sane to me, so

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.

Thanks,
Yunhui

