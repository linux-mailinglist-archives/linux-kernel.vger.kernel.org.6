Return-Path: <linux-kernel+bounces-224951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA3912908
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEB71C22CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7F55E73;
	Fri, 21 Jun 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Ql9WIT"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E538FA0;
	Fri, 21 Jun 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982588; cv=none; b=hkEGo923keri94dIZ5xR/xL4J/33bQMIAqzZby9S37XQd9cE4A7kvK0lsr/L1yAtwywSxsbkwSkq1j6G1lwlqgjtv/mgyXSm7X+/TX8TsIHI+g6qnSPTzyH7AQhbZng6GOwGa7hFBQ1mJfW7b3pwQdTf/jX/9QFXc/K4YxiHql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982588; c=relaxed/simple;
	bh=0VMF9n+QtL3+3e8cyhyYJCm5O5ipnpmBnXL6xMoEx0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWsRnSXlmybtmu9Ia9uBqH+CRsetv9HjG5DWOa8iMaHWrpF+O88ynLP+tD9HfStgwPvzFVEvPXd8hT3pUW3qNWY1RAgOhOMPhoVWM60wpQ3tC3guFOFS5OxqmrscrUf/QdURdh0TN7JJO7w3jO4oj8xzsZErioxjjpga9+d355Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0Ql9WIT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8065e1666so1193026a91.2;
        Fri, 21 Jun 2024 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718982587; x=1719587387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD78Ry4oM+SZFSOpnK1UvmdpLaurNsJCZMHc+5y/b/o=;
        b=e0Ql9WIT7LsOb1TJz5hcwUFi0CXcZPDab0PIvSxZrfcKbO8Hp8LWRhg2sOPTI3PNNI
         acdQ8Pqz7Krtbq1jeA6BKKaYUal+eDEMrplgiS/VGlt1qPFDl9YJRQ9G8l+n0gNbLY8B
         UY7OUFbCOyU0vVojDhSr8Wxl8ufg4rQoxHWbJ93nikdn48dDdA/v2EXgTwT6TZ7YwYwo
         k18riC46NT73qL7HqNN5ZFI5odw/PL5uqtOn/mh4V00MquODYtIwk9JWknxYOBSl0+yt
         kQIz5/Qu+9YfOVFPp2BS9IdwtSrCtbsFK98D0gfPc9BZXl5cAplCsNbCQDo+XetoV/3S
         uxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982587; x=1719587387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD78Ry4oM+SZFSOpnK1UvmdpLaurNsJCZMHc+5y/b/o=;
        b=U/2Gx9la3/pi08xC1yug/x1wQDJuUKM4zL/kNcJROdkarBBWbjZbPCfZ3UCeDwfZ3P
         9Y37w78+ph6BVIbwavylfLo5hUQp9wObxxRmdaCI8qUYqjJPgUUqYjX23LG2tesfjznG
         5jsAGP4XVofmMpnpguvMpUYVFs6OsanX1w4UkMB7ZeAsJyQMxIiVBjr76mohKTw8LQen
         9XHSnzVwm0HDfKtQbYN7s4lh3Hz3JZJPGpLdPiM2r1/VmrK2/2DP8EH+FqgZ4zjYVnj9
         J4caSkwtl7VdOP4ZaXKgkaNk+isFe4xg8ZLUGx2ymcF7X4dTPCxr3IM2VFiWN03EFaNL
         ZOyw==
X-Forwarded-Encrypted: i=1; AJvYcCWcvaHx0M27DAjnnmJ0nd/r1YRiukgduG4WGHdHuIRjyyBjoZ4rMQhqr1EiV+8qsI1WJbmcx2pFJKVHSV40N1RcVzr9YVzGcKdVSD3jiGzwRBDDW4aOqkncC7wWeC1HBbFu0sCopFvg26M=
X-Gm-Message-State: AOJu0YzC540s5igY39Y0a2jt8sGyF9I/n9A8rnYHza43vyzO2ztgorqN
	iQOYuTkDEslg0qyLBExsXZVewCspXQbFHsfcPot3QoqrWGlKjoNY
X-Google-Smtp-Source: AGHT+IF8UKWJTRpcmvflOOzP+qhIAdQw5fFI4pueBDFbxMdSZx8+AH1CJi64a8/TxSHjJjtzoOaH/g==
X-Received: by 2002:a17:90a:ec09:b0:2c7:a8b6:1bdb with SMTP id 98e67ed59e1d1-2c7b5cc9e2emr7976646a91.24.1718982586647;
        Fri, 21 Jun 2024 08:09:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55dcc7fsm3717649a91.29.2024.06.21.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:09:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Jun 2024 08:09:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: iio: Use iio_read_channel_processed_scale for
 IIO_POWER
Message-ID: <cba10629-b24d-4252-a358-1816d9063600@roeck-us.net>
References: <20240620212005.821805-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620212005.821805-1-sean.anderson@linux.dev>

On Thu, Jun 20, 2024 at 05:20:05PM -0400, Sean Anderson wrote:
> Instead of rescaling power channels after the fact, use the dedicated
> scaling API. This should reduce any inaccuracies resulting from the
> scaling.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Applied.

Thanks,
Guenter

