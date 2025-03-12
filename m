Return-Path: <linux-kernel+bounces-558364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D97A5E4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1318189F19A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83A1F0E4A;
	Wed, 12 Mar 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw2NHxdR"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F41DDC3F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809251; cv=none; b=r+2oTHyFrvQ2Uw6632+DmE5JgOWzKr1qMGmOTZ/ewB7/U6Q+rK/xehBuk2SV+5Y//GYLmAv6ku5GlMwDTGIvGtQo95wIRZnf1YYMrPBrkrm4l2wfDrKf1oyXrmKz8xbDFXUBrVRdmou9Te2kPysN6CsceHmVxQf80/hrYAcdPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809251; c=relaxed/simple;
	bh=5vZP7CpJcceQEyeDzE28W+oXvxlBBvt4aIcN9qWy604=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF2mRp2YFaBix1BS2KiXbjJx7xP91BLexq7gDJeD9Qwv8Ben4DR/nAcT+fV6ZYxZI4+qzGvZZuM/W18zuPxo3n1nG0uYyGLaZltICR09X+yAQDLR4+LVacvBVf1JVjs7963bC32tF5HUjBuSVleZVkEGJz9NmsisOv388cG4nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw2NHxdR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so248219e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741809244; x=1742414044; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiZMorRI2puhN1dptiZYy2TXMfV6sCyUspmPm9Ypzjo=;
        b=Lw2NHxdRaFEZu8d9CcDibq2uMY/C2+JHisDzIecfEfVEzVB+5ppAnfq62bzu86smtY
         lxQUZbrVRm2QzHhylkWXg+zfCzBu5gBmuv9jeG1aIBo/1BSJUuCIbXtYaYui+VxNSo5X
         4r9ikey9vqZWnAlVhOIPkL/nhBOvax0nFWBJ6gS92hr7pps/TyPOL5Gz+6ZqT5WXoQjk
         42AA0DG+4kK+YKlcvhOpQbxEKxhw+E0cdXIqvqv0P9R/q11G53KFHfBfuwSuVtxPEkBi
         26FBwz4ajDyLCgwy3JvtNgdzUGAdYYGCwC8MkjYsje6UtqNYQHYPVEHbSbsO+otvDAJN
         IhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809244; x=1742414044;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiZMorRI2puhN1dptiZYy2TXMfV6sCyUspmPm9Ypzjo=;
        b=e2K9/2xnKO/rYh44MiP5/KK0SWtkmWDZiBE458yozY7StyhkcUWCUgYtFtDAgLZnBK
         wnoLccTWXloriXgGHgHIRECaQvqRk0K8lWt7SnSfoXaIYeY+TTVCrFZ0dUVx7kQ+aHIm
         b1EesCd6BPZ6bBk/veT8tfqGwtpPsIJoKkmcljPTliJBIOoMG+g0hE2PrAbcPiM9S4TB
         3MitBKOZaHV+Za71/YndznBptWE9IPFRNTneuJj5x1fnAe7mlZzanO+o5SfMyqOqmPCg
         pQSo4R1kz6yTug8fKcG9ZQivYPKRh+I726UT2zXVue2ITeLcughXowvx8SB3T8zAxyuT
         I3Zg==
X-Gm-Message-State: AOJu0YziJYZJtehYsp5kgXqZO35VDGRWGLeJ09DLXQI5KDnVqPd/5W7w
	ay0AVFnKPBhI02mjCE3w5AUcFF8RXKEqMQdVREPt0TpEdKu73Qfn
X-Gm-Gg: ASbGncuEBRTdhU3p0NSIwcFsya6O7w5lRTnyDyy8CbWeqUVz++4G9/cM5SbaeN6x3Vx
	jrrOMvYLxyQ0nWjdJoJ+qqRnl7qBA+5biYI+LdtDKPNoPx9wysr53k+SmnQFGmOVnjgZjKW9cFX
	KDM7bP9wd4aOm8H/LC8HHtWjE58KfLz9RBIV/UrZOeqgmZJpCbrKkjQgbmadkGt28uLw/Fix3vP
	iywnnLs0Ij0g/a5xJIRJFHqz9zTLdxSM9wKK7QknyuIXzNeDfV8cl76EzfBlo/8o+yp2dA7JC2B
	CyV81xPE6z7SHq8hI0vAwxJD1m9uFhixate/zirsk83ZVxY=
X-Google-Smtp-Source: AGHT+IGzDL/vpqjy3KDVM4+o1qR0C1796dIKI2z6DirpvC0rP7wpmsbqrsmz3Q9ycwNc/t3Wz4O6qA==
X-Received: by 2002:a05:6512:3a88:b0:549:5769:6ae3 with SMTP id 2adb3069b0e04-549abaad1e4mr3397039e87.6.1741809243976;
        Wed, 12 Mar 2025 12:54:03 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1b6483sm2235711e87.135.2025.03.12.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:54:03 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 381BE5A0044; Wed, 12 Mar 2025 22:54:03 +0300 (MSK)
Date: Wed, 12 Mar 2025 22:54:03 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Respect buffer size in get_modalias
Message-ID: <Z9HmWxbTulCfBJfL@grain>
References: <Z7eWSCCqp_HP3iSh@grain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eWSCCqp_HP3iSh@grain>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Feb 20, 2025 at 11:53:28PM +0300, Cyrill Gorcunov wrote:
> When we collect data from DMI data the result is accumulated either
> in a page buffer from sysfs entry or from uevent environment buffer.
> Both are big enough (4K and 2K) and it is hard to imagine that we
> overflow 4K page with the data, still the situation is different for
> uevent buffer where buffer may be already filled with data and we
> possibly may overflow it.
> 
> Thus lets respect buffer size given by a caller and never write
> data unconditionally.
> 
> CC: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Ping?

