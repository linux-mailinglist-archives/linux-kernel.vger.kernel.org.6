Return-Path: <linux-kernel+bounces-408921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0969C8525
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6CAB21D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A371E8822;
	Thu, 14 Nov 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LS5jb6QI"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81181F76D7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574002; cv=none; b=aXSbq5rgvbfZpx3dpHGUGjGWE6TXN6OJDaD9A9+dHYw3PBFjQG2JIKQaRmzQCj06JJFa3pjX+3tVznJDiHQc3dhteb9+xbWnBrN/Rj79QxjMh3pQSbgDazDxZpN+UNHTHA8UFSbE8SgMj3xA28gy+34UWeP7X/Z7GNDF8uJJS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574002; c=relaxed/simple;
	bh=Vlwv78Jmx8PtyWV9jzUFNSXiAEcvYzgDAK5oa5BErbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj17z6GOeb0FJiULGRzhHJyG1CyTDO9THkxoDVPGbUvNqFTFGjbfeCuFH8gZv7EXInmYk5c8ErW5HGfbrxXvNtAzbS6NP0WdWd7jrygKvvUGNSiVSiiKs4OPdnUQTVcCmBMLmtbr/LEzuvLISrukHTnNmAQ6rkK3tW0rwhh+rZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LS5jb6QI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ecaa45af7bso4131397b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731574000; x=1732178800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQk070VnTWQtqIqFikoSqiSm1iFWMwR2xaQu4Ky8zkc=;
        b=LS5jb6QIo6TJey7dMOaI3qTj9hm4WojHUx6U33JnQJQ3R7A6SLMhtcbJlC+7p04raB
         3Ouv5hWGoATu8Y2wKeloKASs/H3gZ7QR42ALz/UoYEwWOjfFVolzDkbNJibV9ZSwFKLY
         j6ETmg3k+6Hi70Lu+F/3i1yxXeDS7lBLrxTBx0BTJ2GF9yYxsRM4+yQULMDduSbfdhYp
         kF2+4Hk0/onoLv4qtbQRTDeLPugAHbe9kS4dACzpmcmw3NZHa4V9qXPiqPImMVLcW7V8
         FsxBzw7BrcKB1xlBqM8evHsHIf1kNuVPlTEL6Be4kVtGp4nESOXERdoEsiCvLlabHRFP
         657Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574000; x=1732178800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQk070VnTWQtqIqFikoSqiSm1iFWMwR2xaQu4Ky8zkc=;
        b=FfikV9Ofm5kBCzzNbWOAEVmvRHqZBfmshxy1wsPnx+Pe1QEAOzB3rcbySGMuJSt8oK
         7Oa833f+IXIWCt4d9R6BdZ0gTg2l9Lo1LiWI3dzBWjUkKoF/hT9TQhFV5JIDZ11Ucv9T
         TlkZB+aaADpUhWfxtsZDsL9fQy3V8ULVVwCGK1wBVgWzaK+h53Z2rwP/dv4UG0wH1XB3
         ltFdBsvH3zM4zBAuDajQO+OzEIrhVW+zaq/KxAgPZATHmYylbgMJyOC+hlXqCLT9CnWT
         YmnzBK/M8OB4RhjRSmer/ZvTMeq56ttqpSMFXO290BMFjg3RBqAH/KoA3W7WWjQlaX5K
         QP1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9f3vXR/NB8v4YTS58lcp4bGux5IiunytKPTxHqF+qORl6dr0fSxMGDUTTr4G+8op2TTtLexl75GbMHiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhAli9aP6/Rk2FpCgif3g6FIrG9TTrnfjybhS1W/fPqcYGS50
	APFQS6pYkj9OMbgcGZr7UOynQN2RiRtqKNTSWCcdoaXX52ZUlF4UuA5WXw/hRHdpPWXtw8z1Ffb
	WMw4/ot9YG/PCm2Rb2gs9QsX/gxRzNNVMEtaIUA==
X-Google-Smtp-Source: AGHT+IEptOSJqLLMi4ZF/HZTAppM321heaBoMo6X041LBRdBo/RkECxvPVue4UqSVc3K2eKfZS0ZLP+18Qu/6LfHtDU=
X-Received: by 2002:a05:690c:498a:b0:6d6:aa50:9267 with SMTP id
 00721157ae682-6ecb359dab1mr66938427b3.39.1731573999808; Thu, 14 Nov 2024
 00:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023221904.GA941054@bhelgaas> <20241113214850.GA1912974@bhelgaas>
In-Reply-To: <20241113214850.GA1912974@bhelgaas>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 14 Nov 2024 09:46:29 +0100
Message-ID: <CACMJSeuU78R8W+m9s0mV9y0DLNJ=JSRHjC70FiVT36bMbimj-A@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Amit Pundir <amit.pundir@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 at 22:48, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Bart, Amit, Neil, Caleb]
>
> On Wed, Oct 23, 2024 at 05:19:04PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 18, 2024 at 05:47:46PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > This series adds PCIe bandwidth controller (bwctrl) and associated PC=
Ie
> > > cooling driver to the thermal core side for limiting PCIe Link Speed
> > > due to thermal reasons. PCIe bandwidth controller is a PCI express bu=
s
> > > port service driver. A cooling device is created for each port the
> > > service driver finds to support changing speeds.
>
> > >  drivers/pci/pcie/bwctrl.c                     | 366 ++++++++++++++++=
++
> > >  include/linux/pci-bwctrl.h                    |  28 ++
> > >  tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
> > >  .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
> > >  .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
>
> > Applied to pci/bwctrl for v6.13, thanks Ilpo (and Alexandru, for the
> > bandwidth notification interrupt support)!
>
> How attached are we to "bwctrl" and "pwrctl" as the names?
>
> I just noticed that we have "ctrl" for bandwidth control but "ctl" for
> power control, which is slightly annoying to keep straight.
>
> "ctrl" is more common in the tree:
>
>   $ find -name \*ctrl\*[ch] | wc -l
>   691
>   $ find -name \*ctl\*[ch] | wc -l
>   291
>
> so I would prefer that, although "pwrctl" is already in the tree (as
> of v6.11), so it would be more disruptive to change it than to rename
> "bwctrl".

"pwrctl" is shorter and it was the only reason for me to choose it over pwr=
ctrl.

Bart

