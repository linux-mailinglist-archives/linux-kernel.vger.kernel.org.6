Return-Path: <linux-kernel+bounces-296157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214095A65D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C091F237A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287A17108A;
	Wed, 21 Aug 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0mOBeC+"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02286AFA;
	Wed, 21 Aug 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274993; cv=none; b=d2MKG5L9d2nVZZR0ST8yjrJ2fYCCF4sG9C5l10wVUSnPAX8woJnGtgoknTyr2dnFED5wo38oNNcughWixVJufnUPVA7RlMiOy0pDLHqlECfojtVPqz2Oh02BeQoOPwOF1HDkjPCB/1j/SRuKtctzMaCa/y9Y/zTxg8b8ytP2aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274993; c=relaxed/simple;
	bh=TiUGC2plqsju+PIKUdlgp4dVJIOBq73ZHtfCj5+GMVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLEcLYX0ZmD9YE3L4D71wbixGqMJUMAX6gdKt10Zl/OyNMu+l50hXfOnLz0e8AM1RcBH4o0NaOa6AWk7GG34pTK1fJxjx4Xvgxsp4ugGAveRWqCiw3kmbvlKBnhkMlpmuYApk18OBHtCzhQ25P3E7aXwz9buw8hNR82GIxQhJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0mOBeC+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so1403401fa.2;
        Wed, 21 Aug 2024 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724274990; x=1724879790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiUGC2plqsju+PIKUdlgp4dVJIOBq73ZHtfCj5+GMVM=;
        b=b0mOBeC+iUbWr6DURzUE/RJpvfRFPUdUZNVCTzbSf9sOLqEXQN6nPIitV83iWT0QDS
         5a0Zx+omFZV5ootU0N97sha1aYkok6kIPvXVy35KTk0Tzu4k6l+LkFK/6oPLX/8kjD5k
         ulko7FuVUPr7Xym3Tao4OEXBefj3GpB7eb6EVXhCX+APnWEYruQgEHwBOADP8uzadol6
         wX8qoKi9tQS0PscWGkLrp/PS8HKaTPHZVeB4rluWtJDnu8kmcyI/BZh/polqwcZTvsaB
         WO4ECAF6aqNCAVaGlQ96WlbglKgbeoB8Q9hht9JH/YXPWG/Ra3Cxshrl6xiktJP32F48
         qOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274990; x=1724879790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiUGC2plqsju+PIKUdlgp4dVJIOBq73ZHtfCj5+GMVM=;
        b=gjMimV+2Za9+6+uTCc7s9qZoqcWigCoYcDZa5xQ7hDcMgYohuePP5kkk/YKiD9wL06
         vdzkMLUcdCybWICsMcR10z7cORSUxuPmvs+m+9J1iEEdF2zb5JgIsTecJcCD5fibIj7C
         ldI8oIuaI3zVWNhhOrZjRC11t6STMlJWqwnjDA6AO7AqrnNnZvr2U6sRdj29tq70en6x
         zjsTbSh2bbfpCAz4TM3TKg7BVOc4azjXnSlD6kurmCCnXuUQWK3Vf856dObj7lfcl+f9
         BAjZNGqxD83XJAxoTFspf9i2LFs9e3xyEaNRdaupiw/XD//bGRDX+u+yPMjplKTXS9Hr
         R8ng==
X-Forwarded-Encrypted: i=1; AJvYcCVWrNw8CBDHnQ8XZiXQL/Bx7P5kqSi9vWig/f2wUbHRXQJuEEeicoos6+/9q4WSYuAZJu+QANLJETRKPbo=@vger.kernel.org, AJvYcCX5SXwdCc/pJzrR2SeirEgQh99ob2EwDafCeyWJF9PWPJcYW2ltvV+ZMmbI5iTnsKlhQ8cxzt01Ndky@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XdgaPV+ZQOynrX/OUaS6B2tEIaZni6rhAsSYrAUCc/o259hT
	AZpRJh8LrkWUGE0xGFQ76hnnVSKQxKXoFlzeEJLOhtWJy+Qmz9ohRRASLLLj63xBQsr0pj824pE
	s9rCn/QfXxJ5U3DxuJNMW6DEqWoIC6Q==
X-Google-Smtp-Source: AGHT+IEbvnYernfbaPui1I8nfs8or7e/vZuuYr7xXOntlaLltoQcnHV5tFfpUmsarL5GBVzxBFqU5Ef5XzVrlzWd/Aw=
X-Received: by 2002:a2e:f12:0:b0:2f3:cd4e:b929 with SMTP id
 38308e7fff4ca-2f3f8953813mr21761351fa.34.1724274989525; Wed, 21 Aug 2024
 14:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com> <20240821-dwc-mp-v2-1-2a29b6a5c2f4@nxp.com>
In-Reply-To: <20240821-dwc-mp-v2-1-2a29b6a5c2f4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Aug 2024 18:16:18 -0300
Message-ID: <CAOMZO5DNndao-kU9s9F_1XGMdTP-sgComD9UoaSOQpfkErBEXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: host: xhci-plat: Parse xhci-missing_cas_quirk
 and apply quirk
To: Frank Li <Frank.Li@nxp.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Wed, Aug 21, 2024 at 1:19=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Parse software managed property 'xhci-skip-phy-init-quirk' and
> 'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue lay=
er
> driver apply these quirk.

Please explain the reason in the commit log.

What does it fix? Why do we need these quirks? Or what does it improve?

