Return-Path: <linux-kernel+bounces-327293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30154977390
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFA22826F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C8A1C233B;
	Thu, 12 Sep 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe1jx/jV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BC273FC;
	Thu, 12 Sep 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176474; cv=none; b=sX1aFaHfwJtXHJgdHvFYWkNO4gbBvN+Uw2vjeSZBCeIsmi+N6jCESs3A8Mf5ePfZwMJCRLea+QW/Gh6x2XjvAtSmbAZMemx4XS22aHhb872/DmsfIXqfzMygIMGI1LakT9G0yLr5VwKooLN7IQZzWSMNbl/AAC6DOVaLYpha8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176474; c=relaxed/simple;
	bh=w/YgIPhQR9ivOQ+vklFgfxUKH+pnzE7kpK6RShDkoxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8xWqahoa74NWVlq6ovhvThEha419AW3bJPPCMQlIFAfFHZfWRISNCeJDUBHNhJpWr6pjK6wLWCTK209tUcZeYADS3MV4Isxdd4Hyy9pYibCu0iCoOLd3Km/k8yY9eeTVvX9JASxRa2kT2tlJ7Lqw10y2NoF/A5DLH276qvU3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe1jx/jV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206b9455460so12097345ad.0;
        Thu, 12 Sep 2024 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726176472; x=1726781272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shUfZxXMDRpMKCAQP+MW5jtasId7ndgHn/WYAvIFVIU=;
        b=Qe1jx/jV9UO9JGFoZP7cGqufV2TnQgHYaTrojcKZU2pHbXBPMoAehnUPYxdAsxJnZM
         xmd2z5dYa0N3kbbjIBw0Q5JtowkJrq9M3aercnfxezJqk4zjIacDAMizePeO4ABbdii3
         +zuGYF5deMg3SA7/K9rgB2DH+KfF4j/qZJ1zddASmuAEdm9FBLv3z3Mw123g47qunQxG
         5rwCzHyAZFr+akj/zKM0FFkn990suNcmAxD1uPL4AUc0brMXsdI7vUZOIJ2kmYQYZV/b
         ajRw7AlfhHOBpEHP3BvXP2ZbGiC5gtGMPTHm9uwBAau4V0RnNUwuaYCjfsJ2zauaQYtP
         7cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726176472; x=1726781272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shUfZxXMDRpMKCAQP+MW5jtasId7ndgHn/WYAvIFVIU=;
        b=nWVq/IY+PN5YayywG4NkIpHI/OjJBCMNBzKNDuFf3+8HjbuBP1tbceW8KcXry/FKDc
         e4V244ylszicceL8DVgOpCJMnNQRfxOieRhgmm+wLmRBRReXjJQEK3sfW8x5Cwvu3W+E
         16+H1UO3HQxW+RKFRO+iWyltV0VPdGKCF0veGodtz2w/ttvdGMO0+DFY55WXs23hkQgz
         6g0A3s+Ed13QUpdVn8/aTdTQTfmnMKMf/+mjC4wAweTK8uJ66SGbgLqJumnPBAvuoA45
         vnRV4GvKkxH39Cf9mH5iSFM8pNnvan4mRrqwdC2q+jTojBG+1/CHA7DTJx/b5G0fJrhO
         ovdw==
X-Forwarded-Encrypted: i=1; AJvYcCWChW/lt0tnb8XlpiXOZYJfuQRbfS58DGG6MH4JFWlkD3aV9ALv+BnPzXhhYTj2rlOxV/ycMLUMKZOi294=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr2r8rfDefx4OSNJ0JeNbu/NWz80a49tpe6cqGFxP1SrBEjlV
	r0WsU+GBDAFmn4TaSWhyMPUVlXTbXM5PP5b8JboVYnGMS4iF0ddQ
X-Google-Smtp-Source: AGHT+IGQqkCyfA9xv/r1rKq53mBs1DRUR6bsYBfle2gcyQyqpcuDzxUUzRl1iGnrHIV+DcqpdU9WCw==
X-Received: by 2002:a17:902:d50b:b0:205:5d71:561e with SMTP id d9443c01a7336-2076e61e061mr59199795ad.26.1726176472195;
        Thu, 12 Sep 2024 14:27:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b009724sm18106835ad.251.2024.09.12.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:27:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Sep 2024 14:27:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (sch5636) Print unknown ID in error string
 via %*pE
Message-ID: <ac9698f5-6ff6-479e-8c13-00e8786ac44b@roeck-us.net>
References: <20240911201903.2886874-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201903.2886874-1-andriy.shevchenko@linux.intel.com>

On Wed, Sep 11, 2024 at 11:19:03PM +0300, Andy Shevchenko wrote:
> Instead of custom approach this allows to print escaped strings
> via %*pE extension. With this the unknown ID will be printed
> as a string. Nonetheless, leave hex values to be printed as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

