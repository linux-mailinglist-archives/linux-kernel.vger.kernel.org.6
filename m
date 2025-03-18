Return-Path: <linux-kernel+bounces-566347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E076A676AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D567A39E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6320E32B;
	Tue, 18 Mar 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOA4OlOH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBE20E314
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308932; cv=none; b=GUWXa0Tnvaw0aLILvNGLrZ/ODkYP4v5HSbqGecKovqWzkBTy92LdtRxa8rKHs/zdpJfEqhSBqSLsQnr/yMAr7YINv8nImHvIMu5GeAsK+rUvOimHKx9lgCGGJr3zfOu5OEmucA7aJ3T5otoYY+t0VFu1JXNvNYrT+VyUlAnPrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308932; c=relaxed/simple;
	bh=JkmZGBvm9dkGoXsxhITYAYPxrVQlvPqXan7A9/G5hIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWHtHmRee3gawOwzhsT/sViMNwjmbUs8Q5Km1bMFpZQaGXa+lkXAEgHJWCuhBzvqv1nHRylsiiFyTKLlFc90W9W9+Mw9xjt3ZBaA37qLYnplizyvGPwMlLpVR4OawvHu/iQ/JLve2UCd10Z0NkpLEeCFnNHLHMUX6PJtv2pT8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOA4OlOH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3996af42857so941954f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308928; x=1742913728; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FiuJGenS9r4gN4igDCUFwLVXGDsRuGko4IS+9Bv5L2M=;
        b=bOA4OlOH6+mGOeNTYP4/V2mw2iLRb4ZHG4+2pzsaxMs80FcAI7ItzWpUpRePEp0rwa
         KOMijJUDSN9yVnlR5QcOoEnatobc9ohiZX6ed4/KWuCd32ejM7c47UZ0JMFkuC4dSn50
         fb1i3+VebMYDJBETh7pCbNd/6QJtEKU7XM74kXgjqvW37QHTxzyyUQkkbFxUnAJ6UXA9
         zZwqsTU6oAO8BkYYb4lgE7450NuAjMfQFrcFGicmUlgoNcfiwGxqgZtvuer+sEglI8Pa
         yRrjdTq/tv2USuU++zEVZESkoItdA1qZeUpgcT8FglQEvadHkLbxZfsv9h6aCCk5WS5f
         IYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308928; x=1742913728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiuJGenS9r4gN4igDCUFwLVXGDsRuGko4IS+9Bv5L2M=;
        b=NO8FVlw0jtrQ6vD5pX4jik9Z++Z5dM/CTW+tE8OwcuZddUVAeXjXy9Mo1mWxHAEvDi
         XAGcXL0FyQrTLCpAPNIx+4xeNZBsNJbtcWy0CcGpYH1Sq3U50Njwqj/w95hBZOg6O+ok
         UKmXgtXIc+TOlBCqg4r82KuNNsUhm6aR1r0+xPb05YZpo76Fjx7eGlJhLFGWOLsiBT+i
         qSYQ9IxfAPeX4cyF/2Gq+veCS7dkyIM/nqwbIzGht+tarwf/OQpYETJkZYvfwaya/GU9
         tPuNgZtbjZV5syIs+pMSFO3q3X1XBhF918YB+/oN/DJP6/rfbDcpZEJ0tVOd9zPWTx/s
         phvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXL1AOWop998L56K9ufKuTeVA2agNgSkpxFsV2v2DGX+YqfckLEj3CkvNkhE6jOOepG0ifKmWpq0ciuQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFEXZdt1+GdvkoMdWOk8rk/7ZWaIcdTN4tvMydbOH0hHI5JY0
	PPrk/mm8wQuikAVN3eM2hQ2Y9Xu192+sh6uiKPXDQviapmhv8Ewo
X-Gm-Gg: ASbGncsnCNb5iXfE8+N3PGrOge+gY7JI3jNzX604X67TZCuKztKBbbZtBTaKDRcWFff
	yoSLDr2XjFh6qd+C7YJzA+zIIOjCxsVCOm93YYOkWlK/NeEFxO6n3RcanRw9uNT+CDjETZNjMv4
	boYDHvQxRQpPsDGuX5dWXaX8Vig60QGamXwzfq6UgnNAjpadinNFR9fbmofyjJR4jTOso5hOnv+
	0QRl9OhJJqsMwO56OC6nqF06AyqNox6KW525YsgLz9qLWcdUWTHhBPKkeF6DTkmvwLStoAgnfn5
	gXOB9uK4QxkEOqhikP4EuuJkkGY3mnX49wzdfM/UZtJ8TRI=
X-Google-Smtp-Source: AGHT+IHLX8HZZ+2Wci446kRf3mvfpCskR7WDvTO3CsK1JjrNl/z1w3XNrCzriB+PrYbZGTzvp1a7CQ==
X-Received: by 2002:a5d:5986:0:b0:391:386d:5971 with SMTP id ffacd0b85a97d-3996bb51fb8mr3191605f8f.14.1742308928282;
        Tue, 18 Mar 2025 07:42:08 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:c99:9d6f:1130:510f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbc3sm18157908f8f.88.2025.03.18.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:42:07 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:41:47 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in
 dynamic address assignment
Message-ID: <Z9mGK0x8fsWvbTvo@qasdev.system>
References: <20250317101516.19157-1-qasdev00@gmail.com>
 <Z9l3waI5EdrWmYC3@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9l3waI5EdrWmYC3@lizhi-Precision-Tower-5810>

On Tue, Mar 18, 2025 at 09:40:17AM -0400, Frank Li wrote:
> On Mon, Mar 17, 2025 at 10:15:16AM +0000, Qasim Ijaz wrote:
> > svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int
> > however it initialises it with i3c_master_get_free_addr() which
> > returns a signed int type and then attempts to check if dyn_addr is
> > less than 0. Unsigned integers cannot be less than 0, so the check
> > is essentially redundant. Furthermore i3c_master_get_free_addr()
> > could return -ENOMEM which an unsigned int cannot store.
> >
> > Fix this by capturing the return value of i3c_master_get_free_addr()
> > in a signed int ‘dyn_addr_ret’. If that value is negative, return
> > an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once
> > we know it’s valid.
> >
> > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> 
> Thank you for your patch, but similar one was already applied
> https://lore.kernel.org/linux-i3c/174225158210.1593610.10018812780731849409.b4-ty@bootlin.com/T/#m5120e1c362e7e57f4cab139a45410fde421c2f37
>

Hi Frank 
 
I sent a fix for this issue on the 9th March, which is before the patch
you linked which was sent on the 10th March.

You can view my orignal patch here:

https://lore.kernel.org/all/20250309164314.15039-1-qasdev00@gmail.com/

Thanks
Qasim
> Frank
> >  drivers/i3c/master/svc-i3c-master.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index f22fb9e75142..eea08f00d7ce 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -998,9 +998,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> >  			 * filling within a few hundred nanoseconds, which is significantly
> >  			 * faster compared to the 64 SCL clock cycles.
> >  			 */
> > -			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > -			if (dyn_addr < 0)
> > +			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > +			if (dyn_addr_ret < 0)
> >  				return -ENOSPC;
> > +			dyn_addr = dyn_addr_ret;
> >
> >  			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> >
> > --
> > 2.39.5
> >

