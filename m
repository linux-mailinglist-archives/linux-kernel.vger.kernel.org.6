Return-Path: <linux-kernel+bounces-235272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A291D29E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70081F2120E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862631552E7;
	Sun, 30 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWzrC/CU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36615350B;
	Sun, 30 Jun 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764014; cv=none; b=cQmFoYN/s6gi3OqirIpDjx7AU8NV3rUj4XDXyM60rzWifDiZc9L1gOgxc6YaX8TD4hXkeA+cuZpb0N35HWZFNmZwsd8CfgWeUVgH1qlF0FmAr8IRho82MJd7LGsdKi/qAsxg8giB+vohcJua/lEDpbqutC94mIEn4QHuyw5On1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764014; c=relaxed/simple;
	bh=gBegh4lCDc3lzGzvIk0yZgjkGG7HNx8Q0MLpf28nm90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBNfLr9vWdOhqHVhBfy46rwBaScQCRYcKraySxlUzn+j1YMnjT3SlqQ6IpUjFYXp5XydB4SRqgVlL6LwUhrpfKsh/ppJu3mIuaIgP0hSzdZNF9vL745EaBCHOTS4zMBAqOsk/iWXGu5s+vktdYBDm6pDpmP5cPM6o4QelLHKJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWzrC/CU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso16793065ad.1;
        Sun, 30 Jun 2024 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719764012; x=1720368812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrKPEr5dAf7Uc7FJuurmlcLczDzgXAmmoWwF3Wmfg1A=;
        b=dWzrC/CUHA6nx+fu/D8N2vJsks80KqOinU5qau3dVt74s0i1DKam68nbRlqd2wGzmF
         yisDVaY1w8JeTjpAY1mooN/uIcN2DwmAkqMQ2pRehUWCnYeZ6r7mSS1sRMs8Z/ABm+RI
         5Wq1PB/Ew56BpDqWg5kNU3nIW6uqIM6PKsofyWJ+aVva9uXtmfUP4E3n856Sy78XlQjA
         1iIVeE1HFiVWhVyVOWyBYmm51BvUq+SwaMhm6wbYgTpIRVtDyvr+Tdb4SgcSIEwX0hRX
         28+2yJYtr5Nmr3caAvYJ9qjnReHVGNCiscO+zzSTaolGvoMdof0Gq+pYAT/RN0PrhK7C
         i8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719764012; x=1720368812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrKPEr5dAf7Uc7FJuurmlcLczDzgXAmmoWwF3Wmfg1A=;
        b=C6eVqpdljkhIUD0IpoFbT/f7YOs1/oIjFbh35+eLIq7wI53LPRt0TiourktLaOE+vH
         ES7cx1ItNQbenJJQNQK6j/9owZnegIdOsbK3ItZ+WTfTSThKvn9h+tTGEr9QUKWOt9Oy
         jc8fV8YnPoj0nMCcjG+Y8KGELZWCToXoktuWwrgn8JEtvjD5HjgoyvPTOO2ADjjoiYud
         QpRbfG6ESZQqOpAxtZ/pySDqE29WOYNHKfn4Qd0cBcn5XD4dWlySTEhO+LiSsegbjoiz
         kNAgJzLhNA7G5uarGqyk+XUFGkzL8NvQmZ/b+54bNBYrRLNJxl4jz71hjEhMx2YqPYMW
         vJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU8ZLfR/QglhqOarUsGsuFXP4JvyRQSFfiSae30C8n/lzHJ/V5WUoiEOGm6w1wk5+ZOHS9W9HyDfTPmsTUR46sYpyCFqulGWRO0HsJcA3ulDi0eMQLWYEzQunH/l7/RkcesFv+qI62NdM=
X-Gm-Message-State: AOJu0YzA5KphQvK6ZiWTKftPhD8Gl5C/VNnD9Rc+NZ9e9e2Z6TE+/8CJ
	0jU7lA8fqfaAzrJkepghdubzgOXKuTBAE4bpQNFH+9G6KPZ2wa4C
X-Google-Smtp-Source: AGHT+IH3M/QXEIc13dcQqwSIIUSxm74TjaDNw3+f1Rkh7385CM8C3SZc+/DeLs4lX1fiv0rbaBDdVQ==
X-Received: by 2002:a17:903:1c4:b0:1f7:1706:2596 with SMTP id d9443c01a7336-1fadbd07d45mr42837855ad.67.1719764012450;
        Sun, 30 Jun 2024 09:13:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15389b3sm47706835ad.121.2024.06.30.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:13:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 30 Jun 2024 09:13:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table
Message-ID: <ef22ef34-f93b-4395-9fae-4e4018d3f501@roeck-us.net>
References: <20240628214723.19665-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628214723.19665-1-W_Armin@gmx.de>

On Fri, Jun 28, 2024 at 11:47:23PM +0200, Armin Wolf wrote:
> The BIOS on this machine is buggy and will in some cases return
> an error when trying to get the fan state, but reading of the
> RPM values and the temperature sensors still works.
> 
> Closes: https://github.com/vitorafsr/i8kutils/issues/38
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

