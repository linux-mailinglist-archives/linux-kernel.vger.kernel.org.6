Return-Path: <linux-kernel+bounces-512296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87675A3373A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD15188BB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB42063F3;
	Thu, 13 Feb 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXV8gn2U"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16E2063FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424377; cv=none; b=r1Vakh3r61Zp0Ad27sfcnZg8j10sOIL3LCCGod0B9JMC8wZHKi5wTdCFT4O8R3tmkMczyS2iW92mJneF49cYFWy6U0TBZ6RgMehzgatVj4lomWCzgxa70raNhWDoepw1XrGjoLFG/IGzcpbwOAe6RNklCpwC8nwYH44rFtB3vRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424377; c=relaxed/simple;
	bh=t6YR0npYVjRvyKj0ZE1XLCJjmwLZGXa/7c4my+oO014=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmySkNwbKBDqW/GH7fIdPehLaW+kSxa51zgRishDv++7QDrAvraK2q4z7xR39FnZFjVveWbniYhuHzaGZ29jfsXiKU97oa/B3xhqjf2WphNBj15lPUCzp4pDbb09DGzn+o/A+RTLTYhzLE2lHzT5xpZMeiWfZihJ6i1wP3rtPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXV8gn2U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de727f7f05so783520a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424373; x=1740029173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HAEYUoXN1RzPu9Vc5RFXNu3L5U0k8+uT71SbgN/hXA=;
        b=JXV8gn2UZhGegF7+LPmcwR/bRPnsW9fAJzgvT4gqFCIX04Ux2Oek21eAK5biQR5/4V
         OjJRN2ha+0CUdpOUZZgFlEpnDUrUXwHVvnUgpz5BNYSsKWw5hvoXC0BQ8Kx4ImGBz+dc
         15bK/+8mTYV/0C38jLwQ1p0bgRqluAJ8lzaXfrYV9bsS27a6vcqFrtdWoeP0tmO6JAaB
         PHHszoU6y+dx9bA82OOMBGSPILMrjtqdx2/AseUuZNhfUPfWD3hb1egs6rAnGKoJpEmT
         awDRzlNaxo5o4Y1IeFAunzpAIt6+yolsLIOcU8xfO0DNNTxlTHioETVOtHZvl4fFlQhI
         /Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424373; x=1740029173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HAEYUoXN1RzPu9Vc5RFXNu3L5U0k8+uT71SbgN/hXA=;
        b=SHujH1XjTxB+x7dRn/4ZKnVZCuXuq+XgeArdZhmEde1s8u3WQ4RVaT/EF6gVAtTGg7
         MywKASkzGKJkBd8VSXNZG/ncxzu3jtGpBlkTfsbgcyzpgSczEGzpXoYBKem6lE3GurRX
         QlhIVQB1u+DOqfuYBWe62KOrgTzzEji8pykgHgnkYIQCe1GkCxesvXWRoVFrQqH3NfOa
         3Ssr3aeOQQrAQ5bWaRq0NV1rWxZS0XctByRvf3KZgNvyX8nMOnDH04vmlsiHo/47c25A
         S4KLZKnU4Ez8HQQ+W+3uKXUpZAMXy2g3y6y/as5U/KDbGhyvcGH6xq1OvNlhYIkg7vjj
         yAkw==
X-Forwarded-Encrypted: i=1; AJvYcCWi26aCXxNAKstRwEcuvLqfm3c+CbvxJJAWbAR1BdPRsbHpFqM/9eDSAGIdlDU/uipTnNbK9PwcfdPGVvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9sxupLvJplRPnNhu/DxCXkeZ15cvVMbUgRjUH3URJF3xywG2
	ohAwqZPw3ukeeHET9Mh0aXfA5Gw1pqJJs0OOZik1/sCphDLZdhGToxke8vVJcAw=
X-Gm-Gg: ASbGnctVXYH7OOH6TfgOyjtRbr99kr6EbsAifvBtJ06yIsIFzhoqvu/yAUzKslbfbba
	cTEEjrDrbJ6+NqpV4Js8EAsqhcb+U3RDBA5fPdDBF9hgapUwST2hQqbG3hAWuPTHTDGuUhuF0mT
	oLLLG3lYuoHyhJGRAOTrIzKwsyuS5vAfQ8SMTOEFeK/3EqY6vDGudolQc0AM0u8uWPP2YouNqvO
	sHt3E0PvlyDbACXpNFVoTzg9M95ecBJY0WHxd6SQ9CSUisE8OEETtALX/2//NomIcQvy/xdsOM0
	1sPMrHI4OULIv9S3VowZ
X-Google-Smtp-Source: AGHT+IEzj9Ta5BdBT6AH7PreThdj8+Vp0LN+dbci6CqGFf6XXQjsFFpLhPxNkTgcclST41hSlPWi8A==
X-Received: by 2002:a17:906:7956:b0:ab7:f221:f7b4 with SMTP id a640c23a62f3a-ab7f34738c0mr544342766b.43.1739424373199;
        Wed, 12 Feb 2025 21:26:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba53257618sm55687766b.51.2025.02.12.21.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 21:26:12 -0800 (PST)
Date: Thu, 13 Feb 2025 08:26:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <d6eaa268-e4ef-4d90-bb1e-37a7f546da93@stanley.mountain>
References: <14ebc311-6fd6-4b0b-b314-8347c4efd9fc@stanley.mountain>
 <f66b15a3-1d83-43f9-8af2-071b76b133c0@intel.com>
 <20250212175901.11199ce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212175901.11199ce1@kernel.org>

On Wed, Feb 12, 2025 at 05:59:01PM -0800, Jakub Kicinski wrote:
> On Wed, 12 Feb 2025 17:46:54 +0100 Alexander Lobakin wrote:
> > > [PATCH next] ice: Fix signedness bug in ice_init_interrupt_scheme()  
> > 
> > I believe it should be "PATCH net" with
> > 
> > > If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
> > > then it returns -ENOSPC so there is no need to check for that in the
> > > caller.  In fact, because pf->msix.min is an unsigned int, it means that
> > > any negative error codes are type promoted to high positive values and
> > > treated as success.  So here the "return -ENOMEM;" is unreachable code.
> > > Check for negatives instead.
> > > 
> > > Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")  
> > 
> > a 'Stable:' tag here.
> 
> Bug only exists in net-next if it comes from commit under Fixes.
> So I think the patch is good as is.

I want to resen this.  My scripts should have put a net-next in the
subject and I think that changing:

-		return -ENOMEM;
+		return vectors;

actually does fall within the scope of the patch so I want to change
that as well.  There is no point in really breaking that into a separate
patch from a practical perspective.

regards,
dan carpenter

