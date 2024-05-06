Return-Path: <linux-kernel+bounces-170499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193718BD81D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C89281BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670CC15CD7A;
	Mon,  6 May 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvE9z2XR"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30392140E38;
	Mon,  6 May 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037450; cv=none; b=ABF/C68TlJ7ruiocRJQcTAv0fWZru7t+Wl/omXjyswA9nRbBuo4tdSLyoKZUpLweclkdI1zcYFWKHReRdyyVnP3XbnKC5OGCWlkowoCnZpKXhTfIukVOyYc5zyVCHCQPEGI/fJY/0k1UxPQot/GOvnE8j8yD6FmD6vwLta2MuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037450; c=relaxed/simple;
	bh=4WttqUMkFb9kDygXYNu/rLcNWGwCtr0wLNb1kJY6/18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/Iqp2ExHRF9x3s0vbBLAS1LgtwW94KPwcKFDgT2iFfgF45m5jjjNhbtdwCznNPxpQiyri2UzKJwJ13ti0tAWMQPdl8b7jr2VPPboXpA8yIs+akstNeY/CNmh6RsSEvI7+0FeVQX2zVCw7OzDhiH88bfYIojvxdpSsMb4V3kQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvE9z2XR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f3d248fadso1040222fac.1;
        Mon, 06 May 2024 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715037448; x=1715642248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Hm9D7eP+XEoI8sGiNQ5EiOGQ8O/nhB4Nt2mJlJ9nVE=;
        b=SvE9z2XRCA2eu9o4znR4K8qB8cYBN6T1rt0F5oljZflqcmZrI8qaaEeKFanyWmJC2c
         Uukrzt9PbnZ+6qQMLjGow9wVzy9uokvE6CFNJrMq8Xr+YqoYMKisAV4Li0DqItE6Euhe
         xGe8RdIGwFXmpGa9H7kTV9RgA8D+kqGdLPJD6vOGKFcgR6W/wPbP0u40afuQOYns7pN8
         rkfkWeTPB96zBn/+mCXYqp48BsmWzI8AN58FkJahB5RNJq5KWNCMLL7lRva4xnIX7/26
         ezJ2Uv2XInhWm/Xrz2TX1YVv6PHZEIUe02gXuR3fda+/VGn5lmP7h5BwlPr+9r+dfDVa
         r6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037448; x=1715642248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hm9D7eP+XEoI8sGiNQ5EiOGQ8O/nhB4Nt2mJlJ9nVE=;
        b=RtRdEn9Vq/lFQ23yzMasXBbutfo+t7LgHzVo3QwqvmH+8r+Uo+Kv8j+ewkW6XF7kG7
         9CALEc3UNTuRAQJVWX9U5Ijhsi7qhqPVfTkccafv+qu/yJ2qXDfSGvuFlhFMXrqHn86D
         B2dzrh8z4qX0XOZIoN7Q3jXc+A7iH3YIcAZ+hTwoyzYhnyzzKNzRLf/yxtbmC3y/C3gc
         UFBmHLkeTy8Z0ML03aSjtAlqmiQlu8QUOO18q2/2EIiqtUksW2vtAQIT0RLIZ37SFWHo
         x8qKVjbBH7Lb0R7FPy9sVbQU+Zjc4Jfl4QMXUDcdb7n9mibVCnx1vOgh4KY+ZbPPS9gh
         Iy2A==
X-Forwarded-Encrypted: i=1; AJvYcCWG7yeoEi6xzrjJjmWnCEYVVMUl45tKBuqgMzs8zHy0v/AxT/TGN1iy6qn5ekjg5o3qWhnJ9yee3V1PYs4ogJ1uElwv2lScYafNmOCy
X-Gm-Message-State: AOJu0YxbHyoxg5g1Q66v7tU9W+8ffhk/SGsMDUvtTbef93B42osERoSG
	YB/gRA4bkvmENxhVXPeCVXZwO0apXqZJ/q0hQviNCPIaPa31nz0q/9RbsQ==
X-Google-Smtp-Source: AGHT+IEMolIF+VXIR+WyvA1rBp8yQZa+3LK9eI5QVQNP0E+dq3WcKJaY6wkjwb69f8mZhQUrgnfuxg==
X-Received: by 2002:a05:6870:310e:b0:22e:df68:ee7a with SMTP id v14-20020a056870310e00b0022edf68ee7amr12361103oaa.42.1715037448155;
        Mon, 06 May 2024 16:17:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7-20020a656087000000b005dc816b2369sm7439592pgu.28.2024.05.06.16.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 16:17:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 6 May 2024 16:17:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lars Petter Mostad <larspm@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hwmon: (emc1403) Various improvements
Message-ID: <f0a2ce94-5610-4f0b-91ae-2d16d1b80dff@roeck-us.net>
References: <20240503154324.517246-1-linux@roeck-us.net>
 <20240506144412.139300-1-lars.petter.mostad@appear.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506144412.139300-1-lars.petter.mostad@appear.net>

On Mon, May 06, 2024 at 04:44:12PM +0200, Lars Petter Mostad wrote:
> I have tested these patches on EMC1438. This has also worked well for me.
> 

Great, thanks a lot!

It would be great if you can reply to the patches with a
Tested-by: tag.

Also, could you send me a register dump of emc1438 ?
I'd like to use a real register dump for the unit test code if possible.

Thanks,
Guenter

