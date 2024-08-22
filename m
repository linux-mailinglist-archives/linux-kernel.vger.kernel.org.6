Return-Path: <linux-kernel+bounces-297788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A395BDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ECD1F24A59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3291CF2A8;
	Thu, 22 Aug 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HdmhTDMH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93A6F2F3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349027; cv=none; b=NidB+d8wUfm7nje+YU42pPpTvEopoXQGLUztGZY7tLdNohgF2vLyepn1E+4PdS3RN6wgodzDXwZ32mSs7Tm/MZuIW2v5CDHYexuf1A3c/4oXu+w6fz9b4aOWifkVDnOKngoWJjkwYgG0rr+Ja2r6piEByj9irh8DpNIm33L9cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349027; c=relaxed/simple;
	bh=dvjLhd87vCdRo/xiVsfDDYj5ouJ7dOsDPOl5m/jQnB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzck3invs3pd6vE7cMOtv0gTfjy/CRKN8ZGkSn2blb4s8JgGN0tmn7ZZB8H43TXID/Kr3nAJSJ9Ju7b9PS7i1Of2Fuhcy5I/rzKU0u6AFwRBFtGGa0iutJ/r68+Gf1A9Ep/ulEqcQWUD9yAbQMXQznZuNy/ijfOgLcY7HV1eemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HdmhTDMH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714302e7285so938471b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724349025; x=1724953825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCVHnlO2pIa86JaK5QjGr85qfeXpWfBdUE9lyP9m+/o=;
        b=HdmhTDMHdO0Cld6OncFcPIZAjg/uddeimxjulI3Ld4XVDE5G+5872NDI0wXrAVpx51
         uGbPsNkdAXEOyZfWZNgTi//CDbasczllkNQiMCBZ0gblO9nFUTXxjfYLfVyJVB4Aq7n7
         owSWzVTi64B+XpCgePSRh/V277TT/NWvHyv9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349025; x=1724953825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCVHnlO2pIa86JaK5QjGr85qfeXpWfBdUE9lyP9m+/o=;
        b=HvFQH9FAr5cCWK/qq1+8zY03saj4Yx5x08n3PjzZfhk9MMBpsoKpQkse4nOm1oDSLY
         hP12EvWIMoPuNlG4Zw3LXnmxDZ8s+b8wucu4FCpRbFuYEpI1kqBqc0+4CmjEr0D3WhgZ
         SpykUn0GH3GQK2erxc+4o61ghcDb3hYZYP3EsNlWvOnU2aUzZy4E19IfGEe+LusKCgwG
         yPa0Hm8PElePDzDeJ2KippuTll5Kyi4Ce5xWW0PelRrzJyscHHLhSf82AxsPJYGmovVy
         Crrz7FuBCACYTN5aNp6voJlYjsoFNH3hUw/ujs3E7a9EUFAnw9EDCMJ4mySE6bnO5Gal
         4VIw==
X-Forwarded-Encrypted: i=1; AJvYcCXkv2Ow0Wk/U9SikI5ijv4latCYBxE82J4q8sKpW9OwQFghk4oQZR5TlF45RBMFQmTKXEqS4dG8oytJ9ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ds8cVdWFVAVs89HaqwejubE69Vdn68tAXeQRaQKHegyLpLmU
	9dDpVaJnHbtSaUOFusV37Za5N+TRik2lR/y4sVrNiSflQd+2EySA8TB/tIf4Yg==
X-Google-Smtp-Source: AGHT+IGfoGIJeQ5mwpQoLfvcD1BDbE9Q0hdoNktosEIXDb7FIO+5WC0W5xfEfFjtY5088xV28XfHJg==
X-Received: by 2002:a05:6a21:3418:b0:1c6:f043:693f with SMTP id adf61e73a8af0-1cada054f37mr7146439637.17.1724349025477;
        Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7143577090fsm1537422b3a.137.2024.08.22.10.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:50:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_cmd_802_11_scan_ext()
Message-ID: <Zsd6YE6z5CNWQocz@google.com>
References: <ZsZa5xRcsLq9D+RX@elsanto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZa5xRcsLq9D+RX@elsanto>

On Wed, Aug 21, 2024 at 03:23:51PM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with a flexible-array member in
> `struct host_cmd_ds_802_11_scan_ext`.
> 
> With this, fix the following warning:
> 
> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/linux-hardening/ZsZNgfnEwOcPdCly@black.fi.intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Brian Norris <briannorris@chromium.org>

