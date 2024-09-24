Return-Path: <linux-kernel+bounces-337167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437CC984635
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060B22842FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68DD1A7266;
	Tue, 24 Sep 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E/T8Vf1j"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920581A705E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182308; cv=none; b=bmLvUUpCjvo3HjdiK2r+0Dbd5m+D8XmEcGpbkS3Iry82GweXV1wiquhRyCgWJwy/8YnIO6RgfTLguqjKCmepR5MQsxifiLGt+XfLr5iyKYiU7bhiSbOLUtBYdgO/5LVsUs1je5Dnge/3Mh0z85QjOUPvWO496O+VOpSwEu+3k5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182308; c=relaxed/simple;
	bh=NYnTT2mYdbSsYE8VZMZNZff4N+tsPnS3XfhKa7yfXm8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oaFJ+pq2Az34t/DUv4+WWn3qV4opyOxPTHJbRIJbynSogfCrNPglm34AHu1hq7DKEueCEhGzkNhbcjaeKH1RVf8pfIBTaeC+4mpDxMhzDjFiN8Gk2iL6wMsQihLvNb8qRwjRelkUQDwm/CeJXIKLX+RrD7nCT4s7Er+PsKRfoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E/T8Vf1j; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7acdd65fbceso68388785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727182305; x=1727787105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEFroRaEUVVo0vhHoSJPYIHPSph3BJU5OJfsvq9T3TM=;
        b=E/T8Vf1jwBgGYlxTq6xEUFwYgzVNGoEaLuK9+40CVRIhcYWR99wheVZWjj7PMjqKhK
         PULcesz3/KsaIHE0BCmWqmo5T0zp8bNDrT0Vou5lmqFh4fbVHL15CwnUnuDnDxkjUAqu
         V/MTyycYJQkcHf06nI+bi3kW3bE+wprLsybgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182305; x=1727787105;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEFroRaEUVVo0vhHoSJPYIHPSph3BJU5OJfsvq9T3TM=;
        b=uhB1WqbC1enDIud0G5YRAzPgwxC9MeeWj+VkUtPf9X9L2qLgHh7rUo+XKjLqiEG+Xp
         INSGiYoEv9nvxhtlWo2jJD7fiky6j37uwzdtVUTZMKXqKqMAq2Zwtsx63lsa474Xvq47
         kvePEfmFGSS0v5BPwswl3m1G0XT1tB2zPUhrenTbaQa2Zuu+ERPXE+UVAYVr1keSCjqh
         YHxgX2Y0vBay2sA0EDckTrsrJy34Lhy4VwQ9O2UEOkftkZwQs7WQg3ZFHhdW33B9ngXZ
         qg+rOE/1H0V6b43yDEIS07pKM4ezPmNlXSh7aDtS62WH7yBO+rLWK1UIS/ry0TkeUbte
         2qvA==
X-Forwarded-Encrypted: i=1; AJvYcCVJLiEVp93yGv2Ux80nIuK7vrgcF8V+WBF1EdTjhBNMwChB763bTCEmulqdzkgMp1VtJhl8YxEHLOpOSgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2EBPU1pgsTmO5iBf8/+GK4s1Skhi438oQLNKZyakBIKXtQd7
	Wb7pi2D6GuhRFYwnnXcfZ+n5VMDWzlHsJs+vFTUpSN2dhz3G1DNML96qpXQDNA==
X-Google-Smtp-Source: AGHT+IEnFVTCyWKq23rKwGg9QTjCsNUD+XWMRU6sHjLIqkYeDsd3w3aGVN81QJVBYLudmWpFjYvWSg==
X-Received: by 2002:a05:620a:4688:b0:79c:125a:9217 with SMTP id af79cd13be357-7acb80aac50mr2551056185a.18.1727182305268;
        Tue, 24 Sep 2024 05:51:45 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde542f6dsm64933885a.49.2024.09.24.05.51.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2024 05:51:44 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Kalle Valo <kvalo@kernel.org>, "John W . Linville" <linville@tuxdriver.com>, Seth Forshee <sforshee@kernel.org>, "Pieter-Paul Giesberts" <pieterpg@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 24 Sep 2024 14:51:38 +0200
Message-ID: <19224165b90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
References: <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH] brcm80211: BRCM_TRACING should depend on TRACING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 24, 2024 2:09:35 PM Geert Uytterhoeven <geert@linux-m68k.org> 
wrote:

> When tracing is disabled, there is no point in asking the user about
> enabling Broadcom wireless device tracing.
>
> Fixes: f5c4f10852d42012 ("brcm80211: Allow trace support to be enabled 
> separately from debug")
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 +
> 1 file changed, 1 insertion(+)



