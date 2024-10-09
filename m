Return-Path: <linux-kernel+bounces-356854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8669967D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19AE1C248A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E053191478;
	Wed,  9 Oct 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cm6cFYMh"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F270190661
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471370; cv=none; b=sFULgwzx48XYBqk7kgOKhQdExe8FehXvJaAFR2b85eOHdlJhomVRWRNkuFQaLeWEvDtp6eOk9OtWXrV/xHgXCoPK0oYeoUByXYe93e01sQ+JuDS8vb/NQi9hANGWwvjGy4Ub5L5ZXe2RUnunOCHYBmKQze8+3AiAuXDhi7nJ9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471370; c=relaxed/simple;
	bh=9V8jwIrSgcFpXYzIEYnO4UoXcbhff18KzNRe9Nwd0zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8bHorZ18L4gl/svYX2X9gR+q1dg2KczZVh5PfPDrqIU81O9oUx312CWmo+MCqnMbyYdnOoZwliSS+S/sDrB7AnduDH081ejwiNPh52DLYRMb+6QNaTE8kYrDvpFhfKoGbh/TMHfTr6ZRwrdhkrSgKWhbFK42JT3YqhMC+bm0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cm6cFYMh; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-507904d0800so2436210e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728471367; x=1729076167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNG+QhTQAdWb1KvFrYofboNFibFz2WosHRUzPUAB8Y4=;
        b=cm6cFYMhtAZ1HbeZlMtIxqVx82G88FvIk6DiMNqjQY12ozN+uf+iL8Sc1+MINMkXlw
         p62KggrjcIwt+iuiFa2JMNSMp4x1qQa2rtWsWmxdRUGZY49fu4K+EP8pxlSY0Bia2QU+
         zPuWfPr/1W2tuVvcSbSLU6lqLA9hQXTcqkT9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471367; x=1729076167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNG+QhTQAdWb1KvFrYofboNFibFz2WosHRUzPUAB8Y4=;
        b=cZVDq55/4xs0gXsGaxFvYG6EkZoEZlF7R7aEIpWqUOEK8o30J32PJ9XkK5gwts6HbY
         ks8iBfVB7omQdP31wY5gb9nm88jL0ijIiMa2CYVznM8iQVEPoGDzAOh1J6UuFxIxcnn1
         9L6k0mUslV1GtctAvm40Uthh84YGMDckJeDzpFGxPUW/fOe78J/ublAXEtg3Xd+DVJxA
         yXFYPYtspxmkJxXjyzD3vXVbhYC81e4chbym7ynmw/1EEznh0PhmLpkVfg9udookKhQC
         VWXdBpM+AnAEc3dNldkF6cRolwydpCigdVCZBlOMn6Ll5m0zSzAYTL5z+hM8XWkZqw6S
         0jOg==
X-Forwarded-Encrypted: i=1; AJvYcCXpB+6IQ4Aw1WyAlLWvXWf1ge/7//MJTmM5m1dZK/Qf6Vaxw1n9qoDxLrFpFET2wOo1yepQ2vrUUUqulnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LTnObpww4wU9WxoA3lpVanEUs3UeHYuvOmz2TbVdY27mgmsu
	vsK9Lw1X4XcPsojWrCxTGlffZmVuR6xLuL7ge0KDZfNUpjdE3JR4M+S3KskGcRByPKQvKMtNGgG
	yww==
X-Google-Smtp-Source: AGHT+IFz7osaEYEYVx96/NROKrPV+N0ifVvqmAhP9VpI4HZBfwNFHKK4hq9A/Wu98P1SGZgnz6vd1g==
X-Received: by 2002:a05:6122:1782:b0:50c:857c:f4da with SMTP id 71dfb90a1353d-50cf09ac571mr1927522e0c.5.1728471367443;
        Wed, 09 Oct 2024 03:56:07 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50c9ad4a3c4sm1330044e0c.11.2024.10.09.03.56.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 03:56:06 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a3075662b6so2347659137.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:56:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSw/CNaGewo9xrgqQ4bO94Fb+hKKvhsO53r7CLAGr7JzDDexaavVzSERnlTNx3sqJD73FWY5T+w/H5FsE=@vger.kernel.org
X-Received: by 2002:a05:6102:1612:b0:49b:d1d1:8f7d with SMTP id
 ada2fe7eead31-4a448e347d3mr2296143137.26.1728471365444; Wed, 09 Oct 2024
 03:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008053514.6800-1-macpaul.lin@mediatek.com>
 <CAC=S1ngrsDxQ1Fe9xB_EevGbGB5nDoCB_n2oGb2VTLiv1vSsGA@mail.gmail.com> <f1bb941b-cb6d-32c4-2cf9-268fc3f43bf9@mediatek.com>
In-Reply-To: <f1bb941b-cb6d-32c4-2cf9-268fc3f43bf9@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 9 Oct 2024 18:55:28 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngHAf+CNuyMB9ZEW38e3mfVRNy7upsoKyAp1gN8=FGrxg@mail.gmail.com>
Message-ID: <CAC=S1ngHAf+CNuyMB9ZEW38e3mfVRNy7upsoKyAp1gN8=FGrxg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix dtbs_check error for tphy
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Jieyy Yang <jieyy.yang@mediatek.com>, 
	Jian Yang <jian.yang@mediatek.com>, Jianguo Zhang <jianguo.zhang@mediatek.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Seiya Wang <seiya.wang@mediatek.com>, 
	Tinghan Shen <tinghan.shen@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:50=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.co=
m> wrote:
>
> On 10/8/24 15:10, Fei Shao wrote:
> >
> > External email : Please do not click links or open attachments until yo=
u
> > have verified the sender or the content.
> >
> > On Tue, Oct 8, 2024 at 1:36=E2=80=AFPM Macpaul Lin <macpaul.lin@mediate=
k.com> wrote:
> >>
> >> The u3phy1 node in mt8195.dtsi was triggering a dtbs_check error.
> >> The error message was:
> >>   t-phy@11e30000: 'power-domains' does not match any of the regexes:
> >>     '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >> Fix this issue by dropping 'power-domains' of u3phy1 node.
> >>
> >> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluati=
on board")
> >> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> >> ---
> >
> > Apart from this, can you or Chunfeng confirm if we should make a
> > similar change for MT8188[1]?
> >
> > [1]: https://lore.kernel.org/all/20241004081218.55962-3-fshao@chromium.=
org/
> >
> > Regards,
> > Fei
> >
>
> According to the suggestion and discussion in
>
> [1]:
> https://lore.kernel.org/lkml/20241008-disorder-slacking-d8196ceb68f7@spud=
/T/#mccf978d76f52cc26970f3f3be6120055e4698fe6
>
> I think adding 'power-domains' to PCIE node of MT8188 is okay.
>

Acked, thanks!

Fei

