Return-Path: <linux-kernel+bounces-332026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E901397B472
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB3128377F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5D18784C;
	Tue, 17 Sep 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcdfm1Pk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5D145FEB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726603521; cv=none; b=BcstsmWZUfF1DY44qCFwKZPeEmq47MC5zjJZMzkGDwA6Uc2Pzhvp5OS2k83VHfkVIsf0M6EMXoQzbZPETH3FrpqFkmu4ZrF9vwC4Q5BVDxMtS4wftqgD9fSIWdQU+iwqlsoZCysjuMDDni7/DHOzNsPLXSLFaw/pWIvyZl96KK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726603521; c=relaxed/simple;
	bh=SfodZ/rtM2jhxXtzGw81B5mYu4eTU4CKiUf1fOOsm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOlh2IkrDFjllWB8I1NWdCRACmUMtVVcBd7NamSypngAwnrAH3KBHsBvWMZvUnrYbkE8Q34ndUViUxxrCI6MAQjJtVwPmQq05T6/GMbpicUnTXhREOhvw+PWPxcgpf0cmw46AdpPf5+MUZiVRw53hN9j3iw0av4xl4qHTmNT09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcdfm1Pk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so6285352e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726603518; x=1727208318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BAqZEURXqmfkfN7P6xqojM68KIepLhSNWCqaR0uo9I=;
        b=Gcdfm1PkCiv4aFOkeI6H+A0246SS/0VNF0RxVUi3uL0AqWEvcyc1jMU8JFkktt4rNf
         2gDgRgKma7QbJ2B/vDorAonRPZ54+pDoZJZnkNmjCdt+z6w4ZZB4/7IE3KOiu1UESIKe
         0asQWuuPfTQz/KbVeQU0JTyubc3e8EPKW9sKqZ861Py7+KzwBMBYfOI4LFbd3iKeTfmg
         IoqaGgYBuBce9C1Mo/vRu6btUjRGET7zvoDVkY6Qz2XRHMgYWANOboONzemxwQ3YjrTC
         FCmnrpuRDxUjkoyxR4KsJa4BjRJ7oVUuPN1dDuGI1RK0y9d21iGpn4w2xJLPEpMXdBwN
         oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726603518; x=1727208318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BAqZEURXqmfkfN7P6xqojM68KIepLhSNWCqaR0uo9I=;
        b=dwLNqlL/1afrqxaoULnQtZG45KZZJLuO7XbYQt/fQFGhM31nZbLq7BKsQehFILpcj2
         l7VmKZyv7PTinNlkKvGsajHKr0ZuDXlCSO1f4M3PWCHDR39G5mpcM0ipQLm8TjAXv2Mc
         J8HTIrvNpzd5w++7en/I1o7Ny1ntbi2iFLeigPIglr5yTRLRZf+FA+vH/4RACO949qT4
         Lv7CY/f6qgEIQIoK8yRZlyCOv8W8aLkIrs424Zs9nmbY46bEiOOtmpMSOdu1I/pj3/kj
         8NSMaBfDBSfCfr7qnfjDyLmzxyo8XZ+tA67EAndhA1FlUeN3zlgSOdPe1CPkvT7Uwiiq
         CCoA==
X-Forwarded-Encrypted: i=1; AJvYcCVKiXBRD3X+o6kr7g121HPl1nUQI1G876npy8/Y65Ngm7xdG2SxeEsnPlb1wEV3hOe7nYjgMm8PRXYTBbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQpfy+sIsJ06GtwuBU4kLcvA7DRAIihA6eAQ6hhZYYZvVYZ2i
	JZSetkBewshgg/kQb02brdR3me1n66yS7Sqbh4vCJvzqwr1P4RU0xViaHw==
X-Google-Smtp-Source: AGHT+IGMIxuzqNUJOUvGmb59uVLTBMVAOejxcAU/dsF1JxJY/nZGiZtZ/Vngc3Cz2bCT6Kw24apbGg==
X-Received: by 2002:a05:6512:ac8:b0:52c:c032:538d with SMTP id 2adb3069b0e04-53678fc857bmr9707003e87.27.1726603517664;
        Tue, 17 Sep 2024 13:05:17 -0700 (PDT)
Received: from kernel-710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4358sm484154466b.71.2024.09.17.13.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:05:17 -0700 (PDT)
Date: Tue, 17 Sep 2024 22:05:15 +0200
From: philipp hortmann <philipp.g.hortmann@gmail.com>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] Staging: rtl8192e: 18 more Style guide variable
 renames
Message-ID: <Zung-0ClV_527-_e@kernel-710>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>

On Mon, Sep 16, 2024 at 10:31:34PM -0700, Tree Davies wrote:
> This series fixes camelCase variable names
> Thank you to all reviewers.
> ~Tree
> 
> Tree Davies (18):
>   Staging: rtl8192e: Rename variable nDataRate
>   Staging: rtl8192e: Rename variable bIsCCK
>   Staging: rtl8192e: Rename variable bCRC
>   Staging: rtl8192e: Rename variable pMCSRateSet
>   Staging: rtl8192e: Rename variable PreCommonCmd
>   Staging: rtl8192e: Rename variable PostCommonCmd
>   Staging: rtl8192e: Rename variable RxDataNum
>   Staging: rtl8192e: Rename variable FwRWRF
>   Staging: rtl8192e: Rename variable bFirstMPDU
>   Staging: rtl8192e: Rename variable bPacketBeacon
>   Staging: rtl8192e: Rename variable Rx_TS_Pending_List
>   Staging: rtl8192e: Rename variable bPacketMatchBSSID
>   Staging: rtl8192e: Rename variable bToSelfBA
>   Staging: rtl8192e: Rename variable Tx_TS_Admit_List
>   Staging: rtl8192e: Rename variable Tx_TS_Pending_List
>   Staging: rtl8192e: Rename variable Tx_TS_Unused_List
>   Staging: rtl8192e: Rename variable Sbox
>   Staging: rtl8192e: Rename variable pMCSFilter
> 
>  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 50 +++++++++----------
>  .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  6 +--
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
>  drivers/staging/rtl8192e/rtl819x_HTProc.c     | 10 ++--
>  drivers/staging/rtl8192e/rtl819x_TSProc.c     | 36 ++++++-------
>  drivers/staging/rtl8192e/rtllib.h             | 34 ++++++-------
>  drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  6 +--
>  8 files changed, 77 insertions(+), 77 deletions(-)
> 
> -- 
> 2.30.2
>

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


