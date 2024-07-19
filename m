Return-Path: <linux-kernel+bounces-257420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2C9379A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4B11F2253B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5C1448DE;
	Fri, 19 Jul 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6qyXwMU"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FA28F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401940; cv=none; b=KWJDAliLPyIbQ8gLYPHC+sAq6Hv8ErabaCLE2duLFogJ470uU3qrCkt6JsqZ1MAlWJwMfTyY2hCuKhaaYE2ZnpDKoapqYQXOZf2XTlUB8DSVoxJLT3JG7ckkcvRzYj/74McNVEyKfaa5kLt7oUJ2mvalHKno/BZ1bCGb+QM+30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401940; c=relaxed/simple;
	bh=ly+G51FtEF4O2iybhM2EuKgqD9C5x0UKIjkARq0Jlxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCwhhvKPqX6leXPIBRmMo7JkDH+0ajL8NB68SFONhMcvKcsL5aYUsBeGdbYO/u0ZI0bPYhlSFzARXakaZgFJfB1Us/D5EvZiy/WFqQWvWSeXCnM/At2tGrEPLZnEQrT8cNbDQ/0LO+HoWEob+vBU7syF0B0W4kLK2BLPQPF2dPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x6qyXwMU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70388567d24so1024198a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721401938; x=1722006738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUKibQhbbQSDu6lJSsRxLfvTPZGluvVZnhoqB+ZHNXM=;
        b=x6qyXwMUyYMR2gAsDBP+0nUmL7Q8SGWmi5TyTdoOL2e1qIdY5TzJ6nnTB+Gw3oYjQo
         14Eu9P9m7OEUyxZpBciTn3Jb+A9siFovPCXwbtpk9twNAJe8qPRKWxk/X+QEglgtH0r+
         XWTlj6ZiOvwrir8fRxd8jD7nJ59QbjOfk5SxF0KvOLIStZbQpYlsMKdq7PrevK4bLgyh
         w+bXDADHfyF9S7fWkBNZ6KICqz2NyY2GPp84g4Nd1s4aY3fmUTvRMDqMY7oGSoss8kS+
         M90LT/0ki50/HAT1GbAtX3iseMfZZxoX+afNXhHAq70A2AoeO3pAN5F12uh+bcfdmosM
         q57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401938; x=1722006738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUKibQhbbQSDu6lJSsRxLfvTPZGluvVZnhoqB+ZHNXM=;
        b=sw5Vt58diCK251r4qvw/ign3SDhqhNvyI0Im8mW1w0HWBHEz3a8cXYsv7P4/A6PmhQ
         OekiMB8xa8DWIpxAvBuqmXKQP9y78L9SCVTZAVmVdvzghd7bj2VjmdAOSDUDQCm9yQhf
         1smiQZa15VN6C1zi5eil6CC/gUPfWixbJejSpGkEV6C0b12s8yHAUARCFDsLzj5/Flra
         K4quIbNlECTJAjAU9QCEf286hj7QQfys3CeBD1OxEkeBGYCIYdL/eoV0XIYBGhgHDuTi
         YgO1PadDAgU6R7wEpZKsXuMR1rPlhaW0HYwE5/KI20iNfjEm2sM6FZdSWDN+4BsEjzuJ
         5knw==
X-Forwarded-Encrypted: i=1; AJvYcCVztHpX+huN9FrilCCiBR8XqUZj4104uT4x8BZVh6iodCZxtaRJptM6iQy+qwHz8CH50NAKXUGHcCbaHmFmmDFqJj9T7ZSvV4PRYgF+
X-Gm-Message-State: AOJu0YwYQFAtYbZCfIRE3Dx2tUBJVKjoXSUSYr8fx7OIw+FxSqR8IAzw
	aePx9j/uNAHCHj/D4ET5kDQ1H1ntv8CiHG0Cv9j1MtD7iDeZuWptq8D/+iPyIzs=
X-Google-Smtp-Source: AGHT+IFISp/m0Hqhy/V33S8AQiM2sHc+83bt/bOYNqMFUDPqruVCPYb2fZ0K+iY+wyuavgJiTwC3MA==
X-Received: by 2002:a05:6830:6606:b0:703:5f4d:a758 with SMTP id 46e09a7af769-708e37965b3mr10070019a34.13.1721401938159;
        Fri, 19 Jul 2024 08:12:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:4528:a9e:1eaf:80c5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60cafccsm321252a34.29.2024.07.19.08.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:12:17 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:12:15 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Max Dubois <makemehappy@rocketmail.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug related with a 6.6.24 platform/x86 commit signed by you -
 Enormous memory leak
Message-ID: <9b0e7f6a-0432-46ba-bd75-7ba324934716@suswa.mountain>
References: <707784492.392759.1721383145890.ref@mail.yahoo.com>
 <707784492.392759.1721383145890@mail.yahoo.com>
 <3bd6b12c-533c-4b6d-bc91-696db8837b3e@oracle.com>
 <20240719142037-93bd4395-1f6b-490a-8a14-50e7bcc756d1@linutronix.de>
 <f055fd4d-7ee7-40b9-a394-5cc8bfe52c97@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f055fd4d-7ee7-40b9-a394-5cc8bfe52c97@suswa.mountain>

On Fri, Jul 19, 2024 at 10:01:14AM -0500, Dan Carpenter wrote:
> 
> The interesting thing about that is the working kernel had tons of these
> allocation failures as well.
> https://bugzilla.kernel.org/show_bug.cgi?id=219061
> See the attachment which called "This is a session with the last WORKING
> KERNEL 6.6.23, NO ERRORS, everything fine".

Never mind.  There are a bunch of different reboots in that file with
different kernels.

regards,
dan carpenter


