Return-Path: <linux-kernel+bounces-416141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D579D40C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7991F233AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42C156230;
	Wed, 20 Nov 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrxgaPWI"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C7155330
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122255; cv=none; b=AUWDEMlYYeogoQDVoMr10wN/Cbku1GZjuFp90PBb0K4+72ywLDvVN2/KZJGir9nYEBErZeFL+uOvh4WK07aqFddGFXq0hHaIkVxLRp0ad88ugPpMo/XSB34wB0E5+fowh3EFndl/xDDjdVOIstgA/At53hpSl5YXEpivo1OMPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122255; c=relaxed/simple;
	bh=2UvVAtc/uLS9k8h6KdYK775dOKGJMjM75TfPH4ylbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWcZxs35RBUsjD3JVGt5KJ3CQb9T5NCLl4zG/8vuhsG2uEnUiGcxkX568sWZs9h3NQk/k9CVneCUC2h41ZUBj09s9KFFja2WhGBF+9Y31YwxqLBU9Azc8DfrQn+W/Xm72hysFusi/Lh8yAmrlSVLpHzQR27FPqLQZCBauCs2ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrxgaPWI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38230ed9baeso3700894f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732122251; x=1732727051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1f2X60ZGZWbIG/u+FbTLhY1O8lOEuX5gB3Pdf3Y5Gk=;
        b=BrxgaPWISiMLnrqdCK6mmVRdk0KBxC+30udVsYAhzULPHhiGmzsnSC6O/N7J8vMadd
         9PNFata/WnxhvpUjt7Cj47yVAO150U/d/sH1q1/ZEitcJU0VlHJQahoqhx4BFnDhB527
         Q6hpvCEwKHcKCOx1VtRGEjZPbNTXCJz55aruiYIYJ1+VizhWunbLRO1GuyTHZsrktu12
         r4xUmXSG1RumVnRQ9aaTgAcke9sNOhcyu1MhVMRbOr4uIbdwwhAPkXFhFg5ngly9G8p2
         BhreNf8IFowLsZs36AUv5Uo7s2ICF56VIs8VeAQuK1MDH0PpMDxWD+C8zbjQcoSPgNjP
         iXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122251; x=1732727051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1f2X60ZGZWbIG/u+FbTLhY1O8lOEuX5gB3Pdf3Y5Gk=;
        b=F1q4aqksKQqDLynNkw9pwB42kpCtksgL0wuzEBpuTtf7s0NJ9voObmqwHftVNdyNhn
         TYMeasAPRn/bSM05qk9XjTgDEbfnuTx6EzcTIUa88IF8KCCcKlqIQ2BHxhylIh5M3jhT
         9gdaoIvDlqLmQQoHghrWhvzfcNY6Wal6C8CFFKe2g+ZrGPqjBxSOQ/83+akx44j86qvR
         0nXgsUDpLHQU9kI9KEnmMIRG73gyuBkS9wqlzhRuSE4nKgjftbxor8sfb4bX+ujaOmLJ
         vqAcsXfzLX7RcN29QpdG4Gn822Npbt2sG2F1zEWq0xypO8/syX9I37cEczJvGGbJ/msS
         urUA==
X-Forwarded-Encrypted: i=1; AJvYcCXFMeUQj7oHCh6d9nJ4rQVsthZjltVpEFbZKzcJuRwTXObIeAcNursSRjs2JS94VIJ6WTKjA2leNuGII30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OWTp+TsWF+ERBOEI+1OzuXnGrVuclB+oX2h2He8SiwLcsYoe
	f3qNExTaN7YMZgFyT4frv1dlwHpUDXJ1IFt1m3YLuubmiI4PzDu5wbVcwB7TnZA=
X-Google-Smtp-Source: AGHT+IGLki7Eyzyn3VgPcW31cIDh05nCl81yRDZJNH1FCUDvtx1fvtj7JpUGqQMpryfZCBsaphK1eg==
X-Received: by 2002:a5d:6d8c:0:b0:382:49ad:54df with SMTP id ffacd0b85a97d-38254adee4amr2828612f8f.2.1732122251151;
        Wed, 20 Nov 2024 09:04:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493eb92sm2514070f8f.95.2024.11.20.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:04:10 -0800 (PST)
Date: Wed, 20 Nov 2024 20:04:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Perego <pperego@suse.de>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Bakker <kees@ijzerbout.nl>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging:gpib: Fix a dereference before null check issue
Message-ID: <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
References: <20241120144653.377795-1-pperego@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120144653.377795-1-pperego@suse.de>

On Wed, Nov 20, 2024 at 03:46:53PM +0100, Paolo Perego wrote:
> This commit fixes a dereference before null check issue discovered by
> Coverity (CID 1601566).
> 
> The check ad line 1450 suggests that a_priv can be NULL, however it has
> been derefenced before, in the interface_to_usbdev() call.
> 
> Signed-off-by: Paolo Perego <pperego@suse.de>
> ---

You need a Fixes tag.  But I'm pretty sure the correct fix is to remove the NULL
check.

regards,
dan carpenter


