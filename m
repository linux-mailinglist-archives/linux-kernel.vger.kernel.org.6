Return-Path: <linux-kernel+bounces-370727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFF9A3151
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8902828E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558061FCF4A;
	Thu, 17 Oct 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GE1NalVr"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535A1FCF42
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207109; cv=none; b=huvfPOsYWL4dhdnGhRhwgzKvMDF0rHLGtq+kc35yjN65yg0Hn76snw4MNTY9TkWt31qGR6aLU2pHFijLJjQVmM96nWjzDEbtUeq6csbRuYHWktdDqs3dbuVaNToapO/RkstOfeJu+N3NgtdrmF54s66Hexjm5FjGnMRqEkCq+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207109; c=relaxed/simple;
	bh=1YJKLaDzXZJBGszdCWaBM9BXlp4oLn2Qp1cIPCql4+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeRQ+EyXmRB21FWQ70xLyEmHTAj108iAPnIEGzctnSSv9CWlfEmVE7uhcIGVCTux1PoC4xTyBKY91vrwj+odDsK/JxR1EptkEVoMfpbyGQAGfnXSslrU+m4MuMMDxwzjqcycpApWBCOGmx+qGV/1hGuru6aL2LHRHxplYxqsTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GE1NalVr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460464090d5so12519051cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729207106; x=1729811906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6FDSzJ8bhsF8vdcDCL94rN1SI/To9xp299yFHn5dIsI=;
        b=GE1NalVrFxg5Jqj0mCxRulNBO2wyL/ppkuvZY1T/sc4tjfC1Tv4AAn8s5ptUsJ+l7f
         ycfTEp8sHMlsLykeeXUTlL4PYJtdw9X977VuQBg7ePHYv7RcMDeYs3UTRiCfQfEjlHOx
         yEX/ZEq0N6jrue0HC0bcpnBhHQ+yhrW1uHd7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207106; x=1729811906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FDSzJ8bhsF8vdcDCL94rN1SI/To9xp299yFHn5dIsI=;
        b=SAD9I7BjCYFmOa/P9cGcPCWm3TpqVuZeQwZSSm5k09CW5VHZrOYNX306DPguFMRAGa
         /Mzot6e00rbAsRfmSD/vLwdSAtRZBC7HWFNn5WjyDXUzJ5+TMr4YR2AvFIYHHa5iY5kk
         thtEGtBn8WIizCsInGuYIc+WbFqsC8zdyRZ6iHeicQr8XWDA6R6AoC+0hJmPeYyMSPgy
         yTLnAGazFaZpPZfCFRN9AvTtwmUso7yt6qSjR81HGy45EBsqrC+5uGeuAyqq6CA4cxxq
         oevPTxSQPPEMOUmj1T6tEa2RMi1QOdWOcNPcLnu3/XCjtsAhW35yZ0zpakRP/f2U2fc2
         mXSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6bWVfzoRZ8N1+Z1m7SW5ugz2fHoEWbUDjgsA4KTALlHRCtB3F/oWlmmHz01ecbmELePyiMu7ES93NiIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCBut/Abo0ga91+2NYByDCjqtOBi5epRS/Tv++FRKBrnhKvNw
	yh7xUMuL3roHPFLsWXHtam7VHiAG88YVJDUn6Vdc46BHq8vwO6zxeo+NdGKEpZAsESi26KSEtaZ
	Zr0or0VJ16qHRq81oEPN6W1HnsgBxSd9EwZBa
X-Google-Smtp-Source: AGHT+IGfp5gAE5G4KXGJWAqhtTz9SCjd92YYOnHa8m+fbXN9Ki68pFCs7qSpp+M8wRW+2iIS00tS/Yjx7pckeE5onug=
X-Received: by 2002:a05:6214:4808:b0:6cb:99db:bdbf with SMTP id
 6a1803df08f44-6cde160f1bdmr9758756d6.43.1729207106060; Thu, 17 Oct 2024
 16:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com> <20241016060523.888804-25-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:15 -0600
Message-ID: <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v9:
> - default to BLOBLIST_ALLOC on arm
> - Move default for BLOBLIST_SIZE_RELOC up
> ---
>  common/Kconfig |  2 ++
>  lib/Kconfig    | 15 +++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>

This is fine, but please disable it for snow since it needs the FIXED
option for now.

Regards,
Simon

