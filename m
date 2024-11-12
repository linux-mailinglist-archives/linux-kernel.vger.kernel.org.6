Return-Path: <linux-kernel+bounces-405066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82129C4C94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2451F2171E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3633204930;
	Tue, 12 Nov 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+9CnN9g"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75904C91;
	Tue, 12 Nov 2024 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378521; cv=none; b=ghWUnyAgMKEL2eqekDPBNTG/fFPLppeeuFpwSYtzpRiJ7lwHbLulk7dTTiJQh+OPmb7ok9p6aAYIv9VfSEDeKk/gIybZhcSsLsfT2SgouHgWqeKCCprOU/vpFmchtHtd50FRQGp7eaFcgN5Yo4ZpCqiujO5FyeS5pE2X1L7MOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378521; c=relaxed/simple;
	bh=Ggmo9WRktZUG72auD+myLd8qdmalUQoLFuvjx/3plH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGGGohMv6DwT6sJ/ZoelKgmAd7zQR6XtCAf2YXNDwKa/SJsVt5FQ/Gj00EEOh34cWFKvC24NJ/sdnlffDh2mqu4HffZdi17tMKWJdWscyDs58VYKcgR51MaficIy/hg1Cp/uAZkFCKWsSxzOa745rCGN7bqZ5w3siehK32AWnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+9CnN9g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2114214c63eso42938255ad.3;
        Mon, 11 Nov 2024 18:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731378519; x=1731983319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJpf/vgoUNNJlHC3zs4C5JJSrlxepQDdd1yn1DyhgVI=;
        b=c+9CnN9g6Nye/kuN894UACvOkvTQYonSS7XUHh1NP7i6xaUqgtNMcjnNORnV7QK7kQ
         QTSSkLcGEXVM92GKbVOhEp/tI4S8Lp1dBj3qRe+fGc5tb31aE8amEBbtQPqY2pXd28/H
         5nkTGLmvmy/py/bL4anppxVu5f7om4WhIZDaE0T9aR4Kn75ZZ5jMM7lvRekI9WgYA1DY
         I+juALl4L3WMxb1o+2Bsf4yXWXWoICO4bteU2i8OmJ6Zf+80CBqfIBAOxaPJrXPBHi8+
         NsK39iLhIZklq/Nvm4TdLW4L9nvf8QJ8dVDkTb6OeY+3IDpGvmg4o0c4pgWemKzdlBRR
         /Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731378519; x=1731983319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJpf/vgoUNNJlHC3zs4C5JJSrlxepQDdd1yn1DyhgVI=;
        b=A2qWbH4KW+fsiYs3wLVzsLmcQiPHQBuUlX8hgmFL9amrkL7t2uf/X/KV228Z04gckG
         OrpwiUohLAbvnjzpKdrxBnhBwo61aRKMPFXK1wqmoIrzYN9nlT+pNGPAg9/uVghtDoc2
         qfO0fFxieI1jjUfagcsH5V/mtbA4hSBXoKtkJNmFObVKBqaI+pYnPNGfPRoaGWOilkSC
         U1QFg/PqBsdO//iwYzeDA82EbTujFTUy0HzDd/ioLlzBu8NNMGhN57NL5pc5pjstwLIi
         WSkdn15ZFYBXM8+tNJd//zgNz9n+u5Pb7TfCL5RugsImHgD9JawBVMBPLhYd5Eg+FTMd
         RDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO72SdrOSfUEcomzp2vnIL8K6I+AKpMTzmYHh3ITiaT4URA7D4oiJVcDzdlVzQsJCnwJXPubY7HiC0fQ==@vger.kernel.org, AJvYcCW5g788vM33uUEInHGdU2DipLIoAqbah0N498YwA0KYq93A0NpzutEsWdeGH0sCUIXb+QzRZSz7sqFHzyxt@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXtNZWA437i/kcisA5XJSQpnIyH9vB94VnwmEe7gw3E6RzPNy
	K5Q/Wm0eel+aPZrXSJasIgLV31dKRGtYFQv+qkcPVSQbP8xN71Ej
X-Google-Smtp-Source: AGHT+IGYbjmsCrqh+gBkaxrSk83UAyOYhs5+9YIp9hmSkfLJsX+BaO9u4uIo+woUsWa3HAl3z/UVwg==
X-Received: by 2002:a17:902:d4c5:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-2118353968emr229124495ad.28.1731378518677;
        Mon, 11 Nov 2024 18:28:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e87544sm80772115ad.283.2024.11.11.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 18:28:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 Nov 2024 18:28:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Subject: Re: [PATCH] hwmon: (nct6775-core) Fix overflows seen when writing
 limit attributes
Message-ID: <60eb849f-29d5-4bfa-9cb3-3a3add653ab5@roeck-us.net>
References: <7d5084cea33f7c0fd0578c59adfff71f93de94d9.1731375425.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5084cea33f7c0fd0578c59adfff71f93de94d9.1731375425.git.xiaopei01@kylinos.cn>

On Tue, Nov 12, 2024 at 09:39:51AM +0800, Pei Xiao wrote:
> DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
> number such as 18446744073709551615 is provided by the user.
> Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Fixes: c3963bc0a0cf ("hwmon: (nct6775) Split core and platform driver")

Applied.

Thanks,
Guenter

