Return-Path: <linux-kernel+bounces-169379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19218BC7D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0981C21289
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283A4EB55;
	Mon,  6 May 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5CxOhN+"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443747F45;
	Mon,  6 May 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978231; cv=none; b=ICon/6Bsihj4WhUQVpHk2/UhcwPCUiWUVOnBvWVr0sfdsGqsvZSaMRLs/ysxkDyxvcQhOwY8cPKhLhcJXXVxEtVzUQe36+6k4FrucgQ3nFqVNN7GKkXbf7BJIJUjgXkP2nJJNK3MCZ20GOj6gPK2nLDDETBOGplAovB5SZWaLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978231; c=relaxed/simple;
	bh=t9sV+2F9GsZsxXoVrTVg45KxuJajB4PCBQUzDfGhbxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6tyKgVFH90wUOanNVVxqUhPnqirbL1Zq1D0saW7fTYmjPbdOvA0TLnZmtqnx6scecgkUXlV5W1OXYyjPMu0FDSNxUudljog1kMrQ00uSBQcShcolfpLUHTwwGkPfNj+B06fSQu4q4PhUpPSZtQ4MprLeCcnbaFr6Ngb9ern8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5CxOhN+; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c7ee71ebaso8071755ab.2;
        Sun, 05 May 2024 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714978229; x=1715583029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwossjwusBAm1BptSw0GFVmeFGQRWSG7xTl1Y98TkIE=;
        b=V5CxOhN+pQVQ6U9zKw5ceoHby5ciwIvIFQYRWUB8kr4kzACFCKV1MhcUYl3psxSizG
         xxfYDqidhQV2R5nh35PpEcAK38POWz6C5q8hBgcDWifNhVhBKoyyt4joWb6FLBOdrbI7
         kPsa67ysUY5VM6ugUv+DOPQB6MXLkRbnFDmJwDiWDDvK3YfGUpG1aeEwOcVxEl3/8208
         jFDKyvSg8cWh5NTdRepktHDnS3iU4npq5cyavyKKwbIpIVSUAf1dCahzwLojYONSQg8R
         6AEr3MMi3X23Wu+GP2Yh2ieJbk4VSjvwk/LgbUlwrpmO+clW+S0OjyzET07Xu2AcIV7G
         b15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978229; x=1715583029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwossjwusBAm1BptSw0GFVmeFGQRWSG7xTl1Y98TkIE=;
        b=Jk/vOJZuSRISR/wz7sOKfNNMuQH0RrdhSfA8F3xalKiM/hJ3Npk82f3EtNZRxeFPeU
         4QL21eZ2oQI+mrUa5nzDdjedcyilh2JQVYDWJkLuxr2YpYJTTmz3N6ZzH5kdlDxEvE0F
         85uKAKrpwuFz+aQSCYuYCj61KNHkLGdNCipUed2AfP/7fCIjnjKuiVk3qjsaegSw/mlQ
         kQ6JV3agxPIwUN60CPw6sHYv7rBLS50SRPYl5wSopAZ7bsbXk26iIO8TnchyMZ0jsMM6
         4vE3NSdRDEtB/36o17H4KXvl2+hyaSUH2moy++GWn3fAYPZFtj0vrBmpwhJiG+5n1nru
         XfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF0+V37RRQwe7yv65TYhnK9H0alLQkCo15hpydUGg1teg+AXnjSezMrhHq5Q4rN9kDoiNdBzrOkWuVx2T+fWwtjVfh1000ODUQqUMHHXp5s92uNlw0ibgWFVBV+ySME8VI7SeViXnGyUKLjoMjkAFOfG5sdeF6M9tslYnMGm/li2GV6A==
X-Gm-Message-State: AOJu0YzwwJbKSed/0lZK7pHE0zeARqHdaZB+d/QcoNBXi9WWQIiDbyor
	U3b3WzUh9HgODlvge8nuVBPfu5iwhDta9s9sWqjWNFD332pssjaDWDAEochbC49aAVRUNQSuhL5
	xAyXN7SstwKfnQmxRG0UlTWIGGLM=
X-Google-Smtp-Source: AGHT+IEm4rLVnE5ZzKrznJT4pumjG0pJt4f5HUbndOlm0YGQ7AvoJGI7vs/cwAljai1Nk7rIaImNgMmAPXsXJkecUw4=
X-Received: by 2002:a05:6e02:1a09:b0:36c:51f9:716a with SMTP id
 s9-20020a056e021a0900b0036c51f9716amr12210835ild.13.1714978229138; Sun, 05
 May 2024 23:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
 <1714967359-27905-2-git-send-email-shengjiu.wang@nxp.com> <05365b5a-0398-4382-9646-a1586468ed10@kernel.org>
In-Reply-To: <05365b5a-0398-4382-9646-a1586468ed10@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 6 May 2024 14:50:18 +0800
Message-ID: <CAA+D8AM09392xgh=iKxrgwYfJ=3YHmGpbE7yfH3MXnrMNNsm4Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: imx8mp: Add #reset-cells property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:24=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 06/05/2024 05:49, Shengjiu Wang wrote:
> > Make audiomix block control a reset provider for
> > Enhanced Audio Return Channel (eARC).
>
> Why? Commit msg should explain that. Why suddenly this became reset
> coontroller? Does it represent hardware?
>

Yes.  The Audio BLK_CTRL contains clock distribution and gating controls,
as well as reset handling to several of the AUDIOMIX peripherals.

The register at offset 0x200 controls the EARC PHY and Controller's reset.

Best regards
Shengjiu Wang

>
>
> Best regards,
> Krzysztof
>

