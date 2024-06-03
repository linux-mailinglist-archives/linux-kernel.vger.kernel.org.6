Return-Path: <linux-kernel+bounces-199226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708CC8D8422
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033BA1F22105
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8ED12D776;
	Mon,  3 Jun 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BagTaSxm"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9A12D758
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421889; cv=none; b=n77zuzlBde3pM+oTutPi0YDPqNJNTC++4l7xYsx3Q4sPxMCkT9o7JacYvku5sO6sNg3B+0udcHGhwC0fTVnFdgI/VsMw4Rt2ViG03On5IB2VRretlStktjLnFVEQ47esmKBYryA0+0b1rc3qio+KDHpaQghfpuZJZJmqwiutWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421889; c=relaxed/simple;
	bh=s5oY5VB/ZeLchozmlxHpgn0jJCP7I7onyi92IM4s3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1I6DN4JykX/gP7uWEgMg4tgmoSI2YcSkSMGFse8YTMgjutZHky2NJxdhCkXpD7+nvA86tEwdo/n+4Br47sHQph3kpyhWY5jaEXWN2TAYB9WigBnopZG4/IpruOHnFm/SwHycGOMIqyXePDE6mO0fgrD7c+nU6c08NGultwmzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BagTaSxm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso46136551fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717421885; x=1718026685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5oY5VB/ZeLchozmlxHpgn0jJCP7I7onyi92IM4s3Jk=;
        b=BagTaSxmjSKP/D9vBOzKTAm3wVu/iGGJVQxrHNpFf7HCEPYYKRvQypYt+VxodVYLcO
         DWBzlLmlQk6p3jpZ1wrPMUfdjXnrVNYEBWJUYaa81bJbT5HCodbgazA+2mJa7SrCymgC
         IxzvY5GRjuDycLbpEF4tbCbPtLNmpnNMS4tVJDJL4wr2XxFsUiuBUioq0YZQlXOjBj7z
         bCVBCZqZzj6bTbf6qN+jT4tRXWTpGy60Y2BTCVl6ikz6bKaV+T9Bj/IOxkK58xlYoUSj
         pdDQFr3ebN2YgJCf0QstUUAigoq2KNUeUnWAwY1Aj2VPp/6rWygtRaWPNVLbp5meCY63
         P7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421885; x=1718026685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5oY5VB/ZeLchozmlxHpgn0jJCP7I7onyi92IM4s3Jk=;
        b=MHi7LCMyw0e0CnSbt02dM8C1Je0dXdXkCkY3hACYeYS4S5oEAeCr4ZNUlMQLGuPfzk
         kOHr80xEJPd2+CUJpgSQeHvg3Ku/jDkF+d+6dGkoidnlZi14GXLqCOv1725g44r6sJdO
         eZPppOQRxQDBpJJWlkRaYbAU75tdCMpDKuu66qysLBwAhYYiHw1Gx9LvhkHIN9397t21
         6U3GKAwnOoawAGqjP2qm0me3Z5EHWKKPzvnlz6NnWJhzWZLW+PJzvkfyf/z+z47EazpD
         svYr32gLm/iXXDV0IAE6/hgTRcmfWjrM9mclT8z+lSiCvIYHqww8gl13L2CRAcjxaHjd
         7GXg==
X-Forwarded-Encrypted: i=1; AJvYcCU3vpUZTfAIdoS1Lfy1xpwjt6aRV1vgKvDlpul720j/HJWefdsopfm+gUecpAUd+lRvhXGc9RJw8er1KCXAA8gxkcrfApX5pRSyqm0T
X-Gm-Message-State: AOJu0Yyjheu56AcGZnHGE3CY/gza2sAFHKuLuDLNJ61IZ7s+YbZ8BC9u
	GdsEf4ZTA0UF2yq0P8ZQHv4zaDcjNGn3IIBrxwjzcfeJF+f8v5wHb1JJhGDzKqUfftEaQYUZ7lB
	6ANHs4ZWqzPTPvXo1nRUvmOG2YBm5V2GEanYtCQ==
X-Google-Smtp-Source: AGHT+IGGEfsiDSa9MS2XjdxinT6DC4pr32ZQOQc6Alq++FGKHA8V9dvlrQ4QnDerXJqsX5VfWRcTedSN+rX53wc9/AQ=
X-Received: by 2002:a2e:b053:0:b0:2ea:938f:a23d with SMTP id
 38308e7fff4ca-2ea951b6102mr59561591fa.42.1717421885548; Mon, 03 Jun 2024
 06:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
 <CACRpkdbOAoSDNFhXfz3djUZh1_MQ_T75CC+-LmojRXvyCbUusA@mail.gmail.com>
 <06a4e5fd-3d26-4923-bcbf-0bdd66d756c4@linux.dev> <CACRpkdbSsgxtKqF6ORXubufTaegjysHU7zH-tJfDfKNd=Kdoeg@mail.gmail.com>
 <51d984f5-896e-469f-914d-2c902be91748@linux.dev> <CACRpkdZ19+zUCEBCJJ+MBnnaF+caZKFTDxYiWZ0BRGx+PxN3bw@mail.gmail.com>
 <e4972a07-18d6-4a8b-bb5a-4b832aa2d20e@linux.dev> <CACRpkdbL63ZWcopgBbANKzr476rO6_cwZL6JLqkvTDXbzzpkpw@mail.gmail.com>
 <38cd5e6d-f18b-4ea2-8fa1-40416d4370a9@amd.com>
In-Reply-To: <38cd5e6d-f18b-4ea2-8fa1-40416d4370a9@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Jun 2024 15:37:53 +0200
Message-ID: <CACRpkdbKgjdA9MFs6VtXxrULAY0VA3PFim+qYwbX08OaHxZKKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: zynqmp: Support muxing individual pins
To: Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-gpio@vger.kernel.org, 
	Krishna Potthuri <sai.krishna.potthuri@amd.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:37=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:

> I have asked Sai (driver owner) to take a look at the patch more closely.

OK if you and Sai both provide your Reviewed-by tags so I know this is what=
 you
want to happen, then I'll apply the patch.

Thanks Michal!

Yours,
Linus Walleij

