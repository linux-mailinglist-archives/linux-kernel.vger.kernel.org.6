Return-Path: <linux-kernel+bounces-343149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CB989745
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6532824EE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BEA7DA76;
	Sun, 29 Sep 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FbirAg/Z"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC44207A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727641264; cv=none; b=bEMHkhazeS/z2wsKNwdR/9Xbiabsdx3ZMziQljgXKx4n72Pe6aez0UH5+Qo9HH7ObhXG/HGsgALe0Oy5ebZexx8cJuANqhdTI43P9Mc1uk3hJ8rWRAI4ZmKAPVre1WVcFxROoN0ztwKF9AxcWwXFHt2P3B0rvJwES+qg5iSHz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727641264; c=relaxed/simple;
	bh=NCMujOi7gIknHs127h5m38WVgd6G0xciBwWlyhI04G4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=r00MQ+cRbKgfXA1/Z5yVTsjxdUvPgWTCYtdQEXfGxO7XnM0tD1WNQZ3CGjHIJpkUWgFU50HrKR51nq+5vke0ggx1aedQZg8RTfeBGFIN7JFh/IYgbDZvR7PSNRRpDVYG/FKR32wcSZpYW/4QOduSOWJKhOsr86p20HjPWg/EBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FbirAg/Z; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7acd7d9dbefso470674385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727641262; x=1728246062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j730t5RgznBmQZu3lvSO1ELFYrR4fxxSXPbfDnOL7lc=;
        b=FbirAg/ZSZj+9IbidxOvv4MW2hjAtpLYy2R2whBxT9uCtH9/Z19joik6o+0vayOTDK
         JyiywBmlX8zVIQeo9Dx8dTRucpMdbGaoWhwPVDDrxbEnEJd8jKAWSfQRr7KU2aP0jE66
         +uWhs5/IrpkAtzBoL5YynpwdN/bDtOQoEFUircp/TPvet9dejhkLD+loPdJCyMDFuuYS
         UZEWO2HrewotMsOigrcRKTe9qDW1CrGwtF7doS+bH/ZT2GthiJQLQqyN4UvMa9LZggME
         ww1cYsohwGHfz6ZTHqk32J9xXGeSMZY2cR/z7EcIdKJcKCRwYbK5GBydd28Gzop+4DTO
         JP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727641262; x=1728246062;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j730t5RgznBmQZu3lvSO1ELFYrR4fxxSXPbfDnOL7lc=;
        b=X/n9AC/Wo7XDCnC5/K/9yz554ytoP2A9uOmHppCZuisTyLdY65og+C9dVl2xNhXQTQ
         F4K2t6scGs1u+W7OXYPrmIG8oDObg/5lRQJ/ebl5WwZ476wqyFHlqtaJbbBP5Qw+3JBk
         QAN8tErEDtuPpnQ0Ll6VP60UdUajMcIH30RMokbV3msZ67MEstDcmz45Ik7n03BooF0O
         rORio3S/UfxYuPeDvgVQcyUQL7EJpBbch1BclyMmVifSk31wMHtgQQ4cN0jQ5juF+mW6
         l5wN6tAiGIbITbgIONVvnv+b00lNB8VnCtsBIWI5Kr41R2pFCf3cj8UqzfI/rW0iXMIN
         VzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7fUaqwtZQ4NUC3TiyP1hD8FP2ULHWkSngRgkWCw72sNZdhFyayDpenSkHQztzPgFxSF01vPmrTHjJ14A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyKzbQ+cvtWFNszpQdb1GYkpoCfxqOygTREzonSgqDSjvjN9uR
	bmw8GukmVvIaw0CGpkhGJkdwtATFm1S4fAJ2++XOiHvIgXBnvxWNHg87QcMkKg==
X-Google-Smtp-Source: AGHT+IE3rPnUiHlGZpJAiiSi2r8ITRz1wB3lhzsgmG3CaQpGo6aFcM3Rt59tO+884CFfrtoXeBewRA==
X-Received: by 2002:a05:620a:24d3:b0:7a9:b114:4704 with SMTP id af79cd13be357-7ae3783849dmr1387092785a.22.1727641262161;
        Sun, 29 Sep 2024 13:21:02 -0700 (PDT)
Received: from [192.168.22.104] ([62.156.169.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33a4c9sm31021261cf.73.2024.09.29.13.21.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Sep 2024 13:21:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Date: Sun, 29 Sep 2024 22:20:59 +0200
Message-ID: <1923f716100.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
References: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH] MAINTAINERS: Add security/Kconfig.hardening to hardening section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 28, 2024 8:26:28 PM Nathan Chancellor <nathan@kernel.org> wrote:
> When running get_maintainer.pl on security/Kconfig.hardening, only the
> security subsystem folks show up, even though they have never taken
> patches to this file:
>
>  $ scripts/get_maintainer.pl security/Kconfig.hardening
>  Paul Moore <...> (supporter:SECURITY SUBSYSTEM)
>  James Morris <...> (supporter:SECURITY SUBSYSTEM)
>  "Serge E. Hallyn" <...> (supporter:SECURITY SUBSYSTEM)
>  linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
>  linux-kernel@vger.kernel.org (open list)
>
>  $ git log --format=%cn --no-merges security/Kconfig.hardening | sort | uniq -c
>        3 Andrew Morton
>        1 Greg Kroah-Hartman
>       18 Kees Cook
>        2 Linus Torvald
>
> Add it to the hardening section so that the KSPP folks are also shown,
> which matches reality over who should comment on and take said patches
> if necessary.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)

For the sake of casual observers, the reason James, Serge, or I haven't 
merged anything in Kconfig.hardening isn't due to any malicious intent or 
lack of appreciation, rather it is out of respect for KSPP and not wanting 
to step on Kees' toes.  I've happily merged KSPP related patches to those 
subsystems which I'm tasked with looking after and I plan to continue to do so.

--
paul-moore.com




