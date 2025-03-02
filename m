Return-Path: <linux-kernel+bounces-540652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126F6A4B357
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC144166A40
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E031EF397;
	Sun,  2 Mar 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efzTdWvg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A51EC009;
	Sun,  2 Mar 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933143; cv=none; b=L0hgfLMkWtu8SvlaystDLkGbOTvCYsFV7lT3osdlPztx791SjFQPquiAFKzhMdi40PHQk5mmnrmrNaUOHc0uwUs769sZuHb0Vbj5uos41hOg5cBLz+10AqQIoKy0GFcbS1Jrjsl4iLXqnvGAirPGc8ENakPR3SVMS74w6CZAlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933143; c=relaxed/simple;
	bh=cK73xlcnwoxldEkGmD4EFh8XODiKSi9jYby1FTeTsVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4p6VGP0gk4Dr2Jg1IcMjQLJxQXMWM2ow3N8332yT80J8MJS7ecBJQlHu96VDOu4AsHG8TOmt7dxi7Fc8lG1/7vScSGi9Mydo9hujw09t6SygEzaQjQy+gpe0oYTTstxSwBiRBa7FxcjtuehCionexiZUwdtu5bDg4AirsNx8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efzTdWvg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so9300795ad.0;
        Sun, 02 Mar 2025 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933141; x=1741537941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5QRhJ4JsspC82Pv8p4aZzdxcDW7s51WKS+5ABEU2ns=;
        b=efzTdWvggNeZ3PRmctf2Vn7drCRvtcmeRudtJvyHwHiuXS1OPka4ZaXezvSVNrvxTi
         llNbkdU10mGtu+JTIEoR2/T4ZQ4SurU5LOUA+2Pg1I3btzY2wSVcxfjt28kuNFnzQXkI
         BAUrpcHbteG0W1+zJ4BDBF2mYHQkdzO7dRMTPwSv9O1CymwEuLIgpCzb4HzbIwQxOOH0
         DMie+StCbaxCWqvWX9c2bFQ6HdPAJoF3RQ6RlgP32ybE+3wrQXWmVA+5Vvl6Qcn/tkqY
         CrKB9Z/4FwftEcYSeyhmCUASxe0O64CgQFv+YR6qYKAbyBQVh1XMACJZ67euqqQkEubL
         yWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933141; x=1741537941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5QRhJ4JsspC82Pv8p4aZzdxcDW7s51WKS+5ABEU2ns=;
        b=AKoMY5JMOmsJ50vCFje/ExfR1lpVQfm0yGMtjSzm5kqsXleqaxBQA9NIJwrJBb1APp
         AEltUcLfzp2HgckkQrJW4rA///1zbyDMD0THDb/Zd9j8Yz1dpK8FBOBXaZwrf+3lt7rD
         80Olb/3JIgEBAZyXklzoBh821Z3xMUSUOT5EzmBAzEPv+Xcn3sDknIpIYkZZx2x+yPFx
         UahyQDN/Kzk7Ckar+h5I0+y4ELpeu/IC8NvR880XDROgMSxLYhlKZ/tv7TbAH5FSUlQR
         q1AmS2b12m0XqDitlIJLh2Eq6O1pU+0u9BzkidT2srXV29x0BQTb1qaTa1fsiHmrLGyI
         eY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUqQjUSnpOSLZm9G6M7guJcoB7mN6PdKAwV5CO3YJJ1CMnd68irUjQcoTZLSdk/0me7zncO94NSiRWXbVnC@vger.kernel.org, AJvYcCVl6Fty/v1JsnFZa3H67gJGbNgIyECz/3gjVJMPfGf1mQS+/iCbcd0YrXysQS2dR9RVWXZLo6GdyHXf@vger.kernel.org, AJvYcCXze3oIbWYeqHpqEXgELEwFn/EIu3POB1F0jT5qFqLXNHO2WULcYhhV1JkRSIq5IzekSSjnhLaAvbFtuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/6LL8gKKvXyBCRogwgzc0wqbjNjg1j9ZWMZ64qh60NmlL4eB
	aBzQAazi9amdgt54zlQbOhb2j2d8OBt0R+Uhf3Z5onn/cyX25rX/
X-Gm-Gg: ASbGncv3RzJFYl35Q6W+7WX6mIS9Vw6whK04KrqeBdkk2Ve1AXFoGvHebwhbqJDz/uh
	3WxHI7l1CGFZiS8eEXFixP6qjQdYzzL5gVfRJlPUJdkAJk+gxF67SSp5P6zQsiCH6Y6Vj9t1Oi2
	nFd/m1x/x8gfyOJPtYZj+H+VjsInvjJecnBS0u3K1iAq2Igfk0NVUpYz8FQq9Pnnsk6bOo/uILg
	sapLUDcKTbKPeHpDoUoYVKyMdpQOEfHAoFmTNqEijqO1fZk8Mo2iU2qQQ1oxXc+9BzXKjGSAU0L
	JFwWuZmnPzHEQXQRwQlyYJb+Z4kmhCh7rDDIAF6XPtbcuFHnbfjF2HBcmw==
X-Google-Smtp-Source: AGHT+IEDANnttZAPBaCcKyUFiBfmVbgwHH2uQfeXbhWXWdLRJgTKpojDnBFAU+XDPaNmK9ksSx2caQ==
X-Received: by 2002:a17:902:f548:b0:223:6180:1bf7 with SMTP id d9443c01a7336-2236925874cmr137212745ad.42.1740933141138;
        Sun, 02 Mar 2025 08:32:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501faff7sm63080445ad.75.2025.03.02.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:32:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:32:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: maudspierings@gocontroll.com
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joseph McNally <jmcna06@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (ntc_thermistor) Fix module name in the
 Kconfig
Message-ID: <f0e34ec5-5c6a-4518-8c5e-da2b95ae2af2@roeck-us.net>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
 <20250227-ntc_thermistor_fixes-v1-1-70fa73200b52@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-1-70fa73200b52@gocontroll.com>

On Thu, Feb 27, 2025 at 01:57:51PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> The module name is incorrectly stated with a hyphen while it is an
> underscore.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Applied.

Thanks,
Guenter

