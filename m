Return-Path: <linux-kernel+bounces-536659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F8A482B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687C91889C05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E726A1C7;
	Thu, 27 Feb 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="XXUlFRJo"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB026A1AC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669142; cv=none; b=QrD16WAEkFSBUMRx1iDvCj85A31IrBqiPF0nzdYemXQD+9EOYG+I9o3uEw6KSBQ5y3yLviJB6YxRcADwuWXW5lP2Z4sasGAF6lqJfzP57/az1XZ0ZgsN577cVtqPC5o5ww8BUN1Qv+TLm421oR4vDATUPnUq+rncxMJdDHkxnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669142; c=relaxed/simple;
	bh=biSojK3aYrH5alpEFwNMM02JPcIaJeMqtWJC7TMKk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz5+N5Dk0zmoyIldV/R9mCmywetHazsNRXIpIgKmjHtkv/PWtRD4Ewu66VYj+rV4xm/HZxEge5aJWWTnamyy2niM8b1Vhx/4sDqjSGvbENRqxQMuTM7H0irfDE6Bsw4iHU7dedobu6ffghwLKV4YCYWr+wbnNzYuoYCFsOUERAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=XXUlFRJo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4721325e3b5so7939141cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740669139; x=1741273939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNx8YZQIjNLm0mZInU+TMEOrRGJoGKSTKhShcPs50Ok=;
        b=XXUlFRJoW4wPfZjg4H8o/bL1jqKGTsvAQDXVcpbrlaItWHmXnPWFTqZTFxFjRzz0Ih
         D//Q3WhQV9YpUiT/tPuD0pgcK0b0HkQVaf/LcQFWYVy8Ir+ru0QjL/y04FTgXMmeGs/t
         LCESLlrl9zCZYwhyZveCY9ojGPNKloFFTaH7j86/2pfpRwgoZmGnV00QDNg14XeEZZnY
         mC3it7/dD7NCFBM3Kae4RVxNJA2xRl7EEiGOTWP2bJGsLhRN+TESQAul5PqCuyBUBNO+
         dQVcOpNmtKMwODMO4sK+5VWWymcGamp9SVW0W2XB4WlWPJWQgxwNyv7ED2jHotrvikI8
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669139; x=1741273939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNx8YZQIjNLm0mZInU+TMEOrRGJoGKSTKhShcPs50Ok=;
        b=WQRb1sc7Pml0HeG89dRgB43e+7qWeLn+i/AEerizpyZPlGYljgUeXXYidk+DSEszGI
         KxhjzPeMKquMW0hYuWTlPRNB22KLdc7ai6kOnjGW3wnc/deApMBXpFoL7uAgONV2VvOS
         fg5BrqTCTwa1n9P2wetUuZoK+xa0dXUcbbDx3/2TJlvpgg5bvB5bZn+fiyzik44kTDaz
         8zTJ+2G+mO6iKbb7lbXeWImWsdjimJBpiwSS7o98mBcPHZe8DbTEFE7Pn7cGEUaPAony
         WKSs+6fQvvOIjkBhJHAeX8LAn1O+B5amwkb1IMK+7RAoTDJBiRU6afnkStGZ8xdfTpkt
         aGhg==
X-Forwarded-Encrypted: i=1; AJvYcCUawFewMAxaONB2SX7piHPHcypOmW8Z6w/6oP7H7+F03EfiAQ92cU2qAW2Z7QyWPDAelg6sQ2i1Bh1vwy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvi/7zm+INiTb6UQ8zXnqyqP1SCmSSdt9GXWcxiBZWaoqfR6wP
	/nTpbMgcYO6Fff7eg5389leFHBp+YK//t1g04pKUE/L/a2T7X3ApWTjnjPZBdA==
X-Gm-Gg: ASbGncviJZVNHERE0/xEew1l5RcNXspq9F7Uf/fckMMZxjcQ1l/SRHh+BeChouVs3NC
	DPCdyrV+z+BcckjUyWwn06sBKIzT6ccQaDC9UFEDhYg7wo9wsvObGS+XmNGr+YiwK+VFfmpt/xc
	ucXWcxrFDqFobgKXwETlBgklV4bmBNf5VvWlpdSvgnaZZJ6tZb9kdJOckxmuX5BH6+tzBYbgBCn
	lcmHhLHvvB0AbGcTpn+Y8o1jz9ImFZ6DlTARSesv8TIrugSZE1RSniIpsWbTx0fdOT72FC3I9/g
	XNNgnYRk+g25g2+fP9OM9FzICZE4qc0sVypDx0EFzyM8
X-Google-Smtp-Source: AGHT+IFpyrujk1OpBqdflL1MiDLfKUylvOBhU5A06YFvWgA27FYmaDjkhww5yqqypilPXGwM0RZvjQ==
X-Received: by 2002:ac8:598f:0:b0:471:f272:9861 with SMTP id d75a77b69052e-4737725c45emr159740651cf.33.1740669139443;
        Thu, 27 Feb 2025 07:12:19 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5ee0f4sm11952951cf.30.2025.02.27.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:12:19 -0800 (PST)
Date: Thu, 27 Feb 2025 10:12:16 -0500
From: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: xhci: lack of clearing xHC resources
Message-ID: <6034ee47-7f95-4917-b4c5-fa9ab6078f73@rowland.harvard.edu>
References: <20250226071646.4034220-1-pawell@cadence.com>
 <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
 <a78164bc-67c4-4f31-bbe1-609e19134ddf@rowland.harvard.edu>
 <PH7PR07MB9538F28D5F4F6706363CC78EDDCD2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538F28D5F4F6706363CC78EDDCD2@PH7PR07MB9538.namprd07.prod.outlook.com>

BTW, since the patch doesn't touch the xHCI driver, the Subject: 
shouldn't say "usb: xhci: ...".  It would be better to put "usb: hub: 
..."

On Thu, Feb 27, 2025 at 07:05:17AM +0000, Pawel Laszczak wrote:
> >Doing it this way, you will call hcd->driver->reset_device() multiple times for the
> >same device: once for the hub(s) above the device and then once for the device
> >itself.  But since this isn't a hot path, maybe that doesn't matter.
> 
> Yes, it true but the function xhci_discover_or_reset_device which is associated with
> hcd->driver->reset_device() include the checking whether device is in SLOT_STATE_DISABLED.
> It allows to detect whether device has been already reset and do not repeat the
> reset procedure.

Okay.  Please resubmit the patch with the changes we discussed (and fix 
the kerneldoc problem pointed out by the kernel build checker).

Alan Stern

