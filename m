Return-Path: <linux-kernel+bounces-337289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F4984839
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628E11C20BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BF1AB53B;
	Tue, 24 Sep 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnvSIV6/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC381A76A5;
	Tue, 24 Sep 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190366; cv=none; b=O/EmjDXmYtFonPEgzCVGR1C9joeto0TwnpzZjTSMUNgZmUx216ghfbGuLnCDZ5ushAy6dF67DdkDUj8OTygbvuJeCcwd5fbZzf7daKps9e3YFx4RPcX+58UToDNcgB9nps+JN94DBY00vatotNYUfDS0T+6XtMi4eQk6lyCYYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190366; c=relaxed/simple;
	bh=WEt4t4OKLC44wD9fFRRRREDLnvhSGokn0SJPbLcxpss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE4yLj/h5liUytJSjpf+Woh1smJdZzk3fPiXLaPNLNOz1IiucU3Jy54mamnd0C9dd7gDjqYyoFtYD5G2vEHl8Ahz4J4LZ42kLLgqN+60pwUC8WhhGsUcSpfQ5+G3oyxWghwYaDlcnik1YLvfQuAQMSccxUoJGeJO9LtfgT+fA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnvSIV6/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so57592291fa.2;
        Tue, 24 Sep 2024 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727190363; x=1727795163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEt4t4OKLC44wD9fFRRRREDLnvhSGokn0SJPbLcxpss=;
        b=WnvSIV6/dO3QMlY/OsPNl9w6S8XpNDT/X66nRnSrdXszduuP6hl2ImwBdxOK4wvWSr
         jOpUXqZTO/1lxgvGw4kWO0Kt3lYUZ0sD0pTLyD1sivUAQc85YNnNkBstbGxLjobc25Zr
         QXWEKh+Qej3AbMGyKM1VroE8zcKcIh1t8tHIvhtn4P8TDrY0gXV7im4bn1WAYtKyC1bB
         wdMmQAcf9ym7/nXNEzokScaw9Wgps1ewIlbLVEF1/gniJzSeOrkVJLr4P1EU9lHW0S8s
         Uq1jNDabxcRjaSi8dn/KjEcgvGpArbfRhdMLU9MLjEKobXMb2ui30ry9QpjsKRRMNmSw
         fPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190363; x=1727795163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEt4t4OKLC44wD9fFRRRREDLnvhSGokn0SJPbLcxpss=;
        b=ec49PRIpqkdwotL/aUssK4/0r+VUrbXkVqKFgQeIRsdYtgMRKf/sWUKIX2BEw1C0ci
         WHIqfNKcmR7Qeq7r5tu51UVWFIMyHq+5UcHVS2XZSyP4Yoquf5/X9Has44z8oJLJhjZE
         9k/TzwolYGvQ6L35n8PGuCvhTkXdCWYEnXorBpgx89VYOB3stsI89jFGAv7vLTZ5OF0g
         R3W1K76qoWnOfPKLAOuGnn5gENWTIdB2qttpFpZgnHVLyVe+GfCJr0329wX+UeFsVIvI
         snq17lr4OEwuRr3zYD4rMeDAyS86Oq2ShL0r6srmJi5FXtA9/NZ9wc+NXAXkvOKGq1FX
         vAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWywjcpc3lYtEi8dlFFOxhXa84EohSVECzdKxo1pJfJ4lDWKB8oYwyU6bafjsxW5gtKwx90nKUA4TIdHCg=@vger.kernel.org, AJvYcCXQXcuuRTCAFjuTPtUYglsxocLAhT873eCV2gb2OULkhndn3k8tvU7yXNuAgqAUgB+Wz7kUBfczupvhO6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAb9ZCPu2b9X2+s25uAiAH6T0OGqIFSwTNb7KO2WkHlw69xE5u
	wx4h1MMn5GjdHZz1m8fPVbacKARsrmcmaJyjDXX73SoyEesEpW9K/vryoJvmLT+raO8CKHe5o3y
	9Q67MWs5Xe6J01ECrdba2cQ99WTg=
X-Google-Smtp-Source: AGHT+IHJXnBttmZSW+jlVDB4ya7Xha0cvgTxb8sPbFzzC+SpJMt6q1ghM6s3jvwsHh6rzM4yTYmh4kBk3zW7n3O2GmY=
X-Received: by 2002:a2e:4a12:0:b0:2ef:2d3a:e70a with SMTP id
 38308e7fff4ca-2f7cb2f6912mr64838401fa.18.1727190362321; Tue, 24 Sep 2024
 08:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
In-Reply-To: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Sep 2024 12:05:50 -0300
Message-ID: <CAOMZO5DYNK_T4xFBToMK25PuCfns57Cn+z0PoZ-y7pGr=2J=tA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Use maple tree register cache
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 10:58=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> Several of the NXP drivers use regmaps with a rbtree register cache. Sinc=
e
> the maple tree cache is uisng a generally more modern data structure whic=
h

Typo: using.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

