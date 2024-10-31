Return-Path: <linux-kernel+bounces-390262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D239B77A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB60EB26631
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C2198E92;
	Thu, 31 Oct 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGy4Z7hW"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9B197A72
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367339; cv=none; b=OH9QQL7vM6HNPake3b/jIRjZgMnrbj73pgELzS/CpdeKa7H2gVwB9v8X0qu2WuAVviNL14wAlLAbVTD4Ohccj17NQWVVtuUzsHiTmD0z6V7CNS/+GAVVglnspmy4wTdMkyfa9FT7N45OGSdH6zFtfn2VuVVCNBftgmxNUGWQ6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367339; c=relaxed/simple;
	bh=NpzT3JWDffonMgDLHFUTtvaGe33OX2pz/Vl1gjN1qOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2M0GCSyxOZE94y5tzMl/TzLE9RkgwgAjDOBE+oZDdxrpDdY+V8gL2tVPcRBkDB/dvDya7MmZ9bUodunu4cgfWCeI2TlZB3IRRdZpvXFpBXasPNuCg98wy+oe7BtBD+4IqYPl/n70AOHTjWmn0312y4o5DGNtohu7VYjpCHyVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oGy4Z7hW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so6472281fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730367335; x=1730972135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhgiGZoPJM0Lh+sWMByCi6m5AEirWnOhOBuCUCkrPgA=;
        b=oGy4Z7hWEcJ58VTN4+lFFLaMyC9qBblmq8DVMTHv/cgAc1GvtB4qyHNLNFWqXqzael
         YYK7TtoCxipFqCKG7FweFzTYBfnvstXvAUrhj6BvScEd43uHK/0OE4zim5p4BbUwLaY2
         e38/L/J0y6XM9JG+d7BgAhwlh1vTFlWnHtDrJP58YQg66OWS7BjbcPEFvzVeiSQHEHeH
         4r+aJBP4z1bmoR2ifogKi+GEulMjgw63CcPeUXp3bz9NUIzEHb17WxVjJLlbwdzkAscm
         RRz/DwrXg+Jb8tIKfOmWdOQZV/B30mGu7jmInUiv7RFVKzfW3nyExfihOXh8k31JMf1W
         Ozxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367335; x=1730972135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhgiGZoPJM0Lh+sWMByCi6m5AEirWnOhOBuCUCkrPgA=;
        b=W2yzZHBrNiIs7iOq46ZgyqtZhMaUQTxZ9cJLAxfkEp9U/1cr/egy293mGohf9EE6dp
         ClZHLpNlSUnfrNIN8Hamew9CoapZpBED4fMJUI7uigzODpayFWqVU5iqwNsHzniYbwTG
         H6eJvTPR5OAf7dp96mJuFUvtuMwAusPgx7I60RAtt/ul6HrKPl8J8nFvRZgnxirTowP9
         IazaY9h8rGU8PTDRKazrVpPylOQtHKFXWJt5hlgsqtCmUQn7u9c0wYK5L0gk4JHMTFrC
         5OuHrVIxVzmrUstwK3D6uspUhGRpcAFIR27DZDoGGmfDN91kECJcdkLtoSITVCyhvO4z
         QEUA==
X-Forwarded-Encrypted: i=1; AJvYcCVxLovum8FX49gONOJBngCB4SAe8uLRSt7opqxBMX1Uw2WmbPDX2EHan/btYnr99woOdbelDOHZcNmUj+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFuJhSlmjtBrMDP6ytm/h583nrRlrxuvVSx2cO8weg2WrUluA
	VmdzC2CfAj6y3DcOyiqqTbWg4AfKZux31O2DWKg22xmaRnVFnO5vsjk7H8W5Yuk=
X-Google-Smtp-Source: AGHT+IH0+JNp1lLF5VxJcufxgytij8dV/52O1hFK1UvQFy7QXqhMzwjcLwROl7GrDUg1tS78lPM41w==
X-Received: by 2002:a2e:9fca:0:b0:2fb:55b2:b199 with SMTP id 38308e7fff4ca-2fcbe0776demr65130691fa.37.1730367335063;
        Thu, 31 Oct 2024 02:35:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abf3sm1539406f8f.101.2024.10.31.02.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:35:34 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:35:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: Fix use after free in debug printk
Message-ID: <8bad985d-4655-45d2-b448-2b3377a8438c@stanley.mountain>
References: <7d0481da-5852-4566-9adb-3a8bb74cb159@stanley.mountain>
 <ZyNI3rQw6q4pkqpD@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyNI3rQw6q4pkqpD@hovoldconsulting.com>

On Thu, Oct 31, 2024 at 10:07:42AM +0100, Johan Hovold wrote:
> On Thu, Oct 31, 2024 at 09:59:10AM +0300, Dan Carpenter wrote:
> > The dev_dbg() call dereferences "urb" but it was already freed on the
> > previous line.  Move the debug output earlier in the function.
> 
> Thanks for catching this, but please use a temporary variable for the
> struct device pointer instead of changing the flow.
> 

Why?  The output is the same either way and this way is cleaner code.

> Also make sure to include the driver name in the patch summary prefix
> (i.e. "USB: serial: io_edgeport: ..."):

Sure.

regards,
dan carpenter


