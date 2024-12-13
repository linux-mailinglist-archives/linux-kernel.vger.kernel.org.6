Return-Path: <linux-kernel+bounces-445511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A69F171C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E31889600
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5C1E2838;
	Fri, 13 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bwMXwBpC"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5651C4A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120041; cv=none; b=ADliwgjNOaZScKipnQr6Zf6Khsx/umhbvIgKV9rAMHbI/i+Q7POokw5NPsk0nj3UN9ezL2rVnRKW9iLn5tZbrteN0shMJm7DSkGAK1ZDjye4+huXaeuPhN28j5nf/Y5EdajTZuPcoP+tCZ8uv9eA7ig1gdopwVTf079u35FXFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120041; c=relaxed/simple;
	bh=+IBdDuUpH0ffV3eW21HSRtsMzybmo8R7I3/oqhIog4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFbx8NL5xjRPeUBsDuBqlKOZwJIGKYfSVgFUB9YVG14T82IZNvJCf3ikdVeCsCIFoBQN6IIF7ew7Z6d9s90LobfY1sJnCL5V8fId4bxmQ8jMVPLIFL7niTCiXOcvAssR4Yq+oDQP3UaAKk6xSisaLCprpzif6mJWauqMxRoeA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bwMXwBpC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso17864806d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1734120039; x=1734724839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjFjYpSxXBJz9M1hdmG3iiPhNXo18zA2UB8YwR16DTw=;
        b=bwMXwBpC8C//IjD7Tc14MGro3NHE7lVSjXm9Qrm4Ep8123XbRwOs0frYTLu7G3fC9Z
         im9o7kUtsH9nWbOY95R6dQTEC/X6T/WKul+Omoigunj5vHieDGwTt9rvIXOKtbi9b52D
         b6mDzKzTrJiXzrmbEf4hR0CJbsrl/1tmbi/JnkY2gBMw9Io+t+L+V5y4+hza/ReUrByq
         23Obgac52tvGXRMapjBEVRfBz0ny0iZAI1WRWT3wZ4driVl0vixE40ZlI2wtMW2hobDg
         hHZcsKoo7xuF0t4a90Oi+ww8ftOT5V9lvycx3PuXmMHZfVntNARVwFhhd1xcJV26qHrI
         MM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120039; x=1734724839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjFjYpSxXBJz9M1hdmG3iiPhNXo18zA2UB8YwR16DTw=;
        b=GmJy22H44UdykQoedPfVXxRLC1eVgpGN7vb9QtBBjkQFd9zv3tIdbM+UHg0zxNnnuc
         O4ZGWyJC9nLTlpAbB4CKB6cZZsal6Q+BcL73+unJF/htg/5AEFQ37K2yc+uWJUusnwHr
         JCQ/XkrhZThhcdNqUSqhvN8HzKKROeIwetFcEIRIHprJF+BbPAF96onkK4RXyLjif+dj
         te7WQqcH8Wvwurt55Yn3ZqcKuNwwXEpyMv/IaNOPe0ia3Vq8bpQIOic4dZud7j06HQX1
         gHH5RZdBaIsl2qDDVUlB+hUkg+UHjBESM7ERSbZGAsLd+ewlIUmxAVzQ4YbZJJSmJxQN
         dkRg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqYIPwXbHy1Z59/kozehMtH91kmaP9ginMArCHhjRbrQ49hWzd2QSHEStr7teeVPAD/uMgv8Shv4c7xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCa3VG1cD6x7UVm0RzYWiF2xcUUObfP1Ttf326JqPxmu3ZjsLE
	CeWyaSw1vKYXtX9cB3ICoo/ZKZPQdUE60KXnVRePUQ8mldI3qJRNZZQptSEghqqwxI2aKxya9DP
	849ISuoL2PuHPWqR7n/QGZOHhGIV3QGbzqhH6ABJQ2nWbvRUqlSM=
X-Gm-Gg: ASbGnctCVOFOU3S5h+0/PL/pugqLbGAUx7xhAANHwAvcYSrG5jqOBeTDozbCey+oTQn
	ZoPbM2ZwBSgxNNMiMVtMeuO/ABU4oIpoWAZGvWg==
X-Google-Smtp-Source: AGHT+IEywBNIbwjppPoVSQ/XELBsV0fF8sTiDrKGwA9AnZLBRibm/aOssHinTtzowKOKfn5HmY+4fB4H6J+nE2ZGRjI=
X-Received: by 2002:a17:90b:2242:b0:2ee:ba0c:1726 with SMTP id
 98e67ed59e1d1-2f2901b253dmr5268444a91.34.1734119680395; Fri, 13 Dec 2024
 11:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Fri, 13 Dec 2024 20:54:29 +0100
Message-ID: <CA+HBbNG0k24fO5OG42jw-7trWbT3iVTdo6Hh=55s1MaTh28p-A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/9] net: lan969x: add RGMII support
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>, 
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 2:41=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> =3D=3D Description:
>
> This series is the fourth of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
>
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
>
>         1) Prepare the Sparx5 driver for lan969x (merged)
>
>         2) Add support for lan969x (same basic features as Sparx5
>            provides excl. FDMA and VCAP, merged).
>
>         3) Add lan969x VCAP functionality (merged).
>
>     --> 4) Add RGMII support.
>
>         5) Add FDMA support.
>
> =3D=3D RGMII support:
>
> The lan969x switch device includes two RGMII port interfaces (port 28
> and 29) supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.
>
> =3D=3D Patch breakdown:
>
> Patch #1 does some preparation work.
>
> Patch #2 adds new function: is_port_rgmii() to the match data ops.
>
> Patch #3 uses the is_port_rgmii() in a number of places.
>
> Patch #4 makes sure that we do not configure an RGMII device as a
>          low-speed device, when doing a port config.
>
> Patch #5 makes sure we only return the PCS if the port mode requires
>          it.
>
> Patch #6 adds checks for RGMII PHY modes in sparx5_verify_speeds().
>
> Patch #7 adds registers required to configure RGMII.
>
> Patch #8 adds RGMII implementation.
>
> Patch #9 documents RGMII delays in the dt-bindings.
>
> Details are in the commit description of the individual patches
>
> To: UNGLinuxDriver@microchip.com
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> To: Steen Hegelund <Steen.Hegelund@microchip.com>
> To: Horatiu Vultur <horatiu.vultur@microchip.com>
> To: Russell King <linux@armlinux.org.uk>
> To: jacob.e.keller@intel.com
> To: robh@kernel.org
> To: krzk+dt@kernel.org
> To: conor+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: robert.marko@sartura.hr
>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Tested-by: Robert Marko <robert.marko@sartura.hr>

> ---
> Changes in v4:
>
> - Split patch #4 in v3 into two patches, where the new patch #5 handles
>   PCS selection, by returning the PCS only for ports that require it.
>
> - Got rid of the '|' symbol for {rx,tx}-internal-delay-ps property
>   description in the dt-bindings (patch #9).
>
> - Link to v3: https://lore.kernel.org/r/20241118-sparx5-lan969x-switch-dr=
iver-4-v3-0-3cefee5e7e3a@microchip.com
>
> Changes in v3:
>
> v2 was kindly tested by Robert Marko. Not carrying the tag to v3 since
> we have changes to the handling of the delays.
>
> - Modified lan969x_rgmii_delay_config() to not apply any MAC delay when
>   the {rx,tx}-internal-delay-ps properties are missing or set to 0
>   (patch #7).
>
> - Removed 'required' constraint from {rx-tx}-internal-delay-ps
>   properties. Also added description and default value (Patch #8).
>
> - Link to v2: https://lore.kernel.org/r/20241113-sparx5-lan969x-switch-dr=
iver-4-v2-0-0db98ac096d1@microchip.com
>
> Changes in v2:
>
>   Most changes are in patch #7. RGMII implementation has been moved to
>   it's own file lan969x_rgmii.c.
>
>   Details:
>
>     - Use ETH_P_8021Q and ETH_P_8021AD instead of the Sparx5 provided
>       equivalents (patch #7).
>     - Configure MAC delays through "{rx,tx}-internal-delay-ps"
>       properties (patch #7).
>     - Add selectors for all the phase shifts that the hardware supports
>       (instead of only 2.0 ns, patch #7).
>     - Add selectors for all the port speeds (instead of only 1000 mbps.)
>     - Document RGMII delays in dt-bindings.
>
>   - Link to v1: https://lore.kernel.org/r/20241106-sparx5-lan969x-switch-=
driver-4-v1-0-f7f7316436bd@microchip.com
>
> ---
> Daniel Machon (9):
>       net: sparx5: do some preparation work
>       net: sparx5: add function for RGMII port check
>       net: sparx5: use is_port_rgmii() throughout
>       net: sparx5: skip low-speed configuration when port is RGMII
>       net: sparx5: only return PCS for modes that require it
>       net: sparx5: verify RGMII speeds
>       net: lan969x: add RGMII registers
>       net: lan969x: add RGMII implementation
>       dt-bindings: net: sparx5: document RGMII delays
>
>  .../bindings/net/microchip,sparx5-switch.yaml      |  18 ++
>  drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
>  .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   5 +
>  .../ethernet/microchip/sparx5/lan969x/lan969x.h    |  10 +
>  .../microchip/sparx5/lan969x/lan969x_rgmii.c       | 224 +++++++++++++++=
++++++
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
>  .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
>  .../net/ethernet/microchip/sparx5/sparx5_phylink.c |  14 +-
>  .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 ++++--
>  .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
>  11 files changed, 484 insertions(+), 29 deletions(-)
> ---
> base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
> change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a
>
> Best regards,
> --
> Daniel Machon <daniel.machon@microchip.com>
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

