Return-Path: <linux-kernel+bounces-310420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90057967C84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25B281A5A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027614A093;
	Sun,  1 Sep 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dol4w57w"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A032A1B8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725229013; cv=none; b=tDptyyKPJv1gNniaYyjQt4zVtoWDIl+f6iLACMJATXrg4CVWn0fE/v9VI9/g2vlNnxWxtbugChfHsHsKqc/l/6Gs1B2eKRkXPzInYJ/NkkHx2DGKWncU3TdKxBU/IAgCUv3+OJQDvdfMCbSikZHyANJm8nHCojPcEZpQkSrg0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725229013; c=relaxed/simple;
	bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIs/JsdN1rrXrTvnIYzfqHMlgUkyOShW7QgiUekIrlL5SvipvE4Zoy91e7BtXkiORsKXqdLlHs3R+JICXpvSejPNi+2RDI1PeQdnumEmZAZqQetvvp0VNozIeZ3notrD+UcjKO/KYBnE83Y58vxOhBm4Jf65ETSR9fZxg+OWmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dol4w57w; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53343bf5eddso4778173e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725229008; x=1725833808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=Dol4w57wANsqQVNqVFgtVj2afSBRE1fBp85A6HxNqVRhMhBw/qmERsMvPoM6UJxQPm
         5evJ0OgwmiHCj3rj6GY4ssItY83gfT1QrGsap62lsLp9qihawu84RVx2g2WJ8oWN8Xrg
         JzTfT8rZZNiP1kqXZ6xy15nlbE3zmSCZjvgWzOqcrSIZjJgD1QWnZIWWmuf+JCMpIzLL
         ZUvdhxUCmh5/WKjoT+m0P/Qce1c3JyGFdFX/rdIzNJg/u/+2TKoaLOAFgB9GS9rwiEtk
         0x59kVcBR6M8sWIJ2MGOuLp+m79NvU+xOnRK12cyWI69KBgvXapy940Fas74Uf+VTVLX
         mCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725229008; x=1725833808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=GWAkN067lK9xx80vAlDCMLvVeLEClAXCKJfH/42cy0Hm/dc6c5zdGEWtuqQsETNBlu
         nAaOavNmiQ3NxZKW5Nh9oFYUM/c8BsEGHuiO+zgPScbB+Bmxa5Kr/UaoJjSvIkry3p6l
         sVUqkuF1gRaAr06sz5CLop1076c+PtK3DJdX/amFIBF5rAWaARXlzGkMvHItSnXuxBVD
         kvRzmlXClHKyzNBfVWrd5ehTqZCqnPBre+Tv3UroJ5VQMZwmszNHuQBsKBVDzVDiHpDF
         FGOqmqGBj4THNnW3miOqTWK9KJLRUxoICf/vUC3HGGsKsLnHGrls7/GXOqVkeW8IfjiU
         k5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWzIISe4hPRCiW2IQBmknymHSspvd2DCWMDFhgddhVGXQmIOoL4ytCOn4vk9p+ntm8qiisnodHTvEvHOKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyN1jKzjnyyGU2o2+WFnoQApfEUPNM+euKguayBy9vMbW+uHk5
	oXBzHHukvFy/DRCLOyG4UEmKKci9oP8GV81RFIcW4hGTskef3QwJ3iE4ZNiNjigJL6rooo7uHxK
	bhU2DVlpGJlJUyLaYJ8+6mvydJ/n2VbTXudAdCg==
X-Google-Smtp-Source: AGHT+IHdmYET5UJJ7O0DFATqy27z4hgwKG+ELczqFeDgPnXSKCKTHjSkjivQNVE9IMRO9eMHmDXIIjSZEDNoK7exNfA=
X-Received: by 2002:a05:6512:3b99:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53546b167famr5663798e87.7.1725229007133; Sun, 01 Sep 2024
 15:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831072158.789419-1-liaochen4@huawei.com> <20240831072158.789419-2-liaochen4@huawei.com>
In-Reply-To: <20240831072158.789419-2-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 00:16:36 +0200
Message-ID: <CACRpkdaDcPgMQhBf9cU+oqgCa7Z-CX43hf+NZ42c5o+ZHaR+Sg@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/3] ata: pata_ftide010: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:30=E2=80=AFAM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

