Return-Path: <linux-kernel+bounces-337021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E499984442
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC780B24192
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF91A4F27;
	Tue, 24 Sep 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGaP4pV9"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E751A4F03;
	Tue, 24 Sep 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176238; cv=none; b=qOpn4gsX2Gj1EWIkO3eciDXPUccxtQIibBqq5wK9DsyeXFnUoPLc5SadrUiZfz8Vx0NWBCrj6r9olgZ1yezkgdccotUnpQ9GlXt9koiV0l5qe4tqGzbZRFWaVIczI1aR/uJZoufTqs8OI86MZZelTVwPeM6r8khi6WexqMgdCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176238; c=relaxed/simple;
	bh=9jnzMbHQubQ0AnJe5LhoAtSQybAfXdyRtiuYCOafWuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad1q7NfqC1/Pk9jUC3cmPO8Au71Kdn/pUfHlX5rXyII35nINtWp1MX/YCwrpK0hS39mp2mBrmKtxS9NpFgCISXW9U4MZS3GSnNlOuihsqiZEXgwGlaziSPO0DY6TSATPtow2hnFsX8JVhVacybPYdouFhOuy96Y+2q/hs7Lz6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGaP4pV9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so5362687f8f.3;
        Tue, 24 Sep 2024 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176235; x=1727781035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jnzMbHQubQ0AnJe5LhoAtSQybAfXdyRtiuYCOafWuA=;
        b=gGaP4pV9yyR9VyF3SMUVkvgcCnygjpwJxE4NRfULT5zKd+Wqew7dlA+JYG4BYoL3B8
         Op5BPWVel6W9lshHkTyosClkBU2XD+KhjUHdw2by4jHjBPCMkofJAepsMrCHTMh5ET2Q
         /pz3dhpn9HkRO3Ck+JEl5TkrFbYiPAUh/0qC9TYWEtFZC67JutrtCV/HVUhot/41H4RK
         cxuhEuOABdmx2dk7Q6EL/KJcd275DGqGahqDlCcCx2XJescIOvcSD2gWAgMBEKsbddyl
         ZyxhkNZJ9NBYj3bokg/LllxE/YxObojmtWueEpL5j4abW2LjnyKk5g7L2vQf+JJSNab9
         wxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176235; x=1727781035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jnzMbHQubQ0AnJe5LhoAtSQybAfXdyRtiuYCOafWuA=;
        b=rOocNluS0r4uemBAh2JfCV7TiiCdf+3G1slt0xGsAP6gzQ7msMjk/3FYmo6H+2fnDr
         Lo1mbqKTymhP+4iLXF++i0HW8XhedNp3oTBSUHgVpXRkR7+hO/Ctj0rwACiNrVNb490e
         lBnqpqcgQqhejSGV+aoQo0AO5SiN4sukhTU70e0QJdo0He98CkrK+aDVbaCWyccAEQmU
         r9ci0lWEK57Y6r6aZk+UGFFchBz0Himpvbotnw8BqYtM9RvAGwVC/Hf4tDwxLVOpAt2O
         Zfynaq4jMzH79i3T6KTxE7RvpgQcpPlykN6CQq6+idYhq92Urm96qb64yTBvyygvKTJ1
         1lSw==
X-Forwarded-Encrypted: i=1; AJvYcCU2L0WKX3n0w5uZ3W7lrqhPDpZbTYavSWNc5wHyCckZrrvYBVWcjgm/ezJUCFcWQKGHxwm2w620GfKytUnh@vger.kernel.org, AJvYcCUKgfcwXWPbuXu7lIvDYN3yHEb2t5GUISN9Z3X/y9IecE8P+PS0g78+MSUmzAcwu+XaQdQ78Zigl5NU@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9T9fkbfXPhNp3jZTIxVJuXhU/S3STEnZNOXxMKuvliu5k+R7
	OnQ4mLF9p/FozoNh6Pyh2soMfSQfM4te298Z6WYA3Ho68BAf61+DLdfuog6/A7LI6inLkPVctUn
	R6nZylioabxoDdWUiYlnLG9h05AI=
X-Google-Smtp-Source: AGHT+IGVdaNowgn71S8XI4E9u5lRgpDLkBXHGgayJ1Q9AYKIR0GLcBZmOfxHttIANuknf5+VKcoYDdRLSvxJdXEcGuk=
X-Received: by 2002:adf:dd81:0:b0:374:c231:a5ea with SMTP id
 ffacd0b85a97d-37a422533b3mr12533743f8f.5.1727176235428; Tue, 24 Sep 2024
 04:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com> <20240915114311.75496-3-laurentiu.mihalcea@nxp.com>
In-Reply-To: <20240915114311.75496-3-laurentiu.mihalcea@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 24 Sep 2024 14:11:35 +0300
Message-ID: <CAEnQRZDM1R+5GX=8tNCaOXw6-Yya142RTSgsNPErv4KjFcpcJA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] reset: add driver for imx8ulp SIM reset controller
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 2:45=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> Certain components can be reset via the SIM module.
> Add reset controller driver for the SIM module to
> allow drivers for said components to control the
> reset signal(s).
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

