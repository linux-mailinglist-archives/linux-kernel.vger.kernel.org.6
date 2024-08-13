Return-Path: <linux-kernel+bounces-285115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EA95098B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E215E1F230D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA11A08A1;
	Tue, 13 Aug 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5MhdNux"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3C2AF0D;
	Tue, 13 Aug 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564524; cv=none; b=Rqpy2mtveM28VFC6KxN1TKG2NmGH/YAd2bxcrZBYNLBCd6Ew0y3WYIBMZNoJugE779e8DtRJYGvW7QZVdRHuJOUPXILdpijF1gntXTSlSQ2LZFeUxtSRlJJImORztPF7PTOeG9xc7I24R6bFB7gf0kLJU4lwIWYs1dKqwbrhSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564524; c=relaxed/simple;
	bh=KLRQ9XCMyV4+IoLC63KlpiQQx6VJgzr/PuSqrkEfaa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PB7zl3d9RcNDp17HRE+CKxNfyOqLD2AhoNUO/Z3Gtx/ZfN1lo47qWjPE0UGLe33m/fF1iDzz91Dz8IW3Ed4xEP5rHsyrpsQ4HEH6YA6dzT8kaKb8NCe1+MObg558TTx+3qRTBHRBscLsuYszaXwh1kkKzVfHFl6x9PDCIz6VgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5MhdNux; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so4378390a91.3;
        Tue, 13 Aug 2024 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564522; x=1724169322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNEc4eFJdLCTJFxQk4jRqMY314XfkiZ1DqdWjlphD8k=;
        b=l5MhdNuxjtpo7H/lPAqTAopquIHQl84xd0K+90nNb+PY9UkNGlyYRjLs5SxdMR9Qik
         mOaF/4U3i/UehLD3L328hAg0nPidd+bQW1kj1v1kQH7IqLa/3TalNPKQ+U2sXlMUcRN6
         iq7Jox0BOSvNaUYocG1z/DWP7JtguCA6PDpHytX8gSss9p4PmVzfnVQEe/Bh9kkKdyaM
         l/BNQJNzaWon3D0niWgs7lMgMhkEAtsTwn6QsLj8XSI+FaxODRiG22jVPk796GY+PKWT
         5pCimFsI1NhjCebFgE1ror20pZhJrczDeAQsbmgR/5+K7wr4xhdejwKnQv93LEUGn5Y/
         JSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564522; x=1724169322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNEc4eFJdLCTJFxQk4jRqMY314XfkiZ1DqdWjlphD8k=;
        b=UqvQ9ex70FrLahWIyHHOdQunLG4/WouzFZMmwE/aOa+cYDwpRn13RtQhzG7kWG5U0/
         kVwdBYEjX6u6+40iRagsOvL5nAdwGZ68dNIbkkrv5PiaGGZgqJ4v5/nRCvUl9hHWQxI3
         aFEGMQR5+mJhCjf6zc0KINNXzcu6gQ2vwlPg2i8VzfZpP/ADaBlLxj30vjqax25Dq3kG
         RWOz7vPNbG41G7vYEztSXMlqWnIFopggcfZEOaV2PeJBcl85nPTBPPzUGQEYvK1LrtbB
         UVWMEt9ns4DJsimSi42WeDkpLJ+nf1+zqwESaLGuvkHmXOnfMwiRaf0cfZHnja77XcMF
         T1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUTo1i2Jy1RSgJF0EINIPhEZDDQN3LOFP8N3pSfFjDI9v6HvLJBLWjLiEw/2LTmYL94aaDAzWMAlAa0LaluIrvbC8ZbB+QQ4T44y57tvJXr74pTfoPVmpYSLPfaQpy3/HjlOxKrg90NGNQ=
X-Gm-Message-State: AOJu0YxDHkINzO+lOCxJ+9SZq1dsroy8zFuyYLWMYKdU0Om4PQw3j8Wz
	v0tRenaZCWILQPqF0cTnt7RI2ZtqvZhJ7KEX3T7FMl9TJwxe7GjO
X-Google-Smtp-Source: AGHT+IHsNoLdrX0R4zp4o2c8WmRrDV2F3h2rC+DtkfhJfrI5TN9h3V521gKbzOJvd+yeGYEpdFTIyw==
X-Received: by 2002:a17:90b:3b46:b0:2cd:2f63:a447 with SMTP id 98e67ed59e1d1-2d39267dcdbmr4411975a91.36.1723564521500;
        Tue, 13 Aug 2024 08:55:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fd02102dsm7465294a91.51.2024.08.13.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:55:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Aug 2024 08:55:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Denis Pauk <pauk.denis@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, attila@fulop.one
Subject: Re: [PATCH] hwmon: (nct6775) add G15CF to ASUS WMI monitoring list
Message-ID: <3c1c6785-b994-486d-a255-8c8bd8080eb1@roeck-us.net>
References: <20240812152652.1303-1-pauk.denis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812152652.1303-1-pauk.denis@gmail.com>

On Mon, Aug 12, 2024 at 06:26:38PM +0300, Denis Pauk wrote:
> Boards G15CF has got a nct6775 chip, but by default there's no use of it
> because of resource conflict with WMI method.
> 
> This commit adds such board to the WMI monitoring list.

Please read the documentation for proper patch descriptions.
Specifically,

> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.

I'll fix that up, but please keep it in mind for future patches.

Applied,

Thanks,
Guenter

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Attila <attila@fulop.one>
> ---
>  drivers/hwmon/nct6775-platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index 9aa4dcf4a6f3..096f1daa8f2b 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
>  	"EX-B760M-V5 D4",
>  	"EX-H510M-V3",
>  	"EX-H610M-V3 D4",
> +	"G15CF",
>  	"PRIME A620M-A",
>  	"PRIME B560-PLUS",
>  	"PRIME B560-PLUS AC-HES",

